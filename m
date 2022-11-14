Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCC56286CC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237480AbiKNRRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237872AbiKNRQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:16:54 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23A71A059
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:16:52 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id e15so7191027qts.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FwATKOMMweKsXI8MejrsmvPC+pLhLOMy4tm3g8Ji6So=;
        b=FzoH+MTWWCHj4vMKiE1IZSj92DU4GAfAJK3BMcYADwvwaCS2G1GuBQNEtiIoxSnuVI
         pfyH8k9d2+bDBZbngUzW44os7KZZRRa9Z+nWsHxPlZ17lnkvnIvArtw98wxMCJ5CwwCG
         TK7tsJANWARnNLhaxkO5LIHrybNJEfskiv/4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FwATKOMMweKsXI8MejrsmvPC+pLhLOMy4tm3g8Ji6So=;
        b=lLBlEOabLHrPs8xn25WCIMMuXFVyUdoxq4p41hq27nL+zatmPpY0wLXCwGL/VuMbeX
         IhdWFgKJWZt+luRT+GDOGfsIRuDFHU6ap65/y2UOPUn3V1cfa82vHqedoSoxR8n3qdW0
         5u+X7XNdl75jTcYgVHcZj22/mneIr+rRbLiaGdMXp8ZZqc3Txbf75PF5+rF0ukzaclSo
         2F6dobWkgMZCoXh/cpLFbdNsrg1CUI7DRq1c3vsDDWKKsoSqMvbhlZ9UZjwV/xAavUOI
         8TRalFHt1dFnGzD+nYxJbC3GEkGm+AZTmm+jlWiwLRFvdfzrFqai3kDi/JcATbjyShR4
         8iog==
X-Gm-Message-State: ANoB5plLmDnuoUiFxFQJeTwCzE5raUPOQAJ4PtNpkPNCpPteLCaIBHn4
        pTHrL9AZWEofSKc9v1tJF8CRb1315YUUdw==
X-Google-Smtp-Source: AA0mqf61wy36GhVXPRyJgpqBNL9xjfBAaiZUHWBX82h5atZkhInUyyZV0d3XqjVCr6VKflqYM0crUA==
X-Received: by 2002:a05:622a:302:b0:3a5:4f9b:215a with SMTP id q2-20020a05622a030200b003a54f9b215amr13410053qtw.394.1668446210918;
        Mon, 14 Nov 2022 09:16:50 -0800 (PST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com. [209.85.222.170])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006ec62032d3dsm6928864qkp.30.2022.11.14.09.16.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 09:16:48 -0800 (PST)
Received: by mail-qk1-f170.google.com with SMTP id z1so7816041qkl.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:16:47 -0800 (PST)
X-Received: by 2002:a37:46d6:0:b0:6ee:24d5:b8fc with SMTP id
 t205-20020a3746d6000000b006ee24d5b8fcmr12144736qka.336.1668446207273; Mon, 14
 Nov 2022 09:16:47 -0800 (PST)
MIME-Version: 1.0
References: <20221110064101.429013735@goodmis.org> <20221110064147.343514404@goodmis.org>
 <875yfitpdu.ffs@tglx> <20221113191518.0a3b29b1@rorschach.local.home>
 <87sfims7ca.ffs@tglx> <87iljhsftt.ffs@tglx>
In-Reply-To: <87iljhsftt.ffs@tglx>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Nov 2022 09:16:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj7DtViDctAzV3PqdYBEh5vcQnRJPtFFB=uaAP=W-VG4A@mail.gmail.com>
Message-ID: <CAHk-=wj7DtViDctAzV3PqdYBEh5vcQnRJPtFFB=uaAP=W-VG4A@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] timers: Add timer_shutdown_sync() to be called
 before freeing timers
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Eric Dumazet <edumazet@google.com>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 7:42 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> So if we want to make this solid and make the life of driver writers
> easier, then we cannot issue a warning as I said in the original thread
> already.

So I think that there are two issues at play:

 (a) do we want to *find* problem places after the conversion

 (b) do we want to make driver writing easier

and (a) argues for warning on timer re-arming, but (b) just says
"don't warn, just ignore it, the driver is being shut down".

I'm personally ok with either of those approaches, and it's literally
just a question of mindset.

> The semantics of timer_shutdown_sync() have to be:
>
>    After return:
>      - the timer is not queued
>      - the timer callbacks is not running
>      - the timer cannot be enqueued again

Yes, but that last case is literally a "do we expect the *driver* to
not enqueue it and warn if it tries, or do we just silently enforce
it"?

I agree with all three points. I'm just not sure about who we expect
to do the "don't enqueue again".

There's a big argument for "make it easy for driver writers" in just
saying "make mod_timer() silently just ignore a re-arming". Making
things easier for driver writers is a good thing.

But maybe it's a "you shouldn't have done that in the first place"
thing, and merits a warning?

I have no strong opinions on that.

What I *do* still want to happen is for subsystems to be able to start
doing the conversion one by one. Which is why I'd still prefer to have
the new names available just so that we don't have to have one
50-patch series, but we can have subsystems apply the obvious cases.

And I'd still like the mindless "let's get the non-semantic changes
out of the way" as one single patch, to get rid of mindless noise.

And honestly, for that to happen I'd be perfectly happy with something like

  #define timer_shutdown(t) del_timer(t)
  #define timer_shutdown_sync(t) del_timer_sync(t)

(obviously with the patches that first remove the existing
'timer_shutdown()' uses first). That wouldn't introduce the *new*
semantics, but it would at least allow the different subsystems to do
the obvious cases, and let the networking people wonder about the much
less obvious ones.

              Linus
