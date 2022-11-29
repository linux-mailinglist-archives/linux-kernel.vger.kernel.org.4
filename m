Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8B363BE9B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbiK2LH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbiK2LGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:06:33 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49FB62055;
        Tue, 29 Nov 2022 03:04:06 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so8726696pjm.2;
        Tue, 29 Nov 2022 03:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QeTQq6wzF697oGF5V/c7AcE3tcQdYXM/Tpo1+r5kqU=;
        b=VFn92dDYFOjUbV6MdgTMzJj5V9Pknq4wx6y3WZA3YSFJ05mGk4kGTuJOZySZkregoX
         R09H4U69mqs7UcFlb7WdVrI6FSlLH3BFV4dfmntynPM37mTsPqRmY10D1PcNr021TndO
         ZJtZT0DZVQOTZVxo5J/TnA2wAB6U4FGrXZ+H2hzG0Al+fVoKV7fQaK6c4SrCQRzz2xNO
         olnT7FldajgQXGJ3VWtI9ztaAaj6GHsuc8tUY2uGp0TcZiATPhatjrtYQVCgb/ZFsXv0
         bqcAuIG7TyxgHWPHNXiComhYtC9wYH8JhbKlT2q8vG0tbV+XV0CJOMp/8JzD8+E5h5Dr
         AIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0QeTQq6wzF697oGF5V/c7AcE3tcQdYXM/Tpo1+r5kqU=;
        b=NfPCOehJkIaQd5BhV7IR11TeJ4LWHU9NeVy03nMYMdJhX6e3Pb37+uxdXLh3eWEkob
         wb5fLlFK/mpNS+V6nVjOOoxktaU4dsrs8icOasjy3N69TmJzfky4039b+fp7NGs+c9kk
         rIvv+T9S0HqvdSPKSpg84qIjpWcY6LAPclicWtOM8sLZnDXm4++XXJfJYvQDQUCyRVRi
         heMfI6MEL+D5q5VmZ6/INuhuHaNM9YQEg37U/ploaqsxnl0T2Tasl/ycbtW+GVOx17sB
         li7w1WGzPh8HfIgQSVhrobC7PbaxjpL7/akX0CeF32kMCeocGLKZySF9itKMVrPPs/PD
         94Cg==
X-Gm-Message-State: ANoB5plnFr/aYy4qB0n+QDJ6b84C8pqnqZnFXsmVAGj7OWc35BYaPvpP
        U6VnonKENnxAwkiAK9NHl1O7gQc3z6s=
X-Google-Smtp-Source: AA0mqf4WkqY8Eem3Omh2NZ+cUvtx3SzsTQZD9LY5jNFj/Jcqfz3tMr5vZFx3brcefjh0aY216O27dA==
X-Received: by 2002:a17:90a:a588:b0:218:8eb8:8502 with SMTP id b8-20020a17090aa58800b002188eb88502mr52114855pjq.179.1669719846009;
        Tue, 29 Nov 2022 03:04:06 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2d4-7fe5-5c2c-fa0a-e67b-3955.emome-ip6.hinet.net. [2001:b400:e2d4:7fe5:5c2c:fa0a:e67b:3955])
        by smtp.gmail.com with ESMTPSA id g8-20020a1709026b4800b001868981a18esm10566761plt.6.2022.11.29.03.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 03:04:05 -0800 (PST)
From:   Owen Yang <ecs.taipeikernel@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Doug Anderson <dianders@chromium.org>, Harvey <hunge@google.com>,
        Bob Moragues <moragues@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Abner Yen <abner.yen@ecs.com.tw>,
        Gavin Lee <gavin.lee@ecs.com.tw>,
        Matthias Kaehlcke <mka@google.com>,
        Owen Yang <ecs.taipeikernel@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v6 1/2] dt-bindings: arm: qcom: Add zombie
Date:   Tue, 29 Nov 2022 19:03:57 +0800
Message-Id: <20221129190339.v6.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
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

(no changes since v1)

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

