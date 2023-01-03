Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C289665B987
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 04:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236603AbjACDFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 22:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236576AbjACDFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 22:05:06 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5E5B84B
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 19:05:04 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NmHcl4nDFzJqpp;
        Tue,  3 Jan 2023 11:03:51 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 3 Jan 2023 11:05:02 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [BUG Report] undefined reference to `convert_to_fxsr'
To:     Borislav Petkov <bp@alien8.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, <hpa@zytor.com>
References: <50aa72a7-043d-8091-78de-458cbcc6c356@huawei.com>
 <Y6w49Y1d3lpv3KFn@zn.tnic> <23e2907c-5188-5ac6-3db8-1c5a12120bf2@huawei.com>
 <Y62vbjBzHF4rmh1V@zn.tnic> <e041533c-4005-b9bc-3985-02224985aa28@huawei.com>
 <Y67IlthBqaX69RwN@zn.tnic>
Message-ID: <64fe1be4-954f-fe6f-44f0-59b572548663@huawei.com>
Date:   Tue, 3 Jan 2023 11:05:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Y67IlthBqaX69RwN@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/30 19:16, Borislav Petkov wrote:
> On Fri, Dec 30, 2022 at 09:49:50AM +0800, Miaohe Lin wrote:
>> Many thanks for doing this. :) But it seems it's not the matter of gcc
>> version. Somewhat confused...
> 
> Put your .config somewhere outside your git repo, clean all build
> artifacts and reset it properly by doing:
> 
> git reset --hard
> git clean -dqfx
> 
> and then copy back the .config and see if you can still repro.
> 

Yes, it still reproduces in my working server. It might be the problem of gcc version.
Does the below origin analysis looks sane to you?

"""
I think it's because convert_to_fxsr() is only defined when CONFIG_X86_32 or CONFIG_IA32_EMULATION is enabled. But it can be
call from __fpu_restore_sig() via below path:

bool fpu__restore_sig(void __user *buf, int ia32_frame):

        if (!IS_ENABLED(CONFIG_X86_64) && !cpu_feature_enabled(X86_FEATURE_FPU)) {
                success = !fpregs_soft_set(current, NULL, 0,
                                           sizeof(struct user_i387_ia32_struct),
                                           NULL, buf);
        } else {
                success = __fpu_restore_sig(buf, buf_fx, ia32_fxstate); /* Will call convert_to_fxsr() later. */
        }

__fpu_restore_sig() will call convert_to_fxsr() even if neither CONFIG_X86_32 nor CONFIG_IA32_EMULATION is enabled. So the link error occurs.
"""

Below is the reproduce log:

linux-rtfsc:/home/linmiaohe/linux # git reset --hard
HEAD is now at 69b41ac87e4a Merge tag 'for-6.2-rc2-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
linux-rtfsc:/home/linmiaohe/linux # git clean -dqfx
linux-rtfsc:/home/linmiaohe/linux # cp ../virt/hmm_config .config
linux-rtfsc:/home/linmiaohe/linux # make menuconfig -j384
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/confdata.o
  HOSTCC  scripts/kconfig/expr.o
  YACC    scripts/kconfig/parser.tab.[ch]
  HOSTCC  scripts/kconfig/menu.o
  LEX     scripts/kconfig/lexer.lex.c
  HOSTCC  scripts/kconfig/preprocess.o
  HOSTCC  scripts/kconfig/symbol.o
  HOSTCC  scripts/kconfig/util.o
  HOSTCC  scripts/kconfig/mconf.o
  HOSTCC  scripts/kconfig/lxdialog/checklist.o
  HOSTCC  scripts/kconfig/lxdialog/inputbox.o
  HOSTCC  scripts/kconfig/lxdialog/textbox.o
  HOSTCC  scripts/kconfig/lxdialog/menubox.o
  HOSTCC  scripts/kconfig/lxdialog/util.o
  HOSTCC  scripts/kconfig/lxdialog/yesno.o
  HOSTCC  scripts/kconfig/lexer.lex.o
  HOSTCC  scripts/kconfig/parser.tab.o
  HOSTLD  scripts/kconfig/mconf
.config:5767:warning: symbol value 'm' invalid for VFIO_VIRQFD


*** End of the configuration.
*** Execute 'make' to start the build or try 'make help'.

linux-rtfsc:/home/linmiaohe/linux # make -j384
...
  DESCEND objtool
  CALL    scripts/checksyscalls.sh
  UPD     include/generated/utsversion.h
  CC      init/version-timestamp.o
  LD      .tmp_vmlinux.kallsyms1
ld: arch/x86/kernel/fpu/signal.o: in function `__fpu_restore_sig':
/home/linmiaohe/linux/arch/x86/kernel/fpu/signal.c:421: undefined reference to `convert_to_fxsr'
make[1]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
make: *** [Makefile:1252: vmlinux] Error 2
make: *** Waiting for unfinished jobs....
linux-rtfsc:/home/linmiaohe/linux #

Many thanks for your time. :)

Thanks,
Miaohe Lin
