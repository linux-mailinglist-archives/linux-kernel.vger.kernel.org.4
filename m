Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41CC730D99
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 05:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbjFODel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 23:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237612AbjFODec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 23:34:32 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFB42702;
        Wed, 14 Jun 2023 20:34:29 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QhSZn5RL6z4wjB;
        Thu, 15 Jun 2023 13:34:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1686800067;
        bh=YpcS1BrLjvGbDxUqeoV3otHCJ3+/0YDjxYK8icm+ysA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=eEFN1zC7xAn1Wr3Kit71RQEzhLSL4SIBGcM6Ixe1KFqmhMEDomwzMDGJd3HwTL8zN
         Z5SzsEAPWzmB9tToxQgSaEVOZXcEQR7leaAQGQjisqMEYiBBeqWsC5xWKqS8nyBQLS
         pZzn7lqvIK5M7QTIjRhq5k3woxwBsVmXj1ytVeSX3L8BgOr6n2Y9Xmg03KpI+lVpeE
         ZQAqJIHwBFhFhWRd2V6IMzeNMrigU4PNW1gqmzYWbgPI4yfBONTfaDdJaTx2Ggqek4
         HbDECZQGZ/n1t7b6XWR17o8sR8f4D6jNZpL9A5ut0u3lqw1gvXjyrzPclYoftupZAa
         PNxDjHn73WIPw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Eric DeVolder <eric.devolder@oracle.com>, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
        geert@linux-m68k.org, tsbogend@alpha.franken.de,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        ysato@users.sourceforge.jp, dalias@libc.org,
        glaubitz@physik.fu-berlin.de, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, 86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org
Cc:     kernel@xen0n.name, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, hpa@zytor.com, keescook@chromium.org,
        paulmck@kernel.org, peterz@infradead.org, frederic@kernel.org,
        akpm@linux-foundation.org, ardb@kernel.org,
        samitolvanen@google.com, juerg.haefliger@canonical.com,
        arnd@arndb.de, rmk+kernel@armlinux.org.uk,
        linus.walleij@linaro.org, sebastian.reichel@collabora.com,
        rppt@kernel.org, kirill.shutemov@linux.intel.com,
        anshuman.khandual@arm.com, ziy@nvidia.com, masahiroy@kernel.org,
        ndesaulniers@google.com, mhiramat@kernel.org, ojeda@kernel.org,
        thunder.leizhen@huawei.com, xin3.li@intel.com, tj@kernel.org,
        gregkh@linuxfoundation.org, tsi@tuyoix.net, bhe@redhat.com,
        hbathini@linux.ibm.com, sourabhjain@linux.ibm.com,
        eric.devolder@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v1 10/21] powerpc/kexec: refactor for kernel/Kconfig.kexec
In-Reply-To: <20230612172805.681179-11-eric.devolder@oracle.com>
References: <20230612172805.681179-1-eric.devolder@oracle.com>
 <20230612172805.681179-11-eric.devolder@oracle.com>
Date:   Thu, 15 Jun 2023 13:34:25 +1000
Message-ID: <87fs6tflfi.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric DeVolder <eric.devolder@oracle.com> writes:

> The kexec and crash kernel options are provided in the common
> kernel/Kconfig.kexec. Utilize the common options and provide
> the ARCH_HAS_ and ARCH_SUPPORTS_ entries to recreate the
> equivalent set of KEXEC and CRASH options.
>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  arch/powerpc/Kconfig | 55 ++++++++++++++------------------------------
>  1 file changed, 17 insertions(+), 38 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index bff5820b7cda..36f2fe0cc8a5 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -588,41 +588,21 @@ config PPC64_SUPPORTS_MEMORY_FAILURE
>  	default "y" if PPC_POWERNV
>  	select ARCH_SUPPORTS_MEMORY_FAILURE
>  
> -config KEXEC
> -	bool "kexec system call"
> -	depends on PPC_BOOK3S || PPC_E500 || (44x && !SMP)
> -	select KEXEC_CORE
> -	help
> -	  kexec is a system call that implements the ability to shutdown your
> -	  current kernel, and to start another kernel.  It is like a reboot
> -	  but it is independent of the system firmware.   And like a reboot
> -	  you can start any kernel with it, not just Linux.
> -
> -	  The name comes from the similarity to the exec system call.
> -
> -	  It is an ongoing process to be certain the hardware in a machine
> -	  is properly shutdown, so do not be surprised if this code does not
> -	  initially work for you.  As of this writing the exact hardware
> -	  interface is strongly in flux, so no good recommendation can be
> -	  made.
> -
> -config KEXEC_FILE
> -	bool "kexec file based system call"
> -	select KEXEC_CORE
> -	select HAVE_IMA_KEXEC if IMA
> -	select KEXEC_ELF
> -	depends on PPC64
> -	depends on CRYPTO=y
> -	depends on CRYPTO_SHA256=y
...
> +
> +config ARCH_HAS_KEXEC_FILE
> +	def_bool PPC64 && CRYPTO && CRYPTO_SHA256

The =y's got lost here.

I think they were both meaningful, because both options are tristate. So
this previously required them to be built-in (=y), whereas after your
patch it will allow them to be modules.

I don't know for sure that those options need to be built-in, but that's
what the code does now, so this patch shouldn't change it, at least
without an explanation.

cheers
