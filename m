Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3192B626BAD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 21:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbiKLUwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 15:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbiKLUwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 15:52:04 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5787FAEF
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 12:52:01 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id x15so5661118qvp.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 12:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lxnav.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dSyudzyX5CRHk6TCL/q8fJ2Jvwv53i/ZsN+8T0uzezc=;
        b=L+aPJqi/0V/aftlhxP1IvuZk7dTZwW+wt4KpxHiaVG2+2ZK6h0sA9sbv4TJDFD97Em
         OXwt1MVMUzPLbft+iaVTk2zDGboahGa1ZuidNFByYTlyY95iIsI00oSYe2QFG7uGaldh
         QJm3Q7leabNpZ7mZJuAwwPt7XP2ImoXMXqqKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dSyudzyX5CRHk6TCL/q8fJ2Jvwv53i/ZsN+8T0uzezc=;
        b=gb1sPscuv5XZJgpX4qUO+FkqOudTmx0l+a01ukE9lbPro5g10279mMlIcSNJVsV98C
         M53fknuWpwWEEdkPoJY+H57kZY0z4fIF8TK6S0VIucD3ONBV18AC4chnhm75iLQQiaaa
         qt3IrT3t3NS9SEsr2qEGA0XO0Ll9pUUA217+y4+fGOxZmbGDQYciFFcswHcV+su2ODxl
         86WyJfNDTZBlXnlvXhXNrKI8oaDsEWaDyqoVgJRQfrKbgKX42VRF973MsUcI39o5p059
         ofRrau4HBxioa0WrOGNVrgngiwCqUsmdBHeQtYkdQbV0CW2VwTopFzkfVJU9WzboiXeA
         Z+KQ==
X-Gm-Message-State: ANoB5pkcoFzNggTNuZ9tg4Fz916xQRkLQWL/7UIh2W1tt5U2hwfdCy1k
        UCcAhOvEgrGJmfOgImTNn+a3xT6yik0yt7JCUruGTQ==
X-Google-Smtp-Source: AA0mqf6YVTNhoVRSbFPX8nrG94EE27+1SyNGVJwwXetBExINJ+wpvzwy7b7gT1/97rZ3cw7G6hBWDSJXfvVaH0TR9ss=
X-Received: by 2002:a05:6214:1552:b0:4bb:8e59:fc4b with SMTP id
 t18-20020a056214155200b004bb8e59fc4bmr7123483qvw.89.1668286320868; Sat, 12
 Nov 2022 12:52:00 -0800 (PST)
MIME-Version: 1.0
References: <20221111112657.1521307-1-mitja@lxnav.com> <20221111112657.1521307-3-mitja@lxnav.com>
 <20221112172806.6db090eb@jic23-huawei>
In-Reply-To: <20221112172806.6db090eb@jic23-huawei>
From:   =?UTF-8?Q?Mitja_=C5=A0pes?= <mitja@lxnav.com>
Date:   Sat, 12 Nov 2022 21:51:36 +0100
Message-ID: <CACbQKWfEa64Fv4CmW8BDp2rXw504YyL_s2TWiA_SwH-zCKKvCA@mail.gmail.com>
Subject: Re: [PATCH 2/4] iio: adc: mcp3422: allow setting gain and sampling
 per channel
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Sat, Nov 12, 2022 at 6:15 PM Jonathan Cameron <jic23@kernel.org> wrote:
> Was it possible for these scales to differ before this change?
Yes. The difference is that before this change you could only see and set
available scales that were available for specified sampling rate. Now you're
able to set gain and sampling rate via scale. So before the change you got
these (@240sps):

0.001000000 0.000500000 0.000250000 0.000125000

Now you get the complete set:
/*                 gain x1     gain x2     gain x4     gain x8  */
/* 240 sps    */ 0.001000000 0.000500000 0.000250000 0.000125000
/*  60 sps    */ 0.000250000 0.000125000 0.000062500 0.000031250
/*  15 sps    */ 0.000062500 0.000031250 0.000015625 0.000007812
/*   3.75 sps */ 0.000015625 0.000007812 0.000003906 0.000001953

