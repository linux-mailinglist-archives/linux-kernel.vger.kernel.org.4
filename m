Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8464667CDEC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjAZOXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjAZOXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:23:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAFD241ED;
        Thu, 26 Jan 2023 06:23:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2055C61843;
        Thu, 26 Jan 2023 14:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F47C433A1;
        Thu, 26 Jan 2023 14:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674742981;
        bh=5UwR9QbyWi/Z/2mgCV5ah8EZM6pifSRECiAKO2qRn28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uoAiN7RLIltAF2itdi3Ajs7/6S33o92wkpcy+qExHZNJo+NeZy1wAm5c8lDdbmCj/
         Y7/do4gY6riMzI6mBqMH8aJB+0YJkh41cyZeWwHMSOPcx8UKe+94GDN8lYf8ivezIT
         r2LjK+N8Vwj3ko5OVXCN3gXzffaET5/HLEFbqJ6osHexUbhLeDIx9xSYQX5x2AwGb9
         GOrRVhWZQIQDcuWCr2FbND7cUkG7AWElZKRBsY+ipbZqu94DFtwIpMLi7d3RQrlqhS
         J05jHWiqLRMKeyPv8PmleXqtaweyzMgdm3b7hMTlHIAig502LNjiSBg4d5JZYGR8U8
         tbGdCvx76bkow==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pL39e-0006jI-2J; Thu, 26 Jan 2023 15:23:06 +0100
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
Subject: [PATCH 24/24] arm64: dts: qcom: sc8280xp-x13s: enable rtc
Date:   Thu, 26 Jan 2023 15:20:57 +0100
Message-Id: <20230126142057.25715-25-johan+linaro@kernel.org>
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

The Lenovo X13s firmware does not implement the UEFI time runtime
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

While it is possible to access this UEFI variable from Linux on the
X13s, this requires using a fairly complex and reverse-engineered
firmware interface. As the only benefit of doing so is to make sure that
the UEFI (Windows) and Linux time never gets out of sync, it seems
preferable to use the PMIC scratch registers for storing an offset
instead. This also avoids flash wear in case of RTC drift, etc.

So instead of using the UEFI RTC offset, reserve four bytes in one of
the PMIC SDAM blocks to hold the RTC offset.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index db406f7774de..6e88e0bb6871 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -683,6 +683,21 @@ &pmk8280_pon_resin {
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
 &pmk8280_vadc {
 	status = "okay";
 
-- 
2.39.1

