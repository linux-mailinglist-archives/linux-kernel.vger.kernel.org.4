Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FD562F02E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbiKRIyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241602AbiKRIx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:53:56 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF4C6153C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:53:51 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id i12so4340712wrb.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=0fnb5O/ndf1VkvRnlKdjT69eu/ujQx3r4QZH4WlaBFo=;
        b=rh99ubA08c1ccpi68lf38lMk3RCCw5M12R7Xite/8g0O2kJh1z0s0syo4NY5Z1aHgS
         /UI/3YGcfw7FaMuVdBObrxV1yPta7zoW0fHST2VluNEP7zI/tnVafL9UdHgpFmm5ywjU
         woUggUQNyBWYQCEup7GjB6UAZ0cA9crGFlCwOV99ogfO+YHj36bhCjUd/OOcU4Ybw6uv
         zcRBBQMZ6BotWfzhs++HNMDZlElu31HiY0kATrQdZF2UaNov48wL0eoAw3103aU5Bfj6
         iacs4EYLesdjXGhB7UthJ1/FhEl3pEwJFd8y9PODz2d4rBN3NJldaJct8AGKsjrKal1p
         KjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0fnb5O/ndf1VkvRnlKdjT69eu/ujQx3r4QZH4WlaBFo=;
        b=pQ2t+3+U6qzN7k2DBt4Jf85kTxyForcFkqphInhDJpu3ywKjZm4dYrKXLFjLYJ/F6i
         gxvaXWihle/0N7FOlnDBVGNnnE1VcRE9dRh75INcr5NaQSv/IQFVUUsuXHf9wzVh9TTn
         7H9egTMJtIBP6Q0pOsp2Fp/+lZqAzDUUOkvCoxWViPXxaZj5U2h4kH6P2tF6wIczViMe
         reAD0CX5cwelby73Zh4bEgqiYhjwiMba2Hwlggv6kSzJwDwO3riikT4CtRFvoVVkm5Zl
         b81KOHjvBfTFbaSSiL93Plp7LMD09NwOh4HC/ADYff7NtvLVP/T0ed3NEy3OZTjwUWgg
         3ogw==
X-Gm-Message-State: ANoB5plvfg/NSN0TJgG1X8sOK5qoMEPStxFyV3A43HXPQ1Qnh2UIeFrf
        pdG8Mh3qEk3zp/h3lAMIL02sXw==
X-Google-Smtp-Source: AA0mqf4y61KkGIczaDvwWLAaO7h5djn812y7ziL2a3ppCt58Ue/mqoix0G9NK2mAZfoBazdxHeOHYw==
X-Received: by 2002:adf:f003:0:b0:236:5d94:6d17 with SMTP id j3-20020adff003000000b002365d946d17mr3449954wro.681.1668761630270;
        Fri, 18 Nov 2022 00:53:50 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id a13-20020a5d53cd000000b002383edcde09sm2971264wrw.59.2022.11.18.00.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 00:53:49 -0800 (PST)
Subject: [PATCH v2 0/2] soc: qcom: Add support for Qualcomm Modem Processing SubSystem DSM memory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIABtId2MC/5WNUQqDMBBEr1L2u1tMakT71XuUUpKYasAksqtCEe/epTfo1/AG5s0OHCgGhttpBw
 pb5FiygD6fwI82DwFjLwy60lopVWO2lHihkgfk1BpT4ToLB5swzcyvnhNq5etr6xvz7hyIyVkO6Mhm
 P4orr9Mk5Rh5KfT5PW9K4vHfyaawQmXa3mvnmtA19ynKrlwKDfA8juMLqwLoFNwAAAA=
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 18 Nov 2022 09:53:47 +0100
Message-Id: <20221114-narmstrong-sm8550-upstream-mpss_dsm-v2-0-f7c65d6f0e55@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm SM8550 SoC Modem Processing SubSystem requires that a memory
region named DSM should be shared with the Application Processor SubSystem.

This adds bindings for this MPSS DSM memory and driver implementation to
share this memory region with the Modem Processing SubSystem.

The MPSS DSM memory must be shared between the APPS SubSystem and the MPSS
SubSystems, for the whole lifetime of the system.

To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@somainline.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Frank Rowand <frowand.list@gmail.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

---
Changes in v2:
- Fixed the bindings
- Added some precision on the MPSS DSM in commit messages
- Link to v1: https://lore.kernel.org/r/20221114-narmstrong-sm8550-upstream-mpss_dsm-v1-0-158dc2bb6e96@linaro.org

---
Neil Armstrong (2):
      dt-bindings: reserved-memory: document Qualcomm MPSS DSM memory
      soc: qcom: add MDSS DSM memory driver

 .../reserved-memory/qcom,mpss-dsm-mem.yaml         | 37 +++++++++
 drivers/of/platform.c                              |  1 +
 drivers/soc/qcom/Kconfig                           | 10 +++
 drivers/soc/qcom/Makefile                          |  1 +
 drivers/soc/qcom/mpss_dsm_mem.c                    | 95 ++++++++++++++++++++++
 5 files changed, 144 insertions(+)
---
base-commit: 999e0145579c0e04174044a39257a4d96ee30020
change-id: 20221114-narmstrong-sm8550-upstream-mpss_dsm-21c438c65f9b

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
