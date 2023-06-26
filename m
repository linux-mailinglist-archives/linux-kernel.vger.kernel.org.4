Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6FB73DFE2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjFZM42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjFZM40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:56:26 -0400
Received: from outbound-smtp11.blacknight.com (outbound-smtp11.blacknight.com [46.22.139.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F6C121
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 05:56:23 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp11.blacknight.com (Postfix) with ESMTPS id 48CEE1C3E9A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:56:21 +0100 (IST)
Received: (qmail 26177 invoked from network); 26 Jun 2023 12:56:21 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 26 Jun 2023 12:56:20 -0000
Date:   Mon, 26 Jun 2023 13:56:18 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.co>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/2] seqlock: Do the lockdep annotation before locking
 in do_write_seqcount_begin_nested()
Message-ID: <20230626125618.e52lrsmulrubrftm@techsingularity.net>
References: <20230623171232.892937-1-bigeasy@linutronix.de>
 <20230623171232.892937-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230623171232.892937-2-bigeasy@linutronix.de>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 07:12:31PM +0200, Sebastian Andrzej Siewior wrote:
> It was brought up by Tetsuo that the following sequence
>    write_seqlock_irqsave()
>    printk_deferred_enter()
> 
> could lead to a deadlock if the lockdep annotation within
> write_seqlock_irqsave() triggers. The problem is that the sequence
> counter is incremented before the lockdep annotation is performed. The
> lockdep splat would then attempt to invoke printk() but the reader side,
> of the same seqcount, could have a tty_port::lock acquired waiting for
> the sequence number to become even again.
> 
> The other lockdep annotations come before the actual locking because "we
> want to see the locking error before it happens". There is no reason why
> seqcount should be different here.
> 
> Do the lockdep annotation first then perform the locking operation (the
> sequence increment).
> 
> Fixes: 1ca7d67cf5d5a ("seqcount: Add lockdep functionality to seqcount/seqlock structures")
> Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Link: https://lore.kernel.org/20230621130641.-5iueY1I@linutronix.de
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
