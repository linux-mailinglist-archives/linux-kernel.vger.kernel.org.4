Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F2F5BC5E6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiISJ5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiISJ51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:57:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232FAA47E;
        Mon, 19 Sep 2022 02:57:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAD8E60E07;
        Mon, 19 Sep 2022 09:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340E8C433C1;
        Mon, 19 Sep 2022 09:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663581442;
        bh=SC0xpJYfatRTu9GE/Tfh5/6VjsG9r+bd/p1faUdRTkI=;
        h=From:To:Cc:Subject:Date:From;
        b=Aq2Rbil72SBqmVgyJnsZowmBIeehH7/MFTIFFSPJJlPNLc87aum31tc0l33+1HdxJ
         VZx6koaAXFC45wDvXeSLXFBZaDYjGDpYx8jFbudlFz7JLWdoI3giurWfY9HOSdTbws
         X9WOtEGOU0+MuHr3RNY/iHVAtiRqfhf2pjJar6EfMCoWtOnuWrfrVvMRGRhI5vwZSo
         eNtmZk+PuoImccjmWbnDJgWAmVSZhs88lkb82+EaaxXUs9GpBds1qt06HrNJkW4nLV
         uVXTWhkiRY5aTsiTC8Wx22OTN0Yw8crP9v3w8PVa6NZ1es5BAGh2BnRQx//4iD/xUc
         GvnJw2TWrgHmA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oaDWn-0000aD-Ro; Mon, 19 Sep 2022 11:57:26 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] phy: qcom-qmp-combo: fix sc8280xp PCS_USB offset
Date:   Mon, 19 Sep 2022 11:57:00 +0200
Message-Id: <20220919095700.2228-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCS_USB register block lives at an offset of 0x300 from the PCS
region on SC8280XP so add the missing offset to avoid corrupting
unrelated registers on runtime suspend.

Note that this region should probably be described separately in the
binding.

Fixes: a2e927b0e50d ("phy: qcom-qmp-combo: Add sc8280xp USB/DP combo phys")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 1 +
 1 file changed, 1 insertion(+)

The corresponding DT fix is here:

	https://lore.kernel.org/all/20220919094454.1574-4-johan+linaro@kernel.org/

Johan


diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index d200cd5ca4fa..ed196d00815b 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -1261,6 +1261,7 @@ static const struct qmp_phy_cfg sc8280xp_usb43dp_usb_cfg = {
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= qmp_v4_usb3phy_regs_layout,
+	.pcs_usb_offset		= 0x300,
 
 	.start_ctrl		= SERDES_START | PCS_START,
 	.pwrdn_ctrl		= SW_PWRDN,
-- 
2.35.1

