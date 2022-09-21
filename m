Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E135BF2FA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 03:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiIUBfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 21:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiIUBfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 21:35:44 -0400
Received: from out199-18.us.a.mail.aliyun.com (out199-18.us.a.mail.aliyun.com [47.90.199.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F06D4F3AB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 18:35:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VQLO8FC_1663724135;
Received: from 30.225.65.96(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VQLO8FC_1663724135)
          by smtp.aliyun-inc.com;
          Wed, 21 Sep 2022 09:35:36 +0800
Message-ID: <452ee5c6-2d1c-16ad-96d1-b0a9e807ff3f@linux.alibaba.com>
Date:   Wed, 21 Sep 2022 09:35:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: arch/riscv/kernel/traps.c:48 die() warn: variable dereferenced
 before check 'regs' (see line 46)
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     dan.carpenter@oracle.com, kbuild@lists.01.org, lkp@intel.com,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        guoren@kernel.org
References: <mhng-0ae2d371-db11-4d05-a4e2-006c5f9303eb@palmer-ri-x1c9>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
In-Reply-To: <mhng-0ae2d371-db11-4d05-a4e2-006c5f9303eb@palmer-ri-x1c9>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/9/21 上午4:06, Palmer Dabbelt 写道:
> On Thu, 11 Aug 2022 03:42:28 PDT (-0700), 
> xianting.tian@linux.alibaba.com wrote:
>>
>> 在 2022/8/11 下午6:33, Dan Carpenter 写道:
>>> tree: 
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
>>> master
>>> head:   f41445645ab5d172e6090d00c332c335d8dba337
>>> commit: 3f1901110a89b0e2e13adb2ac8d1a7102879ea98 RISC-V: Add fast 
>>> call path of crash_kexec()
>>> config: riscv-randconfig-m031-20220810 
>>> (https://download.01.org/0day-ci/archive/20220811/202208110538.uaLOQmBs-lkp@intel.com/config)
>>> compiler: riscv64-linux-gcc (GCC) 12.1.0
>>>
>>> If you fix the issue, kindly add following tag where applicable
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>>>
>>> smatch warnings:
>>> arch/riscv/kernel/traps.c:48 die() warn: variable dereferenced 
>>> before check 'regs' (see line 46)
>>>
>>> vim +/regs +48 arch/riscv/kernel/traps.c
>>>
>>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  31  void die(struct 
>>> pt_regs *regs, const char *str)
>>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  32  {
>>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  33      static int 
>>> die_counter;
>>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  34      int ret;
>>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  35
>>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  36 oops_enter();
>>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  37
>>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  38 
>>> spin_lock_irq(&die_lock);
>>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  39 console_verbose();
>>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  40 bust_spinlocks(1);
>>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  41
>>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  42 pr_emerg("%s 
>>> [#%d]\n", str, ++die_counter);
>>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  43 print_modules();
>>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  44 show_regs(regs);
>>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  45
>>> a4c3733d32a72f Christoph Hellwig 2019-10-28 @46      ret = 
>>> notify_die(DIE_OOPS, str, regs, 0, regs->cause, SIGSEGV);
>>> ^^^^^^^^^^^
>>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  47
>>> 3f1901110a89b0 Xianting Tian     2022-06-06 @48      if (regs && 
>>> kexec_should_crash(current))
>>> ^^^^
>>>
>>> Delete this NULL check.
>> thanks,  I will send another fixup patch to fix the issue, is it OK?
>
> You're always welcome to send fixes, but I didn't see anything so I 
> just sent along 
> https://lore.kernel.org/r/20220920200037.6727-1-palmer@rivosinc.com/
Thanks Palmer for the fix :)
>
>>>
>>> 3f1901110a89b0 Xianting Tian     2022-06-06  49 crash_kexec(regs);
>>> 3f1901110a89b0 Xianting Tian     2022-06-06  50
>>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  51 bust_spinlocks(0);
>>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  52 add_taint(TAINT_DIE, 
>>> LOCKDEP_NOW_UNRELIABLE);
>>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  53 
>>> spin_unlock_irq(&die_lock);
>>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  54 oops_exit();
>>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  55
>>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  56      if 
>>> (in_interrupt())
>>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  57 panic("Fatal 
>>> exception in interrupt");
>>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  58      if (panic_on_oops)
>>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  59 panic("Fatal 
>>> exception");
>>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  60      if (ret != 
>>> NOTIFY_STOP)
>>> 0e25498f8cd43c Eric W. Biederman 2021-06-28  61 
>>> make_task_dead(SIGSEGV);
>>> 76d2a0493a17d4 Palmer Dabbelt    2017-07-10  62  }
>>>
