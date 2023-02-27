Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91CC6A467A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjB0PxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjB0PxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:53:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2E014203
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 07:53:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A773B60EA5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 15:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6D4C433EF;
        Mon, 27 Feb 2023 15:53:11 +0000 (UTC)
Date:   Mon, 27 Feb 2023 10:53:10 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Schspa Shi <schspa@gmail.com>, linux-kernel@vger.kernel.org,
        cocci@inria.fr, mcgrof@kernel.org,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        buytenh@wantstofly.org, johannes.berg@intel.com,
        gregkh@linuxfoundation.org, tomba@kernel.org, airlied@gmail.com,
        daniel@ffwll.ch
Subject: Re: [RFC PATCH] cocci: cpi: add complete api check script
Message-ID: <20230227105310.08d9a46e@gandalf.local.home>
In-Reply-To: <Y/zPv+L2iqOkD2Oa@hirez.programming.kicks-ass.net>
References: <20230227075346.69658-1-schspa@gmail.com>
        <Y/yR/LypvJQXRhAr@hirez.programming.kicks-ass.net>
        <20230227102808.2cea9705@gandalf.local.home>
        <Y/zPv+L2iqOkD2Oa@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2023 16:43:59 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Feb 27, 2023 at 10:28:08AM -0500, Steven Rostedt wrote:
> 
> > So what exact race are you trying to catch here?  
> 
> on-stack copmletion with a wait_for_completion that can return early
> (eg. killable, interruptible, or timeout) can go out of scope (eg, free
> the completion) with the other side calling complete() on some possibly
> re-used piece of stack.
> 
> IOW, Use-after-Free.
> 
> Care must be taken to ensure the other side (whatever does complete())
> is either terminated or otherwise stopped from calling complete() on an
> out-of-scope variable.

I got that. But as you were stating as well, when care is taken, the script
appears to still report it. The example I gave has:

        req = blk_mq_alloc_request(q, REQ_OP_DRV_OUT, 0);
[..]
        req->end_io_data = &wait;
[..]
        hba->tmf_rqs[req->tag] = req;
[..]
        err = wait_for_completion_io_timeout(&wait,
[..]
        spin_lock_irqsave(hba->host->host_lock, flags);
        hba->tmf_rqs[req->tag] = NULL;
        __clear_bit(task_tag, &hba->outstanding_tasks);
        spin_unlock_irqrestore(hba->host->host_lock, flags);


And where the complete is:

        spin_lock_irqsave(hba->host->host_lock, flags);
        pending = ufshcd_readl(hba, REG_UTP_TASK_REQ_DOOR_BELL);
        issued = hba->outstanding_tasks & ~pending;
        for_each_set_bit(tag, &issued, hba->nutmrs) {
                struct request *req = hba->tmf_rqs[tag];
                struct completion *c = req->end_io_data;
 
                complete(c);
                ret = IRQ_HANDLED;
        }
        spin_unlock_irqrestore(hba->host->host_lock, flags);

So the spinlock is making sure that the complete() only works on a
completion if it is still there.

I guess I should have asked, how is this script differentiating between
where there's a problem and where there isn't.

If you remove the spinlocks, then there would most definitely be a race,
and I'm not even sure if the supplied patch would improve this much.

-- Steve

