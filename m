Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1967306A5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbjFNSEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbjFNSEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:04:40 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3A4211C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:04:37 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f649db9b25so9039970e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686765876; x=1689357876;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Upd4FeAvQf31usHpyE+RwsUFEIsTHUdVtgm5KELcXA0=;
        b=wI5e5l//s9SmtRdaucEZwzoqaSqv0P+OcCY/FZ/8vCs0lKx+xf8gPI7Mnz7YmXE4XI
         Ci/9nJzhl/7bFpMNRaoO5DffXCMrpP+0vQB3xnph3nv19tpP/3HBjvaEvHTXzx45BW48
         /08LB0goopNxP8DUBrw+UlUFSssSpJ29DwPWck31cWdsSbRU1Y6nEnQ3zjxq2ZzN1lHO
         otNsaJF99SGeiiouf6ZEU7GMEJGkkgbArCUlISZKccJoNE1eL7oTqa3E7ZgIRJyxiCfK
         5LOMm8JXmnJPmvk/HGfQ0pxwSewS0LdEixk500s7Y8BXZ/S1JnwRnYhcNQi+tdxapjX5
         uolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686765876; x=1689357876;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Upd4FeAvQf31usHpyE+RwsUFEIsTHUdVtgm5KELcXA0=;
        b=VMfQ+Hu+ctssx44JQQuodESuAREkeFqumM8jfld5FJyh0zHIml5TMNLuOaixiSIkIN
         Ev8Y5mNJ4E13+68aQqEoN2434vt+0KOVj0U9v0X0JCr9Ujt9skH7FGKF4WrxWGnQOmas
         9A+e/JRh5Iy2LqlrJ3APLQ2Lsm8mqVq+GUbmktyFwhZmm+gZBWLiNgWtXwg7TpHDtxx7
         GNjQiLkB1Z4/qM+ZtnrXLHZC06vMX4ys0pUeevXq+RvajRWCixT3kkgdqDmdUpDJe5Dz
         rh0gp8zL9DQb9txhWWxX9lr2hvsGuzH9O0NBclMxVmspjhVgVwi4klGlVqqXnj28DZio
         w0gA==
X-Gm-Message-State: AC+VfDy846esYTwI4LOSu8qkr9OT17TWvcxTwUkHFLITWY9QvRjhSStU
        7XOcZ19xsXG61Fr/A9HzHUa3Sw==
X-Google-Smtp-Source: ACHHUZ4+7z6omPJS3cfss81KBSa+43EHLL9/kbTiN0eEFAck+jGSV6Px4OYaL4OzTNXq1wJpysMidg==
X-Received: by 2002:a05:6512:615:b0:4f2:5d38:2c37 with SMTP id b21-20020a056512061500b004f25d382c37mr8741494lfe.15.1686765875915;
        Wed, 14 Jun 2023 11:04:35 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id l18-20020a19c212000000b004eff1f7f206sm2224053lfc.9.2023.06.14.11.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 11:04:35 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 20:04:20 +0200
Subject: [PATCH v6 01/22] dt-bindings: interconnect: Add Qcom RPM ICC
 bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v6-1-263283111e66@linaro.org>
References: <20230526-topic-smd_icc-v6-0-263283111e66@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v6-0-263283111e66@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686765872; l=982;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=w9msswuI45zhSz7DbQ6BMai4GWYypGBpOWJMFDd+VyU=;
 b=IOnkjnpkZECBVHk2UHt1fRIw7NiaZ+xUE7tMwJBoa0QGYcAoGKH6PauFzsijOmxOc0RihS+6A
 0ND0zIfIXPGAdUKn1sOADH1Tr4UgiDy/Em+SC1q/gu3iADc7OQD+sL0
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

