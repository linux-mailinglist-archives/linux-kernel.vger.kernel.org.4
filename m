Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB77A6D5988
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbjDDH0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbjDDHZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:25:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C26D1BC7;
        Tue,  4 Apr 2023 00:25:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A61F62F74;
        Tue,  4 Apr 2023 07:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACF2C433EF;
        Tue,  4 Apr 2023 07:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680593145;
        bh=2q4LsyPxLReBjh6KT0A3DR3vy9HH+t9cFXIsPEwf+A4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CnP/EPT0d9UWN/Cd+QbvP3VDR8IbAjxMxCfAhiXuzfzdaEROsKM6E8C6SXvl1hifi
         vIdeV/B7UNyQdANdCqc6cszZZmquW0aeVPRvVuSd4GgMYckqoLPhjkTuoAnXpoOpA1
         eSpjyfo4FTQN54WS1dM0Y3k2vusHO/86Qimkaevey7XlTezxncah56embdSqq678zE
         fuegtjAGYp+J3M5KlN69LvRGkQ+X4+XGX2SIiIn+5kKjbpjJ9z7D9285krlmN4XJZj
         4q5HGCF0J64wk7En+me/f/FpJacgapczyRA7k1ALH7ZoaQtFjsHKucD19hYimZNP9o
         pTh8gM7tWA4bg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pjb3V-0004xi-6n; Tue, 04 Apr 2023 09:26:13 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 07/11] USB: dwc3: clean up phy init error handling
Date:   Tue,  4 Apr 2023 09:25:20 +0200
Message-Id: <20230404072524.19014-8-johan+linaro@kernel.org>
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

While there likely are no platforms out there that mix generic and
legacy PHYs the driver should still be able to handle that, if only for
consistency reasons.

Add the missing calls to shutdown any legacy PHYs if generic PHY
initialisation fails.

Note that we continue to happily ignore potential errors from the legacy
PHY callbacks...

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/dwc3/core.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index de84e057d28b..15405f1f7aef 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1031,15 +1031,14 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	usb_phy_init(dwc->usb2_phy);
 	usb_phy_init(dwc->usb3_phy);
+
 	ret = phy_init(dwc->usb2_generic_phy);
 	if (ret < 0)
-		goto err0a;
+		goto err_shutdown_usb3_phy;
 
 	ret = phy_init(dwc->usb3_generic_phy);
-	if (ret < 0) {
-		phy_exit(dwc->usb2_generic_phy);
-		goto err0a;
-	}
+	if (ret < 0)
+		goto err_exit_usb2_phy;
 
 	ret = dwc3_core_soft_reset(dwc);
 	if (ret)
@@ -1215,11 +1214,12 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
 
 err1:
-	usb_phy_shutdown(dwc->usb2_phy);
-	usb_phy_shutdown(dwc->usb3_phy);
-	phy_exit(dwc->usb2_generic_phy);
 	phy_exit(dwc->usb3_generic_phy);
-
+err_exit_usb2_phy:
+	phy_exit(dwc->usb2_generic_phy);
+err_shutdown_usb3_phy:
+	usb_phy_shutdown(dwc->usb3_phy);
+	usb_phy_shutdown(dwc->usb2_phy);
 err0a:
 	dwc3_ulpi_exit(dwc);
 
-- 
2.39.2

