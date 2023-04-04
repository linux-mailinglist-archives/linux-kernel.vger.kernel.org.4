Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB776D5993
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbjDDH0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbjDDHZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:25:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640482D79;
        Tue,  4 Apr 2023 00:25:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FEA462F86;
        Tue,  4 Apr 2023 07:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11739C433AC;
        Tue,  4 Apr 2023 07:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680593146;
        bh=wye9SQxSeebraYd3ht27KtushVWGDMc8EdiWMbnNa1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tMcjkIsz5SaJi++v1fTzoMJTkPEi/sku57cnjuoAWXjhvQI9jjgiuTN8oo6e07bJ+
         beT5beBA/Oq7jNOu3EudLHnMpZoJT2nv8V4ymI5ZHQ9Wfb9vbwNRGRWlmpOVcCIy2g
         jZ9ubAq7r0Ej9gsYfIeYOHWfcTsCHGowksHkrbRKqT+LG3IOytg8UzUzZgguqJEGGQ
         9ju1dvEm4RkroGz3XaT/l9L+q8cMJjAscOYtoRKPgfqTD7BFbM650U+/AQVv9COyH7
         Ah/z39XEOMAZSVy1tN3DHsW3CZwtAKJzxf5QRvZkMqvOXOi57pg7Jbu7DQDqVkGGDK
         yZVaWZXYWeohQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pjb3V-0004xr-GS; Tue, 04 Apr 2023 09:26:13 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 10/11] USB: dwc3: refactor clock lookups
Date:   Tue,  4 Apr 2023 09:25:23 +0200
Message-Id: <20230404072524.19014-11-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404072524.19014-1-johan+linaro@kernel.org>
References: <20230404072524.19014-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The probe callback has become unwieldy so break out the clock lookups
into a new helper function to improve readability.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/dwc3/core.c | 116 +++++++++++++++++++++-------------------
 1 file changed, 61 insertions(+), 55 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 52cd5ddfebd5..08432e109a3f 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1692,6 +1692,64 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
 	return edev;
 }
 
+static int dwc3_get_clocks(struct dwc3 *dwc)
+{
+	struct device *dev = dwc->dev;
+
+	if (!dev->of_node)
+		return 0;
+
+	/*
+	 * Clocks are optional, but new DT platforms should support all clocks
+	 * as required by the DT-binding.
+	 * Some devices have different clock names in legacy device trees,
+	 * check for them to retain backwards compatibility.
+	 */
+	dwc->bus_clk = devm_clk_get_optional(dev, "bus_early");
+	if (IS_ERR(dwc->bus_clk)) {
+		return dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
+				"could not get bus clock\n");
+	}
+
+	if (dwc->bus_clk == NULL) {
+		dwc->bus_clk = devm_clk_get_optional(dev, "bus_clk");
+		if (IS_ERR(dwc->bus_clk)) {
+			return dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
+					"could not get bus clock\n");
+		}
+	}
+
+	dwc->ref_clk = devm_clk_get_optional(dev, "ref");
+	if (IS_ERR(dwc->ref_clk)) {
+		return dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
+				"could not get ref clock\n");
+	}
+
+	if (dwc->ref_clk == NULL) {
+		dwc->ref_clk = devm_clk_get_optional(dev, "ref_clk");
+		if (IS_ERR(dwc->ref_clk)) {
+			return dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
+					"could not get ref clock\n");
+		}
+	}
+
+	dwc->susp_clk = devm_clk_get_optional(dev, "suspend");
+	if (IS_ERR(dwc->susp_clk)) {
+		return dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
+				"could not get suspend clock\n");
+	}
+
+	if (dwc->susp_clk == NULL) {
+		dwc->susp_clk = devm_clk_get_optional(dev, "suspend_clk");
+		if (IS_ERR(dwc->susp_clk)) {
+			return dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
+					"could not get suspend clock\n");
+		}
+	}
+
+	return 0;
+}
+
 static int dwc3_probe(struct platform_device *pdev)
 {
 	struct device		*dev = &pdev->dev;
@@ -1742,61 +1800,9 @@ static int dwc3_probe(struct platform_device *pdev)
 		goto err_put_psy;
 	}
 
-	if (dev->of_node) {
-		/*
-		 * Clocks are optional, but new DT platforms should support all
-		 * clocks as required by the DT-binding.
-		 * Some devices have different clock names in legacy device trees,
-		 * check for them to retain backwards compatibility.
-		 */
-		dwc->bus_clk = devm_clk_get_optional(dev, "bus_early");
-		if (IS_ERR(dwc->bus_clk)) {
-			ret = dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
-					    "could not get bus clock\n");
-			goto err_put_psy;
-		}
-
-		if (dwc->bus_clk == NULL) {
-			dwc->bus_clk = devm_clk_get_optional(dev, "bus_clk");
-			if (IS_ERR(dwc->bus_clk)) {
-				ret = dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
-						    "could not get bus clock\n");
-				goto err_put_psy;
-			}
-		}
-
-		dwc->ref_clk = devm_clk_get_optional(dev, "ref");
-		if (IS_ERR(dwc->ref_clk)) {
-			ret = dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
-					    "could not get ref clock\n");
-			goto err_put_psy;
-		}
-
-		if (dwc->ref_clk == NULL) {
-			dwc->ref_clk = devm_clk_get_optional(dev, "ref_clk");
-			if (IS_ERR(dwc->ref_clk)) {
-				ret = dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
-						    "could not get ref clock\n");
-				goto err_put_psy;
-			}
-		}
-
-		dwc->susp_clk = devm_clk_get_optional(dev, "suspend");
-		if (IS_ERR(dwc->susp_clk)) {
-			ret = dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
-					    "could not get suspend clock\n");
-			goto err_put_psy;
-		}
-
-		if (dwc->susp_clk == NULL) {
-			dwc->susp_clk = devm_clk_get_optional(dev, "suspend_clk");
-			if (IS_ERR(dwc->susp_clk)) {
-				ret = dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
-						    "could not get suspend clock\n");
-				goto err_put_psy;
-			}
-		}
-	}
+	ret = dwc3_get_clocks(dwc);
+	if (ret)
+		goto err_put_psy;
 
 	ret = reset_control_deassert(dwc->reset);
 	if (ret)
-- 
2.39.2

