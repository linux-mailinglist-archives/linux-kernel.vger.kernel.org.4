Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29366DAEF1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 16:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjDGOtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 10:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjDGOtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 10:49:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF014EFA
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 07:49:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 385F6643E7
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 14:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D89C433D2;
        Fri,  7 Apr 2023 14:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680878952;
        bh=IDdQomgjknpoAmNRk2aB7/J+4qn0d8niwJ2SPw4ROrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ahv9JidkOairIef7uQR13Ery2b8NUjOLMCoEy5/1i4UidFSsKOK8nyundoEUb7vzO
         5/CPevK5QZOTGQJzjXPNn/u9axgRZq1k2UmB4TotsnKTUGoZKkmskxIaO1ZY4NHgMS
         8e2imISv+b55favesSL6u5d7zXGA6aLZtm51brnnrsN5g15UIWADIDXLEk2wtTPoNg
         TYjhNR1tbugpkJVM5wcHj3IBAFYGjYZz7SqOy0P4IZI3/rIDqO0qdLnllbo5AwOtlE
         h8tM+PelMmWPcipSEHY9NZ+gBgtzKFEHZCgJbdIJKFgE52ETDVR5wqy1FDzouAxEfS
         3RhNw5tG3aYWw==
Date:   Fri, 7 Apr 2023 16:49:09 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Marco Elver <elver@google.com>,
        syzbot <syzbot+3b14b2ed9b3d06dcaa07@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: WARNING in timer_wait_running
Message-ID: <ZDAtZWrly6Hzieip@lothringen>
References: <000000000000566d5405ae2f6f70@google.com>
 <20230407134620.1034-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407134620.1034-1-hdanton@sina.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 09:46:20PM +0800, Hillf Danton wrote:
> On 5 Apr 2023 23:07:24 +0200 Marco Elver <elver@google.com>
> > On Mon, Aug 31, 2020 at 10:07AM -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    1127b219 Merge tag 'fallthrough-fixes-5.9-rc3' of git://gi..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1501768e900000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=978db74cb30aa994
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3b14b2ed9b3d06dcaa07
> > 
> > Dashboard has recent reports (also below) and reproducer (also attached).
> 
> My 2c, with PREEMPT_RT enabled it simply waits by taking timer->it_lock.
> 
> --- upstream/kernel/time/posix-cpu-timers.c
> +++ y/kernel/time/posix-cpu-timers.c
> @@ -1613,6 +1613,21 @@ static int thread_cpu_timer_create(struc
>  	return posix_cpu_timer_create(timer);
>  }
>  
> +static void posix_cpu_timer_wait_running(struct k_itimer *timer)
> +{
> +#ifdef CONFIG_PREEMPT_RT
> +	int stop = 0;
> +
> +	while (!stop) {
> +		spin_lock(&timer->it_lock);
> +		stop = timer->it.cpu.firing == 0;
> +		spin_unlock(&timer->it_lock);
> +	}

No, because there is a whole lot of preemptible area with timer->it_lock
not held between the time ctmr->firing is set to 1, and the actual handling
of that timer that holds the lock.

So no priority inheritance in that case.

There has to be a lock between the time it is set to 1 and the handling
of the timer.
