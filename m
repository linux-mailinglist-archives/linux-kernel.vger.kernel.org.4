Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5E2702A88
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240999AbjEOKd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240673AbjEOKd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:33:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C85C6
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 03:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=0dGuUcPa3VE3upioVJOgHex/yTg2AVBZ5aHWv1wRh8A=; b=jgJuHKCMtfIkXJmRZxdtp3xNB0
        k96olPfwFkrHQLkEras2RDUEnyDiHJGf/WoepHtI3XUj2XYjOdOMUpwvHcEuDgbwjF/MQI/aY80jS
        xpOUqsDrx+RSdxL1fZs/ZfM3adI1xeH4036wHOXU9Xh04BqfWQ0ape2VB7u3GtaxeWUY5GPqPAs7L
        YFNRbPcyrRFvESyBBxtBxaJEXyMPK6wtfqXqGLZeUkybgcFkLjfVgNPbmINgEtxGPwApwjoYhjEiM
        QO45XgpCZL5Nakxz1wwyEewPmxPlxYZtTnRGBGhksgOV9q6e9tT/Q7mWxIOt/3lOdN+4phkNX2nGv
        YsUKospQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pyVW1-00BS5C-0o;
        Mon, 15 May 2023 10:33:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3D257300244;
        Mon, 15 May 2023 12:33:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1AC212DCBEAEE; Mon, 15 May 2023 12:33:16 +0200 (CEST)
Date:   Mon, 15 May 2023 12:33:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] watchdog: Prefer use "ref-cycles" for NMI watchdog
Message-ID: <20230515103316.GG83892@hirez.programming.kicks-ass.net>
References: <20230509221700.859865-1-song@kernel.org>
 <20230512124659.GY4253@hirez.programming.kicks-ass.net>
 <CAPhsuW4GD77L-i-t90E743HTam=qRC0HP7XefT_rXC_WM6s2Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW4GD77L-i-t90E743HTam=qRC0HP7XefT_rXC_WM6s2Hw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 09:43:48AM -0700, Song Liu wrote:
> On Fri, May 12, 2023 at 5:47 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, May 09, 2023 at 03:17:00PM -0700, Song Liu wrote:
> > > NMI watchdog permanently consumes one hardware counters per CPU on the
> > > system. For systems that use many hardware counters, this causes more
> > > aggressive time multiplexing of perf events.
> > >
> > > OTOH, some CPUs (mostly Intel) support "ref-cycles" event, which is rarely
> > > used. Try use "ref-cycles" for the watchdog. If the CPU supports it, so
> > > that one more hardware counter is available to the user. If the CPU doesn't
> > > support "ref-cycles", fall back to "cycles".
> > >
> > > The downside of this change is that users of "ref-cycles" need to disable
> > > nmi_watchdog.
> >
> > Urgh..
> >
> > how about something like so instead; then you can use whatever event you
> > like...
> 
> Configuring this at boot time is not ideal for our use case. Currently, we have
> some systems support ref-cycles and some don't. So this is one more kernel
> argument we need to make sure to get correctly. This also means we cannot
> change this setting without reboot.

You can still add the fallback (with a suitable pr_warn() that the
requested config is not valid or so).

> Another idea I have is to use sysctl kernel.nmi_watchdog, so we can change
> the event after boot. Would this work?

Yeah, I suppose you can also extend the thing to allow runtime changes
to the values, provided the NMI watchdog is disabled at the time or
somesuch.

> Btw, the limitation here (ref-cycles users need to disable NMI watchdog) comes
> from the limitation that the programmable counters cannot do ref-cycles. Is this
> something we may change (or already changed)?

I really don't know .. and if it's not in the SDM I probably couldn't
tell you anyway :/
