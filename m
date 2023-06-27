Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED33173F7E1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjF0IzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjF0IzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:55:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F2610CC;
        Tue, 27 Jun 2023 01:55:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA46261030;
        Tue, 27 Jun 2023 08:55:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CFDC433C0;
        Tue, 27 Jun 2023 08:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687856100;
        bh=s8NUZ3ksYv5mLj2yRtarpDvRohslNYcPlf0NKQbDRhc=;
        h=From:To:Cc:Subject:Date:From;
        b=ORlVk8K3VPq2wiNzuL6lPHqGT9sbQqF8HVCXZg2LGQ6usjE2HA2NtqBmPCiebL4bo
         PK0m2JL/9bzi4ttrpxGNlrkW/2FlKZKknOUKn1BWEShBr7Ba0v2FxHMXoxGXSc6CjX
         zMG8d+cryctWrZfEPNPgGt2kFSfyLR04OnYZ1Z/t/6NmPsAGAwiEW4WKx0Wxx1W8tU
         d9w2XkYHYYGYU2BrKInwjs+LJoDKz8q78ulmumPN8D0bP14+mfeXPg9vJcR96zpXHH
         R0cdvbC+vY283pmR62xzHchZZlR0YAXJyo2J4xMVlw8qkYhV7CUVYWiDxbKOKUOPse
         F6Yh/ArZMVMdw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qE4TQ-0001Zq-BO; Tue, 27 Jun 2023 10:54:57 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Patrick Wildt <patrick@blueri.se>
Subject: [PATCH] arm64: dts: qcom: sc8280xp-pmics: add explicit rtc interrupt parent
Date:   Tue, 27 Jun 2023 10:53:06 +0200
Message-Id: <20230627085306.6033-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unless explicitly specified the interrupt-parent property is inherited
from the parent node on Linux even though this may not be in full
compliance with the devicetree specification.

Following commit 2d5cab9232ba ("arm64: dts: qcom: sc8280xp-pmics:
Specify interrupt parent explicitly"), add an explicit interrupt parent
also for the PMIC RTC node for the benefit of other operating systems
which may be confused by this omission.

Note that any such OS must still implement a fallback to the root
interrupt domain as most devicetrees are written under the assumption
that the interrupt parent is inherited.

Reported-by: Patrick Wildt <patrick@blueri.se>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
index a0ba535bb6c9..80ee12ded4f4 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
@@ -101,7 +101,7 @@ pmk8280_rtc: rtc@6100 {
 			compatible = "qcom,pmk8350-rtc";
 			reg = <0x6100>, <0x6200>;
 			reg-names = "rtc", "alarm";
-			interrupts = <0x0 0x62 0x1 IRQ_TYPE_EDGE_RISING>;
+			interrupts-extended = <&spmi_bus 0x0 0x62 0x1 IRQ_TYPE_EDGE_RISING>;
 			wakeup-source;
 			status = "disabled";
 		};
-- 
2.39.3

