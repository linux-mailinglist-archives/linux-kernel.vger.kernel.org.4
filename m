Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18D76D9263
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 11:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbjDFJMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 05:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjDFJMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 05:12:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3FF1713
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 02:12:18 -0700 (PDT)
Date:   Thu, 6 Apr 2023 11:12:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680772337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tKMi4AOpolsZ6hs2KT6abDjYL0q5nXT/MGGIlmbLajk=;
        b=Qoc/sGlrI/stiYe1y8zpyREHvbjCxM7dChDmkHKtmIEarpnkZyYcy0AhwVdUBJOiV7TirG
        REGu2jYUuuuEtQl/1KWD/53gBehxHtojJ/+Wg0aR0EufLh0uXHnaJ6QOHZMHNnCkeP1Lw3
        dlhrfMkhYt7LeTQ8K/PGXlQLlP0iQyC1RnVMOPkBmT03/s72m31LFi1WWi1JPdz7ptGl4P
        tpAczdLggWKMI03nHdlBYAsgouZxcCMpHWjvm/kJbXiEW3GMUuOcDjRTcFSob0ZLtkxXta
        QMTMqtT551tzLY4ly6BWVTihwpdrrmo1fw0uD/BcxTU/BM2CvEULYb66cJJlkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680772337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tKMi4AOpolsZ6hs2KT6abDjYL0q5nXT/MGGIlmbLajk=;
        b=krsz4s+o2vq3EZ4R7QZ9e/RY1eYBjT6mAEWKBXqRZFfHy4dYV/fvuy+2bMw2eZV9sYxWfI
        IYkb/roE2cZMSkCA==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v5 16/18] timer: Implement the hierarchical pull model
In-Reply-To: <ZBmwScbfvq5HGSCJ@lothringen>
Message-ID: <cd53a09a-7ac8-119a-d9cb-d2be48159f9@linutronix.de>
References: <20230301141744.16063-1-anna-maria@linutronix.de> <20230301141744.16063-17-anna-maria@linutronix.de> <ZBmwScbfvq5HGSCJ@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2023, Frederic Weisbecker wrote:

> On Wed, Mar 01, 2023 at 03:17:42PM +0100, Anna-Maria Behnsen wrote:
> > +static bool tmigr_inactive_up(struct tmigr_group *group,
> > +			      struct tmigr_group *child,
> > +			      void *ptr)
> > +{
> > +	union tmigr_state curstate, newstate;
> > +	struct tmigr_walk *data = ptr;
> > +	bool walk_done;
> > +	u32 childmask;
> > +
> > +	childmask = data->childmask;
> > +	newstate = curstate = data->groupstate;
> > +
> > +retry:
> > +	walk_done = true;
> > +
> > +	/* Reset active bit when child is no longer active */
> > +	if (!data->childstate.active)
> > +		newstate.active &= ~(u8)childmask;
> > +
> > +	if (newstate.migrator == (u8)childmask) {
> > +		/*
> > +		 * Find a new migrator for the group, because child group
> > +		 * is idle!
> > +		 */
> > +		if (!data->childstate.active) {
> > +			unsigned long new_migr_bit, active = newstate.active;
> > +
> > +			new_migr_bit = find_first_bit(&active, BIT_CNT);
> > +
> > +			/* Changes need to be propagated */
> > +			walk_done = false;
> 
> Do you need to propagate the changes even if you found a new migrator for the
> group?

No, you shouldn't require the walk then. Will think about it again, fix
(and test) it.

> > +
> > +			if (new_migr_bit != BIT_CNT)
> > +				newstate.migrator = BIT(new_migr_bit);
> > +			else
> > +				newstate.migrator = TMIGR_NONE;
> 
> Thanks.
> 

Thanks,

	Anna-Maria

