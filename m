Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F127200A0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbjFBLsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbjFBLsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:48:15 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7D8E40
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 04:48:13 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-97000a039b2so291226066b.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 04:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685706491; x=1688298491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hXHt/F6cxWFS3BYmXwXGvvRPw+ZTSiBC/eIgUd2mArA=;
        b=wj0XIQP/rTg/5nXkxVSCA53BnQGRxN2J4y5KaqTRdtjxHZxjoUCS1ilNEfFX5Knw4D
         ssFO5DGV7lQZY+iZB3AjN+TwmKaxueV+EdUPTbOdYgl0dF7yfGy5eKLnKdlHwSN9KJbY
         fwRLuOVuO+Gfc8dPgg8crGGdGUphWzALUAdFcrDE1E0MbCN5uDnhZ28KwZpipx+ax1oB
         ZLlRdBBU7rNF9/oiYoU3LyFCu3ap3iePx+HF8X9vF/z2po7uqlblXQGLbEJn68ZupO55
         cEi/8KoaPcL5Sqkt0wAyhjaKGW9yOcq5Z+Iuif0GkW+bsYr8DKAQWosnAUhjfYkkr27S
         ZhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685706491; x=1688298491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXHt/F6cxWFS3BYmXwXGvvRPw+ZTSiBC/eIgUd2mArA=;
        b=d8R6XZy6rAWIwP/ypdthqxlYzIxVwTVANNo+XnAY3PyR5z26RPiZqBpuqoo/G7VUOl
         yKRmWRS+G3NQGiknd8YeZSDKNj4lqhLeGy/JLJQcEaAA1Qo6Ws1tZpdZf8MXehOtwRSt
         GcDvAvxt0jjUY1ey1pFex4M9pIAZJtrjVi1iAeoVHDzFhEGyajFAMmS3dW1W18y1dq7y
         fJo61iji+xk9tBwH1vsm90bCONZfmtAHRhXdF6EcW+tk+m8A7iEDM1FLBNmiFPG91hyr
         yIEngkTvbHJdzJWBTTbRS9rTuL+iIIslmefpezOtNl7hD9LjtIdW5a9jEbadGATrwjrT
         ucyg==
X-Gm-Message-State: AC+VfDxrud8sBWmOWKjq+0IAayKyTTjlITehfEATBzdHVpP0w7M8uJxV
        0XT5tE+wTUS0TCs058MtYDah
X-Google-Smtp-Source: ACHHUZ6iLw5nkvbgddTHDWVNyO3Au6GNkrD3ItgoZVpqW7pxpw2mmntZ7s91z1vHc/uaTTNToG9mKg==
X-Received: by 2002:a17:906:4fca:b0:96f:9a90:c924 with SMTP id i10-20020a1709064fca00b0096f9a90c924mr10508636ejw.74.1685706491469;
        Fri, 02 Jun 2023 04:48:11 -0700 (PDT)
Received: from localhost.localdomain ([117.217.186.79])
        by smtp.gmail.com with ESMTPSA id qu25-20020a170907111900b00974530bb44dsm658924ejb.183.2023.06.02.04.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 04:48:11 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dlemoal@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 0/9] Add support for MHI Endpoint function driver
Date:   Fri,  2 Jun 2023 17:17:47 +0530
Message-Id: <20230602114756.36586-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds support for Modem Host Interface (MHI) Endpoint function
driver and few updates to the PCI endpoint core.

MHI
===

MHI is the communication protocol used by the host machines to control and
communicate with the Qualcomm modems/WLAN devices over any high speed physical
bus like PCIe. In Linux kernel, MHI is modeled as a bus driver [1] and there
are two instances of MHI used in a typical setup.

1. MHI host - MHI implementation for the host machines like x86/ARM64.
2. MHI Endpoint - MHI implementation for the endpoint devices like modems.

MHI EPF
=======

