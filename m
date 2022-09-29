Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C896D5EF1A5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbiI2JRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbiI2JRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:17:03 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF64314019D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:17:01 -0700 (PDT)
Received: from loongson-pc.loongson.cn (unknown [10.20.42.32])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx72uMYjVjO7UjAA--.64660S2;
        Thu, 29 Sep 2022 17:17:00 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        WANG Xuerui <git@xen0n.name>
Subject: [PATCH V5] LoongArch: Fix cpu name after s3/s4
Date:   Thu, 29 Sep 2022 17:16:54 +0800
Message-Id: <20220929091655.9164-1-lvjianmin@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx72uMYjVjO7UjAA--.64660S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JrW8Gw45uFWUZw47Zw17GFg_yoWfAFc_G3
        Z293srGFn3Ga40va4DXFy8Ww45Aa18XFyYv3y7ArZxCr13Cw15JrsrKw1UAryayF1rWrZ8
        Cw4Iqa1DCF4YkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcAYjsxI4VWkKwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
        s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
        kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
        Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
        0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY
        6x8ErcxFaVAv8VW5Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUg6nQUUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't overwrite the CPU name on coming back from S3/S4 if
it is already initialized.

Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Reviewed-by: WANG Xuerui <git@xen0n.name>

diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
index 529ab8f44ec6..255a09876ef2 100644
--- a/arch/loongarch/kernel/cpu-probe.c
+++ b/arch/loongarch/kernel/cpu-probe.c
@@ -187,7 +187,9 @@ static inline void cpu_probe_loongson(struct cpuinfo_loongarch *c, unsigned int
 	uint64_t *vendor = (void *)(&cpu_full_name[VENDOR_OFFSET]);
 	uint64_t *cpuname = (void *)(&cpu_full_name[CPUNAME_OFFSET]);
 
-	__cpu_full_name[cpu] = cpu_full_name;
+	if (!__cpu_full_name[cpu])
+		__cpu_full_name[cpu] = cpu_full_name;
+
 	*vendor = iocsr_read64(LOONGARCH_IOCSR_VENDOR);
 	*cpuname = iocsr_read64(LOONGARCH_IOCSR_CPUNAME);
 
-- 
2.31.1

