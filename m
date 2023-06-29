Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB344742FB7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 23:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjF2Vve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 17:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjF2Vvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 17:51:32 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7180730D1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 14:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1688075487; bh=C7lSYHOPm/Z4sI0GQts4IYgG0YiR3DHTQkmvN2BfzJ4=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=QMyCcPAU/yNJ7M8ZoRbSzy+TrDT7NltcM2XbOYbAuqoUHgof5TyMaFqFkhP+XrsxV
         4OamwRXXx4SMlX+QsORhYPxfNVfIbf5ZKOF2GrnCVzzH5RFoG+qCaNqj4Il/RC1s3d
         3oGZ3w/Cqg8MdcOw68SSXakl6nPfeZUkYxtaExvU=
Received: by b221-1.in.mailobj.net [192.168.90.21] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Thu, 29 Jun 2023 23:51:27 +0200 (CEST)
X-EA-Auth: P5HCG1ciElwbYgm7onYtMKqytCsT9R2NvTWwxi5496GTptuJln+k/TlBbmf/Liqh+qR0xtiWqaFWGGY8kby6/5SK7yiAPc69
Date:   Fri, 30 Jun 2023 03:21:17 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH v3 4/6] gfs2: Replace kmap_atomic() by kmap_local_page() in
 lops.c
Message-ID: <4817527acb9e015b3c6929517993ea50ba3427ad.1688073459.git.drv@mailo.com>
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

Therefore, replace kmap_atomic() with kmap_local_page() in following
functions of lops.c:
   - gfs2_jhead_pg_srch()
   - gfs2_check_magic()
   - gfs2_before_commit()

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
   - Patch included in patch series

Changes in v2:
   - None


 fs/gfs2/lops.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 1902413d5d12..a7c2296cb3c6 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -427,7 +427,7 @@ static bool gfs2_jhead_pg_srch(struct gfs2_jdesc *jd,
 {
 	struct gfs2_sbd *sdp = GFS2_SB(jd->jd_inode);
 	struct gfs2_log_header_host lh;
-	void *kaddr = kmap_atomic(page);
+	void *kaddr = kmap_local_page(page);
 	unsigned int offset;
 	bool ret = false;
 
@@ -441,7 +441,7 @@ static bool gfs2_jhead_pg_srch(struct gfs2_jdesc *jd,
 			}
 		}
 	}
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 	return ret;
 }
 
@@ -626,11 +626,11 @@ static void gfs2_check_magic(struct buffer_head *bh)
 	__be32 *ptr;
 
 	clear_buffer_escaped(bh);
-	kaddr = kmap_atomic(bh->b_page);
+	kaddr = kmap_local_page(bh->b_page);
 	ptr = kaddr + bh_offset(bh);
 	if (*ptr == cpu_to_be32(GFS2_MAGIC))
 		set_buffer_escaped(bh);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 }
 
 static int blocknr_cmp(void *priv, const struct list_head *a,
@@ -699,10 +699,10 @@ static void gfs2_before_commit(struct gfs2_sbd *sdp, unsigned int limit,
 				void *kaddr;
 				page = mempool_alloc(gfs2_page_pool, GFP_NOIO);
 				ptr = page_address(page);
-				kaddr = kmap_atomic(bd2->bd_bh->b_page);
+				kaddr = kmap_local_page(bd2->bd_bh->b_page);
 				memcpy(ptr, kaddr + bh_offset(bd2->bd_bh),
 				       bd2->bd_bh->b_size);
-				kunmap_atomic(kaddr);
+				kunmap_local(kaddr);
 				*(__be32 *)ptr = 0;
 				clear_buffer_escaped(bd2->bd_bh);
 				unlock_buffer(bd2->bd_bh);
-- 
2.34.1



