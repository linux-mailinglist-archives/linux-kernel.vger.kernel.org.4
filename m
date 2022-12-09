Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40CD64817B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 12:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiLILRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 06:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiLILRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 06:17:44 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCF162F1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 03:17:39 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B94pTC1003426;
        Fri, 9 Dec 2022 05:16:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=9atow78hvykn5Vc3eFPeIJmOcg6TT3MeuElSx9jZL9Y=;
 b=VpfH8//R6XBbHi9Y8tCgtCV8D0VLsXUP54Wa6q9iRimlIkqP11GbAe4zfZV5gah+Y2Mx
 knTIJldUtikSm5YzkPgz1K384fH1dC08FXqI6i5eFK74aJmGGjhZVMDF1zi2y09ZL29p
 2KHMKPWTjNo/JucvIOa0C5CTwur4jts2BwQtBsphzLoNYIpxkqQNEEr9r2UpU+KPK1JC
 SKq8CDcsyJ6y10i4T67wAWFbyK57xC7McdyFe3vXN8gI47j07X8u1xA1E+PIJ3zB1t6E
 iUQxcj8VtMVZ2fo3DYgcJsi4Ui4TMOJnlcCE28vj4gaADTlZO8j43jNm+l2Xc36XaYeK aQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3m84r6pvxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Dec 2022 05:16:42 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Fri, 9 Dec
 2022 05:16:40 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.20 via Frontend Transport; Fri, 9 Dec 2022 05:16:40 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5642DB0E;
        Fri,  9 Dec 2022 11:16:40 +0000 (UTC)
Date:   Fri, 9 Dec 2022 11:16:40 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] ASoC: wm8994: Fix potential deadlock
Message-ID: <20221209111640.GK105268@ediswmail.ad.cirrus.com>
References: <CGME20221209091928eucas1p1cfc768d888a6e6c57fcaa0fe320cfced@eucas1p1.samsung.com>
 <20221209091657.1183-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221209091657.1183-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: JW0C1SuHOfp6VrXwOhVOR80GLDfafi4b
X-Proofpoint-GUID: JW0C1SuHOfp6VrXwOhVOR80GLDfafi4b
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 10:16:57AM +0100, Marek Szyprowski wrote:
> Commit c0feea594e05 ("workqueue: don't skip lockdep work dependency in
> cancel_work_sync()") revealed the following locking issue in the wm8994
> codec:
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.0.0-rc1-00001-gc0feea594e05-dirty #13097 Not tainted
> ------------------------------------------------------
> kworker/1:1/32 is trying to acquire lock:
> c2bd4300 (&wm8994->accdet_lock){+.+.}-{3:3}, at: wm1811_mic_work+0x38/0xdc
> 
> but task is already holding lock:
> f08f5f28 ((work_completion)(&(&wm8994->mic_work)->work)){+.+.}-{0:0}, at: process_one_work+0x1e4/0x778
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 ((work_completion)(&(&wm8994->mic_work)->work)){+.+.}-{0:0}:
>        __cancel_work_timer+0x198/0x22c
>        wm1811_jackdet_irq+0x124/0x238
>        process_one_work+0x288/0x778
>        worker_thread+0x44/0x504
>        kthread+0xf0/0x124
>        ret_from_fork+0x14/0x2c
>        0x0
> 
> -> #0 (&wm8994->accdet_lock){+.+.}-{3:3}:
>        lock_acquire+0x124/0x3e4
>        __mutex_lock+0x90/0x948
>        mutex_lock_nested+0x1c/0x24
>        wm1811_mic_work+0x38/0xdc
>        process_one_work+0x288/0x778
>        worker_thread+0x44/0x504
>        kthread+0xf0/0x124
>        ret_from_fork+0x14/0x2c
>        0x0
> 
> other info that might help us debug this:
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock((work_completion)(&(&wm8994->mic_work)->work));
>                                lock(&wm8994->accdet_lock);
>                                lock((work_completion)(&(&wm8994->mic_work)->work));
>   lock(&wm8994->accdet_lock);
> 
>  *** DEADLOCK ***
> 
> 2 locks held by kworker/1:1/32:
>  #0: c1c072a8 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work+0x1e4/0x778
>  #1: f08f5f28 ((work_completion)(&(&wm8994->mic_work)->work)){+.+.}-{0:0}, at: process_one_work+0x1e4/0x778
> 
> stack backtrace:
> CPU: 1 PID: 32 Comm: kworker/1:1 Not tainted 6.0.0-rc1-00001-gc0feea594e05-dirty #13097
> Hardware name: Samsung Exynos (Flattened Device Tree)
> Workqueue: events_power_efficient wm1811_mic_work
>  unwind_backtrace from show_stack+0x10/0x14
>  show_stack from dump_stack_lvl+0x58/0x70
>  dump_stack_lvl from check_noncircular+0xf0/0x158
>  check_noncircular from __lock_acquire+0x15e8/0x2a7c
>  __lock_acquire from lock_acquire+0x124/0x3e4
>  lock_acquire from __mutex_lock+0x90/0x948
>  __mutex_lock from mutex_lock_nested+0x1c/0x24
>  mutex_lock_nested from wm1811_mic_work+0x38/0xdc
>  wm1811_mic_work from process_one_work+0x288/0x778
>  process_one_work from worker_thread+0x44/0x504
>  worker_thread from kthread+0xf0/0x124
>  kthread from ret_from_fork+0x14/0x2c
> Exception stack(0xf08f5fb0 to 0xf08f5ff8)
> ...
> --->8---
> 
> Fix this by dropping wm8994->accdet_lock while calling
> cancel_delayed_work_sync(&wm8994->mic_work) in wm1811_jackdet_irq().
> 
> Fixes: c0cc3f166525 ("ASoC: wm8994: Allow a delay between jack insertion and microphone detect")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
