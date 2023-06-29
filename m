Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECF2742F75
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 23:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjF2VYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 17:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjF2VXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 17:23:52 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D707030EC
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 14:23:50 -0700 (PDT)
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E66CB3F84D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 21:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688073828;
        bh=YSYJcPCyfrgfbs0zHyOclQwwCoyKaiH+S5JijMPDsyo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=fcnAuz2MaQjiocWTKRoSq+lF/Nmba+f1/hS35beJ142ZsioE8twv9afbIaZsqmAx9
         ef/CjWXIZ90SYyZh/0KBq2/+JODaDrblQbFtKE2mq6uyhPfYQZbrfzdHB9hCXW4rmm
         2HqfmctaRcAtPBhwDjzES3+el6lJyC4svNqsDj4yee8eTappxChCyfOrgRyFc3kJ4E
         NIqeCzFBWbeokkx0elcwD2hgRzBWTDdvrk5xbDWOoe1Hu9OY/iesgfaHpvDjXn821/
         KQmozN2wOhPQyVmr+a9Dfna5eBjLsPA348CJYJ+gE2gz0L/pPLIi5LBRqfV+MpNdbF
         HjnsMfjAhMVLQ==
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6b8810af3adso1220780a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 14:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688073825; x=1690665825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSYJcPCyfrgfbs0zHyOclQwwCoyKaiH+S5JijMPDsyo=;
        b=H5CVyksZpm2FOjTzfewIRhVsB/Wn2d09tjQ5Ktf4/8l8eGf87wUMZvYx/d+gLrpDIk
         90FE7PsXATSawtmmmcFWuNVIjLHC25G5hMevPmdczSISnbNo8CUVvcPp5Ig2SStSqe7j
         6/kBt7af+DeERLiGJpzS2A+nrYZKc2/Nd6yFS3dVkEAcCiSQ69ghq5/tMRTERBrCFCF6
         iZyGNL0LwVXTSNZ1DT1XjwLKaf9GrOwHyGaq9v0y85No09h7VzoIvltXBUjRQ8uyub3m
         6W4NgtF6xoY8lu3LvdDXaDEdqb7dteboGqjUm8gCUDyRkSXaFo4kmIxHGuRPDuuIk0kT
         X6Pg==
X-Gm-Message-State: AC+VfDyZu/h86wFnqFr2tdzcdvQ0IJyCZZPxE+igG0gggk6Gq6A2pGjk
        jWpByV7qHTq0naXE5mtps0P2QR58PgEnfdH2G9yrUiCbx6Ha8j/XfRpV72jREIIUVD44R7TrSuU
        vQtSU//YyTliotqpLfrtwtlUwbbUZSaaJSxIlJmPnSw==
X-Received: by 2002:a05:6830:1be9:b0:6b5:be09:5332 with SMTP id k9-20020a0568301be900b006b5be095332mr1084416otb.23.1688073825098;
        Thu, 29 Jun 2023 14:23:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ52tAeUctNAM3SElt+HV9JGomtruQtp/V8Pv84ClN4z/6mDsIK+0IrLE5czLp639HOCoDpqvg==
X-Received: by 2002:a05:6830:1be9:b0:6b5:be09:5332 with SMTP id k9-20020a0568301be900b006b5be095332mr1084406otb.23.1688073824802;
        Thu, 29 Jun 2023 14:23:44 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4e1:83a2:7720:9030:a195:e622])
        by smtp.gmail.com with ESMTPSA id q6-20020a9d6646000000b006b871010cb1sm2711764otm.46.2023.06.29.14.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 14:23:44 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     "Isaac J. Manjarres" <isaacmanjarres@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] loop: do not enforce max_loop hard limit by (new) default
Date:   Thu, 29 Jun 2023 18:22:56 -0300
Message-Id: <20230629212256.918239-3-mfo@canonical.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629212256.918239-1-mfo@canonical.com>
References: <20230629212256.918239-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:

The max_loop parameter is used for 2 different purposes:
1) initial number of loop devices to pre-create on init
2) maximum number of loop devices to add on access/open()

Historically, its default value (zero) caused 1) to create
non-zero number of devices (CONFIG_BLK_DEV_LOOP_MIN_COUNT),
and no hard limit on 2) to add devices with autoloading.

However, the default value changed in commit 85c50197716c
("loop: Fix the max_loop commandline argument treatment
when it is set to 0") to CONFIG_BLK_DEV_LOOP_MIN_COUNT,
for max_loop=0 not to pre-create devices.

That does improve 1), but unfortunately it breaks 2), as
the default behavior changed from no-limit to hard-limit.

Example:

For example, this userspace code broke for N >= CONFIG,
if the user relied on the default value 0 for max_loop:

    mknod("/dev/loopN");
    open("/dev/loopN");  // now fails with ENXIO

