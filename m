Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726D563D352
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbiK3K37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbiK3K3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:29:50 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EDC40476
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:29:49 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so1045374wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=HV1QfaDP0C7g5BpocQkUCoVZ1CZoBTScwwzZ9Edt3Z8=;
        b=jUxkPncGz04s6ZN9p1vlHM8+rOLFjs1dCmiupHjklp+dZWYdl/GW7BTsk3vt9jSY4T
         QWVS7mNK/Zv0PYAsM0wtozo2TnLvCpb42zL413Af7gf5/m8MLEqcGTKgpfINF2nvN2HF
         zPWxjcXbT6b/dSjSD63JanHGYrVpqV6SuakDK8fgyooKaeIcccwWOAPeIJDfovEbYXhZ
         x7R2A5GOOWPGxz5i6fyL9q7fgVhJ47LV1RtaVP+hPrm6V4Mqa1oVYRPKw4JvpC5ao8GP
         AxQCQ2gpJUh6uVqnh26SWuRyWxOyL5RK80yRNteufCxM6DD6osMNljt6mxFF9LHsnpBr
         JaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HV1QfaDP0C7g5BpocQkUCoVZ1CZoBTScwwzZ9Edt3Z8=;
        b=I7gMJgOxo9Hpf1g1od4R6MPrTp9s1c4A47r3hf2UaddMeLtmENOi24z9spDi5IKlkf
         0Ce01gY6+MIaF9I5hxhWIwcljlofgwm6/0Yp0ccyAHY8hCNkVTvd/SqS5RbamOv/0S6C
         mGE6SvzO2Ydc7PEYgH3eGl0zSkwi5R03ntIRc3tYbZfPLNe+QiOrAFo9DP0iAFC6RDBx
         5V3XGiYzcfY6e1se3I6KTywQQl/HPyyQgIwjUmJxiRtPc55esDn0WqfF18OJD7V2/O3t
         2DewwPHk3E3ERCL8ouJHraRWJ+eMe/Qo8KnVC5DKMblk3HCsOaa+orEvshx0KYh0gYSY
         6iRg==
X-Gm-Message-State: ANoB5pnDoBjz2fj2fP6P2fSux+a7DJpJf3jx7DEtLwLp+lil46XvTxnp
        PeNucXdj45Vx0jjBV0YyPvo6JOqxD3ciBfP9
X-Google-Smtp-Source: AA0mqf4/dHTBM+4OQ/uDSsGgNS1NkXPKVr3/NnGOggHORRxIuPv9PeZRGs5Mc37GAEIRN1Ewg28RvQ==
X-Received: by 2002:a05:600c:4f90:b0:3c1:aeb9:29b6 with SMTP id n16-20020a05600c4f9000b003c1aeb929b6mr30434545wmq.97.1669804187778;
        Wed, 30 Nov 2022 02:29:47 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id j33-20020a05600c1c2100b003b4ff30e566sm4313570wms.3.2022.11.30.02.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 02:29:47 -0800 (PST)
Subject: [PATCH v2 0/5] remoteproc: qcom_q6v5_pas: add support for SM8550 adsp, cdsp & mpss
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAJgwh2MC/5WNTQqDMBCFryJZd0r+BNtV71G6SNJRAyaRSRSKePcOvUFXj+/B+94hKlLEKu7dIQ
 j3WGPJDPrSiTC7PCHEN7PQUmullIXsKNVGJU9Q09D3EraVGV0CwlQarlQCDNKOZvTeWD8KdnlXETy5
 HGa25W1ZuJxjbYU+v+9dcTz/vdkVSFDSBmODN/6mHkvkZbkWmsTrPM8v9fiGHOAAAAA=
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 30 Nov 2022 11:29:44 +0100
Message-Id: <20221114-narmstrong-sm8550-upstream-remoteproc-v2-0-12bc22255474@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-remoteproc@vger.kernel.org
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

This patchsets adds support for the aDSP, cDSP and MPSS found in the
SM8550 SoC.

The aDSP, cDSP and MPSS boot process on SM8550 now requires a secondary
"Devicetree" firmware to be passed along the main Firmware, and the cDSP
a new power domain named "NSP".

In order to satisfy the load & authentication order required by the SM8550
SoC, the following is implemented:
- "Devicetree" firmware request & load in dedicated memory
- Q6V5 prepare
- Power Domain & Clocks enable
- "Devicetree" firmware authentication
- Main firmware load in dedicated memory
- Main firmware authentication
- Q6V5 startup
- "Devicetree" firmware metadata release
- Main metadata release

When booting older platforms, the "Devicetree" steps would be
bypassed and the load & authentication order would still be valid.

Bindings changes depends on:
- https://lore.kernel.org/all/20221124184333.133911-1-krzysztof.kozlowski@linaro.org/

To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@somainline.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Manivannan Sadhasivam <mani@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-remoteproc@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

---
Changes in v2:
- Moved the SM8550 pas bindings on top of "split and reorganize PAS/PIL" v3 patchset 
- Incorporated DSM memory support into pas bindings & driver
- Moved second DTB firmware into second entry of firmware-name
- Dropped applied "qcom,fastrpc: increase allowed iommus entries" patch
- Link to v1: https://lore.kernel.org/r/20221114-narmstrong-sm8550-upstream-remoteproc-v1-0-104c34cb3b91@linaro.org

---
Neil Armstrong (5):
      dt-bindings: remoteproc: qcom: adsp: move memory-region and firmware-name out of pas-common
      dt-bindings: remoteproc: qcom: adsp: document sm8550 adsp, cdsp & mpss compatible
      remoteproc: qcom_q6v5_pas: add support for dtb co-firmware loading
      remoteproc: qcom_q6v5_pas: add support for assigning memory to firmware
      remoteproc: qcom_q6v5_pas: add sm8550 adsp, cdsp & mpss compatible & data

 .../devicetree/bindings/remoteproc/qcom,adsp.yaml  |   4 +
 .../bindings/remoteproc/qcom,pas-common.yaml       |   8 -
 .../bindings/remoteproc/qcom,qcs404-pas.yaml       |   8 +
 .../bindings/remoteproc/qcom,sc7180-pas.yaml       |   8 +
 .../bindings/remoteproc/qcom,sc8180x-pas.yaml      |   8 +
 .../bindings/remoteproc/qcom,sc8280xp-pas.yaml     |   8 +
 .../bindings/remoteproc/qcom,sdx55-pas.yaml        |   8 +
 .../bindings/remoteproc/qcom,sm6350-pas.yaml       |   8 +
 .../bindings/remoteproc/qcom,sm8150-pas.yaml       |   8 +
 .../bindings/remoteproc/qcom,sm8350-pas.yaml       |   8 +
 .../bindings/remoteproc/qcom,sm8550-pas.yaml       | 195 +++++++++++++++
 drivers/remoteproc/qcom_q6v5_pas.c                 | 271 ++++++++++++++++++++-
 12 files changed, 521 insertions(+), 21 deletions(-)
---
base-commit: 268975e1af25cd83994d24c46ad0d95753291f64
change-id: 20221114-narmstrong-sm8550-upstream-remoteproc-804f3fbb34bf

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
