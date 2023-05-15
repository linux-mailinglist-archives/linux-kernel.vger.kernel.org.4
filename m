Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6024B7030E2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242122AbjEOPDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242128AbjEOPDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:03:21 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236B72136
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 08:03:04 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7576eb88a46so874101785a.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 08:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684162982; x=1686754982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWRXE+phlaSRjBwP//6vD7S2kedBsIZjdIRbpXoQP68=;
        b=Nvn4R2jHWMziTpxS1IqrsNiwkQ+0w6EUXm4rP0g2U4O351hUnOBD93Bdq4bi4xM31V
         /N9rTHk7S73puejzbZrxUmMIYN5mW84SKBjv3CO6YrORsNo4CMl8Ujkj6ch/ZoEFk4pH
         y20uw+6QHNcPwIU7rBavkvFy9KN9mX8C3Ppno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684162982; x=1686754982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWRXE+phlaSRjBwP//6vD7S2kedBsIZjdIRbpXoQP68=;
        b=agc4TSQfk20RR1dXkmKmYjHYBxVS7e6NdRvuBVRci+xTjYFHgfX1IPVStOa6EmQAKY
         k+La0Xs8n/tY4hgPHCFiUPjIRoBCxDqwtnzHdVOOuEYs5MKAi1xybHJ1mULriGB41iGl
         2NENjzgohMS2Lhvy3lNk2N5NPoNcTgA2EVqh8iYV323yVF9wO/SJCP4OKNDxN26HHDiK
         gcaPPSEGoOP0rzwtn1d/F74Iu1ELEfuuc+1E+fLULEpgbMQc8bhQIEH2OATyptXlM52B
         z5YaXSZzsjI4/iILgsXg5VHoJmNEO/sB0haHz1rCyUdce1OdIDFDz9VNVI2/msClhDnd
         4UMw==
X-Gm-Message-State: AC+VfDziDNfog7/2L72C9D6DZpS5pOwRUMYnICOe/Mu8y0UubbJmt/J2
        YjvIWxfuytifMeNE3Mpn6PYXgs2N1zKrHK66mVs=
X-Google-Smtp-Source: ACHHUZ4vEwfrQJmG2XwwsolKmtoH1r0bWCLaREQsXGkX2pnPg6A9wcg20jEDp2bXrInQU3LwuQ020g==
X-Received: by 2002:ac8:4e4e:0:b0:3f5:2bba:5c2b with SMTP id e14-20020ac84e4e000000b003f52bba5c2bmr5859834qtw.32.1684162982422;
        Mon, 15 May 2023 08:03:02 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id b8-20020ac812c8000000b003f17f39af49sm5400730qtj.18.2023.05.15.08.03.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 08:03:01 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-3f396606ab0so1489641cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 08:03:01 -0700 (PDT)
X-Received: by 2002:a05:622a:1313:b0:3ef:302c:319e with SMTP id
 v19-20020a05622a131300b003ef302c319emr18569qtk.8.1684162980828; Mon, 15 May
 2023 08:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230324063357.1.Ifdf3625a3c5c9467bd87bfcdf726c884ad220a35@changeid>
 <CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com>
 <552345c5-b1e9-41f6-f275-b6eeeb51df25@linaro.org> <CAMi1Hd05z8uBotO4vs7Ropmt7W2gSA__tTu_=X1t0mze7bXrhg@mail.gmail.com>
In-Reply-To: <CAMi1Hd05z8uBotO4vs7Ropmt7W2gSA__tTu_=X1t0mze7bXrhg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 15 May 2023 08:02:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VSFDe445WEVTHXxU1WS_HGUV5jR5E8_Vgd4eyhn3rHyA@mail.gmail.com>
Message-ID: <CAD=FV=VSFDe445WEVTHXxU1WS_HGUV5jR5E8_Vgd4eyhn3rHyA@mail.gmail.com>
Subject: Re: [PATCH] regulator: qcom-rpmh: Revert "regulator: qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS"
To:     Amit Pundir <amit.pundir@linaro.org>
Cc:     Caleb Connolly <caleb.connolly@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 15, 2023 at 7:42=E2=80=AFAM Amit Pundir <amit.pundir@linaro.org=
> wrote:
>
> On Sun, 14 May 2023 at 18:11, Caleb Connolly <caleb.connolly@linaro.org> =
wrote:
> >
> >
> >
> > On 13/05/2023 18:08, Amit Pundir wrote:
> > > On Fri, 24 Mar 2023 at 19:05, Douglas Anderson <dianders@chromium.org=
> wrote:
> > >>
> > >> This reverts commit 58973046c1bf ("regulator: qcom-rpmh: Use
> > >> PROBE_FORCE_SYNCHRONOUS"). Further digging into the problems that
> > >> prompted the us to switch to synchronous probe showed that the root
> > >> cause was a missing "rootwait" in the kernel command line
> > >> arguments. Let's reinstate asynchronous probe.
> > >
> > > Hi, the asynchronous probe is broken on Dragonboard 845c (SDM845)
> > > running AOSP (Android Open Source Project) with v6.4-rc1
> > > https://bugs.linaro.org/show_bug.cgi?id=3D5975.
> > > Can we please go back to synchronous probe.
> > >
> > > AOSP do not make use of rootwait, IIRC, but it is added by the
> > > bootloader anyway. And the device fails to boot AOSP regardless of
> > > "rootwait" bootarg being present or not.
> >
> > Could you try applying this diff to enable some log spam and let me kno=
w
> > what you get? I'm keen to try and figure this one out. My mail client
> > might crunch this a bit so I have pasted it here too
> > https://p.calebs.dev/ab74b7@raw
>
> These prints add just enough delay for the UFS probe to succeed that I
> can't reproduce the failure anymore.

I'd prefer doing at least a little debugging before jumping to a
revert. From looking at your dmesg [1], it looks as if the async probe
is allowing RPMH to probe at the same time as "qcom-vadc-common".
That's something that talks on the SPMI bus and is (potentially)
talking to the same PMICs that RPMH-regulator is, right? I'm by no
means an expert on how Qualcomm's PMICs work, but it seems plausible
that the "qcom-vadc-common" is somehow causing problems and screwing
up RPMH. Does that seem plausible to you?

If so, one interesting way to track it down would be to move around
delays. Put ~500ms sleep at the _end_ of vadc_probe(). Presumably that
_won't_ fix the problem. Now put a ~500ms sleep at the beginning of
vadc_probe(). Maybe that will fix the problem? If so, you can move the
delay around to narrow down the conflict. My wild guess would be that
vadc_reset() could be throwing things for a loop?

If the above doesn't work, maybe we could add more tracing / printouts
to see what is probing at the same time as RPMH?


[1] https://bugs.linaro.org/attachment.cgi?id=3D1135
