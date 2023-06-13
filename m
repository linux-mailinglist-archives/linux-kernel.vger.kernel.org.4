Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8067772EA5A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239702AbjFMR5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239374AbjFMR5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:57:47 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2425A19A8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 10:57:45 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f620583bc2so7236967e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 10:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686679062; x=1689271062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucwpoQAK13prSY87pdp529JG6f/Yd6pwjydVL0f7ZAE=;
        b=GqVMVo6Hp3TdQ/tAVhnguvaW4XPQ8Z6x0MBjZl0T1E+O0LfjSyFdhMC5JUTEXsfnLi
         6nvtSlZWpNbTKLQlAk2EQVMqUlx3IBDIf6CDdg1JX3cXDZc6McL81zw8ZDPTo/8UySjw
         6kkcsWmkElBmEofyxqawn17ksyrYU4ZHxp6WI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686679062; x=1689271062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucwpoQAK13prSY87pdp529JG6f/Yd6pwjydVL0f7ZAE=;
        b=UYmbj8p2muSOdb96vpGwr5fzYefE/g7J6ydxmXDzgv71VPz7uR/I7e4ZrTJVqOFcKw
         NHjJ4uG8z3nSRKrPcZyqyslFki6c7xk+lpZ16ymT3oR3iRbGLVlB6L7irkB3LEVVglzv
         efKgDc9a2Um7Kr214vczpyjv4bFhhRLoPumM2aq+dmzAqAcZ3aS3um4aXseHZBDetgYy
         vXMCYCKaWUG9QLkQ/XI3u3XJ20+/Fla9zaYtiBSyUVln9P2NiGFYh1Mx6hfCZFtZpowS
         HoOjfypwSkDG9R4YaH+gdX+4fQw32OWBi8ePxdufT60JSERmpw4JvYBaap4892NuByTT
         NfOw==
X-Gm-Message-State: AC+VfDwxOdSa+Tc+Qpb9xBiXF0baViIew4nCEFzIT2qf8y55iJ2H7TND
        ZHE8BTVH7tONS9D7XZtjuY8joExfd9EgPWvxHOdIIbOL
X-Google-Smtp-Source: ACHHUZ4HxX0+IF2HqGBZ5H2xv8/fW5c/KiYXaZ60+U53Fm45AOGoGfB+s2tnDf9EGerQ23vj8We7qQ==
X-Received: by 2002:a05:6512:46a:b0:4f3:a99f:1ea1 with SMTP id x10-20020a056512046a00b004f3a99f1ea1mr7612623lfd.45.1686679061967;
        Tue, 13 Jun 2023 10:57:41 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id m10-20020aa7c2ca000000b005184165f1fasm2712480edp.5.2023.06.13.10.57.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 10:57:40 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-514ad92d1e3so1228a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 10:57:39 -0700 (PDT)
X-Received: by 2002:a50:ab0b:0:b0:514:95d4:c2bb with SMTP id
 s11-20020a50ab0b000000b0051495d4c2bbmr2429edc.2.1686679059461; Tue, 13 Jun
 2023 10:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <1685729609-26871-1-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=Uy=ELwg2jhtFSrpndw-GxUO=0NTKotNymi3sqwG=ggnQ@mail.gmail.com>
 <af4c131a-b97d-a8e8-957d-77c31d3c816a@quicinc.com> <02dabcc8-2340-2188-f6a8-51513b147e7c@quicinc.com>
In-Reply-To: <02dabcc8-2340-2188-f6a8-51513b147e7c@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 13 Jun 2023 10:57:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WwcpyvMem08rOXrBMUWW_7ADgfGZGEnEFDky+96pSdpQ@mail.gmail.com>
Message-ID: <CAD=FV=WwcpyvMem08rOXrBMUWW_7ADgfGZGEnEFDky+96pSdpQ@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: geni-se: Do not bother about enable/disable of
 interrupts in secondary sequencer for non-uart modes
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msavaliy@quicinc.com, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 13, 2023 at 9:07=E2=80=AFAM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> Hi,
>
>
> On 6/12/2023 7:09 PM, Vijaya Krishna Nivarthi wrote:
> > Hi,
> >
> > Thank you very much for the review...
> >
> >
> > On 6/7/2023 9:41 PM, Doug Anderson wrote:
> >> Hi,
> >>
> >> On Fri, Jun 2, 2023 at 11:13=E2=80=AFAM Vijaya Krishna Nivarthi
> >> <quic_vnivarth@quicinc.com> wrote:
> >>> The select_fifo/dma_mode() functions in geni driver enable/disable
> >>> interrupts (secondary included) conditionally for non-uart modes, whi=
le
> >>> uart is supposed to manage this internally.
> >>> However, only uart uses secondary IRQs while spi, i2c do not care abo=
ut
> >>> these at all making their enablement (or disablement) totally
> >>> unnecessary
> >>> for these protos.
> >>>
> >>> Drop enabling/disabling secondary IRQs for non-uart modes.
> >>> This doesn't solve any observed problem but only gets rid of code
> >>> pieces
> >>> that are not required.
> >>>
> >>> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> >>> ---
> >>>   drivers/soc/qcom/qcom-geni-se.c | 24 ++++--------------------
> >>>   1 file changed, 4 insertions(+), 20 deletions(-)
> >> This seems like a nice cleanup to me. It's still odd that the general
> >> code has a special case for UART, but I guess the alternative is to
> >> duplicate the exact same logic for both the i2c and SPI drivers. I
> >> won't insist on that, though I wouldn't be opposed to it either.
> >>
> >> I guess one comment, though: should we also remove the code that
> >> messes with "SE_GENI_S_IRQ_EN" in geni_se_select_gpi_mode()?
> >
> >
> > Right now we have gpi-dma mode support for i2c and spi but not for uart=
.
> >
> > Even when gpi-dma support is added, uart driver's interrupt handler
> > would not be invoked so I believe it would be safe to drop that code
> > from geni_se_select_gpi_mode() too.
> >
> > I will post v2 dropping same after some more lookup.
>
>
> Looking at this once again, I am more inclined towards leaving alone
> gpi_mode() for now.
>
> It probably needs cleanup but we want to take that up at a later time.
>
> Meanwhile its not causing much harm as we don't switch modes dynamically
> for gpi case, so we are not losing much time there reading from and
> writing to registers.
>
> Please let know your thoughts.

It's not really about the time needed for the extra register writes,
but just someone trying to understand the code who might be trying to
figure out what bits are relevant. The bits related to the secondary
sequencer's interrupts don't do anything useful when we're using the
controller for i2c/spi, so why not delete them?

-Doug
