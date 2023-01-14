Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B6266A9CB
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 08:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjANHKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 02:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjANHKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 02:10:18 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AE24EEE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 23:10:16 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id m7-20020a17090a730700b00225ebb9cd01so29075976pjk.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 23:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sSRWg/4zGEapOLoUyhMBgX8aOXNkOAFMgET/1+nTQE4=;
        b=bRJcssISo9IAfeK4THgoBt6skESEzyfXTePiPnw0yhJweh5YhPuTh2W/8PemUboL+8
         ztySbBz4eO3FS5SlVxjtrAd+CtqchUJU+WAM34Ln5pKxO0+geu4fKjcN1gX9ztpERlON
         OQfssc0igRxGC6KdnDyealcTYGAL4QdllVKAX5q/LCMET+0wvg3YQWdKGnX5pneg/Kdv
         qgtd8wKUV4+sH9D5VzShC2HuIy0mOfPH/OKFwvFaX1wHc4uzQmtIEQ6qjHuXDcDbtKeM
         nmzmMeBYpkUl4t03ym9sX443wnoiz1lsEUvJZOrRQv+dzCVWtFzn6NFWAVkPQctYP/VG
         4Oow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sSRWg/4zGEapOLoUyhMBgX8aOXNkOAFMgET/1+nTQE4=;
        b=mQxmmC29PgJS2T2tPF4WJwETaOsnroYu0EoOHfHtaA8WeIRyuJoO5ICGaBnoKk/Uw4
         YdvMrC9QrvE89u92vz1SgDEnV0ShhXcy/GHJKzxoTQbE9eSXiuR2jZ7X476c9/kxxkP6
         VZcDO5L/9AW22sVZ+nSja4fnbrVRrpra4w7F6MYMwQBSRO+L1palqHstMpknldU5DLRB
         DdEd0FKBa8WqBVUZMMz9Ukw42SZqS0TCdmZgKn0bDiDphMthoXTyiverOlzBHMD0Vklb
         OA7LMOfyqfsoA1SDQ/TjSKXWzuU6zpf5kYELrSn2TrDZ4TKpTHdkdkIVaNiVrT2VAGGS
         0MbA==
X-Gm-Message-State: AFqh2krlIo8rl3Zp1G1oKelHAoUdT4kwnNBRVt+tZAAVP+GEpW0euRX+
        JyM4jqiatRHD65oIZC1U2xyk
X-Google-Smtp-Source: AMrXdXsQyL9okZ8HVHcbKkohG31EAuqNbrZIJsCcIOcofHKEjPOsG2qPhe1otBe2CoHDuA6CmBA/ww==
X-Received: by 2002:a17:903:2614:b0:194:6627:d7ab with SMTP id jd20-20020a170903261400b001946627d7abmr7212332plb.12.1673680215934;
        Fri, 13 Jan 2023 23:10:15 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.156])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902e30a00b00192a04bc620sm15225358plc.295.2023.01.13.23.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 23:10:14 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vkoul@kernel.org
Cc:     andersson@kernel.org, quic_cang@quicinc.com,
        quic_asutoshd@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        abel.vesa@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 00/12] ufs: qcom: Add HS-G4 support
Date:   Sat, 14 Jan 2023 12:39:57 +0530
Message-Id: <20230114071009.88102-1-manivannan.sadhasivam@linaro.org>
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

Initially the ufs-qcom driver will use the default gear G2 for enumerating
the UFS device. Afer enumeration, the max gear supported by both the
controller and device would be found out and that will be used thereafter.
But for using the max gear after enumeration, the ufs-qcom driver requires
the UFS device to be reinitialized. For this purpose, a separate quirk has
been introduced in the UFS core along with a callback and those will be used
by the ufs-qcom driver.

This series has been tested on following platforms:

* Qcom RB5 development platform powered by SM8250 SoC
* SM8450 based dev board
* Qdrive3/sa8540p-ride board based on SC8280XP (derivative)

Merging Strategy:
-----------------

The PHY patches are expected to go through PHY tree and UFS, MAINTAINERS
patches are expected to go through SCSI tree.

NOTE: Since this series targets multiple SoCs (base like SM8350) and
(derivative like SC8280XP), testing on all of these platforms is really
appreciated. Although, if the series works for base SoC, then for derivatives
also it should work.

Thanks,
Mani

Changes in v6:

* Rebased on top of phy/next
* Dropped SCSI patches as they got applied

Changes in v5:

* Collected Review and tested-by tags
* Reworded patch 18/23 (Bart) and also the comment for reinit_notify

Changes in v4:

* Dropped HS G3 specific setting from SM8350 default init sequence
* Added G4 support to SM8350 and SC8280XP
* Covered all qcom files under drivers/ufs/host in MAINTAINERS file
* Added missing Suggested-by tags for Can Guo
* Rebased on top of linux-next 20221201

Changes in v3:

* Dropped the "device-max-gear" DT property and switched to reinitialization (Krzysztof)
* Added HS-G4 support to all compatible SoCs (SM8150, SM8250 and SM8450). This will also
  benefit the derivative SoCs of these platforms like SC8180x, SC8280x etc...
* Splitted the qmp_phy_init_tbl changes into separate patches (Vinod)
* Collected reviews from Andrew H

Changes in v2:

* Collected reviews from Dmitry
* Renamed "max-gear" property to "max-device-gear"
* Used min() for deciding which gear to use instead of open comparision
* Added comment about the old register name

Manivannan Sadhasivam (12):
  phy: qcom-qmp-ufs: Remove _tbl suffix from qmp_phy_init_tbl
    definitions
  phy: qcom-qmp-ufs: Rename MSM8996 PHY definitions
  phy: qcom-qmp-ufs: Move register settings to qmp_phy_cfg_tbls struct
  phy: qcom-qmp-ufs: Add support for configuring PHY in HS Series B mode
  phy: qcom-qmp-ufs: Add support for configuring PHY in HS G4 mode
  phy: qcom-qmp-ufs: Move HS Rate B register setting to tbls_hs_b
  phy: qcom-qmp-ufs: Add HS G4 mode support to SM8150 SoC
  phy: qcom-qmp-ufs: Add HS G4 mode support to SM8250 SoC
  phy: qcom-qmp-ufs: Avoid setting HS G3 specific registers
  phy: qcom-qmp-ufs: Add HS G4 mode support to SM8350 SoC
  phy: qcom-qmp-ufs: Add HS G4 mode support to SM8450 SoC
  phy: qcom-qmp-ufs: Add HS G4 mode support to SC8280XP SoC

 .../phy/qualcomm/phy-qcom-qmp-pcs-ufs-v5.h    |   1 +
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       | 454 +++++++++++++-----
 2 files changed, 339 insertions(+), 116 deletions(-)

-- 
2.25.1

