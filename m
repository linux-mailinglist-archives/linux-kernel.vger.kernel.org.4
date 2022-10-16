Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746B1600240
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 19:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiJPRXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 13:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiJPRWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 13:22:47 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8B33337F
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:22:40 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a5so5449117qkl.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyDtIBZ/b6jNbw8Fg/X93utCMqZp3mIZumdRr4BC1ys=;
        b=qpl24SL9tJRLmTKIB1n8Tf5pdZGCVxAQ30xfsv4UF5qf3eBGmIYr1oZ8/leslKm++X
         eawi75xtXRRzrGxYABY85K0ovjtWPAg9j6nevHoto6wFie7QocSjN8qxZzS9+mJ1P4+1
         afgYcNUBGkeV2EaCMnc+UpqcCpm8vbW09sH2sql1fHxgrvpC+xi+oMtCREAfBmR3suVZ
         tt9AAuNIa8J75m6ClTbLydjyiaoigByqde5BlHk2kYNtjc65uVGJl0TjGnnSNdMPIkg2
         Uae7xNcUMlGJstGaUvX6dD35ebXGokp6Vq1NU1fqdzaJUBx9uk+ueIqijGZlHraDnouX
         DtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TyDtIBZ/b6jNbw8Fg/X93utCMqZp3mIZumdRr4BC1ys=;
        b=w2NHQ1K094w+oKA0rlLyHmIoJY7qluVYPFaeRnUoz3/KngsrvZRdi2zSGM/YERQ7mZ
         u4mU7yFNhTPyy0+GTkWZ0GzlnMBFV31jl/AledbJA+QQyalPf+6ph6qnimyyk2J4ZHhl
         Nc0uktP4XsFfqqbwSL6GhLceLWGCKOyt5b3UKFeaGqYHPoaNESeIU8jPxWV3QB6CJQWd
         GP5JdjMPK5JhXZeYpbsDCGV5/gPyOeFEfM3sZyWvVV9Zt+c0P26CsTAo34DbauT/DHFB
         Xs1BtwLPoRXpJ+P3zrVwn+1qXC8TZMoF2UmRH2UUdKL+16diRkkJzuhkH1d4KVmnA+uk
         fqXA==
X-Gm-Message-State: ACrzQf2lOxk4IKzXHq1zB7W+L56T+4PWb7aQGJAHs+54G2vs/ZsMNUq1
        QW2o4r3u2sbnKfANqGY8y/C9nA==
X-Google-Smtp-Source: AMsMyM5ONtMy740dASwtIVTLPQXYt05nbMDYbhD5rSpJvZpGq0cplnKFb6Z2xHReBTxz46Vl36GWeA==
X-Received: by 2002:a05:620a:2a0b:b0:6ed:6af3:74cd with SMTP id o11-20020a05620a2a0b00b006ed6af374cdmr5013031qkp.368.1665940959527;
        Sun, 16 Oct 2022 10:22:39 -0700 (PDT)
Received: from krzk-bin.hsd1.pa.comcast.net ([2601:42:0:3450:9b13:d679:7b5b:6921])
        by smtp.gmail.com with ESMTPSA id r5-20020ac87945000000b003431446588fsm6051008qtt.5.2022.10.16.10.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 10:22:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 06/17] arm64: dts: qcom: sc7280-idp-ec-h1: add missing QUP GPIO functions
Date:   Sun, 16 Oct 2022 13:22:01 -0400
Message-Id: <20221016172212.49105-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221016172212.49105-1-krzysztof.kozlowski@linaro.org>
References: <20221016172212.49105-1-krzysztof.kozlowski@linaro.org>
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

Add default GPIO function to SPI10 and SPI14 chip-select pins on SC7280
IDP, as required by bindings.

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi
index b35f3738933c..3cfeb118d379 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi
@@ -95,11 +95,13 @@ h1_ap_int_odl: h1-ap-int-odl-state {
 
 	qup_spi10_cs_gpio_init_high: qup-spi10-cs-gpio-init-high-state {
 		pins = "gpio43";
+		function = "gpio";
 		output-high;
 	};
 
 	qup_spi14_cs_gpio_init_high: qup-spi14-cs-gpio-init-high-state {
 		pins = "gpio59";
+		function = "gpio";
 		output-high;
 	};
 };
-- 
2.34.1

