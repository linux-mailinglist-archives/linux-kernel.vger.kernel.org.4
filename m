Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE800725CDA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239975AbjFGLRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239471AbjFGLRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:17:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42641702;
        Wed,  7 Jun 2023 04:17:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FB5263DBD;
        Wed,  7 Jun 2023 11:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90665C43442;
        Wed,  7 Jun 2023 11:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686136623;
        bh=PqT7b3LTt1IrPaGyiAZXtxPqgt4zXro8Gw7CXf+6hyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hcwjIfmEFTIUXuUtcgpBMJ4jzU5AmLI03k+n5e24wAmMp/W1YkBJLXXTTEK2axz/9
         T5RVxoff/v2jBz79Uir+LB8uZkFWRyks6Q+F30CwBDcQJgIdEyNWW3cIDPa2R4P5RS
         J6MUJGfI6Q5HqyfmcIrRIak5MNt6+Gi2BtNAXDLaMvzT52dS4jt9jvEjC1v37a5E9e
         zTdlZJPWBugDtMCH7X3aNaLw8VUD97ukmGLTWHyKuF/02Zq/Zhyl2QX0IQrQjqcdpb
         euJakyPqO/MwXQV5UurRMzyB6zDzRIo/gm81awExyAXteEMiR11fFc+lkCITXenblb
         05+boh6s8h1Bg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1q6rAM-0008LU-Gz; Wed, 07 Jun 2023 13:17:26 +0200
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
        Li Jun <jun.li@nxp.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Subject: [PATCH 2/2] USB: dwc3: fix use-after-free on core driver unbind
Date:   Wed,  7 Jun 2023 12:05:40 +0200
Message-Id: <20230607100540.31045-3-johan+linaro@kernel.org>
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

Some dwc3 glue drivers are currently accessing the driver data of the
child core device directly, which is clearly a bad idea as the child may
not have probed yet or may have been unbound from its driver.

As a workaround until the glue drivers have been fixed, clear the driver
data pointer before allowing the glue parent device to runtime suspend
to prevent its driver from accessing data that has been freed during
unbind.

Fixes: 6dd2565989b4 ("usb: dwc3: add imx8mp dwc3 glue layer driver")
Fixes: 6895ea55c385 ("usb: dwc3: qcom: Configure wakeup interrupts during suspend")
Cc: stable@vger.kernel.org      # 5.12
Cc: Li Jun <jun.li@nxp.com>
Cc: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Cc: Krishna Kurapati <quic_kriskura@quicinc.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/dwc3/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 7b2ce013cc5b..d68958e151a7 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1929,6 +1929,11 @@ static int dwc3_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
+	/*
+	 * HACK: Clear the driver data, which is currently accessed by parent
+	 * glue drivers, before allowing the parent to suspend.
+	 */
+	platform_set_drvdata(pdev, NULL);
 	pm_runtime_set_suspended(&pdev->dev);
 
 	dwc3_free_event_buffers(dwc);
-- 
2.39.3

