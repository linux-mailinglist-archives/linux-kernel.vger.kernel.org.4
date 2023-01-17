Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E272670BE7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjAQWol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjAQWnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:43:03 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607C95DC3F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 14:30:18 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ud5so78948408ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 14:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDaDU/ND0Via+W2IIJR2FBHA+vh86Uj3CFJnQI7EtO4=;
        b=yFE2hUQomkInlgwiPt7lD4kob7aUTwltfxBciwuomujqJkHRZDYfYgRqiqaNw3vS10
         BlP9CvcYpb0QxfB9n4t45GOuxCQ56prhrDMBE6Hic7FcwNB+n9YGk9rZsIby3obweN6K
         nhvHVHoXrNP+pxWWQra5S6oRtEV2gcthFtH42nMB2GOog2mX0qEgc2ox02JudnlIoP0U
         pVEi29iNt5jeUbyIMbelsp9a1pphrMPkZt60ZT34hlsy4fChfmtxl5xaREAm55pT4sWn
         urnOWEYF6/vIgQ3fSBgqES8aKvZueBobxcogvAykzDD7bfkhV5DEx7BdoSaWfOg8zxWP
         nAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDaDU/ND0Via+W2IIJR2FBHA+vh86Uj3CFJnQI7EtO4=;
        b=sSepyrOsTSmFXQK3+PH3E+jsj2+/tqFBM1LeiQwBZjrRnd0yJJgh/9TbXwmnwJb2i6
         FQCgrMdHAuS6Kr9gP1KP8So6/BpIsOhjBxjlWomqqlBirW6HLfJjiQvL4musJBfxMNlb
         4R/xgERIDafgQ8s6zH8EFPb1XpYs44eSF+7J5vcjKyYKutajR5L2MZcEJQlwkTyoOIvm
         ZhIg45HIfpUBD8zuYcRJUudRGcAMddn3wDY1PgWM1uNkn0rC2cwAJ/Zpolgyhf9E9I4D
         dIBLUwTgd1Hz4ftULRaBWZOgG1XderyMA6KIJb15/oyYhwNcdtpRRjDutYOT2pFR6NXs
         13kA==
X-Gm-Message-State: AFqh2kruwWGb2wXPx26tt1DvXG1j6h24t+WUVzexbxDudJz20EB94liK
        n9DsEO/bEBqTCeBRqR+TayxC1w==
X-Google-Smtp-Source: AMrXdXtcD2KelzevLES83MtDShW+hs9Oy/AY8ul2ohWGgdXILh4VDxtR8tQRvVBsuLme0L5+sB2hBA==
X-Received: by 2002:a17:906:e259:b0:84d:4923:366d with SMTP id gq25-20020a170906e25900b0084d4923366dmr4270003ejb.44.1673994616935;
        Tue, 17 Jan 2023 14:30:16 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id ec20-20020a170906b6d400b007c0f5d6f754sm13835189ejb.79.2023.01.17.14.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 14:30:16 -0800 (PST)
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
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] dt-bindings: mailbox: qcom: enable syscon compatible for msm8976
Date:   Wed, 18 Jan 2023 00:30:09 +0200
Message-Id: <20230117223013.1545026-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230117223013.1545026-1-dmitry.baryshkov@linaro.org>
References: <20230117223013.1545026-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On msm8976 platform APCS also uses syscon compatible, so move it to the
block of compatibles using SoC-compat together with syscon.

Fixes: 60545466180e ("dt-bindings: mailbox: qcom,apcs-kpss-global: Add syscon const for relevant entries")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
index 36deddca1524..ecc286ab49ef 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -20,7 +20,6 @@ properties:
           - enum:
               - qcom,ipq6018-apcs-apps-global
               - qcom,ipq8074-apcs-apps-global
-              - qcom,msm8976-apcs-kpss-global
               - qcom,msm8996-apcs-hmss-global
               - qcom,msm8998-apcs-hmss-global
               - qcom,qcm2290-apcs-hmss-global
@@ -37,6 +36,7 @@ properties:
               - qcom,msm8916-apcs-kpss-global
               - qcom,msm8939-apcs-kpss-global
               - qcom,msm8953-apcs-kpss-global
+              - qcom,msm8976-apcs-kpss-global
               - qcom,msm8994-apcs-kpss-global
               - qcom,qcs404-apcs-apps-global
               - qcom,sdx55-apcs-gcc
-- 
2.39.0

