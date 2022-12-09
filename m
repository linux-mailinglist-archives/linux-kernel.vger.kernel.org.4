Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321696487D0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiLIRfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiLIRfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:35:03 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7D446BC83;
        Fri,  9 Dec 2022 09:35:01 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1B1623A;
        Fri,  9 Dec 2022 09:35:07 -0800 (PST)
Received: from [10.57.7.11] (unknown [10.57.7.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C25993F73D;
        Fri,  9 Dec 2022 09:34:59 -0800 (PST)
Message-ID: <ba52dac5-2ce7-a567-41af-841b857abbed@arm.com>
Date:   Fri, 9 Dec 2022 17:34:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] lkdtm: Add CFI_BACKWARD to test ROP mitigations
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Cc:     Dan Li <ashimida@linux.alibaba.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20220416001103.1524653-1-keescook@chromium.org>
 <CAEUSe78kDPxQmQqCWW-_9LCgJDFhAeMoVBFnX9QLx18Z4uT4VQ@mail.gmail.com>
 <202212072221.A9FCC905CF@keescook>
From:   Kristina Martsenko <kristina.martsenko@arm.com>
In-Reply-To: <202212072221.A9FCC905CF@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2022 06:22, Kees Cook wrote:
> On Tue, Dec 06, 2022 at 06:28:53PM -0600, Daniel Dï¿½az wrote:
>> Hello!
>>
>> On Sat, 16 Apr 2022 at 00:30, Kees Cook <keescook@chromium.org> wrote:
>>> In order to test various backward-edge control flow integrity methods,
>>> add a test that manipulates the return address on the stack. Currently
>>> only arm64 Pointer Authentication and Shadow Call Stack is supported.
>>>
>>>  $ echo CFI_BACKWARD | cat >/sys/kernel/debug/provoke-crash/DIRECT
>>>
>>> Under SCS, successful test of the mitigation is reported as:
>>>
>>>  lkdtm: Performing direct entry CFI_BACKWARD
>>>  lkdtm: Attempting unchecked stack return address redirection ...
>>>  lkdtm: ok: redirected stack return address.
>>>  lkdtm: Attempting checked stack return address redirection ...
>>>  lkdtm: ok: control flow unchanged.
>>>
>>> Under PAC, successful test of the mitigation is reported by the PAC
>>> exception handler:
>>>
>>>  lkdtm: Performing direct entry CFI_BACKWARD
>>>  lkdtm: Attempting unchecked stack return address redirection ...
>>>  lkdtm: ok: redirected stack return address.
>>>  lkdtm: Attempting checked stack return address redirection ...
>>>  Unable to handle kernel paging request at virtual address bfffffc0088d0514
>>>  Mem abort info:
>>>    ESR = 0x86000004
>>>    EC = 0x21: IABT (current EL), IL = 32 bits
>>>    SET = 0, FnV = 0
>>>    EA = 0, S1PTW = 0
>>>    FSC = 0x04: level 0 translation fault
>>>  [bfffffc0088d0514] address between user and kernel address ranges
>>>  ...
>>>
>>> If the CONFIGs are missing (or the mitigation isn't working), failure
>>> is reported as:
>>>
>>>  lkdtm: Performing direct entry CFI_BACKWARD
>>>  lkdtm: Attempting unchecked stack return address redirection ...
>>>  lkdtm: ok: redirected stack return address.
>>>  lkdtm: Attempting checked stack return address redirection ...
>>>  lkdtm: FAIL: stack return address was redirected!
>>>  lkdtm: This is probably expected, since this kernel was built *without* CONFIG_ARM64_PTR_AUTH_KERNEL=y nor CONFIG_SHADOW_CALL_STACK=y
>>>
>>> Co-developed-by: Dan Li <ashimida@linux.alibaba.com>
>>> Signed-off-by: Dan Li <ashimida@linux.alibaba.com>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>> ---
>>> v1: https://lore.kernel.org/lkml/20220413213917.711770-1-keescook@chromium.org
>>> v2:
>>>  - add PAGE_OFFSET setting for PAC bits (Dan Li)
>>> ---
>>>  drivers/misc/lkdtm/cfi.c                | 134 ++++++++++++++++++++++++
>>>  tools/testing/selftests/lkdtm/tests.txt |   1 +
>>>  2 files changed, 135 insertions(+)
>>>
>>> diff --git a/drivers/misc/lkdtm/cfi.c b/drivers/misc/lkdtm/cfi.c
>>> index e88f778be0d5..804965a480b7 100644
>>> --- a/drivers/misc/lkdtm/cfi.c
>>> +++ b/drivers/misc/lkdtm/cfi.c
>>> @@ -3,6 +3,7 @@
>>>   * This is for all the tests relating directly to Control Flow Integrity.
>>>   */
>>>  #include "lkdtm.h"
>>> +#include <asm/page.h>
>>>
>>>  static int called_count;
>>>
>>> @@ -42,8 +43,141 @@ static void lkdtm_CFI_FORWARD_PROTO(void)
>>>         pr_expected_config(CONFIG_CFI_CLANG);
>>>  }
>>>
>>> +/*
>>> + * This can stay local to LKDTM, as there should not be a production reason
>>> + * to disable PAC && SCS.
>>> + */
>>> +#ifdef CONFIG_ARM64_PTR_AUTH_KERNEL
>>> +# ifdef CONFIG_ARM64_BTI_KERNEL
>>> +#  define __no_pac             "branch-protection=bti"
>>> +# else
>>> +#  define __no_pac             "branch-protection=none"
>>> +# endif
>>> +# define __no_ret_protection   __noscs __attribute__((__target__(__no_pac)))
>>> +#else
>>> +# define __no_ret_protection   __noscs
>>> +#endif
>>
>> We're seeing this problem with allmodconfig on arm64 and GCC 8 (this
>> one observed on 6.0.12-rc3):
>>
>> -----8<----------8<----------8<-----
>> make --silent --keep-going --jobs=8
>> O=/home/tuxbuild/.cache/tuxmake/builds/2/build
>> CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- ARCH=arm64
>> CROSS_COMPILE=aarch64-linux-gnu- 'CC=sccache aarch64-linux-gnu-gcc'
>> 'HOSTCC=sccache gcc'
>> /builds/linux/drivers/misc/lkdtm/cfi.c:67:1: error: pragma or
>> attribute 'target("branch-protection=none")' is not valid
>>  {
>>  ^
> 
> Uuuh... how is CONFIG_ARM64_PTR_AUTH_KERNEL getting set if the compiler
> can't support the 'target("branch-protection=none")' attribute?
> 

Older GCC versions supported the (now deprecated) -msign-return-address option 
instead of the newer -mbranch-protection option, and the kernel checks for that
too when setting CONFIG_ARM64_PTR_AUTH_KERNEL. I guess the test has never
compiled with older GCC versions. The following patch should fix it.

-- 8< --

Subject: [PATCH] lkdtm: cfi: Make PAC test work with GCC 7 and 8

The CFI test uses the branch-protection=none compiler attribute to
disable PAC return address protection on a function. While newer GCC
versions support this attribute, older versions (GCC 7 and 8) instead
supported the sign-return-address=none attribute, leading to a build
failure when the test is built with older compilers. Fix it by checking
which attribute is supported and using the correct one.

Fixes: 2e53b877dc12 ("lkdtm: Add CFI_BACKWARD to test ROP mitigations")
Reported-by: Daniel Díaz <daniel.diaz@linaro.org>
Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
Link: https://lore.kernel.org/all/CAEUSe78kDPxQmQqCWW-_9LCgJDFhAeMoVBFnX9QLx18Z4uT4VQ@mail.gmail.com/
---
 drivers/misc/lkdtm/cfi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm/cfi.c b/drivers/misc/lkdtm/cfi.c
index 5245cf6013c9..d4bb8e31a2fe 100644
--- a/drivers/misc/lkdtm/cfi.c
+++ b/drivers/misc/lkdtm/cfi.c
@@ -54,7 +54,11 @@ static void lkdtm_CFI_FORWARD_PROTO(void)
 # ifdef CONFIG_ARM64_BTI_KERNEL
 #  define __no_pac             "branch-protection=bti"
 # else
-#  define __no_pac             "branch-protection=none"
+#  ifdef CONFIG_CC_HAS_BRANCH_PROT_PAC_RET
+#   define __no_pac             "branch-protection=none"
+#  else
+#   define __no_pac             "sign-return-address=none"
+#  endif
 # endif
 # define __no_ret_protection   __noscs __attribute__((__target__(__no_pac)))
 #else

