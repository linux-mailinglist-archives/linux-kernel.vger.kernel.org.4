Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCA461F9DA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbiKGQcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiKGQcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:32:11 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16622612F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:30:18 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8E0D221BEF;
        Mon,  7 Nov 2022 16:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667838617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G0G+B1FI+BKf60trmrpBtM4TOdviP/AMi7QSrgajnxY=;
        b=BTo9v/EgI3aiUqd9iYdCjvuDON7F80CE/ezeiPUveyP7INNgclAUERekwrK9x8cO5EjM3b
        aC1BrvvtBvYjP8GJN3KXj98yBhYPMsCtVQbNRmyd4Xgpgpp35JQdbUyEltzQJ6m0gTPEIg
        of74ywEbq8ZAlq9O7TMYH77/JxdN194=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667838617;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G0G+B1FI+BKf60trmrpBtM4TOdviP/AMi7QSrgajnxY=;
        b=PK7RCHFOtfp6/i3VgV0LRgDc3OMqg70TdNovuWtuGSVS3jnxgfN5QEQgoXEkFyAHG65E6n
        1PrWrdMRuHuFxXDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8030A13AC7;
        Mon,  7 Nov 2022 16:30:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Zb8/H5kyaWNSYAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 07 Nov 2022 16:30:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E16D1A0704; Mon,  7 Nov 2022 17:30:16 +0100 (CET)
Date:   Mon, 7 Nov 2022 17:30:16 +0100
From:   Jan Kara <jack@suse.cz>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Crash with PREEMPT_RT on aarch64 machine
Message-ID: <20221107163016.cnzhknmdnhajfxdh@quack3>
References: <20221103115444.m2rjglbkubydidts@quack3>
 <Y2U+Je+LICO2HkNY@linutronix.de>
 <20221107135636.biouna36osqc4rik@quack3>
 <Y2kf6tcX47Cl7q0W@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2kf6tcX47Cl7q0W@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07-11-22 16:10:34, Sebastian Andrzej Siewior wrote:
> + locking, arm64
> 
> On 2022-11-07 14:56:36 [+0100], Jan Kara wrote:
> > > spinlock_t and raw_spinlock_t differ slightly in terms of locking.
> > > rt_spin_lock() has the fast path via try_cmpxchg_acquire(). If you
> > > enable CONFIG_DEBUG_RT_MUTEXES then you would force the slow path which
> > > always acquires the rt_mutex_base::wait_lock (which is a raw_spinlock_t)
> > > while the actual lock is modified via cmpxchg. 
> > 
> > So I've tried enabling CONFIG_DEBUG_RT_MUTEXES and indeed the corruption
> > stops happening as well. So do you suspect some bug in the CPU itself?
> 
> If it is only enabling CONFIG_DEBUG_RT_MUTEXES (and not whole lockdep)
> then it looks very suspicious. 

Just to confirm, CONFIG_DEBUG_RT_MUTEXES is the only thing I've enabled and
the list corruption disappeared.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
