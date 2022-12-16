Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA74A64E97D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 11:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiLPKby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 05:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiLPKbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 05:31:48 -0500
Received: from outbound-smtp16.blacknight.com (outbound-smtp16.blacknight.com [46.22.139.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682232B63E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:31:47 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp16.blacknight.com (Postfix) with ESMTPS id E2C901C3BB2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 10:31:45 +0000 (GMT)
Received: (qmail 9659 invoked from network); 16 Dec 2022 10:31:45 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 16 Dec 2022 10:31:45 -0000
Date:   Fri, 16 Dec 2022 10:31:41 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-RT <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH] rtmutex: Add acquire semantics for rtmutex lock
 acquisition
Message-ID: <20221216103141.6qxxmlzuqznp54qu@techsingularity.net>
References: <20221202100223.6mevpbl7i6x5udfd@techsingularity.net>
 <Y4nfopZfBxR4lJ6G@linutronix.de>
 <20221202150158.xzgovoy7wuic6vvk@techsingularity.net>
 <Y48q9/G2B6aMdJ1w@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Y48q9/G2B6aMdJ1w@linutronix.de>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 12:43:51PM +0100, Sebastian Andrzej Siewior wrote:
> > > Before that, it did cmpxchg() which should be fine.
> > > 
> > > Regarding mark_rt_mutex_waiters(). Isn't acquire semantic required in
> > > order for the lock-owner not perform the fastpath but go to the slowpath
> > > instead?
> > > 
> > 
> > Good spot, it does. While the most straight-forward solution is to use
> > cmpxchg_acquire, I think it is overkill because it could incur back-to-back
> > ACQUIRE operations in the event of contention. There could be a smp_wmb
> > after the cmpxchg_relaxed but that impacts all arches and a non-paired
> > smp_wmb is generally frowned upon.
> 
> but in general, it should succeed on the first iteration. It can only
> fail (and retry) if the owner was able to unlock it first. A second
> locker will spin on the wait_lock so.
> 

Sure, generally it would be fine but it also costs us nothing
to avoid additional overhead in the contended case. The pattern of
atomic_relaxed+smp_mb__after_atomic is unusual but I think the comment is
sufficient to explain why it's structured like that.

-- 
Mel Gorman
SUSE Labs
