Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2805D72FA5E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbjFNKWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239540AbjFNKWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:22:23 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D621BD2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:22:20 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b344476313so6707031fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686738138; x=1689330138;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4gn37z49ZtWSh9ik86q07lLH6vDKJpjqwf/xsIE+Io=;
        b=Ryc35p875lLcHPJrD9S6+7gFFAFOSUEhVhptXHrotGZat5oVYZq3TqLRtCn0EtHO0j
         MM7m1mILkkSmzHEctANxoyJY8DG1Ci3u/YG2UCWwjyM/YR5CxlSjBgSB4ECUI09/N6qr
         lkw4OvM7MxCJDkbzJRq5tpScfE63OX6gDMbpl5R/s8zkjAXExlAo41peCBLr9SvfJjc6
         qZ7xPK1XSIX8ove6EZP49SfyPeQJSGUy40JPq3Abyw5qBWNNUSMFOBzlrXd5WAJ29Pk7
         Oi5duosxB/72Lugc5GlPKhe23mcSF4yB8sa8i3Fo0nhrxmsReYrxDvj+kiikGsMeWZ+F
         usAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686738138; x=1689330138;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4gn37z49ZtWSh9ik86q07lLH6vDKJpjqwf/xsIE+Io=;
        b=PMKRKRp+WJF4qnwPqAJONiKmwjJtxNDA7X1ey762cAbM1OztviqttzCYvWynTWoNP7
         4S3BQaSQMpNAbgmUr3qL4pax1FIwgDDXHTsN+RhtAFs1YcGZ72PuaJCF6AOcVpLAoVHD
         JBtHoidNqW5EdW4VS61D89GNZejcYAlkqAMFsT8MzrMEVZs1juYWyQP/uL70wATw/FTO
         Knw5LvHmvGD6aKJun3r+QXgurXPawf95IHyQ7PsmA/IauKAEG662QhOrZ3ULKl0c+e20
         hpMVruRDhOdWIFFQXi4s66Cop4AJCTBhVrVW4FvCN0oQJCwiVrf2Rp6qqyHZa6LnTprr
         nUyw==
X-Gm-Message-State: AC+VfDyPk93oCh8bwGROhtN57GnWbHsfIV11ZJvtZ/7BoHJlMCo8eLaY
        NKzJb7cncne+Ku/hnt5A8/9JeQ==
X-Google-Smtp-Source: ACHHUZ5/F2x9lcbPjaBMfEWIFbcML+1ePQSsIKZaeqF5d14HESsSJncC5mociIWlcLc4Vr7/VzfhJA==
X-Received: by 2002:a2e:9c5a:0:b0:2b1:ae75:2781 with SMTP id t26-20020a2e9c5a000000b002b1ae752781mr5752793ljj.27.1686738138600;
        Wed, 14 Jun 2023 03:22:18 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id m2-20020a2eb6c2000000b002b20d8f270asm2520057ljo.74.2023.06.14.03.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 03:22:18 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 12:22:12 +0200
Subject: [PATCH v5 01/22] dt-bindings: interconnect: Add Qcom RPM ICC
 bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v5-1-eeaa09d0082e@linaro.org>
References: <20230526-topic-smd_icc-v5-0-eeaa09d0082e@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v5-0-eeaa09d0082e@linaro.org>
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
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686738135; l=918;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=1W+eH+8wPS6dtSY8tNN5L1cSWMudrCjAT7V4K+wZK5I=;
 b=K5yI5GOz9/EYW/rU6Z/1pBrZFVzgVtqSaGNUWpOM5WiIOB3NcVaIkmxJNWkg17CRf2QkUSwqh
 TaoSM2GY0AvCxibvZs27IydvgyV19IewSE52+rxW8KnGx/ZvDEyuI5k
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

