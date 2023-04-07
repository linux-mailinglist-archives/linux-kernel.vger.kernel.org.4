Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EB16DB591
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 23:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjDGVAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 17:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjDGVAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 17:00:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997D8199B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 14:00:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34D8E651CA
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 21:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3986EC433D2;
        Fri,  7 Apr 2023 21:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680901235;
        bh=NG9cVPo8jYKrgpxNTOWvWnfRF3Zeu8y+oexjDO79R7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ji09rthdzminTO655oWSPyu9AOv9VJGdc9qkH42nxaQU0HHZ4FnknDYVWBG5KsMSm
         /6002nlAwZ4Ti2BA1BSmAwTJrKfdyAmDiK7dOdKU87ES1THS5kJmWJ+iEsSAglSAhm
         i9+lVEMJb8z+mxIA47qYODiMVCNBWQhYo+VTQD5w7LHA6DCcctbhjMJ3jW3y0pfoF1
         F1ER3qEObJUw3lVItGkneltZ160gYEpU8d+ZsajEGenJUvwpNJBBNFtT97GQqbDn29
         6CNOig7iKa4eNjfTeZeDJckY9ijavFZmSNILXgoxJwfnDOzhbWBI302g5pYgUR9hxi
         /nCD1fCwOeUOA==
Date:   Fri, 7 Apr 2023 23:00:32 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Marco Elver <elver@google.com>,
        syzbot <syzbot+3b14b2ed9b3d06dcaa07@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: WARNING in timer_wait_running
Message-ID: <ZDCEcNb8KATIjvBv@localhost.localdomain>
References: <87h6tsred7.ffs@tglx>
 <874jpsqdy1.ffs@tglx>
 <ZDADdMnY0oW2k5BV@lothringen>
 <87lej3twhv.ffs@tglx>
 <ZDBin2ZQwc69hGX4@lothringen>
 <87ile7trv7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ile7trv7.ffs@tglx>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Fri, Apr 07, 2023 at 09:27:40PM +0200, Thomas Gleixner a écrit :
> On Fri, Apr 07 2023 at 20:36, Frederic Weisbecker wrote:
> 
> > On Fri, Apr 07, 2023 at 07:47:40PM +0200, Thomas Gleixner wrote:
> >> On Fri, Apr 07 2023 at 13:50, Frederic Weisbecker wrote:
> >> > On Fri, Apr 07, 2023 at 10:44:22AM +0200, Thomas Gleixner wrote:
> >> >> Now memory came back. The problem with posix CPU timers is that it is
> >> >> not really known to the other side which task is actually doing the
> >> >> expiry. For process wide timers this could be any task in the process.
> >> >> 
> >> >> For hrtimers this works because the expiring context is known.
> >> >
> >> > So if posix_cpu_timer_del() were to clear ctmr->pid to NULL and then
> >> > delay put_pid() with RCU, we could retrieve that information without
> >> > holding the timer lock (with appropriate RCU accesses all around).
> >> 
> >> No, you can't. This only gives you the process, but the expiry might run
> >> on any task of that. To make that work you need a mutex in sighand.
> >
> > Duh right missed that. Ok will try.
> 
> But that's nasty as well as this can race against exec/exit and you can't
> hold sighand lock when acquiring the mutex.
> 
> The mutex needs to be per task and held by the task which runs the
> expiry task work.
> 
> Something like the completely untested below. You get the idea though.

For something untested, it looks quite right!

Thanks.
