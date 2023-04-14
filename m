Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1F36E24C3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 15:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjDNNwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 09:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDNNwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:52:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156A4AF16;
        Fri, 14 Apr 2023 06:51:50 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681480304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WNDyBVduIseCowQeQV6xpjhSeQnDe1IBsVjmd+71qk0=;
        b=WoDnxp7jIe/vNmnQSDSy8P82Wu1P+DSsfJ3VKsS9hjJNv8smgFybz1t7t3n34FCKuTED+h
        /fPdpQg6dpNnqhfRQv1d5FzfLN7FC1LszR+TzKWEm4nlCjvgMj0wUbC4j5EzSKGNzGNuNM
        1E3erEV49HNgETeKvNkLThI8iBw/3MlF3dkCfcLRBFEUKwJkYG3l/VdVaUEF/YQI+W3otB
        v0BwePZENBYrs+QYpNisAhQTYAq2HdB2BLUVKg6+wq8z8t7/N0p1KsJno4zn7yhglTR9bJ
        +5Z6B+1wJn74VEBVqvx3UhcnIdoqoXmKAKoI3/8ksQz7L/mO8zPlW21KfVAL4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681480304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WNDyBVduIseCowQeQV6xpjhSeQnDe1IBsVjmd+71qk0=;
        b=39awMyFNo8WELCM1kDeMjaQ5YAzi5amupO3rjP7cIQS2xqol5p101uKQoHM6kgPY/MxYPk
        Dso1U9tJpMPSUNBQ==
To:     Pierre Gondois <pierre.gondois@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] v6.3-rc2-rt3
In-Reply-To: <9ee941ae-ae22-f14b-4e69-f81b29bbba4b@arm.com>
References: <20230314170502.OHw1_FK3@linutronix.de>
 <20230314171231.jwtham4a@linutronix.de>
 <9ee941ae-ae22-f14b-4e69-f81b29bbba4b@arm.com>
Date:   Fri, 14 Apr 2023 15:55:50 +0206
Message-ID: <87ttxiefpd.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 2023-04-14, Pierre Gondois <pierre.gondois@arm.com> wrote:
> =============================
> [ BUG: Invalid wait context ]
> 6.3.0-rc5-rt8-gacb52bd349a2 #417 Not tainted
> -----------------------------
> swapper/0/1 is trying to lock:
> ffff00097eea1180 (cpu){....}-{3:3}, at: __printk_safe_enter (kernel/printk/printk_safe.c:28 (discriminator 3))
> other info that might help us debug this:
> context-{5:5}
> 1 lock held by swapper/0/1:
> #0: ffff80000ba77028 (rcu_tasks_rude.cbs_gbl_lock){....}-{2:2}, at: cblist_init_generic (kernel/rcu/tasks.h:233)

This is actually a mainline issue relating to legacy consoles. In
mainline you see it as a warning when CONFIG_PROVE_RAW_LOCK_NESTING is
enabled.

If you enable CONFIG_PREEMPT_RT you will not have the problem.

I will look at how the issue can be gracefully ignored in
!CONFIG_PREEMPT_RT.

Thanks for reporting.

John Ogness
