Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452736D5991
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbjDDH03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbjDDHZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:25:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A2B2688;
        Tue,  4 Apr 2023 00:25:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 063A262F7A;
        Tue,  4 Apr 2023 07:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5BEEC4339E;
        Tue,  4 Apr 2023 07:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680593145;
        bh=Wd9dTXZlk8hsrFQwzg6wbq+SL8TQUl+h+nC61vTCstg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K4p/xjn0updgmS/4520oefQs02M9/kSbikQ+YEV5vGULZMV5XPQyr0nZHrKCaDxzh
         pqdy4PfRzgGgPdIq2Qu/xZ+a6f7Ljj5yRWQBodAbDuQpJ/snUjib38OcoAGZ6GJyjZ
         E/++S/czbFcVgnG/Q3RIyHGrfZChW3Yo8U0eShnjaX8x7OlriViZ+KytdTADCXincb
         riSp4eWM8LfHj1edqNVL0fKLS1l7Hz9BOkod6r/S0LOHpaMVSs3c3zkkyySCRf6h5m
         tq6v2rORTvPPzX4Hxe4o7sGIhLwKn9z5g5OpvYa8Fzv5wSQoFdUx74woHoL2khEqqY
         icoomYhdO1xdg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pjb3V-0004xe-3W; Tue, 04 Apr 2023 09:26:13 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 06/11] USB: dwc3: clean up probe error labels
Date:   Tue,  4 Apr 2023 09:25:19 +0200
Message-Id: <20230404072524.19014-7-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404072524.19014-1-johan+linaro@kernel.org>
References: <20230404072524.19014-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use descriptive names consistently for the probe error labels.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/dwc3/core.c | 45 ++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index d837ab511686..de84e057d28b 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1705,7 +1705,7 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
 	if (IS_ERR(dwc->reset)) {
 		ret = PTR_ERR(dwc->reset);
-		goto put_usb_psy;
+		goto err_put_psy;
 	}
 
 	if (dev->of_node) {
@@ -1719,7 +1719,7 @@ static int dwc3_probe(struct platform_device *pdev)
 		if (IS_ERR(dwc->bus_clk)) {
 			ret = dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
 					    "could not get bus clock\n");
-			goto put_usb_psy;
+			goto err_put_psy;
 		}
 
 		if (dwc->bus_clk == NULL) {
@@ -1727,7 +1727,7 @@ static int dwc3_probe(struct platform_device *pdev)
 			if (IS_ERR(dwc->bus_clk)) {
 				ret = dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
 						    "could not get bus clock\n");
-				goto put_usb_psy;
+				goto err_put_psy;
 			}
 		}
 
@@ -1735,7 +1735,7 @@ static int dwc3_probe(struct platform_device *pdev)
 		if (IS_ERR(dwc->ref_clk)) {
 			ret = dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
 					    "could not get ref clock\n");
-			goto put_usb_psy;
+			goto err_put_psy;
 		}
 
 		if (dwc->ref_clk == NULL) {
@@ -1743,7 +1743,7 @@ static int dwc3_probe(struct platform_device *pdev)
 			if (IS_ERR(dwc->ref_clk)) {
 				ret = dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
 						    "could not get ref clock\n");
-				goto put_usb_psy;
+				goto err_put_psy;
 			}
 		}
 
@@ -1751,7 +1751,7 @@ static int dwc3_probe(struct platform_device *pdev)
 		if (IS_ERR(dwc->susp_clk)) {
 			ret = dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
 					    "could not get suspend clock\n");
-			goto put_usb_psy;
+			goto err_put_psy;
 		}
 
 		if (dwc->susp_clk == NULL) {
@@ -1759,23 +1759,23 @@ static int dwc3_probe(struct platform_device *pdev)
 			if (IS_ERR(dwc->susp_clk)) {
 				ret = dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
 						    "could not get suspend clock\n");
-				goto put_usb_psy;
+				goto err_put_psy;
 			}
 		}
 	}
 
 	ret = reset_control_deassert(dwc->reset);
 	if (ret)
-		goto put_usb_psy;
+		goto err_put_psy;
 
 	ret = dwc3_clk_enable(dwc);
 	if (ret)
-		goto assert_reset;
+		goto err_assert_reset;
 
 	if (!dwc3_core_is_valid(dwc)) {
 		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
 		ret = -ENODEV;
-		goto disable_clks;
+		goto err_disable_clks;
 	}
 
 	platform_set_drvdata(pdev, dwc);
@@ -1785,7 +1785,7 @@ static int dwc3_probe(struct platform_device *pdev)
 	    DWC3_GHWPARAMS0_AWIDTH(dwc->hwparams.hwparams0) == 64) {
 		ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
 		if (ret)
-			goto disable_clks;
+			goto err_disable_clks;
 	}
 
 	spin_lock_init(&dwc->lock);
@@ -1803,23 +1803,23 @@ static int dwc3_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(dwc->dev, "failed to allocate event buffers\n");
 		ret = -ENOMEM;
-		goto err2;
+		goto err_allow_rpm;
 	}
 
 	dwc->edev = dwc3_get_extcon(dwc);
 	if (IS_ERR(dwc->edev)) {
 		ret = dev_err_probe(dwc->dev, PTR_ERR(dwc->edev), "failed to get extcon\n");
-		goto err3;
+		goto err_free_event_buffers;
 	}
 
 	ret = dwc3_get_dr_mode(dwc);
 	if (ret)
-		goto err3;
+		goto err_free_event_buffers;
 
 	ret = dwc3_core_init(dwc);
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to initialize core\n");
-		goto err3;
+		goto err_free_event_buffers;
 	}
 
 	dwc3_check_params(dwc);
@@ -1827,13 +1827,13 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	ret = dwc3_core_init_mode(dwc);
 	if (ret)
-		goto err5;
+		goto err_exit_debugfs;
 
 	pm_runtime_put(dev);
 
 	return 0;
 
-err5:
+err_exit_debugfs:
 	dwc3_debugfs_exit(dwc);
 	dwc3_event_buffers_cleanup(dwc);
 
@@ -1848,20 +1848,19 @@ static int dwc3_probe(struct platform_device *pdev)
 	phy_exit(dwc->usb3_generic_phy);
 
 	dwc3_ulpi_exit(dwc);
-err3:
+err_free_event_buffers:
 	dwc3_free_event_buffers(dwc);
-
-err2:
+err_allow_rpm:
 	pm_runtime_allow(dev);
 	pm_runtime_disable(dev);
 	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_set_suspended(dev);
 	pm_runtime_put_noidle(dev);
-disable_clks:
+err_disable_clks:
 	dwc3_clk_disable(dwc);
-assert_reset:
+err_assert_reset:
 	reset_control_assert(dwc->reset);
-put_usb_psy:
+err_put_psy:
 	if (dwc->usb_psy)
 		power_supply_put(dwc->usb_psy);
 
-- 
2.39.2

