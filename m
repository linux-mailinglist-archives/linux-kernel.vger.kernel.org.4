Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E643689F97
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 17:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjBCQtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 11:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbjBCQtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 11:49:05 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B457BBFA
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 08:49:04 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso4313304wmq.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 08:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPGIQMGiuzh1lR8nv0hVybfRN6cS2OlCFSuMfHEv4Qk=;
        b=ndMR+Sp/SSPTCAPvgGub1M0Ublg+/b53apl8CDJirjidwZHB7qAZwko6bKqC6RyJB6
         EVTPVI6JZQSL6pifqZJlZ+TQWMY7VhSxm/+6LV2FCSwK+KXgHKHnrnWHnW6kHe0O9129
         5VD0XZVI8TKmVHArQyU5iqpw1GGZo22c2n4X7AtDIA61emhLdqw0pjiwR2rnInyGEe8C
         k+OBVsk1tVrk7uOKxtrYX6T3Co2KIdDXT3W1FXhJcQyzcFCxsrDkhJOTtj2EiU8yY3wQ
         qrUJimsVopf+n1HAEdc1LOG9VAq6CPmPyTyL5iD9wCov94ij4sDhDaJgywRBPTGZLxZw
         6g1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPGIQMGiuzh1lR8nv0hVybfRN6cS2OlCFSuMfHEv4Qk=;
        b=00c9a0cQ/R+ev430FaPuPMdGXiXqH/Xol72/Y8B7a6uHF1JVFfppBjp12bWYA85Q1u
         7Ptns1EuC169OedVqZR7RtNhtV22SNngs4O6s625N3K09/VUPTBcBG3RbkTcHfqHB5nj
         ISq/8rRJU/k7M/uFrr1eZ2tQncLxq37XVeSJd76nDBi8WYGZJ5ImhzM1AKL4zR/vQt4R
         Eq/5Y7UMgkign3SIqSIFFzWqdunA8JHTTp7xUnW2BQgpNos4ppH5DA1Xow6HuiO/ZuMm
         /GFr+61zaNK80Fx5uUr3Fg5MGI9tpR5FGZGlplITt82hRi3rom/JkpVbJbQKXl2Hj/qL
         +EyQ==
X-Gm-Message-State: AO0yUKVgj4pFO39UC2/Jdoabb3pw303y3CfGhLuhQsIjShIhCBB0BCKV
        lrhKip3YNZB+WKERROIL+CCVDA==
X-Google-Smtp-Source: AK7set8ZA4rOQL1llR9Lj0TcFZ7Ju5sXBox35xsoRQmWfSdKE+OG22fqJaaceJM66St5hyDJrqax0w==
X-Received: by 2002:a05:600c:468e:b0:3db:1434:c51a with SMTP id p14-20020a05600c468e00b003db1434c51amr10555011wmo.40.1675442942792;
        Fri, 03 Feb 2023 08:49:02 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i21-20020a05600c355500b003dc4b4dea31sm3503247wmq.27.2023.02.03.08.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 08:49:02 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/5] dt-bindings: pinctrl: qcom,sm8450-lpass-lpi: correct GPIO name pattern
Date:   Fri,  3 Feb 2023 17:48:52 +0100
Message-Id: <20230203164854.390080-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230203164854.390080-1-krzysztof.kozlowski@linaro.org>
References: <20230203164854.390080-1-krzysztof.kozlowski@linaro.org>
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

The SM8450 LPASS pin controller has GPIOs 0-22, so narrow the pattern of
possible GPIO names.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml
index e04d094d1946..8bf51df0b231 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml
@@ -65,7 +65,7 @@ $defs:
           List of gpio pins affected by the properties specified in this
           subnode.
         items:
-          pattern: "^gpio([0-9]|[1-2][0-9])$"
+          pattern: "^gpio([0-9]|1[0-9]|2[0-2])$"
 
       function:
         enum: [ swr_tx_clk, swr_tx_data, swr_rx_clk, swr_rx_data,
-- 
2.34.1

