Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F102C5B4291
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 00:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiIIWom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 18:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiIIWoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 18:44:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0531F24F2A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 15:44:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFFDA620F0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 22:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6D7C433D6;
        Fri,  9 Sep 2022 22:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1662763475;
        bh=UR0/qf49iaA12b1h+bJxCdBOdwx4P6K5iqMbkzq4aAo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CgMdko5lp0xtwBaPIPLFkXtOwAwHW3tXXLlSzH+1jK8Uo+Z99m1SK/hXHTlp8Bm/0
         rzumAzbJOea2z/sGyB0FSo9S2631CccZ/jLswx/KKvIEshtVk+YuYyXRgum2n+olPK
         T3QxNI7Zb4mwpyuxi/Xd4sJNY68cHvHj67uHMdk4=
Date:   Fri, 9 Sep 2022 15:44:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Xin Hao <xhao@linux.alibaba.com>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/sysfs: change few functions execute order
Message-Id: <20220909154434.5870e33657a11d53320861e7@linux-foundation.org>
In-Reply-To: <20220908221653.131120-1-sj@kernel.org>
References: <20220908151042.239189ddb1635c0f598c6fd2@linux-foundation.org>
        <20220908221653.131120-1-sj@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  8 Sep 2022 22:16:53 +0000 SeongJae Park <sj@kernel.org> wrote:

> Reviewed-by: SeongJae Park <sj@kernel.org>

Cool.  I rewrote the changelog significantly:

From: Xin Hao <xhao@linux.alibaba.com>
Subject: mm/damon/sysfs: change few functions execute order
Date: Thu, 8 Sep 2022 16:19:32 +0800

There's no need to run container_of() as early as we do.

The compiler figures this out, but the resulting code is more readable.

Link: https://lkml.kernel.org/r/20220908081932.77370-1-xhao@linux.alibaba.com
Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/damon/sysfs.c |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

--- a/mm/damon/sysfs.c~mm-damon-sysfs-change-few-functions-execute-order
+++ a/mm/damon/sysfs.c
@@ -1031,8 +1031,7 @@ static ssize_t nr_schemes_show(struct ko
 static ssize_t nr_schemes_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
 {
-	struct damon_sysfs_schemes *schemes = container_of(kobj,
-			struct damon_sysfs_schemes, kobj);
+	struct damon_sysfs_schemes *schemes;
 	int nr, err = kstrtoint(buf, 0, &nr);
 
 	if (err)
@@ -1040,6 +1039,8 @@ static ssize_t nr_schemes_store(struct k
 	if (nr < 0)
 		return -EINVAL;
 
+	schemes = container_of(kobj, struct damon_sysfs_schemes, kobj);
+
 	if (!mutex_trylock(&damon_sysfs_lock))
 		return -EBUSY;
 	err = damon_sysfs_schemes_add_dirs(schemes, nr);
@@ -1237,8 +1238,7 @@ static ssize_t nr_regions_show(struct ko
 static ssize_t nr_regions_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
 {
-	struct damon_sysfs_regions *regions = container_of(kobj,
-			struct damon_sysfs_regions, kobj);
+	struct damon_sysfs_regions *regions;
 	int nr, err = kstrtoint(buf, 0, &nr);
 
 	if (err)
@@ -1246,6 +1246,8 @@ static ssize_t nr_regions_store(struct k
 	if (nr < 0)
 		return -EINVAL;
 
+	regions = container_of(kobj, struct damon_sysfs_regions, kobj);
+
 	if (!mutex_trylock(&damon_sysfs_lock))
 		return -EBUSY;
 	err = damon_sysfs_regions_add_dirs(regions, nr);
@@ -1440,8 +1442,7 @@ static ssize_t nr_targets_show(struct ko
 static ssize_t nr_targets_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
 {
-	struct damon_sysfs_targets *targets = container_of(kobj,
-			struct damon_sysfs_targets, kobj);
+	struct damon_sysfs_targets *targets;
 	int nr, err = kstrtoint(buf, 0, &nr);
 
 	if (err)
@@ -1449,6 +1450,8 @@ static ssize_t nr_targets_store(struct k
 	if (nr < 0)
 		return -EINVAL;
 
+	targets = container_of(kobj, struct damon_sysfs_targets, kobj);
+
 	if (!mutex_trylock(&damon_sysfs_lock))
 		return -EBUSY;
 	err = damon_sysfs_targets_add_dirs(targets, nr);
@@ -1962,8 +1965,7 @@ static ssize_t nr_contexts_show(struct k
 static ssize_t nr_contexts_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
 {
-	struct damon_sysfs_contexts *contexts = container_of(kobj,
-			struct damon_sysfs_contexts, kobj);
+	struct damon_sysfs_contexts *contexts;
 	int nr, err;
 
 	err = kstrtoint(buf, 0, &nr);
@@ -1973,6 +1975,7 @@ static ssize_t nr_contexts_store(struct
 	if (nr < 0 || 1 < nr)
 		return -EINVAL;
 
+	contexts = container_of(kobj, struct damon_sysfs_contexts, kobj);
 	if (!mutex_trylock(&damon_sysfs_lock))
 		return -EBUSY;
 	err = damon_sysfs_contexts_add_dirs(contexts, nr);
@@ -2737,8 +2740,7 @@ static ssize_t nr_kdamonds_show(struct k
 static ssize_t nr_kdamonds_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
 {
-	struct damon_sysfs_kdamonds *kdamonds = container_of(kobj,
-			struct damon_sysfs_kdamonds, kobj);
+	struct damon_sysfs_kdamonds *kdamonds;
 	int nr, err;
 
 	err = kstrtoint(buf, 0, &nr);
@@ -2747,6 +2749,8 @@ static ssize_t nr_kdamonds_store(struct
 	if (nr < 0)
 		return -EINVAL;
 
+	kdamonds = container_of(kobj, struct damon_sysfs_kdamonds, kobj);
+
 	if (!mutex_trylock(&damon_sysfs_lock))
 		return -EBUSY;
 	err = damon_sysfs_kdamonds_add_dirs(kdamonds, nr);
_

