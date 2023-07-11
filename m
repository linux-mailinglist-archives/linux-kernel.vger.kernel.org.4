Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F340774EEF4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjGKMc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjGKMcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:32:21 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78767100
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:31:53 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbf1b82d9cso58863955e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689078660; x=1691670660;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F+HpM+HCeMpSefmXK16C9YcJaoau/C3nDGJIkf8i7cM=;
        b=ul0ok/tUjWblWmfDJyReJiMIRQ1ASPlslx/+OFGEndbIsdI6qoghJHW3uq3VjT7ivG
         JSRc4Jp+rHawPfoElLxK9MFg2cHlU2P9JL1c/JUrwUWiO5QQmQOlJPYX01WcoH0qg/ag
         tjUNTZNm2MQUCyCMM6rMp2bjC+Zd99ntL8WcYDM+UluhSKF5v/2fmaYuopaHlKyD9F6a
         t9DTEd+hzlTLAemviU5FVteR1BldVq6+zdQQojlVQonNulCWHmqH8bQqvuyFJu/VClDm
         9Cye8wM7NVIrQhPxI8Jh+tegg2IcYSI1zMZ45nzLynPgafLNKCR1h6T8PWjH/e6HaeNv
         qfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689078660; x=1691670660;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+HpM+HCeMpSefmXK16C9YcJaoau/C3nDGJIkf8i7cM=;
        b=V9NulMMHoNk8ngANogbiNugYNrbJtD+4qiiAfX2z05P+GRRRAn3Cu6F5doVytfyF0O
         scFdFoI/VhrzGvlYpZV96JcSucNUYvk7Lla50csUKmY4Xe2YY+EAXJUMOpcvaSlyd2Js
         Ldo/qAuXpUvLZDHAqQzZDSQ58RUYbd4PAVEzm0FOF5+BwVUZOKiIS5ziXAFPS2oEtjWn
         mJuy+mLM0KYJ6MmaNZr1kczAfuF9NkXA9+UObyjN9fdHf4FLqjqt4rtGmBgu6eWr37rd
         r90ESyyLLchuIxsqE0OZPFJOGqIgHRsCkqm2vTBxBi5M8Ft4js1eDhPyZsVJf55CmA/w
         TxKw==
X-Gm-Message-State: ABy/qLZMQOPA0VTn5MS1+SSv2ZjMaz2GHLy3EgvdSq8q+jpeTXAA5GDn
        4+Mmmy71qRmMl71GL5wOlymzrJ0j0c7UyT0c3S5p2g==
X-Google-Smtp-Source: APBJJlEQupFlCuRT7R8SseW9Y2wdzGnv9aFcooCUZ4hnjXBLeIT4wGij8HdFQ5+TYBuRWwliDkKCtg==
X-Received: by 2002:a05:651c:211:b0:2b6:da64:321 with SMTP id y17-20020a05651c021100b002b6da640321mr12309325ljn.45.1689077964399;
        Tue, 11 Jul 2023 05:19:24 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:19:24 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:43 +0200
Subject: [PATCH 44/53] arm64: dts: qcom: sm8250: add qcom,bcm-voter-idx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-44-b223bd2ac8dd@linaro.org>
References: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
In-Reply-To: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=999;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ebMrQjKmDTgpWjkINs/Atf2PQmSY9dkU3TIUUbwBPoQ=;
 b=2OP9+lUs6pA/83Z+vE3WXtNyqzqPquNrM8XqK7DknAXmP1+1Lj4UX4sVKsct2f4C6r3LDSIVi
 Etb83M3eBHhC59EcuJBb6ILh6z46QOGZc8myu/aS85weLkvbSCKm7x7
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To improve the representation and ease handling, identify each BCM voter

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index e03007e23e91..29994aae897c 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/clock/qcom,sm8250-lpass-audiocc.h>
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sm8250.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
@@ -5674,6 +5675,7 @@ rpmhpd_opp_turbo_l1: opp10 {
 
 			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
+				qcom,bcm-voter-idx = <ICC_BCM_VOTER_APPS>;
 			};
 		};
 

-- 
2.41.0

