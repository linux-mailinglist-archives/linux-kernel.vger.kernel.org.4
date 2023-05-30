Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4FF715A9D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjE3JtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjE3JtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:49:13 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF069C
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 02:49:10 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2af2e908163so45355791fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 02:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1685440149; x=1688032149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akFeIP35hj3g/G+iX6470TrZtzvrlyZ/wSZAMe9T/g0=;
        b=ZkFDkzFUsH5KXBNpXNmt1EMKU1KBzFwY6BpSvt1ArrWqjTb5rdDoNDbTNikXR7huGt
         fQJ6xgJyPw6unI3NCW/2oyq8/4vrcRNTvfVYqmyCskwmZv6pbW9adBOxkb3ibrjO5KFV
         Kli4o68Zk7WRZ1ciGWzoGbq1zIakSAfD3OO3vpkJP23/k064hLH8WUctLUjUn0Juu9SQ
         d0+vDwAQGbKrGSFaeyOMywktq84h6iJ+Rx+usDQi374pKPXwYVLKQQ9gmlGL2hc4o+7H
         Fq/aDxotAYvY8Q+wAKC5qPI8ArZRhSFmzhUpspui7mPSqFty1ftrzV4tHkQmDVp1N/Ty
         4zCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685440149; x=1688032149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=akFeIP35hj3g/G+iX6470TrZtzvrlyZ/wSZAMe9T/g0=;
        b=AeW2qw9XjpBeU7FtGCC0dh2yoGBqJUGJleJZtoRLJ2zELNqGVMvmMuRj5dlGEnMua/
         RQq9SgfRuhwNhszVA0TKqb/vHx4V6gjwX0s6OLYfTmKjZcwRkx7EooJ6yiUKvU8OQsax
         xNBeACmhFgMy5jpSVmXdzJ8liKVNS8kqfMAM7re0+vGL+kEilS/vAunDFRoRsPloechE
         54rKnCbHggKe5xp0DEuH10Vwl4l/eeQ8/XkU6QGTa3WgTzr4t9/e5/Jq89wuEJkoqwn3
         b9qLfnOl0dvJgpJmD4nyX0cL6/DTTNN8jwZuwfWiqUo19DJL7/LDI8kmrqJxvtBGWeKo
         BP+Q==
X-Gm-Message-State: AC+VfDyHJlTeVzDRq/Khajv/eyp6nDVjJLhgJKylvSDnJPD081oBBozk
        47qr5sWR5hA/Sc/2Gf3i3B/whkLC5T+tzzU97Je9Ig==
X-Google-Smtp-Source: ACHHUZ5YWqP22yH/TFgEMZysIl3zCGKuxwVw9dO0MFanWlPnZpSLAEzO0Xhx6Xxury2RcCwUjqyiKc8DzcOxVy2dsaI=
X-Received: by 2002:a2e:a445:0:b0:2a9:ee54:9fad with SMTP id
 v5-20020a2ea445000000b002a9ee549fadmr476463ljn.7.1685440149056; Tue, 30 May
 2023 02:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230529073845.2859178-1-guoren@kernel.org> <20230529-jasmine-amigo-6d01f6852b35@wendy>
 <CAJF2gTRSoZbexqka=_7nf4+dHZW2FGf++BiTMypfTbeoGAbUiA@mail.gmail.com> <CAJF2gTTzUfp7xDr8myA+xMcxGNEQ+XLEYMfoR91NShdBAQMu7Q@mail.gmail.com>
