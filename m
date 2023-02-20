Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9493669C76C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjBTJOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjBTJON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:14:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ADFFF0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:14:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EE1460D2E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B570C433EF;
        Mon, 20 Feb 2023 09:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676884451;
        bh=mG/NJn6UIKMCtB1jUJxsXAFCx30P4P2liMAXbdz/2Xo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mAcRmoA6Qn3UZ1chqK60R1a2hOSyf3/oQFr9/z4MVnvrvZpMm1yEwoqqWTqJ0IMbh
         L7W844Whmf+R+CoIxa/+5A3ShRVClbZ91nvx+OLA3SadOpiq7O719RAXw69X71/BFU
         DtFAIuLebpfytY40BPrUr7OG2trd4+iPLaHButziGI9MBP/STpDpPG5uxN5UKtSV8L
         XYiDzlzvSsIrgoy5ZcCrtXTfbe3nwCMDN/Ar2nzLAxsIQ+wsFrrTsbzB//rb7Y82N7
         KtKQJEvcSyK7lCJv3F7dJaUIbglBk2CjsdArBrH867pR97sXB1f+v1CjyC8P9rDpg5
         fc8kEM4T9n7lg==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v8 0/3] Introduce 64b relocatable kernel
In-Reply-To: <20230215143626.453491-1-alexghiti@rivosinc.com>
References: <20230215143626.453491-1-alexghiti@rivosinc.com>
Date:   Mon, 20 Feb 2023 10:14:09 +0100
Message-ID: <87y1osog0u.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Ghiti <alexghiti@rivosinc.com> writes:

> After multiple attempts, this patchset is now based on the fact that the
> 64b kernel mapping was moved outside the linear mapping.
>
> The first patch allows to build relocatable kernels but is not selected
> by default. That patch is a requirement for KASLR.
> The second and third patches take advantage of an already existing powerpc
> script that checks relocations at compile-time, and uses it for riscv.
>
> This patchset is rebased on top of:
>
> RISC-V kasan rework (https://lore.kernel.org/lkml/Y6TTvku%2FyuSjm42j@spud=
/T/)
> riscv: Use PUD/P4D/PGD pages for the linear mapping (https://lore.kernel.=
org/lkml/20230125114229.hrhsyw4aegrnmoau@orel/T/)
> riscv: Allow to downgrade paging mode from the command line (https://lore=
.kernel.org/lkml/CAHVXubjeSMvfTPnvrnYRupOGx6+vUvUGfRS3piTeo=3DTH2cHKNg@mail=
.gmail.com/)
> base-commit-tag: v6.2-rc7
>
> Changes in v8:
>   * Fix UEFI boot by moving rela.dyn section into the data so that PE/COFF
>     loader actually copies the relocations too
>   * Fix check that used PGDIR instead of PUD which was not correct
>     for sv48 and sv57
>   * Fix PE/COFF header data size definition as it led to size of 0
>
> Changes in v7:
>   * Rebase on top of v5.15
>   * Fix LDFLAGS_vmlinux which was overriden when CONFIG_DYNAMIC_FTRACE was
>     set
>   * Make relocate_kernel static
>   * Add Ack from Michael
>
> Changes in v6:
>   * Remove the kernel move to vmalloc zone
>   * Rebased on top of for-next
>   * Remove relocatable property from 32b kernel as the kernel is mapped in
>     the linear mapping and would then need to be copied physically too
>   * CONFIG_RELOCATABLE depends on !XIP_KERNEL
>   * Remove Reviewed-by from first patch as it changed a bit
>
> Changes in v5:
>   * Add "static __init" to create_kernel_page_table function as reported =
by
>     Kbuild test robot
>   * Add reviewed-by from Zong
>   * Rebase onto v5.7
>
> Changes in v4:
>   * Fix BPF region that overlapped with kernel's as suggested by Zong
>   * Fix end of module region that could be larger than 2GB as suggested b=
y Zong
>   * Fix the size of the vm area reserved for the kernel as we could lose
>     PMD_SIZE if the size was already aligned on PMD_SIZE
>   * Split compile time relocations check patch into 2 patches as suggeste=
d by Anup
>   * Applied Reviewed-by from Zong and Anup
>
> Changes in v3:
>   * Move kernel mapping to vmalloc
>
> Changes in v2:
>   * Make RELOCATABLE depend on MMU as suggested by Anup
>   * Rename kernel_load_addr into kernel_virt_addr as suggested by Anup
>   * Use __pa_symbol instead of __pa, as suggested by Zong
>   * Rebased on top of v5.6-rc3
>   * Tested with sv48 patchset
>   * Add Reviewed/Tested-by from Zong and Anup
>
> Alexandre Ghiti (3):
>   riscv: Introduce CONFIG_RELOCATABLE
>   powerpc: Move script to check relocations at compile time in scripts/
>   riscv: Check relocations at compile time

I'm getting issues booting via UEFI/efi-stub with this, because the PE
header is messed up.

from arch/riscv/kernel/efi-header.S:

 | ...
 | extra_header_fields:
 |         .quad   0                                       // ImageBase
 |         .long   PECOFF_SECTION_ALIGNMENT                // SectionAlignm=
ent
 |         .long   PECOFF_FILE_ALIGNMENT                   // FileAlignment
 | ...

PECOFF* is taken from the linker-script, and ends up in relocation
section. When u-boot tried to load the image, alignment is zero and the
loader breaks.


Bj=C3=B6rn
