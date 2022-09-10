Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51485B46C2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 16:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiIJOcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 10:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiIJOc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 10:32:29 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0593C15B;
        Sat, 10 Sep 2022 07:32:26 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e16so7846379wrx.7;
        Sat, 10 Sep 2022 07:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ri5En/fDJnZs9/fgpIxN7nIJmyjfgpQ1FdIzzVX5B3I=;
        b=GDmsmw1nMyyrhBDISv4WWbTZCjtK0xybNcqoP3gO8yYgIzH5fd/E1CgqTCsaplnVAv
         KcwOL0qju7hgMGKOFTpff9HDIkfnYOl5ty0Kc4dFV8KD6YA3KiK5DAR4EJ8OhjAiuZmz
         L0IIZwHajCuwIXt7uzuSiflExeX68kalvhdz1IN6Euw0mE7xNV3i4gH7WQl0Z4x3BRRh
         /HlztyT/ZnELNZRLcOoSJHS+HzgMygmG3ueSmS/QOQGAmY4L+4Vi70akS85+26hMu7dd
         /e4rbRmUf4YOoqcETGzGBN4k+isXEDwHJ32soLlc8R2oV+ILymKf4Y8p5/rUI5JOl9eO
         ZBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ri5En/fDJnZs9/fgpIxN7nIJmyjfgpQ1FdIzzVX5B3I=;
        b=Jg+djW7EfRfLMhvqjd9ab68fpdaXEiRYwUPGYnZdUcoBNCO+R+Tl68IalVwXc0F1Ug
         r2X73UqkuaUj/c4Rp1r4hUst+q8KtnCeSaW8cEHWLx6GsSfVE3WmSx80AeGR8ilemlYY
         cBBavBpyIkL3eN55LI6ueVo6woS3ABlqyBtJbboVxpYVfuhvG9Gf6b0vyHAH133kLMzJ
         dSkTmaSZTzclF6ZbbSQnn4eHe4bWCeR8IgY1G9RDb1gd9mZOv30kxzLvUSVGmQ66t0DA
         GOSLcVzeNVTPQMF4IgfdfSfxgqyKVzvbq124LV0lcyMThUOVXtuNTqth2ul6nq9RJM63
         YV+Q==
X-Gm-Message-State: ACgBeo134jdRz2Xfvdl/WNlnnf9DmEajsXE2MjFF5TwzWwsA4ULgQ4ha
        jGuSwHph+4XCvqhJIq/WrXA=
X-Google-Smtp-Source: AA6agR4zXW62zIwj6CaLhiyKEF4o4Y6C1vTVmUD3oqNKkWRtMjO1EAt931MwWTCnR1Uo38nyPfwoAw==
X-Received: by 2002:a5d:5551:0:b0:228:d70a:102e with SMTP id g17-20020a5d5551000000b00228d70a102emr10390924wrw.446.1662820345380;
        Sat, 10 Sep 2022 07:32:25 -0700 (PDT)
Received: from localhost ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id i13-20020a05600c354d00b003a5c1e916c8sm4951251wmq.1.2022.09.10.07.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 07:32:25 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/9] dt-bindings: mmc: sdhci-msm: Add pinctrl-1 property
Date:   Sat, 10 Sep 2022 17:32:09 +0300
Message-Id: <20220910143213.477261-6-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220910143213.477261-1-iskren.chernev@gmail.com>
References: <20220910143213.477261-1-iskren.chernev@gmail.com>
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

Most mmc blocks contain two pinctrls, default and sleep. But then
dt-schema complains about pinctrl-1 not being defined.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index a792fa5574a0..775476d7f9f0 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -97,6 +97,10 @@ properties:
     description:
       Should specify pin control groups used for this controller.
 
+  pinctrl-1:
+    description:
+      Should specify sleep pin control groups used for this controller.
+
   resets:
     maxItems: 1
 
-- 
2.37.2

