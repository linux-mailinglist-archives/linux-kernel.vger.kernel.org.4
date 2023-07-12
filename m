Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058EC75078E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjGLMHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbjGLMHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:07:32 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE2C1FD8;
        Wed, 12 Jul 2023 05:07:22 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-78372625badso307750639f.3;
        Wed, 12 Jul 2023 05:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689163641; x=1691755641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=js9A+LroJpKyjly1c+m3wIj1/hOhy81EZTbGk7lLc9w=;
        b=QJDFf6a2qcjPXjiPm97eZlxkt0nwP+Cy792/OnHUSjEnI5bVgRJOZlFiDEhc9oPi6V
         8Ukf3UAhhORVbhHiJLowqUCvznS3tlqmqp+oI2JYlf1FRg/EVkPBXdub7EjPGyE8LFcQ
         vJY4YUMoSH/dFomzmMcsTFyx0k/FBuivXQWCR9tm6o33eGWo8GmiSO8lRHiZDWPKVnc1
         34Kl8LzDooi5FS626w9o36EXvlrHFUt4EOMEg3wWkSxeC7szYcDl6zD0/II0YC5WkiLP
         eLrjT4FAVw7NGfD33CKrdeg86PxkCNS24anRmf7ctv8V9cgolZXJlFBrEDyeLw+TMIBz
         Al9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689163641; x=1691755641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=js9A+LroJpKyjly1c+m3wIj1/hOhy81EZTbGk7lLc9w=;
        b=D5+kt8vnrSibkZrgsUEwWRNPs+5KNPjftDgWWqEIRMi/l0HREd3SxmjNwJgtYRCDKv
         3J42NIcCa8C3ON3oqH2XF2OcMFVJPg/qWgt3e39DE1yhToK3AyuWVFiIPr5SUMP4IKs4
         /uHdEPr28LR7cDUGwvGMsJ9Lm89L3vlxURKGnnZCZUf8vMoQ55m4Zbo6JCvNGIpE1n6G
         e4rVjs3JLY+LomLF9a+7KoFk0znW3w8rdVWNLMojHfYRXU1OuSA5eYt8fBHDiynhoEAR
         6FJGYt1jfKHckn1DKjjlGel6ZN2c3kpMELIUQD063SipnjqOs7phhtm9meAziHWxKW74
         ZfCw==
X-Gm-Message-State: ABy/qLaOw0Mi/aRgggHCs5ovZ3ci++OdKgziDYvqw6NqnWyzDyJ94vCC
        GMAJIj26wXmYHrwmCEq+Xrjui8FspLXegWDhHbQ=
X-Google-Smtp-Source: APBJJlETKzUMF2OAd9kTWv7lkEdSNYU4Mqa9EYSDW3Wz3B8ikNrnIT5lFXObmJx47ZNPP7nh7b1m66J9NjVwYTQm1Zg=
X-Received: by 2002:a5d:8848:0:b0:783:606b:740f with SMTP id
 t8-20020a5d8848000000b00783606b740fmr18734048ios.15.1689163641507; Wed, 12
 Jul 2023 05:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230607151127.1542024-1-pavacic.p@gmail.com> <20230607151127.1542024-4-pavacic.p@gmail.com>
 <CACRpkdbrEA54qmfTKSsFRG9ZS4u8hM6P5TXtOjRAiW+TD_v-fQ@mail.gmail.com>
 <CAO9szn00vRFm+iM1m7KgkW0WRuKyJEgVU4tVx4f5tF6KPnE=2w@mail.gmail.com>
 <CACRpkdaw8M3dSkmiV5QDOt3BBB7Jo6NxT0Og=zvA4REMA_7y9g@mail.gmail.com>
 <CAO9szn29A0qCABG0ACni42UGpsGKLwG7OT1y_ho3DgQ0WLvfmw@mail.gmail.com>
 <CACRpkdYXtQwmZR1u-1fwmyC_8Yq4bMkjDBcUCfuGqSz_UhXWJQ@mail.gmail.com>
 <CAO9szn0OuKW+-JZMs3TPUHiwLCe6cUPcsUq+og64K2utMyZpqQ@mail.gmail.com>
 <CACRpkdb5stXKb7FNk_FC-PKduCngRX3sZTbzcxN+kRskz78fuQ@mail.gmail.com>
 <CAO9szn3oTzrrwiyr91H14ep7OPUkA-SDST3CSQAQHvFFnkJWfA@mail.gmail.com>
 <0d43e653-32cd-b25e-40fa-6f0571048467@denx.de> <CAO9szn20RY3uBDceyUJ1S+gb=FN8Hd5qqMfOSbitHFyFCZ+iLg@mail.gmail.com>
 <8b0ae1d1-c769-1f55-0452-4bbc62da133b@denx.de>
