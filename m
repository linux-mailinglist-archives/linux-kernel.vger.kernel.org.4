Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4A068837E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbjBBP4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbjBBPzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:55:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171E56B981;
        Thu,  2 Feb 2023 07:55:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31A9D61C17;
        Thu,  2 Feb 2023 15:54:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D9FC43325;
        Thu,  2 Feb 2023 15:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675353285;
        bh=R+lcw9Z2ly5fSK4ncGho+OoAniIGSr6RfBUKPnF3huQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dJTGKfmkOkJW8WtINBZiQDfxE7K3e6wJXYEg7cIL40tdNmbNmZU0PR/1kkzxbDY5s
         iCEixiUWWsoxrEcOfV9s9utyzSUq72Jg3zBiwUqUx5Pv20OkQ1sYERTfHWmmyQXyCO
         dxqW6PvhJCf2b5sUotRJVA9sxKKWEExG3qKecPmdeLbFLKqjvCbCJuDrHN7FGFMVQN
         h0hAa5yJYR4NJeZ7akIOewCGDp8fWjrmy3UNAGD9pEcdQiDuqc2fheIN2BY4DDvl8n
         Pxt5idCSvUb8367cYafEmpRLOSCaqcU3qNhTfS1HXaQyoGHQltC0BUi5NCKCSHRBSx
         5YmysIL2chG2A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pNbva-0001mg-Bk; Thu, 02 Feb 2023 16:55:10 +0100
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
Subject: [PATCH v2 21/22] arm64: dts: qcom: sc8280xp-crd: enable rtc
Date:   Thu,  2 Feb 2023 16:54:47 +0100
Message-Id: <20230202155448.6715-22-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202155448.6715-1-johan+linaro@kernel.org>
References: <20230202155448.6715-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

While it is possible to access this UEFI variable from Linux on the CRD,
this requires using a fairly complex and reverse-engineered firmware
interface. As the only benefit of doing so is to make sure that the UEFI
(Windows) and Linux time never gets out of sync, it seems preferable to
use the PMIC scratch registers for storing an offset instead. This also
avoids flash wear in case of RTC drift, etc.

Also note that setting variables using this interface does not work on
at least one CRD for reasons not yet known.

So instead of using the UEFI RTC offset, reserve four bytes in one of
the PMIC SDAM scratch-register blocks to hold the RTC offset.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index 3e0cbacb0641..73b7507b956a 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -499,6 +499,21 @@ &pmk8280_pon_pwrkey {
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

