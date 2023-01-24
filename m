Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB03D679292
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 09:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjAXIJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 03:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjAXIJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 03:09:42 -0500
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DA33D935;
        Tue, 24 Jan 2023 00:09:41 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pKEMy-002UjK-9t; Tue, 24 Jan 2023 09:09:28 +0100
Received: from dynamic-078-055-147-119.78.55.pool.telefonica.de ([78.55.147.119] helo=[192.168.1.11])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pKEMy-001fq4-35; Tue, 24 Jan 2023 09:09:28 +0100
Message-ID: <9553643d-8802-e863-bd21-c316f2788f79@physik.fu-berlin.de>
Date:   Tue, 24 Jan 2023 09:09:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] sh: define RUNTIME_DISCARD_EXIT
Content-Language: en-US
To:     Tom Saeger <tom.saeger@oracle.com>, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     akpm@linux-foundation.org, Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Dennis Gilmore <dennis@ausil.us>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        torvalds@linux-foundation.org
References: <9166a8abdc0f979e50377e61780a4bba1dfa2f52.1674518464.git.tom.saeger@oracle.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <9166a8abdc0f979e50377e61780a4bba1dfa2f52.1674518464.git.tom.saeger@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 78.55.147.119
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom!

On 1/24/23 01:09, Tom Saeger wrote:
> sh vmlinux fails to link with GNU ld < 2.40 (likely < 2.36) since
> commit 99cb0d917ffa ("arch: fix broken BuildID for arm64 and riscv").

Works for me with binutils 2.36.1.

> This is similar to fixes for powerpc and s390:
> commit 4b9880dbf3bd ("powerpc/vmlinux.lds: Define RUNTIME_DISCARD_EXIT").
> commit a494398bde27 ("s390: define RUNTIME_DISCARD_EXIT to fix link error
> with GNU ld < 2.36").
> 
>    $ sh4-linux-gnu-ld --version | head -n1
>    GNU ld (GNU Binutils for Debian) 2.35.2
> 
>    $ make ARCH=sh CROSS_COMPILE=sh4-linux-gnu- microdev_defconfig
>    $ make ARCH=sh CROSS_COMPILE=sh4-linux-gnu-
> 
>    `.exit.text' referenced in section `__bug_table' of crypto/algboss.o:
>    defined in discarded section `.exit.text' of crypto/algboss.o
>    `.exit.text' referenced in section `__bug_table' of
>    drivers/char/hw_random/core.o: defined in discarded section
>    `.exit.text' of drivers/char/hw_random/core.o
>    make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
>    make[1]: *** [Makefile:1252: vmlinux] Error 2
> 
> arch/sh/kernel/vmlinux.lds.S keeps EXIT_TEXT:
> 
> 	/*
> 	 * .exit.text is discarded at runtime, not link time, to deal with
> 	 * references from __bug_table
> 	 */
> 	.exit.text : AT(ADDR(.exit.text)) { EXIT_TEXT }
> 
> However, EXIT_TEXT is thrown away by
> DISCARD(include/asm-generic/vmlinux.lds.h) because
> sh does not define RUNTIME_DISCARD_EXIT.
> 
> GNU ld 2.40 does not have this issue and builds fine.
> This corresponds with Masahiro's comments in a494398bde27:
> "Nathan [Chancellor] also found that binutils
> commit 21401fc7bf67 ("Duplicate output sections in scripts") cured this
> issue, so we cannot reproduce it with binutils 2.36+, but it is better
> to not rely on it."
> 
> Fixes: 99cb0d917ffa ("arch: fix broken BuildID for arm64 and riscv")
> Link: https://lore.kernel.org/all/Y7Jal56f6UBh1abE@dev-arch.thelio-3990X/
> Link: https://lore.kernel.org/all/20230123194218.47ssfzhrpnv3xfez@oracle.com/
> Signed-off-by: Tom Saeger <tom.saeger@oracle.com>

I'm in favor of including this patch for the said reasons.

> This may be moot given sh might be soon removed:
> https://lore.kernel.org/all/20230113062339.1909087-1-hch@lst.de/#t
> 
> However this did come up here:
> https://lore.kernel.org/all/20230123194218.47ssfzhrpnv3xfez@oracle.com/

We're currently busy trying to save arch/sh.

Thanks,
Adrian

-- 
  .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

