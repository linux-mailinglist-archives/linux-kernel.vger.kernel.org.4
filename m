Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEB36D8E4F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 06:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbjDFEYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 00:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbjDFEYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 00:24:31 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB8A8A55
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 21:24:29 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id u97so2835211ybi.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 21:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680755068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puK3a92VIcFR8DZUjfLY5Zthlc/h1NJaguZIqRU5ZbY=;
        b=srUDOS282koby+W1c0YzjdnoDWiEEWYMzkc/fjye5dgJk54gJ/v/y7E8z/k6z3P99d
         1glIIM0OoCKuZ9gwIDMAlaywSn6mhTVPfLXvB6oRdgyTjYQKiYX4BGnq7YdBX1BrSzd5
         ckNqpBmXr1+/uFkONj5Wou+ecdZPSVRNq8gXK8oNb2C9WqzkJMWFmp6Mim+PfPTCQR3X
         crPRmuuyPa3QDOAFdU56qHmllr3aR4s6wp1MjcBfu2p90QvIPK0eyhYWO+6aOy16pr0I
         Wg4JGwWR6uV8CcQypeRIEHZCOwiGvu8Y5oCXJlJ3lpTkrsHOdxo7PwU2rJK+ymoOpuxI
         YDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680755068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puK3a92VIcFR8DZUjfLY5Zthlc/h1NJaguZIqRU5ZbY=;
        b=hCys0DMrHAjHT6PDhqf/1tI1l9hD8UyZVtzbiolEl96nlafgTjssbvGLrbedRY9MVh
         NMyJ+24zmmJfawtC100cXf4RO2ZK7cwl457z2ZwcSZua+XtN4kWVJNTyNJBf+kO/2bVa
         XJFIZaeUErJFYFPZnHReih6wWHzCLFu87jgrnYgTeDfe/Ebs+wuNfwjQHCpl8GQwF3OP
         Y/vOXgfLSmDt8KrIoQtmXmlOd2DP7q0tlcX1RBKVALGkpwCBVx5v8AkF2gAWF86M5KA3
         z+ZFm+th6j7hJlAPBF3p2YMXGAFgTEoppXJHP+lupZPKfjgCBzitWu9cl8zmEVD9inqt
         nG5g==
X-Gm-Message-State: AAQBX9fcm6UzrCixmyG4FfmIu3fSFH1BBXMVOM/KkY5nEmNw0DhVs48O
        H/2gUcyjoMdhShhMvBFoscLXs/qwM9FmpuNPYpGr
X-Google-Smtp-Source: AKy350YtLXFfQ6EkwnXCDrgRQ7fIlVpSETrEO79HYvdZzc/YmdZp9lagOsgoajysFV+BmlG7zUAiGU4T0y3VYN74whQ=
X-Received: by 2002:a25:ccc4:0:b0:b73:caa7:f06f with SMTP id
 l187-20020a25ccc4000000b00b73caa7f06fmr1203173ybf.5.1680755068599; Wed, 05
 Apr 2023 21:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230405185650.239f9721f066aa480e83d543@linux-foundation.org>
 <20230405172524.e25b62e1c548a95564b1d324@linux-foundation.org>
 <20230406000854.25764-1-jaewon31.kim@samsung.com> <20230406014419epcms1p3f285b6e3fdbb1457db1bcbaab9e863be@epcms1p3>
 <CGME20230406000841epcas1p3630010a770682be0f1d540a448f3e00e@epcms1p2>
 <20230406021712epcms1p216f274040d25d18380668ffbfa809c48@epcms1p2> <20230405200923.9b0dca2165ef3335a0f6b112@linux-foundation.org>
In-Reply-To: <20230405200923.9b0dca2165ef3335a0f6b112@linux-foundation.org>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 5 Apr 2023 21:24:17 -0700
Message-ID: <CANDhNCq+mhhXjW7huYoQwUq18sRCcn6HjbPqh7mU9KrGyKeLfA@mail.gmail.com>
Subject: Re: [PATCH v2] dma-buf/heaps: system_heap: Avoid DoS by limiting
 single allocations to half of all memory
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     jaewon31.kim@samsung.com,
        "tjmercier@google.com" <tjmercier@google.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 5, 2023 at 8:09=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
> On Thu, 06 Apr 2023 11:17:12 +0900 Jaewon Kim <jaewon31.kim@samsung.com> =
wrote:
>
> > >> +       if (len / PAGE_SIZE > totalram_pages())
> > >> +               return ERR_PTR(-ENOMEM);
> > >
> > >We're catering for a buggy caller here, aren't we?  Are such large
> > >requests ever reasonable?
> > >
> > >How about we decide what's the largest reasonable size and do a
> > >WARN_ON(larger-than-that), so the buggy caller gets fixed?
> >
> > Yes we're considering a buggy caller. I thought even totalram_pages() /=
 2 in
> > the old ion system is also unreasonable. To avoid the /2, I changed it =
to
> > totalram_pages() though.
> >
> > Because userspace can request that size repeately, I think WARN_ON() ma=
y be
> > called to too often, so that it would fill the kernel log buffer.
>
> Oh geeze.  I trust that userspace needs elevated privileges of some form?
>
> If so, then spamming dmesg isn't an issue - root can do much worse than
> that.
>
> > Even we think WARN_ON_ONCE rather than WARN_ON, the buggy point is not =
kernel
> > layer. Unlike page fault mechanism, this dma-buf system heap gets the s=
ize from
> > userspace, and it is allowing unlimited size. I think we can't fix the =
buggy
> > user space with the kernel warning log. So I think warning is not enoug=
h,
> > and we need a safeguard in kernel layer.
>
> I really dislike that ram/2 thing - it's so arbitrary, hence is surely
> wrong for all cases.  Is there something more thoughtful we can do?

Just for context, here's the old commit that added this to ION:
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Dc9e8440eca61298ecccbb27f53036124a7a3c6c8

I think the consideration was that allocations larger than half of
memory are likely due to erroneously "negative" size values.

My memory is foggy on any discussions from that time, but I imagine
the thinking was treating the value as if it were signed and error out
immediately on negative values, but rather than just capping at 2gb on
32bit systems, one could scale it to half of the system memory size,
as that seemed an appropriate border of "obviously wrong".

And the reason why I think folks wanted to avoid just warning and
continuing with the allocation, is that these large allocations would
bog the system down badly before it failed, so failing quickly was a
benefit as the system was still responsive and able to be used to
collect logs and debug the issue.

When you say "decide what's the largest reasonable size", I think it
is difficult as with the variety of RAM sizes and buffer sizes I don't
think there's a fixed limit. Systems with more ram will use larger
buffers for image/video capture buffers.  And yes, you're right that
ram/2-1 in a single allocation is just as broken, but I'm not sure how
to establish a better guard rail.

thanks
-john
