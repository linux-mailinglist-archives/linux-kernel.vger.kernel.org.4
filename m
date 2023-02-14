Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76886962EF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjBNMDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjBNMDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:03:03 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135087EC9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:03:01 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id hg24-20020a05600c539800b003e1f5f2a29cso1036918wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I3shvzCeDJk0aJLXCz2Fi53c14j1PwpmIfo6GpvgOlk=;
        b=GpgoiPKZCtdioxmx0gpNue68w9ZlaCkccA7QGPdTjaq0zhsTmu2n/A6Sf2DDTex1eV
         hPu1awwYrwjVOpeW9mbLHBdo+bqvIKl69WQgU1R/+HtrD8JTMJNZzKFn9csfK1XzQ1Qo
         qnf4/FEFukt4IZkJyHVEO46RyN+xTpzg4QIwqp5WJzCo0LNflou2ta2wKp9ddNuqYc/V
         KIM8Ufp43Szcqq94MUptQxETSi2K5Pa0kYxe/uUfYcCOUolVip300AIRHhcVCU3yvRxu
         y4bFXfNvH0JlzH/NinYZfnZjMZy7X+SYCLZ12KGiF3mFysT5KlLnE5gV6v+rAvv1sLJF
         KQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I3shvzCeDJk0aJLXCz2Fi53c14j1PwpmIfo6GpvgOlk=;
        b=bANSFs7XT0s5+FIltNxj1M7ylE36VQf4CEXjnEZCvVAhBduW9edHARLo/n6HIwpGhh
         MzO7/DNptAb3Q4JRPuQXhgzVGSjjlPaQ4l6dD954NTsW335yy1afoNM51iGNohYLnOb7
         m7W6H/4fT2kZnIUWGJBESEamLKOL82726l8jf4MnwGZn7kS/sW2ZEUSI6IWBx3D+CFU7
         EwcOwnaz/jcY72XVbGJxKJq3PFJgvsArcpwxvEaXys8piScI2afCLMr8fkimwFRHc46J
         nJnTjxJMnIVzmQMr3FyEaypwwsvxGA818KPhSSkR8IXCeSIJ6U0UJCkhkwoHP0wqzc1t
         HeDA==
X-Gm-Message-State: AO0yUKUWknrFCBaBlW3yww0XlOBynT/mJmvFpdU+YNer9kDdT/xtp/Sl
        g+RwGzoVDFLMi2xRRGqqtxhkDA==
X-Google-Smtp-Source: AK7set8pUpgbV35UbjeKdI6zHSqyLvAQswd66/w+rS96k/B8bKl4FtFeNT0y8rMY3sTDuDNWKsM8nA==
X-Received: by 2002:a05:600c:4ab0:b0:3de:d9f:3025 with SMTP id b48-20020a05600c4ab000b003de0d9f3025mr1697260wmp.0.1676376179342;
        Tue, 14 Feb 2023 04:02:59 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id l40-20020a05600c1d2800b003dd1b00bd9asm18834846wms.32.2023.02.14.04.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 04:02:58 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Eric Biggers <ebiggers@google.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [RFC PATCH 0/5] Add dedicated Qcom ICE driver
Date:   Tue, 14 Feb 2023 14:02:48 +0200
Message-Id: <20230214120253.1098426-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
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

As both SDCC and UFS drivers use the ICE with duplicated implementation,
while none of the currently supported platforms make use concomitantly
of the ICE IP block, the new SM8550 allows both UFS and SDCC to do so.
In order to support such scenario, there is a need for a unified
implementation and a devicetree node to be shared between both types
of storage devices. So lets drop the duplicate implementation of the ICE
from both SDCC and UFS and make it a dedicated (soc) driver.

This RFC should be treated as work-in-progress. Initially, its goal is
to figure out what is the most agreeable implementation for both types
of storage. Note that currently, only one ICE instance is supported
(like the existing HW suggests) and it is laking refcounting and locking
of any sort. Also missing bindings schema file for now.

Any suggestions are welcome at this point, including the location of
such a new driver.

Abel Vesa (5):
  soc: qcom: Make the Qualcomm UFS/SDCC ICE a dedicated driver
  arm64: dts: qcom: sm8450: Add the Inline Crypto Engine node
  arm64: dts: qcom: sdm630: Add the Inline Crypto Engine node
  scsi: ufs: ufs-qcom: Switch to the new ICE API
  mmc: sdhci-msm: Switch to the new ICE API

 arch/arm64/boot/dts/qcom/sdm630.dtsi          |  18 +-
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts       |   4 +
 arch/arm64/boot/dts/qcom/sm8450.dtsi          |  24 +-
 drivers/mmc/host/sdhci-msm.c                  | 252 ++----------------
 drivers/soc/qcom/Kconfig                      |  10 +
 drivers/soc/qcom/Makefile                     |   1 +
 .../ufs-qcom-ice.c => soc/qcom/qcom-ice.c}    | 247 +++++++++++------
 drivers/ufs/host/Kconfig                      |   1 -
 drivers/ufs/host/Makefile                     |   1 -
 drivers/ufs/host/ufs-qcom.c                   |  42 ++-
 drivers/ufs/host/ufs-qcom.h                   |  32 +--
 include/soc/qcom/ice.h                        |  61 +++++
 12 files changed, 326 insertions(+), 367 deletions(-)
 rename drivers/{ufs/host/ufs-qcom-ice.c => soc/qcom/qcom-ice.c} (50%)
 create mode 100644 include/soc/qcom/ice.h

-- 
2.34.1

