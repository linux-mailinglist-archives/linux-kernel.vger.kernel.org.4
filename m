Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3D45B4CDB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 11:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiIKJGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 05:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiIKJGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 05:06:50 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4C06BCAD;
        Sun, 11 Sep 2022 02:06:48 -0700 (PDT)
Received: from loongson-pc.loongson.cn (unknown [10.20.42.105])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx_2sbpR1jFrsWAA--.22738S2;
        Sun, 11 Sep 2022 17:06:35 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     lpieralisi@kernel.org, robin.murphy@arm.com, chenhuacai@loongson.cn
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        lenb@kernel.org, robert.moore@intel.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        loongarch@lists.linux.dev
Subject: [PATCH V5 0/2] DMA: update acpi_dma_get_range to return dma map regions 
Date:   Sun, 11 Sep 2022 17:06:33 +0800
Message-Id: <20220911090635.5559-1-lvjianmin@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx_2sbpR1jFrsWAA--.22738S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4UKF4xtr1ftF1xur43Awb_yoW8XrykpF
        9a9rsxJr45KrZxJry3Aw1rZr15Xw1fZryxGa9rK34kJF1jvr17Jry8Z3WxCa4UAF9rGr40
        qF98Ja45WF1UAwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
        jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_
        JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK
        6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_XrWUJr1UMxC20s026xCaFV
        Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
        x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
        1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
        JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VU1a9aPUUUUU==
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch series changed acpi_dma_get_range to return dma regions
as of_dma_get_range, so that dev->dma_range_map can be initialized
conveniently.

And acpi_arch_dma_setup for ARM64 is changed wih removing dma_base
and size from it's parameters.

Remove ARCH_HAS_PHYS_TO_DMA for LoongArch and use generic
phys_to_dma/dma_to_phys in include/linux/dma-direct.h.

V1 -> V2
- Removed dma_base and size from acpi_arch_dma_setup' parameters
- Add patch to remove ARCH_HAS_PHYS_TO_DMA for LoongArch

V2 -> V3
- Add kerneldoc for acpi_dma_get_range changing
- Remove redundant code in acpi_arch_dma_setup, and check map

V3 -> V4
- Change title to "Use acpi_arch_dma_setup() and remove ARCH_HAS_PHYS_TO_DMA"
- Use resource_size() to get size 

V4 -> V5
- Change commit log for patch: Support multiple dma windows with different offsets
- Remove a unnecessary blank line
- Fix a bug of acpi_dma_get_range

Jianmin Lv (2):
  ACPI / scan: Support multiple dma windows with different offsets
  LoongArch: Use acpi_arch_dma_setup() and remove ARCH_HAS_PHYS_TO_DMA

 arch/loongarch/Kconfig        |  1 -
 arch/loongarch/kernel/dma.c   | 52 ++++++++++++++--------------------
 arch/loongarch/kernel/setup.c |  2 +-
 drivers/acpi/arm64/dma.c      | 28 ++++++++++--------
 drivers/acpi/scan.c           | 53 +++++++++++++++--------------------
 include/acpi/acpi_bus.h       |  3 +-
 include/linux/acpi.h          | 12 ++++----
 7 files changed, 70 insertions(+), 81 deletions(-)

-- 
2.31.1

