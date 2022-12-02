Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8C96405B6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbiLBLVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbiLBLVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:21:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58558D3A11;
        Fri,  2 Dec 2022 03:21:10 -0800 (PST)
Date:   Fri, 2 Dec 2022 12:21:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669980067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kUQrge8plg+w3veFNfesME539B6kRsAYWeeTF/4ow6U=;
        b=gIbaXxqbfa/DKrpVLcquPWnUONxpPCPbMltn7ZiMsVmSPV0+jWRUGxk0r/LU4lzIHG0TaN
        nGB3RhNeKb17G6Yu/pPNjR0qBRcaHb9V+89fHomimz2f2NAuTHtcoh4oSqsdWR+vRe6SX0
        JSAjsLETamPvn6rpLkRZA935cqn1J9B348CYpP695I9jWzonoUHhrr7ljCu+M2U3b1kKD8
        t55pgi7fuwqpdjtLd+oI4zTvIg2omxBCpq30ixQ8Db5cWtemBUL2e6Mymbj83Ym9VPjY7m
        TyXOHapCF/kTE8CrR6SvpwOvYJJus99o1I8lLjgKZ0NKQfrueqE5T7bQYkh30Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669980067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kUQrge8plg+w3veFNfesME539B6kRsAYWeeTF/4ow6U=;
        b=IFM03siZCUBxNyT1YdfePX74U+EaISXE6cDPra5trFsblD1y74xAxrC3uDDVD5+4iS44mR
        EKtvSGfPQ4eVoIAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-RT <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH] rtmutex: Add acquire semantics for rtmutex lock
 acquisition
Message-ID: <Y4nfopZfBxR4lJ6G@linutronix.de>
References: <20221202100223.6mevpbl7i6x5udfd@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221202100223.6mevpbl7i6x5udfd@techsingularity.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-02 10:02:23 [+0000], Mel Gorman wrote:
> The lock owner is updated with an IRQ-safe raw spinlock held but the
> spin_unlock does not provide acquire semantics which are needed when
> acquiring a mutex. This patch adds the necessary acquire semantics for a
> lock operation when the lock owner is updated. It successfully completed
> 10 iterations of the dbench workload while the vanilla kernel fails on
> the first iteration.

I *think* it is

Fixes: 700318d1d7b38 ("locking/rtmutex: Use acquire/release semantics")

Before that, it did cmpxchg() which should be fine.

Regarding mark_rt_mutex_waiters(). Isn't acquire semantic required in
order for the lock-owner not perform the fastpath but go to the slowpath
instead?

Sebastian
