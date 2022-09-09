Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E899B5B33F2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiIIJap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiIIJaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:30:15 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7059813CB1B;
        Fri,  9 Sep 2022 02:28:25 -0700 (PDT)
Received: from loongson-pc.loongson.cn (unknown [10.20.42.105])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxBOIrBxtjH04VAA--.19971S2;
        Fri, 09 Sep 2022 17:28:11 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     lpieralisi@kernel.org, robin.murphy@arm.com, chenhuacai@loongson.cn
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        lenb@kernel.org, robert.moore@intel.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        loongarch@lists.linux.dev
Subject: [PATCH V4 0/2] DMA: update acpi_dma_get_range to return dma map regions 
Date:   Fri,  9 Sep 2022 17:28:09 +0800
Message-Id: <20220909092811.22627-1-lvjianmin@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxBOIrBxtjH04VAA--.19971S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4UKF4xtr1ftF1xXF4xZwb_yoW8Jw4DpF
        9a9r43Gr1UKrZxJry3Aw1rZw15Xw1fZry7Ga9rK34kJF4jvr17Jry8Z3WxCa4UAa47Gr40
        qF98Ja45WF1UAwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU921xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r10
        6r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxE
        wVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26ryrJr1UJwCFx2IqxVCFs4
        IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
        MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
        WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
        6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUZa9-UUUUU=
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

Jianmin Lv (2):
  ACPI / scan: Support multiple dma windows with different offsets
  LoongArch: Use acpi_arch_dma_setup() and remove ARCH_HAS_PHYS_TO_DMA

 arch/loongarch/Kconfig        |  1 -
 arch/loongarch/kernel/dma.c   | 52 ++++++++++++++--------------------
 arch/loongarch/kernel/setup.c |  2 +-
 drivers/acpi/arm64/dma.c      | 29 +++++++++++--------
 drivers/acpi/scan.c           | 53 +++++++++++++++--------------------
 include/acpi/acpi_bus.h       |  3 +-
 include/linux/acpi.h          | 12 ++++----
 7 files changed, 71 insertions(+), 81 deletions(-)

-- 
2.31.1

