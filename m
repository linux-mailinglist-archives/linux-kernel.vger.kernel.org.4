Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E14B60922E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 11:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiJWJyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 05:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiJWJyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 05:54:03 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BA7760D4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 02:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666518556; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fH7g4YysWMLgOSNDG15jV52CUiW7mUEZ75bQsRILO7Y=;
        b=Eo1izMgZo0Frd07iuiRf9vf0fPXjQWEKqIe+2Bb8/l1BPw7uYGD6XuUOmArqH5H2tabJWa
        uw/WwGE6sqa2b04ScoqkO0g6adnTgivFJn62wERiV03dp5Q6uXsq4yEprv0pRue1F6jXZX
        HKP/0H4faJWhV237ysdVPljtKQ0IC54=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 22/28] mfd: motorola-cpcap: Remove #ifdef guards for PM related functions
Date:   Sun, 23 Oct 2022 10:48:46 +0100
Message-Id: <20221023094852.8035-23-paul@crapouillou.net>
In-Reply-To: <20221023094852.8035-1-paul@crapouillou.net>
References: <20221023094852.8035-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros
to handle the .suspend/.resume callbacks.

These macros allow the suspend and resume functions to be automatically
dropped by the compiler when CONFIG_SUSPEND is disabled, without having
to use #ifdef guards.

This has the advantage of always compiling these functions in,
independently of any Kconfig option. Thanks to that, bugs and other
regressions are subsequently easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mfd/motorola-cpcap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
index 265464b5d7cc..ae8930eff72d 100644
--- a/drivers/mfd/motorola-cpcap.c
+++ b/drivers/mfd/motorola-cpcap.c
@@ -221,7 +221,6 @@ static const struct regmap_config cpcap_regmap_config = {
 	.val_format_endian = REGMAP_ENDIAN_LITTLE,
 };
 
-#ifdef CONFIG_PM_SLEEP
 static int cpcap_suspend(struct device *dev)
 {
 	struct spi_device *spi = to_spi_device(dev);
@@ -239,9 +238,8 @@ static int cpcap_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(cpcap_pm, cpcap_suspend, cpcap_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(cpcap_pm, cpcap_suspend, cpcap_resume);
 
 static const struct mfd_cell cpcap_mfd_devices[] = {
 	{
@@ -346,7 +344,7 @@ static struct spi_driver cpcap_driver = {
 	.driver = {
 		.name = "cpcap-core",
 		.of_match_table = cpcap_of_match,
-		.pm = &cpcap_pm,
+		.pm = pm_sleep_ptr(&cpcap_pm),
 	},
 	.probe = cpcap_probe,
 	.id_table = cpcap_spi_ids,
-- 
2.35.1

