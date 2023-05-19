Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135AD70A14E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjESVJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjESVJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:09:23 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE99DE56;
        Fri, 19 May 2023 14:09:20 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f3b4ed6fdeso241069e87.3;
        Fri, 19 May 2023 14:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684530559; x=1687122559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCVraEkibXAoKbM2fIOO1Nf6W/5PWeeWGXHiXipcxac=;
        b=aNx9vpqGFPB5eo78xu3N2qQWx9rK/N6N1IRiD89vMi4fczHryGDuU/galxXmJN74jO
         NtimkaDSSo1FXrrNgSqZQwNzytfgtQyJr1xFbsElFcCUG0p8brrJ3fFcrD4Y6pDP6i6H
         3PE/1wJEUQRmIAI40adL4NRvSZDX0edlvEz/nEsZHA4cCtfu07JSmEm29oFPI4Z/jgaa
         VhqcffSlnG8rpliHBgJGY5uv5QELZHFKUAb33SUKhVgbW0NBYXhcl3xVV9yuzUPSdYYs
         dQaRjPaWxdjf0rGNt2sO1lDVLcTbMZCFppz7zXPuCfQwgs8jGFWeRNRCawr9JIYbZ/C4
         gYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684530559; x=1687122559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCVraEkibXAoKbM2fIOO1Nf6W/5PWeeWGXHiXipcxac=;
        b=dwCPmuGxadAowYnNOpzeSyeGtuXq3wlbT+DEjlcAMqz2dPxcISsxsdps7AXC0ji5BH
         H5Io4RFdDNj5la6fjAeZLGSlanSZbcBrQ9R6pfXoOL18OO9e2vEzsv2rzzLPt0LoPEoV
         TH64SnWk0kY/5B4vcLCsnbv0TEqH5iH8UKBi03RgSe9N7Z1KoMPOEW+Z0ztxte69jCrB
         x+Ss9mBnz6Qpj2XatgfTXm0/kO4nsmN7FZojzBsTLuNYWHWL7y8IPIx2trnH6uZXA5x7
         +CUUX+osig4MUsyXCTPtpZRXgo3elAtfgCl8+t4dD5FwAVewS1EBJ9o47E4YNgVfzjxC
         EN/A==
X-Gm-Message-State: AC+VfDz1Jnd52XCMpapYLPl9iaXUy0rpvK1Ows3KuTDJaHmvp+njvDmA
        9a1vH+9rW056p1GMYhn8qtJatRc/KhQK3w==
X-Google-Smtp-Source: ACHHUZ4havTjIs551re+Nl819h8oMaK9jJvEFCflsISfdbRBeG9bkBafbqi76y7pZwA8bT5equMN5g==
X-Received: by 2002:a05:6512:376b:b0:4ef:f4ef:a1cc with SMTP id z11-20020a056512376b00b004eff4efa1ccmr987568lft.14.1684530558628;
        Fri, 19 May 2023 14:09:18 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id i14-20020ac2522e000000b004f3945751b2sm30043lfl.43.2023.05.19.14.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 14:09:18 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] ARM: dts: qcom: msm8226: Add IMEM node
Date:   Sat, 20 May 2023 00:09:01 +0300
Message-Id: <20230519210903.117030-5-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519210903.117030-1-matti.lehtimaki@gmail.com>
References: <20230519210903.117030-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is used for example for reboot-mode which enables userspace to
signal the bootloader to go into the bootloader or recovery mode.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
 arch/arm/boot/dts/qcom-msm8226.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
index 006263373348..3628e48c1ec1 100644
--- a/arch/arm/boot/dts/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
@@ -646,6 +646,18 @@ smd-edge {
 				label = "lpass";
 			};
 		};
+
+		imem: sram@fe805000 {
+			compatible = "qcom,msm8226-imem", "syscon", "simple-mfd";
+			reg = <0xfe805000 0x1000>;
+
+			status = "disabled";
+
+			reboot-mode {
+				compatible = "syscon-reboot-mode";
+				offset = <0x65c>;
+			};
+		};
 	};
 
 	timer {
-- 
2.34.1

