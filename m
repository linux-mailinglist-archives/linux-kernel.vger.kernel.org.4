Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A856CA420
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbjC0Man (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjC0Mal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:30:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372B33AA3;
        Mon, 27 Mar 2023 05:30:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D060CB811A6;
        Mon, 27 Mar 2023 12:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C0DC433EF;
        Mon, 27 Mar 2023 12:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679920237;
        bh=MaDS5qpKWXhmPQ7hgsrAMQiXtlRKEKaLWw+IBrcP3Sk=;
        h=From:To:Cc:Subject:Date:From;
        b=AjT/b107IkjApKd9s2bpnLvcCtPRv89f9RwfUE0g6+F6hFchVE6CriVSq9uh4fppm
         N2GlMPGz9IZ4E+6qTD9aAgXoG5SKnQg7z77ngHiRh+R04mOxFADjQsJmfvwkwh/nyK
         eLvZxjDAXIlPVYcKqMRIvEEwrfUvm7NxNVmY4BjF6gOaIWuhyqQYjBkbgmebQD8mo6
         dOFzoqTHp36dNxFx8GKI5d2JNPGE2/hH3n/tCF2u7zNd8rYso1SRghN80mnakGaKrQ
         MIzbadWw8u7a26ceHFoYZ1EqpWG8NxpI9cKl3ce/+tMc0Prao9E0tMWwzH4L0OVAcv
         5FKOlL+EThI6A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pglzq-00018j-3G; Mon, 27 Mar 2023 14:30:46 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] arm64: dts: qcom: sc8280xp-pmics: fix pon compatible and registers
Date:   Mon, 27 Mar 2023 14:29:48 +0200
Message-Id: <20230327122948.4323-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pmk8280 PMIC PON peripheral is gen3 and uses two sets of registers;
hlos and pbs.

This specifically fixes the following error message during boot when the
pbs registers are not defined:

	PON_PBS address missing, can't read HW debounce time

Note that this also enables the spurious interrupt workaround introduced
by commit 0b65118e6ba3 ("Input: pm8941-pwrkey - add software key press
debouncing support") (which may or may not be needed).

Fixes: ccd3517faf18 ("arm64: dts: qcom: sc8280xp: Add reference device")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
index c35e7f6bd657..a0ba535bb6c9 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
@@ -59,8 +59,9 @@ pmk8280: pmic@0 {
 		#size-cells = <0>;
 
 		pmk8280_pon: pon@1300 {
-			compatible = "qcom,pm8998-pon";
-			reg = <0x1300>;
+			compatible = "qcom,pmk8350-pon";
+			reg = <0x1300>, <0x800>;
+			reg-names = "hlos", "pbs";
 
 			pmk8280_pon_pwrkey: pwrkey {
 				compatible = "qcom,pmk8350-pwrkey";
-- 
2.39.2

