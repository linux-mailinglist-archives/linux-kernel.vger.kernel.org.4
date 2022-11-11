Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E08626045
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 18:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiKKRSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 12:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbiKKRSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 12:18:03 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6F53F077;
        Fri, 11 Nov 2022 09:18:01 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2ABHHokh079454;
        Fri, 11 Nov 2022 11:17:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668187070;
        bh=yyoNJRT9+sRkSyBtz2H+CMlPQ7h0N1T+j7lp3IM8q4k=;
        h=From:To:CC:Subject:Date;
        b=s/iRlNiOo2JkCS09lTOXx2SGfewFrAza+Xh4n8+KCfPCY64xixThG10A99XedQBUE
         L0Zyx0Sa/zDQlwV25NIPtW4+71sRDrzwzVwIzxk2qIhTU1bzv+Howu1o3zcGRQ3EcX
         WzyaD+OVqQeJsJd+gVlqJbqMjnlMtJt13n8t55Gs=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2ABHHoFO091819
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Nov 2022 11:17:50 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 11
 Nov 2022 11:17:49 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 11 Nov 2022 11:17:49 -0600
Received: from jti.ent.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2ABHHewX028454;
        Fri, 11 Nov 2022 11:17:42 -0600
From:   Georgi Vlaev <g-vlaev@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v3 0/5] firmware: ti_sci: Introduce system suspend support
Date:   Fri, 11 Nov 2022 19:17:34 +0200
Message-ID: <20221111171739.160693-1-g-vlaev@ti.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces necessary ti_sci driver functionality in
preparation of supporting DeepSleep mode for suspend to mem on TI
K3 AM62x. This version is a fixup and rebase of the patch series by
Dave Gerlach [1]. It applies on top of v6.1-rc4.

Deep Sleep mode is described in section "5.2.4.4 DeepSleep" of the
AM62x Technical Reference Manual [2].

The kernel triggers entry to Deep Sleep mode through the mem suspend
transition with the following:

* Use a TF-A binary that supports PSCI_SYSTEM_SUSPEND call. This causes
  system to use PSCI system suspend as last step of mem sleep.

* The firmware requires that the OS sends a TISCI_MSG_PREPARE_SLEEP
  message in order to provide details about suspend, so we must add the
  ability to send this message. We also add TISCI_MSG_LPM_WAKE_REASON
  and TISCI_MSG_SET_IO_ISOLATION messages as part of a new PM ops. These
  messages are part of the TISCI PM Low Power Mode API [3]. (Patch 2)

* A memory address must be provided to the firmware using the above
  message, which is allocated and managed by dma_alloc_coherent()
  and friends. (Patch 3)

* System must load firmware to a specific location before Deep Sleep is
  entered, and this is accomplished using a memory region in device
  tree to indicate where this firmware should be loaded, and also a
  "firmware-name" property to indicate the name of the firmware
  to load. The ti_sci driver checks in its pm handler to see if
  the firmware has been loaded and if not, loads it. (Patch 4)

* Finally, the ti_sci driver must actually send TISCI_MSG_PREPARE_SLEEP
  message to firmware with the above information included, which it
  does during the driver suspend handler when PM_MEM_SUSPEND is the
  determined state being entered. (Patch 5)

This is tested on am625-sk using a limited dts with all devices disabled
apart from cpu0, main_uart0, i2c, rtc, mmc/sd, dmsc, and secure_proxy_main.

Testing this sequence requires K3 sdhci suspend/resume support [4],
enable the wkup_rtc in the am625-sk.dts, disable devices that don't
support system suspend/resume like OSPI and CPSW3G.

In can be tested on the following branch:
https://github.com/gvlaev/linux/tree/upstream-v6.2/lpm-ti-sci-v2

Changelog:
v3:
- Fix the compile warnings on 32-bit platforms reported by the kernel
  test robot in patches (3,5).
- Pick up Roger's "Tested-by" tags.

v2:
- Addressed comments received for v1 series [1].
- Updated v1 patch 5 to use pm notifier to avoid firmware loading
  issues.
- Dropped the reserved region requirement and allocate DMA memory
  instead. The reserved region binding patch is also removed.
- Introduce two more TISCI LPM messages that are supported in SysFW.
- Fixes in error handling.

[1] https://lore.kernel.org/lkml/20220421203659.27853-1-d-gerlach@ti.com
[2] https://www.ti.com/lit/pdf/spruiv7
[3] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html
[4] https://lore.kernel.org/lkml/20220408124338.27090-1-a-govindraju@ti.com

Georgi Vlaev (5):
  dt-bindings: ti, sci: Add lpm region and firmware-name
  firmware: ti_sci: Introduce Power Management Ops
  firmware: ti_sci: Allocate memory for the LPM modes
  firmware: ti_sci: Use dt provided fw name and address to load at
    suspend time
  firmware: ti_sci: Introduce prepare system suspend call

 .../bindings/arm/keystone/ti,sci.yaml         |  21 +-
 drivers/firmware/ti_sci.c                     | 356 ++++++++++++++++++
 drivers/firmware/ti_sci.h                     |  64 +++-
 include/linux/soc/ti/ti_sci_protocol.h        |  44 +++
 4 files changed, 480 insertions(+), 5 deletions(-)


base-commit: f0c4d9fc9cc9462659728d168387191387e903cc
-- 
2.30.2

