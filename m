Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459216332BF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 03:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbiKVCHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 21:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbiKVCHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 21:07:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDCAAE7A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 18:07:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4958EB8136A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB45C433C1;
        Tue, 22 Nov 2022 02:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669082855;
        bh=+16kGjj1j4gE3sROSy2tGl8ILXMMJJCvpewesosGAUY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cHMLWcEi9hAdasUtUyFrd/B7thHrkejnpMj72e88A4aYESVzcw4zhgP3W/6Iu8TwL
         oAtu5Wj32ibNyGffYPugb3/OJtO1nsNQRTTG6E4JjbzmteWsz686TYaHCRUx9xM05q
         pxA/P+Z0HFZh3TNor6hXrE3dVXlfe/6MAfHzLGwq0Tzdr7wRQvQ4pX5giMSl4owCl9
         vWrut7ceFMQFA6lbkHssGunsJHRilXquNy9hiH754W4sRpgOLjAY2bWI7oelYDdUVJ
         taiuNAe2tEyNr8IGtuH02bKwzKuLXg1bal7VPuAkkw51jOAEWsyD5OrktXz0Lzc3ID
         wab5Y3N+5Q1ww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 91B645C0641; Mon, 21 Nov 2022 18:07:34 -0800 (PST)
Date:   Mon, 21 Nov 2022 18:07:34 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
        LKML <linux-kernel@vger.kernel.org>, phillip.lougher@gmail.com,
        Thorsten Leemhuis <regressions@leemhuis.info>, elliott@hpe.com
Subject: Re: BUG: BISECTED: in squashfs_xz_uncompress() (Was: RCU stalls in
 squashfs_readahead())
Message-ID: <20221122020734.GD4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <9697fcf5-4213-3d5e-176a-e82d4bd07870@alu.unizg.hr>
 <eac8af79-8936-f845-c8dd-c63ebf0d5e81@alu.unizg.hr>
 <02877aee-8c05-6534-8a91-94ba366d0276@squashfs.org.uk>
 <20221118155534.GJ4001@paulmck-ThinkPad-P17-Gen-1>
 <dd430080-774b-1cba-1758-2bf92cb1acac@alu.unizg.hr>
 <20221120175016.GC4001@paulmck-ThinkPad-P17-Gen-1>
 <8e62a31f-3ef8-71ec-6181-2afa56eeb5db@alu.unizg.hr>
 <20221120192150.GE4001@paulmck-ThinkPad-P17-Gen-1>
 <8c9eb87b-5623-730a-5cf6-72d831ef797a@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c9eb87b-5623-730a-5cf6-72d831ef797a@alu.unizg.hr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 05:04:36AM +0100, Mirsad Goran Todorovac wrote:
> On 20. 11. 2022. 20:21, Paul E. McKenney wrote:
> > > And what about the Mr. Robert Elliott's observation about calling conf_recshed()?
> > > 
> > > > How big can these readahead sizes be? Should one of the loops include
> > > > cond_resched() calls?
> > > 
> > > That is IMHO better than allowing 21000 milisecond stalls on a core (or more of them).
> > > 
> > > I don't think it is correct to stay in kernel mode for more than an timer unit
> > > without yielding the CPU. It creates stalls in multimedia and audio (chirps like on scratched
> > > CD-ROMs). This is especially noticeable with a KASAN build.
> > > 
> > > Since Firefox and most snaps are using squashfs as compressed ROFS, the Firefox appears
> > > to perform poorer since snaps are introduced than Chrome.
> > > 
> > > IMHO, if we want something like realtime and multimedia processing (which is the specific
> > > area of my research), it seems that anything trying to hold processor for 21000 ms (21 secs)
> > > is either buggy or deliberately malicious. 20 ms is quite enough of work for a threat
> > > in one allotted timeslot.
> > > 
> > > I do not agree with Mr. Lougher's observation that I am thrashing my laptop. I think that
> > > a system has to endure stress and torture testing. I was raised on Digital MicroVAX systems
> > > on Ultrix which compiled lab at a time in memory that would today sound funny. :)
> > 
> > I personally think that it would be great if you were to work to decrease
> > the Linux kernel's latency.  Doing so would not be fixing a regression,
> > but I personally would welcome it.  Others might have different opinions,
> > but please do CC me on any resulting patches.
> > 
> > And I will see your MicroVAX and raise you a videogame written on a
> > PDP-12 whose fastest instruction executed in 1.6 microseconds (-not-
> > nanoseconds!).  ;-)
> 
> I'm afraid that I would lose in Far Cry miserably if my cores
> decided to all lock up for 21 secs. :-(

Agreed, 21 seconds is an improvement over the earlier 60 seconds, but
still a very long time.  Me, I come from DYNIX/ptx, where the equivalent
to the RCU CPU stall warning was 1.5 seconds.  On the other hand, it
is also the case that DYNIX/ptx had nowhere near the variety of drivers
and subsystems, nor did it scale anywhere near as far as Linux does today.

But you only need one CPU to lock up for 21 seconds to get an RCU CPU
stall warning, not all of them.  ;-)

