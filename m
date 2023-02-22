Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50C469F5BE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 14:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjBVNgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 08:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjBVNge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 08:36:34 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D379B3ABE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 05:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6Qd62Z9xyLIVfwSbP4xLMelOZ06oP0/w0wP8oeqN4vA=; b=DzcAM3/U49ghmdaUAF6wI6ys7j
        dbCU2CMrJKpnhJI8aEGS5mMFMuM/MNzzX+GTDsDLfR3/ipkC7tQ+3RVERoZw+Is/yfBn3mSei3qUr
        kDp2ZlT3C8Hn90a8WaYwIsLkPIOfnAnmku41ifoMHWhMkNoY2Ff1DVHhKhqn+7GCMapVmKH9qPspK
        ytIz2gz9HWeZMstj9oekVlyjeWLOuSacN5aCQ7K5MItxKPocAJNHjFFytRrq12sebrXqlyGaPXqga
        pFBB90HwABkb/ort4vWR/nFaDDLf58u6Iv4G11NmvNf/VojY7gvs98eo/ROwt1cRQ7X6YeAjxAT11
        ns1Kf6Jg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pUpI8-00CYLy-12;
        Wed, 22 Feb 2023 13:36:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 60D16300033;
        Wed, 22 Feb 2023 14:36:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2F8E220DD8093; Wed, 22 Feb 2023 14:36:14 +0100 (CET)
Date:   Wed, 22 Feb 2023 14:36:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched: Consider task_struct::saved_state in
 wait_task_inactive().
Message-ID: <Y/YaTojZ1stY2fAO@hirez.programming.kicks-ass.net>
References: <Y++UzubyNavLKFDP@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y++UzubyNavLKFDP@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 03:53:02PM +0100, Sebastian Andrzej Siewior wrote:
> wait_task_inactive() waits for thread to unschedule in a certain task state.
> On PREEMPT_RT that state may be stored in task_struct::saved_state while the
> thread, that is being waited for, blocks on a sleeping lock and
> task_struct::__state is set to TASK_RTLOCK_WAIT.
> It is not possible to check only for TASK_RTLOCK_WAIT to be sure that the task
> is blocked on a sleeping lock because during wake up (after the sleeping lock
> has been acquired) the task state is set TASK_RUNNING. After the task in on CPU
> and acquired the pi_lock it will reset the state accordingly but until then
> TASK_RUNNING will be observed (with the desired state is saved in saved_state).
> 
> Check also for task_struct::saved_state if the desired match was not found in
> task_struct::__state on PREEMPT_RT. If the state was found in saved_state, wait
> until the task is idle and state is visible in task_struct::__state.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
> ---

Which if the very few wait_task_inactive() users requires this?
