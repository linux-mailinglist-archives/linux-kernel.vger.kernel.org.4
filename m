Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CDE742FB2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 23:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjF2Vty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 17:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjF2Vtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 17:49:46 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A068530C4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 14:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1688075378; bh=Js+wviSqbRoPvM+R8wP9vofgFSlATI7fQH4Z+TLAhBM=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=k0Fa9zvD/neTdeo9mrtsWdPMl5QyAU47R0HPgkV0n3DfUxzs+HW9bCbv4lnoCY40F
         er7hsbCoE5Bc+gThNcAGF4dxuvBZu8KLnBmCVsvuJ1JIMe3YJ4eSxIoRcyB4A8cL3m
         BJTdzrUAxFN56lr07AN7OrVIsIaAxV35ZwLdNjKs=
Received: by b221-2.in.mailobj.net [192.168.90.22] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Thu, 29 Jun 2023 23:49:38 +0200 (CEST)
X-EA-Auth: bfXx7m6mBHf0bbbEInyNo09c2pO3FAllciMTjbbMOaPyxDfwVkN/aN/2e4+nmIyLXNLywzBzQgffhdOIJnAiNivQauo1214l
Date:   Fri, 30 Jun 2023 03:19:29 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH v3 1/6] gfs2: Replace kmap_atomic() by kmap_local_page() in
 stuffed_readpage
Message-ID: <1955d9c440240f4c97efd80f3efca550871fe0ef.1688073459.git.drv@mailo.com>
References: <cover.1688073459.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1688073459.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmap_atomic() is deprecated in favor of kmap_local_{folio,page}().

Therefore, replace kmap_atomic() with kmap_local_page() in
stuffed_readpage().

kmap_atomic() disables page-faults and preemption (the latter only for
!PREEMPT_RT kernels), However, the code within the mapping/un-mapping in
stuffed_readpage() does not depend on the above-mentioned side effects.

Therefore, a mere replacement of the old API with the new one is all that
is required (i.e., there is no need to explicitly add any calls to
pagefault_disable() and/or preempt_disable()).

Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Changes in v3:
   - split into 2 patches
   - included in the patch set. Was sent as standalone patch previously

Changes in v2:
   - Update patch description to correct the replacement function name from
     kmap_local_page to kmap_local_folio


 fs/gfs2/aops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 3b41542d6697..3eac4f2f5c27 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -432,10 +432,10 @@ static int stuffed_readpage(struct gfs2_inode *ip, struct page *page)
 	if (error)
 		return error;
 
-	kaddr = kmap_atomic(page);
+	kaddr = kmap_local_page(page);
 	memcpy(kaddr, dibh->b_data + sizeof(struct gfs2_dinode), dsize);
 	memset(kaddr + dsize, 0, PAGE_SIZE - dsize);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 	flush_dcache_page(page);
 	brelse(dibh);
 	SetPageUptodate(page);
-- 
2.34.1



