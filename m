Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C14C70A9EA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 20:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjETSWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 14:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjETSVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 14:21:51 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2BE10CC;
        Sat, 20 May 2023 11:21:29 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ae87bdc452so10580345ad.2;
        Sat, 20 May 2023 11:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684606887; x=1687198887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFFbB0eljV8B1MeTCIcq4HztEtmKMqwP+0gvj6VcmR4=;
        b=Nnk6Ai/nkBf2hhxnRhVom43y5wyOdJP9gUzN7dZmbhN9Xlh/jd+IJMDrqrQ/mIW6zi
         LNJWi3s0pmf0bHnCIHEE7G6/Y4SgsCdkyiuv14aavxpMVL8QaJ77n6FF6w7/MLicxl+G
         keikEFDOL66YAj9F4r4jow8pidhVd1RUrM7mvAJpriKKcBXYpFllm5urCVAyixUbldL7
         0atWVqYzHBRCkc3un7tnKM2CprEARuTOB7TINNTfNq0ZCl1lMEYQLpJFqKu3qGuDnWdx
         EiwBdeEgWY10w7YgOnbYTtxL+qOcImMpAa4Cb0QlgJ2zvF/KozyhDoT3EDZOGPKYe/vy
         XlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684606887; x=1687198887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFFbB0eljV8B1MeTCIcq4HztEtmKMqwP+0gvj6VcmR4=;
        b=hqVwJcfw8/k1rdmzK6gKtYM56Iv9NUZC+/DsFY+ACLsZ3hhGv4HKFtDnMYESLDVLTQ
         q7bi1jG3WpxZtC6Ffc+4YqFQX7k+AUjJ4OaxG8q7DD0L9sJI7gzPDxEvRvTnhJAD+zIc
         fvt07y6uJjHd9judjNAIj/CKGmAJRemA/TXoCBLkLnucKTTCAGNYhWq9LoRJL7bFjWgD
         k/gVYQjLkbcJ1nXkyxZmX/yK3++RONMHBBXB/oRs2Pdy//oU7jvwFeiVCcMasHLFv2rK
         JM4H5iZRtvrC8Fs11pLcmAimu+b2R3BRUF+O8pDJhycWbmXyinjpccFAPvzm5SF6VD+0
         Fvzw==
X-Gm-Message-State: AC+VfDxWgUNYjf5yOYTdQ4NoV/o6bWcQncgjqA+vIRgyOPjlG5aNz5Ty
        m/MHHl+9b3CyUWU/okw5dQjBs1z/1whpDGqipTY=
X-Google-Smtp-Source: ACHHUZ6Dd97OJfNjLHrXt5eSzL/oUGa+2LLRlD67s5KC5vc1UxPwiMnl+25XJI/CR7wqyE8JSfjOQnTdHTmh69CEGes=
X-Received: by 2002:a17:902:e848:b0:1ad:d500:19d3 with SMTP id
 t8-20020a170902e84800b001add50019d3mr8459565plg.23.1684606886701; Sat, 20 May
 2023 11:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230517223007.178432-1-boerge.struempfel@gmail.com>
 <CAOMZO5CqMMCCOsAB3YgJUUampE=iZru57d=qoX13-GkSaaC5gg@mail.gmail.com>
 <CAEktqcuMrqiwDfGM=SAoHiKPY-hupS+jipt=6Tasr1q8VUvRQQ@mail.gmail.com>
 <CAOMZO5CJwwKmDYRxnny2JOrwucGn=q7+9xKqk_NSvZ_wyNSHEQ@mail.gmail.com>
 <CAEktqcue7gFk9fXMsNPxwUsUVRxpa6GE5wCHZqU2p2dDz8WYqg@mail.gmail.com> <CAHp75VcP78MhmjzOCiGwfEwWwVxCHhy3qmZet0HqjPeLTc9h-A@mail.gmail.com>
In-Reply-To: <CAHp75VcP78MhmjzOCiGwfEwWwVxCHhy3qmZet0HqjPeLTc9h-A@mail.gmail.com>
From:   =?UTF-8?B?QsO2cmdlIFN0csO8bXBmZWw=?= <boerge.struempfel@gmail.com>
Date:   Sat, 20 May 2023 20:21:15 +0200
Message-ID: <CAEktqctboF3=ykVNtPsifcmHzF6dWwoEcVh+O4H1u-R=TT6gHg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] spi: add SPI_MOSI_IDLE_LOW mode bit
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Fabio Estevam <festevam@gmail.com>, bstruempfel@ultratronik.de,
        amit.kumar-mahapatra@amd.com, broonie@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for you response

Am Do., 18. Mai 2023 um 12:58 Uhr schrieb Andy Shevchenko
<andy.shevchenko@gmail.com>:
>
> On Thu, May 18, 2023 at 3:27=E2=80=AFAM B=C3=B6rge Str=C3=BCmpfel
> <boerge.struempfel@gmail.com> wrote:
> > Am Do., 18. Mai 2023 um 01:53 Uhr schrieb Fabio Estevam <festevam@gmail=
.com>:
>
> ...
>
>
> > Okay. I have begun to implement this. During this, I noticed, that if
> > I called the new option
> > "--mosi-idle-low", the alignment of the help-lines (and in the c code
> > itself) would break.
> > Should I therefore shorten the option name by using an abbreviation
> > like "--mil", which is
> > probably not very helpful as a "full option name", or should I touch
> > all the other lines and
> > insert necessary spaces, such that they are aligned once more? (And if
> > so, should I do
> > this in a seperate patch, preparing the addition of the new options?)
>
> It's a user space tool where not so strict rules of commit splitting
> apply (as far as I know), I would go with indention fixes in the same
> patch that adds the option.
>

That's good to know. I will do that.

> ...
>
> > > > While looking through the code, I noticed, that the latest two
> > > > additions to the spi->mode
> > > > (SPI_3WIRE_HIZ and SPI_RX_CPHA_FLIP) are also missing from this too=
l. Is this
> > > > by design, or should they then be included as well?
> > >
> > > Looks like these two are missing and would be good to get them includ=
ed as well.
> >
> > Okay. Should this be a separate patch, or should I add the support for
> > all 3 mode bits in
> > one commit?
>
> Split them logically. Are they from the same group of bits? No? then spli=
t.
>
Yes they are actually from the same group of bits. Therefore I'll add
them all in the same patch.
> --
> With Best Regards,
> Andy Shevchenko
