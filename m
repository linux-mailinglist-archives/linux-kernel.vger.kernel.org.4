Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F53473968B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 06:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjFVE4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 00:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFVE4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 00:56:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2519199D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 21:56:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 437A161703
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 04:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51232C433C8;
        Thu, 22 Jun 2023 04:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687409766;
        bh=g7D6HBzEigVjHztCXXrF3KEb3b7m425hu9GVu3l4Q2g=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=UBpFByEME8DHHgZfpMLxsOftIX/Geuj9XgTa40W7vsgj0Q1NItCXIdzDyyXC8LEMz
         Dl0TF/XxzLn0/S5CQf0ezwE87ckKMEby4x45rr/snH2Yk4dHit9lHL4p8dLn3i/Ccw
         /2BB8CZMUDKC/zJVxMM5M6n+67HximIqY1ufCtYxMgfoqsWVn+CbpMLsmnTS+NPogz
         dd7gpY6jcCi3CSAwchyzoVvMgdf206spTgGOvjqygOV5TwvEvHRBtfwySmnPbOdgYa
         ooJtBauPXcp5WVbqN4qT4qzKvwDgybR+WogGi4xNQtpm21WQv1aMqmzfDqn/Wuxy4d
         8jdv+rbXkq+cw==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, Bjorn Topel <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, david@redhat.com,
        osalvador@suse.de, virtualization@lists.linux-foundation.org,
        linux@rivosinc.com, alexghiti@rivosinc.com
Subject: Re: [PATCH 3/7] riscv: mm: Refactor create_linear_mapping_range()
 for hot add
In-Reply-To: <mhng-ec7e2bae-2eb8-45c5-b7e4-bc2a931760df@palmer-ri-x1c9a>
References: <mhng-ec7e2bae-2eb8-45c5-b7e4-bc2a931760df@palmer-ri-x1c9a>
Date:   Thu, 22 Jun 2023 06:56:04 +0200
Message-ID: <87y1kcumcb.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Palmer Dabbelt <palmer@dabbelt.com> writes:

> On Fri, 12 May 2023 07:57:33 PDT (-0700), bjorn@kernel.org wrote:
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>
>> Add a parameter to the direct map setup function, so it can be used in
>> arch_add_memory() later.
>>
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>> ---
>>  arch/riscv/mm/init.c | 18 +++++++++---------
>>  1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index e974ff6ef036..aea8ccb3f4ae 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -1247,18 +1247,19 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>>  	pt_ops_set_fixmap();
>>  }
>>
>> -static void __init create_linear_mapping_range(phys_addr_t start,
>> -					       phys_addr_t end)
>> +static void __meminit create_linear_mapping_range(phys_addr_t start, ph=
ys_addr_t end,
>> +						  struct mhp_params *params)
>
> Sorry if I missed a v2, but it looks like this fails to build under=20
> CONFIG_MEMORY_HOTPLUG=3Dn (as struct mhp_params isn't defined) -- unless =
I=20
> screwed up some merge conflict, but doesn't look like it here.
>
> I'm getting
>
>       CC      arch/riscv/mm/init.o
>     arch/riscv/mm/init.c:1252:58: warning: =E2=80=98struct mhp_params=E2=
=80=99 declared inside parameter list will not be visible outside of this d=
efinition or declaration
>      1252 |                                                   struct mhp_=
params *params)
>           |                                                          ^~~~=
~~~~~~
>     arch/riscv/mm/init.c: In function =E2=80=98create_linear_mapping_rang=
e=E2=80=99:
>     arch/riscv/mm/init.c:1261:42: error: invalid use of undefined type =
=E2=80=98struct mhp_params=E2=80=99
>      1261 |                 pgprot =3D  params ? params->pgprot : pgprot_=
from_va(va);
>           |                                          ^~
>     make[3]: *** [scripts/Makefile.build:252: arch/riscv/mm/init.o] Error=
 1
>     make[2]: *** [scripts/Makefile.build:494: arch/riscv/mm] Error 2
>     make[1]: *** [scripts/Makefile.build:494: arch/riscv] Error 2
>     make: *** [Makefile:2026: .] Error 2
>
> patchwork is saying something similar
> <https://gist.github.com/conor-pwbot/9ed9a564e63d824aed1786050ee06558>.

Yup! Thanks for pointing that out. This series has a bunch of more
issues, that need to be resolved in a v2.


Bj=C3=B6rn
