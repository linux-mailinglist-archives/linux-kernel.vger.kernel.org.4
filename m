Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B69B733073
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344149AbjFPLwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344696AbjFPLwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:52:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F82199D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n1ta8NR7kXLABeMYbha2SDOE9+G1pC8i6ptannheg7c=; b=Dz2G3Mh+Lk8YOmDh0q55zwY860
        TX26VsbO+nn10vqAWGxwj5e9geNA6X5LW92UTlEaCp9fcEN8WgxOu8ONd5XSfP7ogzzEwKt3u7WnH
        LL69dVdFS27iZtYWGqeXdJ0oup3g9+3ul7v5tpCdIgaEadSJBehKnuyl1nvLOaFf3LfXRvnXvp9/8
        zH56LtzRLM3p5wS9tbRd4tXpQFnVEtblpmDUEr3EYpEM4Y44rajW8i00lotJu5keW13smNK5IJAn6
        Cy8+qWYvEltHKnKeHb1iXOmBJ/xThG0zXNkd1Ye9ZDU9TwMxBQQ03K2gNQ9J5eVt1lTJLKDhhc5IR
        ec/WR4UQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qA7zc-008xqW-NM; Fri, 16 Jun 2023 11:51:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4DB45300208;
        Fri, 16 Jun 2023 13:51:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 210BB2C009B6D; Fri, 16 Jun 2023 13:51:49 +0200 (CEST)
Date:   Fri, 16 Jun 2023 13:51:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [RFC PATCH V3 6/6] sched/fair: Implement starvation monitor
Message-ID: <20230616115149.GK83892@hirez.programming.kicks-ass.net>
References: <cover.1686239016.git.bristot@kernel.org>
 <bd9977efff8cc3e002c4b2db02f611167905a99f.1686239016.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd9977efff8cc3e002c4b2db02f611167905a99f.1686239016.git.bristot@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 05:58:18PM +0200, Daniel Bristot de Oliveira wrote:
> From: Juri Lelli <juri.lelli@redhat.com>
> 
> Starting deadline server for lower priority classes right away when
> first task is enqueued might break guarantees, as tasks belonging to
> intermediate priority classes could be uselessly preempted. E.g., a well
> behaving (non hog) FIFO task can be preempted by NORMAL tasks even if
> there are still CPU cycles available for NORMAL tasks to run, as they'll
> be running inside the fair deadline server for some period of time.
> 
> To prevent this issue, implement a starvation monitor mechanism that

Why should this be prevented?  FIFO can be preempted by a higher
priority FIFO/RR, or in this case by DEADLINE, and always by stop_task.

Just accept this.

Anything that's build around FIFO-99 not getting preempted is just plain
broken. Don't try and pander to broken.
