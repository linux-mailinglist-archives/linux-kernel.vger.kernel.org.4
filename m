Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883406C80B4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjCXPGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjCXPGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:06:35 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1455A12CC8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:06:31 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5418d54d77bso37535207b3.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679670388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pO9JO1Nl3vWVaBBZbGNy96ElA1aYviPDI6HLdepDIuA=;
        b=Sdr1nZK4AmDw66Jdr6BgRFNzOYYahTtPW1new4Fjey+FIqkxE2y5N5oy0ZLnd+fYsX
         wVB1BDCHD93TFQBsQdAExKCsn/91GVJ7Astm7SK/ysY0r+KX/6ZjxCo2YnAdvbxcZxvj
         Om3Bby0CSDarLB1G30I/b6LUqzEIJItkt8IyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679670388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pO9JO1Nl3vWVaBBZbGNy96ElA1aYviPDI6HLdepDIuA=;
        b=4AbD95HYY7CsxdBgF/+Iwq5cFO5VlB+srjhCUEdA2jf+kSrOzjEjVhuue9/qSUqs7Z
         gde1j9ENNWUifl67IlSGYEBl3aTStmyERZ0DNoEpnvl0pscAxv7reJjLR8j6N1cdA8N/
         t7QvztEnkqUL9pN8yEbCL/k4cL4fLcW20gSREXBvnEHjiyY/Qst4c1pIp9q4tzZTsp/9
         qSjT5T4tr7mhOA/QodqD80+dDySpvEbh0aTE/1SLLQH0G5MX1jFX/P0kTOZWQEy6f1Ml
         /wdyrvMc1R7uQPGvFlrE2NZNgai2bs5GEC0yt+tc+Qz0Cy38+eUTAoztiDorQY8ebDw3
         jQ9g==
X-Gm-Message-State: AAQBX9eeR3JQibfMEtqn6shSzGVV/eFOsOq3+Hm53TZdzSKi2FUrJRWa
        0tX2gAcvCGqs2yfGWK6Lqfk+CRKyKx0ID+MCf6o=
X-Google-Smtp-Source: AKy350bgW93sDYbpgChmJ31g1XuOyNIKCb8vGPTIc4rh4rUIkFPRhKqbKTeH++4hOrcrIAjInAW7Xg==
X-Received: by 2002:a81:1692:0:b0:52e:d421:2414 with SMTP id 140-20020a811692000000b0052ed4212414mr6581956yww.25.1679670388513;
        Fri, 24 Mar 2023 08:06:28 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id da12-20020a05690c0d8c00b00545a08184efsm456024ywb.127.2023.03.24.08.06.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 08:06:27 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id p15so2506576ybl.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:06:27 -0700 (PDT)
X-Received: by 2002:a05:6902:1881:b0:b69:83b2:5124 with SMTP id
 cj1-20020a056902188100b00b6983b25124mr1212852ybb.0.1679670387329; Fri, 24 Mar
 2023 08:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230323083330eucas1p1f7e3f9beb5ba168c6b13374d74c158f0@eucas1p1.samsung.com>
 <20230323083312.199189-1-m.szyprowski@samsung.com> <20230323114035.GL68926@ediswmail.ad.cirrus.com>
 <CAD=FV=UYO1KaoAZ7o5cA83SC1VHRomvJfaXVWyYPKrEZHyNNjg@mail.gmail.com>
 <20230323174531.GM68926@ediswmail.ad.cirrus.com> <CAD=FV=X0SAEk_iUGQ=J-PWk_MzVc7ZikBM3N8rrnhGFzcdBNpw@mail.gmail.com>
 <20230324092353.GO68926@ediswmail.ad.cirrus.com>
In-Reply-To: <20230324092353.GO68926@ediswmail.ad.cirrus.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Mar 2023 08:06:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WUCqhq-wCoiir-1sNQpTNJfr-c2vAYvyJc6hKi8U4u_w@mail.gmail.com>
Message-ID: <CAD=FV=WUCqhq-wCoiir-1sNQpTNJfr-c2vAYvyJc6hKi8U4u_w@mail.gmail.com>
Subject: Re: [PATCH] regulator: wm8994: Use PROBE_FORCE_SYNCHRONOUS
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 24, 2023 at 2:23=E2=80=AFAM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> On Thu, Mar 23, 2023 at 11:00:32AM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, Mar 23, 2023 at 10:45=E2=80=AFAM Charles Keepax
> > <ckeepax@opensource.cirrus.com> wrote:
> > >
> > > I think really the best place to look at this would be at the
> > > regulator level. It is fine if mfd_add_devices passes, the problem
> > > really is that the regulator core doesn't realise the regulator is
> > > going to be arriving, and thus returns a dummy regulator, rather
> > > than returning EPROBE_DEFER. If it did the MFD driver would probe
> > > defer at the point of requesting the regulator, which would all
> > > make sense.
> >
> > I think something like your suggestion could be made to work for the
> > "microphone" supply in the arizona MFD, but not for the others looked
> > at here.
> >
> > The problem is that if the MFD driver gets -EPROBE_DEFER then it will
> > go through its error handling path and call mfd_remove_devices().
> > That'll remove the sub-device providing the regulator. If you try
> > again, you'll just do the same. :-)
> >
> > Specifically in wm8994 after we've populated the regulator sub-devices
> > then we turn them on and start talking to the device.
> >
> > I think the two options I have could both work for wm8994's case:
> > either add some type of "my children have done probing" to MFD and
> > move the turning on of regulators / talking to devices there, or add
> > another stub-device and add it there. ;-)
>
> Is this true if we keep the regulator as sync though? Yes it will
> remove the children but when it re-adds them the reason that the
> regulator probe deferred in the first place will hopefully be
> removed. So it will now fully probe in path.

Ah, I see. So you keep it as synchronous _and_ make it so that it
won't get a dummy. Yeah, I was trying to brainstorm ways we could fix
it if we kept the regulator async. If we keep it as sync and fix the
dummy problem then, indeed, it should work as you say.

I've spent a whole lot of time dealing with similar issues, though,
and I think there is actually another related concern with that design
(where the regulator is synchronous). ;-) If the child device ends up
depending on a resource that _never_ shows up then you can get into an
infinite probe deferral loop at bootup. If it works the way it did
last time I analyzed similar code:

1. Your MFD starts to probe and kicks off probing of its children
(including the regulator).

2. Your regulator tries to probe and tries to get a resource that will
never exist, maybe because of a bug in dts or maybe because it won't
show up until userspace loads a module. It returns -EPROBE_DEFER.

3. The MFD realizes that the regulator didn't come up and it also
returns -EPROBE_DEFER after removing all its children.

4. That fact that we added/removed devices in the above means that the
kernel thinks it should retry probes of previously deferred devices
because, maybe, the device showed up that everyone was waiting for.
Thus, we go back to step #1.

...the system can actually loop forever in steps #1 - #4 and we ended
up in that situation several times during development with similar
architected systems.


-Doug
