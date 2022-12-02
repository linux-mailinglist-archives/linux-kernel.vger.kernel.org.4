Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E876B63FDDE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 02:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbiLBB5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 20:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiLBB5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 20:57:19 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5B1D3DF1;
        Thu,  1 Dec 2022 17:57:18 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id h33so3203459pgm.9;
        Thu, 01 Dec 2022 17:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Scs2v36zL9JQf1vKDUPFcdw/WWq3/M7XE6jlqN/Oj18=;
        b=Udkmzq8utbgxd4mKpvm+ZVSy3l925Ad68fE6qQJcjQ9qayaPyC0qCcBwVJYfKDyN0b
         y/UceCoTS9L1ggPPqdhuvA52LlYlHljmk5AItm9rqkZayukVV3L3vZipfbGzEIotP014
         PSiZdT2ZADBnV35gsuQlYz4GjR9wUAx59N+HhFF2iSIE4MoBOdrVQX7H0PFBIXWODCNj
         VZ5VJt/rs8+WjPAP1R9+WTSd+xAHD6Bs3YL3H1OOGP8k01Cjp4W6GW5+3pwu8WFdXTRp
         zEWWf2oCiBCAV36A1FlKb5VOEbSq2EfP4Z0vve/MYM8X0QjksZVYRvMm8HyLSu5i9c+/
         ZVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Scs2v36zL9JQf1vKDUPFcdw/WWq3/M7XE6jlqN/Oj18=;
        b=h9Hu8CntQ2rZRDMOg3Cfvue0W4yyiGQZuSB51SYFEH9BxU8iBJRX5+8uEsXsvKn59h
         StT4atHVsRNIMd8wA593PIpQ9AQK4nbOubC8EkjaXLBHy3jRIZHp7fZTo9umeBb6ncYh
         QT3rc8Y9tH2eSY1ixGzaHDNg3OWtTbwL6LndVpzx39aZ2nfJu3QpstRKcoouN+J+t3tO
         34jR2swA4QvjXCHyhQq9RBdrR2beMmvr1lxELQWwo2rf+gy+DojOcI62GpdEanXWRI/Q
         7PsmXllWDVaCy/yfF7/9585lTTBj2v+OWs9uJ6Agm3XK/fUQ0WNvvJsByIeQCoSQcPw6
         TYyg==
X-Gm-Message-State: ANoB5pl0YJGlaN+U5SD293OjA80KCjkAxsvJqcsqN3nCBdlRLXq0W/rs
        RkqagNvdRWB3N9X9RV6Bv/2Dr4NFaxs=
X-Google-Smtp-Source: AA0mqf7AN1sBOdjyPbtDzrwnxuBG6zYgXm7QyThqf4n/YrRBwJJdoPX/AFJkflyzmghKcgsyUGE0Bg==
X-Received: by 2002:a65:45c5:0:b0:46e:c7be:16fc with SMTP id m5-20020a6545c5000000b0046ec7be16fcmr41810686pgr.462.1669946237568;
        Thu, 01 Dec 2022 17:57:17 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2d4-7fe5-859f-c348-0205-f26e.emome-ip6.hinet.net. [2001:b400:e2d4:7fe5:859f:c348:205:f26e])
        by smtp.gmail.com with ESMTPSA id p9-20020a170902e74900b0018948b0082asm4365465plf.140.2022.12.01.17.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 17:57:16 -0800 (PST)
From:   Owen Yang <ecs.taipeikernel@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Gavin Lee <gavin.lee@ecs.com.tw>,
        Stephen Boyd <swboyd@chromium.org>,
        Abner Yen <abner.yen@ecs.com.tw>,
        Matthias Kaehlcke <mka@google.com>, Harvey <hunge@google.com>,
        Bob Moragues <moragues@google.com>,
        Owen Yang <ecs.taipeikernel@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v13 1/2] dt-bindings: arm: qcom: Add zombie
Date:   Fri,  2 Dec 2022 09:57:02 +0800
Message-Id: <20221202095048.v13.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
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

Changes in v13:
- None.

Changes in v12:
- None.

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