Though affected users may "fix" it with (loop.)max_loop=0,
this means to require a kernel parameter change on stable
kernel update (that commit Fixes: an old commit in stable).

Solution:

The original semantics for the default value in 2) can be
applied if the parameter is not set (ie, default behavior).

This still keeps the intended function in 1) and 2) if set,
and that commit's intended improvement in 1) if max_loop=0.

Before 85c50197716c:
  - default:     1) CONFIG devices   2) no limit
  - max_loop=0:  1) CONFIG devices   2) no limit
  - max_loop=X:  1) X devices        2) X limit

After 85c50197716c:
  - default:     1) CONFIG devices   2) CONFIG limit (*)
  - max_loop=0:  1) 0 devices (*)    2) no limit
  - max_loop=X:  1) X devices        2) X limit

This commit:
  - default:     1) CONFIG devices   2) no limit (*)
  - max_loop=0:  1) 0 devices        2) no limit
  - max_loop=X:  1) X devices        2) X limit

Future:

The issue/regression from that commit only affects code
under the CONFIG_BLOCK_LEGACY_AUTOLOAD deprecation guard,
thus the fix too is contained under it.

Once that deprecated functionality/code is removed, the
purpose 2) of max_loop (hard limit) is no longer in use,
so the module parameter description can be changed then.

Tests:

Linux 6.4-rc7
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
CONFIG_BLOCK_LEGACY_AUTOLOAD=y

- default (original)

	# ls -1 /dev/loop*
	/dev/loop-control
	/dev/loop0
	...
	/dev/loop7

	# ./test-loop
	open: /dev/loop8: No such device or address

- default (patched)

	# ls -1 /dev/loop*
	/dev/loop-control
	/dev/loop0
	...
	/dev/loop7

	# ./test-loop
	#

- max_loop=0 (original & patched):

	# ls -1 /dev/loop*
	/dev/loop-control

	# ./test-loop
	#

- max_loop=8 (original & patched):

	# ls -1 /dev/loop*
	/dev/loop-control
	/dev/loop0
	...
	/dev/loop7

	# ./test-loop
	open: /dev/loop8: No such device or address

- max_loop=0 (patched; CONFIG_BLOCK_LEGACY_AUTOLOAD is not set)

	# ls -1 /dev/loop*
	/dev/loop-control

	# ./test-loop
	open: /dev/loop8: No such device or address

Fixes: 85c50197716c ("loop: Fix the max_loop commandline argument treatment when it is set to 0")
Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---
 drivers/block/loop.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 21bcd6ffe241..86060be853bc 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1777,14 +1777,43 @@ static const struct block_device_operations lo_fops = {
 /*
  * If max_loop is specified, create that many devices upfront.
  * This also becomes a hard limit. If max_loop is not specified,
+ * the default isn't a hard limit (as before commit 85c50197716c
+ * changed the default value from 0 for max_loop=0 reasons), just
  * create CONFIG_BLK_DEV_LOOP_MIN_COUNT loop devices at module
  * init time. Loop devices can be requested on-demand with the
  * /dev/loop-control interface, or be instantiated by accessing
  * a 'dead' device node.
  */
 static int max_loop = CONFIG_BLK_DEV_LOOP_MIN_COUNT;
-module_param(max_loop, int, 0444);
+
+#ifdef CONFIG_BLOCK_LEGACY_AUTOLOAD
+static bool max_loop_specified;
+
+static int max_loop_param_set_int(const char *val,
+				  const struct kernel_param *kp)
+{
+	int ret;
+
+	ret = param_set_int(val, kp);
+	if (ret < 0)
+		return ret;
+
+	max_loop_specified = true;
+	return 0;
+}
+
+static const struct kernel_param_ops max_loop_param_ops = {
+	.set = max_loop_param_set_int,
+	.get = param_get_int,
+};
+
+module_param_cb(max_loop, &max_loop_param_ops, &max_loop, 0444);
 MODULE_PARM_DESC(max_loop, "Maximum number of loop devices");
+#else
+module_param(max_loop, int, 0444);
+MODULE_PARM_DESC(max_loop, "Initial number of loop devices");
+#endif
+
 module_param(max_part, int, 0444);
 MODULE_PARM_DESC(max_part, "Maximum number of partitions per loop device");
 
@@ -2100,7 +2129,7 @@ static void loop_probe(dev_t dev)
 {
 	int idx = MINOR(dev) >> part_shift;
 
-	if (max_loop && idx >= max_loop)
+	if (max_loop_specified && max_loop && idx >= max_loop)
 		return;
 	loop_add(idx);
 }
@@ -2288,6 +2317,9 @@ module_exit(loop_exit);
 static int __init max_loop_setup(char *str)
 {
 	max_loop = simple_strtol(str, NULL, 0);
+#ifdef CONFIG_BLOCK_LEGACY_AUTOLOAD
+	max_loop_specified = true;
+#endif
 	return 1;
 }
 
-- 
2.39.2

