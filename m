Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9205773639D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 08:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjFTGch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 02:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjFTGce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 02:32:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F70E60;
        Mon, 19 Jun 2023 23:32:33 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687242751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VHkzoJWWRRTz1M33LEnyo1a9sWZjKqKnXGzXwAWtbx8=;
        b=U52/kdmZ/M584OtYX9Rr5pCjN49UC1hlVzO6HV7MuOAyoU2cJtxOHDcxeVk4FdLr1p3oss
        6cXGMYpvfOkDw70VhQo9S0Q/5T2Hij6HIoxuXppVXg5nGeV1E93qd8YsrUyD2otJozx4u8
        N0fVoLf59JxnSfOB+wfp4revCcyv9z4xPMZrnT8RVOCXr7skqRgiKwQQ8o8fbhSN9IXcqB
        g803jv46kE47EQudOfGGNTSZ5nhqJkcjXpq0VYsb9Opnz15me84OIzO+NKgz6nUcgNCW92
        z7Ajnji0Q76XI93N8aIc0+iJlzE8DLnR51Q4HpP01Wku2RT4Hdj45tdrbFY8dA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687242751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VHkzoJWWRRTz1M33LEnyo1a9sWZjKqKnXGzXwAWtbx8=;
        b=Nv7SgjtiLnQP/FgOj1zrF0cPEO095/BL8XiS8mr9u31yg6gGz5VJvnR9OPvyVg7/Ntrd0i
        AGtBUYd977x9t+Dw==
To:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org, torvalds@linux-foundation.org,
        peterz@infradead.org, akpm@linux-foundation.org
Subject: Re: +
 lazy-tlb-fix-hotplug-exit-race-with-mmu_lazy_tlb_shootdown.patch added to
 mm-hotfixes-unstable branch
In-Reply-To: <CTH8ZNDRMLEZ.2WS18IS2E38T7@wheely>
References: <20230525205253.E2FAEC433EF@smtp.kernel.org>
 <87v8fv86bh.ffs@tglx> <CTH8ZNDRMLEZ.2WS18IS2E38T7@wheely>
Date:   Tue, 20 Jun 2023 08:32:31 +0200
Message-ID: <87jzvyprsw.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20 2023 at 16:02, Nicholas Piggin wrote:
> On Sun Jun 11, 2023 at 5:29 AM AEST, Thomas Gleixner wrote:
>> /*
>>  * Invoked on the outgoing CPU in context of the CPU hotplug thread
>>  * after ensuring that there are no user space tasks left on the CPU.
>>  *
>>  * If there is a lazy mm in use on the hotplug thread, drop it and
>>  * switch to init_mm.
>>  *
>>  * The reference count on init_mm is dropped in finish_cpu().
>>  */
>> static void sched_force_init_mm(void)
>> {
>>
>> No?
>
> It could be done in many places. Peter touched it last and it's
> been in the tree since prehistoric times.

That's an argument for slapping it into some randomly chosen place and
be done with it, right?

>> > +/*
>> > + * After the CPU is offline, double check that it was previously switched to
>> > + * init_mm. This call can be removed because the condition is caught in
>> > + * finish_cpu() as well.
>>
>> So why adding it in the first place?
>>
>> The changelog mumbles something about reducing churn, but I fail to see
>> that reduction. This adds 10 lines of pointless code and comments for
>> zero value.
>
> Not sure what you're talking about. The patch didn't add it. Removing it
> requires removing it from all archs, which is the churn.

Sure. That's left as an exercise for others, right?

Oh well.

	tglx
