Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAD4735709
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 14:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjFSMmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 08:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjFSMmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 08:42:10 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 102EB91
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 05:42:07 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.41:49634.708654646
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id 39BC21001CA;
        Mon, 19 Jun 2023 20:42:03 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-75648544bd-xwndj with ESMTP id 83a1b428dd7a475db363d78ea8e44377 for l.stach@pengutronix.de;
        Mon, 19 Jun 2023 20:42:06 CST
X-Transaction-ID: 83a1b428dd7a475db363d78ea8e44377
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
From:   Sui Jingfeng <15330273260@189.cn>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH v10 00/11] drm/etnaviv: Add pci device driver support
Date:   Mon, 19 Jun 2023 20:41:50 +0800
Message-Id: <20230619124201.2215558-1-15330273260@189.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

There is a Vivante GC1000 (v5037) in LS2K1000 and LS7A1000, this GPU is a
PCI device, and it has 2D and 3D cores in the same core. This series is
trying to add PCI device driver support to drm/etnaviv.

v6:
	* Fix build issue on system without CONFIG_PCI enabled
v7:
	* Add a separate patch for the platform driver rearrangement (Bjorn)
	* Switch to runtime check if the GPU is dma coherent or not (Lucas)
	* Add ETNAVIV_PARAM_GPU_COHERENT to allow userspace to query (Lucas)
	* Remove etnaviv_gpu.no_clk member (Lucas)
	* Various Typos and coding style fixed (Bjorn)
v8:
	* Fix typos and remove unnecessary header included (Bjorn).
	* Add a dedicated function to create the virtual master platform
	  device.
v9:
	* Use PCI_VDEVICE() macro (Bjorn)
	* Add trivial stubs for the PCI driver (Bjorn)
	* Remove a redundant dev_err() usage (Bjorn)
	* Clean up etnaviv_pdev_probe() with etnaviv_of_first_available_node()
v10:
	* Add one more cleanup patch
	* Resolve the conflict with a patch from Rob
	* Make the dummy PCI stub inlined
	* Print only if the platform is dma-coherrent

Rob Herring (1):
  drm/etnaviv: Replace of_platform.h with explicit includes

Sui Jingfeng (10):
  drm/etnaviv: Add a dedicated function to register an irq handler
  drm/etnaviv: Add a dedicated function to get various clocks
  drm/etnaviv: Add dedicated functions to create and destroy platform
    device
  drm/etnaviv: Add helpers for private data construction and destruction
  drm/etnaviv: Allow bypass component framework
  drm/etnaviv: Add driver support for the PCI devices
  drm/etnaviv: Add support for the dma coherent device
  drm/etnaviv: Add a dedicated function to create the virtual master
  drm/etnaviv: Clean up etnaviv_pdev_probe() function
  drm/etnaviv: Keep the curly brace aligned

 drivers/gpu/drm/etnaviv/Kconfig             |  10 +
 drivers/gpu/drm/etnaviv/Makefile            |   2 +
 drivers/gpu/drm/etnaviv/etnaviv_drv.c       | 322 ++++++++++++++------
 drivers/gpu/drm/etnaviv/etnaviv_drv.h       |  10 +
 drivers/gpu/drm/etnaviv/etnaviv_gem.c       |  22 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c |   7 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c       | 166 ++++++----
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h       |   9 +
 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c   |  75 +++++
 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.h   |  18 ++
 include/uapi/drm/etnaviv_drm.h              |   1 +
 11 files changed, 481 insertions(+), 161 deletions(-)
 create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c
 create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.h

-- 
2.25.1

