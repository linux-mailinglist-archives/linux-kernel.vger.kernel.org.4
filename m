Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5875D67CDFC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjAZOZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjAZOYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:24:31 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAE770D62;
        Thu, 26 Jan 2023 06:23:47 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id m7-20020a17090a71c700b0022c0c070f2eso4703655pjs.4;
        Thu, 26 Jan 2023 06:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NwoVoQA2ou9ZRpL3U7Nv6BoSj96XgNeTjb66AejG9oo=;
        b=C7mY4qLZs14JoAswZVkEF5r2W0VbCtBoT8WDTR4NsktGZ2KsL0JQTyyYDzhqGqeMXl
         CTJFwX6+QXFzQnQNrGrfhEIuvurhS+zkieW2urHA0lEJA5OltK2SCBzcafKxohIhd20Z
         pRbf5WJuq9Of03ouclf7XM/YdZyarwNVSD1Sy/xyXGD450I/WVDpPCyH9b4vE7vscLUV
         aIHDbv1/qiyp0frl7XOgmG+2bSKPLlyJZDCdS3IXgkerJNziKNHd1E5+pUDLZDM+EV96
         XLLBqGKxLd8kAJqcWOce2yCMmJF7Iqn9bmiNMFMtvlUNX1tC/401WHgPlgA+FOS81V8E
         ujqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NwoVoQA2ou9ZRpL3U7Nv6BoSj96XgNeTjb66AejG9oo=;
        b=oRsz5tENoCfnQtDkJVjQPuHenVFPBwwOGmJNKV7RWwI7UVzlVuWYTtlIx8DJib/JGI
         tfhiDnOKnTUhoCGfOcN051obygfBsPaJLIDXnjW43vNLPfzM4ghjXa2jOAZz0pLm57N0
         N4Mq9ouLWszn3O/bl6NRfdeL2SV8uPX6nV5/hDMiNJJAuBQyi50pupJlLwaXPXfADCDm
         tljvJRAvIfAh+GtP33JnivusNtkQHNslEsm/HcCeFVygCiRVFf0rsKaYxk8YddeKJtxO
         JBJ8cDab4YJnMLy2IeHEHm+b8hofN1vAeqGguyly0NyaM06nRLQ3B8j/Jv9jmzDfW9gR
         fKWQ==
X-Gm-Message-State: AFqh2kr6bGbzGNp/4PJa27LTtpv7lYjbeHrnYju7r7ajHPoF2krIoLYr
        gxXegvpXSzWId842NnRW1/g=
X-Google-Smtp-Source: AMrXdXu1eJSJ4Kajr/piBp62I0tu+/NNq031brXbWC2VMZMEa2QlZId8ebXZgHyk3kNX83hMsvciyg==
X-Received: by 2002:a17:902:eb44:b0:189:377c:9ab with SMTP id i4-20020a170902eb4400b00189377c09abmr36285630pli.51.1674743024748;
        Thu, 26 Jan 2023 06:23:44 -0800 (PST)
Received: from localhost.localdomain (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id c8-20020a170902d48800b001960706141fsm1047268plg.149.2023.01.26.06.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 06:23:44 -0800 (PST)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Jianhua Lu <lujianhua000@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: arm: qcom: Add Xiaomi Mi Pad 5 Pro (xiaomi-elish)
Date:   Thu, 26 Jan 2023 22:23:33 +0800
Message-Id: <20230126142334.8080-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible for Xiaomi Mi Pad 5 Pro.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v3:
  - Pick up Krzysztof's A-b

Changes in v2:
  - Move compatible "xiaomi-elish" down.

 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 22553637c519..398ff26e6e0e 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -875,6 +875,7 @@ properties:
               - qcom,sm8250-mtp
               - sony,pdx203-generic
               - sony,pdx206-generic
+              - xiaomi,elish
           - const: qcom,sm8250
 
       - items:
-- 
2.39.1

