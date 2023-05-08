Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEB76FBB81
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 01:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbjEHXsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 19:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjEHXsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 19:48:09 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EAD72B7
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 16:48:08 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-965fc25f009so639794566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 16:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683589687; x=1686181687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8t+saJAbUSVL4ue1y2IEMbLMFyq3GQP269CpYlGUPA=;
        b=Wh57UW3RuUlEG2otI7UPvSHXwsD/JsyyHfRXmSij9Vz3Et3LPe4Ey6y6I0DxpkJpZa
         WEANGIHJf4f9mbYbaRITBmj3Mtb5Q84iquTdm4BMeRnOSfSIqTr95/DeWeQCtVBuOdMq
         adlGL6QzsmcbRaDNYlqlEZJILjJUF4IJLOTBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683589687; x=1686181687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8t+saJAbUSVL4ue1y2IEMbLMFyq3GQP269CpYlGUPA=;
        b=ik2pYjT/2mI+/w6BzDz01HqH9pf+KJ9FFr05RsCfGYbONcZuLf/PcsZ4gTz/dLX5tw
         e/E7aKs3oW/KyvoMy3Glb7omAMsmA4U1yqIbDXI0Ot370QmkiH0vhKuAdgb6WHQNOIJW
         BCxeb2nMFsFvoOWqB59AAaAMJjr5NKMp7R4S1n1plO4l4lb+bfGUDU6yzMulgWnFOfD6
         lda9awIaIuYV/+TkcnI07AGgjJGJg0xA0cJmo6fCkQmSrag/xaFPVzzk7gnCXAPgTAZS
         E8VPGJHNvZI4GhxEJ4jlkGHxNPm6T1TFglLGZmeqdk959RWyfvKAW0Mt3XmRFD27Ug3w
         71+g==
X-Gm-Message-State: AC+VfDw4pn+3T8x0ZIvzWjtOchZAs+OccH5Dw0Q59oilX47xn7eiEeej
        Iieo22+lyO1XXbsZKTReADhwOpH+IoVaHEouEeOFqw==
X-Google-Smtp-Source: ACHHUZ58A+Smm+h5KS37lyPipB5mS1/JI3MdnKxzL+tzuf2WecHaIGo6d+kwAuQDOktVLLUBlPm8Vw==
X-Received: by 2002:a17:907:8692:b0:967:142b:ff07 with SMTP id qa18-20020a170907869200b00967142bff07mr4280428ejc.21.1683589686960;
        Mon, 08 May 2023 16:48:06 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id e9-20020a170906648900b0094f3d700868sm576183ejm.80.2023.05.08.16.48.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 16:48:05 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-50bc075d6b2so9875316a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 16:48:05 -0700 (PDT)
X-Received: by 2002:a17:907:9482:b0:968:4d51:800b with SMTP id
 dm2-20020a170907948200b009684d51800bmr3242793ejc.1.1683589685292; Mon, 08 May
 2023 16:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230424212130.590684-1-dave.hansen@linux.intel.com>
 <CAHk-=whn3F1k263SZNUVQK195tcCMAo5E_WbmjUE0qFC5rWg=w@mail.gmail.com>
 <4433c3595db23f7c779b69b222958151b69ddd70.camel@intel.com>
 <148b3edb-b056-11a0-1684-6273a4a2d39a@intel.com> <CAHk-=wiuVXTfgapmjYQvrEDzn3naF2oYnHuky+feEJSj_G_yFQ@mail.gmail.com>
 <CAHk-=wiB0wy6oXOsPtYU4DSbqJAY8z5iNBKdjdOp2LP23khUoA@mail.gmail.com>
 <4171c4b0-e24b-a7e2-9928-030cc14f1d8d@intel.com> <CAHk-=wiVLvz3RdZiSjLNGKKgR3s-=2goRPnNWg6cbrcwMVvndQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiVLvz3RdZiSjLNGKKgR3s-=2goRPnNWg6cbrcwMVvndQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 8 May 2023 16:47:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg4vpYz+xRtd+PsdmQ9gtNGbXrFKW3ndvXcrLEEDN0hyw@mail.gmail.com>
Message-ID: <CAHk-=wg4vpYz+xRtd+PsdmQ9gtNGbXrFKW3ndvXcrLEEDN0hyw@mail.gmail.com>
Subject: Re: [GIT PULL] x86/shstk for 6.4
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 8, 2023 at 4:31=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Yeah, right now the non-shadow-stack ptep_set_wrprotect() can just be
> an atomic clear_bit(), which turns into just
>
>         lock andb $-3, (%reg)
>
> and I guess that would inevitably become a horror of a cmpxchg loop
> when you need to move the dirty bit to the SW dirty on CPU's where the
> dirty bit can come in late.
>
> How very very horrid.

Oh, maybe not.

So the nice thing here is that we actually *do* have the old value
(although we don't pass it in to ptep_set_wrprotect(), so while the

        lock andb $-3,(%reg)

looks simple and efficient, I do think that it wouldn't necessarily be
any worse to replace it with a

        lock cmpxchg %new,%old,(%reg)

and a well-predicted branch for the (very very unlikely) failure case.

So maybe unifying these two areas wouldn't be too bad.

In fact, looking at this code a bit more made me realize that we
probably should always have special-cased the common "is the source MM
single-threaded" case.

Pretty much nobody does "fork()" from a threaded app, because it's not
portable anyway.

So:

 - the nasty racy case is already exceedingly rare, and we're wasting
huge amounts of time on using a locked access here when in 99% of all
cases we shouldn't do that at all!

 - we would probably be *much* better off with a "if (mm->count =3D=3D 1)"
test that goes off and does *not* do the atomic case (which also
doesn't have any worries about dirty bits). I'll take a well-predicted
conditional branch over an atomic op any day of the week

 - once you do that, the nasty racy case isn't even in the critical
path any more, so it might as well do the unconditional "cmpxchg" loop
that works on all CPU's.

And yes, old CPU's may still set the dirty bit *later*, but we can
indeed make the rule be that the *kernel* never sets that "read-only
and dirty" combination, and then on new CPU's the HW guarantees it
doesn't set it either.

How does that sound? I think we'd potentially speed up fork() quite
noticeably by not doing the locked accesses.

Maybe I just think I'm clever, but I'm actually very stupid and am not
thinking of some obvious problem case.

For example, maybe the mm count doesn't end up being 1 commonly after
all, because we're sharing it with the idle thread or something like
that.

Or maybe there's something even more obviously wrong with the above idea.

                  Linus
