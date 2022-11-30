Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BD663D49C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbiK3LaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiK3L3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:29:46 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D32193DA
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:29:25 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id vv4so40601282ejc.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quL6WPeERZYedqB/nklThp0WUV+KiBC4sy50mhyRH+A=;
        b=g4zwRW29WPpz2thZu61KxOT33kFiYPjdJn8O5qYNxPph6DuPgMkHYs+nZcWacaCU7f
         gTxy9hKOIGvnGy82GX93mzCGf1z9/2d4ExSz35UcU8LJPhcZfY9TPzS7Oj0FZModf2Fv
         DEs2Dg+vdjOooKqMblRPEQ0gx4xCeX2raSuGdnHaM4ojj/PB7wRFtHjbcKXTAfNGK6OF
         HaB3AJnXLs/im/ez+So+ShqbWZ1LSObv1r2+5C7tB8g5//SkfYrJ8nTsVDO5dyJ6jDd0
         EYCa9bfzgvZuNsTjJqjmfHTc+Izp27IF+JuO7pGOnEYXgFUHTK3PuYpuI+r5j16lxGVt
         xiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quL6WPeERZYedqB/nklThp0WUV+KiBC4sy50mhyRH+A=;
        b=AGNvqS/1dLigd9vsHIT91+Zkqsk4IayGJMl6zwcnfFP9y9MbXH+u8rcILqJq9IzmnK
         5t84NTQK6x8UWcOW7pFdrHqPbptdNkl//ljEx/2lx/pqEjFAJ5CnzxJK9SMl4bR0XWkx
         3mYGuLRncTIwFJ7vi4rY9No0kTX8e9HWYYYhkKEvzJ+EsULqGOo3qqyuw3dPH9PISCD5
         TMfwoHYs7VkEs1px7NFldIv5911ym50Xrl+tkD6qkx1WU9BchuuIARpSkE8knCvl/XO3
         WfQd27/Wpdta5X39ljFKI7g/FBfZPvyz2Y5T8/2pcikpbFK++eUZRCC2RPHkI0DJgi5+
         c7+g==
X-Gm-Message-State: ANoB5pmvsX0RvnoPsbjLJt6WduXQzaEJOj7AdR6e3OJfS7DDBQTyQBFv
        mf8dQmvKHCPFNU6iYEPLHHwDhRqIekSaeQ==
X-Google-Smtp-Source: AA0mqf7z9P491em89qUagFeLR3nXWgGsebtZg2qlrn0Cni55JOX4TOd7qtW9BMO5z8C4xvnwCcNG4A==
X-Received: by 2002:a17:906:448d:b0:7ae:37aa:6bf with SMTP id y13-20020a170906448d00b007ae37aa06bfmr50974954ejo.481.1669807764892;
        Wed, 30 Nov 2022 03:29:24 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709060a4a00b007c073be0127sm521593ejf.202.2022.11.30.03.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 03:29:24 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 7/9] dt-bindings: clock: qcom,rpmh: Add CXO PAD clock IDs
Date:   Wed, 30 Nov 2022 13:28:50 +0200
Message-Id: <20221130112852.2977816-8-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221130112852.2977816-1-abel.vesa@linaro.org>
References: <20221130112852.2977816-1-abel.vesa@linaro.org>
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

The SM8550 has a new fixed divider as child clock of CXO
called CXO_PAD, so add IDs for it.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/dt-bindings/clock/qcom,rpmh.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,rpmh.h b/include/dt-bindings/clock/qcom,rpmh.h
index 0a7d1be0d124..f3e0288420ce 100644
--- a/include/dt-bindings/clock/qcom,rpmh.h
+++ b/include/dt-bindings/clock/qcom,rpmh.h
@@ -33,5 +33,7 @@
 #define RPMH_HWKM_CLK				24
 #define RPMH_QLINK_CLK				25
 #define RPMH_QLINK_CLK_A			26
+#define RPMH_CXO_PAD_CLK			27
+#define RPMH_CXO_PAD_CLK_A			28
 
 #endif
-- 
2.34.1

