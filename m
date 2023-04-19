Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3EA6E7410
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 09:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjDSHdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 03:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjDSHdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:33:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFEF9037
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:33:23 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681889601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CA8pq10uWD0ZpuG1kPN4dWhcbPnN2/F6yKuNqv6psE4=;
        b=kJzMWQso/GD8LLTRZ1XqUE6PRN50+ccNTLZVm1NgsDwNSm1/+0ok84/g2gg3SUJJcI2rPT
        /7RlwtX94XCu/+e0r+34k8drtzWODfeabe3aGqlMmVC6HEQ3eNBwmDd6dGxBNXxCFyco1X
        kLx2/Oj3B7tPQRDZBvApTT0JyAF+SeFBp4icBNHinSBRemErT+UshABDNHL7YfJs9hkpxG
        fOaC8z1nYIFdRHASeE8KMsn+9bNAt3i1mmEhaa19GeXCScMZ4oGQAawdpl3VHUo0x5gdO5
        k7owLA/qcS5+9RymTD1Wzq5q/+HW8EIsFkmAtsvQAQBjKB/iI7DW+ktGNAPzUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681889601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CA8pq10uWD0ZpuG1kPN4dWhcbPnN2/F6yKuNqv6psE4=;
        b=OVPh9r7jDLIYw14Xh24jGIEvlnPs+2jC+5zWr+xIR/0fznUCzlpR5X1F7gpwDkbhul9Iol
        h7b6TVrRxCP4ruAA==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Marco Elver <elver@google.com>,
        syzbot <syzbot+3b14b2ed9b3d06dcaa07@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] posix-cpu-timers: Implement the missing
 timer_wait_running callback
In-Reply-To: <ZD7JAppWQCoBEBgN@localhost.localdomain>
References: <87h6tsred7.ffs@tglx> <874jpsqdy1.ffs@tglx>
 <ZDADdMnY0oW2k5BV@lothringen> <87lej3twhv.ffs@tglx>
 <ZDBin2ZQwc69hGX4@lothringen> <87ile7trv7.ffs@tglx>
 <CANpmjNOFxGa6iuVbzVcXPyWO-6Zmd=edhatmDBHPKcZ-au35dg@mail.gmail.com>
 <87zg764ojw.ffs@tglx> <ZD7JAppWQCoBEBgN@localhost.localdomain>
Date:   Wed, 19 Apr 2023 09:33:20 +0200
Message-ID: <87cz40498f.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18 2023 at 18:44, Frederic Weisbecker wrote:
> Le Mon, Apr 17, 2023 at 03:37:55PM +0200, Thomas Gleixner a =C3=A9crit :
>>  struct cpu_timer {
>>  	struct timerqueue_node	node;
>> @@ -72,6 +74,7 @@ struct cpu_timer {
>>  	struct pid		*pid;
>>  	struct list_head	elist;
>>  	int			firing;
>> +	struct task_struct	*handling;
>
> I guess it can be made __rcu

Indeed.=20
>>  		if (likely(cpu_firing >=3D 0))
>>  			cpu_timer_fire(timer);
>> +		/* See posix_cpu_timer_wait_running() */
>> +		WRITE_ONCE(timer->it.cpu.handling, NULL);
>
> And rcu_assign_pointer()

I fix that up on the fly.

> Aside the boring details:
>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks for going through this!
