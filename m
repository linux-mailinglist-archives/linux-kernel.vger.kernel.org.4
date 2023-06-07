Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D572725CDD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240116AbjFGLRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239049AbjFGLRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:17:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C0D1BD;
        Wed,  7 Jun 2023 04:17:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36DF763DBA;
        Wed,  7 Jun 2023 11:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865BFC43444;
        Wed,  7 Jun 2023 11:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686136623;
        bh=SWgB+GJxunV8+GIcdNuLA2VAu98d93P4jlBSJxTcTc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dCocfCn5G6R1dJgV4Mmgd6QmoqMqRFKA44H9gGa/fGqbDWMqfznlnu83eU4rX3cpv
         2g3YmLmKhzdK4uBPsKEf5RRJy2gDbmp3VzLjfoipyHazynVJbqidDhMtYqzgdoEmdE
         hAQSBAK6dLwMOUWcB4LV6Fn39BYBcLwNJUr9X4uiMCKDyZ3UG25cqpgZDhiYHCgV1N
         qEiiv2znG3AMjklFQRR021NlKqKMNAhGwtv7xM71Bn2dkvgxHcTKYuNAmnD9NWk+8V
         BX9bCPRAjwtMTs4eSxvQ2DD8l0t1+mWji/1z4wHfAqtoNNTCp0uxrnbgg+6xhe4Wan
         ZW0mkD4+vxNXQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1q6rAM-0008LS-ET; Wed, 07 Jun 2023 13:17:26 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Subject: [PATCH 1/2] USB: dwc3: qcom: fix NULL-deref on suspend
Date:   Wed,  7 Jun 2023 12:05:39 +0200
Message-Id: <20230607100540.31045-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230607100540.31045-1-johan+linaro@kernel.org>
References: <20230607100540.31045-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm dwc3 glue driver is currently accessing the driver data of
the child core device during suspend and on wakeup interrupts. This is
clearly a bad idea as the child may not have probed yet or could have
been unbound from its driver.

The first such layering violation was part of the initial version of the
driver, but this was later made worse when the hack that accesses the
driver data of the grand child xhci device to configure the wakeup
interrupts was added.

Fixing this properly is not that easily done, so add a sanity check to
make sure that the child driver data is non-NULL before dereferencing it
for now.

Note that this relies on subtleties like the fact that driver core is
making sure that the parent is not suspended while the child is probing.

Reported-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/all/20230325165217.31069-4-manivannan.sadhasivam@linaro.org/
Fixes: d9152161b4bf ("usb: dwc3: Add Qualcomm DWC3 glue layer driver")
Fixes: 6895ea55c385 ("usb: dwc3: qcom: Configure wakeup interrupts during suspend")
Cc: stable@vger.kernel.org	# 3.18: a872ab303d5d: "usb: dwc3: qcom: fix use-after-free on runtime-PM wakeup"
Cc: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Cc: Krishna Kurapati <quic_kriskura@quicinc.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 959fc925ca7c..79b22abf9727 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -308,7 +308,16 @@ static void dwc3_qcom_interconnect_exit(struct dwc3_qcom *qcom)
 /* Only usable in contexts where the role can not change. */
 static bool dwc3_qcom_is_host(struct dwc3_qcom *qcom)
 {
-	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
+	struct dwc3 *dwc;
+
+	/*
+	 * FIXME: Fix this layering violation.
+	 */
+	dwc = platform_get_drvdata(qcom->dwc3);
+
+	/* Core driver may not have probed yet. */
+	if (!dwc)
+		return false;
 
 	return dwc->xhci;
 }
-- 
2.39.3

