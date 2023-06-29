Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A4E742C0F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 20:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjF2SoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 14:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjF2Sn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 14:43:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4881A2D55
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 11:43:56 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688064234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6C/4O6IMGQUkL614VBtPLgXvHc0T28BWHO32tO50Ymk=;
        b=KiO0NgWW8uR98f2mOLYwWVmqt8zvXtXXlnU/8uxNNvbKQ54r8eRRDsVGUpPTfsyYFop+5H
        LcRVweK62Z7MuGHbE1PdLj/X/LNxM9gQ950CsRJjuXPNvUVdlhaSZ54m6go1o5dqifZjN7
        WJkO3zw7tSUVPru/tEID0LnGS/FXn8yde+TCdon70KPSlW856tzJeSyZzMI+1DHD+HtZzI
        nr3adWMRWb1mtxGSM2cAkMmugN3oiiJBN4nn5PlvEAFjPqQ3uIrQN4TcFcPIzWcQUlojwA
        DtdwPN0xrcSVdyhmq2TIEbzHiJhN/mEB24IzjU64BZU6yRNfxjgVjqktA4yk+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688064234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6C/4O6IMGQUkL614VBtPLgXvHc0T28BWHO32tO50Ymk=;
        b=pg0yRGlXFPZr3rSZQsAOOSS/CRnGJFi3pQj8wDhb+kKJCjAIP1Nzqvu7QbO8QIOaX4tM83
        mKl9tNaFZ3YqMMBg==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch 12/45] posix-cpu-timers: Simplify posix_cpu_timer_set()
In-Reply-To: <ZJq/KHqjChLWtypG@lothringen>
References: <20230606132949.068951363@linutronix.de>
 <20230606142031.705286109@linutronix.de> <ZJq/KHqjChLWtypG@lothringen>
Date:   Thu, 29 Jun 2023 20:43:54 +0200
Message-ID: <87y1k2153p.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27 2023 at 12:51, Frederic Weisbecker wrote:
> On Tue, Jun 06, 2023 at 04:37:37PM +0200, Thomas Gleixner wrote:
>> Avoid the late sighand lock/unlock dance when a timer is not armed to
>> enforce reevaluation of the timer base so that the process wide CPU timer
>> sampling can be disabled.
>> +	 * SIGEV_NONE timers are never armed. In case the timer is not
>> +	 * armed, enforce the reevaluation of the timer base so that the
>> +	 * process wide cputime counter can be disabled eventually.
>>  	 */
>>  	if (!sigev_none && new_expires && now < new_expires)
>>  		arm_timer(timer, p);
>> +	else
>> +		trigger_base_recalc_expires(timer, p);
>
> We don't need a recalc if sigev_none, right?

Correct.
