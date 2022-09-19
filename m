Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C125BC5AE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiISJpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiISJpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:45:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38650E089;
        Mon, 19 Sep 2022 02:45:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CD00617A1;
        Mon, 19 Sep 2022 09:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8BDC433D6;
        Mon, 19 Sep 2022 09:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663580707;
        bh=XITKlPeeoIj+gRcJGE4GNKtWufjLUHLpqTekyIgpw88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pc7YS22VNlbG9KV9WKAdB8uKMd/8oQlAw+bFERZY3nCJ65ud+uq0ofCvU5CWgwqsV
         mydSs9qBtCeuLsKPd+5/iL73UkvFS/biC4WoNdrXkBQYqTLu0EVG/NwLkDCuTypOUm
         7NhIVFyMqs5FORFmQUMZiKgWzhNexPpS4lysKnw3jXwXFp7VrRWvr8b6D2ZivTrKYG
         yVzdbGCi4HsuZEHur09120DiKri9TzOc7qHi0j0GzBSAip70ifzxLAGnHMCRgqrE5/
         YTNAtltznSloIG16oqDsiGy2l/eknXU/Dpx5CYna5KpGhcuC6kv2ULpqqCquxLy80z
         MI02qX9cbCNvQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oaDKy-0000Pu-7C; Mon, 19 Sep 2022 11:45:12 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 4/4] arm64: dts: qcom: sc8280xp: drop broken DP PHY nodes
Date:   Mon, 19 Sep 2022 11:44:54 +0200
Message-Id: <20220919094454.1574-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220919094454.1574-1-johan+linaro@kernel.org>
References: <20220919094454.1574-1-johan+linaro@kernel.org>
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

The DP PHY register layout of the current binding do not apply to the
newer USB4/USB3/DP PHY which uses a different register layout entirely.

Drop the DP PHY subnodes until the binding has been updated to prevent
the driver from corrupting unrelated registers.

Note that this is also needed in order to not break USB with an upcoming
PHY driver change that checks for overlapping register regions.

Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index c734cac84719..014d72e49c74 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1191,16 +1191,6 @@ usb_0_ssphy: usb3-phy@88eb400 {
 				clock-names = "pipe0";
 				clock-output-names = "usb0_phy_pipe_clk_src";
 			};
-
-			usb_0_dpphy: dp-phy@88ed200 {
-				reg = <0 0x088ed200 0 0x200>,
-				      <0 0x088ed400 0 0x200>,
-				      <0 0x088eda00 0 0x200>,
-				      <0 0x088ea600 0 0x200>,
-				      <0 0x088ea800 0 0x200>;
-				#clock-cells = <1>;
-				#phy-cells = <0>;
-			};
 		};
 
 		usb_1_hsphy: phy@8902000 {
@@ -1253,16 +1243,6 @@ usb_1_ssphy: usb3-phy@8903400 {
 				clock-names = "pipe0";
 				clock-output-names = "usb1_phy_pipe_clk_src";
 			};
-
-			usb_1_dpphy: dp-phy@8904200 {
-				reg = <0 0x08904200 0 0x200>,
-				      <0 0x08904400 0 0x200>,
-				      <0 0x08904a00 0 0x200>,
-				      <0 0x08904600 0 0x200>,
-				      <0 0x08904800 0 0x200>;
-				#clock-cells = <1>;
-				#phy-cells = <0>;
-			};
 		};
 
 		system-cache-controller@9200000 {
-- 
2.35.1

