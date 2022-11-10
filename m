Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5487E623F97
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiKJKPX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Nov 2022 05:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKJKPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:15:21 -0500
X-Greylist: delayed 584 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Nov 2022 02:15:19 PST
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7FFF60E97
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 02:15:19 -0800 (PST)
HMM_SOURCE_IP: 172.18.0.188:58510.456354312
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-10.133.8.199 (unknown [172.18.0.188])
        by chinatelecom.cn (HERMES) with SMTP id F38C12800D9;
        Thu, 10 Nov 2022 18:05:13 +0800 (CST)
X-189-SAVE-TO-SEND: huyd12@chinatelecom.cn
Received: from  ([10.133.8.199])
        by app0023 with ESMTP id faa22b8ad1a34afc97177a92b20272eb for boqun.feng@gmail.com;
        Thu, 10 Nov 2022 18:05:33 CST
X-Transaction-ID: faa22b8ad1a34afc97177a92b20272eb
X-Real-From: huyd12@chinatelecom.cn
X-Receive-IP: 10.133.8.199
X-MEDUSA-Status: 0
Sender: huyd12@chinatelecom.cn
From:   <huyd12@chinatelecom.cn>
To:     <nathan@kernel.org>, <guoj17@chinatelecom.cn>
Cc:     <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
        <tglx@linutronix.de>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <longman@redhat.com>, <boqun.feng@gmail.com>,
        <linux-kernel@vger.kernel.org>, <hpa@zytor.com>,
        <ndesaulniers@google.com>, <trix@redhat.com>,
        <llvm@lists.linux.dev>
References: <20221108060126.2505-1-guoj17@chinatelecom.cn> <Y2rayPgDfL2NYcjQ@dev-arch.thelio-3990X>
In-Reply-To: <Y2rayPgDfL2NYcjQ@dev-arch.thelio-3990X>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBsb2NraW5nOiBmaXgga2VybmVsL2xvY2tpbg==?=
        =?gb2312?B?Zy8gaW5saW5lIGFzbSBlcnJvcg==?=
Date:   Thu, 10 Nov 2022 18:05:13 +0800
Message-ID: <001d01d8f4eb$f0f37a90$d2da6fb0$@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="gb2312"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKFEmH8zKzDbyVrnMB6jnsnqOop9AI9ItAUrM3JQRA=
Content-Language: zh-cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks your comments, 
And if any concern to apply it on upstream?

Yadi

-----邮件原件-----
发件人: nathan@kernel.org <nathan@kernel.org> 
发送时间: 2022年11月9日 6:40
收件人: guoj17@chinatelecom.cn
抄送: peterz@infradead.org; mingo@redhat.com; will@kernel.org;
tglx@linutronix.de; bp@alien8.de; dave.hansen@linux.intel.com;
x86@kernel.org; longman@redhat.com; boqun.feng@gmail.com; linux-kernel@vger.
kernel.org; hpa@zytor.com; ndesaulniers@google.com; trix@redhat.com;
llvm@lists.linux.dev; huyd12@chinatelecom.cn
主题: Re: [PATCH] locking: fix kernel/locking/ inline asm error

On Tue, Nov 08, 2022 at 02:01:26PM +0800, guoj17@chinatelecom.cn wrote:
> From: Guo Jin <guoj17@chinatelecom.cn>
> 
> When compiling linux 6.1.0-rc3 configured with CONFIG_64BIT=y and 
> CONFIG_PARAVIRT_SPINLOCKS=y on x86_64 using LLVM 11.0, an error: 
> "<inline asm> error: changed section flags for .spinlock.text, 
> expected:: 0x6" occurred.
> 
> The reason is the .spinlock.text in kernel/locking/qspinlock.o is used 
> many times, but its flags are omitted in subsequent use.
> 
> LLVM 11.0 assembler didn't permit to
> leave out flags in subsequent uses of the same sections.
> 
> So this patch adds the corresponding flags to avoid above error.
> 
> Signed-off-by: Guo Jin <guoj17@chinatelecom.cn>

Right, my reverse bisect tells me that this error was fixed by [1] in LLVM,
which landed in 12.0.0 and was backported to LLVM 11.0.1 [2].

We could bump the minimum supported version of LLVM for building the kernel
to 11.0.1 over this, just to avoid further issues like this down the road,
as the kernel will always be adding new sections for various things. That
change would not appear to be disruptive, as all the major distros either
have 11.0.1 or newer or older than the current minimum of 11.0.0, so they
need to get clang from elsewhere already.

archlinux:latest: clang version 14.0.6

debian:oldoldstable-slim: clang version 3.8.1-24 (tags/RELEASE_381/final)
debian:oldstable-slim: clang version 7.0.1-8+deb10u2
(tags/RELEASE_701/final)
debian:stable-slim: Debian clang version 11.0.1-2
debian:testing-slim: Debian clang version 14.0.6-2
debian:unstable-slim: Debian clang version 14.0.6-7

fedora:35: clang version 13.0.1 (Fedora 13.0.1-1.fc35)
fedora:latest: clang version 14.0.5 (Fedora 14.0.5-1.fc36)
fedora:rawhide: clang version 15.0.4 (Fedora 15.0.4-1.fc38)

opensuse/leap:15: clang version 13.0.1
opensuse/leap:latest: clang version 13.0.1
opensuse/tumbleweed:latest: clang version 15.0.3

ubuntu:bionic: clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
ubuntu:focal: clang version 10.0.0-4ubuntu1
ubuntu:latest: Ubuntu clang version 14.0.0-1ubuntu1
ubuntu:kinetic: Ubuntu clang version 15.0.2-1
ubuntu:rolling: Ubuntu clang version 15.0.2-1
ubuntu:devel: Ubuntu clang version 15.0.2-1

At the same time, you are clearly using LLVM 11.0.0, so I think this is a
reasonable fix in the immediate term.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

[1]:
https://github.com/llvm/llvm-project/commit/1deff4009e0ae661b03682901bf69322
97ce7ea1
[2]:
https://github.com/llvm/llvm-project/commit/700baa009dc685a0adc5f94d258be4ae
24742471

> ---
>  arch/x86/include/asm/qspinlock_paravirt.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/qspinlock_paravirt.h 
> b/arch/x86/include/asm/qspinlock_paravirt.h
> index 60ece592b220..dbb38a6b4dfb 100644
> --- a/arch/x86/include/asm/qspinlock_paravirt.h
> +++ b/arch/x86/include/asm/qspinlock_paravirt.h
> @@ -37,7 +37,7 @@
__PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath,
".spinlock.text");
>   *   rsi = lockval           (second argument)
>   *   rdx = internal variable (set to 0)
>   */
> -asm    (".pushsection .spinlock.text;"
> +asm    (".pushsection .spinlock.text, \"ax\";"
>  	".globl " PV_UNLOCK ";"
>  	".type " PV_UNLOCK ", @function;"
>  	".align 4,0x90;"
> --
> 2.25.1
> 

