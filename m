Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173F5714EED
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 19:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjE2RZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 13:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjE2RZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 13:25:01 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56949CD
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 10:24:54 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8Axz+vl33RkK0oCAA--.5147S3;
        Tue, 30 May 2023 01:24:53 +0800 (CST)
Received: from openarena.loongson.cn (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxMuXk33RkhkV_AA--.9919S2;
        Tue, 30 May 2023 01:24:52 +0800 (CST)
From:   Sui Jingfeng <suijingfeng@loongson.cn>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH v5 0/6] drm/etnaviv: add pci device driver support
Date:   Tue, 30 May 2023 01:24:46 +0800
Message-Id: <20230529172452.2148819-1-suijingfeng@loongson.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxMuXk33RkhkV_AA--.9919S2
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7uFy5WF4rCw45CrW8Kw43GFg_yoW8GF1DpF
        47JFyYyry0vrW2k343AFn8XFy3C3WxWF9Yk3srt3sI9w4rAr1jvryDKa15Jr9xJr1fJF42
        qrnIkry3WF17ArJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        baxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jw0_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
        ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAa
        w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Wrv_ZF1lYx0Ex4A2
        jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82
        IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2Iq
        xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
        1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY
        6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
        AFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZF
        pf9x07URyIUUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a Vivante GC1000 (v5037) in LS2K1000 and LS7A1000, this GPU is a
PCI device, and it has 2D and 3D cores in the same device. Thus, this patch
series is trying to add PCI device driver support to etnaviv.

Sui Jingfeng (6):
  drm/etnaviv: add a dedicated function to register an irq handler
  drm/etnaviv: add a dedicated function to get various clocks
  drm/etnaviv: add dedicated functions to create and destroy platform
    devices
  drm/etnaviv: add helpers for private data construction and destruction
  drm/etnaviv: expand driver support for the PCI devices
  drm/etnaviv: allow usperspace create cached coherent bo

 drivers/gpu/drm/etnaviv/Makefile            |   1 +
 drivers/gpu/drm/etnaviv/etnaviv_drv.c       | 183 +++++++++++++------
 drivers/gpu/drm/etnaviv/etnaviv_drv.h       |   7 +
 drivers/gpu/drm/etnaviv/etnaviv_gem.c       |  22 ++-
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c |   9 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c       | 185 ++++++++++++++------
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h       |  13 ++
 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c   |  88 ++++++++++
 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.h   |  10 ++
 include/uapi/drm/etnaviv_drm.h              |  11 +-
 10 files changed, 415 insertions(+), 114 deletions(-)
 create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c
 create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.h

-- 
2.25.1

