Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A58637156
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 04:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiKXD5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 22:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiKXD5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 22:57:41 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B41EE24;
        Wed, 23 Nov 2022 19:57:38 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id b21so372237plc.9;
        Wed, 23 Nov 2022 19:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGwvbVKMm9h/sFfV9Q2uLqdpGgHfx9ic4niLttdCeaU=;
        b=RzYAZWCSvx9Rslffu5+s2/dhpwBAYmm+HJq4YQ8L4VhQvXTljN6MYG7rQ/Tr+5UaqP
         Z0xFSqj9+N/Xd++SCFsnY/nWAIqtwLz5+nZNKoKtcC4E+dLYoYnpFVzIbJnmJZfVVVWJ
         S/FPqn51M+oDUXBvB9T9AOzkDo6ScCvOAGip2H0mLD9AzQsLtMFZ+xqD8soqfIAEUw+9
         Oq6WM2m4NPZCxMoJkgrv6OK3S02ijrgFXK0Le7Yvqj+IgOc2jJrNKwPFmudldE1dsXhs
         b4ExMTkA48xTWMKarQezHiHKx00XJVGnVWFhVmWufUUDeejjn2Du2uFK+pAhNfkRl9Ns
         ypgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGwvbVKMm9h/sFfV9Q2uLqdpGgHfx9ic4niLttdCeaU=;
        b=uPj8WvZTErJ+0Yef8VtAPlJ7VPBVXTnyjGceAD/lO3CZPfJ7H8NgJcMjajx8fRvolv
         5Lck9OI8uiAgsZS38n9eHxJGsDiPHF+xuyvTYxvLAql2nfuLesyYAszfmbz0F/T2YVRQ
         B/47FQs5d7CyWdkiMB1bX6JI/XQqxlFInYIf30cwjXuovFsgpR1zi8CqzJO97iSWLPGx
         P10560maHN9b5J3nXh6fg40CJyxFlC6yc0TPwCEuiES+3pxLLKvuJqoFGXgVqR9Zi20/
         33Lh+0V34E3yCyRHcVSeLrAPDszJ4FVWMBxHxuG8RVPAy7iBuUanRn3MqBTh2MDuEaRq
         L8TQ==
X-Gm-Message-State: ANoB5pmutlyZno+cp1ayKaogdCTdZpWP1DwaG8oZTQz0Gtp449PgHLLe
        LlkhCAUGrZiFII8/CTD43WFICMsa6WM=
X-Google-Smtp-Source: AA0mqf4dQzL9Zx/t0+Jr/GhgH7RCMJ5nvQOCGQGcbkCeu6sJD3cqJ++tdOb3nFVLUZIxDBx1NZ1vdg==
X-Received: by 2002:a17:902:7686:b0:177:faf5:58c5 with SMTP id m6-20020a170902768600b00177faf558c5mr13091572pll.166.1669262257957;
        Wed, 23 Nov 2022 19:57:37 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2d2-0afd-cc59-9e7c-2b31-e31c.emome-ip6.hinet.net. [2001:b400:e2d2:afd:cc59:9e7c:2b31:e31c])
        by smtp.gmail.com with ESMTPSA id 124-20020a620582000000b00574866d619asm25998pff.119.2022.11.23.19.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 19:57:37 -0800 (PST)
From:   Owen Yang <ecs.taipeikernel@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bob Moragues <moragues@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>, Harvey <hunge@google.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Owen Yang <ecs.taipeikernel@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: arm: qcom: Add zombie
Date:   Thu, 24 Nov 2022 11:57:28 +0800
Message-Id: <20221124115712.v4.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
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

Add an entry in the device tree binding for sc7280-zombie.

Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
---

Changes in v4:
- Dropping the redundant 'DT binding for' as requested by Krzysztof. v4.
- Adding an empty line here before "/dts-v1/;" in "sc7280-herobrine-zombie-lte.dts", "sc7280-herobrine-zombie.dts" as requested by Matthias. v4.
- Deleteing "/dts-v1/;" in "sc7280-herobrine-zombie.dtsi" as requested by Matthias. v4.
- Droping changing file path in description. v3. as requested by Matthias. v3.
- Changing Patch order, binding patch first and dt file second, as requested by Douglas. v2.
- Adding "arm64: dts: qcom: sc7280:" in dt patch ${SUBJECT}, as requested by Douglas. v2.
- Adding "dt-bindings: arm: qcom:" in bind patch ${SUBJECT}, as requested by Douglas. v2.
- Adding '#include "sc7280-herobrine-wifi-sku.dtsi"' in sc7280-herobrine-zombie.dts, as requested by Douglas. v2.
- Adding "(newest rev)" for zombie entry description in qcom.yaml, as requested by Douglas. v2.
- Adding "post-power-on-delay-ms = <100>;" for trackpad in "sc7280-herobrine-zombie.dtsi". v2
- Changing "vcc-supply" to "vdd-supply" for trackpad in "sc7280-herobrine-zombie.dtsi", as requested by Douglas. v2.

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

