Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20B967CDF3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjAZOXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjAZOXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:23:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D58417171;
        Thu, 26 Jan 2023 06:23:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5134C61867;
        Thu, 26 Jan 2023 14:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD28C4361B;
        Thu, 26 Jan 2023 14:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674742979;
        bh=HCGjEGUFY0gKH3ZyA4nO2jGVovR75O5DPlTfU63GDlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZvhIj1VGCEOt9h4Lgx+D4p1ZnjGp22aEyT0sSvkrWuhJZyw3vMdxsbCGsbd+q9iBo
         8HaOVgkZBxIc2bxujRq9uGMIkY5VPgxFSaDqmzeipOtC2XVI58HDi6wbs9XY5CSSmw
         smCdxK/T8ixr+PorT6XynyKKoJ1Pvu/hvn3O8RrOK2XnqRxWFNL1QFHfFb+mFaq7Xt
         wnynkGVKPvyZEykAG6hs9/8gsJRnBGNOLfIvLtwwPihwLwUAtwgMaCVcb6HxqNpiGr
         TfBQwugcHSuh7i63umCFVvtKBSVUK4W2ddp5GTGjiIWtNGxAda8/dq3TFvc5+FX0r0
         uDTgC7hrfF6/A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pL39d-0006jF-W4; Thu, 26 Jan 2023 15:23:06 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 23/24] arm64: dts: qcom: sc8280xp-crd: enable rtc
Date:   Thu, 26 Jan 2023 15:20:56 +0100
Message-Id: <20230126142057.25715-24-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126142057.25715-1-johan+linaro@kernel.org>
References: <20230126142057.25715-1-johan+linaro@kernel.org>
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

The SC8280XP CRD firmware does not implement the UEFI time runtime
services so the RTC in the PM8280K PMIC needs to be accessed directly.

To complicate things further, the RTC control and time registers are
read-only on this platform so an offset must be stored in some other
machine-specific non-volatile memory which an RTC driver can take into
account when reading or updating the time.

The UEFI firmware (and Windows) use a UEFI variable for this:

	882f8c2b-9646-435f-8de5-f208ff80c1bd-RTCInfo

but the offset can only be accessed via the Qualcomm UEFI Secure
Application residing in the TEE as the firmware does not implement the
variable runtime services either.

Unfortunately setting variables using this interface does not work on
the CRD so updating the time would not be possible. Instead, reserve
four bytes in one of the PMIC SDAM blocks to hold the RTC offset.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index c780b82e498d..192e076345d2 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -500,6 +500,21 @@ &pmk8280_pon_pwrkey {
 	status = "okay";
 };
 
+&pmk8280_rtc {
+	nvmem-cells = <&rtc_offset>;
+	nvmem-cell-names = "offset";
+
+	status = "okay";
+};
+
+&pmk8280_sdam_6 {
+	status = "okay";
+
+	rtc_offset: rtc-offset@bc {
+		reg = <0xbc 0x4>;
+	};
+};
+
 &qup0 {
 	status = "okay";
 };
-- 
2.39.1

