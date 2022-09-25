Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3995E9283
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 13:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbiIYLHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 07:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiIYLGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 07:06:32 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE34326C3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 04:06:25 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u18so6755285lfo.8
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 04:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Ltd+pnwzPyeoA6eImt7eQVAAefud/sfm9oMKcojNkgE=;
        b=tlLlTMpTqrKh2WFQxL0HxNPtdRO4n/J/OM+kRemabxcSv9/uTCsvSxp/EsJEuEEloT
         7aHKKjmatBWss8LjUYe9lwWMzBLV2357i+qCsMXVsSwM654tuDXcXlJWUw/hc+8qkdos
         U2Jw8NbRsMO6KPt2y7qXPnge9OFyvK994HDQX+bhYkgiKvdisDeBqlbMdjxIhnZ5wunm
         nAAcofJ4QOWGr+Uodn24B2o2RNDCofxT4M9XN+KI1XNU4Ez8Lw/7+UwtJetT+9bWsMWX
         LYQ/UY5peaR+fFehrp+0pNULIY8Si8LXuwuewdy61wcVKjTxzCQUGr/eraIK+v92qASn
         LmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Ltd+pnwzPyeoA6eImt7eQVAAefud/sfm9oMKcojNkgE=;
        b=Im+5RIUUd+RxVQ9omTfGg8InUSNAEt7Wtzzpys9W2pfSkEIBk2T4e2K5+vGheyI3tg
         lxjMxMQo+T5Dv/ionODeIc1WqWVzxBJdE0f5gzWBJ0vR29e1tbWsLXCrA7kXV/yV7PJx
         mp+dHYE1TCrSrA0j7/s4Db3uDVCLlKA841BA8xArGR7hWQC1K9aczPIz8Jy5SD6Vb5AP
         Q3UEX5uEs+dNIiVWjFWGq4wStGvZEAXpbaG08cTK5Voa7ERfnd9pUUcUsm9gYuQPYbrs
         rUP/Sdz2qHyyYeLRlu1tAtalzozd2s6qlXu3fBHgg6pQ7KqOClt6nNWZabKRVOeJu4Jv
         ougQ==
X-Gm-Message-State: ACrzQf3WFl1fnpGxIqL1PhoZVrRzbHThwWD9RJ2gCvvVPSZdzUlYEBpD
        v656LR9Js36qu61K1IO5wwIJ7A==
X-Google-Smtp-Source: AMsMyM57t13wYv+t4apXeTo8L58bPl0in9J6WQ8xwsyPKvSKngP7eSxTQLlL2f2v+koI5KRxQNjDdQ==
X-Received: by 2002:a05:6512:3403:b0:48c:9727:50b0 with SMTP id i3-20020a056512340300b0048c972750b0mr6404437lfr.309.1664103983645;
        Sun, 25 Sep 2022 04:06:23 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u19-20020ac258d3000000b00492dadd8143sm2177265lfo.168.2022.09.25.04.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 04:06:23 -0700 (PDT)
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
Subject: [PATCH 09/15] arm64: dts: qcom: sm6125-sony-xperia: add missing SD CD GPIO functions
Date:   Sun, 25 Sep 2022 13:06:02 +0200
Message-Id: <20220925110608.145728-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220925110608.145728-1-krzysztof.kozlowski@linaro.org>
References: <20220925110608.145728-1-krzysztof.kozlowski@linaro.org>
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

Add default GPIO function to SD card detect pins on SM6125 Sony Xperia,
as required by bindings:

  qcom/sm6125-sony-xperia-seine-pdx201.dtb: pinctrl@500000: sdc2-off-state: 'oneOf' conditional failed, one must be fixed:
    'pins' is a required property
    'function' is a required property
    'clk-pins', 'cmd-pins', 'data-pins', 'sd-cd-pins' do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
index 6a8b88cc4385..9af4b76fa6d7 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
+++ b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
@@ -89,6 +89,7 @@ &hsusb_phy1 {
 &sdc2_off_state {
 	sd-cd-pins {
 		pins = "gpio98";
+		function = "gpio";
 		drive-strength = <2>;
 		bias-disable;
 	};
@@ -97,6 +98,7 @@ sd-cd-pins {
 &sdc2_on_state {
 	sd-cd-pins {
 		pins = "gpio98";
+		function = "gpio";
 		drive-strength = <2>;
 		bias-pull-up;
 	};
-- 
2.34.1

