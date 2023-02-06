Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AEB68C016
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjBFOal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjBFOaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:30:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137C6166D4;
        Mon,  6 Feb 2023 06:30:37 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675693835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mjUDP7D6etLzLdxr40QpFpxhhmwSWnv1xex9q1g7ZCU=;
        b=JSzfds3Q6PWQtuYaTVYUVKWe3UTtlVC17btV+1Rk6ZldSaR4hPMyTwg1x64VR/uKrwWGVQ
        QSR9S4qGKF/H5Z2vkV+NyGs4V01fVT6vVc8h4Wsr/7RAd0ULg8xofBW9/ghQS6lW06n6wz
        65hHKZ//DC41NDi0ss1Bp19GJDLmLtZh3n+W7SM0uhY+JBPm5SFoHrOl7DA3rXuyH872HB
        6/fV0VzTNLXvZW4jmNtSOuExVIpTyaBA0o2U76eyhiK2yhvCQKC5WNZf1q62owefMYpxVd
        eDVjkZFHY89bvJaoznEaak7HPViza8CyNVGe6+aUM8RpBTy3vEMavxvJyMr+4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675693835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mjUDP7D6etLzLdxr40QpFpxhhmwSWnv1xex9q1g7ZCU=;
        b=/pr03pZkP9ESS7vep89rt9wSWrT/tA9mTNCxMASUPFR3yCS9VAOwPStCTxebqpKvjcYxA/
        PEGluRY/pmc/IbDQ==
To:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux-RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] locking/rwbase: Mitigate indefinite writer starvation
In-Reply-To: <20230120140847.4pjqf3oinemokcyp@techsingularity.net>
References: <20230120140847.4pjqf3oinemokcyp@techsingularity.net>
Date:   Mon, 06 Feb 2023 15:30:35 +0100
Message-ID: <87ttzyyigk.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mel!

On Fri, Jan 20 2023 at 14:08, Mel Gorman wrote:
> dio_truncate is not a realtime application but indefinite writer starvation
> is undesirable. The test case has one writer appending and truncating files
> A and B while multiple readers read file A. The readers and writer are
> contending for one file's inode lock which never succeeds as the readers
> keep reading until the writer is done which never happens.
>
> This patch records a timestamp when the first writer is blocked. DL /

git grep 'This patch' Documentation/process/

> RT tasks can continue to take the lock for read as long as readers exist
> indefinitely. Other readers can acquire the read lock unless a writer
> has been blocked for a minimum of 4ms. This is sufficient to allow the
> dio_truncate test case to complete within the 30 minutes timeout.

I'm not opposed to this, but what's the actual reason for this pulled
out of thin air timeout?

What's the downside of actually forcing !RT readers into the slowpath
once there is a writer waiting?

Thanks,

        tglx
