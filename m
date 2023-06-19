Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084E07357A2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjFSNEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjFSNEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:04:36 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51511E5C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:04:34 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f86e1bdce5so1587297e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687179872; x=1689771872;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Upd4FeAvQf31usHpyE+RwsUFEIsTHUdVtgm5KELcXA0=;
        b=u71ZydpAAJq88suWSHZ5jqjUYOP7UG7YmVf6nBI4BuHqcGgsDZjf7GI1Z7Hj1cR8s6
         Xu5zq2jf/nV/YxYGuqHs7Hs6XTDeIF32CI8gi3b6LbTsq8butef10FWWYCdmOdZPWRee
         2PdaO2YDpnDPq/ca4Q7treBPkIsCISy+RKlBGOTcN1I6V7dbHJLnpT+J8K+FIIMoj498
         fctN092uT8VxsjpPT1bJwjMgfhe02sxTnpwBDd9ESmoUSC7+Zr+ghYQ0zKlk01ISuPye
         bEuea4yv81fIghWasWHTRIYkAYBiz8o7BwxwbuJ3xy10NAomKjCG7XIDm3rlZO51kqCy
         7urg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687179872; x=1689771872;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Upd4FeAvQf31usHpyE+RwsUFEIsTHUdVtgm5KELcXA0=;
        b=TNB2CqOS/Uk1XBOE0E6BUbUw8q1M/GzXinwtLUKFxGZy17BXT45Cj7Ff/t9bvx8BdY
         RZtWPrn0MX+xyO9wYFnHumiFwx8VOcgHmrcqn71b6NxcGt8ncfQzLnLgdGozgNBF3vP2
         czJU23/BBVSsmaqs1Ln2EMsKVtn2nU56x0Gu8mN71s+XfSKIf0JoCDjmGNfRQoL60SRf
         tyA79KtBksdLleTJIcbeKLJ/QZUm0NOjmYPfPM3J+qy7+fgY+oCpzl1bJ9iVSsqxJrYk
         XO97dYOwG0gFJd9QxzzMxaesDkQy8BgFn60ucPgJEHRHIvhCT5kBqpesrCHWPxmNCNCp
         nQyA==
X-Gm-Message-State: AC+VfDxtqJEvp/fBZuw602reQ6xzLSMBqTz9Ls74LXQh4xc7rqr4kMnH
        4eQWPp/9F4wZ63R8XInXXVwJQQ==
X-Google-Smtp-Source: ACHHUZ6/+ViP0pu3Lm2zTR6PzxyQYLLVinFku37jLNvaYnLDrMgEnydM8MIbdTR6zC+8o5umjLvwBw==
X-Received: by 2002:a19:4307:0:b0:4f8:4421:2e0 with SMTP id q7-20020a194307000000b004f8442102e0mr4811594lfa.22.1687179872463;
        Mon, 19 Jun 2023 06:04:32 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id q28-20020ac25a1c000000b004f643664882sm4256489lfn.147.2023.06.19.06.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 06:04:32 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 19 Jun 2023 15:04:26 +0200
Subject: [PATCH v7 01/22] dt-bindings: interconnect: Add Qcom RPM ICC
 bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v7-1-09c78c175546@linaro.org>
References: <20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687179869; l=982;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=w9msswuI45zhSz7DbQ6BMai4GWYypGBpOWJMFDd+VyU=;
 b=sXRlKbEeyql3Yv4hCJ9myZVaQd0txDgJuSVVzLpzubTtZaZBW2akye+RKz5176Wh4RBb/QHNw
 aISKFvsfO2xCzZVIwWTMwHUQgWMe8DgxGFnVnL9K1C2BCTc/FKz6LX1
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SMD RPM interconnect driver requires different icc tags to the
RPMh driver. Add bindings to reflect that.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 include/dt-bindings/interconnect/qcom,rpm-icc.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/dt-bindings/interconnect/qcom,rpm-icc.h b/include/dt-bindings/interconnect/qcom,rpm-icc.h
new file mode 100644
index 000000000000..2cd56f91e5c5
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,rpm-icc.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_RPM_ICC_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_RPM_ICC_H
+
+#define RPM_ACTIVE_TAG		(1 << 0)
+#define RPM_SLEEP_TAG		(1 << 1)
+#define RPM_ALWAYS_TAG		(RPM_ACTIVE_TAG | RPM_SLEEP_TAG)
+
+#endif

-- 
2.41.0

