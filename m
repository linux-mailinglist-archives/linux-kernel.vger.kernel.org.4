Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06A55B86F1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 13:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiINLEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 07:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiINLEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:04:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B82FFD7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 04:04:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B27DB81A3E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 11:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244FBC433D6;
        Wed, 14 Sep 2022 11:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663153469;
        bh=tbx0ApNcuaaHnoKpUSFbEFs9vNYZFNnjuUmTNGNSz84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N6tuKtMG5Wmi2TiNPlqXNBlsCCM7q7I4weRyHU3u7SOpc+dpRiZWg/K4KmkjzcpRg
         BCMAtkSNyStcTOmwtbpvDianxv2Te0aJjOemrRB3hCdd5piRmtOFvbr39TdCoxmphd
         ytgetmLNAQ80hgq5GRNAjPy8rNeidiEdPsXEZVUeTR9PChFvfVrSyoU6rek9ZHflYe
         JRQElf5dlxjXAHMTwF23DENQRw0hZTJTLAFn0Fxl1f3Cz8vFLYj0QnvlCVo4yhhLOF
         U1hR0bUvrYkCgWQVZRJS7LMX7oNnAlwEacKl0afM8jxz4mvhIpomZoTNh+0c1ua5w4
         7PZKF9/UM9V8g==
Date:   Wed, 14 Sep 2022 13:04:26 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>, cl@linux.com,
        tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
        pauld@redhat.com, neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 2/3] tick/sched: Ensure quiet_vmstat() is called when
 the idle tick was stopped too
Message-ID: <20220914110426.GD1936@lothringen>
References: <20220817191346.287594886@redhat.com>
 <20220817191524.201253713@redhat.com>
 <20220909121224.GA220905@lothringen>
 <YxuViCnKcIYVE02B@fuller.cnet>
 <20220912143822.irn6xhs2etmumqlt@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912143822.irn6xhs2etmumqlt@ava.usersys.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 03:38:23PM +0100, Aaron Tomlin wrote:
> On Fri 2022-09-09 16:35 -0300, Marcelo Tosatti wrote:
> Hi Frederic,
> 
> Sorry about that. How about the following:
> 
>  - Note: CPU X is part of 'tick_nohz_full_mask'
> 
>     1.      CPU Y migrated running task A to CPU X that
> 	    was in an idle state i.e. waiting for an IRQ;
> 	    marked the current task on CPU X to need/or
> 	    require a reschedule i.e., set TIF_NEED_RESCHED
> 	    and invoked a reschedule IPI to CPU X
> 	    (see sched_move_task())
> 
>     2.      CPU X acknowledged the reschedule IPI. Generic
> 	    idle loop code noticed the TIF_NEED_RESCHED flag
> 	    against the idle task and attempts to exit of the
> 	    loop and calls the main scheduler function i.e.
> 	    __schedule().
> 
> 	    Since the idle tick was previously stopped no
> 	    scheduling-clock tick would occur.
> 	    So, no deferred timers would be handled
> 
>     3.      Post transition to kernel execution Task A
> 	    running on CPU X, indirectly released a few pages
> 	    (e.g. see __free_one_page()); CPU X's
> 	    'vm_stat_diff[NR_FREE_PAGES]' was updated and zone
> 	    specific 'vm_stat[]' update was deferred as per the
> 	    CPU-specific stat threshold
> 
>     4.      Task A does invoke exit(2) and the kernel does
> 	    remove the task from the run-queue; the idle task
> 	    was selected to execute next since there are no
> 	    other runnable tasks assigned to the given CPU
> 	    (see pick_next_task() and pick_next_task_idle())
> 
>     5.      On return to the idle loop since the idle tick
> 	    was already stopped and can remain so (see [1]
> 	    below) e.g. no pending soft IRQs, no attempt is
> 	    made to zero and fold CPU X's vmstat counters
> 	    since reprogramming of the scheduling-clock tick
> 	    is not required/or needed (see [2])

Much better thanks.

Please cut the patch in two patches: one that fixes the stuff in
the idle path and another one that fixes the return to user path.

The first one is definetly a fix, the second one is rather a feature
that is definetly wanted as well but I need to think it through further.

> 
> 
> 
> Kind regards,
> 
> -- 
> Aaron Tomlin
> 
