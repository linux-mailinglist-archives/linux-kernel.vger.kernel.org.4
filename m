Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C74612393
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 16:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiJ2OQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 10:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJ2OQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 10:16:45 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F915EDEB
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 07:16:44 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id f9so7165281pgj.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 07:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GQ4PiNcI1cLiE7ryjV3rS13VZXM0Dj58HsM9AOiZxhg=;
        b=oElrO+L1rk9mNgPaQGCjkZqLOoN/67uzSPW+WcTDNV/dlPycNO8b7MS7IsMpWIqNYF
         xUKaohiK08X2rxqOr13PkPDChzujijVPpSmqeRsCG7kud8ymS/F0+HcRTnPW6YYan+yE
         3+cWdpU8fOsgsRZYLXIRI02fIS0y2CeZAwSxlu+5fUeu1jdfyfDoq6Caf6QXsldiT/jD
         SzhPRlTtn1xW79PNSMOhpUNh/SJ1FAx9j4LyXvmmK5rJEIhjWxpaziqq8dBgcSbPQ+/B
         /Ap/tPE5e76VysGg9KnP9bcX+MsEHSt5O1haM/qoj16CapP+unQWLDmi3wBOt4lNbfbq
         5Gcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQ4PiNcI1cLiE7ryjV3rS13VZXM0Dj58HsM9AOiZxhg=;
        b=uHK4jCtqcXH0bgSRE4dJYxXl2v7IDpm9onWbUiFjd1cnthh0MIgBu2oXbeoDZSjCGM
         QuMNwUjTY54FFOV3fLTdoWlrjpfbSFKgc/8EN8fzbwypiK6OBkcT/1mBHKPvQAKqXDiQ
         lPj1FE2/WdzhtId6ylqdwWcBEzlevCa1PYXFSCJtxgvGkeKkhbA0RExw8nb2PLR0y+mi
         /VXD8iif6T1wO9HV4FP0VcGM/DcgZ8rP41yp6NKTBsTHYRC5lvfIrIa3/GTJBHkzJs/2
         7lu5hB6H9vSptfjC1NVIjAu9SdKZ6HKyW4CWBJ24qy567HWvUFoF90jWY822n5zSLPJ6
         mmvg==
X-Gm-Message-State: ACrzQf0GQ9gWENotLFKuxmBh8cWFPRP1JRhYRuR/FP8ysQ8gBq1u6+vK
        Or5gZNnVDB2W/qK/Ees6kNJ0
X-Google-Smtp-Source: AMsMyM6rJuqEreNrU5xX/uOHOar39X19G2dhV8I6IvYMk82ydVaceF1ziLNEgSrN26R2pCFJQ7ehaQ==
X-Received: by 2002:a65:6d93:0:b0:42c:50ec:8025 with SMTP id bc19-20020a656d93000000b0042c50ec8025mr4151085pgb.62.1667053003345;
        Sat, 29 Oct 2022 07:16:43 -0700 (PDT)
Received: from localhost.localdomain ([117.193.208.18])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001866049ddb1sm1370157plf.161.2022.10.29.07.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 07:16:42 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        quic_cang@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 00/15] ufs: qcom: Add HS-G4 support
Date:   Sat, 29 Oct 2022 19:46:18 +0530
Message-Id: <20221029141633.295650-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds HS-G4 support to the Qcom UFS driver and PHY driver.
The newer Qcom platforms support configuring the UFS controller and PHY
in dual gears (i.e., controller/PHY can be configured to run in two gear
speeds). This is accomplished by adding two different PHY init sequences
to the PHY driver and the UFS driver requesting the one that's required
based on the platform configuration.

But this requires both the UFS controller and UFS device to agree to a
common gear. For finding the max supported gear, a separate register is
used for the UFS controller and devicetree is used for the UFS device.
Based on the max gear of both, the UFS driver will decide which gear to
use during runtime.

This series has been tested on Qcom RB5 development platform powered by
SM8250 SoC that uses HS-G4.

Merging Strategy:
-----------------

The PHY patches are expected to go through PHY tree and UFS, MAINTAINERS
patches are expected to go through SCSI tree. Finally, the binding and
devicetree patches can go through ARM MSM tree. There is no build dependency
between the patches.

Thanks,
Mani

Manivannan Sadhasivam (15):
  phy: qcom-qmp-ufs: Move register settings to qmp_phy_cfg_tables struct
  phy: qcom-qmp-ufs: Add support for configuring PHY in HS Series B mode
  phy: qcom-qmp-ufs: Add support for configuring PHY in HS G4 mode
  phy: qcom-qmp-ufs: Add HS G4 mode support to SM8250 SoC
  phy: qcom-qmp-ufs: Move HS Rate B register setting to tables_hs_b
  dt-bindings: ufs: Add "max-gear" property for UFS device
  arm64: dts: qcom: qrb5165-rb5: Add max-gear property to UFS node
  scsi: ufs: ufs-qcom: Remove un-necessary goto statements
  scsi: ufs: ufs-qcom: Remove un-necessary WARN_ON()
  scsi: ufs: ufs-qcom: Use bitfields where appropriate
  scsi: ufs: ufs-qcom: Use dev_err_probe() for printing probe error
  scsi: ufs: ufs-qcom: Fix the Qcom register name for offset 0xD0
  scsi: ufs: ufs-qcom: Factor out the logic finding the HS Gear
  scsi: ufs: ufs-qcom: Add support for finding HS gear on new UFS
    versions
  MAINTAINERS: Add myself as the maintainer for Qcom UFS driver

 .../devicetree/bindings/ufs/ufs-common.yaml   |   5 +
 MAINTAINERS                                   |   8 +
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      |   1 +
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       | 350 +++++++++++++-----
 drivers/ufs/host/ufs-qcom.c                   | 177 +++++----
 drivers/ufs/host/ufs-qcom.h                   |  64 ++--
 6 files changed, 389 insertions(+), 216 deletions(-)

-- 
2.25.1

