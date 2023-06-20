Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212E573684A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjFTJsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjFTJsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:48:01 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D63E6F1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
        Content-Type; bh=XU0Fg2KaF1xcsfWW4v0Y+xi9FWHK/c2RL/uvt8tfibM=;
        b=SYJk9LdyJhPjfLKMgCx73S9NtUWTih27uuWU9rq/6ldf3OoWdEaG0ogiK9bse7
        XT3b4Xoh6KQqOFpazPOam6O3wJg23kmcF8lldzsuAaAEAUDS0wips5cDqbJTnudv
        OvRnqM6H0vBtTFhROYrfjlFFtjdUS5C9AoWslDCnu86no=
Received: from openarena.loongson.cn (unknown [114.242.206.180])
        by zwqz-smtp-mta-g4-0 (Coremail) with SMTP id _____wAXg3CldZFkB8yiAQ--.11241S2;
        Tue, 20 Jun 2023 17:47:17 +0800 (CST)
From:   Sui Jingfeng <18949883232@163.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH v10 00/11] drm/etnaviv: Add pci device driver support
Date:   Tue, 20 Jun 2023 17:47:05 +0800
Message-Id: <20230620094716.2231414-1-18949883232@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAXg3CldZFkB8yiAQ--.11241S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr4UJrWkGrW7WF4rWrWruFg_yoW5GF4xpF
        4UGFyYyry8urW3Kw17JFn5JFy3C3WxWF9Y93srt3s09w45AryjvryDKF45Jr9xJr4rAF12
        qr1a9r13WF1UArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jD5r7UUUUU=
X-Originating-IP: [114.242.206.180]
X-CM-SenderInfo: jprymkizyyjjits6il2tof0z/xtbBdQeU0VaEE2i9qQACsI
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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

