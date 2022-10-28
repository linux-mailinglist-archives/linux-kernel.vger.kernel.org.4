Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563926116E3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiJ1QGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiJ1QFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:05:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72461F9E4;
        Fri, 28 Oct 2022 09:05:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64E9E6294D;
        Fri, 28 Oct 2022 16:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941D9C433B5;
        Fri, 28 Oct 2022 16:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666973109;
        bh=lQAeh2JyHulI6VOCF5gUBOHb/iKIMa8Q2OtzfLpz+8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VojMZjSVaherPPSSN0D74W2f9Y0RLH/5A9Y0OMFhBfTsVALva+2XDKZyv4cUbUVS3
         QxRQssAhzoaMjPimhDrvC7lZk3KRQkDDXvJnsTUDY/CRCGO+S3Ay+ClOE8uiV292L8
         d+a/GlLGyQOPRJ86VoyNrnHKUJ4X36IONe4/BNSaT35QoPWekaoEnqojXkodskPneb
         QjOHvretz/z8bj8cXOz7/BIeBNBL3K3r9XZ2VUB8oP3X/Ja01xznJrJdpp2M9pKe1y
         NjrQenryvjNnlpaG52sH4mqbiCL2S5/Teg5upYf2obf853ebqjUEc3HJsykukMH113
         tCEg/iZAL/VVw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ooRqp-00071U-Oy; Fri, 28 Oct 2022 18:04:55 +0200
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
Subject: [PATCH RESEND v2 01/13] phy: qcom-qmp-usb: fix sc8280xp PCS_USB offset
Date:   Fri, 28 Oct 2022 18:04:23 +0200
Message-Id: <20221028160435.26948-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028160435.26948-1-johan+linaro@kernel.org>
References: <20221028160435.26948-1-johan+linaro@kernel.org>
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
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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

