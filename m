Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8483B623127
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbiKIRNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiKIRNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:13:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9240A1740D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 09:13:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E01E61BF8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 17:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36628C433C1;
        Wed,  9 Nov 2022 17:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668013995;
        bh=0vwf7/h3n8f9yZ0UJ0OpWCfLux64K87StRZHpL2ILzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E3sbPlaJ68SGp+eDAmlhEAeQV+RM0i1VJtPdmrrKq0/bpEvSzjviNOZIhvkX7pT/J
         N21fyc6ESr9BQArdb8uHfVWefxHF4/sNuvjpy3TKAzScKt3INB30j9CckKoECQz85i
         lWDGc4jaJBakLHiaWFbtTQsLfWOFsU+O7TPJoyqr12o18DlGI0ocs6RgqHlEdVBvkF
         DBMbxqNphJf8Fen1UHBKVei9Hy09xIBrfCFUXLOnrIhuo2INj0m3MIqkJ5Yy+Hka5l
         91Vzi4Sh12KPBvNdoDVseXJ8XImSTsHvHgxl1mjWyNX1NiBXp6TXLASbXoCYojZTho
         fWsxx0u8DDH5w==
Date:   Wed, 9 Nov 2022 18:13:12 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v4 14/16] timer: Implement the hierarchical pull model
Message-ID: <20221109171312.GC300561@lothringen>
References: <20221104145737.71236-1-anna-maria@linutronix.de>
 <20221104145737.71236-15-anna-maria@linutronix.de>
 <20221108104738.GA21669@lothringen>
 <9496e1a6-d1-1a20-c1c9-2bc3f34eb888@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9496e1a6-d1-1a20-c1c9-2bc3f34eb888@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 06:02:11PM +0100, Anna-Maria Behnsen wrote:
> On Tue, 8 Nov 2022, Frederic Weisbecker wrote:
> 
> > On Fri, Nov 04, 2022 at 03:57:35PM +0100, Anna-Maria Behnsen wrote:
> > > @@ -1859,6 +1863,36 @@ void forward_and_idle_timer_bases(unsigned long basej, u64 basem,
> > >  	 */
> > >  	is_idle = time_after(nextevt, basej + 1);
> > >  
> > > +	if (is_idle) {
> > > +		u64 next_tmigr;
> > > +
> > > +		next_tmigr = tmigr_cpu_deactivate(tevt->global);
> > > +
> > > +		tevt->global = KTIME_MAX;
> > > +
> > > +		/*
> > > +		 * If CPU is the last going idle in timer migration
> > > +		 * hierarchy, make sure CPU will wake up in time to handle
> > > +		 * remote timers. next_tmigr == KTIME_MAX if other CPUs are
> > > +		 * still active.
> > > +		 */
> > > +		if (next_tmigr < tevt->local) {
> > > +			u64 tmp;
> > > +
> > > +			/* If we missed a tick already, force 0 delta */
> > > +			if (next_tmigr < basem)
> > > +				next_tmigr = basem;
> > > +
> > > +			tmp = div_u64(next_tmigr - basem, TICK_NSEC);
> > > +
> > > +			nextevt = basej + (unsigned long)tmp;
> > > +			tevt->local = next_tmigr;
> > > +			is_idle = time_after(nextevt, basej + 1);
> > 
> > So after that, tevt->global shouldn't matter anymore for tick_nohz_next_event(),
> > right? If so then probably that line can go away (with a comment specifying why we can
> > ignore the global part)?:
> > 
> >        tevt.local = min_t(u64, tevt.local, tevt.global);
> > 
> 
> tevt->global is set to KTIME_MAX anyway. So the whole tevt information is
> also no longer required in tick_nohz_next_event(). I need to rework the
> patch where this was introduced. Then the forward_and_idle_timer_bases()
> could still simply return the next timer and then there is no longer a
> point against using your idea with naming of the functions.

You got it! ;-)
