Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2016722FE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjARQYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjARQYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:24:05 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC92B5896B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:22:43 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id f19-20020a1c6a13000000b003db0ef4dedcso1765455wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P4dmctLxdZK3eYAfEKwcOzQh3Gp/4sD4d2HzV/1+Nrw=;
        b=WiY1AS2zer5ahoODjQ8Y3ht6v/Axjn4JLz4yzpsMT+3EKV5+jOsvRZTMHYjiOE/J3S
         DomR/QyEhbR2YXoaItwgpG5J+eTeLO0KZp+BSavxggl16iRIzyuSbMrDqerj+8GkA5W7
         0ngjVMlvaQKh+2xyfZRqnnmydAf4E8wX7Zq8ljk8jPaxu7JhsVBYc5bU7OeXbp0+3uNJ
         uoK9HdMdph+Uc95W3Oz6sfbKUeoeM0IBaCQcAsYSuKfJXrHATpPfOB5r+LXxszRrK4xA
         etYI59rM0OJk5K96CtBuTRX/+uPR36t2WP7mTvceKh9wm2AdVYrxF2vi0pL0aZeZjCXv
         VCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P4dmctLxdZK3eYAfEKwcOzQh3Gp/4sD4d2HzV/1+Nrw=;
        b=Wqlorsp4Rjw9ctnbeg2DsMNzJ11qq5hY+uhbJ0aTqOIv0/AsD8C8riRkzHEUBoi5s4
         nJ0HDY3MeSf6yp85oi6xdEkA7jTUpX5Yf28pMGA1yzXJ71vAxFo1OvsygICPOAACWXOQ
         fSkVneJGUQvxq1Ojhm4FOS/06LdTDHyyzUeciz8SqTa6JHCaSVbA3IrFvuKwTBXlIxm2
         cquvnFo9HcvPZ6FBuB2VaZTXBT2Nj4hHl8coNcOVac2ZifcKyiwJSdF8nQF/znYwJSfI
         IMiOV/olOeoqaWLadRjGV0Ks/dmJwlO21+9/SBcnxBDPrHz/EMzVxhdR0xShzLfgxN9r
         i2PA==
X-Gm-Message-State: AFqh2krf2sqQI2ZTn3fy1+gamO/MDWpiD36UXzKIAWnDy2X+qzHj3JOY
        dZXOGpb2Pa0V7tH9Og9W3hzsGg==
X-Google-Smtp-Source: AMrXdXuSfKEoI9Que22uwdl2DSJT2jjnF4v05Fdzz7/9dp0O0uRIcdpKjO6cvsuzGzA9eJ1QCp8LFg==
X-Received: by 2002:a05:600c:1e21:b0:3d0:7fee:8a70 with SMTP id ay33-20020a05600c1e2100b003d07fee8a70mr7622507wmb.19.1674058962368;
        Wed, 18 Jan 2023 08:22:42 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l23-20020a05600c1d1700b003db0dbbea53sm2744393wms.30.2023.01.18.08.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:22:41 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 0/5] remoteproc: qcom_q6v5_pas: add support for SM8550
 adsp, cdsp & mpss
Date:   Wed, 18 Jan 2023 17:22:39 +0100
Message-Id: <20221114-narmstrong-sm8550-upstream-remoteproc-v4-0-54154c08c0b7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM8cyGMC/53NQWrDMBAF0KsErTtFM5ITt6veI2QhybItsKUwc
 gzB+O6ZZFe6albDH/jvb6pGTrGq78OmOK6pppIl2I+DCqPLQ4TUSVakiRDRQnY814VLHqDObdNo
 uF0lRzcDx7ks8colQKttb3rvjfW9Esu7GsGzy2EULd+mSZ5jqkvh+2t7RTnn/86sCBpQ22Bs8MZ
 /4c+UpFk+Cw/qIhMrvcXSkyUfiKhp7Mn+Yc1brBH2SHgkh11/wvYXu+/7AwWo346OAQAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc:     Alex Elder <elder@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@somainline.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Manivannan Sadhasivam <mani@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Alex Elder <elder@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-remoteproc@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

---
Changes in v4:
- Rebased onto git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git for-next
- Added reviewed-by on bindings patches
- Remove dependency in cover letter since merged
- Link to v3: https://lore.kernel.org/r/20221114-narmstrong-sm8550-upstream-remoteproc-v3-0-62162a1df718@linaro.org

Changes in v3:
- fix mpss matching in bindings, tested against DT
- Link to v2: https://lore.kernel.org/r/20221114-narmstrong-sm8550-upstream-remoteproc-v2-0-12bc22255474@linaro.org

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
 .../bindings/remoteproc/qcom,sm8550-pas.yaml       | 178 ++++++++++++++
 drivers/remoteproc/qcom_q6v5_pas.c                 | 268 ++++++++++++++++++++-
 12 files changed, 501 insertions(+), 21 deletions(-)
---
base-commit: f9721c6a43b63f6428e71b23a435f7f4f4e17af2
change-id: 20221114-narmstrong-sm8550-upstream-remoteproc-804f3fbb34bf

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
