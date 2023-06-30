Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EA47440B9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbjF3RBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjF3RBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:01:23 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEF34C3A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 10:00:02 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-66767d628e2so1655383b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 10:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688144389; x=1690736389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JHRes1O1VxMkr+CfLg+uJGUs+Iy2MgLhTyprz6Plm7M=;
        b=dAVepBRSWI8Z+sSG2bcHZWFJV1N3FsDVH7G83a8DbJvXjlmkgWZkv3vKatTg8DPYVw
         r9uIFE7N6l6l0NV9cvJRwqED6POrjJVdD+iMOSj1UfegI2c8wkIpHtIKEuJ8o4EPqA2d
         Lzoy/Jl4bh9V5hnS1hxRKOXDRQ1qURLy64daI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688144389; x=1690736389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHRes1O1VxMkr+CfLg+uJGUs+Iy2MgLhTyprz6Plm7M=;
        b=ex+sEArgQRWIEVZxdV4QIBtsMjYgi05LCAwsVDnVFuKuDD6c8fLFkGtT17PxSFmY/n
         LyBaYgLQTv6OiO2kpddQQG4q8hP+xmIEtj9HbHC/Sz/ThAs/K2LF6Wf+Z8/6y3c0f7Cj
         4kD5AstkwnZ5TAoIZ2pgFg+dU0kfSlMT9rp282iDfQdTe3crXquNSSiYHnpAO7jS2JVJ
         stEVF2gIy3kzmHhO9KjZSIdWQJqwmInPQ43k5Vd7lkD5aS0FhdcuLnR3F3nYoggCqcEw
         QSIy4L+K/HqP61vhILf+cEFQWRLwa0VguzJ6Hts+TGocGf572k0070H+Ixhh8KKF+8ca
         41KA==
X-Gm-Message-State: AC+VfDxzu7yPnGzOWoSFlfNiJ9WIXdL/CuVnAnCn2Qm1I1TBSt1Cx/IK
        2epqleenRcnhb4cNMV8RGPlS0zLa4Ro0RTUI/VM=
X-Google-Smtp-Source: ACHHUZ5o4/tBiwRadgu5tGxdbBGl4knDtTJFKkAyDtoDU59yvKQgxw2W2hUtynVX5t50awuXclX9Eg==
X-Received: by 2002:a05:6a20:12cf:b0:101:1951:d491 with SMTP id v15-20020a056a2012cf00b001011951d491mr3313305pzg.6.1688144389058;
        Fri, 30 Jun 2023 09:59:49 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p15-20020aa7860f000000b0064cca73d911sm10254599pfn.103.2023.06.30.09.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 09:59:48 -0700 (PDT)
Date:   Fri, 30 Jun 2023 09:59:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] pid: use flex array
Message-ID: <202306300950.2BE7567101@keescook>
References: <20230628-pokal-puzzeln-5199c679b051@brauner>
 <CAHk-=wiBXJOzkez2Rd=cQ5ckttJq6OdYtArFmCtVQHyeuQBGrw@mail.gmail.com>
 <20230630-testphasen-orangen-0e54486a267d@brauner>
 <CAHk-=whJJbmfBk_8v_vFn1NdJ9O-AKCrjY+EArkzgFp9h-sKHA@mail.gmail.com>
 <20230630-stiefel-rotor-7f2d13fc084f@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630-stiefel-rotor-7f2d13fc084f@brauner>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 10:04:14AM +0200, Christian Brauner wrote:
> On Fri, Jun 30, 2023 at 12:12:22AM -0700, Linus Torvalds wrote:
> > On Thu, 29 Jun 2023 at 23:51, Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > I have no preference for either syntax. Both work. But this is probably
> > > more an objection to this being mixed in with the flex array change in
> > > the first place.
> > 
> > Yes. I looked at it, and tried to figure out if it was related
> > somehow, and decided that no, it can't possibly be, and must be just
> > an unrelated change.

Yes, those changes were style changes because I was annoyed that a grep
for 'numbers[' didn't turn anything up. :P Since it's an array I think
it's just good form to use [] when accessing an element. But yes, it's
conceptually the same.

> > > I did react to that in the original review here:
> > > https://lore.kernel.org/all/20230518-zuneigen-brombeeren-0a57cd32b1a7@brauner
> > > but then I grepped for it and saw it done in a few other places already
> > 
> > Yeah, we do end up growing new uses of 'use 0 as a pointer' almost as
> > quickly as we get rid of them.

Apologies on this -- this patch was just before the addition of
struct_size_t(), so I missed it in the cleanup I did for that:
https://git.kernel.org/linus/d67790ddf0219aa0ad3e13b53ae0a7619b3425a2

> I've grepped around a bit and I saw that the
> struct_size((struct bla *)NULL, ...)
> pattern seems to be used in most places that have similar needs. Not
> sure if there's something nicer.

The above patch fixes them all (excepting struct pid). In retrospect, I
should have asked to carry the struct pid fix in the hardening tree due
to that.

> I gave this thing a stab myself since I have a few minutes and so Kees
> doesn't have to do it. Authorship retained and dropped the ack. Is the
> following more acceptable? 

Thanks for reworking it!

> [...]
> [brauner: dropped unrelated changes and remove 0 with NULL cast]

However, this should use struct_size_t(); I'll send a new patch and
double check that UBSAN stays happy, etc.

Sorry for the mess!

-Kees

-- 
Kees Cook
