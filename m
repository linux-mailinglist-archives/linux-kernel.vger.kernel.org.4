Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FE56338EB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbiKVJrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbiKVJqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:46:53 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91F412619
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:46:52 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id p21so13107786plr.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fb2a2qPkiNyV79EPxFgoQUH1bBZRJ4pPl8l2Hu7egWs=;
        b=qkbeDWaMEih+xSYda34uaUzUrXMbtjUx6DZiDrTlV3PKpZtjBHk3b7xM2iVwoRB4a+
         IrBsAc0gcc2G/JprUzBk1toHVkr5LQLp5qHmRn6wGF4LCqIhV/qMZL6UQ7yOFinI/VnS
         R/vVv3UK5jVy7/jZ2DZEtKTPGDbupucmn5N/6dI4mgAX9DtHKZNSfl7OT/15R5XkkQqu
         /vbEk9P4Zf0h2Ac3E/UDTlFpKjOdiirCZfIViNQTaRq6YAoLtHv4D5hcvhwxnrU43JbK
         nuPXwh+/fWsGu7R9/9M8smCG5JZqVk/E7dECDpzFvEr0De6usViiCOvv/idyUCMvxmzM
         O3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fb2a2qPkiNyV79EPxFgoQUH1bBZRJ4pPl8l2Hu7egWs=;
        b=oocwSeeIAFggT5YMi0Vn1vEkkB/yA6uveGceD0oKn23Ie0AHNbtwp1Cleqm4kaaINS
         FvT2RKPbnzsmj8mU4cLKQHoS8h0JBwJFpfBSo8ejYGm7W0a5dscrMPRhcmOQ9Cx4Z0Gj
         WHiZFg39r3sfY29Gza8oyPQcV0/KJPPECK1zH5pQEnpfEl3+Dmc0S0B4Zr7ZRo+V1yps
         9yVu78XZ5KKMjqIyNe3QgoVfcH3/FG0mIVi+BRKzPHLuHJ8rgT13yYixkUB2JwAtH/CY
         6nnNflJ94yUB2vKSATjHSfo7BDy/5RCxTxwd4PFVyVzz2DIvim6uhEInNGS/eXImSZkv
         61bw==
X-Gm-Message-State: ANoB5pnSvUk3HRK8mbwpsgl9NgWVHm/X7HvzRRMbVkqv5HEAbXKaeJN+
        b8BrrAWgAQ4pn3N4KwZd9YSVZRJTa/zktfheALlDbCZOlOw=
X-Google-Smtp-Source: AA0mqf7IOUg8BcWStSC1num5dHrWSE+I+Al0NduEjlhEQtr6fNKF9LF2IPsvZnwLi5cQQHMQjf+Ua0MktKrb0TlETIY=
X-Received: by 2002:a17:902:ca04:b0:17f:7f7e:70c7 with SMTP id
 w4-20020a170902ca0400b0017f7f7e70c7mr5070065pld.107.1669110411632; Tue, 22
 Nov 2022 01:46:51 -0800 (PST)
MIME-Version: 1.0
References: <20221122075440.1165172-1-suagrfillet@gmail.com> <Y3yO+ii+NEVPTYFo@wendy>
In-Reply-To: <Y3yO+ii+NEVPTYFo@wendy>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Tue, 22 Nov 2022 09:46:40 +0000
Message-ID: <CAAYs2=h7jQMAHyixusGneXSvHACaS+7YDxNE5pCfJotjHpOkxA@mail.gmail.com>
Subject: Re: [PATCH] riscv/ftrace: fix ftrace_modify_call bug
To:     Conor Dooley <conor.dooley@microchip.com>, guoren@kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conor Dooley <conor.dooley@microchip.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=88=
22=E6=97=A5=E5=91=A8=E4=BA=8C 08:57=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Nov 22, 2022 at 03:54:40PM +0800, Song Shuai wrote:
> > With this commit (riscv: ftrace: Reduce the detour code size to half)
>
> AFAICT the above patch has not been applied & this patch here should be
> folded into the offending patch?
> I've marked this one as "Not Applicable" in patchwork as a result, but
> let me know if that is an incorrect assumption.
>
> Thanks,
> Conor.
>
Hi, Conor:

Sorry to disturb you with this patch without against the merged commit list=
,

This patch actually is created for fixing (riscv: ftrace: Reduce the
detour code size to half)
which has not been merged yet.

As Guo replied, he will fold it in the target patch. You can ignore
this one. Sorry again.

BTW, for dispelling your confusion about my email name.
Actually, it was misspelled when registering, but I keep it for daily use.
So you can send it without concern. :P

-- Song


Sorry for bothering you with the
> > patched, ftrace bug occurred When hosting kprobe and function tracer
> > at the same function.
> >
> > Obviously, the variable caller in ftrace_modify_call was assigned by
> > rec->ip with 4 offset failing the code replacing at function entry.
> > And the caller should be assigned by rec->ip directly to indicate
> > the function entry.
> >
> > The following is the ftrace bug log.
> >
> > ```
> > [  419.632855] 00000000f8776803: expected (ffe00297 1a4282e7) but got (=
1a8282e7 f0227179)
> > [  419.633390] ------------[ ftrace bug ]------------
> > [  419.633553] ftrace failed to modify
> > [  419.633569] [<ffffffff802091cc>] kernel_read+0x0/0x52
> > [  419.633863]  actual:   97:02:e0:ff:e7:82:82:1a
> > [  419.634087] Updating ftrace call site to call a different ftrace fun=
ction
> > [  419.634279] ftrace record flags: e0000002
> > [  419.634487]  (2) R
> > [  419.634487]  expected tramp: ffffffff800093cc
> > [  419.634935] ------------[ cut here ]------------
> > ```
> >
> > Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> > ---
> >  arch/riscv/kernel/ftrace.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> > index 8c77f236fc71..61b24d767e2e 100644
> > --- a/arch/riscv/kernel/ftrace.c
> > +++ b/arch/riscv/kernel/ftrace.c
> > @@ -132,7 +132,7 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsi=
gned long old_addr,
> >                      unsigned long addr)
> >  {
> >       unsigned int call[2];
> > -     unsigned long caller =3D rec->ip + 4;
> > +     unsigned long caller =3D rec->ip;
> >       int ret;
> >
> >       make_call_t0(caller, old_addr, call);
> > --
> > 2.20.1
> >
