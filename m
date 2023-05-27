Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3157133D8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 11:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjE0Jwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 05:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjE0Jwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 05:52:41 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6535E3;
        Sat, 27 May 2023 02:52:34 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-96f5d651170so520486666b.1;
        Sat, 27 May 2023 02:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685181153; x=1687773153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Na6Txrt2hFh+fWwveerBgJHyXpffGPNv4qohRE1MaYg=;
        b=V+s71H6TjO/HhMt4HfHThkprHxIaiCIwYBezKbGdNwVjoG6TWOilANBd7iOeb7I/di
         cLfoOhLT4T4U7sp0hqat1o6D/LVCtW+ycJAELRF1Po3rXbdlT9Y5/jDI9V2lJBTIDBQT
         TunOnUuxnX2kqiolWh52N178srlVEYj7O3LPuXPuHEz4WezrVh6KSqeri3KCRLqY2SGX
         4tQ5KCbF91Wi2QDdfekWueRH5WUeibkrsfR3ocKH+f2JJYhVywvbENjodj8FJIrnIHBf
         5mm91uUPTwLaMCQRuvSoERhyf13dxva5R+ct0akm1W61MxAEjLkPSTNqWzDGchnRc36Y
         QX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685181153; x=1687773153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Na6Txrt2hFh+fWwveerBgJHyXpffGPNv4qohRE1MaYg=;
        b=PGo63o3yIQOukosfk/7j7JlXJZlz0SmBIj4BJB8QbeO8BCLppsZAeSioMmfCpOyc+7
         ElA5dwJ+z+kEPB22onP5RJildyvcCG2NswVGXG5+vZAZAxrkt2KOwhHH7+khubk2Q/HA
         PgtVmuVEcxOoeaHKsPiyGz6p6MJ8UiXw+UIgTzMVDQH1AKM0SSpPj5e4hgmaJSC/EifD
         iGcBqLoYM15XsgzTZ6wS1xicWNeqhwan+rfyICfnbslr1mpc2imV1NJVjtTDCXuX+g/U
         BeL1eTxY2pBZx0BX7n7lWOasKZyUyR09OugX6eUKzEVxYSNGEfL57pfGcYqIiHRskoPh
         /5fw==
X-Gm-Message-State: AC+VfDwP7vXgT7oZkXeqXWHlyH9tdmc21oj+E3fExgPgkmelwwN7/kPd
        WY06cZtDWrVefqQlZZNdEIMiHtwY5xyt8Q==
X-Google-Smtp-Source: ACHHUZ5ZUCSqPzYpjsoHWRdlMUw62ces7+jeMttuscdSulYOdCoZgfBsxlriuni6BF0Qzvui1E1PNQ==
X-Received: by 2002:a17:907:980c:b0:966:5fac:2e52 with SMTP id ji12-20020a170907980c00b009665fac2e52mr1378960ejc.9.1685181152973;
        Sat, 27 May 2023 02:52:32 -0700 (PDT)
Received: from fedora.. (dh207-98-6.xnet.hr. [88.207.98.6])
        by smtp.googlemail.com with ESMTPSA id kq10-20020a170906abca00b00960005e09a3sm3218262ejb.61.2023.05.27.02.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 02:52:32 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     ilia.lin@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ansuelsmth@gmail.com, Robert Marko <robimarko@gmail.com>
Subject: [PATCH 1/2] dt-bindings: cpufreq: qcom-cpufreq-nvmem: document IPQ8074
Date:   Sat, 27 May 2023 11:52:28 +0200
Message-Id: <20230527095229.12019-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document IPQ8074 compatible for Qcom NVMEM CPUFreq driver.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 .../devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
index 6f5e7904181f..7e1bb992ce90 100644
--- a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
@@ -28,6 +28,7 @@ select:
           - qcom,apq8064
           - qcom,apq8096
           - qcom,ipq8064
+          - qcom,ipq8074
           - qcom,msm8939
           - qcom,msm8960
           - qcom,msm8974
-- 
2.40.1

