Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB79742FBD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 23:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjF2Vwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 17:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjF2Vwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 17:52:41 -0400
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB41D30C4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 14:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1688075556; bh=UA/oPXEOCkpLvdvEKZfva8LkSO3tk7fFipNWehdBuOA=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=jROdF5sKV/UphvUFU2txfGwyrTjsaRUbPT4TQa58ZW19BxibusSFDDztO1qgzlsyA
         YcyR1gW1BBlDJgqCWuGxBDr2NTTWyZzc2XsAmJG8/Le2odaW5y/ufJi8wq2+CGdl5Y
         f6AbJ5dIIJ7cUFUEqV8whZmHs2ch3/yWwjoVoT8E=
Received: by b221-2.in.mailobj.net [192.168.90.22] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Thu, 29 Jun 2023 23:52:36 +0200 (CEST)
X-EA-Auth: Rz1yyKWhBlZLKK+E7BgmFVdgRQu2DOQ6nBvjfd3qC+VEec0HVUJnMCWv71/GeS1XHqO4oOENrwt389pQ/71L0tyeKcGUbMkM
Date:   Fri, 30 Jun 2023 03:22:27 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH v3 6/6] gfs2: Replace kmap_atomic() by kmap_local_page() in
 gfs2_write_buf_to_page
Message-ID: <4bed561513ba76486ea3fc87f97e6c646f98cbe7.1688073459.git.drv@mailo.com>
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
gfs2_write_buf_to_page().

kmap_atomic() disables page-faults and preemption (the latter only for
!PREEMPT_RT kernels), However, the code within the mapping/un-mapping in
gfs2_write_buf_to_page() does not depend on the above-mentioned side
effects.

Therefore, a mere replacement of the old API with the new one is all that
is required (i.e., there is no need to explicitly add any calls to
pagefault_disable() and/or preempt_disable()).

Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Changes in v3:
   - Patch included in patch set

Changes in v2:
   - None


 fs/gfs2/quota.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 386ca770ce2e..e5767133aeea 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -764,10 +764,10 @@ static int gfs2_write_buf_to_page(struct gfs2_inode *ip, unsigned long index,
 	}
 
 	/* Write to the page, now that we have setup the buffer(s) */
-	kaddr = kmap_atomic(page);
+	kaddr = kmap_local_page(page);
 	memcpy(kaddr + off, buf, bytes);
 	flush_dcache_page(page);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 	unlock_page(page);
 	put_page(page);
 
-- 
2.34.1



