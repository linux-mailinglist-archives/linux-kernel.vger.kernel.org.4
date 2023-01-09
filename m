Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F03662BEA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbjAIQ5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbjAIQ51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:57:27 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6467412634;
        Mon,  9 Jan 2023 08:57:16 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id A14F041CDB;
        Mon,  9 Jan 2023 16:57:15 +0000 (UTC)
Received: from pdx1-sub0-mail-a292.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 1FAF4415FA;
        Mon,  9 Jan 2023 16:57:15 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1673283435; a=rsa-sha256;
        cv=none;
        b=VlcqsXUE8LdZAXPHw/t2+3Y1eWKZpLdwl4lJdwlIxKcBWrmvUtl/pDRY4CGFBMvVgAcwkN
        Nf3GqwDQ99uU64gfVQGKQs2eBOvEeOVs0oL4YOdSSzFDOMzpxq7cp3DDSXH0LwqndQSFQx
        mEIC6gNSNY+EmBhT7s3CkTLvXPlmYdJTOkatOIu80ErROjSjPETY9+MuhjVY/ASqpf5nLd
        ttgm90E4TRgdhehE4LJFRZJNJTmP57f1RNu0XXzqX8BygG2TunDneIGruEYlEf5GR2aZMF
        2oliOm4PxmbpHfJf7ERFTlohwK06seTIozVDpKkSnAk57rREWiaYrhCRf6eJLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1673283435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=fRJz35yDKzgW+z+yhtKqr7vvSQJNcuNFipzAMKSucTA=;
        b=M0te18ttWUVp6q9IkMv8L/wuy1G/8QNOkYm5iZP3S48wfUvoMugwmLcyaZwPWwX6sjwe1s
        Iio3XJDI2E8QGTuuCHh1WGb0rcD8/ry4M24IioE1TTFlD8ok0NgdbWBBxdYBX3STjOw93z
        E+BEZPrlV9z7OB6ebuDm4d/7pM594GtF71DnhN360oAvbALmLNglwLgB8MUN29WRoDAYTc
        wKVAC/y7Uy8WbS3JMvnArLT0sxGRkdphmIKHtA2OGtMluUVTEHwer+ksWI8vcKCklRZDXO
        jNrglUIDmlJGTAuYdbimuIUPjS048J2DgSkgmJHhSv5f8pEGJDckWCV1yvwfkw==
ARC-Authentication-Results: i=1;
        rspamd-6f569fcb69-l5lcf;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Rock-Eyes: 3461fba77bbd2390_1673283435457_2841770446
X-MC-Loop-Signature: 1673283435457:2312549784
X-MC-Ingress-Time: 1673283435457
Received: from pdx1-sub0-mail-a292.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.99.229.59 (trex/6.7.1);
        Mon, 09 Jan 2023 16:57:15 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a292.dreamhost.com (Postfix) with ESMTPSA id 4NrKqZ1Nkzz24;
        Mon,  9 Jan 2023 08:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1673283434;
        bh=fRJz35yDKzgW+z+yhtKqr7vvSQJNcuNFipzAMKSucTA=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=eHmwZVgW9JpGDKQsD3zPEnXK4u5aFPZRh02y0uymSNwq1i0JVAmyhTAJ/OAzzvDeU
         IBGu4OQwKI+mrUV/aYyD1HMwAgn9WjoODG5NHeN36InF9UCYy8wckoH8WbWFDJw6ND
         2mhHct2kc2eEqCEAKw8iZUTVwSRS/jyKABWU+U6T1c4M7WjwKcWoipyoYqa+yKMjWq
         MwxBZUkzgPpO7NghtkbzGzgixQwwFrfaPoQF1pVf/F8MaU7/bhDogO8em1QOQogdHU
         ZHPjZD7ofof6jkQ/PYCt1oy7sS2vNNNbi5uOb+ASfl0Ze3eKl6DNbeGk+CmEfydoiE
         iEqGMm2MiZ7ow==
Date:   Mon, 9 Jan 2023 08:31:23 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux-RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        torvalds@linux-foundation.org, frederic@kernel.org
Subject: Re: [RFC PATCH] locking/rwbase: Prevent indefinite writer starvation
Message-ID: <20230109163123.mizksqivfmozaz4f@offworld>
References: <20230106142743.30759-1-mgorman@techsingularity.net>
 <Y7wxjBN9bDaZ0BKo@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Y7wxjBN9bDaZ0BKo@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Jan 2023, Peter Zijlstra wrote:

