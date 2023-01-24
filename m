Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF29367A604
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbjAXWk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbjAXWky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:40:54 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793E155BF
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:40:50 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 129so16828699ybb.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RDuGCLBsJROnQgjnYY3aX7bga786PqkzOmiF+tHPmuU=;
        b=L5aVE7jbnsLPir/FYv94dI8JnFNEZksUG3d+/xJ+jMK3nFrH1HYRwl29JR+qM3PLe+
         0br/fzxb32B9S9TEmPOvcdLKHkafzvL4INoSYqbtRlhdMKrPn2Kv3Lk9C59U7fSCNNF+
         NNY/bSbiOGLe5l7QJGqURIiGLwj7MTxNuvWfX7noQTbYThyNB21bnkUU/vPzGX1VaTKU
         Jx6ua5K3+iWy76KNfIQf5P2ftHQ71k69kDqaN40R9iWi59SsPwWpwvxQNrWtSsyBfHvk
         9BLvWUqSikMGiyzfDGQjSvEUdPFanSnttQfF3+chlN7LNvOmIvPthPteyjnLxNDZEiKY
         /BAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDuGCLBsJROnQgjnYY3aX7bga786PqkzOmiF+tHPmuU=;
        b=F8BQCyfeIwPq7s7FvI5aHWQmE3OKObRk2VEa6nVgcyA07KCubJuAh856hsdlJerYaQ
         WsV4FCkUFFMpLI3dzn+BnBaGWWkg8m9DwlgG6Je2kFRRZVZbasVM3+DFyi0TMUkHO9HY
         3yd2VAw865pDLpJaBSJvy9NFO70m6DU8yYXlSvtTUnMoxSMdRYJSfrTwxktcwSepk9Wh
         IN0P5PDX3xLC5Zla9MM/FYvQLiCnSgHORmDRRwp+yBKqZK0Hd3F/NZiV1BUWGKToxKd0
         Rny+Jl9j3Rs0STjDgjRKu+dE5bDrxpce7LLf4d2LPHPbYbzkhAqzNj3gYDqBcGfhGZm1
         m7jA==
X-Gm-Message-State: AFqh2koBSb3ErRJGIpdJUWGRa6E4GQMhqS9nHeQPkI21G3HXs591fDbW
        tUSfPcXnVzOMOUV9Wk9Xz60WGlzj+GxcrozdoUA0
X-Google-Smtp-Source: AMrXdXtyEia+HG5eqTF+SyJQlkM/vHqfCujv/2gYx1yXc7lnImaA7YrNPGVE3yv0SI/Dh6uQiPvXwQ4FKYU2rdscuUY=
X-Received: by 2002:a25:2501:0:b0:801:4500:63e with SMTP id
 l1-20020a252501000000b008014500063emr2172584ybl.332.1674600049392; Tue, 24
 Jan 2023 14:40:49 -0800 (PST)
MIME-Version: 1.0
References: <20230123182728.825519-1-kan.liang@linux.intel.com>
 <20230123182728.825519-2-kan.liang@linux.intel.com> <CANDhNCpWwxXM8DD9h4zOW+bygshkOg9TWO9Z7wJO_B7bDtgEHw@mail.gmail.com>
 <9c17d6be-e532-84e1-4d35-77b9bd3051dc@linux.intel.com> <CANDhNCp_0Os+e0A0LZ7yKw16mWai9MAPMPYL0p1NkcVxifh88w@mail.gmail.com>
 <1fb59dfa-1ab9-51ad-98c6-89431aa56918@linux.intel.com> <CANDhNCodq8iyRY-md-nRkAPYS5p3iTCgDqZXvWAA108TctQASg@mail.gmail.com>
 <c8ad4654-6bfd-2983-036e-e969787992e9@linux.intel.com>
In-Reply-To: <c8ad4654-6bfd-2983-036e-e969787992e9@linux.intel.com>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 24 Jan 2023 14:40:37 -0800
Message-ID: <CANDhNCqxOurpjKQaEEgxdFYV8kQQHVUNZUy1B5AewSi8bys8iQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] timekeeping: NMI safe converter from a given time to monotonic
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Stephane Eranian <eranian@google.com>, peterz@infradead.org,
        mingo@redhat.com, tglx@linutronix.de, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        ak@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 2:08 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
> On 2023-01-24 3:33 p.m., John Stultz wrote:
> > On Tue, Jan 24, 2023 at 12:13 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
> >> On 2023-01-24 1:43 p.m., John Stultz wrote:
> >> I read the code correctly, it should happen only when adjusting NTP or
> >> suspending/resuming. If so, I think the drawback should not impact the
> >> normal analysis work. I will call out the drwabacks in the comments
> >> where the function is used.
> > So the adjustments are done at tick time depending on the current NTP
> > "error" (basically what the kernel tracks as the delta from its sense
> > of what NTP has told us).
> >
> > Not just at the time when ntp makes an adjustment.
> >
> > So the window for it to happen is every timekeeping update (which is ~HZ).
>
> You mean the tkf->base is updated in each tick?

Right, every call to timekeeping_update(), which is called for every
major state change in time along with regular updates via
timekeeping_advance() which is called from update_wall_time() which
gets called from the various tick handlers.

> If so, that should be a problem.
>
> Does the NTP "error" consistently happen on all the platforms? Or just
> on some platforms which we can check and limit the usage?

Basically any platform where adjtimex was ever called.  Both offset
and freq adjustments will trigger this. The trouble is that the
adjustments requested are finer grained than what the actual
clocksources mult values can be adjusted for. So the kernel tracks the
error internally and will oscillate the clocksource multiplier value
to keep the long-term accuracy close to what was requested.

> There are two configurations for PEBS, single PEBS, and large PEBS.
> For the single PEBS mode, HW triggers a NMI for each record. The TSC is
> the time which the record is generated, and we convert it in the same
> NMI. I don't think the NTP "error" can impact it.

If the clocksource is being adjusted in between reads (imagine the
freq is dropped), when using the fast accessors, time may seem to go
backwards between those reads.

In fact, if the same TSC value is used for two calls in a row, you
could see time go backwards or forwards between them if the adjustment
happened inbetween.

The regular (non-fast) clocksource accessors use the seqcount to
prevent reads from occuring while the adjustment is made from being
used (you'll note we always re-read the clocksource within the
seqcount loop) but this makes it not NMI safe.


> But for the large PEBS mode, HW triggers a NMI only when a fixed number
> of records are generated. It's very likely that the base has been
> updated between the records. That could bring troubles, since we can
> only fall back to the NMI handler time of the last record. I'm afraid we
> have to disable the large PEBS mode.
>

Right, if I recall, this is why the interpolation is done in the
existing get_device_system_crosststamp(). It's obviously never going
to be perfect as we dont' keep the timekeeper state for every tick,
but it might be better than the bailout you have if you didn't luck
into the current interval.

My apologies, as my intention isn't to dissuade you here, but just to
make sure the complexities (and unfortunately there are a lot) are
well worked out and well tested.

thanks
-john
