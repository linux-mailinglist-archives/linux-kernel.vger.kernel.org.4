Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79BC67D94D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 00:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbjAZXDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 18:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbjAZXDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 18:03:45 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E55552BB
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:03:41 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id c66so1186475iof.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0817b8QuSi7hdYOROCPDeMWfXlDnjhdy6HTg+NWqT4=;
        b=mubW0yFBRNRRB/VvHHPAlaCWIMZKyNdR5xOeTOY8/ni1uYMXxzi7pzNV9t3cFgSW5Y
         FotiU4Btx110lE1+UCIYAUOF264i/LxOaU1iw2Obz6ZwBft2mxffoSdDJviHdGboHHL+
         5GgpbyoSHRws5IUhpudUPx2+THUuMODad/IAgdn3TW+EzQBsQe/inCevGHTbe5vduefT
         tGubaTNwUn9q2iSaOT6gDoIyfvPQbovlpb4EXSxJ6AyBNsN7cUnccXnBiiH6wbVw9muj
         Ltj/36xxHnkxK64B6dH0EocpbRN+0KFUMqTb4y7+NMZ8WJvjYSUskLoytUXSS3R7moQ6
         Onhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c0817b8QuSi7hdYOROCPDeMWfXlDnjhdy6HTg+NWqT4=;
        b=MmbWSD94o2+ai5vnQ+Ck3Fa2SComtZfkD0RnLRFY1Q4WylHEXcAXEYjAH8taUk8Tac
         EDcxhow2PvKPKyOMUDe4VuSTofkpugu3xjNYspohjXmDwFyxzj1P1BqMYlgDSVEDBBkl
         7+rLCaGnxX6JXbSo8U2210Oz7DjBrJCl46p02bCfy+rXDZT5a/mm1PLrryFk9xfd2av0
         tUEtx4YvAQMQraIitPkQP1dhA97pIc8mnE7AjT27iWFxzyTV8JyqvzzuCYg7j+eEFgL4
         OSwIkI10gI+3ZLSCqhSQHUqYVwyqB63ektD0xVpt3YHjHZgGVv90ZMu+Bczq45pqakSd
         sk6w==
X-Gm-Message-State: AFqh2kq7Rjkaz3qiS/HaqCW3IxPzkvNpangwet/Ky0xupdAL915+/k8h
        d5J1Mwq3pGx2K4aoogbod3pkqA==
X-Google-Smtp-Source: AMrXdXtKAXX3oS9Pnk9NtCBhAAYZsbkGo0kVhxqgs6+MnSb6gGZedzmqEAIRil9QHRGoUCWCOyyeCA==
X-Received: by 2002:a05:6602:1253:b0:6e3:19f:b3c3 with SMTP id o19-20020a056602125300b006e3019fb3c3mr27906809iou.0.1674774221562;
        Thu, 26 Jan 2023 15:03:41 -0800 (PST)
Received: from eriador.lumag.spb.ru ([194.204.33.9])
        by smtp.gmail.com with ESMTPSA id l4-20020a6bd104000000b006f8b7d869a0sm670924iob.1.2023.01.26.15.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 15:03:41 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 4/7] dt-bindings: mailbox: qcom: add missing platforms to conditional clauses
Date:   Fri, 27 Jan 2023 01:03:16 +0200
Message-Id: <20230126230319.3977109-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230126230319.3977109-1-dmitry.baryshkov@linaro.org>
References: <20230126230319.3977109-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing platforms to the conditional clauses selecting whether the
clocks/clock-names properties are required or whether they must be
omitted.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
index 5f7770036fed..7d8de7a16984 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -72,6 +72,7 @@ allOf:
         compatible:
           enum:
             - qcom,msm8916-apcs-kpss-global
+            - qcom,msm8939-apcs-kpss-global
             - qcom,qcs404-apcs-apps-global
     then:
       properties:
@@ -121,12 +122,18 @@ allOf:
       properties:
         compatible:
           enum:
+            - qcom,msm8953-apcs-kpss-global
+            - qcom,msm8976-apcs-kpss-global
             - qcom,msm8994-apcs-kpss-global
             - qcom,msm8996-apcs-hmss-global
             - qcom,msm8998-apcs-hmss-global
+            - qcom,qcm2290-apcs-hmss-global
             - qcom,sc7180-apss-shared
+            - qcom,sc8180x-apss-shared
             - qcom,sdm660-apcs-hmss-global
             - qcom,sdm845-apss-shared
+            - qcom,sm4250-apcs-hmss-global
+            - qcom,sm6115-apcs-hmss-global
             - qcom,sm6125-apcs-hmss-global
             - qcom,sm8150-apss-shared
     then:
-- 
2.39.0

