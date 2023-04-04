Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D7A6D602C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbjDDMWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbjDDMWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:22:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687C246B2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 05:21:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 337ED632DC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 12:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B9FC433D2;
        Tue,  4 Apr 2023 12:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680610904;
        bh=D+kOVIeVc8YgEs6zZB4OAQ3HDC8JkWUJQbH5kV7n+8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TCsbsTESfMp+Y8BMSGc/iKIc7y5qj7oBTKJCcn0SGTyNN6wREmTpeTAhwGFSwcJvl
         g4KpPRKGY+Gh+57T9XpIUiZKf1Ga5L7E3Gmgh6tWmhsim47KJ9LEUXv7Jd5PcD9+cP
         UP4FC+oAMMnfm/dzilPblsf1c7mu5B9CF7/N82DclTi6qu8BUItZwNm7Df7dwl/Avj
         Oso3OgU6TAJuY2Bxzy3kXMdFFjstsoZlCCOpPPPgkpqTEQZWdKvgDpuq/Bvwbcg+5M
         LaB7nq6lzHtzNgcgn4tg/T40eXohVtlxeyda3RotJ4FPcYGfCB87wN+9ZFfB1dJLeZ
         qCV7BQbmTqIiA==
Date:   Tue, 4 Apr 2023 14:21:39 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Victor Hassan <victor@allwinnertech.com>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        jindong.yue@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tick/broadcast: Do not set oneshot_mask except
 was_periodic was true
Message-ID: <ZCwWUyUkcC9PZlij@lothringen>
References: <20230328063629.108510-1-victor@allwinnertech.com>
 <ZCqp02hiCell/5AR@lothringen>
 <b187d221-228a-f032-8c93-16e148ec49ca@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b187d221-228a-f032-8c93-16e148ec49ca@allwinnertech.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 07:37:06PM +0800, Victor Hassan wrote:
> > 
> > Leading to such race:
> > 
> > * CPU 1 stop its tick, next event is in one hour
> > * CPU 0 registers new broadcast and sets CPU 1 in tick_broadcast_oneshot_mask
> > * CPU 1 runs into cpuidle_enter_state(), and tick_broadcast_enter() is ignored because
> >    the CPU is already in tick_broadcast_oneshot_mask
> 
> Yes.
> 
> > * CPU 1 goes to sleep
> > * CPU 0 runs the broadcast callback, sees that the next timer for CPU 1
> >    is in one hour, program the broadcast to that deadline
> > * CPU 1 gets an interrupt that enqueues a new timer expiring in the next jiffy
> > * CPU 1 don't call tick_broadcast_exit and thus don't remove itself from
> >    tick_broadcast_oneshot_mask
> 
> I'm not sure about this... Actually, I believe CPU 1 *will* call
> tick_broadcast_exit in this condition because I cannot find a limitation on
> this execution path.

You're right, what I wrote doesn't make sense. Let me try again:

* CPU 1 stop its tick, next event is in one hour. It calls
  tick_broadcast_enter() and goes to sleep.
  
* CPU 1 gets an interrupt that enqueues a new timer expiring in the next jiffy
  (note it's not yet actually programmed in the tick device)
  
* CPU 1 call tick_broadcast_exit().

* CPU 0 registers new broadcast device and sets CPU 1 in tick_broadcast_oneshot_mask

* CPU 0 runs the broadcast callback, sees that the next timer for CPU 1
  is in one hour (because the recently enqueued timer for CPU 1 hasn't been programmed
  yet), so it programs the broadcast to that 1 hour deadline.

* CPU 1 runs tick_nohz_idle_stop_tick() which eventually writes and program
  dev->next_event to next jiffy
  
* CPU 1 runs into cpuidle_enter_state(), and tick_broadcast_enter() is ignored because
  the CPU is already in tick_broadcast_oneshot_mask, so the dev->next_event
  change isn't propagated to broadcast.

* CPU 1 goes to sleep for 1 hour.

Does it make more sense? There might be more simple scenario of course.

Thanks.
