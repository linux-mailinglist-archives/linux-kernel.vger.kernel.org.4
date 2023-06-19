Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F92735AAB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 17:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjFSPF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 11:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFSPFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 11:05:07 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2291C199F
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 08:04:18 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-25ec175b86bso2339155a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 08:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687187057; x=1689779057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ijoPficGMbC8MNoj6bix6NY7Kbw2jw00NC2bUq8rco=;
        b=NZohB7jULHtqmwtPONNyPyf6F6F21c9VTWQVX78xQnVRRRN5TT9252RlBsUu9fRAvl
         tyCMversYp/dLi1xDvws1ot3xjDQb983M391KxCCwzxFSmQWXIPZ6A8r++NrceIzn0+I
         zdde4fidaTFqUxkWLOdvU76L7W33O1oDj/VC7pfkjLhsHdEY1TbE6dIEy0s8x9tSleJt
         +fWoxTdf8XlqLchKyZfU8vFR8yN93ly0LCoMw4DjkDAlPWqrisl+mNrIyrb2Fz49Ix4I
         x3mSgqDd9BJb3/QdnRQQVmXfHyf71oAZmxSagmwqMJsI56usVroryAGqYZAA5mG1E598
         tCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687187057; x=1689779057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ijoPficGMbC8MNoj6bix6NY7Kbw2jw00NC2bUq8rco=;
        b=ON6n2lz6P/jEND8DBVXhHVtXlRB8TxL27OznEy+XKlix4yrqKJIiACtjVUJ9sirJ4N
         tCrAEfXgfE4Q42cAmTVsc8awAjiA6xj5D6oCFKCBMETJ8LpkthW/gPuQqBVFRFmLLPFI
         vStHTTphKPJ7AtpkdfP2R/fK4IK8LuuuAsBsmBPSEQChzpMbrtVufxAdq6o//iU0NQHl
         sQZ1e3FKkCZ3fQXrV3kIvIT3z/R/39wIEiUJdldcAYYlbzwsxsyOqBmQ/kp5q7RVLiAq
         jobMut/f1zxL1YgOgnU8+lSU818J08O9gh/AOVpjvXcT0IoHEOop2h9ffCX3EJ+EZwMh
         A3jA==
X-Gm-Message-State: AC+VfDzVEPfRUnWy/mR885E/Oq23tfdNvgm52fxJ9bwrsKMcF4yoR/gG
        FFuFnnesFYYyblHcmeFd/4Cj
X-Google-Smtp-Source: ACHHUZ6tI13kW3PqxOgCDdRV/bnoOp0Af7lFbtRpF/0aJZMLjxoWidISPg+wC/5GklYEq+HPXXgdPg==
X-Received: by 2002:a17:90b:11d2:b0:25e:aedf:e82b with SMTP id gv18-20020a17090b11d200b0025eaedfe82bmr9751107pjb.15.1687187057447;
        Mon, 19 Jun 2023 08:04:17 -0700 (PDT)
Received: from localhost.localdomain ([117.217.183.37])
        by smtp.gmail.com with ESMTPSA id 10-20020a17090a19ca00b0025efaf7a0d3sm2765480pjj.14.2023.06.19.08.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 08:04:16 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 0/9] PCI: qcom: Do not advertise hotplug capability
Date:   Mon, 19 Jun 2023 20:33:59 +0530
Message-Id: <20230619150408.8468-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The SoCs making use of Qualcomm PCIe controllers do not support the PCIe hotplug
functionality. But the hotplug capability bit is set by default in the hardware.
This causes the kernel PCI core to register hotplug service for the controller
and send hotplug commands to it. But those commands will timeout generating
messages as below during boot and suspend/resume.
    
[    5.782159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2020 msec ago)
[    5.810161] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2048 msec ago)
[    7.838162] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2020 msec ago)
[    7.870159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2052 msec ago)
    
This not only spams the console output but also induces a delay of a couple of
seconds. To fix this issue, this series clears the HPC bit in PCI_EXP_SLTCAP
register as a part of the post init sequence for all IP versions to not
advertise the hotplug capability for the controller.

Testing
=======

This series has been tested on DB845c (SDM845 SoC) and Lenovo Thinkpad X13s
(SC8280XP SoC).

Thanks,
Mani

Changes in v4:

* Splitted patch 1/8 into two
* Rebased on top of pci/next

Changes in v3:

* Dropped double signed-off tags
* Dropped Dmitry's gmail reviewed tag as per his request
* Mentioned the newline change in commit log of patch 2/8

Changes in v2:

* Collected tags
* Moved the HPC clearing to a separate function and reused across different
  configs

Manivannan Sadhasivam (9):
  PCI: qcom: Disable write access to read only registers for IP v2.3.3
  PCI: qcom: Use DWC helpers for modifying the read-only DBI registers
  PCI: qcom: Disable write access to read only registers for IP v2.9.0
  PCI: qcom: Do not advertise hotplug capability for IPs v2.7.0 and
    v1.9.0
  PCI: qcom: Do not advertise hotplug capability for IPs v2.3.3 and
    v2.9.0
  PCI: qcom: Do not advertise hotplug capability for IP v2.3.2
  PCI: qcom: Use post init sequence of IP v2.3.2 for v2.4.0
  PCI: qcom: Do not advertise hotplug capability for IP v1.0.0
  PCI: qcom: Do not advertise hotplug capability for IP v2.1.0

 drivers/pci/controller/dwc/pcie-qcom.c | 73 ++++++++++++++------------
 1 file changed, 38 insertions(+), 35 deletions(-)

-- 
2.25.1

