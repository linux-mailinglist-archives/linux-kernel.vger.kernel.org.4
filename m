Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F9569171A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 04:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjBJDVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 22:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjBJDVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 22:21:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B885FD3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 19:21:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE61861C5D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 03:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18AF3C433D2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 03:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675999307;
        bh=kx8K+qjPI3fEVB2cKDazV2+EJu5JDYSk+vcOqEGi0Rs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ag35YqlGysUM5iTBMV6QTNoMHxEFux+SLd6UBMYXzCSb8MRG0q23yfGkWcpidgJvq
         jQCPne6Mp19nnrT9NY7n35SBFKzP+us0Kmvw2xFi5YUn8enyLCHUoCBr1gJ2kcEnTd
         TxrFUzDCeD54EPiV7JAmxjBnY+Gwqhav8lwbD4xAaLelgjInRNrBPaB4MdPAfqREho
         a08S7qxisZfMSB0YLSyEgkluiLs3O0KK8Ytub08UaDnZ9Bd9DKbOLkUdTLYi5gfYEN
         e3Qmt0aOBjMZMEkAFFhWAvOhma+ZtqunEA9HdQ+qclb8r7PGB3UwKmfs8k/c+iVpyo
         MZkUN54GQiQqA==
Received: by mail-ej1-f51.google.com with SMTP id ud5so12488102ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 19:21:47 -0800 (PST)
X-Gm-Message-State: AO0yUKXOMA+R/e06vAWREwmKCK79OZbF2u9hGJjiHleiV500zcc+gK/h
        pL36yE3Fb9fsC91qQ6Fpncay5H32ixlmpD7L9G4=
X-Google-Smtp-Source: AK7set+PihFfDOFPBtCCTlYAxuDSf7LfkVmUWMZ3DTl2A8TkRWZ/5QbP1ECkuEi/45gSUPh2Oh2JlEMS7iXI9DHGPM8=
X-Received: by 2002:a17:907:2e02:b0:8af:4969:6c5f with SMTP id
 ig2-20020a1709072e0200b008af49696c5fmr273909ejc.150.1675999305288; Thu, 09
 Feb 2023 19:21:45 -0800 (PST)
MIME-Version: 1.0
References: <20230209035839.2610277-1-maobibo@loongson.cn> <e6bb59c32134477aa4890047ae5ad51b@AcuMS.aculab.com>
 <741b2246-d609-ccc6-bf55-d6b0b5e54b54@loongson.cn> <2aa6243491784e74960182dc12968170@AcuMS.aculab.com>
In-Reply-To: <2aa6243491784e74960182dc12968170@AcuMS.aculab.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 10 Feb 2023 11:21:33 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7BgBASt_CpSQgS6MNbzxODhoq8ykK5ZAn2y3ZOekXM9g@mail.gmail.com>
Message-ID: <CAAhV-H7BgBASt_CpSQgS6MNbzxODhoq8ykK5ZAn2y3ZOekXM9g@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: add checksum optimization for 64-bit system
To:     David Laight <David.Laight@aculab.com>
Cc:     maobibo <maobibo@loongson.cn>, WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit comes from the old internal kernel, I want to know which
one has better performance.

https://github.com/loongson/linux/commit/92a6df48ccb73dd2c3dc1799add08adf0e=
0b0deb

