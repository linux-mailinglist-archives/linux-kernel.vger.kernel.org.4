Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2211E72FDBA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243581AbjFNMAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244378AbjFNL7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:59:44 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF1A51FDC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:59:38 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.116])
        by gateway (Coremail) with SMTP id _____8Ax3eqpq4lkpx0FAA--.10865S3;
        Wed, 14 Jun 2023 19:59:37 +0800 (CST)
Received: from loongson-pc.loongson.cn (unknown [10.20.42.116])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxNeSoq4lkzJMaAA--.10424S2;
        Wed, 14 Jun 2023 19:59:36 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH V3 0/5] irqchip/loongson: Fix some loongson irqchip drivers
Date:   Wed, 14 Jun 2023 19:59:31 +0800
Message-Id: <20230614115936.5950-1-lvjianmin@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxNeSoq4lkzJMaAA--.10424S2
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZF13JFWDXFyDJF1kZF17CFX_yoWfZFb_uF
        WI93yDCrn2gF1xXay2yr40vF9I9FWUW3Wq9FyjqF1rX3yqv3W3Cr47CwnxG3Z7JF48tFn8
        Xrs5GryfCryIyosvyTuYvTs0mTUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvT
        s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
        cSsGvfJTRUUUb38YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
        vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
        x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
        McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
        1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_
        JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
        CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
        I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
        8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73
        UjIFyTuYvjxU4xR6UUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch series provide some fixes for loongson-liointc and loongson-pch-pic driver.

V1->V2:
1. Adjust commit log for all patchs
2. Add some explanation for Loongson-3's polarity register

V2->V3:
1. Add a new patch[5] to fix irq affinity setting during resume for loongson-eiointc

Jianmin Lv (3):
  irqchip/loongson-pch-pic: Fix initialization of HT vector register
  irqchip/loongson-liointc: Fix IRQ trigger polarity
  irqchip/loongson-eiointc: Fix irq affinity setting during resume

Liu Peibao (1):
  irqchip/loongson-pch-pic: Fix potential incorrect hwirq assignment

Yinbo Zhu (1):
  irqchip/loongson-liointc: Add IRQCHIP_SKIP_SET_WAKE flag

 drivers/irqchip/irq-loongson-eiointc.c |  2 +-
 drivers/irqchip/irq-loongson-liointc.c | 13 +++++++++----
 drivers/irqchip/irq-loongson-pch-pic.c | 10 ++++------
 3 files changed, 14 insertions(+), 11 deletions(-)

-- 
2.31.1

