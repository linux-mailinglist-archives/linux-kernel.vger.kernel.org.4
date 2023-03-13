Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B526B82F6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 21:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjCMUlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 16:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCMUlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 16:41:00 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55B950721;
        Mon, 13 Mar 2023 13:40:07 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id 4so7590975ilz.6;
        Mon, 13 Mar 2023 13:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678740006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZaCV0WUtBPAAadzUTN1+MYnU8j2LSiKAw9rROH/ouw=;
        b=JtofO/o3gg0239JS75f2bHGUOx1O8xSzUbXwHyM7gEMl2D9ouJPoN7pkWICQjgIsfS
         /sU0y2PVmDml/f89PZu0LDpGvuh11lH4itW1jbqx0Lj9YJrCi+ti1j5t5b1J98G9M3et
         4CwuuASQK/mhg/ASaJ19PxRvsyFEmbfhQhAycjYkwKT5SNNkYa81U+cQo10onwGGadMr
         ejs4VvRTPoax5lWdECcehOP1UpCWUCuUnK0k4ShB5wMYQbzA1rKoyzAVwAP2tr82V2FA
         Foi0LwqnkGmOu1Be+shGE56Q2AB9GineC2g0BBDdQ1QUzEGXjMfbGnWZkPG44FNHirNY
         V7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678740006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZaCV0WUtBPAAadzUTN1+MYnU8j2LSiKAw9rROH/ouw=;
        b=U4R5WJBgWTDJ3ZdBXIbVP2LTUoWxULRX0rOlgp2G9+NOGgdeZQNbGiN+WgAJRc3HCq
         7xrYevYRhHlk6PV4M5zdfIbKxgfOlIeLQZwANp+2gxHiR6cunPugLTw7GdrklNRpnP/r
         WKAj58buWnz9ijJyUUy1eSmWtkFjF5iGV7JDUiEMc2lTG2XP7iEVAg5OqFHDK24u0Vj9
         dGYyi+wTpVT1pLqqeJSRtDvPcielKJj15Ra1SV/CJb6PJweggUksvo6jBtfMoHa+IB1U
         aJ3hgswDtRXWRCOQMHX0GZPH9UqEEdPdusn9IX8F9Q5T8dzfclbcfn7Yea2R+VOV/mMR
         ilsw==
X-Gm-Message-State: AO0yUKX/9JELG+2mpJWmzv3KTNKjzMFz15v47lJEX6TBT6KhmqU7e6RX
        a8se75kz3eXFNlad5roEESygYUHDfXYvvLc7iOe4ZTz7meg=
X-Google-Smtp-Source: AK7set93On5UXiWXqIE/iSH6Lyki5HnTxQbbXShr7riWwECrynof73TKCea678jmafu1j1FjmhSIG1K0NtbHbO4dy5k=
X-Received: by 2002:a05:6e02:790:b0:322:fdba:24c1 with SMTP id
 q16-20020a056e02079000b00322fdba24c1mr504636ils.1.1678740006525; Mon, 13 Mar
 2023 13:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230220212245.153554-1-gpiccoli@igalia.com> <ba225af5-3729-32a4-318a-c1c4b8e8b37a@igalia.com>
In-Reply-To: <ba225af5-3729-32a4-318a-c1c4b8e8b37a@igalia.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Mon, 13 Mar 2023 16:39:55 -0400
Message-ID: <CAEdQ38HS=V9QJsdSoccos02HGn4=QKobkci=BTP9tc3=RyzUFQ@mail.gmail.com>
Subject: Re: [PATCH v4] alpha: Clean-up the panic notifier code
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-alpha@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 4:18=E2=80=AFPM Guilherme G. Piccoli
<gpiccoli@igalia.com> wrote:
>
> On 20/02/2023 18:22, Guilherme G. Piccoli wrote:
> > The alpha panic notifier has some code issues, not following
> > the conventions of other notifiers. Also, it might halt the
> > machine but still it is set to run as early as possible, which
> > doesn't seem to be a good idea.
> >
> > So, let's clean the code and set the notifier to run as the
> > latest, following the same approach other architectures are
> > doing - also, remove the unnecessary include of a header already
> > included indirectly.
> >
> > Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> > Cc: Matt Turner <mattst88@gmail.com>
> > Cc: Richard Henderson <richard.henderson@linaro.org>
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> >
> > ---
> >
> >
> > V4:
> > - Rebased (and build-tested) against v6.2.
> >
> > V3:
> > - No changes.
> >
> > V2:
> > - Fixed rth email address;
> > - Added Petr's review tag - thanks!
> >
>
> Hi folks, just a gentle ping.
> Lemme know if there's anything I could do in order to get this move forwa=
rd.
>
> Thanks in advance,
>
>
> Guilherme

My apologies. I meant to include this in my last pull request.

I'll take it through my tree.

Thanks,
Matt
