Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A6A70CA18
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbjEVTzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbjEVTzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:55:47 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551B599
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:55:42 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3f475746ae0so35046861cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684785341; x=1687377341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rberg4bwUy07oOUWgD6JRy5t/SGEkLBqBr8AY1Hm/Hc=;
        b=MumOKtVbvpYF1URRoME2u4hs0ePmWNGRKdF+QL2FppqL4wIKBlUcban31t6elfsMgl
         I+WU+t3+ytTSHYQrK9IaeB5DU6axO+euarW8HA4CD0k6oztaOFFWymdJ2fSfsb6atvne
         mNhaKnbk4g38Fb9HEFT8fmJuz1hGFPzn2xjY48Ls1+3/qhTdfUsel+j0LEQEaqSJRZxT
         YQP+N1h77ATSyxlNztyABc7TeNhpvfBKES452+ccTGhjFHHIuKsF+kPi1SoyFTGYwxbJ
         FNhfhzOBqeM5a+U0jIEmHpYjoVZ81boF1oHo3RCgAouaBM1QlB/K1IvQPk6+ZIJEX65X
         DCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684785341; x=1687377341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rberg4bwUy07oOUWgD6JRy5t/SGEkLBqBr8AY1Hm/Hc=;
        b=CtshOgWKYmto8qIQjd+XRJKuA7uiHNW18L1tcgW8FEIC5W0xk81IIbDAjdnGUZaJBl
         g29Ae9yKWr525gTDDT/N+81ieH36eI/6lZ4ON25WRQkYquskGSltw8lCOJ3tzyZSN7ID
         ZfVaLk+oPe56Q9tNVtCIRth7FY2eTJXu5ncvTcBIYgE3Thm4dkou40vnDPggw4nhUhZo
         6Hlxpn8enbQQO89TdbGh99aazsMYmwuzdwnUKUFMfIbEAKwECGqZmLFBIMm2HYwelKil
         Wss1AwmuOzuSsQIDAkMv9UV1MSrp3Aex07rLSr4aALFW2MQmVVWwEijdyIJTAhos3hjc
         57lA==
X-Gm-Message-State: AC+VfDxxAJgRwR+bHp1UURQKfok8eyu5ObGxOOADywXFu7guI4DE1H7+
        cFEtoRV+UpkCBeX63hFZ5j+C+lfl/pcZg5eBzxmufg==
X-Google-Smtp-Source: ACHHUZ7yl3BpjhOWiGRIS/IB9MYPFWRYgFp7KBYS80lpTZrk+qUlmN4Cx8Y2/Q3JYL5nEEPZ/nnEvCXWUqUopr9Zah0=
X-Received: by 2002:a05:622a:1213:b0:3f2:a58:7a7a with SMTP id
 y19-20020a05622a121300b003f20a587a7amr19555223qtx.58.1684785341122; Mon, 22
 May 2023 12:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230516-sunxi-v1-1-ac4b9651a8c1@google.com> <f099e6e0-d1c6-9d72-0d16-2712286be67d@gmail.com>
In-Reply-To: <f099e6e0-d1c6-9d72-0d16-2712286be67d@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 May 2023 12:55:30 -0700
Message-ID: <CAKwvOdngn_v3oW4iTFZ1rBKOtWNUAk_-qc+u3V+UhM5wmwzSdg@mail.gmail.com>
Subject: Re: [PATCH] ARM: sunxi: fix return code check of of_property_match_string
To:     "William (Zhenghao) Zhang" <william.zhang@broadcom.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 11:34=E2=80=AFAM Florian Fainelli <f.fainelli@gmail=
.com> wrote:
>
> +William,
>
> On 5/16/23 09:35, ndesaulniers@google.com wrote:
> > of_property_match_string returns an int; either an index from 0 or
> > greater if successful or negative on failure.
> >
> > Fixes the following splat observed with UBSAN:
> > [    0.166489][    T1] UBSAN: array-index-out-of-bounds in arch/arm/mac=
h-sunxi/mc_smp.c:810:29
> > [    0.166934][    T1] index 2 is out of range for type 'sunxi_mc_smp_d=
ata [2]'
> > [    0.167206][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        =
W          6.4.0-rc2 #1
> > [    0.167515][    T1] Hardware name: Generic DT based system
> > [    0.167727][    T1]  unwind_backtrace from show_stack+0x18/0x1c
> > [    0.167979][    T1]  show_stack from dump_stack_lvl+0x68/0x90
> > [    0.168226][    T1]  dump_stack_lvl from ubsan_epilogue+0x8/0x34
> > [    0.168474][    T1]  ubsan_epilogue from __ubsan_handle_out_of_bound=
s+0x78/0x80
> > [    0.168760][    T1]  __ubsan_handle_out_of_bounds from sunxi_mc_smp_=
init+0xe8/0x574
> > [    0.169100][    T1]  sunxi_mc_smp_init from do_one_initcall+0x178/0x=
9c8
> > [    0.169364][    T1]  do_one_initcall from kernel_init_freeable+0x1dc=
/0x28c
> > [    0.169661][    T1]  kernel_init_freeable from kernel_init+0x20/0x16=
4
> > [    0.169912][    T1]  kernel_init from ret_from_fork+0x14/0x2c
> >
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> William had a similar fix submitted back in September of last year, but
> I do not believe it got applied either:
>
> https://lore.kernel.org/r/20220929012944.454613-1-william.zhang@broadcom.=
com
>
> lore was not able to find it, but above is the message ID, and attached
> is his original patch.

Hi William,
How would you like to proceed here? I don't want to step on any toes
if there's an existing patch.

> --
> Florian



--=20
Thanks,
~Nick Desaulniers
