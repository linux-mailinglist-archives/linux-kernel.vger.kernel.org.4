Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39815750918
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbjGLNCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbjGLNCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:02:34 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBBA1FD2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:02:23 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666e916b880so3454652b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689166943; x=1691758943;
        h=content-transfer-encoding:author:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KMdohCdaLVd4HEOOg6g6eIdW9oFM4ELH5FlH42ryJA4=;
        b=FO8qnGg64dU7X+U8EMUetFFnalKYf9NpPJ7dptUBQOkNpwc7ZLhwLDh025M7zMlcZH
         QrHgezV0MJQv6uDJjvMI858+eQbKt98luJKA7Jhm8UfQ/ivd9IQ8/0Il4x1hgFxv4U2P
         4hJcwADL1GngCelhFCpOAOJ4XSZsmTcDTtgCEXyWYc3rSw6QVA//WnQY9BUan190iJ1E
         Lf8lebzMdld8H9io6dgAOTL0oqNJKMUl6Y1QMBrgIYSLlTmF7BLJxtSQxDfqIDXqSRW0
         S8y56T0M4ovrAOWqzDZvFUIDSwd9AZpK7u2/48Os1oxVvgUcpXnCWXYDU3c85rz2MsNn
         pvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689166943; x=1691758943;
        h=content-transfer-encoding:author:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMdohCdaLVd4HEOOg6g6eIdW9oFM4ELH5FlH42ryJA4=;
        b=XmCzHc5euChieyOHrE5DT7TjHSOpDy6B4vP5Y0epj8ApVy9h6U0DCxpLVYKmEbGJM7
         +A7q7KUjMKm6YK+eOebXEGDk6nVlkN+NFQGwqKYGgXUG5T0RJIazrdaINsJDcEDB335l
         QEeCdFRUrbqahHg+za+WQ5AcZMRWgc38nI2AVrDD7cb6QvPZKEJ9jJGv39e2x+nOGjrZ
         b+/+QwlRM/u9dsQuVtR9qUNkY7SxKZWjOO9jXEqiFzK0JbmqSvELEjqfu+2PHchTx9/R
         vu/jMxeSH+joV/7rMZrgfuN1ywQuDKYiea/8mwBT6xx7N0pTWa/MW4m1e0WfFCETq6re
         P+Og==
X-Gm-Message-State: ABy/qLZrI7UwsLEX+WJ2/gkRZZyjRsyd9mH8utLHYXh1XVTrPr+HWGE0
        VpuBiLugaX4YE5s+8xe8k9a6WQ==
X-Google-Smtp-Source: APBJJlGxOuD2o+cmEyspcCKwQyh62RpiDLf/OBRMFhKExXiTATvAyj0SSczI6826Fg3XxvXJc/xNQQ==
X-Received: by 2002:a05:6a20:12d0:b0:129:a9af:7ec6 with SMTP id v16-20020a056a2012d000b00129a9af7ec6mr16897403pzg.56.1689166943112;
        Wed, 12 Jul 2023 06:02:23 -0700 (PDT)
Received: from x-wing.lan ([49.207.50.231])
        by smtp.gmail.com with ESMTPSA id p1-20020a639501000000b0054fe07d2f3dsm3417023pgd.11.2023.07.12.06.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 06:02:22 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Bryan Donoghue <bryan.odonoghue@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: display/msm: qcom,sdm845-mdss: add memory-region property
Date:   Wed, 12 Jul 2023 18:32:14 +0530
Message-Id: <20230712130215.666924-1-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Author: Amit Pundir <amit.pundir@linaro.org>
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add and document the reserved memory region property
in the qcom,sdm845-mdss schema.

Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 .../devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml    | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml
index 6ecb00920d7f..3ea1dbd7e317 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml
@@ -39,6 +39,11 @@ properties:
   interconnect-names:
     maxItems: 2
 
+  memory-region:
+    maxItems: 1
+    description:
+      Phandle to a node describing a reserved memory region.
+
 patternProperties:
   "^display-controller@[0-9a-f]+$":
     type: object
-- 
2.25.1

