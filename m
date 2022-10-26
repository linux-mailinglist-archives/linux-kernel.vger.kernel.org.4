Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D42060EBF0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 01:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbiJZXA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 19:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbiJZXAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 19:00:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF7B27CD0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 15:59:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 274DAB80CA9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 22:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E743C433D6;
        Wed, 26 Oct 2022 22:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666825192;
        bh=8GL00RPKqf41iTTBqJzSvs8lE7BF3n/Dkon2+BFR2Rk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MePX4QP7b/+bsXbvuYDWVKEzt8T7ttgcmo+ROEtbeepA6gq+RAYM+Hsv0n5MZf6HR
         fOoJ7LQbDBQ7v3IRo7/ROwd6lLUpT6cU9hRCtPe42QeE9yahzPn39o6qYY4HZAXszM
         WMjWy38qDWJp5lPr52IEJMiGkOi2vR3U/8zKGDomoHsUxjGV1Xms72lV21B8XHV2FX
         sCZZY9ZwHNRf3X1FJ+/hjUjSHcvpyLLbkxY6mRBWxWaVNLgPZ83mX+cCZkJCdMKZeA
         2LIeGNczowR3Brpwwht3QTd/GBnbqwBhiftq+gGAm2xeLrCnxfnX73vg/VLhWky2Nb
         jHhgtItkwIP6g==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH v2 06/12] mm/damon/sysfs: remove parameters of damon_sysfs_region_alloc()
Date:   Wed, 26 Oct 2022 22:59:37 +0000
Message-Id: <20221026225943.100429-7-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026225943.100429-1-sj@kernel.org>
References: <20221026225943.100429-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'damon_sysfs_region_alloc()' is always called with zero-filled 'struct
damon_addr_range', because the start and end addresses should set by
users.  Remove unnecessary parameters of the function and simplify the
body by using 'kzalloc()'.

Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/damon/sysfs.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index b9183063bfea..e8bd7367d15b 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1065,17 +1065,9 @@ struct damon_sysfs_region {
 	struct damon_addr_range ar;
 };
 
-static struct damon_sysfs_region *damon_sysfs_region_alloc(
-		struct damon_addr_range ar)
+static struct damon_sysfs_region *damon_sysfs_region_alloc(void)
 {
-	struct damon_sysfs_region *region = kmalloc(sizeof(*region),
-			GFP_KERNEL);
-
-	if (!region)
-		return NULL;
-	region->kobj = (struct kobject){};
-	region->ar = ar;
-	return region;
+	return kzalloc(sizeof(struct damon_sysfs_region), GFP_KERNEL);
 }
 
 static ssize_t start_show(struct kobject *kobj, struct kobj_attribute *attr,
@@ -1184,7 +1176,7 @@ static int damon_sysfs_regions_add_dirs(struct damon_sysfs_regions *regions,
 	regions->regions_arr = regions_arr;
 
 	for (i = 0; i < nr_regions; i++) {
-		region = damon_sysfs_region_alloc((struct damon_addr_range){});
+		region = damon_sysfs_region_alloc();
 		if (!region) {
 			damon_sysfs_regions_rm_dirs(regions);
 			return -ENOMEM;
-- 
2.25.1

