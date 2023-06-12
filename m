Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CE972B912
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 09:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbjFLHtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 03:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235528AbjFLHtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:49:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76252127;
        Mon, 12 Jun 2023 00:48:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686554477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UOZWia0uZeGvaQi3MK4YR+I/hZw08QaJJFpFJXADn8E=;
        b=pkfLEU/MgFNQ54EayAioJlP9N8TyiCWvDcN6D6/B9fmeqv9DT4fvtuHNhMO+X8HMn6cXnB
        S+qW/cWO6ALsGO1Z3uz24b4Y8xUOZRbwfZfa67PnOSM+4g5vzpr3PV9vrLn1GWfuWpQtNM
        4B81WtGHFLZAvmE6OpB5alAv8F4tmQctTrwGpgeQmXRhwtzGgD960t3PP24jlZ4jLAcGAw
        aWHUssKtx1lHHPy+6hAOxWKGmu04LuNrp6Xw/sPSut3+x2UPuvWqAokamjc1rHvRWcNi12
        1A6F1KgirLx0YKg48Z6Ha0Mc5yUTA2GQqUy4gptOGm4+hbvjufLvFoq9JXp6Qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686554477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UOZWia0uZeGvaQi3MK4YR+I/hZw08QaJJFpFJXADn8E=;
        b=En1O6ZsvXHIR0ygmiNd0s4GIQMRdb4Yfn6zSEk0XxkTA377ymwyw8ivAhWs4SEfoWQ0n1J
        z3p7FhX4/3/GzxBQ==
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     mm-commits@vger.kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, chenhuacai@loongson.cn
Subject: Re: + kthread-unify-kernel_thread-and-user_mode_thread.patch added
 to mm-nonmm-unstable branch
In-Reply-To: <87352x22jc.fsf@email.froward.int.ebiederm.org>
References: <20230605231056.16BD1C433D2@smtp.kernel.org>
 <87352x22jc.fsf@email.froward.int.ebiederm.org>
Date:   Mon, 12 Jun 2023 09:21:17 +0200
Message-ID: <87wn096t8y.ffs@tglx>
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

On Sun, Jun 11 2023 at 14:59, Eric W. Biederman wrote:
> Andrew Morton <akpm@linux-foundation.org> writes:
>
>> The patch titled
>>      Subject: kthread: Unify kernel_thread() and user_mode_thread()
>> has been added to the -mm mm-nonmm-unstable branch.  Its filename is
>>      kthread-unify-kernel_thread-and-user_mode_thread.patch
>
> Andrew.
>
> My fuzzy memory thinks Linus asked for the current split.

Correct. It was in a discussion about a nasty security hole due to a
race in the original code which did _not_ have the distinction.

> Plus this change just obfuscates the code making the most important
> detail the argument to a boolean parameter.  Meaning you have to have
> an interface that has only 3 callers memorized to even begin to make
> sense of it.

Right. Losing the clear distinction of the function names is a horrible
idea.

If at all this should at least keep user_mode_thread() and
kernel_thread() as inline wrappers around a common function.

Just blindly unifying code is a patently bad idea.

Thanks,

        tglx
