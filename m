Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC876E1794
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 00:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjDMWiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 18:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjDMWij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 18:38:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15A0423A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 15:38:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B0956421A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 22:38:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D5AC4339E;
        Thu, 13 Apr 2023 22:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681425516;
        bh=Riwglc43l4f0bQiMlyIBog53NVU6UB5IMNh6rCQlKeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=prQzSi6ipArSlSdvcYVNPRKaicI220MjMHQx5fTrtv22/VLWFypqD52LU3ieWCddT
         X9aaRS3qeAXd7nuI97DL9Rp5kD+Y4fF7/BUhJw6hQLIpnIZdfY7GXDQ0yCDz4A9vFF
         nUvG9coNsPE6nYXydRBXy8H8IK8hiuXQga+fqQEqQHyLKw5djHl75wm7wK6Avv7E57
         dwpDsJs09Lpr1nLW7BssgDITCmG2tbHE6HaiqN0aXzBw4i9wRW7G8CFD20kFnjYO4E
         GX6sZ7plP038awaeI4JY1QRtL/T9IOaP4ld2k3pDfM5sHQcDeGdkhNuHaHWZ3eM1So
         vHp/lwQHjXIZQ==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH 3/6] spmi: pmic-arb: Convert to platform remove callback returning void
Date:   Thu, 13 Apr 2023 15:38:31 -0700
Message-ID: <20230413223834.4084793-4-sboyd@kernel.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230413223834.4084793-1-sboyd@kernel.org>
References: <20230413223834.4084793-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20230306073446.2194048-4-u.kleine-koenig@pengutronix.de
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/spmi/spmi-pmic-arb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 8b6a42ab816f..42a593418aad 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -1674,7 +1674,7 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int spmi_pmic_arb_remove(struct platform_device *pdev)
+static void spmi_pmic_arb_remove(struct platform_device *pdev)
 {
 	struct spmi_controller *ctrl = platform_get_drvdata(pdev);
 	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
@@ -1682,7 +1682,6 @@ static int spmi_pmic_arb_remove(struct platform_device *pdev)
 	irq_set_chained_handler_and_data(pmic_arb->irq, NULL, NULL);
 	irq_domain_remove(pmic_arb->domain);
 	spmi_controller_put(ctrl);
-	return 0;
 }
 
 static const struct of_device_id spmi_pmic_arb_match_table[] = {
@@ -1693,7 +1692,7 @@ MODULE_DEVICE_TABLE(of, spmi_pmic_arb_match_table);
 
 static struct platform_driver spmi_pmic_arb_driver = {
 	.probe		= spmi_pmic_arb_probe,
-	.remove		= spmi_pmic_arb_remove,
+	.remove_new	= spmi_pmic_arb_remove,
 	.driver		= {
 		.name	= "spmi_pmic_arb",
 		.of_match_table = spmi_pmic_arb_match_table,
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

