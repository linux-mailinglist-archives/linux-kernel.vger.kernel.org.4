Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230E96B81DC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 20:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjCMTtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 15:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjCMTtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 15:49:53 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAB16EB80
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 12:49:52 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id nv15so8950932qvb.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 12:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678736990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBRdAUT5zAcd3v4xkZPTM5Pd+gMdA3kGoenKyKmJgXE=;
        b=F96NZ3yz4YYpIq6fhYvlbme3tMwwE3X/z0nBIvK7w2zCmehO3jXkGiqAH+woZV6A9Y
         Mfi9Bg2xufB1iX4/TQAMsbmqmR+ZO5UWyubEt3Xcf/3d5CW6Cq6BXwDcihYQCp8XY1mF
         y/8UyVHrPyNka4sChlqKNbyEPdVQVjq5W+y4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678736990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBRdAUT5zAcd3v4xkZPTM5Pd+gMdA3kGoenKyKmJgXE=;
        b=8O96Fz9etH6P9ZFcClf5rM7i+prwuynKiSNM8vBLP7E0dNantAbm4OxguLsLHBo7Xo
         tOlsbWGpJlHythwl6RM5onruyn8bqwSE8nXSt3fF59fcKfwTFGYKt3PWBXQsgKqqjS7I
         4WWFAT43uWIA+STaA7HSYIGNV8d1grP45xLViXrXISsw51BFp5DH3N+yEeG4uqA0+Jbl
         UITl0osKYK1PGW3kII7/N7fPCuciX2ZeRuEM3dFZCj4DhP5pK2c5fAOoNn+2v38pMA0c
         GLmI9uEt0gkCwsJfWxU+Bj0kh5gTnbaGPPpLBvAfrPlOo4V2dedP01PRAFJhltiSVlo6
         0jiQ==
X-Gm-Message-State: AO0yUKUF5jXyUpzLbsMALmG1gsc8Jl1oLroIFK52ozXIXnwJKdrL7cPt
        f7gpdSQih8AuzICFg5KKrWIe/uoxVTNT6Rla8ZU=
X-Google-Smtp-Source: AK7set8TeR8JnS0f6QlydwxTYWWfHKot3QkCKwv86V1knyh2Mf0eVTRTFxpQZdZRAVe5GQHbNAUhVQ==
X-Received: by 2002:a05:6214:e41:b0:577:6328:af86 with SMTP id o1-20020a0562140e4100b005776328af86mr15133727qvc.12.1678736989894;
        Mon, 13 Mar 2023 12:49:49 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id 64-20020a370343000000b00729a26e836esm296489qkd.84.2023.03.13.12.49.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 12:49:49 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5416698e889so141295207b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 12:49:49 -0700 (PDT)
X-Received: by 2002:a81:ac4d:0:b0:541:6961:8457 with SMTP id
 z13-20020a81ac4d000000b0054169618457mr6039602ywj.2.1678736988650; Mon, 13 Mar
 2023 12:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230313181820.2482385-1-dianders@chromium.org>
 <20230313111806.2.Iee214b2dd184cb19197db8f97fad7e4adca273be@changeid> <89bf362b-6c63-447a-ad4b-91385bf26dab@sirena.org.uk>
In-Reply-To: <89bf362b-6c63-447a-ad4b-91385bf26dab@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 13 Mar 2023 12:49:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XWaWfDy+ZFjwq6hK4ssTtGjxRePzF2DooMAOg3fziZvw@mail.gmail.com>
Message-ID: <CAD=FV=XWaWfDy+ZFjwq6hK4ssTtGjxRePzF2DooMAOg3fziZvw@mail.gmail.com>
Subject: Re: [PATCH 2/2] regulator: fixed: Set PROBE_PREFER_ASYNCHRONOUS
To:     Mark Brown <broonie@kernel.org>
Cc:     mka@chromium.org, christian@kohlschutter.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 13, 2023 at 12:05=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:
>
> On Mon, Mar 13, 2023 at 11:18:20AM -0700, Douglas Anderson wrote:
> > As of commit 218320fec294 ("regulator: core: Fix off-on-delay-us for
> > always-on/boot-on regulators"), we now might have a big delay during
> > probe of fixed regulators. That can have a significant boot speed
> > impact. Let's mitigate this by preferring async probe for fixed
> > regulators. The regulator framework itself has no issues with
> > regulators probing in an asynchronous way. The fixed regulator driver
> > is fairly straightforward and also has no issues.
>
> This is going to be true for all regulators...

Sure, that's true. So what are you suggesting?

There has always been a hope that someday we could just turn on async
probe everywhere. Folks at ChromeOS / Android at Google have looked at
this on and off over the years. Most recently +briannorris looked at
and described it as "no small task". There were a lot of kinks across
the various subsystems. I think +Saravana also has it on his wishlist
to tackle, too.

For the most part, the best we've been able to do is to identify
devices that happened to be involved in long delays at bootup and add
the flag to those devices after confirming that they worked OK. It's
not super elegant but it's pragmatic. That's what I've done here. If
there are other regulator drivers that are known to be involved in big
delays during probe time then we should add the flag there, too. Right
now, "off-on-delay" is only for fixed regulators, though there's no
real reason it shouldn't be applied to all regulators. I suppose some
of the other regulator related delays could affect pretty much any
regulator, though I guess normally those aren't associated with
always-on / boot-on regulators?

If you want, I can submit a pile of patches adding this flag to more
regulators. I did that in the past for mmc:

31ae403513be mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that are
newer than 5.4
d86472ae8b20 mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in=
 v5.4
a1a489197a07 mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that
existed in v4.19
7320915c8861 mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that
existed in v4.14
2a99f3fa85ea mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in=
 v4.9
21b2cec61c04 mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in=
 v4.4


-Doug
