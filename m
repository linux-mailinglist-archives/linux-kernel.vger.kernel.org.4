Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE416B9665
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjCNNfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjCNNfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:35:13 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679771F49C;
        Tue, 14 Mar 2023 06:31:11 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PbZD96Sf2z4x5R;
        Wed, 15 Mar 2023 00:31:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1678800666;
        bh=RWpQH91z9oCPCV7UgB1VjeBlCalvsZzq/D68BsBI0Ww=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Gmi2DLvR7FFuYEzpwxyajVFJgqqPUe+t2SrIuwdBqzYcgbPpV3TLjtx3waxpWL6PS
         Tlm2qgbZO6FByZBDH6vF20yDA6dWo8oqnebJk3mUZNrFfgeS07oV/YOl+wQ/pjVzZu
         NwgdFlLy64biV7j4n9vGCDKf7dkUIoM/W/PbkbUt8GCcCNGFWLT03R3isUmlhyjLoN
         z+e+Uak4GXq1yhQ7L0Ld0I2uWeJ7ZdLzkVARLCWcim1o6ZC2zU4FnwLI9WmUPUXLXt
         pck/4eDZ5TqTFY6UejLoZnpTjGPIH2V00sS3IcxUEmiEM4sMhD557XPpadOlNh7qRi
         JJdlXEA0IptgQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Fangrui Song <maskray@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        Fangrui Song <maskray@google.com>
Subject: Re: [PATCH v3] vdso: Improve cmd_vdso_check to check all dynamic
 relocations
In-Reply-To: <20230310190750.3323802-1-maskray@google.com>
References: <20230310190750.3323802-1-maskray@google.com>
Date:   Wed, 15 Mar 2023 00:28:53 +1100
Message-ID: <87jzzjo416.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fangrui Song <maskray@google.com> writes:
> The actual intention is that no dynamic relocation exists. However, some
> GNU ld ports produce unneeded R_*_NONE. (If a port fails to determine
> the exact .rel[a].dyn size, the trailing zeros become R_*_NONE
> relocations. E.g. ld's powerpc port recently fixed
> https://sourceware.org/bugzilla/show_bug.cgi?id=29540) R_*_NONE are
> generally no-op in the dynamic loaders. So just ignore them.
>
> With the change, we can remove ARCH_REL_TYPE_ABS. ARCH_REL_TYPE_ABS is a
> bit misnomer as ports may check RELAVETIVE/GLOB_DAT/JUMP_SLOT which are
> not called "absolute relocations". (The patch is motivated by the arm64
> port missing R_AARCH64_RELATIVE.)
>
> Signed-off-by: Fangrui Song <maskray@google.com>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com> # for vDSO, aarch64
> Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com> # for aarch64
> ---
> Changes from v2:
> * rebase
>
> Changes from v3:
> * Add a comment before `include $(srctree)/lib/vdso/Makefile` in every touched arch Makefile
> ---
>  arch/arm/vdso/Makefile            |  4 +---
>  arch/arm64/kernel/vdso/Makefile   |  4 +---
>  arch/arm64/kernel/vdso32/Makefile |  3 ---
>  arch/csky/kernel/vdso/Makefile    |  4 +---
>  arch/loongarch/vdso/Makefile      |  4 +---
>  arch/mips/vdso/Makefile           |  4 +---
>  arch/powerpc/kernel/vdso/Makefile |  2 +-

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
