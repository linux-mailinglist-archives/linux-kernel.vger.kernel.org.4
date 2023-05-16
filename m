Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B66F705969
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 23:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjEPVYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 17:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjEPVYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 17:24:23 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFF52693
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 14:24:21 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6439df6c268so9660881b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 14:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684272260; x=1686864260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2t/JV41B23wn51WmTbAsDHcdxitNO9yCyn6PuCNMWvw=;
        b=JA4gjOyNnkOp6N9yhir+XZgrlFNqLN73f73FcIJHA1+X8QEZAJiMpbN7VZktdvWTrP
         dWm+zNi2W7pCpBqRcmyCZh4bploVzN5SUQLhukNNLsvxbzGGGgpOwGeWnc27KpOwM5pP
         x3jVQBLHuosKERY91H3OWqqw8+Bo5I5pXaqTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684272260; x=1686864260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2t/JV41B23wn51WmTbAsDHcdxitNO9yCyn6PuCNMWvw=;
        b=jQ+4EAsphmMagmqRZ0Ndme6Y9pwJYX9wju4WneXfuJNyHIQye9zzyrOMGIxVut5SLU
         BqsFQfRO8K3AtYFWzOQIvRYmPXJdTDd0nPIC7XdBiB4QKjmNGJitwoBP72wjwS94jURO
         91TiGtAr7NBjjfy652P92yfED9hbfn8NpOC07Mia8kl6GoLD72/ANN3EjFjIIPsoHfOt
         ytCM4IlfAemyv5kshEFApp/8J1j8vjYn++XeNgDlPrTYGLMPLNyNsY2WqHX09pCSss5V
         Y9i4CYz4caobQxwYOsROR34jYgvxJKUdqdTc6PJNd2B/qJ0te4ScPBqp91syWxm3wYW9
         pn4Q==
X-Gm-Message-State: AC+VfDzvvlfUyNb8+2kn8d8r72BO9OmJhkObxIHotpDslZA16x1H+Igt
        hVQgYnvlsZEauRVzIVHnHwp/hP/pF9cr5p95xUw=
X-Google-Smtp-Source: ACHHUZ5N7+JzoLslg82KahZDNUss7Zg+K5TpRtXDWO72DRmMMsrc7EohFWF6NZElsnlEvLA2Gd/grQ==
X-Received: by 2002:a05:6a00:a28:b0:63f:1eb3:824b with SMTP id p40-20020a056a000a2800b0063f1eb3824bmr54851505pfh.17.1684272259897;
        Tue, 16 May 2023 14:24:19 -0700 (PDT)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com. [209.85.214.176])
        by smtp.gmail.com with ESMTPSA id c25-20020a62e819000000b0063f172b1c47sm7591410pfi.35.2023.05.16.14.24.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 14:24:18 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ac65ab7432so29625ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 14:24:18 -0700 (PDT)
X-Received: by 2002:a17:902:e74a:b0:1ac:3605:97dc with SMTP id
 p10-20020a170902e74a00b001ac360597dcmr88838plf.6.1684272257936; Tue, 16 May
 2023 14:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230324063357.1.Ifdf3625a3c5c9467bd87bfcdf726c884ad220a35@changeid>
 <CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com>
 <552345c5-b1e9-41f6-f275-b6eeeb51df25@linaro.org> <CAMi1Hd05z8uBotO4vs7Ropmt7W2gSA__tTu_=X1t0mze7bXrhg@mail.gmail.com>
 <CAD=FV=VSFDe445WEVTHXxU1WS_HGUV5jR5E8_Vgd4eyhn3rHyA@mail.gmail.com> <CAMi1Hd28FJUjB8A-9YF7xpKOzSyNWXX3qung4aDjpLBhOvw_eA@mail.gmail.com>
