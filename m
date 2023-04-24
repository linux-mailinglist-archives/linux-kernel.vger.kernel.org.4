Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D16C6ED11D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjDXPPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjDXPPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:15:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64AF65A7;
        Mon, 24 Apr 2023 08:15:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BF41625E8;
        Mon, 24 Apr 2023 15:15:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1830C433EF;
        Mon, 24 Apr 2023 15:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682349328;
        bh=ehNtbOjPXKCjxTzYSbGk5qzu8/Du9Cfnuq4TM4fmjsM=;
        h=From:To:Cc:Subject:Date:From;
        b=e+tVp8aFRMBYnfQ1C8DZg1wjamIsoNJMnFId6uPCev1K1nrapaiPma2mk7plKMig/
         Jz4jfwkiHTcU3XybJx8xlNLMIAMt9HHS6f7aMUzHgXnJsTrmTzpybCkION5g2AWXTt
         qnHcwzhlCSXTrP5dz9l7rOCTZrTCrEzWhYCFBbzsIotWT18gnOva4tJfjWeX8MT5zT
         vh8EjhdiUmSOT4l5VrxfCYDQoUU6Y+Ropcc3XP8/9trSR8TGXIcGjpyVEcT79/MEVz
         tRgA50E2i2GVzkqzrE6zV4xkcHKwmKHW7RtTZO69EuO/06/Y4qygFLdMFt3tLZfGu3
         jpdDu5NpJbwkA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        Rob Herring <robh@kernel.org>,
        Markus Elfring <Markus.Elfring@web.de>,
        Simon Horman <horms@kernel.org>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Yu Zhe <yuzhe@nfschina.com>
Subject: [GIT PULL] remoteproc updates for v6.4
Date:   Mon, 24 Apr 2023 08:19:12 -0700
Message-Id: <20230424151912.278066-1-andersson@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git rproc-v6.4

for you to fetch changes up to 1f6fa392a9942e4a2bd3122913baeb33e987ccd9:

  remoteproc: st: Use of_property_present() for testing DT property presence (2023-04-18 18:56:51 -0700)

----------------------------------------------------------------
remoteproc updates for v6.4

Unnecessary type casts from the void * rproc->priv pointer is dropped
throughout te subsystem.

A kernel-doc error is corrected in the Mediatek SCPI IPI implementation.

The firmware loading onto the IMX DSP remote processors is reworked to
avoid non-32bit memory operations. A module parameter is introduced to
assist development of firmware without communication abilities in place.
Error paths in imx_dsp_rproc_mbox_alloc() is cleaned up.

The cluster configuration handling in the TI K3 R5 driver is corrected
and support for the single-R5 core found in the TI AM62x SoC family is
introduced.

The TI PRU driver device- to virtual-address translation is updated to
avoid compiler warning about the unsigned device-address always being
larger than 0.

The ST remoteproc driver is transitioned to use of_property_present().

Issues with kicks arriving after the STM32 remote processor has been
shut down are mitigated by checking the processor's state before
handling them.

Support for mailbox channels for communication with the remote
processors are added to the Xilinx R5 remoteproc driver. The naming of
carveouts are corrected and their parsing is reworked.
For this a couple of fixes targeting the mailbox subsystem are picked up
here as well.

Reference counting of of_nodes are corrected in the ST, STM32, RCAR and
IMX remoteproc drivers.

----------------------------------------------------------------
Arnaud Pouliquen (2):
      remoteproc: stm32_rproc: Add mutex protection for workqueue
      dt-bindings: remoteproc: stm32-rproc: Typo fix

Devarsh Thakkar (3):
      remoteproc: k3-r5: Simplify cluster mode setting usage
      dt-bindings: remoteproc: ti: Add new compatible for AM62 SoC family
      remoteproc: k3-r5: Use separate compatible string for TI AM62x SoC family

Iuliana Prodan (2):
      remoteproc: imx_dsp_rproc: Add module parameter to ignore ready flag from remote processor
      remoteproc: imx_dsp_rproc: Add custom memory copy implementation for i.MX DSP Cores

Markus Elfring (1):
      remoteproc: imx_dsp_rproc: Improve exception handling in imx_dsp_rproc_mbox_alloc()

Mathieu Poirier (6):
      remoteproc: stm32: Call of_node_put() on iteration error
      remoteproc: st: Call of_node_put() on iteration error
      remoteproc: rcar_rproc: Call of_node_put() on iteration error
      remoteproc: imx_rproc: Call of_node_put() on iteration error
      remoteproc: imx_dsp_rproc: Call of_node_put() on iteration error
      remoteproc: imx_dsp_rproc: Fix kernel test robot sparse warning

Rob Herring (2):
      dt-bindings: remoteproc: Drop unneeded quotes
      remoteproc: st: Use of_property_present() for testing DT property presence

Simon Horman (1):
      remoteproc: pru: Remove always true check positive unsigned value

Tanmay Shah (5):
      mailbox: zynqmp: Fix counts of child nodes
      mailbox: zynqmp: Fix IPI isr handling
      mailbox: zynqmp: Fix typo in IPI documentation
      drivers: remoteproc: xilinx: Fix carveout names
      remoteproc: xilinx: Add mailbox channels for rpmsg

Yang Li (1):
      remoteproc/mtk_scpi_ipi: Fix one kernel-doc comment

Yu Zhe (1):
      remoteproc: Remove unnecessary (void*) conversions

 .../remoteproc/amlogic,meson-mx-ao-arc.yaml        |   4 +-
 .../bindings/remoteproc/fsl,imx-rproc.yaml         |   4 +-
 .../bindings/remoteproc/ingenic,vpu.yaml           |   4 +-
 .../bindings/remoteproc/qcom,glink-edge.yaml       |   2 +-
 .../bindings/remoteproc/qcom,smd-edge.yaml         |   2 +-
 .../bindings/remoteproc/renesas,rcar-rproc.yaml    |   4 +-
 .../bindings/remoteproc/st,stm32-rproc.yaml        |  18 +-
 .../bindings/remoteproc/ti,k3-r5f-rproc.yaml       |  76 +++--
 drivers/mailbox/zynqmp-ipi-mailbox.c               |  13 +-
 drivers/remoteproc/da8xx_remoteproc.c              |  12 +-
 drivers/remoteproc/imx_dsp_rproc.c                 | 249 ++++++++++++++--
 drivers/remoteproc/imx_rproc.c                     |   7 +-
 drivers/remoteproc/mtk_scp.c                       |  12 +-
 drivers/remoteproc/mtk_scp_ipi.c                   |   2 +-
 drivers/remoteproc/pru_rproc.c                     |   5 +-
 drivers/remoteproc/qcom_q6v5_adsp.c                |  10 +-
 drivers/remoteproc/qcom_q6v5_mss.c                 |   8 +-
 drivers/remoteproc/qcom_q6v5_pas.c                 |  14 +-
 drivers/remoteproc/qcom_wcnss.c                    |  10 +-
 drivers/remoteproc/rcar_rproc.c                    |   9 +-
 drivers/remoteproc/st_remoteproc.c                 |   7 +-
 drivers/remoteproc/stm32_rproc.c                   |  14 +-
 drivers/remoteproc/ti_k3_r5_remoteproc.c           | 127 +++++---
 drivers/remoteproc/xlnx_r5_remoteproc.c            | 324 ++++++++++++++++-----
 include/linux/mailbox/zynqmp-ipi-message.h         |   2 +-
 25 files changed, 710 insertions(+), 229 deletions(-)
