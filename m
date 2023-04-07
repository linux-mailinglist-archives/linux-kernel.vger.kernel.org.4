Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C616DAD8E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240862AbjDGN2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240795AbjDGN2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 09:28:41 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAC486A6
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 06:28:39 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id z42so43509784ljq.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 06:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680874119;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k0IfW2c7yHYEw+7My0/Z0HZx/BNSO/stFk2dfA3BGq0=;
        b=Ro0Vd5ko7vTTIJf8sPurw4gyNC9dktQtfFJJl77SMkhAyBP/pGEqpZZrfkq9zQdxen
         QeNFSfzVP6fKnCXK705/jnJaWfZLdgruEkF/WVCiDDaxQ4ySU9ehYsHiPe+r/Qc0lPZn
         EokASAgN41BXeNYBcaDHOMxar1uBU09BRlUzAQKJwjLTUL+uhrDoYiIglqvYKboSjlLn
         QbNjaKhLY+GS7st+gBqJBxuhQ+KfPOYo3FZs9eRJm4aaZm8kdnupDwBHXgnjjeuPxW0V
         S2P9lkFrRAJ1dr77dnsAMlAVhS+Vgw8ZU8FcCJFPCozDIJoAnciVDnC2yT22pK3t20jj
         t7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680874119;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0IfW2c7yHYEw+7My0/Z0HZx/BNSO/stFk2dfA3BGq0=;
        b=ip+KLREzDx5De9OgQrHXy4IbtdX3sQMsieCX5pW97SV+eOP2MQRzKXjeDLLF+jEbyb
         fAoammKYNw29/M95e4MDoprxjW16n88vJMKYyF+IlyA7qJ/UA0rWtqtC58G0d9yVL5Ju
         Wv98D5SSoBLoWo/JBA5wUyg2ze5wMlXAxRtlMD5W2ECaSBmBf49KUZn54C+vyq3cDm88
         80vkV+yMAkFJc+Sfd1NGhZhU6JuoGam/MsIsrzMJuvhhbD80nHBouTLtV8pSfZBz6yAW
         peV8Jx1oCmmi1AXmsGb8gypwLD323rjv69Mv6OuG5bFZ9NP6gM2jrRDW94O/subnfJDF
         sCAA==
X-Gm-Message-State: AAQBX9ed3uN0+wp07lvG8ITUFRYhrCKsdHc0QI8I7mBLJafSDzlJBksN
        jvGgjhgEtFz1vJSnVA0YvQL5xA==
X-Google-Smtp-Source: AKy350ZQ30yshVINhFaemYrdT+8iOMgt3F15JZRLYN0ujn/iGtjiu2jaTgtCX9DBh7jQJj5JhlA8EQ==
X-Received: by 2002:a2e:9a90:0:b0:295:ba22:360 with SMTP id p16-20020a2e9a90000000b00295ba220360mr718548lji.42.1680874118910;
        Fri, 07 Apr 2023 06:28:38 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id h2-20020a2e3a02000000b002a618eb72b1sm811031lja.98.2023.04.07.06.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 06:28:38 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 07 Apr 2023 15:28:34 +0200
Subject: [PATCH 4/6] arm64: dts: qcom: sc7280: Fix up the gic node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230407-topic-msm_dtb-v1-4-6efb4196f51f@linaro.org>
References: <20230407-topic-msm_dtb-v1-0-6efb4196f51f@linaro.org>
In-Reply-To: <20230407-topic-msm_dtb-v1-0-6efb4196f51f@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680874110; l=1494;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=gHkzosUqi4bzAs9dpyelWGTDvy9GQH7llzRSHl6mEos=;
 b=vqvoGg7o3fTzGx7vo2BEYDCXp5lvFkui2hVK5Zlj/spa9/z9GyvocahhSArwYxz23Agovl07UXC+
 zft2HNhADd3ZtyJKEv7cFmxO2Z6+RnmniJonP8w9Z7VA7RmgPy76
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following schema warning:

gic-its@17a40000: False schema does not allow {'compatible':
['arm,gic-v3-its'], 'msi-controller': True, '#msi-cells': [[1]],
'reg': [[0, 396623872, 0, 131072]], 'status': ['disabled']}

And reorder the properties to be more in order with all other nodes.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 0cdb16316021..3292b046a8d3 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -5182,20 +5182,20 @@ apps_smmu: iommu@15000000 {
 
 		intc: interrupt-controller@17a00000 {
 			compatible = "arm,gic-v3";
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
-			#interrupt-cells = <3>;
-			interrupt-controller;
 			reg = <0 0x17a00000 0 0x10000>,     /* GICD */
 			      <0 0x17a60000 0 0x100000>;    /* GICR * 8 */
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
 
-			gic-its@17a40000 {
+			msi-controller@17a40000 {
 				compatible = "arm,gic-v3-its";
+				reg = <0 0x17a40000 0 0x20000>;
 				msi-controller;
 				#msi-cells = <1>;
-				reg = <0 0x17a40000 0 0x20000>;
 				status = "disabled";
 			};
 		};

-- 
2.40.0

