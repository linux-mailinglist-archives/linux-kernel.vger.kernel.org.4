Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3191F725C25
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239815AbjFGK4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbjFGK4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:56:10 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2BBE1BD8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 03:56:01 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.31:55208.1520123491
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id 595B31002AB;
        Wed,  7 Jun 2023 18:55:58 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-75648544bd-xp9j7 with ESMTP id 01a77a006a344abebd1cacd0747ec331 for l.stach@pengutronix.de;
        Wed, 07 Jun 2023 18:56:00 CST
X-Transaction-ID: 01a77a006a344abebd1cacd0747ec331
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
From:   Sui Jingfeng <15330273260@189.cn>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Li Yi <liyi@loongson.cn>
Cc:     linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH v8 0/8] drm/etnaviv: add pci device driver support
Date:   Wed,  7 Jun 2023 18:55:43 +0800
Message-Id: <20230607105551.568639-1-15330273260@189.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

There is a Vivante GC1000 (v5037) in LS2K1000 and LS7A1000, this GPU is a
PCI device, and it has 2D and 3D cores in the same core. Thus, this patch
set is trying to add PCI device driver support to etnaviv.

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

Sui Jingfeng (8):
  drm/etnaviv: add a dedicated function to register an irq handler
  drm/etnaviv: add a dedicated function to get various clocks
  drm/etnaviv: add dedicated functions to create and destroy platform
    devices
  drm/etnaviv: add helpers for private data construction and destruction
  drm/etnaviv: allow bypass component framework
  drm/etnaviv: add driver support for the PCI devices
  drm/etnaviv: add support for the dma coherent device
  drm/etnaviv: add a dedicated function to create the virtual master

 drivers/gpu/drm/etnaviv/Kconfig             |  10 +
 drivers/gpu/drm/etnaviv/Makefile            |   2 +
 drivers/gpu/drm/etnaviv/etnaviv_drv.c       | 257 ++++++++++++++------
 drivers/gpu/drm/etnaviv/etnaviv_drv.h       |  10 +
 drivers/gpu/drm/etnaviv/etnaviv_gem.c       |  22 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c |   7 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c       | 168 ++++++++-----
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h       |   9 +
 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c   |  75 ++++++
 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.h   |   9 +
 include/uapi/drm/etnaviv_drm.h              |   1 +
 11 files changed, 440 insertions(+), 130 deletions(-)
 create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c
 create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.h

-- 
2.25.1

