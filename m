Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0B8611354
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiJ1No5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiJ1Nov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:44:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA4315A1C;
        Fri, 28 Oct 2022 06:44:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7375C62886;
        Fri, 28 Oct 2022 13:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA28FC43141;
        Fri, 28 Oct 2022 13:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666964680;
        bh=GVBev1jEona/JnPzuSX2/hO6w0D68gFMKEICg/YDpjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rj7KNmW+tHOJun329eIQheARmQ/3e+fyWVY7Wwj7SNZWYMWkum6id/26ymfyvxFNo
         S6ZKoqDSfgsZZH3L6wZfrrcklcC35pwkGJtormgKqjFaLkicmlTGZPwTq/t96QTuB+
         BRKV7v9GUuDz5sjS73XEkmebeOfQvGB1yCsSJZryKOJYZUZAcukuAWOWZ+fgufJuMx
         8sU8AgrmNVZECV/mCGzhK9JR+knISMBqK5/zwtmTQfraiek44QaCUiJBCtmXGmKgyS
         fciqfAM5jNtNDWLMZfWYcf6szp3eP8FkZ0e4XCpIOcHaMuRPIGPykOMRIYA7TkAyiG
         oSY8NXN0x9WvA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ooPet-000528-4m; Fri, 28 Oct 2022 15:44:27 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 04/13] phy: qcom-qmp-usb: move pm ops
Date:   Fri, 28 Oct 2022 15:43:58 +0200
Message-Id: <20221028134407.19300-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028134407.19300-1-johan+linaro@kernel.org>
References: <20221028134407.19300-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the PM ops structure next to the implementation to keep the driver
callbacks grouped.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index 4591128743c7..f28883e0d21e 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -2280,6 +2280,11 @@ static int __maybe_unused qmp_usb_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static const struct dev_pm_ops qmp_usb_pm_ops = {
+	SET_RUNTIME_PM_OPS(qmp_usb_runtime_suspend,
+			   qmp_usb_runtime_resume, NULL)
+};
+
 static int qmp_usb_vreg_init(struct device *dev, const struct qmp_phy_cfg *cfg)
 {
 	struct qcom_qmp *qmp = dev_get_drvdata(dev);
@@ -2501,11 +2506,6 @@ int qmp_usb_create(struct device *dev, struct device_node *np, int id,
 	return 0;
 }
 
-static const struct dev_pm_ops qmp_usb_pm_ops = {
-	SET_RUNTIME_PM_OPS(qmp_usb_runtime_suspend,
-			   qmp_usb_runtime_resume, NULL)
-};
-
 static int qmp_usb_probe(struct platform_device *pdev)
 {
 	struct qcom_qmp *qmp;
-- 
2.37.3

