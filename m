Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F2E6E2663
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjDNPDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 11:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjDNPDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:03:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5898F93CE;
        Fri, 14 Apr 2023 08:03:21 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681484599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WZbmV2/0mJHNv7WWGKc8denlmxQkwpLy33oC3nMgopk=;
        b=iBuy3VERhbxgFIH+MRuYD5d/89EO4b76taoG0JUbAD4dhUwYFzBHNiqq4usjdp+G0mV5tb
        3th0WP7B0FO1hCBomtOuXs6wPFhenUNNixwt2epPjITGnGOIyeZDv9DZy+bFtXcjJ7wZYM
        CgSUG4qF5XMDWnRVbo+Yf7xXi4S5gsrFIW9qvcD4HDZv+xithtidvrif4H0s82aNugvYz5
        TPziTEjpQ118hjhCldWscrFpRhgV7MPjaEt9RnMW4FbUT2U5tVRjQh7bhfMgEd+959egeC
        MNCxXzwpjFNrMANUh/U2quAtRlnWKMGyR6aLF7h/wBtniYJOcwo16JPN16Q5HQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681484599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WZbmV2/0mJHNv7WWGKc8denlmxQkwpLy33oC3nMgopk=;
        b=p/G6z1mvJMSwrxK6z0HjQ2lMOzDUaUhQnmz406eoub5JnEwqqCI5+PJtw4c0LXB5+2d9H9
        y2r5caoccNAtcFDw==
To:     Vlastimil Babka <vbabka@suse.cz>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] v6.3-rc2-rt3
In-Reply-To: <73b5657a-4c47-980a-e709-cd6a880c067c@suse.cz>
References: <20230314170502.OHw1_FK3@linutronix.de>
 <20230314171231.jwtham4a@linutronix.de>
 <9ee941ae-ae22-f14b-4e69-f81b29bbba4b@arm.com>
 <87ttxiefpd.fsf@jogness.linutronix.de>
 <73b5657a-4c47-980a-e709-cd6a880c067c@suse.cz>
Date:   Fri, 14 Apr 2023 17:07:25 +0206
Message-ID: <87pm86ece2.fsf@jogness.linutronix.de>
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

On 2023-04-14, Vlastimil Babka <vbabka@suse.cz> wrote:
> Is it perhaps a similar situation to this thread?
>
> https://lore.kernel.org/all/20230412124735.GE628377@hirez.programming.kicks-ass.net/

We are dealing with a spin_lock() inside a raw_spin_lock() section. The
legacy console drivers do this. The fix is the new atomic/threaded
consoles. For CONFIG_PREEMPT_RT a workaround is implemented so that the
legacy consoles avoid this. For !CONFIG_PREEMPT_RT you can expect
CONFIG_PROVE_RAW_LOCK_NESTING to cause a splat on that printk().

Or perhaps that particular printk() in cblist_init_generic() should be
changed to printk_deferred() as a temporary whack-a-mole
workaround.

John Ogness
