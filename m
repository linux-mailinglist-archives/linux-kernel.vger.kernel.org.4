Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0E1609DC2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJXJQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbiJXJQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:16:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4923569BC2;
        Mon, 24 Oct 2022 02:15:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43A35B81012;
        Mon, 24 Oct 2022 09:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0E2C433D6;
        Mon, 24 Oct 2022 09:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666602940;
        bh=F2XhYBJZZ37OeuVyzuENkOhMW0tF0uumy5Gl7HJ9FuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U/2cjFd3YdLFKC5d3m2XSW15zYiclRfeDu3OI5KMLbdRnuSwfo2fic75U6IbXbUJ/
         Nct0sDie9P3Hp2sDg+kpIqNaIN89A7G7bXL2G2ZZjKn0sYYYxuMPOXL14Mca4eIAgg
         JaTloAuKwus4B4PwST92Q7HdVrF8xDort+T5zyNV2biG0P3e3EJ8lHGYIVj8RsIj5a
         QEuhSxz6Up4Xcjqsy4a2bj5c8LM8Nne5M1ZHaAiRlQTRWwX6yIoetArZcZZhpGQbY5
         WtuqC/VMOWBUraRkFFkT5EQPwu5KPXDm6YdDmUYrA/RYJMAFBs2yCaHe0SOfYfdeW6
         gkLerNUPVW3yg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1omtYK-0005Iy-AC; Mon, 24 Oct 2022 11:15:24 +0200
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
Subject: [PATCH 1/4] arm64: dts: qcom: sm8150: fix UFS PHY registers
Date:   Mon, 24 Oct 2022 11:15:04 +0200
Message-Id: <20221024091507.20342-2-johan+linaro@kernel.org>
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

Fixes: 3834a2e92229 ("arm64: dts: qcom: sm8150: Add ufs nodes")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index cef8c4f4f0ff..4a527a64772b 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -2032,11 +2032,11 @@ ufs_mem_phy: phy@1d87000 {
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

