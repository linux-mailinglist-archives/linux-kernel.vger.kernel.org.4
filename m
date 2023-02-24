Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10C36A1D7B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjBXOcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjBXOcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:32:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE97B64E2E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 06:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677249082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SOsL6NM2MJym+f7C6hxVzCVTtD6Lm6OnQWKMhqCZjP8=;
        b=ccpDWd7yzc9GIVUCggQrv/9t1lL/B2EmolBYSyptm3l5vSMYU+nX4DQuu4+G6/SrsBpv37
        5hA59d9SmVA/xRgjvLgIt0jb/p/eea+xR5be5LtXvDYcVXq1RcqsJGOWvl6PxLNs7HK29H
        wOPZ9tpMWNpsp6oh33OBDlQ/d1+Izco=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145-LZUo_cplOIC5eZZlXA46IQ-1; Fri, 24 Feb 2023 09:31:19 -0500
X-MC-Unique: LZUo_cplOIC5eZZlXA46IQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00110887400;
        Fri, 24 Feb 2023 14:31:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 44AA6440D8;
        Fri, 24 Feb 2023 14:31:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <2134430.1677240738@warthog.procyon.org.uk>
References: <2134430.1677240738@warthog.procyon.org.uk> <2009825.1677229488@warthog.procyon.org.uk> <CAHk-=whAAOVBrzwb2uMjCmdRrtudGesYj0tuqdUgi8X_gbw1jw@mail.gmail.com> <20230220135225.91b0f28344c01d5306c31230@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steve French <stfrench@microsoft.com>
Cc:     dhowells@redhat.com, Vishal Moola <vishal.moola@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Paulo Alcantara <pc@cjr.nz>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Xin Hao <xhao@linux.alibaba.com>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] cifs: Fix cifs_writepages_region()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2213351.1677249027.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
From:   David Howells <dhowells@redhat.com>
Date:   Fri, 24 Feb 2023 14:31:15 +0000
Message-ID: <2213409.1677249075@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the simplest fix for cifs_writepages_region() that gets it to work.

Fix the cifs_writepages_region() to just skip over members of the batch th=
at
have been cleaned up rather than retrying them.  I'm not entirely sure why=
 it
fixes it, though.  It's also not the most efficient as, in the common case=
,
this is going to happen a lot because cifs_extend_writeback() is going to
clean up the contiguous pages in the batch - and then this skip will occur=
 for
those.

Fix: 3822a7c40997 ("Merge tag 'mm-stable-2023-02-20-13-37' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/akpm/mm")
Signed-off-by: David Howells <dhowells@redhat.com>
---
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 5365a3299088..ebfcaae8c437 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2893,8 +2893,9 @@ static int cifs_writepages_region(struct address_spa=
ce *mapping,
 =

 			if (folio_mapping(folio) !=3D mapping ||
 			    !folio_test_dirty(folio)) {
+				start +=3D folio_size(folio);
 				folio_unlock(folio);
-				goto skip_write;
+				continue;
 			}
 =

 			if (folio_test_writeback(folio) ||

