Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833CD60EBF1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 01:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbiJZXAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 19:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbiJZXAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 19:00:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1A227CE0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 15:59:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAB89620E4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 22:59:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3802C433D7;
        Wed, 26 Oct 2022 22:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666825192;
        bh=nH2ArlwknM/y/vBnmfj0ga+qKqYuQNWCJAYIWsSWxEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sh/w0gDPKBDZTvj3PeoKX95hmST7DK0fwtYMFgGoV74D2d7W70BPXmc5pMvr5UQYX
         75wYdCxnWco7u/YfNf1FDOAhTvd/pPYEyDStO6ND3y32bPM7xos/FuOjTVPu4Mq9jw
         VlgS34XwFctaQ3C1VZOMt4M9/K/iqHjhh49PhbCDOJBlf5Ky0Qvo6Shgse1SNLhQkE
         NPvv5qeOaWtv96IkHUVp6wO8/mxvZWRKhx0FGNnx/4TjLZEoOVxAKJkjKuFqgEpTRr
         T1meIpTeo4BixfYNRNbL/nciUQg5bNB8rUc2rjDrp1IcPFxpHNcsBzPCflEloIyx8s
         hxg/wLJ1Vo2DA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH v2 05/12] mm/damon/sysfs: use damon_addr_range for regions' start and end values
Date:   Wed, 26 Oct 2022 22:59:36 +0000
Message-Id: <20221026225943.100429-6-sj@kernel.org>
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

DAMON has a struct for each address range but DAMON sysfs interface is
using the low type (unsigned long) for storing the start and end addresses
of regions.  Use the dedicated struct for better type safety.

Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/damon/sysfs.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 9f1219a67e3f..b9183063bfea 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1062,13 +1062,11 @@ static struct kobj_type damon_sysfs_schemes_ktype = {
 
 struct damon_sysfs_region {
 	struct kobject kobj;
-	unsigned long start;
-	unsigned long end;
+	struct damon_addr_range ar;
 };
 
 static struct damon_sysfs_region *damon_sysfs_region_alloc(
-		unsigned long start,
-		unsigned long end)
+		struct damon_addr_range ar)
 {
 	struct damon_sysfs_region *region = kmalloc(sizeof(*region),
 			GFP_KERNEL);
@@ -1076,8 +1074,7 @@ static struct damon_sysfs_region *damon_sysfs_region_alloc(
 	if (!region)
 		return NULL;
 	region->kobj = (struct kobject){};
-	region->start = start;
-	region->end = end;
+	region->ar = ar;
 	return region;
 }
 
@@ -1087,7 +1084,7 @@ static ssize_t start_show(struct kobject *kobj, struct kobj_attribute *attr,
 	struct damon_sysfs_region *region = container_of(kobj,
 			struct damon_sysfs_region, kobj);
 
-	return sysfs_emit(buf, "%lu\n", region->start);
+	return sysfs_emit(buf, "%lu\n", region->ar.start);
 }
 
 static ssize_t start_store(struct kobject *kobj, struct kobj_attribute *attr,
@@ -1095,7 +1092,7 @@ static ssize_t start_store(struct kobject *kobj, struct kobj_attribute *attr,
 {
 	struct damon_sysfs_region *region = container_of(kobj,
 			struct damon_sysfs_region, kobj);
-	int err = kstrtoul(buf, 0, &region->start);
+	int err = kstrtoul(buf, 0, &region->ar.start);
 
 	return err ? err : count;
 }
@@ -1106,7 +1103,7 @@ static ssize_t end_show(struct kobject *kobj, struct kobj_attribute *attr,
 	struct damon_sysfs_region *region = container_of(kobj,
 			struct damon_sysfs_region, kobj);
 
-	return sysfs_emit(buf, "%lu\n", region->end);
+	return sysfs_emit(buf, "%lu\n", region->ar.end);
 }
 
 static ssize_t end_store(struct kobject *kobj, struct kobj_attribute *attr,
@@ -1114,7 +1111,7 @@ static ssize_t end_store(struct kobject *kobj, struct kobj_attribute *attr,
 {
 	struct damon_sysfs_region *region = container_of(kobj,
 			struct damon_sysfs_region, kobj);
-	int err = kstrtoul(buf, 0, &region->end);
+	int err = kstrtoul(buf, 0, &region->ar.end);
 
 	return err ? err : count;
 }
@@ -1187,7 +1184,7 @@ static int damon_sysfs_regions_add_dirs(struct damon_sysfs_regions *regions,
 	regions->regions_arr = regions_arr;
 
 	for (i = 0; i < nr_regions; i++) {
-		region = damon_sysfs_region_alloc(0, 0);
+		region = damon_sysfs_region_alloc((struct damon_addr_range){});
 		if (!region) {
 			damon_sysfs_regions_rm_dirs(regions);
 			return -ENOMEM;
@@ -2147,11 +2144,11 @@ static int damon_sysfs_set_regions(struct damon_target *t,
 		struct damon_sysfs_region *sys_region =
 			sysfs_regions->regions_arr[i];
 
-		if (sys_region->start > sys_region->end)
+		if (sys_region->ar.start > sys_region->ar.end)
 			goto out;
 
-		ranges[i].start = sys_region->start;
-		ranges[i].end = sys_region->end;
+		ranges[i].start = sys_region->ar.start;
+		ranges[i].end = sys_region->ar.end;
 		if (i == 0)
 			continue;
 		if (ranges[i - 1].end > ranges[i].start)
-- 
2.25.1

