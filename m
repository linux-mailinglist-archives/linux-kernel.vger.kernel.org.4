Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E62A63E764
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 02:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiLAB7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 20:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLAB7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 20:59:45 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD4956ECE;
        Wed, 30 Nov 2022 17:59:44 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id h33so378698pgm.9;
        Wed, 30 Nov 2022 17:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/vOdaMjZAEF+5Q09MuuoEJVXEscHbW6csGYAcl0/ZY=;
        b=LDbf3NuN5DzLgVQSDCdKyngvV1JobgcsAlYomrVqy51zw1h4EOd7uT5biPsnZerS6U
         jgCu6FdXJpq9HZIFfBy+tzsmT9JMj/xV+N/z80wWQPU/25Bjub3xYyD6frqzye/+i40o
         QMy6uby+szkkEEJMY8GDTJ3qC4CJR/hRUioewXDslLURwGn08UJ8G5S9iQMw55H1cFS6
         KlWDFyb0WQFLYFKVVpmlpehVQYdk+3ZAzDti9g4fNjmiYbJ74nDjF4N+c21Ans7VgsYu
         RTxihVRzIUZ9Qrj2+QpnJRfqVBQ2/MgGi7nLrdQ5mivetYFqfWnG7F1p1YgpL9HPKfdw
         /NbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/vOdaMjZAEF+5Q09MuuoEJVXEscHbW6csGYAcl0/ZY=;
        b=z1Kr2Yjw4PJIeNuFiWv3HOnrtkHYVbr4s1JxzZFs7yotmaif2SMtd0WzXLVIuqVhyO
         79Q6tlUvfD/aijZzaIm7IS2O8UwA3mI01vhkTKfuWPxgyhM4CZS5ladiQmFe0u4q1s7a
         qIk1ssU1yK/3gKuWIGqsl6S5d/EJSIm58+jNLuQnQZU32eXnWGPqWw1UEqkrKJqwv6xJ
         uqUUTrImQQEdE0pFb+1SK6dRcoVfiJ+qlihfUwiJhhAhAW5pA0u2aGyM1R0dri5eQ3uI
         XtGbO5XvV2rd51lh6US6qdatso5aQzlLfWhO9FTJgx7emuoVNeYCREld8PJcZqicL+L0
         G3Ew==
X-Gm-Message-State: ANoB5plE+2VVJZ+VqbddiBGyRSOSneAFYvBLFMIloIXT+31QCtSsR0hO
        exgCmX7N4BsyVlVmV1OXflFj7degDcA=
X-Google-Smtp-Source: AA0mqf5SigCzPhfMurTk/v00E+QxxsLBlszHyG9DhbhgIdz1WBRw6oTYJuW/RHqHf/Eo6+x3fEkqWw==
X-Received: by 2002:aa7:9245:0:b0:571:3fb3:9b5f with SMTP id 5-20020aa79245000000b005713fb39b5fmr65452188pfp.86.1669859983763;
        Wed, 30 Nov 2022 17:59:43 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2d4-7fe5-a80b-9fee-51f7-4bb8.emome-ip6.hinet.net. [2001:b400:e2d4:7fe5:a80b:9fee:51f7:4bb8])
        by smtp.gmail.com with ESMTPSA id x12-20020a1709029a4c00b00186a2dd3ffdsm2174398plv.15.2022.11.30.17.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 17:59:43 -0800 (PST)
From:   Owen Yang <ecs.taipeikernel@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bob Moragues <moragues@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Abner Yen <abner.yen@ecs.com.tw>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@google.com>,
        Gavin Lee <gavin.lee@ecs.com.tw>, Harvey <hunge@google.com>,
        Owen Yang <ecs.taipeikernel@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v11 1/2] dt-bindings: arm: qcom: Add zombie
Date:   Thu,  1 Dec 2022 09:59:33 +0800
Message-Id: <20221201095900.v11.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entries in the device tree binding for sc7280-zombie.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
---

Changes in v11:
- Put all tags togather as As requested by Douglas.

Changes in v10:
- Add "Reviewed-by" tags in this patch log.
- Fixed history log list.

Changes in v9:
- Fixed version number (v7 and v8 were erroneously posted as v6)

Changes in v8:
- Correct commit log. Use "entries" instead of "an entry". As requested by Krzysztof, Matthias and Douglas.

Changes in v7:
- None.

Changes in v6:
- None.

Changes in v5:
- None.

Changes in v4:
- None.

Changes in v3:
- None.

Changes in v2:
- Fixed patch order.

 Documentation/devicetree/bindings/arm/qcom.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 463509f0f23a..7ec6240311db 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -655,6 +655,16 @@ properties:
           - const: google,villager-sku512
           - const: qcom,sc7280
 
+      - description: Google Zombie (newest rev)
+        items:
+          - const: google,zombie
+          - const: qcom,sc7280
+
+      - description: Google Zombie with LTE (newest rev)
+        items:
+          - const: google,zombie-sku512
+          - const: qcom,sc7280
+
       - items:
           - enum:
               - lenovo,flex-5g
-- 
2.17.1

