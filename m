Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510AF609E93
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiJXKHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJXKHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:07:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F466432;
        Mon, 24 Oct 2022 03:07:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE053611AD;
        Mon, 24 Oct 2022 10:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B16C433B5;
        Mon, 24 Oct 2022 10:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666606023;
        bh=Blc66Ko1azHrb/nEVIdVCCRSopdMuUlafRjUOxGWY+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LbR7LDlSZk4rHgr+yNoQRlUV7hPaFX1hrAXCVoGz8fzsx2pt17hAar/UlV9UJ80Zi
         zRZeun+PffO3YmJaFNzuSq1nyAl6opCGKW7MvyFXqLR4PEHzrYNK7RSQhoteYWzQqL
         Gtha2VWTuKmWiYfUwdFjcCPk1dmXt99tBM7Vy9lAkqvHg9fWIVSKIrzQ+oTNsWTZta
         GABXjIvld32EoaoE7vx2j7pL6/5mWlqR6EKFzO+/CUfnIcG7lu+3v2q7oQYiVb73v0
         QFkGCM78jfK+e/DNoj307aTKkt1aOLU5rwr97GAxvnE39ADY+JI1C1q1IHLl3vhgk5
         YUPqpVvFQAXNw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1omuM2-0005M6-Ob; Mon, 24 Oct 2022 12:06:46 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 01/13] phy: qcom-qmp-usb: fix sc8280xp PCS_USB offset
Date:   Mon, 24 Oct 2022 12:06:20 +0200
Message-Id: <20221024100632.20549-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024100632.20549-1-johan+linaro@kernel.org>
References: <20221024100632.20549-1-johan+linaro@kernel.org>
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

The PCS_USB register block lives at an offset of 0x1000 from the PCS
region on SC8280XP so add the missing offset to avoid corrupting
unrelated registers on runtime suspend.

Note that the current binding is broken as it does not describe the
PCS_USB region and the PCS register size does not cover PCS_USB and the
regions in between. As Linux currently maps full pages, simply adding
the offset to driver works until the binding has been fixed.

Fixes: c0c7769cdae2 ("phy: qcom-qmp: Add SC8280XP USB3 UNI phy")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index d0c433197080..82af28f4a91b 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -1682,6 +1682,7 @@ static const struct qmp_phy_cfg sc8280xp_usb3_uniphy_cfg = {
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= qmp_v4_usb3phy_regs_layout,
+	.pcs_usb_offset		= 0x1000,
 };
 
 static const struct qmp_phy_cfg qmp_v3_usb3_uniphy_cfg = {
-- 
2.37.3

