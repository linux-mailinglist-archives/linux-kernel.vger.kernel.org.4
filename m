Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0836541B2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 14:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbiLVNTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 08:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235248AbiLVNS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 08:18:28 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D1B2B24C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 05:18:27 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so5660068pje.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 05:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYoJy3okzdnngL6TcLmeGykcAQcBXE1fb+mKXu1bB1c=;
        b=ZtQ5aYt6JszkNCc6c+71vylemy82zpImGkRGBLjyDIYf900tOPtXU155alWvES6I1M
         iN33nGCpROLkAWz2iuohHqj0WGMRtqHS9xDzku9mG2s9eEQkt4khJBVbQ3qq3b4HOA6l
         R3OiuzxM8jBtFr4UDlvK6L1wOV6uTgeCQlEU6XYG7D0VC2AmlsmzQuN+5VwkKXZ0CLoF
         K95z38wHmzOT7Vbkjk4Z6BmrLHVQnNZCMcX0kdRG0L5JmGdSFrmd2YFdwz0FVzttv0/l
         4LLt67WOyGy9V4XDggSgZXyDOflfPKYJR/YGUYQ9EeVBtidNSLZOUhCuupf7w9zw3Q60
         VOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYoJy3okzdnngL6TcLmeGykcAQcBXE1fb+mKXu1bB1c=;
        b=PSwmZpBY0OwmdQAjVEYpdhLMxSd1ryeeymj4IwmzIEjVtccwSEiroYUtmmlczpgudj
         9lp6GLNg0/OvKvTP+Bzbbe9/JZW/bE80xvgYBAiG0ew/+FRiqBaOD9/WM0qCNqFeNHgz
         4uyVeU9lsLOyjZarpOOsm4aTpX3mfPPSoL04ZFXo+I9g3XNTyQZNsBZuHnXvsYEqIGGe
         RuFnJuDlm4RzsF+czV8l66fgrRj9UW9e+3MomdLDv8Se0Eelmv9Y60l846p9VCOvao3a
         RsT+Hq67F3lvwjQDIvsJ4q9Zn+ow9z68VHuaMVz/5nDnjRLigT3LuD9N8M2hHopVoPPC
         I+CA==
X-Gm-Message-State: AFqh2kqnAvrbHMWkNWmAwg9gYldjWE0HcKO/mXoL3F8HGuhU/M8EjBD9
        wla/K0w5I4dlTNiLulQTstci
X-Google-Smtp-Source: AMrXdXuQk5bFXwNnUxnhWo5QLTtJciBLJW9VKkXjO0jzujbPw/eVGhVOUzd7gxx0E69pxZ8/u3ZH1A==
X-Received: by 2002:a17:902:edc3:b0:189:5ef4:6ae9 with SMTP id q3-20020a170902edc300b001895ef46ae9mr5194255plk.45.1671715106651;
        Thu, 22 Dec 2022 05:18:26 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.99])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902fe0c00b001896040022asm491570plj.190.2022.12.22.05.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 05:18:25 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com, ahalaney@redhat.com, steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 08/16] arm64: dts: qcom: sm8250: Fix the base addresses of LLCC banks
Date:   Thu, 22 Dec 2022 18:46:48 +0530
Message-Id: <20221222131656.49584-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221222131656.49584-1-manivannan.sadhasivam@linaro.org>
References: <20221222131656.49584-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LLCC block has several banks each with a different base address
and holes in between. So it is not a correct approach to cover these
banks with a single offset/size. Instead, the individual bank's base
address needs to be specified in devicetree with the exact size.

Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index dab5579946f3..d1b65fb3f3f3 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -3545,8 +3545,11 @@ usb_1_dwc3: usb@a600000 {
 
 		system-cache-controller@9200000 {
 			compatible = "qcom,sm8250-llcc";
-			reg = <0 0x09200000 0 0x1d0000>, <0 0x09600000 0 0x50000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg = <0 0x09200000 0 0x50000>, <0 0x09280000 0 0x50000>,
+			      <0 0x09300000 0 0x50000>, <0 0x09380000 0 0x50000>,
+			      <0 0x09600000 0 0x50000>;
+			reg-names = "llcc0_base", "llcc1_base", "llcc2_base",
+				    "llcc3_base", "llcc_broadcast_base";
 		};
 
 		usb_2: usb@a8f8800 {
-- 
2.25.1

