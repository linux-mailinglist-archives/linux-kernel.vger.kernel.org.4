Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E736476F6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 21:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiLHUGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 15:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiLHUGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 15:06:11 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EE871272
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 12:06:09 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3bd1ff8fadfso25505697b3.18
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 12:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OGhmujOQ3LHvhNffWWxTOz03eJmhoP8dH26JUxPiv9A=;
        b=U6aDPl2myrZIIKIGUJ0avQLION3uqVvN8qwo9PUj5t2mD90pfGol56QdSn6YYroxDh
         t9FUxWiOr9zloTUfJNztvnYW7pRZ2CbnxhPrKdKzFuV5vKw2In92C3B+xCCythGGi3VX
         PFG+MJC8f4laeAiOzw4PLyjHupuxq5yRXj9CtRnHJMlMqxNWEFjI/+SntJP1Nlt15GuR
         4vFqrHv6DZiF6fLoexqgLAWgHnpxs0UueVtgqiQkG/Fa/7R7UBLmBl+DVh7Ps44P3ptV
         6akvXSA7VYTpGYyFTfNPmcXyEFPXUs73ERML+KZu+M91SpXPUP7Xk6aittYoztRa5Q0O
         B36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OGhmujOQ3LHvhNffWWxTOz03eJmhoP8dH26JUxPiv9A=;
        b=F3Ihgpup6OhJg71Wp+tfk1eVljDWfiJB41c+7t9O2g7UaNC4+efImMX5INQLtgWVxs
         4uTemXtfpsjhZ3+J/+h74JrrXLSMmYZiZkq48cqCJFsLBueL4t5jRUfaKrwmVknUOLD4
         vWR8eanG6Fe5gvHCbl42iYNWDyiSFlTBxvoPUJAd2hu1p0yaznJGRYG8mkU7O+o1RtY5
         2J7RQsvGQ2ra6zYpsgHWIC84rlwKii/ixZbF8bdmSgOEkZK/qb++1iYaY6i7M+XWH7bL
         MKxM9A4yGPAjwoLn2EazWVW7HyQ9PWqAQrULY77waB8DiKXADacFEdaUbpLBkMXMkKSY
         ATfg==
X-Gm-Message-State: ANoB5pnLxhPgr8VnfknTcGwP+L/wl0swqt5gfykfMbA/UiyQWKVzN4/R
        Odb4YxHOSiwsDbKki0APPjXhZiijgGgLlRbvzO82iw==
X-Google-Smtp-Source: AA0mqf5eG4ukM9Gke/9q7x+rfDkZT4u/r6tSFxm6BIumuvsskw9y53vKp2UZkaB752/pmAS1J4CLp+yGVarG50Ub0viBGw==
X-Received: from isaacmanjarres.irv.corp.google.com ([2620:15c:2d:3:c924:bf6:54d9:20e9])
 (user=isaacmanjarres job=sendgmr) by 2002:a05:690c:909:b0:368:70a8:9791 with
 SMTP id cb9-20020a05690c090900b0036870a89791mr15417509ywb.197.1670529968666;
 Thu, 08 Dec 2022 12:06:08 -0800 (PST)
Date:   Thu,  8 Dec 2022 12:06:04 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221208200605.756287-1-isaacmanjarres@google.com>
Subject: [PATCH v1] loop: Fix the max_loop commandline argument treatment when
 it is set to 0
From:   "Isaac J. Manjarres" <isaacmanjarres@google.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ken Chen <kenchen@google.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        "Isaac J. Manjarres" <isaacmanjarres@google.com>,
        stable@vger.knernel.org, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the max_loop commandline argument can be used to specify how
many loop block devices are created at init time. If it is not
specified on the commandline, CONFIG_BLK_DEV_LOOP_MIN_COUNT loop block
devices will be created.

The max_loop commandline argument can be used to override the value of
CONFIG_BLK_DEV_LOOP_MIN_COUNT. However, when max_loop is set to 0
through the commandline, the current logic treats it as if it had not
been set, and creates CONFIG_BLK_DEV_LOOP_MIN_COUNT devices anyway.

Fix this by starting max_loop off as set to CONFIG_BLK_DEV_LOOP_MIN_COUNT.
This preserves the intended behavior of creating
CONFIG_BLK_DEV_LOOP_MIN_COUNT loop block devices if the max_loop
commandline parameter is not specified, and allowing max_loop to
be respected for all values, including 0.

This allows environments that can create all of their required loop
block devices on demand to not have to unnecessarily preallocate loop
block devices.

Fixes: 732850827450 ("remove artificial software max_loop limit")
Cc: stable@vger.knernel.org
Cc: Ken Chen <kenchen@google.com>
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 drivers/block/loop.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ad92192c7d61..d12d3d171ec4 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1773,7 +1773,16 @@ static const struct block_device_operations lo_fops = {
 /*
  * And now the modules code and kernel interface.
  */
-static int max_loop;
+
+/*
+ * If max_loop is specified, create that many devices upfront.
+ * This also becomes a hard limit. If max_loop is not specified,
+ * create CONFIG_BLK_DEV_LOOP_MIN_COUNT loop devices at module
+ * init time. Loop devices can be requested on-demand with the
+ * /dev/loop-control interface, or be instantiated by accessing
+ * a 'dead' device node.
+ */
+static int max_loop = CONFIG_BLK_DEV_LOOP_MIN_COUNT;
 module_param(max_loop, int, 0444);
 MODULE_PARM_DESC(max_loop, "Maximum number of loop devices");
 module_param(max_part, int, 0444);
@@ -2181,7 +2190,7 @@ MODULE_ALIAS("devname:loop-control");
 
 static int __init loop_init(void)
 {
-	int i, nr;
+	int i;
 	int err;
 
 	part_shift = 0;
@@ -2209,19 +2218,6 @@ static int __init loop_init(void)
 		goto err_out;
 	}
 
-	/*
-	 * If max_loop is specified, create that many devices upfront.
-	 * This also becomes a hard limit. If max_loop is not specified,
-	 * create CONFIG_BLK_DEV_LOOP_MIN_COUNT loop devices at module
-	 * init time. Loop devices can be requested on-demand with the
-	 * /dev/loop-control interface, or be instantiated by accessing
-	 * a 'dead' device node.
-	 */
-	if (max_loop)
-		nr = max_loop;
-	else
-		nr = CONFIG_BLK_DEV_LOOP_MIN_COUNT;
-
 	err = misc_register(&loop_misc);
 	if (err < 0)
 		goto err_out;
@@ -2233,7 +2229,7 @@ static int __init loop_init(void)
 	}
 
 	/* pre-create number of devices given by config or max_loop */
-	for (i = 0; i < nr; i++)
+	for (i = 0; i < max_loop; i++)
 		loop_add(i);
 
 	printk(KERN_INFO "loop: module loaded\n");
-- 
2.39.0.rc1.256.g54fd8350bd-goog

