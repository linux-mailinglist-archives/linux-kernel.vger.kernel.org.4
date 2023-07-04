Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907B174770C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjGDQm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjGDQmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:42:13 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF53210F5;
        Tue,  4 Jul 2023 09:42:11 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b6adef5c22so89906741fa.3;
        Tue, 04 Jul 2023 09:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688488929; x=1691080929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1NPQO00RUvISCaGkH2p3FM3CNMfuB7h4Q8LwRfFEJw=;
        b=lDIAAiA3BLp1hltTyOfOxPdCVmgnDofgCD/aIDcYnz3YoR9RAjvz8AoPHTt7eCJXNq
         vKW6Xw/JgB8JwFhTdaXZo7Z7Wb1w9rhUhJIDrDOwasqEfFQmOyCWirVscu2m4e0w6UN8
         MZpGQjnGdmPSEDokfSy3pP1xk3ejDrS7nsdjbqjvRoPDVPSoXbblln0BZUfQkdrpNYCr
         UWt78eo+QwZR1SyFdmJNhrEjZxdP3aTip6rrpU4/5N+z9TXDL/1A+g1EeRI5a4YtySjU
         8adGZVROMY0LkGaYb91GfMRqwupA/sFKFiXY/Uy5hRp4IeBuaRZFquJ7nZ3vkLUKEsZ6
         3h3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688488929; x=1691080929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1NPQO00RUvISCaGkH2p3FM3CNMfuB7h4Q8LwRfFEJw=;
        b=cCCSILPCuF54Tl6fPnSN3dvsw1opBfvyRHxUnCmH4zZcbI7oM4BxEe/EvBpagkHdfi
         hIRhKoDb8Gbpb5WjtCgS/r5vXSn/ZxfSlnKWK4GYhDNQPLC9YYD0SkiUqsjWevao9n8z
         XsMKqjVPHmxJUEZbviFWAOY+ZKYffPTFMIbQ4I5nsiKKW22M7s8iRYXCHfAyTCuOs6vx
         D9YavLvRbl+GxKX3Vn5uAtq5hHRjlxgyH7W6yT7SVj58Kij22B+WfVBVU6ppGbmeEtjR
         TfOTDWEKpd3lhxUsm9nLt+fYgbv5dcasbIY5kI3YW6+Z16ZaqrusM9i3K/ZQEkx7tcDm
         p9Dg==
X-Gm-Message-State: ABy/qLZKb5BevA03eXQE3Sl8wd3+r5VwX8iTuoiBvqP9ulah+HtHK2+y
        bdJAB7Dtc+bdMZvwIW9MYpYcLJSPNjvFx7lX
X-Google-Smtp-Source: APBJJlFURqjBvJzRH1SX5FGs3z/RLlJBfF1I4//xlj5p9fhahlmFRbC5tiQ/0FGwyMMBcMKnBZLDTA==
X-Received: by 2002:a2e:86d1:0:b0:2b5:7f12:413f with SMTP id n17-20020a2e86d1000000b002b57f12413fmr10162964ljj.7.1688488929396;
        Tue, 04 Jul 2023 09:42:09 -0700 (PDT)
Received: from david-ryuzu.fritz.box ([188.195.169.176])
        by smtp.googlemail.com with ESMTPSA id u15-20020a2e2e0f000000b002b6eb5db863sm1181920lju.43.2023.07.04.09.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 09:42:09 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        map220v <map220v300@gmail.com>,
        David Wronek <davidwronek@gmail.com>
Subject: [PATCH 1/7] dt-bindings: arm: qcom,ids: Add SoC ID for SM7125
Date:   Tue,  4 Jul 2023 18:31:54 +0200
Message-ID: <20230704163848.169853-3-davidwronek@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230704163848.169853-2-davidwronek@gmail.com>
References: <20230704163848.169853-2-davidwronek@gmail.com>
MIME-Version: 1.0
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

From: map220v <map220v300@gmail.com>

Add the SoC ID for Qualcomm SM7125.

Signed-off-by: map220v <map220v300@gmail.com>
Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 include/dt-bindings/arm/qcom,ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index bcbe9ee2cdaf..6a8dd2e42b24 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -215,6 +215,7 @@
 #define QCOM_ID_SDA429W			437
 #define QCOM_ID_SM8350			439
 #define QCOM_ID_QCM2290			441
+#define QCOM_ID_SM7125			443
 #define QCOM_ID_SM6115			444
 #define QCOM_ID_IPQ5010			446
 #define QCOM_ID_IPQ5018			447
-- 
2.41.0

