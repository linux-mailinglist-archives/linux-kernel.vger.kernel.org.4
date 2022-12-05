Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091736422BC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 06:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiLEFaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 00:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiLEFaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 00:30:21 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5C910573;
        Sun,  4 Dec 2022 21:30:21 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id h33so9521726pgm.9;
        Sun, 04 Dec 2022 21:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqTqtUH4SGu1jZyiQDeCWeieBWj4y0izBZGPp2Zpk7I=;
        b=MvDa0gz2S1pkesbkXJQajaXu9MsFphwcjvHX57EhueCxKWUmh8BJoSUaI9oOdIQwj9
         4GoCz1hPlAYUhoeiQ1oRzeMpWr+DTtHiviVoARdaF8snNKZU/OsNotRFpvXYyggMt1tp
         pN0l9JCq44V9OKcMx565ASHNCJcG5ogY6F/sKdQLNY+3jquMcqlhraLHET0qx7MF1ipc
         GhGSUNBE3kp7Aef+Q/69j4/FqMKuzGkCP68D8GaTr+Alc2lYY0+MRROHLMr6zmOaI2cB
         M+iQM2Da/+ZdxzMQ8LADBzlaJTd9413Jm+mf6rA7JpZm8jDZx9G7u+P5TfcpUAnIQHx1
         xzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqTqtUH4SGu1jZyiQDeCWeieBWj4y0izBZGPp2Zpk7I=;
        b=yLHdgzAWLa6uFYSmRyRn3wSAAH4IBlwOFADi+rFY5E0HjRNrbNcNU79YKOWG7jOJuS
         Ic7N0nYASY1YZvkt+wyEtHNQKce0mIinjqF7/1AREZy6VaX+vUSoMHdmidRqL4AcHhjk
         aKv46vfERdSiKeYtJEh8puQeXhC+6c/ha45oCLqTvjfwBaZNCdG04N55+SO8ag1DXxbC
         YiKz/STQP4hhe+ww0+GhdX7kzRU2ZUhLFRBW8XorY5/743sMCq2fVs9Ho+up312cTO/n
         YWaLD392m/lWkLT+AkSllsvC0wSAmJaDqHmhFvdxbf1N7UgCG6D7vVwczW8SLi619Ade
         abOw==
X-Gm-Message-State: ANoB5plPJh4194H0zZS4wIGtzzGnuujycGb+vPQEv2nU4uPolHPpI2e+
        j55PuWy5moiMB2c3fQu9j+T2vExBXLU=
X-Google-Smtp-Source: AA0mqf66qduVLZhP4T/e5mH6CJEsnoy0jTRRNV34xJAKzug/p+wgWeoLtnrd3nudduT1wxkNb4XGGQ==
X-Received: by 2002:a63:4081:0:b0:46f:e657:7d25 with SMTP id n123-20020a634081000000b0046fe6577d25mr71093325pga.347.1670218220365;
        Sun, 04 Dec 2022 21:30:20 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2d4-7fe5-c00b-8015-d148-489d.emome-ip6.hinet.net. [2001:b400:e2d4:7fe5:c00b:8015:d148:489d])
        by smtp.gmail.com with ESMTPSA id 13-20020a17090a190d00b00218cd71781csm8239556pjg.51.2022.12.04.21.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 21:30:19 -0800 (PST)
From:   Owen Yang <ecs.taipeikernel@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Bob Moragues <moragues@google.com>, Harvey <hunge@google.com>,
        Matthias Kaehlcke <mka@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Gavin Lee <gavin.lee@ecs.com.tw>,
        Abner Yen <abner.yen@ecs.com.tw>,
        Owen Yang <ecs.taipeikernel@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v14 1/2] dt-bindings: arm: qcom: Add zombie
Date:   Mon,  5 Dec 2022 13:29:59 +0800
Message-Id: <20221205132913.v14.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
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

Changes in v14:
- None.

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

