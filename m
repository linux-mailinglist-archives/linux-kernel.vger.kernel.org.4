Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E38A710FEC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241808AbjEYPrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241810AbjEYPrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:47:47 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443631A1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:47:46 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f6094cb2ebso5939825e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685029664; x=1687621664;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i7fskv7wFtJKRdpwuN7WJVfxVhRgocG9sAIRUMAhdUo=;
        b=QavnK7L1CBahMJ2M/KON2DXzPpSEofUV/dHNQZwrUwyIhvVrZZxcY1ZcXMS8Bjdix9
         vj6HOckJuHGufz6o90taIZc5cJjPYubSwWqkPfowgzAEAdOfvuYvC8YjcleY781KZkqf
         b56+QQMR2hMbcHca/+zm9HRgyCTtM5J3ASArmNLEsnoK2iYS8GFlrRrXC6kJObq5fRUY
         9eGidIdiJ/Za8ilVQ2sL1i6jXZVxywyhicmHG+uTvP+7MtYFxIdAe4+f5SJv7Onz5d+G
         c6j/zrVSFr/b1+iakQSzbAkMd+xidqhpWNdzTQNZNl4sMC82T1+L46yE9xkGTvdALLZY
         gR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685029664; x=1687621664;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7fskv7wFtJKRdpwuN7WJVfxVhRgocG9sAIRUMAhdUo=;
        b=EamxAmMs+Uis78fdtk21qwB5ARTUpPP/ABHvVpqo4Bz8BLBQybkAxlMbks2ODF2Tkf
         7Q0igLZIoAu79/Q2Ki7PqO/s+heHcicOtOooHWTT53Hs32/Wz+CkG2l5AY0D0xM3vZoJ
         RjEpu1pQODYBXjxfs2yuC5T4gUrCDoa8+deqX+19HJ6ysJxynMzrBnNqhPj/Kp3Mwq9e
         MQhowWKP9JhAfs5pY71y4R35F6LqAV62DL0GCrXOCZkbCsGW4MrNReRTmsGj9EoFInz2
         dkDt7Dw5BWyKb4P4wRjenZC28Cu5V0199jv7FALfPahnUY57oF3UhN6zd+S6D3OErfQm
         DvCA==
X-Gm-Message-State: AC+VfDyMEUchbachF/cnAVPlqTSYpAon7Chyig1+W3cXpky/5tKqBmKn
        fkJjVSdx4DJC2pivLUtuOGoQGQ==
X-Google-Smtp-Source: ACHHUZ5QQ/CIvUNIitY8XqYql6TjE61MourwSiwzqhpXG4FY8LC7r8LCN5RpvzDOHM4e+enaH1oPaw==
X-Received: by 2002:a1c:7c05:0:b0:3f6:113f:9184 with SMTP id x5-20020a1c7c05000000b003f6113f9184mr3328761wmc.19.1685029664756;
        Thu, 25 May 2023 08:47:44 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id b3-20020a5d5503000000b002ca864b807csm2275873wrv.0.2023.05.25.08.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 08:47:44 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 25 May 2023 17:47:37 +0200
Subject: [PATCH 3/4] arm64: dts: qcom: sm8550: enable PMIC RTC on MTP & QRD
 boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v1-3-4d5d7602f290@linaro.org>
References: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v1-0-4d5d7602f290@linaro.org>
In-Reply-To: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v1-0-4d5d7602f290@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1117;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=OhvubshaeIwf6V0ll41NcZ9KhvdQx92+w9HwT/05Q/g=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkb4MccE13InYB41STLGWteCWKX4jFswyvN8XIZOYg
 YsnpvqaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZG+DHAAKCRB33NvayMhJ0aHHD/
 9pHyU19UckmY9DlqmsYH9ZH1XrZH7TS1a8yKw80oQSIeLkHfX7MsaZbXzIr+y+alm4U9RwcZI7zzO+
 FKqK48iPH8UxiiRqifJHvJgXACZ3AsJsiOq8TYs2DHFov233XWOLGCANMzhvk/vHfCzmhQos3jkORa
 MuzLf2yUmRE0TXTiTcT+23TjmxyhAyNxa1NgHkB7VY8E/UnyMordS7Lmx3zbROYp6UDEwJssttKM6O
 1OkNj19wT8p9xHNxm2RtNLO/+u5rC0QyThgKEcobUYbMhwprkjcUjxiZq1FlHSRFxwFV6n08s+ntEi
 otNT3O8+ilNOfTjbjOaRLaEpzq30reoNj5/nxBPW9mvue7p72hcxqz/o0hzFelPdEKj7elYO6s73Q3
 Q8JDhK5nPMq+6/A2qH05gpHauYd+c1UHW2yBh3fyvCH20ZdQHfRUDXdSsh72p7Oyhbh3jtaOJL23I5
 oa1MeSAiFBa155dQiWHFHNp0VTNMkD2sYdPPXmiIhnacsS+EhdPCK6pTQFNY7hQeuXDRUBtVQP+rWP
 aJGIPmCiP7RaEWxG022q/R/kITL/XitxPilkxtLEj/rK4vp3QfEcB68fRidIRDCcdiF/xrmaFqpvJ5
 D64VCTmgQO1ljy4Bd4joImfjNdw35u9dlOGZjcyq86bF9pSfGh9I4kHrGRHA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMK8550 RTC is functional on the SM8550 MTP & QRD boards,
let's enable them.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 4 ++++
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index e2b9bb6b1e27..6bf111e655f7 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -496,6 +496,10 @@ &pm8550b_eusb2_repeater {
 	vdd3-supply = <&vreg_l5b_3p1>;
 };
 
+&pmk8550_rtc {
+	status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index 4a8177f99523..b08a8201ad23 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -482,6 +482,10 @@ &pm8550b_eusb2_repeater {
 	vdd3-supply = <&vreg_l5b_3p1>;
 };
 
+&pmk8550_rtc {
+	status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };

-- 
2.34.1

