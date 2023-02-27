Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8026A4233
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjB0NFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjB0NFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:05:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC27DC14A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677503102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rbgMV4+Gw07qIFcKv0NDtwcmvgDQ6J2Uk8Vw7BugGlw=;
        b=DzLODSpEMgkzecyNbe186stqwlJqt5uAD+FeTESucVM/U1yW4RSEuMj6DJRgik0HEByrEq
        cHv7dFjgtLEKLg4jdP+sUwscUOyB69I+qhFVo0pcbGTtJb+5hh7qcMF313USHSwHljaQIE
        9o5triTcBnqwT49N2ZSNCL9BWn9YVek=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-xNV1IN3UPr2PH4RBXTQMdA-1; Mon, 27 Feb 2023 08:05:01 -0500
X-MC-Unique: xNV1IN3UPr2PH4RBXTQMdA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA7331991C41;
        Mon, 27 Feb 2023 13:05:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B05582166B2C;
        Mon, 27 Feb 2023 13:04:59 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>
Subject: [PATCH 1/2] cifs: Fix cifs_write_back_from_locked_folio()
Date:   Mon, 27 Feb 2023 13:04:53 +0000
Message-Id: <20230227130454.2673622-2-dhowells@redhat.com>
In-Reply-To: <20230227130454.2673622-1-dhowells@redhat.com>
References: <20230227130454.2673622-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cifs_write_back_from_locked_folio() should return the number of bytes read,
but returns the result of ->async_writev(), which will be 0 on success.  As
it happens, this doesn't prevent cifs_writepages_region() from working as
it will then examine and ignore the pages that are no longer dirty rather
than just skipping over them.

Fixes: d08089f649a0 ("cifs: Change the I/O paths to use an iterator rather than a page list")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Tom Talpey <tom@talpey.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
---
 fs/cifs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index ebfcaae8c437..f8cc68ce9d8a 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2839,6 +2839,7 @@ static ssize_t cifs_write_back_from_locked_folio(struct address_space *mapping,
 	free_xid(xid);
 	if (rc == 0) {
 		wbc->nr_to_write = count;
+		rc = len;
 	} else if (is_retryable_error(rc)) {
 		cifs_pages_write_redirty(inode, start, len);
 	} else {

