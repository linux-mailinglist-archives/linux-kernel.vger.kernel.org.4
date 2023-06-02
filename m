Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6AC71FFB3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbjFBKuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbjFBKuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:50:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD5EC0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:50:02 -0700 (PDT)
Date:   Fri, 2 Jun 2023 12:49:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685703000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fbksIU3JUlXkEO7MjUhZpBXWqwFd5LCsyXZ1/Ew4uKM=;
        b=XHnU+dMEh789VExWhaT99Prt+X5alCCKCe7QpKMF+JmC5sclABZ+DQbzx0igzBb3SjnyE+
        CUiDXW9g3LyIJrv4W1IdPV/+n2/kBt95a0AJg0UjnddeEiqkVu6mqYv3+gGX5DDoHXgXNT
        cK0AOCxwwSbZuZQX3XVQ+Z4UP9pRu3/oI6W2LuZtkApBTJJ53z+4htZuyyh3aMp5JSXKMP
        tF9GooEUBPCz2UVChj4UvhC+qYDLsUfuUBv0e85BIjR/D4E45N4iRc+vMv2qb9K9EKlfxq
        fQtOAjnPZLx0Ym8tEzKZhTfHkmPT+h5UpawwwYirx4HCDKxK+qtpJAKmlrGEew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685703000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fbksIU3JUlXkEO7MjUhZpBXWqwFd5LCsyXZ1/Ew4uKM=;
        b=WtJZLwdX+3+JjXqTwdEYQQUNp/Wde6FkPO6BBWq2BoAFlZ9srg4ZTfvEp3sugrdidTLmlo
        eiXldH1saadXzABw==
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
Message-ID: <20230602104958._mDE_6c6@linutronix.de>
References: <Y++UzubyNavLKFDP@linutronix.de>
 <20230525165244.GV83892@hirez.programming.kicks-ass.net>
 <20230526080543.GF38236@hirez.programming.kicks-ass.net>
 <20230526151335.oPeFiIdq@linutronix.de>
 <20230601091234.GW83892@hirez.programming.kicks-ass.net>
 <20230602082503.GA624418@hirez.programming.kicks-ass.net>
 <20230602103731.GA630648@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230602103731.GA630648@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-02 12:37:31 [+0200], Peter Zijlstra wrote:
> ---
> Subject: sched: Unconditionally use full-fat wait_task_inactive()
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Fri Jun  2 10:42:53 CEST 2023
>=20
> While modifying wait_task_inactive() for PREEMPT_RT; the build robot
> noted that UP got broken. This led to audit and consideration of the
> UP implementation of wait_task_inactive().
>=20
> It looks like the UP implementation is also broken for PREEMPT;

If UP is broken for PREEMPT, shouldn't it get a fixes or stable tag?

Eitherway, I will try to stuff this in RT today and give feedback. I
actually never booted this on UP, will try to do so today=E2=80=A6

Sebastian
