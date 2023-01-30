Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A8B680C9E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 12:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236220AbjA3L5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 06:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbjA3L5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 06:57:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C332B17CF2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 03:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YEuLpyr1TFwAE2iDDlIo8sI/GlGMh4pgtBpr41lcQrg=; b=Jb51256Y486dJcgCTDFrwFQRzH
        f9dlUl3IKLS41mqn/iUPJaEplCGf8R0jaPVsZTSHL+cnWrA3figPzJhOk2mmyk09jOMjPFCvZzVvX
        FeERVfG7DR8wShu0vQ3Apske+ZXdt/6yBLAV/fQ/FC0Y4ytrv/FeT4O4CYodzOK/Z3fgSSELDDgAz
        +18vqtvJdQek5WA94sUpslK0EJNyO9OpE3XzlAy3DGBIkkT/lBVNtIuxVZ+q86Gj1wowlYuxb8/L9
        E0JC4eZXqEKLFvpJ71VSpqXrsdvK0uEoMLatx7tIBjTzFUEfDiWVkYX0RnJ5RUgLgOAxEwYxGJ/0s
        b5QuAMvw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMSmA-00AKMV-Om; Mon, 30 Jan 2023 11:56:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A1D49300033;
        Mon, 30 Jan 2023 12:56:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 72C99238936D8; Mon, 30 Jan 2023 12:56:40 +0100 (CET)
Date:   Mon, 30 Jan 2023 12:56:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>, Phil Auld <pauld@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched: Store restrict_cpus_allowed_ptr() call state
Message-ID: <Y9eweBuHFeO1jZCH@hirez.programming.kicks-ass.net>
References: <20230127015527.466367-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127015527.466367-1-longman@redhat.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 08:55:27PM -0500, Waiman Long wrote:
> The user_cpus_ptr field was originally added by commit b90ca8badbd1
> ("sched: Introduce task_struct::user_cpus_ptr to track requested
> affinity"). It was used only by arm64 arch due to possible asymmetric
> CPU setup.
> 
> Since commit 8f9ea86fdf99 ("sched: Always preserve the user requested
> cpumask"), task_struct::user_cpus_ptr is repurposed to store user
> requested cpu affinity specified in the sched_setaffinity().
> 
> This results in a slight performance regression on an arm64
> system when booted with "allow_mismatched_32bit_el0"

Dude, how can you still call this a slight performance regression after
Will told you time and time again that's not the problem.

It clearly is a behavioural problem.
