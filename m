Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172026007C7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiJQHhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiJQHhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:37:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929A35A3DE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:37:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D32E1B80F52
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734B6C433D7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665992249;
        bh=+5A1av+6MnMOMcMrSEXVxrOm6Gs3Za7niSjGLgaRaoA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aTKhrFZRJllPH5LJZnPbhwVrb3NyyPV16YWHpco4uplbVb77Q9b9SmBLy60I8AqqK
         f23O7tGvxDEbgxqlB1bi3Wa4y4nYDonf0git3ImYxxf7Y2Tbj+SKcf0ht70dlu9zcU
         8G+7hVyPV41SQIhM6jfv6Er3PnY3yWLky7TMyhC8kRUnicow4486zgyn0VKZzdgClu
         XOP+FDw2gHpRnqj/yhraIfcOz3b7zmUsBeaIlivlxfo/VECXZw+yAzJQOtyuZNoO1W
         o8rQV8W3lNN4LauJqlV03TXM6MEEZMCNvDhKGDxOr2NzD8SKINKdIr3Y+yEmf7s8j1
         a9zgPdjx+mFzA==
Received: by mail-ed1-f51.google.com with SMTP id m16so14784936edc.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:37:29 -0700 (PDT)
X-Gm-Message-State: ACrzQf0G01//r6XZNTgaGli7cE/w0O6mqaj35FWQPRnlivVtMeN+8stZ
        Ls8BhRREnv0m3rD+kYNoN3yl92bTcvQvBu7tEDg=
X-Google-Smtp-Source: AMsMyM4f4vwixo4JyVz7ksqp1i8sB0ECUqnrO8JC8nLqKPuUwCS+N5Ao4ZAhXJh/30TDBqiHpEZl8nUhVbn7kjxV/8A=
X-Received: by 2002:aa7:d4d9:0:b0:45c:7eae:d8d8 with SMTP id
 t25-20020aa7d4d9000000b0045c7eaed8d8mr9113622edr.254.1665992247623; Mon, 17
 Oct 2022 00:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221017022330.2383060-1-chenhuacai@loongson.cn> <67d9acd0-692f-95d4-2c92-4e43e1d0100c@loongson.cn>
In-Reply-To: <67d9acd0-692f-95d4-2c92-4e43e1d0100c@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 17 Oct 2022 15:37:15 +0800
X-Gmail-Original-Message-ID: <CAAhV-H54TeCwuUu+pGyGUDgy3_k1eCA1hX56-ZrTuk2_WRiFxQ@mail.gmail.com>
Message-ID: <CAAhV-H54TeCwuUu+pGyGUDgy3_k1eCA1hX56-ZrTuk2_WRiFxQ@mail.gmail.com>
Subject: Re: [PATCH V2] LoongArch: Add unaligned access support
To:     Jinyang He <hejinyang@loongson.cn>
Cc:     Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jinyang,

On Mon, Oct 17, 2022 at 12:22 PM Jinyang He <hejinyang@loongson.cn> wrote:
>
> Hi, Huacai,
>
>
> On 2022/10/17 =E4=B8=8A=E5=8D=8810:23, Huacai Chen wrote:
> > [...]
> > +     default:
> > +             panic("unexpected fd '%d'", fd);
> Due to the optimization of gcc, the panic() is unused actually and leave
> the symbol 'read/write_fpr' in vmlinux. Maybe we can use unreachable() an=
d
>
> always_inline.
Seems impossible, I have tried __always_inline() and BUILD_BUG(), then
BUILD_BUG() is triggered, because the reg-number is not a compile time
constant.

>
> > [...]
> > +
> > +fault:
> > +     /* roll back jump/branch */
> > +     regs->csr_era =3D origpc;
> > +     regs->regs[1] =3D origra;
>
> I'm not sure where the csr_era and regs[1] was damaged...
Yes, seems not be damaged.

>
> > [...]
> >
> > +/*
> > + * unsigned long unaligned_read(void *addr, void *value, unsigned long=
 n, bool sign)
> > + *
> > + * a0: addr
> > + * a1: value
> > + * a2: n
> > + * a3: sign
> > + */
> > +SYM_FUNC_START(unaligned_read)
> > +     beqz    a2, 5f
> > +
> > +     li.w    t1, 8
> IMHO we can avoid the constant reg t1.
OK, thanks.

> > +     li.w    t2, 0
> > +
> > +     addi.d  t0, a2, -1
> > +     mul.d   t1, t0, t1
> > +     add.d   a0, a0, t0
> > +
> > +     beq     a3, zero, 2f
> beqz
OK, thanks.

> > +1:   ld.b    t3, a0, 0
> > +     b       3f
> > +
> > +2:   ld.bu   t3, a0, 0
> > +3:   sll.d   t3, t3, t1
> > +     or      t2, t2, t3
> > +     addi.d  t1, t1, -8
> > +     addi.d  a0, a0, -1
> > +     addi.d  a2, a2, -1
> > +     bgt     a2, zero, 2b
> bgtz
> > +4:   st.d    t2, a1, 0
> > +
> > +     move    a0, a2
> > +     jr      ra
> > +
> > +5:   li.w    a0, -EFAULT
> > +     jr      ra
> > +
> > +     fixup_ex 1, 6, 1
> > +     fixup_ex 2, 6, 0
> > +     fixup_ex 4, 6, 0
> > +SYM_FUNC_END(unaligned_read)
> > +
> > +/*
> > + * unsigned long unaligned_write(void *addr, unsigned long value, unsi=
gned long n)
> > + *
> > + * a0: addr
> > + * a1: value
> > + * a2: n
> > + */
> > +SYM_FUNC_START(unaligned_write)
> > +     beqz    a2, 3f
> > +
> > +     li.w    t0, 0
> > +1:   srl.d   t1, a1, t0
> > +2:   st.b    t1, a0, 0
> > +     addi.d  t0, t0, 8
> > +     addi.d  a2, a2, -1
> > +     addi.d  a0, a0, 1
> > +     bgt     a2, zero, 1b
> bgtz
OK, thanks.

> > +
> > +     move    a0, a2
> > +     jr      ra
> > +
> > +3:   li.w    a0, -EFAULT
> > +     jr      ra
> > +
> > +     fixup_ex 2, 4, 1
> > +SYM_FUNC_END(unaligned_write)
>
> Thanks,
>
> Jinyang
>
