Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE1E688425
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjBBQUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbjBBQTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:19:46 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253226A710
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 08:19:44 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so1837650wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 08:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bvde7TRSc+XcvQpUicM3HCo0A7W0vz9q6qwUldao3rg=;
        b=x5c3UB8Bj+KlldXNEvRvLneBXOLJ10bFnWBopPG6nMZHfM+8ZNTxtwxOpymB/s5WkL
         yABC8THSJC16qlBSXBpAs61wuHs7fqF25p0GtC1yJsX3mJiUoWnaI/xCTZstbTx6gZNf
         GUokT1YZZ1/Gkeiq+ippsaXocyoUv86LWby7NtL83H7XdtKollJ8h4iwCvPkb8x40VFs
         SCvrT779yJ5SdBYXTFN/cC/y8isUHcL1WcgF6foLfrVOptUsIs4oJEZHfxUtH2zJKrVb
         NPhQqfBpdF5Khoqv5MzuAJpU7SmOEAotjGspsk3JYQa+ZmaO31UFh8YTcL3g4y5dCm17
         DFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bvde7TRSc+XcvQpUicM3HCo0A7W0vz9q6qwUldao3rg=;
        b=01ZM2W+GEQPy1BI0KsL9fCvvPFBkm3oWKncH1KA5EYzwRMol1XZ608yHI+wsy6BYeq
         JMeA6RfLLRbswFpzxVK7UGXJI+hBEJhLmgoOaoD7iXiCoF0IOqMbzXcR0BDLCYn74Sdy
         u38TQ9hPEm0SoLZIb4kGy+dEYVBlLQg6+iAoYMDmBxJzE7yK6TB5NGcegwAUciAIeoH5
         ADIXY+d4X4EhDBnfW/VbCSBma5uYbyl9P2n2jsYkm0XaR5yLgJqcnwZNpX7KWWrwTAho
         iBSufqofe5voL9budySoTm0lkBzZt6n/qax017TRWGHAbqMvXpoemP+M+aEmk/DTL505
         EF8A==
X-Gm-Message-State: AO0yUKVXvj99gBWHL6UYJg2JJJBbDvp/lgONTjxrKtWiYmwJLl9n1Rvo
        xXcisDKNHAtWdl6sMC3MYNO5kA==
X-Google-Smtp-Source: AK7set/tzDxe3/7brUDVCpGjm2oWuYghTrMOZPr4KOplroPKoawcTSFfMMo/hig3LS6S763yUmI4Jg==
X-Received: by 2002:a05:600c:1d96:b0:3dd:af7a:53db with SMTP id p22-20020a05600c1d9600b003ddaf7a53dbmr6756393wms.11.1675354782673;
        Thu, 02 Feb 2023 08:19:42 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c351000b003dc521f336esm212416wmq.14.2023.02.02.08.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 08:19:42 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 05/13] arm64: dts: qcom: msm8976: add compatible fallback to mailbox
Date:   Thu,  2 Feb 2023 17:18:48 +0100
Message-Id: <20230202161856.385825-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230202161856.385825-1-krzysztof.kozlowski@linaro.org>
References: <20230202161856.385825-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSM8976 mailbox is compatible with MSM8953.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8976.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
index 2d360d05aa5e..a18eebd8f66e 100644
--- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -1027,7 +1027,8 @@ intc: interrupt-controller@b000000 {
 		};
 
 		apcs: mailbox@b011000 {
-			compatible = "qcom,msm8976-apcs-kpss-global", "syscon";
+			compatible = "qcom,msm8976-apcs-kpss-global",
+				     "qcom,msm8953-apcs-kpss-global", "syscon";
 			reg = <0x0b011000 0x1000>;
 			#mbox-cells = <1>;
 		};
-- 
2.34.1

