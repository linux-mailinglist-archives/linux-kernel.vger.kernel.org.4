Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2B169DBE1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 09:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbjBUI0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 03:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbjBUI0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 03:26:33 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC9FB23852;
        Tue, 21 Feb 2023 00:26:26 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8AxJFwwgPRjNhcDAA--.863S3;
        Tue, 21 Feb 2023 16:26:24 +0800 (CST)
Received: from user-pc.202.106.0.20 (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxyuYmgPRj2Zw3AA--.2222S3;
        Tue, 21 Feb 2023 16:26:23 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, wanghongliang@loongson.cn
Subject: [PATCH v11 3/4] LoongArch: time: add of_clk_init in time_init
Date:   Tue, 21 Feb 2023 16:26:12 +0800
Message-Id: <20230221082612.6442-2-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230221082612.6442-1-zhuyinbo@loongson.cn>
References: <20230221082612.6442-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxyuYmgPRj2Zw3AA--.2222S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvdXoW7Wr4UWFyruw13ZF4kXrWxtFb_yoWDWFXE9w
        1xGw15WryxJ39akF95J3ZxJw1jkw40yF98ZFn3Zr17AFnxJ34UCw43Z343Arn0gas29rs8
        ZrW5Grs7Cr13KjkaLaAFLSUrUUUU0b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        X7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2
        IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84AC
        jcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM2
        8EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE
        52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCj
        c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7V
        AKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
        67AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
        8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5
        JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
        1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
        daVFxhVjvjDU0xZFpf9x07jeGQDUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Loongson-2 clock controller driver used CLK_OF_DECLARE to
register clock subsystem that ask of_clk_init was called in
time_init and this patch was to addd such support.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
Change in v11:
		1. Add acked-by on this patch.

 arch/loongarch/kernel/time.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
index a6576dea590c..7d1f3b64928b 100644
--- a/arch/loongarch/kernel/time.c
+++ b/arch/loongarch/kernel/time.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/sched_clock.h>
 #include <linux/spinlock.h>
+#include <linux/of_clk.h>
 
 #include <asm/cpu-features.h>
 #include <asm/loongarch.h>
@@ -219,6 +220,8 @@ int __init constant_clocksource_init(void)
 
 void __init time_init(void)
 {
+	of_clk_init(NULL);
+
 	if (!cpu_has_cpucfg)
 		const_clock_freq = cpu_clock_freq;
 	else
-- 
2.31.1

