Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0606A03A5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjBWIQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjBWIQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:16:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02814AFC7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 00:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677140147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X3ikqoEsv3r0MxS807H4Mv08SZa5kDqPLyNECnlbwYE=;
        b=F6/1Lhd6dnKyNrnQxFOGcLLDlwKAvR62mvnr+NOk5XuXUyOkibMc2KpAF4yjr2IzEoodxm
        oBHOu3VjmRzfGuDwdfgymV02mfRnJhc2Wr0O+uBp2pcm3fc+DKk6Rkc+rZQBpBk8YrnuJi
        sGrDRXgeePHg6Xlg0ZOrtm8TlqthPS8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-206-JGOh3xiMO9emvn2N0KPR9g-1; Thu, 23 Feb 2023 03:15:45 -0500
X-MC-Unique: JGOh3xiMO9emvn2N0KPR9g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1009F802C18;
        Thu, 23 Feb 2023 08:15:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C251F1121314;
        Thu, 23 Feb 2023 08:15:43 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>
Subject: [PATCH 1/2] cifs: Add some missing xas_retry() calls
Date:   Thu, 23 Feb 2023 08:15:38 +0000
Message-Id: <20230223081539.970487-2-dhowells@redhat.com>
In-Reply-To: <20230223081539.970487-1-dhowells@redhat.com>
References: <20230223081539.970487-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The xas_for_each loops added into fs/cifs/file.c need to go round again if
indicated by xas_retry().

Fixes: 5f0955c98375 ("cifs: Add some helper functions")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Tom Talpey <tom@talpey.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
---
 fs/cifs/file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 0e602173ac76..5c60f4044b65 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -52,6 +52,8 @@ static void cifs_undirty_folios(struct inode *inode, loff_t start, unsigned int
 
 	end = (start + len - 1) / PAGE_SIZE;
 	xas_for_each_marked(&xas, folio, end, PAGECACHE_TAG_DIRTY) {
+		if (xas_retry(&xas, folio))
+			continue;
 		xas_pause(&xas);
 		rcu_read_unlock();
 		folio_lock(folio);
@@ -81,6 +83,8 @@ void cifs_pages_written_back(struct inode *inode, loff_t start, unsigned int len
 
 	end = (start + len - 1) / PAGE_SIZE;
 	xas_for_each(&xas, folio, end) {
+		if (xas_retry(&xas, folio))
+			continue;
 		if (!folio_test_writeback(folio)) {
 			WARN_ONCE(1, "bad %x @%llx page %lx %lx\n",
 				  len, start, folio_index(folio), end);
@@ -112,6 +116,8 @@ void cifs_pages_write_failed(struct inode *inode, loff_t start, unsigned int len
 
 	end = (start + len - 1) / PAGE_SIZE;
 	xas_for_each(&xas, folio, end) {
+		if (xas_retry(&xas, folio))
+			continue;
 		if (!folio_test_writeback(folio)) {
 			WARN_ONCE(1, "bad %x @%llx page %lx %lx\n",
 				  len, start, folio_index(folio), end);