> If not, then why was the previous patch a fix rather than simply a precursor
> to this change (where it now matters).
I wanted to separate a bug fix from improvements, if these were rejected for
for some reason.

> There are a number of changes in here which are more stylistic cleanup
> than anything to do with the functional change. Please pull those out
> to a precursor patch where we can quickly check they make not functional changes
> rather than having them mixed in here.
Will do.

> I have no particular problem with taking these from hex
> to decimal, though I'm not really seeing the necessity.
>
> However, it is really a style question and should not be in this
> patch where it mostly adds noise making it slightly harder
> to spot the functional changes.
My styling preference. I think indexes should be decimal so they are not
confused with flags.

> >               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) \
> > -                             | BIT(IIO_CHAN_INFO_SCALE), \
> > -             .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> > +                             | BIT(IIO_CHAN_INFO_SCALE) \
> > +                             | BIT(IIO_CHAN_INFO_SAMP_FREQ), \
>
> Hmm. This is an ABI change.  Hopefully no one will notice however.
Indeed. I've noted this in the cover letter.


> > -static const int mcp3422_read_times[4] = {
> > +static const int mcp3422_read_times[MCP3422_SRATE_COUNT] = {
> Reasonable to make this change, but I think it belongs in a precursor patch.
Will fix.

> > +     for (i = 0; i < MCP3422_SRATE_COUNT; i++) {
> > +             count += sprintf(buf + count, "0.%09u 0.%09u 0.%09u 0.%09u%s",
> > +                     mcp3422_scales[i][0],
> > +                     mcp3422_scales[i][1],
> > +                     mcp3422_scales[i][2],
> > +                     mcp3422_scales[i][3],
> > +                     (i < MCP3422_SRATE_COUNT - 1 ? " " : "\n"));
>
> What does the output of this now look like?
0.001000000 0.000500000 0.000250000 0.000125000
0.000250000 0.000125000 0.000062500 0.000031250
0.000062500 0.000031250 0.000015625 0.000007812
0.000015625 0.000007812 0.000003906 0.000001953
All in one line.

> For available attributes we tend to only show the values available assuming
> just the one thing is changing.  Hence hold sampling frequency static, then
> show what scales are available
> It can get complex if there are nasty interactions so we might have a
> situation where one attribute allows to all the possible values.
> So maybe we have all scales available and on a write try to find
> the nearest frequency to the current at which we can deliver the
> required scale.
That's what's being done here:
+ for (j = 0; j < MCP3422_SRATE_COUNT; j++) {
+ for (i = 0; i < MCP3422_PGA_COUNT; i++) {
+ if (val2 == mcp3422_scales[j][i]) {
+ config &= ~MCP3422_PGA_MASK;
+ config |= MCP3422_PGA_VALUE(i);
+ config &= ~MCP3422_SRATE_MASK;
+ config |= MCP3422_SAMPLE_RATE_VALUE(j);
+ adc->ch_config[req_channel] = config;
+ return 0;
+ }
  }
  }

Before it looked at only one sampling frequency and all gains, now it looks at
all combinations.
Looking at this I agree that it would be better to find nearest instead of
looking for an exact match.

> My gut feeling for this device is make the sampling frequency the dominant
> attribute.  So just list the available sampling frequencies not taking
> scale into account.  For current sampling frequency just list the available
> scales and only accept those to be written to the scale attr.
That way the order in which you set attributes matters. Is that really better?
This device has a settable sampling rate and gain and they are independent.
But we could only set gain via scale which values were sampling rate dependent.

> >       /* meaningful default configuration */
> > +     for (i = 0; i < 4; i++) {
> > +             adc->ch_config[i] = (MCP3422_CONT_SAMPLING
> > +             | MCP3422_CHANNEL_VALUE(i)
> > +             | MCP3422_PGA_VALUE(MCP3422_PGA_1)
> > +             | MCP3422_SAMPLE_RATE_VALUE(MCP3422_SRATE_240));
> > +     }
> > +
> >       config = (MCP3422_CONT_SAMPLING
> >               | MCP3422_CHANNEL_VALUE(0)
> >               | MCP3422_PGA_VALUE(MCP3422_PGA_1)
>
> Perhaps use the first channel configuration for this?
Will fix.

Kind regards,
Mitja