>On Fri, Jan 06, 2023 at 02:27:43PM +0000, Mel Gorman wrote:
>> rw_semaphore and rwlock are explicitly unfair to writers in the presense
>> of readers by design with a PREEMPT_RT configuration. Commit 943f0edb754f
>> ("locking/rt: Add base code for RT rw_semaphore and rwlock") notes;
>>
>>	The implementation is writer unfair, as it is not feasible to do
>>	priority inheritance on multiple readers, but experience has shown
>>	that real-time workloads are not the typical workloads which are
>>	sensitive to writer starvation.
>>
>> While atypical, it's also trivial to block writers with PREEMPT_RT
>> indefinitely without ever making forward progress. Since LTP-20220121,
>> the dio_truncate test case went from having 1 reader to having 16 readers
>> and the number of readers is sufficient to prevent the down_write ever
>> succeeding while readers exist. Ultimately the test is killed after 30
>> minutes as a failure.
>>
>> dio_truncate is not a realtime application but indefinite writer starvation
>> is undesirable. The test case has one writer appending and truncating files
>> A and B while multiple readers read file A.  The readers and writer are
>> contending for one file's inode lock which never succeeds as the readers
>> keep reading until the writer is done which never happens.
>>
>> This patch records a timestamp when the first writer is blocked. Reader
>> bias is allowed until the first writer has been blocked for a minimum of
>> 4ms and a maximum of (4ms + 1 jiffie). The cutoff time is arbitrary on
>> the assumption that a hard realtime application missing a 4ms deadline
>> would not need PRREMPT_RT. It's expected that hard realtime applications
>> avoid such heavy reader/writer contention by design. On a test machine,
>> the test completed in 92 seconds.
>
>>  static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
>>				      unsigned int state)
>>  {
>> @@ -76,7 +79,8 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
>>	 * Allow readers, as long as the writer has not completely
>>	 * acquired the semaphore for write.
>>	 */
>> -	if (atomic_read(&rwb->readers) != WRITER_BIAS) {
>> +	if (atomic_read(&rwb->readers) != WRITER_BIAS &&
>> +	    jiffies - rwb->waiter_blocked < RW_CONTENTION_THRESHOLD) {
>>		atomic_inc(&rwb->readers);
>>		raw_spin_unlock_irq(&rtm->wait_lock);
>>		return 0;
>
>Blergh.
>
>So a number of comments:
>
> - this deserves a giant comment, not only an obscure extra condition.
>
> - this would be better if it were limited to only have effect
>   when there are no RT/DL tasks involved.

Agreed.

(Sorry for hijacking this thread, also more Cc)

Hmm this reminds me of the epoll rwlock situation[1, 2] which does the lockless
ready event list updates from irq callback context and hits the writer unfair
scenario, which was designed really for tasklist_lock. Converting the read_lock
to RCU looks like a no-go because this is not a read-mostly pattern, far from
it actually. And in fact the read path is not at all a read path (ie: simply
traversing the list(s)). We also probably hit this unfair is good for throughput
condition mentioned by Linus as these are spinning locks and thus a short critical
region to really benefit from actual concurrent readers.

So while the numbers in a218cc491420 (epoll: use rwlock in order to reduce ep_poll
callback() contention) are very nice, based on the above and the fact that per
the changelog it does misasume the fairness I would vote for removing the lockless
stuff and return to simply using a spinlock (epoll is wacky enough already).
It is ultimately less burden on the kernel, and I suspect that people who really
care about epoll performance will mostly be looking at io_uring.

Thanks,
Davidlohr

[1] https://lore.kernel.org/all/20210825132754.GA895675@lothringen/
[2] https://lore.kernel.org/all/20220617091039.2257083-1-eric.dumazet@gmail.com/

>
>This made me re-read the phase-fair rwlock paper and again note that RW
>semaphore (eg blocking) variant was delayed to future work and AFAICT
>this future hasn't happened yet :/
>
>AFAICT it would still require boosting the readers (something tglx still
>has nightmares of) and limiting reader concurrency, another thing that
>hurts.
>
>
