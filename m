Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C94760F168
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 09:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbiJ0HrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 03:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbiJ0HrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 03:47:04 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B61169123;
        Thu, 27 Oct 2022 00:47:03 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id l2so589449pld.13;
        Thu, 27 Oct 2022 00:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msL4Fm7iWpHIBylFj9WDZgCoBlELM6gjoyFeS0oql9o=;
        b=Hmn99xvSBH8PpkAxglpPN9eQHnxGxvWuQerqHQg82N4aBYWSf5e1PPDImExNWt0ZMT
         1fDol/hX3LmyFXIZaLj//RAncjZm8caw6zK1ZHY6hps2rwI6KKpdor6h3HIIhob4LJT1
         /kxlY5lsS66l0ESbL060PkEXdh7wHM1uxSMzNcnWc/Coo66SZbu2wiEI7H85LpIIzE+O
         jBx7G39tztheYGWuFOGVYpoZvG0OKDkvGEk53prfPq4XMenPhYTypfeC6U/x3GSAh2/5
         PR4K9IqO6PUeHNtwNbCMdwWBEGaKmOe64SBAw7dBb4GVbY2LMVIWA2GfVI9E8YNA6bkz
         j/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=msL4Fm7iWpHIBylFj9WDZgCoBlELM6gjoyFeS0oql9o=;
        b=ID/fZl87wgbVi9oFzydAKgxXzpPBHuZEo4rV4W5vaY2ix5dh+D3bZAzLKKTl8NHDAf
         rWm531df/22tnUzvUtI9Em88QajbHevwPOXeAHlokD0PcdVOdQCkSu0nzFwazuhVzRNx
         HJOustvXNM7LRp02TQPyXEJzHm7At95EaNTAu1FyVOJIuw31MwqxtZ+zXfBXOPO31mIv
         11t4KuW5EolNtNb7WP3c5gLmWqzmDKjoFYKfJL5sAx8ynqDEBs8H56Ne+0kv7mDfRRzo
         MXTqOFbYeim1Vy2DOJ+mMjAx59b8HO3BSWdS/9l0uVr3IgNazOpkEwIXOL8tfGPZoAEm
         AXUQ==
X-Gm-Message-State: ACrzQf1sNE2lw3sNma9DqIo0eaV7UlMDFgI0V+kbBFxwRf8Ctz0UBnCD
        54vxTPu2hoIi+uYWnc3OE5k=
X-Google-Smtp-Source: AMsMyM4VOx+ddVCfKjCCzX/ZBUF4azoIJuntmCQUSr8paHoWdpQYPMwjcRg+aGAGomHCzM3JALquiw==
X-Received: by 2002:a17:902:a70e:b0:186:7fdd:888b with SMTP id w14-20020a170902a70e00b001867fdd888bmr30392545plq.47.1666856822687;
        Thu, 27 Oct 2022 00:47:02 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:99d6:ae15:f9aa:1819])
        by smtp.gmail.com with ESMTPSA id i4-20020a056a00004400b0056ba02feda1sm611386pfk.94.2022.10.27.00.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 00:47:02 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] arm64: dts: qcom: sc7280: fix codec reset line polarity for CRD 1.0/2.0
Date:   Thu, 27 Oct 2022 00:46:51 -0700
Message-Id: <20221027074652.1044235-5-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221027074652.1044235-1-dmitry.torokhov@gmail.com>
References: <20221027074652.1044235-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver for the codec, when resetting the chip, first drives the line
low, and then high. This means that the line is active low. Change the
annotation in the DTS accordingly.

Fixes: f8b4eb64f200 ("arm64: dts: qcom: sc7280: Add wcd9385 codec node for CRD 1.0/2.0 and IDP boards")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 4884647a8a95..1ac7c091e03f 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -34,7 +34,7 @@ wcd9385: audio-codec-1 {
 		pinctrl-0 = <&wcd_reset_n>;
 		pinctrl-1 = <&wcd_reset_n_sleep>;
 
-		reset-gpios = <&tlmm 83 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&tlmm 83 GPIO_ACTIVE_LOW>;
 
 		qcom,rx-device = <&wcd_rx>;
 		qcom,tx-device = <&wcd_tx>;
-- 
2.38.0.135.g90850a2211-goog

