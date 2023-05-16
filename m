Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D2C704513
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 08:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjEPGS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 02:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjEPGS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 02:18:56 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9383B2D42;
        Mon, 15 May 2023 23:18:53 -0700 (PDT)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id 0FBEDE0005;
        Tue, 16 May 2023 06:18:47 +0000 (UTC)
Message-ID: <5d894e71-25ad-8ba0-f632-2eec6e017f46@ghiti.fr>
Date:   Tue, 16 May 2023 08:18:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: linux-next: Tree for May 15 (several RV64 build errors)
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor@kernel.org>
References: <20230515141235.0777c631@canb.auug.org.au>
 <54244db6-ff69-4cf8-894c-c3dd2f12df9c@infradead.org>
Content-Language: en-US
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <54244db6-ff69-4cf8-894c-c3dd2f12df9c@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/23 04:45, Randy Dunlap wrote:
>
> On 5/14/23 21:12, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20230512:
>>
> ../arch/riscv/mm/init.c: In function 'create_fdt_early_page_table':
> ../arch/riscv/mm/init.c:925:19: warning: unused variable 'pa' [-Wunused-variable]
>    925 |         uintptr_t pa = dtb_pa & ~(PMD_SIZE - 1);
>        |                   ^~


This one slipped through, I'm adding !BUILTIN_DTB to our internal CI, 
I'll send a fix today.


>
> /opt/crosstool/gcc-12.2.0-nolibc/riscv64-linux/bin/riscv64-linux-ld: section .data LMA [000000000041a000,00000000075bffd7] overlaps section .text LMA [00000000000f09d4,00000000033562ab]
> /opt/crosstool/gcc-12.2.0-nolibc/riscv64-linux/bin/riscv64-linux-ld: section .init.pi.text LMA [00000000033562ac,0000000003359137] overlaps section .data LMA [000000000041a000,00000000075bffd7]


I'll check this one too which seems to be related to kernel/pi introduction.


>
> /opt/crosstool/gcc-12.2.0-nolibc/riscv64-linux/bin/riscv64-linux-ld: drivers/iommu/io-pgtable-arm.o: in function `.L227':
> io-pgtable-arm.c:(.init.text+0x444): undefined reference to `alloc_io_pgtable_ops'
> /opt/crosstool/gcc-12.2.0-nolibc/riscv64-linux/bin/riscv64-linux-ld: drivers/iommu/io-pgtable-arm.o: in function `.L0 ':
> io-pgtable-arm.c:(.init.text+0xc4c): undefined reference to `free_io_pgtable_ops'
> /opt/crosstool/gcc-12.2.0-nolibc/riscv64-linux/bin/riscv64-linux-ld: drivers/iommu/ipmmu-vmsa.o: in function `.L690':
> ipmmu-vmsa.c:(.text+0x2260): undefined reference to `free_io_pgtable_ops'
> /opt/crosstool/gcc-12.2.0-nolibc/riscv64-linux/bin/riscv64-linux-ld: drivers/iommu/ipmmu-vmsa.o: in function `.L1309':
> ipmmu-vmsa.c:(.text+0x3f24): undefined reference to `alloc_io_pgtable_ops'


Ok, those ones too....


Thanks for the report,


Alex


>
>
> Full randconfig file is attached.
>
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
