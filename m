Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C869273315C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344300AbjFPMhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344783AbjFPMhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:37:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACF030ED
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:37:09 -0700 (PDT)
Date:   Fri, 16 Jun 2023 14:37:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686919027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8OtrdfBcjyOOddFpGarokVYXJ6xauAxchjGuvxmZWCY=;
        b=OTtnIn475Dbyi1Dr+PJkdeI/m43b55pQBX/RA1Y3l1qpIukjl/8710tgbPmebJnDQH3ODi
        ByR6nz0yqJpLgGJOKuamGQPZaOysbh0Fo02GPOOmCA7WvKtXyZYCwBbYXjMyHZ5votLhoU
        j4/8SB9O+64QFd8Zn49PtK/N7+XEgI9OIqwsgLXcHZ39fJkFU8Gn7GmI8cMIl8gadLKb7I
        K0a/g+tj+H26JHuW9xsvclkJ4SuNCovug7sAWNXAa/6BGJ+gpMRGUm76gdWdUxrOKWDGmz
        +7OQdw65moT9twELsLLzgZHS/qeeetkcEAnbCb9NmWSrIoOmQ6U5DsaKdLpZCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686919027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8OtrdfBcjyOOddFpGarokVYXJ6xauAxchjGuvxmZWCY=;
        b=/VCzuUGMvGYPHo1m7t2IRhjSV67rJKWyc569G3hrCedu5TFbi1Nk8NKmRcXkoTe87LF49n
        cxOpLB0o5fMTd1Bw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Crystal Wood <swood@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Stultz <jstultz@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/4] sched/core: Provide sched_rtmutex() and expose
 sched work helpers
Message-ID: <20230616123704.lXQeCRiJ@linutronix.de>
References: <20230427111937.2745231-1-bigeasy@linutronix.de>
 <20230427111937.2745231-2-bigeasy@linutronix.de>
 <20230503132051.GB1676736@hirez.programming.kicks-ass.net>
 <20230510150415.6BXNs0I1@linutronix.de>
 <20230511134308.GV4253@hirez.programming.kicks-ass.net>
 <20230525152505.obklNijZ@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230525152505.obklNijZ@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-25 17:25:07 [+0200], To Peter Zijlstra wrote:
> > if that works out this worry goes away.
> >=20
> > If we get PROVE_RAW_LOCK_NESTING usable, something like the below might
> > help out with the validation part...
>=20
> Okay. So if I don't collide with workqueue do you buy this or do you
> ask for something else. I'm not sure=E2=80=A6
>=20
> Regarding PROVE_RAW_LOCK_NESTING: If I boot -rc3 with `quiet' then I
> don't see any complains.
> Otherwise it is printk during boot (caller is holding raw_spinlock_t and
> then printk() calls to serial driver with spinlock_t).
> From time to time ppl send "fixes" for PROVE_RAW_LOCK_NESTING splats so
> I would guess they boot with `quiet' and there isn't much else. So we
> are getting close here I guess.
>=20
> Do you want me to test the suggested validation map somewhere? Because
> if it works, it could be queued.

Do you want just the validation map or is there something I'm missing?

Sebastian
