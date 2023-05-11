Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43966FF760
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238654AbjEKQay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238899AbjEKQaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:30:20 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B941A1B8
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:30:11 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-965c3f9af2aso1336072466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1683822609; x=1686414609;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xmbKzKvCEVL3/Z+maa2frRisiuuXCYpfX7aC8pkvAmU=;
        b=q/dV1Kyz1sXGgpQBSBLe1o1ZHQPsO4KY0ZINVL7sF0dY5PWi8vtO4cTDNAXLPfoYqT
         9TWMsb30K2KbCfPm9vbXw8PxwLzrni+5W8MkG6TPmYQyj3dQxHiz3rq+u7Htp34zZjTO
         81APfL/5wjNQfqdsPXAFuh/lgTpuYKvt4vmFNYPPZNe2Eh9Qqd43X69hrrJaaI4rlczC
         V6Wmcmt+izh+xnOwPYeLQFjbX+D+RV64MzrntDtyBhQ5wF5EjCNdjy5DVmXZIw7Pn8pg
         EClDjEEEJxVAJptJLWkbq8w2gs7sIXQocpD/V1MXCO1OxSylOdkycHK1CuNanCgUxDAO
         HjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683822609; x=1686414609;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmbKzKvCEVL3/Z+maa2frRisiuuXCYpfX7aC8pkvAmU=;
        b=lOOM66cG9g/XJVMNCuNuhrmZfVlZn1YH2eeDyacb/a79JkG+bqtbTZw7LVmN73ndrQ
         zZfOzw4f3BgtiMPWfWN1JHrKjJOM48mKJ8acgARePnwOF7uZWqt878o6XZuMvqVO9IDy
         N5h10AwyF54SRom0LQzcf5604t+XSnfjHqpuz/mgfxd6cniCZHmqAVSkrKDfL8AjY9Dn
         EYTxiTVEXzy6QJcx6+eB8dZszjr2WwRWJlcDrEV6RE3vT+TiuHcQcHAK8ogJAm56mJUg
         e9OMi65GjKGLMfCaCHngBdpmx/Azme4xEm6S3WNwNhFDEfb8PVq82fPuMXuRftRRHTHU
         XXeA==
X-Gm-Message-State: AC+VfDwIkf4PkNtNGENI0mAagT0zrQVkEiQ0mWBPta6xTpoft420TKrV
        c/k09b42u4QKx85SpEJpCs6LBIMX9/Po76LR/KY=
X-Google-Smtp-Source: ACHHUZ5uOZDaYJVg9Iy1QBY5C2GOopzZ8IjxRnoeyVNFQMDXFhaxHGCDIKTLpigjJCW/vtgDc5u0yw==
X-Received: by 2002:a17:906:dc89:b0:957:862a:9e6e with SMTP id cs9-20020a170906dc8900b00957862a9e6emr25298127ejc.73.1683822609676;
        Thu, 11 May 2023 09:30:09 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id v9-20020a170906338900b0094ee99eeb01sm4209935eja.150.2023.05.11.09.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 09:30:09 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 11 May 2023 18:29:30 +0200
Subject: [PATCH v7 10/11] arm64: dts: mediatek: add cpufreq support for
 mt8365-evk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v7-10-98cbdfac656e@baylibre.com>
References: <20230203-evk-board-support-v7-0-98cbdfac656e@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v7-0-98cbdfac656e@baylibre.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1201; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=Rq9Zwic5qmJaMrB9niIQqjmYy4HHPOH7tnCD4z3ywik=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkXRgFgHKPxikwHNlF53Z9K1ZVag508Iiu4ktC/Erl
 oNn1iLSJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZF0YBQAKCRArRkmdfjHURSf9D/
 9e8z/M0tLfGh8LKPOPWHUhEpwvDmDGhQ8Sv3EJVcvEbZlehDxc0bKZ5QPW486w7RiMvScyTOrwUwZ4
 /4zH+gUCHFtEo4RbchFHkmCyoVmqBCClMQdJrA+75i4oFwtCCVyCibd6fZ53AUKjXIUJduasVXLzyQ
 x+4Vu2+iEH7jdwPzRI/UOnCOHdBlRtt5G5BiFHX+VkDkbzvheEJltDe9kqIaGeaxWGoxuqKjaSwr26
 2ItedjGs3qapqQB4dv05/9CJZE3873C/K5QBOw9HOPjiKtGJJSD2PS9FLiDJcpMKAoRw7+FaEMseU9
 OMijDOrupSFfBLHv0VEtBGa4FsjuTYcVM3uBV73z1eyr6YoakLjtjYJye/mHE8N8ek9oxg0mH5DJxQ
 iLTZFAmtZBebXV6us4SmHFT2mzpC9JGhz6rcUM+5Cul8znxNVYut+FPVVHfyDCo02z++xMHGCkXx4d
 tI51+YoFVcXeo6tBEPc3Q1s/xXXudIHndZ1UwRlYs2MSM4fk+aeWOkGkzmUhUTXytJiuoU9YoKD5YP
 yhZ3yu8mKKnXOYV9nR3C9tlHNK2zsmXgNEHMbVcKXqQ6hrPhgosIAXYnWqaRndO3fRcGgD6GqDfiU4
 Mt2ma43fUmMRe8EQ+eqvpgq9TqQMSApPb7QUmqchapJpOMCevP9fvaYtC7tw==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to have cpufreq support, this patch adds proc-supply and
sram-supply for each CPU.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
index cf81dace466a..b39b2bdfb82f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
@@ -88,6 +88,26 @@ optee_reserved: optee@43200000 {
 	};
 };
 
+&cpu0 {
+	proc-supply = <&mt6357_vproc_reg>;
+	sram-supply = <&mt6357_vsram_proc_reg>;
+};
+
+&cpu1 {
+	proc-supply = <&mt6357_vproc_reg>;
+	sram-supply = <&mt6357_vsram_proc_reg>;
+};
+
+&cpu2 {
+	proc-supply = <&mt6357_vproc_reg>;
+	sram-supply = <&mt6357_vsram_proc_reg>;
+};
+
+&cpu3 {
+	proc-supply = <&mt6357_vproc_reg>;
+	sram-supply = <&mt6357_vsram_proc_reg>;
+};
+
 &ethernet {
 	pinctrl-0 = <&ethernet_pins>;
 	pinctrl-names = "default";

-- 
2.25.1

