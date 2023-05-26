Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C5B71292F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243720AbjEZPNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjEZPNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:13:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2C4E7
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 08:13:39 -0700 (PDT)
Date:   Fri, 26 May 2023 17:13:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685114017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iIhbo7U5bYYA5D+nU5U/U0dXC0GGh8X5zoP3O7uKmOg=;
        b=Ayk/N/FMLAjF+gSUoME7I8Mjhyz0Wz3K0GAY9agEM4mUZO8rqKWD6SRZl4sFiWydoY3D4f
        1hKYiEoWTOT5RNNQUtd8dlcBN7xk2X3XfjDLIDwTIa1L0e6UUe6aJ1PKCSZplcUlWFjXbn
        fGbVaJPJRC2fV+yv9DIlekb3ExvH4/g1Uk2+UK/Du4OQc5h/iT/MnXrbOnRXq+OnwGDjJt
        UyasWa0CJChrcKXq7my9A+8nJY+GFbnZ6J/oeTqyy2OMy/ucch1053ti9tk7XT6eak/wSi
        DDPteN2jSMSQRG7VNVw6Z74akjUKjW/bwneVyVodlpMRFWGhb9OEzUO/8gzfqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685114017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iIhbo7U5bYYA5D+nU5U/U0dXC0GGh8X5zoP3O7uKmOg=;
        b=xbGljKdQ9DCfRo/Pnp0a8/LfI3rntrTSiXBYTZEUyLQDHYfSpxKpaaol+OqnwT/LtiTO2I
        dosgiowg2bSbN6DA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20230526151335.oPeFiIdq@linutronix.de>
References: <Y++UzubyNavLKFDP@linutronix.de>
 <20230525165244.GV83892@hirez.programming.kicks-ass.net>
 <20230526080543.GF38236@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230526080543.GF38236@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-26 10:05:43 [+0200], Peter Zijlstra wrote:
> New day, new chances... How's this? Code-gen doesn't look totally
> insane, but then, making sense of an optimizing compiler's output is
> always a wee challenge.

Noticed it too late but looks good. Tested, works.

Sebastian
