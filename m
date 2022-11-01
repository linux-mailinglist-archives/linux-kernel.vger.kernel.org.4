Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268A361549E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiKAWDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiKAWDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:03:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE2F617A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:03:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0215A61744
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 22:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCDEC433D7;
        Tue,  1 Nov 2022 22:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667340214;
        bh=/1k1bBlsjxjo9k4yKNnny083mrtwv5FWU+9lM1PdzeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VRXQmr3mV2mTLz+4+nYdZKAv6AO3TB8XVGLyNXGM0nSSgG5AbZTa1in/nOl8zUDsK
         BM92vEa7Ze75qXBbB4lvkORJhA+DhNlHnCwC2KBcRkSKqJNwEkmf5SJYpS+6QTK9Pf
         ypIr8YDbRCzZ77CmCjkUo8YvVKObinMT6rMhnU3ouu9wyFV6+3ALHP7cJpJZ6lXzaC
         pNkzIbhS9x51U7S/LPtmIwYfozv51FCau3jFvePiUbjPwIfofxT4tj3ggUwqD8qUNM
         5w4BL/hXvdy5wFxZXHz/0Ile5zLQtAzu6woU5LPH2UNUyhdf2iEP35Ae/2Qm1EgU77
         HhfKu3/Ino90w==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 2/8] mm/damon/sysfs-schemes: implement schemes/tried_regions directory
Date:   Tue,  1 Nov 2022 22:03:22 +0000
Message-Id: <20221101220328.95765-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221101220328.95765-1-sj@kernel.org>
References: <20221101220328.95765-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For efficient and simple query-like DAMON monitoring results readings
and deep level investigations of DAMOS, DAMON kernel API
(include/linux/damon.h) users can use 'before_damos_apply' DAMON
callback.  However, DAMON sysfs interface users don't have such option.

Add a directory, namely 'tried_regions', under each scheme directory to
use it as the interface for the purpose.  Note that this commit is
implementing only the directory but the data filling.

After the data filling change is made, users will be able to signal
DAMON to fill the directory with the regions that corresponding scheme
has tried to be applied.  By setting the access pattern of the scheme,
users could do the efficient query-like monitoring.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 57 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 7ea4bcce90cb..f9714ac62565 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -9,6 +9,36 @@
 
 #include "sysfs-common.h"
 
+/*
+ * scheme regions directory
+ */
+
+struct damon_sysfs_scheme_regions {
+	struct kobject kobj;
+};
+
+static struct damon_sysfs_scheme_regions *
+damon_sysfs_scheme_regions_alloc(void)
+{
+	return kzalloc(sizeof(struct damon_sysfs_scheme_regions), GFP_KERNEL);
+}
+
+static void damon_sysfs_scheme_regions_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_scheme_regions, kobj));
+}
+
+static struct attribute *damon_sysfs_scheme_regions_attrs[] = {
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_scheme_regions);
+
+static struct kobj_type damon_sysfs_scheme_regions_ktype = {
+	.release = damon_sysfs_scheme_regions_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_scheme_regions_groups,
+};
+
 /*
  * schemes/stats directory
  */
@@ -635,6 +665,7 @@ struct damon_sysfs_scheme {
 	struct damon_sysfs_quotas *quotas;
 	struct damon_sysfs_watermarks *watermarks;
 	struct damon_sysfs_stats *stats;
+	struct damon_sysfs_scheme_regions *tried_regions;
 };
 
 /* This should match with enum damos_action */
@@ -743,6 +774,25 @@ static int damon_sysfs_scheme_set_stats(struct damon_sysfs_scheme *scheme)
 	return err;
 }
 
+static int damon_sysfs_scheme_set_tried_regions(
+		struct damon_sysfs_scheme *scheme)
+{
+	struct damon_sysfs_scheme_regions *tried_regions =
+		damon_sysfs_scheme_regions_alloc();
+	int err;
+
+	if (!tried_regions)
+		return -ENOMEM;
+	err = kobject_init_and_add(&tried_regions->kobj,
+			&damon_sysfs_scheme_regions_ktype, &scheme->kobj,
+			"tried_regions");
+	if (err)
+		kobject_put(&tried_regions->kobj);
+	else
+		scheme->tried_regions = tried_regions;
+	return err;
+}
+
 static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 {
 	int err;
@@ -759,8 +809,14 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 	err = damon_sysfs_scheme_set_stats(scheme);
 	if (err)
 		goto put_watermarks_quotas_access_pattern_out;
+	err = damon_sysfs_scheme_set_tried_regions(scheme);
+	if (err)
+		goto put_tried_regions_out;
 	return 0;
 
+put_tried_regions_out:
+	kobject_put(&scheme->tried_regions->kobj);
+	scheme->tried_regions = NULL;
 put_watermarks_quotas_access_pattern_out:
 	kobject_put(&scheme->watermarks->kobj);
 	scheme->watermarks = NULL;
@@ -781,6 +837,7 @@ static void damon_sysfs_scheme_rm_dirs(struct damon_sysfs_scheme *scheme)
 	kobject_put(&scheme->quotas->kobj);
 	kobject_put(&scheme->watermarks->kobj);
 	kobject_put(&scheme->stats->kobj);
+	kobject_put(&scheme->tried_regions->kobj);
 }
 
 static ssize_t action_show(struct kobject *kobj, struct kobj_attribute *attr,
-- 
2.25.1

