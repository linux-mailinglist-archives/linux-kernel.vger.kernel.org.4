Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15722667338
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjALNdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjALNc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:32:59 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB6F91901F;
        Thu, 12 Jan 2023 05:32:54 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxCeoEDMBjHz0BAA--.3675S3;
        Thu, 12 Jan 2023 21:32:52 +0800 (CST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxf+QDDMBjim8YAA--.9397S3;
        Thu, 12 Jan 2023 21:32:52 +0800 (CST)
Subject: Re: kernel hangs when kprobe memcpy
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>
References: <d179086d-78d8-d0e3-e113-9072cffa55f4@loongson.cn>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <19666c03-4bf6-7aac-3f1d-cd31ab7de2d5@loongson.cn>
Date:   Thu, 12 Jan 2023 21:32:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <d179086d-78d8-d0e3-e113-9072cffa55f4@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Cxf+QDDMBjim8YAA--.9397S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxWw1UXF13GFy3uF4rZF13Jwb_yoW5GF4kp3
        ZIyw45trs5Jw1YgFy7Jw48WFyI9r1kArWUAr1kC345Aa4jqr95JF4Iva1Ut398Wr9F9w1a
        qF18try7JrW7AaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAa
        w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2
        jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62
        AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI
        1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
        6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr
        0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIY
        CTnIWIevJa73UjIFyTuYvjxU4s2-UUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/11/2023 07:38 PM, Tiezhu Yang wrote:
> Hi all,
>
> (1) I have the following test environment, kernel hangs when kprobe memcpy:
>
> system: x86_64 fedora 36
> kernel version: Linux 5.7 (compile and update)
> test case: modprobe kprobe_example symbol="memcpy"
> (CONFIG_SAMPLE_KPROBES=m)
>
> In order to fix build errors, it needs to unset CONFIG_NFP and do the
> following changes:
> commit 52a9dab6d892 ("libsubcmd: Fix use-after-free for realloc(..., 0)")
> commit de979c83574a ("x86/entry: Build thunk_$(BITS) only if
> CONFIG_PREEMPTION=y")
>
> (2) Using the latest upstream mainline kernel, no hang problem due to the
> commit e3a9e681adb7 ("x86/entry: Fixup bad_iret vs noinstr") to prohibit
> probing memcpy which is put into the .noinstr.text section.
>
>   # modprobe kprobe_example symbol="memcpy"
>   modprobe: ERROR: could not insert 'kprobe_example': Invalid argument
>
> In my opinion, according to the commit message, the above commit is not
> intended to fix the memcpy hang problem, the problem was fixed by accident.
>
> (3) If make handler_pre() and handler_post() as empty functions in the 5.7
> kernel code, the above hang problem does not exist.
>
> diff --git a/samples/kprobes/kprobe_example.c
> b/samples/kprobes/kprobe_example.c
> index fd346f58ddba..c194171d8a46 100644
> --- a/samples/kprobes/kprobe_example.c
> +++ b/samples/kprobes/kprobe_example.c
> @@ -28,8 +28,6 @@ static struct kprobe kp = {
>  static int __kprobes handler_pre(struct kprobe *p, struct pt_regs *regs)
>  {
>  #ifdef CONFIG_X86
> -    pr_info("<%s> p->addr = 0x%p, ip = %lx, flags = 0x%lx\n",
> -        p->symbol_name, p->addr, regs->ip, regs->flags);
>  #endif
>  #ifdef CONFIG_PPC
>      pr_info("<%s> p->addr = 0x%p, nip = 0x%lx, msr = 0x%lx\n",
> @@ -65,8 +63,6 @@ static void __kprobes handler_post(struct kprobe *p,
> struct pt_regs *regs,
>                  unsigned long flags)
>  {
>  #ifdef CONFIG_X86
> -    pr_info("<%s> p->addr = 0x%p, flags = 0x%lx\n",
> -        p->symbol_name, p->addr, regs->flags);
>  #endif
>  #ifdef CONFIG_PPC
>      pr_info("<%s> p->addr = 0x%p, msr = 0x%lx\n",
>
> I want to know what is the real reason of the hang problem when kprobe
> memcpy,
> I guess it may be kprobe recursion, what do you think? Thank you.
>
> By the way, kprobe memset has no problem whether or not handler_pre() and
> handler_post() are empty functions.
>
> Thanks,
> Tiezhu

I find out the following call trace:

handler_pre()
   pr_info()
     printk()
       _printk()
         vprintk()
           vprintk_store()
             memcpy()

I think it may cause recursive exceptions, so we should
mark memcpy as non-kprobe-able, right?

Thanks,
Tiezhu

