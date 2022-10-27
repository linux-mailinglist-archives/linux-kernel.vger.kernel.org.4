Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C5460F7E3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbiJ0Mrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235799AbiJ0Mrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:47:36 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BF23168E76
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:47:35 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.32])
        by gateway (Coremail) with SMTP id _____8AxzNjlfVpjA+ICAA--.11073S3;
        Thu, 27 Oct 2022 20:47:34 +0800 (CST)
Received: from loongson-pc.loongson.cn (unknown [10.20.42.32])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxV1fkfVpjFdwFAA--.2819S2;
        Thu, 27 Oct 2022 20:47:33 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
Subject: [PATCH V2] LoongArch: Fix memsection size
Date:   Thu, 27 Oct 2022 20:47:32 +0800
Message-Id: <20221027124732.20837-1-lvjianmin@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxV1fkfVpjFdwFAA--.2819S2
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7ZrWxXFy8ArWDuw15uF1xZrb_yoW8Gr1xpF
        929r95Krs8Wa1xur48t345Cry5Kan5u342qF98Z34UAr43Wrs2yr4qywsrZF97Jw48ArWI
        qFsxXws3ZF98A3DanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b38YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kK
        e7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280
        aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28Icx
        kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E
        5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAV
        WUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
        1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
        0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU
        74lkDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On LoongArch, the physical address (0 - 0xfff_ffff) is always memory, which
is in the low half of the memsection (0 - 0x1fff_ffff) with 512M size, and
the high half will be a hole which is not memory but I/O registers (of cpu
and chipset).

This situation may cause some issues. For example, during S3, these I/O registers
will be saved and restored as valid memory pages (pfn_valid() of common version
returns true for the whole memsection) which will cause exception, especially
on resume.

To avoid exceptions, we can use 256M memsection size, or use the way as ARM64 to
walk through all memory memblock to check if a mem pfn is valid which maybe
lower performance. For simplicity, this patch just use the former way.

Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>

diff --git a/arch/loongarch/include/asm/sparsemem.h b/arch/loongarch/include/asm/sparsemem.h
index 3d18cdf1b069..05903b40a625 100644
--- a/arch/loongarch/include/asm/sparsemem.h
+++ b/arch/loongarch/include/asm/sparsemem.h
@@ -8,7 +8,7 @@
  * SECTION_SIZE_BITS		2^N: how big each section will be
  * MAX_PHYSMEM_BITS		2^N: how much memory we can have in that space
  */
-#define SECTION_SIZE_BITS	29 /* 2^29 = Largest Huge Page Size */
+#define SECTION_SIZE_BITS	28
 #define MAX_PHYSMEM_BITS	48
 
 #endif /* CONFIG_SPARSEMEM */
-- 
2.31.1

