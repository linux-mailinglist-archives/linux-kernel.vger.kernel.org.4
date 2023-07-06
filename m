Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75640749C38
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjGFMol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjGFMoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:44:32 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A111996;
        Thu,  6 Jul 2023 05:43:59 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-98df3dea907so82666566b.3;
        Thu, 06 Jul 2023 05:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688647432; x=1691239432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flUpj1SL0IxzkEf+wAIgzyyLAEa29IzZhs+iHwXJtAI=;
        b=Dt0Pc/Wh6L50oeuVSkYferwE8MxWg78g9MPMvgZ8qPou6i0gaNdfGqu13cWOVWefya
         vT7ZKHC9vwWVWJmS7syaN9+6qlIRrMaFTPVLdvSwHAxDjrqZLFD0+wQVygVwEYevYCDQ
         9Hwjd7GqtH9a0c/nb7Q9kjVbxoPxKTOocaxq6kmJlIBGLdJcozryEk8h4r/w78IBGC1Z
         OXZFKuWgC2MoxWbRseP8FZQE8Ck8QDEC18TtIR65Q6fWovBczpP89o0CyBseSEy7icbD
         uo/J1qub2U1ACQrnouaPR+vINLU+v21PgJL9bbxNBEDkceaxwU8gNcjwDgguQwwQTN7+
         EgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688647432; x=1691239432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flUpj1SL0IxzkEf+wAIgzyyLAEa29IzZhs+iHwXJtAI=;
        b=IPLjmhZpORrfY8oE/gMPLgEIOC0bpxn+cy1dNTDzw05WXZN3+hZ8a01Cxkr0R0JwfK
         3KFk05c999iBJMUJlZreBLQcQGj3kSdx42RJHTc+zuIfhzzJ8rx4Erl1aQMvZvbSZ6DG
         oIaMR2Xxr4Z/GSdxxwXf4vy027iFKz76rQF7PpIaJYTVYVYm4NPim6nA8ckd5APhd02E
         ExahlSdKbX0XwR23RZ1P5tV1IpJjo9vml2RcwUil7qBgCTHaI9tj/n3qWJw+ZblsUgoY
         NKuIj2teyGsMcy4AFySVokEmMkSVgRg8bMSxiCqVdEDpt2cb9V5SKI86lrCMrTWpoQsO
         WpWw==
X-Gm-Message-State: ABy/qLYrvY+wbhRjtFYN+XEsrcfEqAKsucrhfSUfVUu45LKdxsFzxkzc
        lxJpVatqkOD9yabgXye1Sgi94e0K3rP0wA==
X-Google-Smtp-Source: APBJJlEw6L1FxYH1BSPRmdIw45CdWdYwn2wBSFJahG6iqKqyaL3El1h7gHyq5sH/ONb8UTtVUqdgVA==
X-Received: by 2002:a17:906:8052:b0:992:9d41:875b with SMTP id x18-20020a170906805200b009929d41875bmr1254648ejw.32.1688647432412;
        Thu, 06 Jul 2023 05:43:52 -0700 (PDT)
Received: from david-ryuzu.fritz.box (ipbcc3a9b0.dynamic.kabel-deutschland.de. [188.195.169.176])
        by smtp.googlemail.com with ESMTPSA id w14-20020a170906b18e00b00992ca779f42sm775915ejy.97.2023.07.06.05.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 05:43:52 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        David Wronek <davidwronek@gmail.com>
Subject: [PATCH v2 2/7] dt-bindings: arm: qcom,ids: Add SoC ID for SM7125
Date:   Thu,  6 Jul 2023 14:40:21 +0200
Message-ID: <20230706124339.134272-3-davidwronek@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706124339.134272-1-davidwronek@gmail.com>
References: <20230706124339.134272-1-davidwronek@gmail.com>
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

Add the SoC ID for Qualcomm SM7125.

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

