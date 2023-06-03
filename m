Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C82720FBF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 13:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjFCLAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 07:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjFCLAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 07:00:10 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C1DC133
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 04:00:06 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:51732.1826327623
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id 24BF31002B2;
        Sat,  3 Jun 2023 19:00:03 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-75648544bd-7vx9t with ESMTP id 706082b12ee64e49a7c70ff2f70429ec for l.stach@pengutronix.de;
        Sat, 03 Jun 2023 19:00:05 CST
X-Transaction-ID: 706082b12ee64e49a7c70ff2f70429ec
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
From:   Sui Jingfeng <15330273260@189.cn>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH v7 0/7] drm/etnaviv: add pci device driver support
Date:   Sat,  3 Jun 2023 18:59:36 +0800
Message-Id: <20230603105943.3042766-1-15330273260@189.cn>
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

Sui Jingfeng (7):
  drm/etnaviv: add a dedicated function to register an irq handler
  drm/etnaviv: add a dedicated function to get various clocks
  drm/etnaviv: add dedicated functions to create and destroy platform
    devices
  drm/etnaviv: add helpers for private data construction and destruction
  drm/etnaviv: allow bypass component framework
  drm/etnaviv: add driver support for the PCI devices
  drm/etnaviv: add support for the dma coherent device

 drivers/gpu/drm/etnaviv/Kconfig             |   9 +
 drivers/gpu/drm/etnaviv/Makefile            |   2 +
 drivers/gpu/drm/etnaviv/etnaviv_drv.c       | 228 +++++++++++++++-----
 drivers/gpu/drm/etnaviv/etnaviv_drv.h       |  10 +
 drivers/gpu/drm/etnaviv/etnaviv_gem.c       |  22 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c |   7 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c       | 170 ++++++++++-----
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h       |   9 +
 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c   |  75 +++++++
 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.h   |   9 +
 include/uapi/drm/etnaviv_drm.h              |   1 +
 11 files changed, 422 insertions(+), 120 deletions(-)
 create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c
 create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.h

-- 
2.25.1

