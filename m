Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63DE68DDB1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjBGQNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbjBGQN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:13:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C274E055;
        Tue,  7 Feb 2023 08:13:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FB8360EA6;
        Tue,  7 Feb 2023 16:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C26C433EF;
        Tue,  7 Feb 2023 16:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675786399;
        bh=FLLBP0tTZMTEFNWTFRCOfoqXmh7TMFj9z2SwwwQ+5qo=;
        h=From:To:Cc:Subject:Date:From;
        b=nhhBAWfFDWtPwtP5V87mG2i7Se7blpUDpt0dX0s1B2Nz8J9dHcar/LTEE4M2F5/yM
         E28Y0A+5GYWCzYXlSv7zJv5A44VpQS74C7z3Lb6oWWf/VVnmPzVPw9z7b1kD8Cf6Ih
         1mePSowwg3p65lzzLBB8pWQrSdIwquj5+0ELfVZ4g5rIp4DhdopEpfMedZTDwGQUcY
         kMHKKjMiatRL3vqMusbbsqcpxO55rY30nr07BbirYbZqnBSkPrmLyBhIjVQRzdsr5v
         bz6QlUCL+ZuccEB7nOAZVRzWmcbVl9vQATNgIXJ4w+M+f1KO6XKeb7Vtrm+TzjoUhq
         B0qttGVTChpdg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: i2c: imx290: fix conditional function defintions
Date:   Tue,  7 Feb 2023 17:13:12 +0100
Message-Id: <20230207161316.293923-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.1
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

From: Arnd Bergmann <arnd@arndb.de>

The runtime suspend/resume functions are only referenced from the
dev_pm_ops, but they use the old SET_RUNTIME_PM_OPS() helper
that requires a __maybe_unused annotation to avoid a warning:

drivers/media/i2c/imx290.c:1082:12: error: unused function 'imx290_runtime_resume' [-Werror,-Wunused-function]
static int imx290_runtime_resume(struct device *dev)
           ^
drivers/media/i2c/imx290.c:1090:12: error: unused function 'imx290_runtime_suspend' [-Werror,-Wunused-function]
static int imx290_runtime_suspend(struct device *dev)
           ^

Convert this to the new RUNTIME_PM_OPS() helper that so this
is not required. To improve this further, also use the pm_ptr()
helper that lets the dev_pm_ops get dropped entirely when
CONFIG_PM is disabled.

A related mistake happened in the of_match_ptr() macro here, which
like SET_RUNTIME_PM_OPS() requires the match table to be marked
as __maybe_unused, though I could not reproduce building this without
CONFIG_OF. Remove the of_match_ptr() here as there is no point in
dropping the match table in configurations without CONFIG_OF.

Fixes: 02852c01f654 ("media: i2c: imx290: Initialize runtime PM before subdev")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/i2c/imx290.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
index 49d6c8bdec41..48ae2e0adf9e 100644
--- a/drivers/media/i2c/imx290.c
+++ b/drivers/media/i2c/imx290.c
@@ -1098,7 +1098,7 @@ static int imx290_runtime_suspend(struct device *dev)
 }
 
 static const struct dev_pm_ops imx290_pm_ops = {
-	SET_RUNTIME_PM_OPS(imx290_runtime_suspend, imx290_runtime_resume, NULL)
+	RUNTIME_PM_OPS(imx290_runtime_suspend, imx290_runtime_resume, NULL)
 };
 
 /* ----------------------------------------------------------------------------
@@ -1362,8 +1362,8 @@ static struct i2c_driver imx290_i2c_driver = {
 	.remove = imx290_remove,
 	.driver = {
 		.name  = "imx290",
-		.pm = &imx290_pm_ops,
-		.of_match_table = of_match_ptr(imx290_of_match),
+		.pm = pm_ptr(&imx290_pm_ops),
+		.of_match_table = imx290_of_match,
 	},
 };
 
-- 
2.39.1

