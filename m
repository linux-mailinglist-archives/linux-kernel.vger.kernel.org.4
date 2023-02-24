Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52F16A1E64
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjBXPU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjBXPUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:20:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BC855047
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 07:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677251958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GQh9PzREi1aKG+cvDq/BudsqXqu0IrqPEQVrEk5VEng=;
        b=DMUYxNW2CKnZL6CtqvRXXT/I56on4JlzFtgCy8jSJy0C5PRceB9EP0uoZTN7oU2DXCJ+4Q
        3TC5GpZqZmKSTGWKp0lyzLacCUUrnLaGI59G7kSv0SzDsFEygB60Q+ZlxX6Pk1Sl7pTQ5c
        +QR0VI2VPnV7Um2E2ytqpI6/PplwWBU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-ZGuU11x2PtyBMDfxKc7VNQ-1; Fri, 24 Feb 2023 10:13:09 -0500
X-MC-Unique: ZGuU11x2PtyBMDfxKc7VNQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C9F6800B23;
        Fri, 24 Feb 2023 15:13:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CBAC7492B12;
        Fri, 24 Feb 2023 15:13:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <2213409.1677249075@warthog.procyon.org.uk>
References: <2213409.1677249075@warthog.procyon.org.uk> <2134430.1677240738@warthog.procyon.org.uk> <2009825.1677229488@warthog.procyon.org.uk> <CAHk-=whAAOVBrzwb2uMjCmdRrtudGesYj0tuqdUgi8X_gbw1jw@mail.gmail.com> <20230220135225.91b0f28344c01d5306c31230@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steve French <stfrench@microsoft.com>
Cc:     dhowells@redhat.com, Vishal Moola <vishal.moola@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Paulo Alcantara <pc@cjr.nz>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Xin Hao <xhao@linux.alibaba.com>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] cifs: Improve use of filemap_get_folios_tag()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2244150.1677251586.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 24 Feb 2023 15:13:06 +0000
Message-ID: <2244151.1677251586@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[This additional to the "cifs: Fix cifs_writepages_region()" patch that I
posted]

The inefficiency derived from filemap_get_folios_tag() get a batch of
contiguous folios in Vishal's change to afs that got copied into cifs can
be reduced by skipping over those folios that have been passed by the star=
t
position rather than going through the process of locking, checking and
trying to write them.

A similar change would need to be made in afs, in addition to fixing the b=
ugs
there.

There's also a fix in cifs_write_back_from_locked_folio() where it doesn't
return the amount of data dispatched to the server as ->async_writev() jus=
t
returns 0 on success.

Signed-off-by: David Howells <dhowells@redhat.com>
---
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index ebfcaae8c437..bae1a9709e32 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2839,6 +2839,7 @@ static ssize_t cifs_write_back_from_locked_folio(str=
uct address_space *mapping,
 	free_xid(xid);
 	if (rc =3D=3D 0) {
 		wbc->nr_to_write =3D count;
+		rc =3D len;
 	} else if (is_retryable_error(rc)) {
 		cifs_pages_write_redirty(inode, start, len);
 	} else {
@@ -2873,6 +2874,13 @@ static int cifs_writepages_region(struct address_sp=
ace *mapping,
 		for (int i =3D 0; i < nr; i++) {
 			ssize_t ret;
 			struct folio *folio =3D fbatch.folios[i];
+			unsigned long long fstart;
+
+			fstart =3D folio_pos(folio); /* May go backwards with THPs */
+			if (fstart < start &&
+			    folio_size(folio) <=3D start - fstart)
+				continue;
+			start =3D fstart;
 =

 redo_folio:
 			start =3D folio_pos(folio); /* May regress with THPs */

