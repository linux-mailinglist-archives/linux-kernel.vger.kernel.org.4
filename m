Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A552C5F13C6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 22:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiI3Uht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 16:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiI3Uhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 16:37:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04634183E47;
        Fri, 30 Sep 2022 13:37:45 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664570263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tl82kt0durQl1cKnS/0FUghprX2ODh80zSubEwXT0Jc=;
        b=2Zhb3JpoEWXmV91SYXf90fMrn98guED5WhnzC4NnAPcayzikHhVkezT4sTtYoJyop/wjPh
        b/j9T0p/yQGGPUB3QF09TEF5BN0Yw+9rI6fc0Zh8x9FyqHZ7soS0C3Pat7HK9M/geEpEYN
        7eaGIlUztWatKGynI8oAx3ttLVy10E9X1koOuJYVPoQKgMPzV+QsJFddyBtKVpagcIKx3b
        4aDIPEoiYCqRlKu4G5ztUVRaK8oDfJi7+0tgoxmBTYEtS3rvrXkJJ90Gmh/wStT/k5hW8p
        qFRCocGcKjS6mUsFq8oXBFAke9AlWKnWOdYEQqK6fOhuq7iaXZ2zBClrwKIk3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664570263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tl82kt0durQl1cKnS/0FUghprX2ODh80zSubEwXT0Jc=;
        b=go5HhcFjhHDMKEOtV0gQdP/67FkOE/i4Tip0fdQ2nwA8zXq7Ot0ZeL7FG3lMfNQL9xAakn
        PkLz0vdHEcYOh8CQ==
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH RFC v2 rcu 1/8] srcu: Convert ->srcu_lock_count and
 ->srcu_unlock_count to atomic
In-Reply-To: <20220930153506.GD4196@paulmck-ThinkPad-P17-Gen-1>
References: <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
 <20220929180731.2875722-1-paulmck@kernel.org>
 <87ill4vrb9.fsf@jogness.linutronix.de>
 <20220930153506.GD4196@paulmck-ThinkPad-P17-Gen-1>
Date:   Fri, 30 Sep 2022 22:43:43 +0206
Message-ID: <87wn9k7g4o.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-30, "Paul E. McKenney" <paulmck@kernel.org> wrote:
>> > -	this_cpu_inc(ssp->sda->srcu_lock_count[idx]);
>> > +	this_cpu_inc(ssp->sda->srcu_lock_count[idx].counter);
>> 
>> Is there any particular reason that you are directly modifying
>> @counter instead of raw_cpu_ptr()+atomic_long_inc() that do you in
>> __srcu_read_lock_nmisafe() of patch 2?
>
> Performance.  From what I can see, this_cpu_inc() is way faster than
> atomic_long_inc() on x86 and s390.  Maybe also on loongarch.  No idea
> on arm64.

Yeah, that's what I figured. I just wanted to make sure.

FWIW, the rest of the series looks pretty straight forward to me.

John
