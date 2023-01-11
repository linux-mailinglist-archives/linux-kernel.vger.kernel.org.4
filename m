Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0185665A71
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238480AbjAKLkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238514AbjAKLji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:39:38 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E019192A1;
        Wed, 11 Jan 2023 03:38:05 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Cx+emcn75jSfAAAA--.2916S3;
        Wed, 11 Jan 2023 19:38:04 +0800 (CST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxPuSbn75jOegXAA--.7699S3;
        Wed, 11 Jan 2023 19:38:03 +0800 (CST)
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: kernel hangs when kprobe memcpy
Message-ID: <d179086d-78d8-d0e3-e113-9072cffa55f4@loongson.cn>
Date:   Wed, 11 Jan 2023 19:38:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxPuSbn75jOegXAA--.7699S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7tF15ZFyrAw1DWr4rAFW5Jrb_yoW8tFyfp3
        W3Aw15tr4rJw1Ygay7Jw48WFyI9ryqyrW8Cr4kCryYy3WYvrW8GFWI9a18J3y5ur9Fv3Wa
        vF10yry7Jry7AaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E
        87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km
        07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUv
        cSsGvfC2KfnxnUUI43ZEXa7IU8hiSPUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

(1) I have the following test environment, kernel hangs when kprobe memcpy:

system: x86_64 fedora 36
kernel version: Linux 5.7 (compile and update)
test case: modprobe kprobe_example symbol="memcpy" (CONFIG_SAMPLE_KPROBES=m)

In order to fix build errors, it needs to unset CONFIG_NFP and do the
following changes:
commit 52a9dab6d892 ("libsubcmd: Fix use-after-free for realloc(..., 0)")
commit de979c83574a ("x86/entry: Build thunk_$(BITS) only if 
CONFIG_PREEMPTION=y")

(2) Using the latest upstream mainline kernel, no hang problem due to the
commit e3a9e681adb7 ("x86/entry: Fixup bad_iret vs noinstr") to prohibit
probing memcpy which is put into the .noinstr.text section.

   # modprobe kprobe_example symbol="memcpy"
   modprobe: ERROR: could not insert 'kprobe_example': Invalid argument

In my opinion, according to the commit message, the above commit is not
intended to fix the memcpy hang problem, the problem was fixed by accident.

(3) If make handler_pre() and handler_post() as empty functions in the 5.7
kernel code, the above hang problem does not exist.

diff --git a/samples/kprobes/kprobe_example.c 
b/samples/kprobes/kprobe_example.c
index fd346f58ddba..c194171d8a46 100644
--- a/samples/kprobes/kprobe_example.c
+++ b/samples/kprobes/kprobe_example.c
@@ -28,8 +28,6 @@ static struct kprobe kp = {
  static int __kprobes handler_pre(struct kprobe *p, struct pt_regs *regs)
  {
  #ifdef CONFIG_X86
-	pr_info("<%s> p->addr = 0x%p, ip = %lx, flags = 0x%lx\n",
-		p->symbol_name, p->addr, regs->ip, regs->flags);
  #endif
  #ifdef CONFIG_PPC
  	pr_info("<%s> p->addr = 0x%p, nip = 0x%lx, msr = 0x%lx\n",
@@ -65,8 +63,6 @@ static void __kprobes handler_post(struct kprobe *p, 
struct pt_regs *regs,
  				unsigned long flags)
  {
  #ifdef CONFIG_X86
-	pr_info("<%s> p->addr = 0x%p, flags = 0x%lx\n",
-		p->symbol_name, p->addr, regs->flags);
  #endif
  #ifdef CONFIG_PPC
  	pr_info("<%s> p->addr = 0x%p, msr = 0x%lx\n",

I want to know what is the real reason of the hang problem when kprobe 
memcpy,
I guess it may be kprobe recursion, what do you think? Thank you.

By the way, kprobe memset has no problem whether or not handler_pre() and
handler_post() are empty functions.

Thanks,
Tiezhu

