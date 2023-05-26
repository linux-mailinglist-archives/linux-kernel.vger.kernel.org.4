Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B3B712AC0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236326AbjEZQh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjEZQh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:37:26 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979F8D9
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:37:23 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f600a6a890so765e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685119042; x=1687711042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EY8jNRNfAa0Ugc42QcvXpqkmlzbK+JbHaTZLZiADEaE=;
        b=De6LirTmjImnmRKlEqNPvy3JPAo2CR65jhpJD0oGuGW8VgRXuVGyhNZyzKlQlSoak3
         KVyRwC2UjOk5mnVr1vIjSAO1ZlaJp/OfszCysoCsP/OT00FJDh/y+gqaRGBqMhsNJdTs
         mn0GEl71o/Q40nq6QmPpRmLFK3oWrjXTGN3mOpXhot4VTm4K6wNfdlF+3GxdsVZsFhsR
         HsNwwe4vqovoNpqmAEWVAvI3D3jvR6xW4eGXZ0bUpD3yxdjx3frSyMI1r297n+BHEPnc
         bGDaBGx78/R3AOxec3a2nzy+udYTBlMyerU05I7wpp9x3vLuPbYzrnw+ziQ5Xc+8PQ3e
         +nVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685119042; x=1687711042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EY8jNRNfAa0Ugc42QcvXpqkmlzbK+JbHaTZLZiADEaE=;
        b=ZL0iZCLFFwO7OK1kBp/qte5756KjkaImBr6N9DkQSxjRdgUOWwrMyGBqA4jm2V3bwu
         RhSE/LBXLT69D/XYcoVEloUUe7sddSUfdQQUMjOP8G7UJnhmG1Biow5SHM8G09tfsj89
         gPQxezK9kxkyicYRsSpnC3rbxF9ebOV3Hi7BwgZ4V30dBqYJ36stm0XnK9OND3+/rjFM
         MxxUuJzK5kqoq7eQrJg/oeQMoeUAit4hQj/AooQQot0Hpu2YOCq+TIliJYC6iRoeXH3O
         /af2rMSD9thEw+DMLVeIG8d6Z/tKUzwwt5hI6Tc8ATu96BU5JcU3K0Whu4LDc4zWWSUP
         6dbw==
X-Gm-Message-State: AC+VfDxqI9AjUZQGO9EU4bPFk/PwJEG7mDTHWeX3o+VjdYV9S5XEWK+D
        lZUkbbhup4KKn4ZPniWcN8VExHQrXUOtp5Dckq80gQ==
X-Google-Smtp-Source: ACHHUZ6luz3NVVUHHwLHkIApI6hqmLmBGSoFjISIyczkObu857DbTinAwsZjNBeumKUB6CavLiHhASOB1maa4I1JmkE=
X-Received: by 2002:a05:600c:3c93:b0:3f4:2594:118a with SMTP id
 bg19-20020a05600c3c9300b003f42594118amr132218wmb.2.1685119041804; Fri, 26 May
 2023 09:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <CANn89iKUbyrJ=r2+_kK+sb2ZSSHifFZ7QkPLDpAtkJ8v4WUumA@mail.gmail.com>
 <CAHk-=whqNMUPbjCyMjyxfH_5-Xass=DrMkPT5ZTJbFrtU=qDEQ@mail.gmail.com>
In-Reply-To: <CAHk-=whqNMUPbjCyMjyxfH_5-Xass=DrMkPT5ZTJbFrtU=qDEQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 26 May 2023 18:37:09 +0200
Message-ID: <CANn89i+bExb_P6A9ROmwqNgGdO5o8wawVZ5r3MHnz0qfhxvTtA@mail.gmail.com>
Subject: Re: x86 copy performance regression
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
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

On Fri, May 26, 2023 at 6:30=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, May 26, 2023 at 8:00=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > We can see rep_movs_alternative() using more cycles in kernel profiles
> > than the previous variant (copy_user_enhanced_fast_string, which was
> > simply using "rep  movsb"), and we can not reach line rate (as we
> > could before the series)
>
> Hmm. I assume the attached patch ends up fixing the regression?
>
> That hack to generate the two-byte 'jae' instruction even for the
> alternative is admittedly not pretty, but I just couldn't deal with
> the alternative that generated pointlessly bad code.
>
> We could make the constant in the comparison depend on whether it is
> for the unrolled or for the erms case too, I guess, but I think erms
> is probably "good enough" with 64-byte copies.
>
> I was really hoping we could avoid this, but hey, a regression is a regre=
ssion.
>
> Can you verify this patch fixes things for you?


Hmm.. my build environment does not like this yet :)

arch/x86/lib/copy_user_64.S:40:30: error: unexpected token in argument list
0: alternative ".byte 0x73," ".Lunrolled" "-0b-2", ".byte 0x73,"
".Llarge" "-0b-2", X86_FEATURE_ERMS
                             ^
make[3]: *** [scripts/Makefile.build:374: arch/x86/lib/copy_user_64.o] Erro=
r 1
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [scripts/Makefile.build:494: arch/x86/lib] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile:2026: .] Error 2
