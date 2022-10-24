Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA7C609DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiJXJQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiJXJQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:16:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D406712AF9;
        Mon, 24 Oct 2022 02:15:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 977816112B;
        Mon, 24 Oct 2022 09:15:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D642AC43470;
        Mon, 24 Oct 2022 09:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666602940;
        bh=yBETrzXWGt7pb8QzxS3UVCAJWEhIrqkv9EtCngJvm68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LeTOjYcHs1TfRqT0RUEUvBS+n8Cji67bFNF+54A0HK7+FVNp+VXWWHUlz0HlRbpOE
         gv97jgHLe/2vlyic/tUZ9gSQz4M0Y0VjIxQCp/wegd9HM0tNSrxCbmrWNgVhjPrFZ4
         +5fROlBaCPy9Q7bE/X5dzV4FM1w9YWtkS52NRioRhQKdu8Rg68J1WkXYA6jT3RDuu1
         R+IzwcV5q6jCBYfrbCY60cvz3fQ9D6+kqgIU4MtSwFilkPkgsz8KgGhvPbOBJGDpju
         E2ptDe1rbntZlu8uS5/ZYMh6cjutKWkM7ZF66W60GSoMYg6ch3aC+ldJq1WzUwJ6lM
         lN+ZwTaXo4I8g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1omtYK-0005J0-DQ; Mon, 24 Oct 2022 11:15:24 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/4] arm64: dts: qcom: sm8250: fix UFS PHY registers
Date:   Mon, 24 Oct 2022 11:15:05 +0200
Message-Id: <20221024091507.20342-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024091507.20342-1-johan+linaro@kernel.org>
References: <20221024091507.20342-1-johan+linaro@kernel.org>
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

The sizes of the UFS PHY register regions are too small and does
specifically not cover all registers used by the Linux driver.

As Linux maps these regions as full pages this is currently not an issue
on Linux, but let's update the sizes to match the vendor driver.

Fixes: b7e2fba06622 ("arm64: dts: qcom: sm8250: Add UFS controller and PHY")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index a5b62cadb129..0fd768a4f308 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2179,11 +2179,11 @@ ufs_mem_phy: phy@1d87000 {
 			status = "disabled";
 
 			ufs_mem_phy_lanes: phy@1d87400 {
-				reg = <0 0x01d87400 0 0x108>,
-				      <0 0x01d87600 0 0x1e0>,
-				      <0 0x01d87c00 0 0x1dc>,
-				      <0 0x01d87800 0 0x108>,
-				      <0 0x01d87a00 0 0x1e0>;
+				reg = <0 0x01d87400 0 0x16c>,
+				      <0 0x01d87600 0 0x200>,
+				      <0 0x01d87c00 0 0x200>,
+				      <0 0x01d87800 0 0x16c>,
+				      <0 0x01d87a00 0 0x200>;
 				#phy-cells = <0>;
 			};
 		};
-- 
2.37.3

