Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3BF61925E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 09:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiKDIEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 04:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbiKDID6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 04:03:58 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E53E426579;
        Fri,  4 Nov 2022 01:03:53 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.77])
        by gateway (Coremail) with SMTP id _____8DxTttox2RjmncEAA--.15297S3;
        Fri, 04 Nov 2022 16:03:52 +0800 (CST)
Received: from loongson-PC.loongson.cn (unknown [10.20.42.77])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx_1djx2Rjel0NAA--.37956S2;
        Fri, 04 Nov 2022 16:03:51 +0800 (CST)
From:   Liu Peibao <liupeibao@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>
Cc:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip: loongson-liointc: fix improper error handling in liointc_init()
Date:   Fri,  4 Nov 2022 16:03:47 +0800
Message-Id: <20221104080347.21527-1-liupeibao@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx_1djx2Rjel0NAA--.37956S2
X-CM-SenderInfo: xolx1vpled0qxorr0wxvrqhubq/1tbiAQAACmNjr2MWjwAAse
X-Coremail-Antispam: 1Uk129KBjvdXoWrtF4DtFW7Gw4fJFW3CF47XFb_yoWkXFg_CF
        Z2qwsxJFyIvr1kJw1kAr1Yvry29ry8W3Wq9FW8WF1fA3yUtw13CrZrA3sxCF4IgFW09rn3
        ArZ5uryxCryIkjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        87kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7
        xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS
        0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8vApUUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For cores less than 4, eg, loongson2k1000 with 2 cores, the
of_property_match_string() may return with an error value,
which causes that liointc could not work. At least one isr
is what should be checked like previous commit <b2c4c3969fd7>
(irqchip/loongson-liointc: irqchip add 2.0 version) did.

Fixes: 0858ed035a85 ("irqchip/loongson-liointc: Add ACPI init support")
Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
---
 drivers/irqchip/irq-loongson-liointc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index 0da8716f8f24..c4584e2f0ad3 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -207,10 +207,13 @@ static int liointc_init(phys_addr_t addr, unsigned long size, int revision,
 					"reg-names", core_reg_names[i]);
 
 			if (index < 0)
-				goto out_iounmap;
+				continue;
 
 			priv->core_isr[i] = of_iomap(node, index);
 		}
+
+		if (!priv->core_isr[0])
+			goto out_iounmap;
 	}
 
 	/* Setup IRQ domain */
-- 
2.20.1

