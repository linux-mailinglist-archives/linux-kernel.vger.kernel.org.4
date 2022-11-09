Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92C56236C7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 23:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiKIWsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 17:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKIWsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 17:48:12 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1FD27DFE;
        Wed,  9 Nov 2022 14:48:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C8BAF2006F;
        Wed,  9 Nov 2022 22:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668034089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XMCM7OWY+iNPSuDyAZw1JG6t45voRNJpeWU5mvT7YDk=;
        b=ZcmhCy9UlSxOBX4+VnLZ/6sRAOTm7BRl2Nx/7AliLU0jNqXqBIzr9pJnYBIKY+trNUq8To
        siuCJzyBf1pTfsUA89MvdBtRjz5/tZJbFUE6NU/hxWrFT4sbFwomtfTOWYD668fqpDk7Nc
        nvdcv5A0VjPlQlh+55JnnGYSWkuBPws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668034089;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XMCM7OWY+iNPSuDyAZw1JG6t45voRNJpeWU5mvT7YDk=;
        b=vlZ8IiSxZIS4m+I8/dLaTXhVMAgXggODzZVr/ZcTyOa/NqSfx29Htf43mF3Q9FdJMUDcXv
        tf0vRNlmy8Zk1jCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E85F1331F;
        Wed,  9 Nov 2022 22:48:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 61HWHCkubGOJKwAAMHmgww
        (envelope-from <krisman@suse.de>); Wed, 09 Nov 2022 22:48:09 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Keith Busch <kbusch@kernel.org>,
        Liu Song <liusong@linux.alibaba.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] sbitmap: Use single per-bitmap counting to wake up
 queued tags
Organization: SUSE
References: <20221105231055.25953-1-krisman@suse.de>
        <cd88f306-1da4-a243-ec23-fea033142fbb@kernel.dk>
Date:   Wed, 09 Nov 2022 17:48:08 -0500
In-Reply-To: <cd88f306-1da4-a243-ec23-fea033142fbb@kernel.dk> (Jens Axboe's
        message of "Wed, 9 Nov 2022 15:06:52 -0700")
Message-ID: <87wn83eod3.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
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

Jens Axboe <axboe@kernel.dk> writes:

> On 11/5/22 5:10 PM, Gabriel Krisman Bertazi wrote:
>> Performance-wise, one should expect very similar performance to the
>> original algorithm for the case where there is no queueing.  In both the
>> old algorithm and this implementation, the first thing is to check
>> ws_active, which bails out if there is no queueing to be managed. In the
>> new code, we took care to avoid accounting completions and wakeups when
>> there is no queueing, to not pay the cost of atomic operations
>> unnecessarily, since it doesn't skew the numbers.
>> 
>> For more interesting cases, where there is queueing, we need to take
>> into account the cross-communication of the atomic operations.  I've
>> been benchmarking by running parallel fio jobs against a single hctx
>> nullb in different hardware queue depth scenarios, and verifying both
>> IOPS and queueing.
>> 
>> Each experiment was repeated 5 times on a 20-CPU box, with 20 parallel
>> jobs. fio was issuing fixed-size randwrites with qd=64 against nullb,
>> varying only the hardware queue length per test.
>> 
>> queue size 2                 4                 8                 16                 32                 64
>> 6.1-rc2    1681.1K (1.6K)    2633.0K (12.7K)   6940.8K (16.3K)   8172.3K (617.5K)   8391.7K (367.1K)   8606.1K (351.2K)
>> patched    1721.8K (15.1K)   3016.7K (3.8K)    7543.0K (89.4K)   8132.5K (303.4K)   8324.2K (230.6K)   8401.8K (284.7K)
>> 
>> The following is a similar experiment, ran against a nullb with a single
>> bitmap shared by 20 hctx spread across 2 NUMA nodes. This has 40
>> parallel fio jobs operating on the same device
>> 
>> queue size 2 	             4                 8              	16             	    32		       64
>> 6.1-rc2	   1081.0K (2.3K)    957.2K (1.5K)     1699.1K (5.7K) 	6178.2K (124.6K)    12227.9K (37.7K)   13286.6K (92.9K)
>> patched	   1081.8K (2.8K)    1316.5K (5.4K)    2364.4K (1.8K) 	6151.4K  (20.0K)    11893.6K (17.5K)   12385.6K (18.4K)
>
> What's the queue depth of these devices? That's the interesting question
> here, as it'll tell us if any of these are actually hitting the slower
> path where you made changes. 
>

Hi Jens,

The hardware queue depth is a parameter being varied in this experiment.
Each column of the tables has a different queue depth.  Its value is the
first line (queue size) of both tables.  For instance, looking at the
first table, for a device with hardware queue depth=2, 6.1-rc2 gave
1681K IOPS and the patched version gave 1721.8K IOPS.

As mentioned, I monitored the size of the sbitmap wqs during the
benchmark execution to confirm it was indeed hitting the slow path and
queueing.  Indeed, I observed less queueing on higher QDs (16,32) and
even less for QD=64.  For QD<=8, there was extensive queueing present
throughout the execution.

I should provide the queue size over time alongside the latency numbers.
I have to rerun the benchmarks already to collect the information
Chaitanya requested.

> I suspect you are for the second set of numbers, but not for the first
> one?

No. both tables show some level of queueing. The shared bitmap in
table 2 surely has way more intensive queueing, though.

> Anything that isn't hitting the wait path for tags isn't a very useful
> test, as I would not expect any changes there.

Even when there is less to no queueing (QD=64 in this data), we still
enter sbitmap_queue_wake_up and bail out on the first line
!wait_active. This is why I think it is important to include QD=64
here. it is less interesting data, as I mentioned, but it shows no
regressions of the faspath.

Thanks,

-- 
Gabriel Krisman Bertazi