On Thu, Feb 9, 2023 at 8:39 PM David Laight <David.Laight@aculab.com> wrote=
:
>
> From: maobibo
> > Sent: 09 February 2023 11:55
> >
> >
> > =E5=9C=A8 2023/2/9 17:35, David Laight =E5=86=99=E9=81=93:
> > > From: Bibo Mao
> > >> Sent: 09 February 2023 03:59
> > >>
> > >> loongArch platform is 64-bit system, which supports 8 bytes memory
> > >> accessing, generic checksum function uses 4 byte memory access.
> > >> This patch adds 8-bytes memory access optimization for checksum
> > >> function on loongArch. And the code comes from arm64 system.
> > >
> > > How fast do these functions actually run (in bytes/clock)?
> > With uint128 method, there will unrolled loop, instruction
> > can execute in parallel. It gets the best result on loongarch
> > system where there is no neither carry flag nor post-index
> > addressing modes.
>
> We're probably almost agreeing...
>
> > Here is the piece of disassemble code with uint128 method:
>
> Load 8 values:
>
> >    120000a40:   28c0222f        ld.d    $r15,$r17,8(0x8)
> >    120000a44:   28c0622a        ld.d    $r10,$r17,24(0x18)
> >    120000a48:   28c0a230        ld.d    $r16,$r17,40(0x28)
> >    120000a4c:   28c0e232        ld.d    $r18,$r17,56(0x38)
> >    120000a50:   28c0022e        ld.d    $r14,$r17,0
> >    120000a54:   28c0422d        ld.d    $r13,$r17,16(0x10)
> >    120000a58:   28c0822b        ld.d    $r11,$r17,32(0x20)
> >    120000a5c:   28c0c22c        ld.d    $r12,$r17,48(0x30)
>
> Pairwise add them
>
> >    120000a60:   0010b9f7        add.d   $r23,$r15,$r14
> >    120000a64:   0010b54d        add.d   $r13,$r10,$r13
> >    120000a68:   0010b24c        add.d   $r12,$r18,$r12
> >    120000a6c:   0010ae0b        add.d   $r11,$r16,$r11
>
> Generate 4 'carry' bits
>
> >    120000a70:   0012c992        sltu    $r18,$r12,$r18
> >    120000a74:   0012beee        sltu    $r14,$r23,$r15
> >    120000a78:   0012c170        sltu    $r16,$r11,$r16
> >    120000a7c:   0012a9aa        sltu    $r10,$r13,$r10
>
> Add the carry bits onto the sums.
> I've not quite worked out which add is which!
> But I think you've missed a few adds here.
>
> >    120000a80:   0010ae0f        add.d   $r15,$r16,$r11
> >    120000a84:   0010ddce        add.d   $r14,$r14,$r23
> >    120000a88:   0010b250        add.d   $r16,$r18,$r12
> >    120000a8c:   0010b54d        add.d   $r13,$r10,$r13
> >    120000a90:   0010b5d2        add.d   $r18,$r14,$r13
> >    120000a94:   0010c1f0        add.d   $r16,$r15,$r16
>
> Somewhere each value needs an add, an sltu to generate the 'carry',
> and an add for the carry itself.
> If you sum the carry bits into a separate register it is
> possible to get a both adds and the sltu (for different values)
> to run in the same clock (on a suitable cpu).
> If there are 4 integer units you can also get the loop instructions
> 'for free' and unrolling 8 times may not be needed at all.
>
> ...
> > There is no post-index addressing modes on loongarch,
> >       val =3D *mem;  // 64bit read
> >         mem++;
> >       sum +=3D val;
> >       carry =3D sum < val;
> >       carry_sum +=3D carry;
> > it takes 5 instruction and these 5 instructions depends on previous ins=
tr.
>
> I'd assume the loop was unrolled enough so the address
> increment doesn't matter.
>
> > There is the piece of disassemble code:
> >    120000d90:   28c001f0        ld.d    $r16,$r15,0
> >    120000d94:   0010c58c        add.d   $r12,$r12,$r17
> >    120000d98:   02c021ef        addi.d  $r15,$r15,8(0x8)
>
> Those three instructions are independent.
>
> >    120000d9c:   0010b20c        add.d   $r12,$r16,$r12
>
> that one depends on the ld.d
>
> >    120000da0:   0012c191        sltu    $r17,$r12,$r16
>
> that depends on the add.d
> but it could be execute after the 'bne' in parallel with the ld.d
>
> >    120000da4:   5fffedf2        bne     $r15,$r18,-20(0x3ffec) # 120000=
d90 <do_csum_64+0x90>
>
> If you tweak the code it is possible to get down to just
> the addi.d and bne constraining the dependency chain.
> (Assuming there is no delay on the read and there are an infinite
> number of execution units.)
> Unroll once and do:
>         ld.d r,addr,0
>         addi.d addr,16
>         ld.d r,addr,-8
>         bne addr,limit,loop_top
> and you might get a loop that does a memory read every clock.
>
> So you end up worrying about how the memory read delays affect
> the instruction pipeline.
> The Intel x86 cpu I've got just pile up the arithmetic instructions
> waiting for the data to be read.
> If you get a memory read requested every clock everything else
> follows - provided you don't try to execute too many instrcutions
> at once.
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)