In-Reply-To: <CAJF2gTTzUfp7xDr8myA+xMcxGNEQ+XLEYMfoR91NShdBAQMu7Q@mail.gmail.com>
From:   Andy Chiu <andy.chiu@sifive.com>
Date:   Tue, 30 May 2023 17:48:58 +0800
Message-ID: <CABgGipXu7iq-J5v6GVMPrnHiGVLuMxabB0_hPb+o+04T2MAwpw@mail.gmail.com>
Subject: Re: [PATCH] riscv: vector: Fixup modules compile error
To:     Guo Ren <guoren@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>, greentime.hu@sifive.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmer@rivosinc.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 2:52=E2=80=AFPM Guo Ren <guoren@kernel.org> wrote:
>
> On Tue, May 30, 2023 at 10:59=E2=80=AFAM Guo Ren <guoren@kernel.org> wrot=
e:
> >
> > On Mon, May 29, 2023 at 9:43=E2=80=AFPM Conor Dooley <conor.dooley@micr=
ochip.com> wrote:
> > >
> > > On Mon, May 29, 2023 at 03:38:45AM -0400, guoren@kernel.org wrote:
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > >
> > > > Some .ko also need the riscv_v_user_allowed symbol.
> > > >
> > > > ERROR: modpost: "riscv_v_user_allowed" [arch/riscv/kvm/kvm.ko]
> > > > undefined!
> > > > make[3]: ***
> > > > [/home/guoren/source/kernel/linux/scripts/Makefile.modpost:136:
> > > > Module.symvers] Error 1
> > > >
> > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > ---
> > > >  arch/riscv/kernel/vector.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.=
c
> > > > index 1c4ac821e008..3ae08816d608 100644
> > > > --- a/arch/riscv/kernel/vector.c
> > > > +++ b/arch/riscv/kernel/vector.c
> > > > @@ -129,6 +129,7 @@ bool riscv_v_user_allowed(void)
> > > >  {
> > > >       return riscv_v_get_cur_ctrl(current) =3D=3D PR_RISCV_V_VSTATE=
_CTRL_ON;
> > > >  }
> > > > +EXPORT_SYMBOL(riscv_v_user_allowed);
> > >
> > > Is there a reason that this should not be EXPORT_SYMBOL_GPL()?
> > Good question, but I just follow our arch/riscv habbit, maybe we
> > should change all of that in another patch.
> >
> > =E2=9E=9C  linux-s64ilp32 git:(s64ilp32) =E2=9C=97 grep EXPORT_SYMBOL  =
arch/riscv -r | wc -l
> > 66
> > =E2=9E=9C  linux-s64ilp32 git:(s64ilp32) =E2=9C=97 grep EXPORT_SYMBOL_G=
PL  arch/riscv -r | wc -l
> > 15
>
> Why !MODULE_LICENSE(GPL) modules couldn't use riscv_v_user_allowed?
> Seems EXPORT_SYMBOL_GPL has more limitations.
>
> :c:func:`EXPORT_SYMBOL_GPL()`
> -----------------------------
>
> Defined in ``include/linux/export.h``
>
> Similar to :c:func:`EXPORT_SYMBOL()` except that the symbols
> exported by :c:func:`EXPORT_SYMBOL_GPL()` can only be seen by
> modules with a :c:func:`MODULE_LICENSE()` that specifies a GPL
> compatible license. It implies that the function is considered an
> internal implementation issue, and not really an interface. Some
> maintainers and developers may however require EXPORT_SYMBOL_GPL()
> when adding any new APIs or functionality.
>
> For kvm is okay:
>
> MODULE_AUTHOR("Qumranet");
> MODULE_LICENSE("GPL");
>
> So, I would leave the decition to Andy. If he didn't want it used with
> other non-gpl modules, choose the EXPORT_SYMBOL_GPL.

Do you have any use case for exporting this function to non-GPL
licensed modules? I exported the function with EXPORT_SYMBOL_GPL() in
v20[1] because I thought most maintainers would accept GPL rather than
non-GPL one. And it seems most drivers would never call this function
anyway.

>
> >
> > >
> > > I figure Andy will roll this into this next revision.

The fix for this has been included in v20[1]. However, I also changed
the function name
s/riscv_v_user_allowed/riscv_v_vstate_ctrl_user_allowed/.

> > >
> > > Cheers,
> > > Conor.
> >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
>
>
>
> --
> Best Regards
>  Guo Ren

[1]: https://lore.kernel.org/all/20230518161949.11203-21-andy.chiu@sifive.c=
om/

Cheers,
Andy
