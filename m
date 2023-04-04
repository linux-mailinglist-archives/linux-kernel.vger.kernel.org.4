Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AD26D5996
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbjDDH0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbjDDHZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:25:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B1D2D61;
        Tue,  4 Apr 2023 00:25:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 132C862F82;
        Tue,  4 Apr 2023 07:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC4DC433A8;
        Tue,  4 Apr 2023 07:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680593146;
        bh=HINqrMhuBbCk5a4TBRf+k04vnEVW5aw69FWQnx8oXE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BA5wBplkdvTnvUblKDN26vtxTjyUXx3UY46V6kZYI4sZ4f35gBEdBuSGcuE5QDXXV
         5VUXLChmEMEkJZdXQbM4IyVEEMfGihUe8LrENefnHJX3fk0kDeKuqVYnPHN4p91fpJ
         N2FdALEwDNYWe2CMEKgEOebARbVQBftFRuWCF8WCL7RoGVUwCKGzrw7y9xpeDq/mXt
         jm052DjYXEB3k0Cy6g3YKMN+Q+RZAIjhASNc1KT9vbsvHjBZszeBwR9NQbrC3duKUe
         jPs6XZfJ/emNY58jxxqbRznhD+4VVQXgYtHgUal5Kv+4GX49kp8YzBLiJ/ZOkV3otV
         S7Fww25u7SdvA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pjb3V-0004xk-A2; Tue, 04 Apr 2023 09:26:13 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 08/11] USB: dwc3: clean up core init error handling
Date:   Tue,  4 Apr 2023 09:25:21 +0200
Message-Id: <20230404072524.19014-9-johan+linaro@kernel.org>
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

Clean up the core init error handling by using descriptive names for the
error labels and releasing resourcing in reverse order consistently.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/dwc3/core.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 15405f1f7aef..c499ef026500 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1008,7 +1008,7 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	ret = dwc3_phy_setup(dwc);
 	if (ret)
-		goto err0;
+		return ret;
 
 	if (!dwc->ulpi_ready) {
 		ret = dwc3_core_ulpi_init(dwc);
@@ -1017,7 +1017,7 @@ static int dwc3_core_init(struct dwc3 *dwc)
 				dwc3_core_soft_reset(dwc);
 				ret = -EPROBE_DEFER;
 			}
-			goto err0;
+			return ret;
 		}
 		dwc->ulpi_ready = true;
 	}
@@ -1025,7 +1025,7 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	if (!dwc->phys_ready) {
 		ret = dwc3_core_get_phy(dwc);
 		if (ret)
-			goto err0a;
+			goto err_exit_ulpi;
 		dwc->phys_ready = true;
 	}
 
@@ -1042,7 +1042,7 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	ret = dwc3_core_soft_reset(dwc);
 	if (ret)
-		goto err1;
+		goto err_exit_usb3_phy;
 
 	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD &&
 	    !DWC3_VER_IS_WITHIN(DWC3, ANY, 194A)) {
@@ -1077,16 +1077,16 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	usb_phy_set_suspend(dwc->usb3_phy, 0);
 	ret = phy_power_on(dwc->usb2_generic_phy);
 	if (ret < 0)
-		goto err2;
+		goto err_suspend_usb3_phy;
 
 	ret = phy_power_on(dwc->usb3_generic_phy);
 	if (ret < 0)
-		goto err3;
+		goto err_power_off_usb2_phy;
 
 	ret = dwc3_event_buffers_setup(dwc);
 	if (ret) {
 		dev_err(dwc->dev, "failed to setup event buffers\n");
-		goto err4;
+		goto err_power_off_usb3_phy;
 	}
 
 	/*
@@ -1203,27 +1203,23 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	return 0;
 
-err4:
+err_power_off_usb3_phy:
 	phy_power_off(dwc->usb3_generic_phy);
-
-err3:
+err_power_off_usb2_phy:
 	phy_power_off(dwc->usb2_generic_phy);
-
-err2:
-	usb_phy_set_suspend(dwc->usb2_phy, 1);
+err_suspend_usb3_phy:
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
-
-err1:
+	usb_phy_set_suspend(dwc->usb2_phy, 1);
+err_exit_usb3_phy:
 	phy_exit(dwc->usb3_generic_phy);
 err_exit_usb2_phy:
 	phy_exit(dwc->usb2_generic_phy);
 err_shutdown_usb3_phy:
 	usb_phy_shutdown(dwc->usb3_phy);
 	usb_phy_shutdown(dwc->usb2_phy);
-err0a:
+err_exit_ulpi:
 	dwc3_ulpi_exit(dwc);
 
-err0:
 	return ret;
 }
 
-- 
2.39.2

