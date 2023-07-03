Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA000745784
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjGCIjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjGCIjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:39:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948C7D1;
        Mon,  3 Jul 2023 01:39:44 -0700 (PDT)
Date:   Mon, 3 Jul 2023 10:39:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688373581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tIo8ToFvfLCAEEo6B/vCsBppCQf0LjJR8ahEBNE7/WA=;
        b=Yzm2Bu7FUJ0WUmHLrYt5h5hMSv7XAdcWQC6IU7o7abA46PR2a6xaOXNLiIKwbdGJvADtuZ
        pCgQOTnE8u0UmYwBvaZW08MZGE0a6q3J4b/9e8tbLflmgCuYsEYmiZ2xBvmgnDkml6X1Iz
        cthfIPRNwi1IOY8WfMshr4wpHg8tOh+ARo0QgqmN1BWu1IRPPf2rIhfJWdADHt45oYi/wx
        zSIset78oLVhOEzNzlFV9OQSo3i2C/dYPMdIf+Q+q6aa52P8rUT2MrhDOriArq+APsyiDo
        /l1bMyN9b0kcUn5PvZ2eKQoWg7qq5mImdzphtN9e/F6WR/ts8HepcIrl5qk/Ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688373581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tIo8ToFvfLCAEEo6B/vCsBppCQf0LjJR8ahEBNE7/WA=;
        b=g6s1EJ+4E0UtxWEK6NhAYwjgwDWv6l4iK64AN9uJzZw8IY9u831DTAQlHggiQNkpelGKKa
        aUXCd5nlczWnZrCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, pmladek@suse.com,
        will@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        mingo@redhat.com, mgorman@techsingularity.net, longman@redhat.com,
        lgoncalv@redhat.com, john.ogness@linutronix.de, david@redhat.com,
        boqun.feng@gmail.com, mm-commits@vger.kernel.org
Subject: Re: +
 mm-page_alloc-use-write_seqlock_irqsave-instead-write_seqlock-local_irq_save.patch
 added to mm-unstable branch
Message-ID: <20230703083938.CEkQ9Nhd@linutronix.de>
References: <20230702234049.DCE06C433C8@smtp.kernel.org>
 <b8c61ac6-220a-fb08-90a6-d14ff7754ab9@I-love.SAKURA.ne.jp>
 <ZKKAL9o4lC1Iw5SP@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZKKAL9o4lC1Iw5SP@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-03 10:00:47 [+0200], Michal Hocko wrote:
> On Mon 03-07-23 09:09:46, Tetsuo Handa wrote:
> > Nacked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > 
> > because of https://lkml.kernel.org/r/a1c559b7-335e-5401-d167-301c5b1cd312@I-love.SAKURA.ne.jp .
> 
> This is not really productive approach! You are rising non-material
> concerns you haven't proven to be real. This is blocking otherwise
> useful fix. I am completely fine recording your nack with a reference to
> your concern should we ever trip over your concerns and so we can easily
> revert and find a different solution but I do not believe this should
> stand in the way in the fix.
> 
> Now concerning the patch 1 in the series, I do agree this should be
> passing through the lockdep maintainers. But this fix is not really
> dependent on it.

I fully agree here.

Sebastian
