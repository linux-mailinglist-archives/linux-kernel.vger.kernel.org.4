Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1296862D2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjBAJaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjBAJaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:30:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD475B597
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 01:30:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1923561723
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 09:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F39FC433EF;
        Wed,  1 Feb 2023 09:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675243817;
        bh=MImzud+6lRzhX2tGkp7uKBM1B58TKv2hfv2OdwtwPDQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=S3mpfu431i4iAMsICWrvOX+66Gfb7JR6cGSmf2FbkUpQPH3hHzrwgrp1DSmEzWtwu
         3WNz9hI/fdn2hnWDf8mX4MHbDqC/8SuIYFnxE6dop7HWzhPwIlNnpqzbFkDrSXstEE
         1wswwAWG/lxElpfZ90hM+Uz2+qOWXRYor6fJFCB+6VYtmt+3s6h4/nW1NIGGKqwRyy
         syClpFLPBfX+QatEJsqoRwA2H1mvhXm0ZrALHwpK4i7XJGMDDRkuB/Xb4IPozaxFZu
         7dwAjmVkHtPwjZqsRf4R0glhSJAr99WRYCuH6y4XMnf8X6Nj4adFtRBuZ6mtEdVtEb
         23C/ZYOkJ20VA==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com, mhiramat@kernel.org,
        conor.dooley@microchip.com, penberg@kernel.org,
        mark.rutland@arm.com, liaochang <liaochang1@huawei.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] riscv: kprobe: Fixup kernel panic when probing an
 illegal position
In-Reply-To: <CAJF2gTQHDmT=XWE=j8+5Y5ogKh4qNMpXCwAa+7wXEkBit0ujXw@mail.gmail.com>
References: <20230126130509.1418251-1-guoren@kernel.org>
 <878rhig9zj.fsf@all.your.base.are.belong.to.us>
 <CAJF2gTQHDmT=XWE=j8+5Y5ogKh4qNMpXCwAa+7wXEkBit0ujXw@mail.gmail.com>
Date:   Wed, 01 Feb 2023 10:30:14 +0100
Message-ID: <87357pravt.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guo Ren <guoren@kernel.org> writes:

>> > +     if (!arch_check_kprobe(p))
>> > +             return -EILSEQ;
>> > +
>> >       /* copy instruction */
>> >       p->opcode =3D *p->addr;
>>
>> Not related to your patch, but this can also trigger a misaligned load.
> After rereading the spec, misaligned load/store is not mandatory
> supported. (Although my machines and qemu are correct)

Yes. It would be great if it could be turned on by QEMU (you can with
Spike).

> So I need fixup:
>
> diff --git a/arch/riscv/kernel/probes/kprobes.c
> b/arch/riscv/kernel/probes/kprobes.c
> index 27f8960c321c..0c016d496746 100644
> --- a/arch/riscv/kernel/probes/kprobes.c
> +++ b/arch/riscv/kernel/probes/kprobes.c
> @@ -58,12 +58,14 @@ static bool __kprobes arch_check_kprobe(struct kprobe=
 *p)
>  {
>         unsigned long tmp  =3D (unsigned long)p->addr - p->offset;
>         unsigned long addr =3D (unsigned long)p->addr;
> +       kprobe_opcode_t opcode;
>
>         while (tmp <=3D addr) {
>                 if (tmp =3D=3D addr)
>                         return true;
>
> -               tmp +=3D GET_INSN_LENGTH(*(kprobe_opcode_t *)tmp);
> +               memcpy(&opcode, (void *)tmp, sizeof(kprobe_opcode_t));
> +               tmp +=3D GET_INSN_LENGTH(opcode);

I'd prefer sizeof(opcode).

>         }
>
>         return false;
> @@ -80,7 +82,7 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>                 return -EILSEQ;
>
>         /* copy instruction */
> -       p->opcode =3D *p->addr;
> +       memcpy(&p->opcode, p->addr, sizeof(kprobe_opcode_t));

Same comment as above, and this would ideally be a separate patch.


Bj=C3=B6rn