> > You can can see a couple of people playing the game on a PDP-12 in
> > a computer museum: https://www.rcsri.org/collection/pdp-12/
> > 
> > > Besides, this is the very idea behind the MG-LRU algorithm commit, to test eviction of
> > > memory pages in the system with heavy load and low on memory.
> > > 
> > > I will probably test your commits, but now I have to do my own evening ritual, unwinding,
> > > and knowledge and memory consolidation (called "sleep").
> > 
> > And yes, sleep is often one of the best debugging tools available.
> > 
> > > I appreciate your lots of commits on the kernel.org and I hope I do not sound like
> > > I am thinking you are a village idiot :(
> > > 
> > > I am trying to adhere to the Code of Conduct with mutual respect and politeness.
> > 
> > Skepticism is not necessarily a bad thing, especially given that I
> > am not immune from errors and confusion.  Me, I just thought you were
> > forcefully reporting the regression, so I forcefully pointed you at the
> > fix for that regression.
> > 
> > Again, I have absolutely no objection to your improving the kernel's
> > response time.
> 
> This is at present just the wishful thinking, as I lack your 30 years of
> experience with the kernel and RCU update system. I am only beginning to realise
> why it is more efficient than the traditional locking, and IMHO it should
> avoid locking up cores instead of increasing the number of complaints.

Just to set the record straight, RCU does not normally lock up any of
the cores.  Instead, RCU detects that cores have been locked up.

Give or take the occasional bug in RCU, of course!

> But even if the Linux kernel source is magically "memory mapped" into my
> mind, I still do not see how it could be done. My Linux kernel learning curve
> had not yet got that up, but I have no doubts that it is designed by
> Intelligent Designers who are very witty people, and not village idiots ;-)

There is the school of thought that claims that the Linux kernel is
driven by evolutionary forces rather than intelligent design.  And as
we all know, evolutionary forces are driven by random changes, which
absolutely anyone could make.

And one approach is to take a less aggressive RCU CPU stall timeout,
say reducing from 21 seconds to (say) 15 seconds instead of all the
way down to 20 milliseconds.  This could allow you to ease into the
latency-reduction work.

Alternatively, consider that response time is a property of the
entire system plus the environment that it runs in.  So I suspect that
the Android folks are accompanying that 20-millisecond timeout with
some restrictions on what the on-phone workloads are permitted to do.
Maybe ask the Android guys what those restrictions are and loosen them
slightly, again allowing you to ease into the latency-reduction work.

> > > I know that the Linux kernel is about 30 million lines by now, and by the security experts
> > > we should expect 30,000 bugs in such a solid piece of written code (one per thousand of
> > > lines). Only Mr. Thorsten mentioned 950 unresolved in the "open" list.
> > 
> > At least 30,000 bugs, of which we know of maybe 950.  ;-)
> 
> So I need no point in banning the kernel from screaming to logs that it had
> core stalls that needed a physical NMI to recover from, or they would potentially
> last much longer.

Sometimes an NMI does get the CPUs back on track.  Sometimes the RCU CPU
stall warning is a symptom of the CPU having gotten too old and failing.
Most often, though, it is a sign of some sort of lockup, a too-long
RCU read-side critical section, or as Robert Elliot noted, the lack of
a cond_resched().

But please keep in mind that cond_resched() helps only in kernels built
with CONFIG_PREEMPTION=n.

> > > Knowing all of this is difficult, but I still believe in open source and open systems
> > > interconnected.
> > 
> > If it was easy, where would be the challenge?
> 
> AFAIK, the point I was taught in life was obedience, not overcoming challenges.

Perhaps early in life I was ordered to overcome challenges?  If so, then
my overcoming them would be a matter of obedience.  ;-)

> > > Of course, I always remember a proverb "Who hath despised the day of the small beginnings?"
> > > 
> > > Hope this helps. My $0.02.
> > 
> > I think we are good.   ;-)
> 
> Yes, you guys do an amasing job of keeping 30 million lines of code organised
> and making some sense. I will cut the smalltalk as I know you are a busy man.
> If I make a progress to actually produce any patches fixing these lockups and
> stalls, I will be sure to include you into CC: as you requested.

Looking forward to seeing what you come up with!

							Thanx, Paul