The MHI Endpoint function driver (MHI EPF) is used on the MHI endpoint devices
like modems. The MHI EPF driver sits in between the PCIe EP and MHI EP bus and
carries out all of the PCIe related activities like BAR config, PCIe Event
handling, MMIO read/write etc,... for the MHI EP bus.

Below is the simple representation of the setup:


                 +----------------------------------------------------+
                 |                  Endpoint CPU                      |                   
                 |                                                    |
+------------+   |   +------------+   +-----------+   +-----------+   |
|            |   |   |            |   |           |   |           |   |
|            |   |   |   MHI EP   |   |           |   |           |   | PCIe Bus
|  Modem DSP +---+---+    Bus     +---+  MHI EPF  +---+  PCIe EP  +---+---------
|            |   |   |            |   |           |   |           |   |
|            |   |   |            |   |           |   |           |   |
+------------+   |   +------------+   +-----------+   +-----------+   |
                 |                                                    |
                 |                                                    |
                 +----------------------------------------------------+

The data packets will be read from the Modem DSP by the MHI stack and will be
transmitted to the host machine over PCIe bus with the help of MHI EPF driver.

Test setup
==========

This series has been tested on Snapdragon X55 modem a.k.a SDX55 connected to
the ARM64 host machine.

Thanks,
Mani

[1] https://www.kernel.org/doc/html/latest/mhi/mhi.html

Changes in v6:

* Moved the alloc/map and unmap/free code to separate helper functions and used
  them to avoid code duplication in epf driver.
* Removed superfluous WARN_ON_ONCE() from epf driver.

Changes in v5:

* Moved the PCI EPF driver match logic to pci_epf_match_id() function and used
  that to get the matched driver ID for passing to driver probe instead of
  storing the id during match.
* Added a patch to fix the missing documentation about MSI/MSI-X start vector.
* Addressed the review comments on the MHI EPF driver. Most notably, got rid of
  local variable for tracking MHI registration and used the mhi_dev pointer.
  Also, modified the MSI vector increment comment to make it clear.
* Added a patch for adding MHI EPF driver to MAINTAINERS file

Changes in v4:

* Collected review tag from Kishon
* Changed the IP_SW0 channel numbers as per latest MHI spec

Changes in v3:

* Fixed the probe function of EPF_VNTB driver

Changes in v2:

* Rebased on top of v6.3-rc1
* Switched to the new callback interface for passing events from EPC to EPF
* Dropped one patch related to notifier

Manivannan Sadhasivam (9):
  PCI: endpoint: Add missing documentation about the MSI/MSI-X range
  PCI: endpoint: Pass EPF device ID to the probe function
  PCI: endpoint: Return error if EPC is started/stopped multiple times
  PCI: endpoint: Add linkdown notifier support
  PCI: endpoint: Add BME notifier support
  PCI: qcom-ep: Add support for Link down notification
  PCI: qcom-ep: Add support for BME notification
  PCI: endpoint: Add PCI Endpoint function driver for MHI bus
  MAINTAINERS: Add PCI MHI endpoint function driver under MHI bus

 MAINTAINERS                                   |   1 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |   2 +
 drivers/pci/endpoint/functions/Kconfig        |  10 +
 drivers/pci/endpoint/functions/Makefile       |   1 +
 drivers/pci/endpoint/functions/pci-epf-mhi.c  | 465 ++++++++++++++++++
 drivers/pci/endpoint/functions/pci-epf-ntb.c  |   3 +-
 drivers/pci/endpoint/functions/pci-epf-test.c |   2 +-
 drivers/pci/endpoint/functions/pci-epf-vntb.c |   2 +-
 drivers/pci/endpoint/pci-ep-cfs.c             |   3 +
 drivers/pci/endpoint/pci-epc-core.c           |  56 ++-
 drivers/pci/endpoint/pci-epf-core.c           |  18 +-
 include/linux/pci-epc.h                       |   2 +
 include/linux/pci-epf.h                       |   8 +-
 13 files changed, 560 insertions(+), 13 deletions(-)
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-mhi.c

-- 
2.25.1

