Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B586619D8B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiKDQoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiKDQnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:43:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA0B31EF9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 09:43:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE9D4B82E72
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 16:43:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D007C433D6;
        Fri,  4 Nov 2022 16:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667580225;
        bh=vrLFKGbB+WonWostWlSiKuz27yHax/ThgTlKqQVTgQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kk5AVgkkcTwryvrh2TJfl7NM2BKytqTBHdEgOXT2xqFY+wl4POYrFfa4QAamr5vqb
         reNy8dz5iWRdgDjEpLGBavDGqCNLPvHf98qJIqxZCvG1kdEDXhz6RkpMar1Fdc88Up
         B+j5D1mZGSIg5QCWtZIN7/Fqh1+HtA4Q4/Ke18nBket/nuElg7fRMyDwiAx/ntwPDK
         IAKEICkjRbmYwqcvyU5o72UCKZqTeBYPGHavvVhSyyGHhEoXRdIx4fEnXHNqWfwmnr
         4Ud4W72vgP2U1aitNzu9F//GNbqosFqagOixG5lRdJbos2UgFqpdBOmTtE53p4fIMI
         LRlMZH2v1QjJQ==
Date:   Fri, 4 Nov 2022 17:43:42 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Stephen Boyd <sboyd@kernel.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v4 05/16] add_timer_on(): Make sure callers have
 TIMER_PINNED flag
Message-ID: <20221104164342.GA1440400@lothringen>
References: <20221104145737.71236-1-anna-maria@linutronix.de>
 <20221104145737.71236-6-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104145737.71236-6-anna-maria@linutronix.de>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 03:57:26PM +0100, Anna-Maria Behnsen wrote:
> The implementation of the hierachical timer pull model will change the
> timer bases per CPU. Timers, that have to expire on a specific CPU, require
> the TIMER_PINNED flag. Otherwise they will be queued on the dedicated CPU
> but in global timer base and those timers could also expire on other
> CPUs. Timers with TIMER_DEFERRABLE flag end up in a separate base anyway
> and are executed on the local CPU only.
> 
> Therefore add the missing TIMER_PINNED flag for those callers who use
> add_timer_on() without the flag. No functional change.

You're fixing the current callers but what about the future ones?

add_timer_on() should always guarantee that a timer runs on the
right destination, which is not the case after your patchset if the
timer hasn't been set to TIMER_PINNED.

Therefore I think we should either have:

* add_timer_on() enforce TIMER_PINNED (doesn't work because if the timer is
  later called with mod_timer(), we should expect it to run anywhere)

or

* add_timer_on() warns if !TIMER_PINNED

or

* have an internal flag TIMER_LOCAL, that is turned on when
  add_timer_on() is called or add_timer()/mod_timer() is called
  on a TIMER_PINNED. Otherwise it is turned off.

The last solution should work with existing API and you don't need to
chase the current and future users of add_timer_on().

Thanks.
