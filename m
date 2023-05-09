Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110306FC2FF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbjEIJme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbjEIJmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:42:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4BE3ABB
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 02:42:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B17E62962
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 09:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A89C433D2;
        Tue,  9 May 2023 09:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683625350;
        bh=04pCZDrxyu0T00XmwyXiFwQ5hWnBD+EL4Y1HHpJMI1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vy61Puc9iZiJ/Kk9ZVbJ2bx5dkxA+K1djj2zilU0dH+yhnzXpeROAul+CIC/No+Ky
         MzsOCXW/1lljCO6zGwPBKZLhx/q5k3YbyZ87lLOZ50LCWUqmbugDHCfxI+2xPRjvUi
         JpDLsTpskhMTAK5V2rXA4+eEXxTY05jN+VEymXLYe7EZry4mOUYnD6npFjgzPNpgso
         yI3diXYt75DX39f39euGJiMuHBJDgegGbyC/E33p6XUaUBgL9eowebJT0CwIpDNLCU
         qGZD8NBA8NXsh2+Oqly+JIDOR3DKAN0Qs77STUCnr3/uOvauQKU3AxLJPK5P2CHDk1
         h/zO0ptEvu4Aw==
Date:   Tue, 9 May 2023 11:42:27 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [patch 02/20] posix-timers: Ensure timer ID search-loop limit is
 valid
Message-ID: <ZFoVg9UmItpIaA69@lothringen>
References: <20230425181827.219128101@linutronix.de>
 <20230425183312.932345089@linutronix.de>
 <ZFUXrCZtWyNG3Esi@lothringen>
 <87zg6i2xn3.ffs@tglx>
 <87v8h62vwp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8h62vwp.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 06, 2023 at 01:36:22AM +0200, Thomas Gleixner wrote:
> On Sat, May 06 2023 at 00:58, Thomas Gleixner wrote:
> > On Fri, May 05 2023 at 16:50, Frederic Weisbecker wrote:
> > So the whole thing works like this:
> >
> >    start = READ_LOCKLESS(sig->next_id);
> >
> >    // Enfore that id and start are different to not terminate right away
> >    id = ~start;
> >
> > loop:
> >    if (id == start)
> >    	goto fail;
> >    lock()
> >         id = sig->next_id;                      <-- stable readout
> >         sig->next_id = (id + 1) & INT_MAX;      <-- prevent going negative
> >
> >         if (unused_id(id)) {
> >            add_timer_to_hash(timer, id);
> >            unlock();
> >            return id;
> >         }
> >    id++;
> >    unlock();
> >    goto loop;
> >
> > As the initial lockless readout is guaranteed to be in the positive
> > space, how is that supposed to be looping forever?
> 
> Unless you think about the theoretical case of an unlimited number of
> threads sharing the signal_struct which all concurrently try to allocate
> a timer id and then releasing it immediately again (to avoid resource
> limit exhaustion). Theoretically possible, but is this a real concern
> with a timer ID space of 2G?

I didn't go that far actually, it was just me misunderstanding that loop and
especially the (id =~start) part. Now I got it.

I guess the for statement can just be:

for (; start != id; id++)

> 
> I'm sure that it's incredibly hard to exploit this, but what's really
> bothering me is the hash table itself. The only reason why we have that
> is CRIU.
> 
> The only alternative solution I could come up with is a paritioned
> xarray where the index space would be segmented for each TGID, i.e.
> 
>        segment.start = TGID * MAX_TIMERS_PER_PROCESS
>        segment.end    = segment.start + MAX_TIMERS_PER_PROCESS - 1
> 
> where MAX_TIMERS_PER_PROCESS could be a copius 2^16 which would work for
> both 32bit and 64bit TID limits.
> 
> That would avoid the hash table lookups and the related issues, but OTH
> it would require to allocate one extra page per TGID if the application
> uses a single posix timer.
> 
> Not sure whether that's worth it though.

Not sure either...

Thanks.
