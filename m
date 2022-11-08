Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2C5620732
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 04:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbiKHDEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 22:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbiKHDEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 22:04:40 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BAA30548;
        Mon,  7 Nov 2022 19:04:25 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id z6so8049889qtv.5;
        Mon, 07 Nov 2022 19:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rkIMOBSS3ypVsdn15tuhOs5mmYH7IO0HzwnEY+I3eho=;
        b=AfQKzSnjYn7tjFvQXb9Bizqt0k4Bua80a/j1tdphzrOQO9Vpa9IovM26k0335K9yHQ
         CSg0Y70qlXHOzAtoHUnjlqqKZbN8mCEfex5Dx0h75GhxJ9dukp0aUU7a3u50md2bQQBh
         yjfzRjBiCMmhLq0O9HXXYjIyBjh/4eljROwwP83oIs8EYRByNGtKMrSqBhdIk8bybGOq
         D5LUP0VDyRnGTpBRWvdlBiS5cE+imcDYyeYKHwdcTjijCgvn1y6zTJG7/rZyKsrbaUbb
         COlGo8fYlLh8FOVmNKXLwr2+3x4j+Kq7RG8YY/Ahd9jYxAloYKSDnnFKyjrt9JLPRgeq
         wPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rkIMOBSS3ypVsdn15tuhOs5mmYH7IO0HzwnEY+I3eho=;
        b=C77HYUA2y/X5MmDy2Hx61IkSJmVAuAJie98YvBjcV5N7CstG/1AD+6M4dAVK1dboUs
         GsWbtpwEuFDwM2d8jJxwna2WM1GyTAgv/pmcjw5gzKfH3cE58urdMQ9ol48Z1XyQERhI
         mJnKk7GqbT7RppFlD4D6DTGmyDRbsvxnmESLEDbQBIXyvfLmusZoVXWmPAMFrW6pucQn
         uvn+cbBoLRBi/h5N7GidrCODasNCOVS7ASYFsT89M/TTJR0O+76yip9nnb7DUIK7iuPX
         IU0ue8PXGVLIMpk3CNpwmhXD63pX+mKiVeLY4LMcAHacxWnx1JNu4WLL+RDKAZuYk2Os
         nwow==
X-Gm-Message-State: ACrzQf1uPwFZLJlJRGi1trORjKo3OSsYJ44fn+g2UWg45ezo0JQAqlv2
        QtdEXXgcRT4p9lQQs+FWru4=
X-Google-Smtp-Source: AMsMyM6PJRwhTna0XKwPWKldchpUG/4X98+LNNTGwZ5hXHWgtdW6Le4yC6D7uKrS2//Bmgc23CXqIg==
X-Received: by 2002:a05:622a:4d44:b0:3a5:2c05:9e12 with SMTP id fe4-20020a05622a4d4400b003a52c059e12mr33661012qtb.481.1667876664576;
        Mon, 07 Nov 2022 19:04:24 -0800 (PST)
Received: from localhost ([2607:fea8:a2e2:2d00::61cc])
        by smtp.gmail.com with ESMTPSA id fw9-20020a05622a4a8900b003a56d82fd8csm7248694qtb.91.2022.11.07.19.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 19:04:24 -0800 (PST)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v3 0/4] Initial SDM670 and Pixel 3a support
Date:   Mon,  7 Nov 2022 22:04:07 -0500
Message-Id: <20221108030411.59409-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:
 - remove intc address and size cells (4/4)
 - move apps_rsc label property down (4/4)
 - move properties in intc (4/4)
 - remove leading zeroes in iommus (4/4)
 - change 0x0 to 0 in regs except cpu (4/4)
 - change 0 to 0x0 in memory regs (4/4)
 - convert hex to decimal in rmi4 #cells properties (4/4)

Changes since v1:
 - remove i2c interconnects (4/4)
 - change regulator phandle names (4/4)
 - change regulators node names (4/4)
 - remove clock-output-names from xo-board (4/4)
 - remove vdd-supply from touchscreen (4/4)
 - move clocks to device dts (4/4)
 - reorder pmic nodes, root nodes, and phandle references in dts (4/4)
 - move status properties to bottom of nodes (4/4)
 - accumulate commit message tags (1-3/4)

Do not apply this series yet. It is only for review comments. It can be
applied once the "qcom,sdm670-smmu-500" compatible string gets added (or
now if you don't care about handling an unnecessary quirk).

This adds the device trees and bindings to support the Qualcomm
Snapdragon 670 and Google Pixel 3a. This patch series, specifically the
last patch, depends on:

[PATCH v4 0/3] SDM670 Global Clocks
  https://lore.kernel.org/all/20220914013922.198778-1-mailingradian@gmail.com/T/
[PATCH v2 0/2] RPMh Support for PM660 and PM660L
  https://lore.kernel.org/all/20220920223331.150635-1-mailingradian@gmail.com/T/
[PATCH v2 0/2] SDM670 RPMh Clocks
  https://lore.kernel.org/all/20220920223734.151135-1-mailingradian@gmail.com/T/
[PATCH v2 0/2] SDM670 USB 2.0 support
  https://lore.kernel.org/all/20220922024656.178529-1-mailingradian@gmail.com/T/
[PATCH 0/2] SDM670 SDHCI support
  https://lore.kernel.org/all/20220923014322.33620-1-mailingradian@gmail.com/T/
[PATCH v2 0/2] SDM670 Power Domains
  https://lore.kernel.org/all/20221004221130.14076-1-mailingradian@gmail.com/T/
[PATCH v10 0/3] SDM670 Pin Control Driver
  https://lore.kernel.org/all/20221014001934.4995-1-mailingradian@gmail.com/T/
[PATCH v6 0/4] SDM670 GPI DMA support
  https://lore.kernel.org/all/20221018005740.23952-1-mailingradian@gmail.com/T/
[RFC PATCH v2 0/11] iommu/arm-smmu-qcom: Rework Qualcomm SMMU bindings and implementation
  https://lore.kernel.org/linux-arm-msm/20221102184420.534094-1-dmitry.baryshkov@linaro.org/T/
[PATCH v4 0/1] iommu: SMMU for SDM670
  https://lore.kernel.org/linux-arm-msm/20221108025847.58352-1-mailingradian@gmail.com/T/

P.S.: Thank you to all the maintainers and reviewers who went through
everything and made helpful comments!

Richard Acayan (4):
  dt-bindings: arm: cpus: add qcom kryo 360 compatible
  dt-bindings: arm: qcom: add sdm670 and pixel 3a compatible
  dt-bindings: firmware: scm: add sdm670 compatible
  arm64: dts: qcom: add sdm670 and pixel 3a device trees

 .../devicetree/bindings/arm/cpus.yaml         |    1 +
 .../devicetree/bindings/arm/qcom.yaml         |    6 +
 .../bindings/firmware/qcom,scm.yaml           |    1 +
 arch/arm64/boot/dts/qcom/Makefile             |    1 +
 .../boot/dts/qcom/sdm670-google-sargo.dts     |  533 ++++++++
 arch/arm64/boot/dts/qcom/sdm670.dtsi          | 1160 +++++++++++++++++
 6 files changed, 1702 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sdm670.dtsi

-- 
2.38.1

