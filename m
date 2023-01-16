Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0F666B5F1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 04:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjAPDTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 22:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjAPDT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 22:19:28 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81D6876A3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 19:19:26 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxV+k9wsRj5csBAA--.353S3;
        Mon, 16 Jan 2023 11:19:25 +0800 (CST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axvr45wsRjYgUaAA--.53479S3;
        Mon, 16 Jan 2023 11:19:22 +0800 (CST)
Subject: Re: [PATCH v11 3/6] LoongArch: Add kretprobe support
To:     kernel test robot <lkp@intel.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <1673688444-24251-4-git-send-email-yangtiezhu@loongson.cn>
 <202301151852.m2cigv2D-lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <bfac74ca-5e8e-7a02-71d4-9b69b804aa7c@loongson.cn>
Date:   Mon, 16 Jan 2023 11:19:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <202301151852.m2cigv2D-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Axvr45wsRjYgUaAA--.53479S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxJw4fXr15WrW8Zr4xZF48tFb_yoW5ArWxpa
        yDZr1akr4rWr95XFZ7GayUX3W8Krn5A3srZryUK34Y9ay5Zryftrn293y5AFZrKwn8KFyF
        vr4Fqas5KF43Aa7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487Mx
        AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
        Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwI
        xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8
        JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
        C2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/15/2023 07:17 PM, kernel test robot wrote:
> Hi Tiezhu,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on linus/master]
> [also build test WARNING on v6.2-rc3 next-20230113]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Tiezhu-Yang/LoongArch-Simulate-branch-and-PC-instructions/20230114-173012
> patch link:    https://lore.kernel.org/r/1673688444-24251-4-git-send-email-yangtiezhu%40loongson.cn
> patch subject: [PATCH v11 3/6] LoongArch: Add kretprobe support
> config: loongarch-allmodconfig
> compiler: loongarch64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/da766ea35a574bece74a5068aad708b5773b2981
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Tiezhu-Yang/LoongArch-Simulate-branch-and-PC-instructions/20230114-173012
>         git checkout da766ea35a574bece74a5068aad708b5773b2981
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash arch/loongarch/kernel/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> Note: functions only called from assembly code should be annotated with the asmlinkage attribute
> All warnings (new ones prefixed by >>):
>
>>> arch/loongarch/kernel/kprobes.c:376:14: warning: no previous prototype for 'trampoline_probe_handler' [-Wmissing-prototypes]
>      376 | void __used *trampoline_probe_handler(struct pt_regs *regs)
>          |              ^~~~~~~~~~~~~~~~~~~~~~~~
>
>
> vim +/trampoline_probe_handler +376 arch/loongarch/kernel/kprobes.c
>
>    374	
>    375	/* Called from __kretprobe_trampoline */
>  > 376	void __used *trampoline_probe_handler(struct pt_regs *regs)
>    377	{
>    378		return (void *)kretprobe_trampoline_handler(regs, NULL);
>    379	}
>    380	NOKPROBE_SYMBOL(trampoline_probe_handler);
>    381	
>

Thanks for the report, I can reproduce it when make W=1
and also can silence it when declare the prototype

void *trampoline_probe_handler(struct pt_regs *regs);

in arch/loongarch/include/asm/kprobes.h

Let me wait for some time, if no more comments, I will
update this patch and then send v12.

Thanks,
Tiezhu

