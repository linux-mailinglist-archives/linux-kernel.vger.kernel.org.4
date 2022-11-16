Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4AE62B6B8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238611AbiKPJjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238109AbiKPJjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:39:47 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4633D25282
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:39:45 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id n12so42611275eja.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6oqx15ITri8OuC13o4xCW0SmP3dFj+PiqjV49pnT8A=;
        b=TZCSe/yGP+6YUUxZ+J3RiJY4ZZose/RfW64FOqPUop2XAXuLE6BVBfv1uW5gjHBz+e
         jY4ZL1INXZi+XC4mhyNs198vPjVdRcWqCvAv20Hv5CHDkO16DbUgwCNB3owLSdhv/RF9
         iCekFgLlJcwBBdU6WRRe//N8RcoYY0FGMfYHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S6oqx15ITri8OuC13o4xCW0SmP3dFj+PiqjV49pnT8A=;
        b=TiuwpzhYfhMNCCNitc0dZFMKjIKmijXcuCcBVonRFAQopDgYTP3jOMbAQiejm7HJOQ
         eXfSuGwyBuhwpFRw2o049Edp5s2H8CLPfKbP1qKluY8YzCgSOcxQaNMO8IwWp5daXtu3
         aGrBERWas+v6hnZCkdtCTE6PMUUplmvV4MlvA7y8vIZr26lk3j9XuitBwFNdu7t8+lhn
         zRSd6/BHVDeUeqfOlQunO0b09jK+mAyTxv9wbagjtLJoS0kZdx554W4r92wmeKczvFYf
         +4lNqJlO5R9xBlSv+9hsIlE3gSKG8uTQLWhJaezIP3aoqUc4zUYOPA7UQ+kTERw/2aBY
         bKFA==
X-Gm-Message-State: ANoB5plqrrY8uWe0KIFtdjcpEo+tb1eBvpuP7Mk5K3LpeneYtw4VGJIa
        PY+dqPgJ52imV+xG1VNQeiF3Ew==
X-Google-Smtp-Source: AA0mqf5IDCFzMzxg7K+YiFTymvahSK1AsntC/ot3k1xLAUk0GHJ5RGc4u67XB6zl0x/PYZjfkwUibg==
X-Received: by 2002:a17:906:414d:b0:781:951:2fb with SMTP id l13-20020a170906414d00b00781095102fbmr17126729ejk.64.1668591583634;
        Wed, 16 Nov 2022 01:39:43 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id z4-20020aa7d404000000b0046778ce5fdfsm5928035edq.10.2022.11.16.01.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 01:39:43 -0800 (PST)
Date:   Wed, 16 Nov 2022 10:39:41 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Dave Airlie <airlied@gmail.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        Christian Brauner <brauner@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Sean Paul <sean@poorly.run>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: Re: [PATCH] drm/atomic: do not branch based on the value of
 current->comm[0]
Message-ID: <Y3Sv3TgclLH6SD0A@phenom.ffwll.local>
Mail-Followup-To: Dave Airlie <airlied@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        dri-devel@lists.freedesktop.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        Christian Brauner <brauner@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Sean Paul <sean@poorly.run>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
References: <20221105222012.4226-1-Jason@zx2c4.com>
 <CAPM=9twc_TBtG_654Hm4SV_G1Ar+PiCuZGg1fV-Zooga+4S0GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9twc_TBtG_654Hm4SV_G1Ar+PiCuZGg1fV-Zooga+4S0GQ@mail.gmail.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 01:49:43PM +1000, Dave Airlie wrote:
> On Sun, 6 Nov 2022 at 08:21, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > This reverts 26b1d3b527e7 ("drm/atomic: Take the atomic toys away from
> > X"), a rootkit-like kludge that has no business being inside of a
> > general purpose kernel. It's the type of debugging hack I'll use
> > momentarily but never commit, or a sort of babbies-first-process-hider
> > malware trick.
> >
> > The backstory is that some userspace code -- xorg-server -- has a
> > modesetting DDX that isn't really coded right. With nobody wanting to
> > maintain X11 anymore, rather than fixing the buggy code, the kernel was
> > adjusted to avoid having to touch X11. A bummer, but fair enough: if the
> > kernel doesn't want to support some userspace API any more, the right
> > thing to do is to arrange for a graceful fallback where userspace thinks
> > it's not available in a manageable way.
> >
> > However, the *way* it goes about doing that is just to check
> > `current->comm[0] == 'X'`, and disable it for only that case. So that
> > means it's *not* simply a matter of the kernel not wanting to support a
> > particular userspace API anymore, but rather it's the kernel not wanting
> > to support xorg-server, in theory, but actually, it turns out, that's
> > all processes that begin with 'X'.
> >
> > Playing games with current->comm like this is obviously wrong, and it's
> > pretty shocking that this ever got committed.
> 
> I've been ignoring this because I don't really want to reintroduce a
> regression for deployed X servers. I don't see the value.
> 
> You use a lot of what I'd call overly not backed up language. Why is
> it obviously wrong though? Is it "playing games" or is it accessing
> the comm to see if the process starts with X.
> 
> Do we have lots of userspace processes starting with X that access
> this specific piece of the drm modesetting API. I suppose we might and
> if we have complaints about that I'd say let's try to fix it better.
> 
> Sometimes engineering is hard, It was a big enough problem that a big
> enough hammer was used.
> 
> I'd hope @Daniel Vetter can comment as well since the original patch was his.

Frankly I refrained from replying when I've seen the patch originally
because I didn't manage to come up with a nice&constructive reply like you
did here. The only thing novel here is the amount of backhanded insults
folded into the commit message.

I very much welcome constructive contributions that actually solve the
problem here, or at least move it forward a bit. This patch is neither.

What might be an option is a tainting module option that disables this
check, since the amount of people willing&able to fix up Xorg is still
zero. But that would need to come with a proper commit message and all
that, and ideally a pile of acks from people who insist they really want
this and need it.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
