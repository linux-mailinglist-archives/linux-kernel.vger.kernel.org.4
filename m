Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01C070A5F4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 08:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjETGiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 02:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjETGiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 02:38:23 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3ABDC1A8
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 23:38:19 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.176])
        by gateway (Coremail) with SMTP id _____8Dxh+naamhk3l4KAA--.18302S3;
        Sat, 20 May 2023 14:38:18 +0800 (CST)
Received: from loongson-pc.loongson.cn (unknown [10.20.42.176])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxFLXaamhkd1JrAA--.51105S2;
        Sat, 20 May 2023 14:38:18 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH V1 0/4] irqchip/loongson: Fix some loongson irqchip drivers
Date:   Sat, 20 May 2023 14:38:14 +0800
Message-Id: <20230520063818.27208-1-lvjianmin@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxFLXaamhkd1JrAA--.51105S2
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
        BjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
        xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
        j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
        67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E
        87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82
        IYc2Ij64vIr41l4c8EcI0En4kS14v26r1Y6r17MxC20s026xCaFVCjc4AY6r1j6r4UMxCI
        bckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
        I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
        2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
        C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73
        UjIFyTuYvjxU7MmhUUUUU
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_SBL_CSS,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch series provide some fixes for loongson-liointc and loongson-pch-pic driver.

Jianmin Lv (2):
  irqchip/loongson-pch-pic: Fix initialization of HT vector register
  irqchip/loongson-liointc: Fix IRQ trigger polarity

Liu Peibao (1):
  irqchip/loongson-pch-pic: Fix potential incorrect hwirq assignment

Yinbo Zhu (1):
  irqchip/loongson-liointc: Add IRQCHIP_SKIP_SET_WAKE flag

 drivers/irqchip/irq-loongson-liointc.c |  9 +++++----
 drivers/irqchip/irq-loongson-pch-pic.c | 10 ++++------
 2 files changed, 9 insertions(+), 10 deletions(-)

-- 
2.31.1

