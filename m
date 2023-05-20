Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D766570A7D6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 14:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjETMUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 08:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjETMTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 08:19:53 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9ED128;
        Sat, 20 May 2023 05:19:50 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2af24ee004dso19508601fa.0;
        Sat, 20 May 2023 05:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684585188; x=1687177188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjXc4/GMRnCq9hjwFiP+znUTBS6Bv1a1cDU4Wv6DmUE=;
        b=epNksI2VmY8Ez7i903ZrYF+/suW8pEzI0SZw0w0auDpl0zYlQA7VX4SK4gcNuBiYUU
         PPBHQDmdL18IzOviYohdQbmKP5GGvoUoHStkvMkt5O5AK72do1+2XC6rKIxsJbv4HsK4
         Nkuy02/JxanfEGTwKQ14ODORHt3BjTrZVizlipdDmZaLklEetr0Scjt08CXr/JCNwL0c
         Ddura+mcwcPiy7Q4EN6YheVciFzETy/A3/RQdvHxcAxOIchwoKdHDWDDIIqc9oXmw1BF
         BOqgb5OMswamxwIjdc5LGMfpWmJUHcelwhZxZT2PHddBG5zJ6hVZqMrGkSd95OjM3voI
         g15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684585188; x=1687177188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UjXc4/GMRnCq9hjwFiP+znUTBS6Bv1a1cDU4Wv6DmUE=;
        b=I8vELl+NfSIPEC+tWr211VzUmz0P14MlFvB7hppYzUtWUu330FYLwQViExn871hd5y
         /WIT+7/wjVCnPv+uh4anT/IyfQE6cn6dXmhATuQkcS5dPuIpllk6InzQhpMlfKm1ihud
         D54pXDqCxl3XwDmnIORoBCsh/dDeGrgijfNpiAGgnB0mT+jCvVsOHAKG9mkkN3TIA/GI
         VlXTvumGlQKHjWfLd+GwvbGAtq/UbTF7UGMp/6CfBKEwFneVn2rLHXTrToxEp5yPQ8Vu
         3LVShUYRIcUjFdHBFgruIaLnKbr5bGFicijlukBKsxLiWjc0JUQiOq8QtEaM0jVkGp/3
         IpDg==
X-Gm-Message-State: AC+VfDwnka/jAHox29cGY1KCLAyu0ngVURI27Cnz+q1a2+ouRmDathok
        bqMtsWCmvR/LIqteKqS1GoJ5cYKJKYexJQ==
X-Google-Smtp-Source: ACHHUZ5ACo6eGWA8zQr8lRgaoqODDex8H5V5wannozNzKIqSs2uRRIpkaTLAvifU80uem9xCwgllOw==
X-Received: by 2002:ac2:4461:0:b0:4f3:a99f:1e91 with SMTP id y1-20020ac24461000000b004f3a99f1e91mr1631822lfl.52.1684585188423;
        Sat, 20 May 2023 05:19:48 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id r11-20020a19ac4b000000b004edafe3f8dbsm260303lfc.11.2023.05.20.05.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 05:19:47 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] ARM: dts: qcom: msm8226: Add rpm-stats device node
Date:   Sat, 20 May 2023 15:19:32 +0300
Message-Id: <20230520121933.15533-4-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230520121933.15533-1-matti.lehtimaki@gmail.com>
References: <20230520121933.15533-1-matti.lehtimaki@gmail.com>
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

Add device node for the rpm-stats pseudo device.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8226.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
index cb4b4a6d0447..8644540f5aae 100644
--- a/arch/arm/boot/dts/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
@@ -592,6 +592,11 @@ frame@f9028000 {
 			};
 		};
 
+		sram@fc190000 {
+			compatible = "qcom,msm8226-rpm-stats";
+			reg = <0xfc190000 0x10000>;
+		};
+
 		rpm_msg_ram: sram@fc428000 {
 			compatible = "qcom,rpm-msg-ram";
 			reg = <0xfc428000 0x4000>;
-- 
2.34.1

