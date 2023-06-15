Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C0C731F6B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237549AbjFORlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236688AbjFORlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:41:06 -0400
X-Greylist: delayed 3356 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Jun 2023 10:40:58 PDT
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D80F2719
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 10:40:58 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 35FGJsTl017085;
        Thu, 15 Jun 2023 11:19:54 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 35FGJqSI017082;
        Thu, 15 Jun 2023 11:19:52 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 15 Jun 2023 11:19:52 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Eric DeVolder <eric.devolder@oracle.com>, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
        geert@linux-m68k.org, tsbogend@alpha.franken.de,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        ysato@users.osdn.me, dalias@libc.org, glaubitz@physik.fu-berlin.de,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, 86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, peterz@infradead.org,
        linus.walleij@linaro.org, thunder.leizhen@huawei.com,
        hpa@zytor.com, kernel@xen0n.name, ardb@kernel.org, tsi@tuyoix.net,
        agordeev@linux.ibm.com, paulmck@kernel.org, bhe@redhat.com,
        masahiroy@kernel.org, konrad.wilk@oracle.com,
        sebastian.reichel@collabora.com, samitolvanen@google.com,
        ojeda@kernel.org, juerg.haefliger@canonical.com,
        borntraeger@linux.ibm.com, frederic@kernel.org, arnd@arndb.de,
        mhiramat@kernel.org, aou@eecs.berkeley.edu, keescook@chromium.org,
        gor@linux.ibm.com, anshuman.khandual@arm.com, hca@linux.ibm.com,
        xin3.li@intel.com, npiggin@gmail.com, rmk+kernel@armlinux.org.uk,
        paul.walmsley@sifive.com, boris.ostrovsky@oracle.com,
        ziy@nvidia.com, hbathini@linux.ibm.com, gregkh@linuxfoundation.org,
        kirill.shutemov@linux.intel.com, ndesaulniers@google.com,
        sourabhjain@linux.ibm.com, palmer@dabbelt.com, svens@linux.ibm.com,
        tj@kernel.org, akpm@linux-foundation.org, rppt@kernel.org
Subject: Re: [PATCH v1 10/21] powerpc/kexec: refactor for kernel/Kconfig.kexec
Message-ID: <20230615161952.GD19790@gate.crashing.org>
References: <20230612172805.681179-1-eric.devolder@oracle.com> <20230612172805.681179-11-eric.devolder@oracle.com> <87fs6tflfi.fsf@mail.lhotse>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fs6tflfi.fsf@mail.lhotse>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 01:34:25PM +1000, Michael Ellerman wrote:
> Eric DeVolder <eric.devolder@oracle.com> writes:
> > -config KEXEC_FILE
> > -	bool "kexec file based system call"
> > -	select KEXEC_CORE
> > -	select HAVE_IMA_KEXEC if IMA
> > -	select KEXEC_ELF
> > -	depends on PPC64
> > -	depends on CRYPTO=y
> > -	depends on CRYPTO_SHA256=y
> ...
> > +
> > +config ARCH_HAS_KEXEC_FILE
> > +	def_bool PPC64 && CRYPTO && CRYPTO_SHA256
> 
> The =y's got lost here.
> 
> I think they were both meaningful, because both options are tristate. So
> this previously required them to be built-in (=y), whereas after your
> patch it will allow them to be modules.
> 
> I don't know for sure that those options need to be built-in, but that's
> what the code does now, so this patch shouldn't change it, at least
> without an explanation.

This patch shouldn't change it at all, period.  If you want to change it
(and that sounds like a good idea, if it is possible anyway), that
should be a separate patch.


Segher
