Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E2662B1F2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 04:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiKPDuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 22:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiKPDt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 22:49:57 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9955ECD5;
        Tue, 15 Nov 2022 19:49:56 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id k4so10889639qkj.8;
        Tue, 15 Nov 2022 19:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UZKsJoIfY0MbBUSTBsROBs0HiEIHYnlS6Iz33e/OHjA=;
        b=mtqJUeYxkwrG3fBI5/xBCHLc/j0jW7eQMtQrzL+oOfVpdLQcp8/JAU1RqaqlV6X+/c
         Ds84Omjs+/DALUI2ug+4cgeKGeJoVIRadkqN5exONZkQRiHbgNP25X2rMbnu/RA493lg
         0YeryszRx2oUjQqzyAiryhJ6s9CHxBsU217jqb6AzzHr/ERNTzEkWPzSLGeZZkHu4tOx
         qWCBn7PBOB4u7TdCe7VE01AWGdlzwPKW2GBcInOoy1lr3of4OW3dvFh8QY3e4XAzBcGa
         55umJL3lTvTXw5iUdwyQIdjvv2r+/5uxltTN2dqyldeeBv99RFJlyisVMCYvR0CL+Z6U
         rnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UZKsJoIfY0MbBUSTBsROBs0HiEIHYnlS6Iz33e/OHjA=;
        b=Y3EprU+4N5nZAaGIJYFWxWmYYKjx6e0/kv7gFzCbkBbGaBGEzZeInpltY3bktCNhSP
         L+RJnoqod1Ukia5JX7KKOJ6iVeTwLl3A6vT0Jy4w9qxKJMUrukSL+zYCA/qpJimrhSaP
         YeD2XBHY7R9SPMs6p9HSgDbag4fGp6wrtw7oDqCVrzwOYcsE91AFhjQtKryCMsAP1EiH
         YGty8jxuJYwl7K9KWs6mzYty7+M8NxxNJF63h1r08rrY27czBLEI0FZ9YT2nDKj6oD04
         IMb2R0KSZgC9hOYBli4zIBuheuWzWlpJEDIKAU2ekYwHMlpiklV2HT0ncU2eX1+9JceB
         RjGg==
X-Gm-Message-State: ANoB5pkffmOLNiKdCVQkft2NwTouVT9gvtKJ/qGOJIpVHsXNw++wXCTI
        R9M1d9nHrnneRddCJPI3xBj86VGy0/cWxXxSI1c=
X-Google-Smtp-Source: AA0mqf6HmRzZ9V0R9lu84kF5IYZA0L8+E2KmnGXyUBvj652qWLmcdA4Fu7+nBYCKT5++s7jH3itSHDWKxCT+a3IoP6o=
X-Received: by 2002:a05:620a:110d:b0:6ee:bbea:1ebb with SMTP id
 o13-20020a05620a110d00b006eebbea1ebbmr18395623qkk.638.1668570595612; Tue, 15
 Nov 2022 19:49:55 -0800 (PST)
MIME-Version: 1.0
References: <20221105222012.4226-1-Jason@zx2c4.com>
In-Reply-To: <20221105222012.4226-1-Jason@zx2c4.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Wed, 16 Nov 2022 13:49:43 +1000
Message-ID: <CAPM=9twc_TBtG_654Hm4SV_G1Ar+PiCuZGg1fV-Zooga+4S0GQ@mail.gmail.com>
Subject: Re: [PATCH] drm/atomic: do not branch based on the value of current->comm[0]
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        Christian Brauner <brauner@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Sean Paul <sean@poorly.run>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Nov 2022 at 08:21, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> This reverts 26b1d3b527e7 ("drm/atomic: Take the atomic toys away from
> X"), a rootkit-like kludge that has no business being inside of a
> general purpose kernel. It's the type of debugging hack I'll use
> momentarily but never commit, or a sort of babbies-first-process-hider
> malware trick.
>
> The backstory is that some userspace code -- xorg-server -- has a
> modesetting DDX that isn't really coded right. With nobody wanting to
> maintain X11 anymore, rather than fixing the buggy code, the kernel was
> adjusted to avoid having to touch X11. A bummer, but fair enough: if the
> kernel doesn't want to support some userspace API any more, the right
> thing to do is to arrange for a graceful fallback where userspace thinks
> it's not available in a manageable way.
>
> However, the *way* it goes about doing that is just to check
> `current->comm[0] == 'X'`, and disable it for only that case. So that
> means it's *not* simply a matter of the kernel not wanting to support a
> particular userspace API anymore, but rather it's the kernel not wanting
> to support xorg-server, in theory, but actually, it turns out, that's
> all processes that begin with 'X'.
>
> Playing games with current->comm like this is obviously wrong, and it's
> pretty shocking that this ever got committed.

I've been ignoring this because I don't really want to reintroduce a
regression for deployed X servers. I don't see the value.

You use a lot of what I'd call overly not backed up language. Why is
it obviously wrong though? Is it "playing games" or is it accessing
the comm to see if the process starts with X.

Do we have lots of userspace processes starting with X that access
this specific piece of the drm modesetting API. I suppose we might and
if we have complaints about that I'd say let's try to fix it better.

Sometimes engineering is hard, It was a big enough problem that a big
enough hammer was used.

I'd hope @Daniel Vetter can comment as well since the original patch was his.

Dave.
