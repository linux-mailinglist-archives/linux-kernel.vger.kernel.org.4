Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362016F706D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjEDRG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEDRG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:06:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CD32719
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:06:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB8ED60BFB
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 17:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79785C433D2;
        Thu,  4 May 2023 17:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683220014;
        bh=Vg245Ve3enU1Q9fQg9Hb4lm+gMTGeaBK1zP8+ZEJy6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TNn9bEg4S57lrpz5t7yP0PTLGS6ElbTW/an7qdcn7/bwJGwGBM8vhfLjCpBHAmc4i
         4gbYLNUkcPxOhzDJ+H4lakU99K/V7R1wn6SrsY3kQLHZDQJ7+cvnYh8BUAI8IMW2ms
         aRmaA/2Crq2IsbDWhq92XZCRjTA6qv22lz2jDp1TtfRHKxh2FLcsT+VML1kV8DdIMv
         VDHVuReoVaErj6GyCrxZBWTQCAiomKGbTuQNjUC4Yj+qRM3eX4BLx4lK6TcWljnbnk
         soNfVeFzZzimvllpHrh35Mxdg8LnBgDG79PsbnpyNqrNvKEhcaMFNg/0NCOTqTs8Hi
         S+gczJDrCBYnA==
Date:   Thu, 4 May 2023 19:06:50 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [patch 01/20] posix-timers: Prevent RT livelock in
 itimer_delete()
Message-ID: <ZFPmKtFGPUQkeDEd@localhost.localdomain>
References: <20230425181827.219128101@linutronix.de>
 <20230425183312.862346341@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230425183312.862346341@linutronix.de>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Apr 25, 2023 at 08:48:56PM +0200, Thomas Gleixner a écrit :
> itimer_delete() has a retry loop when the timer is concurrently expired. On
> non-RT kernels this just spin-waits until the timer callback has
> completed. On RT kernels this is a potential livelock when the exiting task
> preempted the hrtimer soft interrupt.
> 
> This only affects hrtimer based timers as Posix CPU timers cannot be
> concurrently expired. For CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y this is
> obviously impossible as the task cannot run task work and exit at the same
> time. The CONFIG_POSIX_CPU_TIMERS_TASK_WORK=n (only non-RT) is prevented
> because interrupts are disabled.

But the owner of the timer is not the same as the target of the timer, right?

Though I seem to remember that we forbid setting a timer to a target outside
the current process, in which case the owner and the target are the same at
this exit stage. But I can't remember what enforces that permission in pid_for_clock()...

Thanks.
