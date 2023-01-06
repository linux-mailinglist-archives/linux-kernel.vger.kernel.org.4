Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9812F6605D0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 18:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbjAFRlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 12:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235742AbjAFRkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 12:40:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4907DE2F;
        Fri,  6 Jan 2023 09:40:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA83F616F5;
        Fri,  6 Jan 2023 17:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F76BC433F1;
        Fri,  6 Jan 2023 17:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673026844;
        bh=YZZNY9dRwSGWCR6rI1dKx/9bpURDl+Gj2lOCqnQv91U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z6cyH5ZRauWxvfPORXoj+wOKxhm88QKwFJtkWNBMkZG3gI46FE91EyPqpwZKjrILS
         RgdcJG33HPg9cJHPy5eKKnjHWSKUFivP4YcQ4jZh5OFHyNvVMBPDYXP+JeOBde+1m2
         Fhm7tKt4vQzjz1SEA8qQC32e+xF1RT1RngZPn80xzlR9cVkGZfdBKGoetCf2G6DF2i
         LXTwHWSLFbVDXuWTGf9J0WhubYpgHsqgVMo/4LH4Y+sGSrMCLFnwVW+dP2y6pS+joo
         EUjIaeme/J9pRRgLp3DDGE/0ygpmlNaOd6dGmBO34HShJ9efDfVSf2OiapQSu3LKmX
         jKdEAcoM+lVqA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     willy@infradead.org, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 3/3] fs/ceph/addr: use folio_headpage() instead of folio_page()
Date:   Fri,  6 Jan 2023 17:40:28 +0000
Message-Id: <20230106174028.151384-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230106174028.151384-1-sj@kernel.org>
References: <20230106174028.151384-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using 'folio_page(folio, 0)' for getting the head page of a folios is
not the standard idiom and inefficient.  Replace the call in fs/ceph/ to
'folio_headpage()'.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 fs/ceph/addr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 8c74871e37c9..b76e94152b21 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1290,7 +1290,7 @@ static int ceph_netfs_check_write_begin(struct file *file, loff_t pos, unsigned
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_snap_context *snapc;
 
-	snapc = ceph_find_incompatible(folio_page(*foliop, 0));
+	snapc = ceph_find_incompatible(folio_headpage(*foliop));
 	if (snapc) {
 		int r;
 
-- 
2.25.1