In-Reply-To: <CAMi1Hd28FJUjB8A-9YF7xpKOzSyNWXX3qung4aDjpLBhOvw_eA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 16 May 2023 14:24:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W13L0H88G1gt8qRnXfpV-_7E9QfHufN_a23_B1bb=aww@mail.gmail.com>
Message-ID: <CAD=FV=W13L0H88G1gt8qRnXfpV-_7E9QfHufN_a23_B1bb=aww@mail.gmail.com>
Subject: Re: [PATCH] regulator: qcom-rpmh: Revert "regulator: qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS"
To:     Amit Pundir <amit.pundir@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 16, 2023 at 11:12=E2=80=AFAM Amit Pundir <amit.pundir@linaro.or=
g> wrote:
>
> On Mon, 15 May 2023 at 20:33, Doug Anderson <dianders@chromium.org> wrote=
:
> >
> > Hi,
> >
> > On Mon, May 15, 2023 at 7:42=E2=80=AFAM Amit Pundir <amit.pundir@linaro=
.org> wrote:
> > >
> > > On Sun, 14 May 2023 at 18:11, Caleb Connolly <caleb.connolly@linaro.o=
rg> wrote:
> > > >
> > > >
> > > >
> > > > On 13/05/2023 18:08, Amit Pundir wrote:
> > > > > On Fri, 24 Mar 2023 at 19:05, Douglas Anderson <dianders@chromium=
.org> wrote:
> > > > >>
> > > > >> This reverts commit 58973046c1bf ("regulator: qcom-rpmh: Use
> > > > >> PROBE_FORCE_SYNCHRONOUS"). Further digging into the problems tha=
t
> > > > >> prompted the us to switch to synchronous probe showed that the r=
oot
> > > > >> cause was a missing "rootwait" in the kernel command line
> > > > >> arguments. Let's reinstate asynchronous probe.
> > > > >
> > > > > Hi, the asynchronous probe is broken on Dragonboard 845c (SDM845)
> > > > > running AOSP (Android Open Source Project) with v6.4-rc1
> > > > > https://bugs.linaro.org/show_bug.cgi?id=3D5975.
> > > > > Can we please go back to synchronous probe.
> > > > >
> > > > > AOSP do not make use of rootwait, IIRC, but it is added by the
> > > > > bootloader anyway. And the device fails to boot AOSP regardless o=
f
> > > > > "rootwait" bootarg being present or not.
> > > >
> > > > Could you try applying this diff to enable some log spam and let me=
 know
> > > > what you get? I'm keen to try and figure this one out. My mail clie=
nt
> > > > might crunch this a bit so I have pasted it here too
> > > > https://p.calebs.dev/ab74b7@raw
> > >
> > > These prints add just enough delay for the UFS probe to succeed that =
I
> > > can't reproduce the failure anymore.
> >
> > I'd prefer doing at least a little debugging before jumping to a
> > revert. From looking at your dmesg [1], it looks as if the async probe
> > is allowing RPMH to probe at the same time as "qcom-vadc-common".
> > That's something that talks on the SPMI bus and is (potentially)
> > talking to the same PMICs that RPMH-regulator is, right? I'm by no
> > means an expert on how Qualcomm's PMICs work, but it seems plausible
> > that the "qcom-vadc-common" is somehow causing problems and screwing
> > up RPMH. Does that seem plausible to you?
> >
> > If so, one interesting way to track it down would be to move around
> > delays. Put ~500ms sleep at the _end_ of vadc_probe(). Presumably that
> > _won't_ fix the problem. Now put a ~500ms sleep at the beginning of
> > vadc_probe(). Maybe that will fix the problem? If so, you can move the
> > delay around to narrow down the conflict. My wild guess would be that
> > vadc_reset() could be throwing things for a loop?
> >
> > If the above doesn't work, maybe we could add more tracing / printouts
> > to see what is probing at the same time as RPMH?
>
> Tried out a few changes today but none of them worked or were
> effective enough to debug this crash further, other than setting
> fw_devlink=3Dpermissive.
>
> Adding more tracing / prints (BOOTTIME_TRACING and
> FUNCTION_GRAPH_TRACER) didn't work and didn't help in reproducing the
> crash either. They added just enough delay to boot the device
> successfully everytime.
>
> I tried to reason with the kernel modules which gets loaded before and
> after the qcom-rpmh-regulator (QCOM_REBOOT_MODE, QCOM_PON, IIO/VADC,
> SPMI_PMIC* etc) as suggested, but I run into the same crash even if I
> disable those driver modules. So I don't think that the other driver
> modules which gets loaded at around the same time as
> qcom-rpmh-regulator by default have any impact on this failure.

Ugh, Heisenbugs are no fun to debug. :( It sorta sounds as if pretty
much anything you can do to change the timing fixes you. That does
make reverting the async probe of the regulator less appealing. If, as
you said, it's not just some other driver loading at the same time
that's interfering then the revert "fixes" you in the same way that a
"msleep" would fix you. That doesn't seem like enough of a
justification for the revert to me.

It still feels to me like _something_ is happening at the same time as
the RPMH regulator driver is loading, though, I'm just not sure how to
suggest debugging it. I guess other thoughts:

* When RPMH complains, is it always with the same regulator (lvs1), or
sometimes different ones? Any clue there?

* How much can you control module loading order? If rpmh-regulator
module loads first, does it "fix" things? If it does, maybe you could
bisect to find the place where problems start cropping up. Does that
give any clues?


> The only way I can boot successfully everytime is if I boot with
> fw_devlink=3Dpermissive bootarg. So I'll have to check if there is any
> new dependency which got added recently in DT or somewhere else that
> is causing this breakage.

I guess I'll assume that `fw_devlink=3Dpermissive` only fixes you
because it changes the timing...
