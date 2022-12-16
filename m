Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCADF64EEDC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiLPQVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbiLPQUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:20:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7281DF0B;
        Fri, 16 Dec 2022 08:20:18 -0800 (PST)
Date:   Fri, 16 Dec 2022 17:20:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1671207615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+MEibrmmCh/iophEg5CPI5D8t7JQfVecU9sRiaAK93A=;
        b=cEVV8iwST4jB0LztH86xpKsLGAedVX4PqoLvh9iyG/LPIXAmCN4CY2fEFIiV8HuYdQi43p
        RHW6rod4xspj+V25qLaQn4r9/K3xdBCiuHLJjree/R8lCuF5v+vGbGYFouT2zCd77oBnIP
        WM4gv2VB73rGKKk72NXCdpqf04BdScspQGbRJVKWQxDyY3rN+IttB9LbDKZBrTeVM+a0h5
        UtWgI6s2b8TKpmYcknTFCX5blQm9NHPFiLzh4tKyy5DxLGgc/YI8MAq5MUmMwSij9Sdscp
        GVliHFE9UT8iLBXrtVZ52WaYejG/2gRVOB42/97AxIIRd9ikQHdQcaOmL7l1FA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1671207615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+MEibrmmCh/iophEg5CPI5D8t7JQfVecU9sRiaAK93A=;
        b=hHeeO2kRBdDp/EV4zb6aWIKp74+nvyVb6wRQWDxW491yTRyRsIxQuUSghinXev+IYZ8fDo
        hZWeOwRinb7cUaBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Will Deacon <will@kernel.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <Y5yavm77lWLH+IWj@linutronix.de>
References: <20221202100223.6mevpbl7i6x5udfd@techsingularity.net>
 <Y4nfopZfBxR4lJ6G@linutronix.de>
 <20221202150158.xzgovoy7wuic6vvk@techsingularity.net>
 <20221216111412.GA8666@willie-the-truck>
 <20221216135548.itw2xrqbvuldk35y@techsingularity.net>
 <20221216155803.GB8949@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221216155803.GB8949@willie-the-truck>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-16 15:58:04 [+0000], Will Deacon wrote:
> I guess bigeasy can give the weaker barrier a try if he has the time, but
> otherwise we can leave the change as-is.

I can't give a try because I have no HW. All I contributed here so far
was based on what you wrote in the previous email and then I spotted the
lack of the barrier of any sorts and asked about it.
I _would_ assume that the cmpxchg_barrier() here would work but I'm far
from knowing.
If the explicit barrier after the cmpxchg_relaxed() is what you two
agree on and it is better/ cheaper/ more obvious then fine. Do it ;)

> Cheers,
> 
> Will

Sebastian