In-Reply-To: <8b0ae1d1-c769-1f55-0452-4bbc62da133b@denx.de>
From:   Paulo Pavacic <pavacic.p@gmail.com>
Date:   Wed, 12 Jul 2023 14:07:10 +0200
Message-ID: <CAO9szn1QdB5WGshuyCOGqb0qbBWHqoikeiMkk+bNGhAF5TX5ew@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] drm/panel-fannal-c3004: Add fannal c3004 DSI panel
To:     Marek Vasut <marex@denx.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

sub, 8. srp 2023. u 14:53 Marek Vasut <marex@denx.de> napisao je:
>
> On 7/7/23 17:26, Paulo Pavacic wrote:
> > Hello Marek,
>
> Hi,
>
> > =C4=8Det, 6. srp 2023. u 17:26 Marek Vasut <marex@denx.de> napisao je:
> >>
> >> On 7/6/23 17:18, Paulo Pavacic wrote:
> >>> Hello Linus,
> >>>
> >>> =C4=8Det, 22. lip 2023. u 10:22 Linus Walleij <linus.walleij@linaro.o=
rg> napisao je:
> >>>>
> >>>> On Wed, Jun 21, 2023 at 5:09=E2=80=AFPM Paulo Pavacic <pavacic.p@gma=
il.com> wrote:
> >>>>
> >>>>> A lot of modifications to st7701 are required. I believe it would
> >>>>> result in a driver that doesn't look or work the same. e.g compare
> >>>>> delays between initialization sequences of panel-fannal-c3004 and
> >>>>> panel-st7701. I think it would be optimal to create st7701s driver =
and
> >>>>> have special handling for st7701s panels. If there was a flag for
> >>>>> whether panel is st7701 or st7701s it would end up looking like a
> >>>>> mess.
> >>>>
> >>>> What matters is if the original authors of the old st7701 driver are
> >>>> around and reviewing and testing patches at all. What we need is
> >>>> active maintainers. (Added Jagan, Marek & Maya).
> >>>>
> >>>> I buy the reasoning that the st7701s is perhaps substantially differ=
ent
> >>>> from st7701.
> >>>>
> >>>> If st7701s is very different then I suppose it needs a separate driv=
er,
> >>>> then all we need to to name the driver properly, i.e.
> >>>> panel-sitronix-st7701s.c.
> >>>
> >>> I had in person talk with Paul Kocialkowski and I have concluded that
> >>> this is the best solution.
> >>> I believe I should rename it to st7701s due to the hardware changes. =
I
> >>> would like to create V5 patch with driver renamed to st7701s.
> >>> Please let me know if you agree / disagree.
> >>
> >> If I recall it right, the ST7701 and ST7701S are basically the same
> >> chip, aren't they ?
> >
> > I'm currently exploring all the differences. There aren't a lot of
> > differences, but there are some.
> > So far I can see that default register values are different, new
> > previously unused registers are now used and there has been some
> > reordering of how info is placed in registers [1] (data bits are in
> > different order). Moreover, instructions to some commands have been
> > changed and meaning of what data bits mean [2][3]. Also, new features
> > have been added [2]; there is now PCLKS 3 for example.
> >
> > You can see few differences in following images. Same images were
> > attached in this mail:
> > [1] https://ibb.co/NmgbZmy - GAMACTRL_st7701.png
> > [2] https://ibb.co/G79y235 - PCLKS2.png
>
> Ouch. I wonder if this is still something that can be abstracted out
> with some helper accessor functions like:
>
> if (model =3D=3D ST7701)
>    write something
> else
>    write the other layout
>
> Or whether it makes sense to outright have a separate driver. The later
> would introduce duplication, but maybe that much duplication is OK.

I would like to create new driver because panel-st7701 seems to be
outdated and is using non-standard macro (ST7701_WRITE()) and for me
it is crashing kernel 5.15.
Does anyone have similar issues with it?

Br,
Paulo
