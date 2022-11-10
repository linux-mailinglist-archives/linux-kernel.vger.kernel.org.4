Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAD3623A63
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 04:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbiKJD0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 22:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbiKJDZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 22:25:57 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC13025C68
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 19:25:55 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 130so528441pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 19:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3dVcYSVijqi3rF2gaHW3eFsExRV81VNFqf3MXHIVDz8=;
        b=y6dm1VN6ElyA3ZMQtpTLFeDt08Ajx/7OEu3LIqCwwsAT6kI66tvtEZTk/MigQSMFDn
         iUMXHrH5BU5BU70ikHKG0viiMiJTUqwFa78UDNPEvmVTXFp7eaClTM/8+KTczz6ihN0J
         JrI2C6imwTRc+6DRrMNv6BSIS2QS1jmZkO8TE5C+QtX7OVqfa0oZEpC7jvNLM6UX8vkq
         H6u0B1FWxt4Mzc8OOTc2PgrmfL8SxIow6I7hutQ5cpLWhPCSnRC44Ltk9XVVskY9re6Y
         SzKyoxLKNWcbYevZ0wCLYrDxeDKgGDgt+a3+lYUvdQ2CLB2ZQcOlFNx1eEJ9LIBqiIfX
         recw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3dVcYSVijqi3rF2gaHW3eFsExRV81VNFqf3MXHIVDz8=;
        b=DnHQk9b/gejYw/kcYVn+54pSv/pTYqnD3u7Mku0+GZttb4Q5zlVU+h84+DecfjHfHq
         krRyTWlA5J5qLCtMD8QJgTsWUAfAEQ3J22rPGUs0sQfrcjQCz1WTk1eBOzKDV1UyBqk7
         P6A6kDsluuSNvv7dc9yJPn0wZBfGtzuJ3tBEcmLWzRTPTpH3QtAwbyrXb89IG6Z514kq
         1qt/I85d5mW5Yfs/EPSREshmQsQkU3oHycV4eh+rsmdyuRo81a88b+FtDMampKol7qeL
         7mjW2WyfO9y/sEtAeGPM6J5rJWxvnuUYViiBqmccyVdVL9Mi87u/q3J3AqApfdt2hUdG
         ZEDw==
X-Gm-Message-State: ACrzQf2f8K7f7Z4YGBRF8503hXupjxa2bwJIB+6avJ20xK2DVVEyclD6
        L/2HfW9rCDUfStNmVJa+rORbZg==
X-Google-Smtp-Source: AMsMyM6ni0Ps4nm21AMZo/2kWyj5Fa/CU+UvZlBgrRXIrYkTqySfRxe8+ABA8zRdSA4KdYfxiqLfuQ==
X-Received: by 2002:a63:1953:0:b0:434:aa27:6bee with SMTP id 19-20020a631953000000b00434aa276beemr1585144pgz.388.1668050755239;
        Wed, 09 Nov 2022 19:25:55 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n9-20020a635c49000000b004639c772878sm8161320pgm.48.2022.11.09.19.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 19:25:54 -0800 (PST)
Message-ID: <97a7eafc-c77f-6282-c914-7e66712ee47b@kernel.dk>
Date:   Wed, 9 Nov 2022 20:25:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] sbitmap: Use single per-bitmap counting to wake up queued
 tags
Content-Language: en-US
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Keith Busch <kbusch@kernel.org>,
        Liu Song <liusong@linux.alibaba.com>, Jan Kara <jack@suse.cz>
References: <20221105231055.25953-1-krisman@suse.de>
 <cd88f306-1da4-a243-ec23-fea033142fbb@kernel.dk> <87wn83eod3.fsf@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <87wn83eod3.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/22 3:48 PM, Gabriel Krisman Bertazi wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 11/5/22 5:10 PM, Gabriel Krisman Bertazi wrote:
>>> Performance-wise, one should expect very similar performance to the
>>> original algorithm for the case where there is no queueing.  In both the
>>> old algorithm and this implementation, the first thing is to check
>>> ws_active, which bails out if there is no queueing to be managed. In the
>>> new code, we took care to avoid accounting completions and wakeups when
>>> there is no queueing, to not pay the cost of atomic operations
>>> unnecessarily, since it doesn't skew the numbers.
>>>
>>> For more interesting cases, where there is queueing, we need to take
>>> into account the cross-communication of the atomic operations.  I've
>>> been benchmarking by running parallel fio jobs against a single hctx
>>> nullb in different hardware queue depth scenarios, and verifying both
>>> IOPS and queueing.
>>>
>>> Each experiment was repeated 5 times on a 20-CPU box, with 20 parallel
>>> jobs. fio was issuing fixed-size randwrites with qd=64 against nullb,
>>> varying only the hardware queue length per test.
>>>
>>> queue size 2                 4                 8                 16                 32                 64
>>> 6.1-rc2    1681.1K (1.6K)    2633.0K (12.7K)   6940.8K (16.3K)   8172.3K (617.5K)   8391.7K (367.1K)   8606.1K (351.2K)
>>> patched    1721.8K (15.1K)   3016.7K (3.8K)    7543.0K (89.4K)   8132.5K (303.4K)   8324.2K (230.6K)   8401.8K (284.7K)
>>>
>>> The following is a similar experiment, ran against a nullb with a single
>>> bitmap shared by 20 hctx spread across 2 NUMA nodes. This has 40
>>> parallel fio jobs operating on the same device
>>>
>>> queue size 2 	             4                 8              	16             	    32		       64
>>> 6.1-rc2	   1081.0K (2.3K)    957.2K (1.5K)     1699.1K (5.7K) 	6178.2K (124.6K)    12227.9K (37.7K)   13286.6K (92.9K)
>>> patched	   1081.8K (2.8K)    1316.5K (5.4K)    2364.4K (1.8K) 	6151.4K  (20.0K)    11893.6K (17.5K)   12385.6K (18.4K)
>>
>> What's the queue depth of these devices? That's the interesting question
>> here, as it'll tell us if any of these are actually hitting the slower
>> path where you made changes. 
>>
> 
> Hi Jens,
> 
> The hardware queue depth is a parameter being varied in this experiment.
> Each column of the tables has a different queue depth.  Its value is the
> first line (queue size) of both tables.  For instance, looking at the
> first table, for a device with hardware queue depth=2, 6.1-rc2 gave
> 1681K IOPS and the patched version gave 1721.8K IOPS.
> 
> As mentioned, I monitored the size of the sbitmap wqs during the
> benchmark execution to confirm it was indeed hitting the slow path and
> queueing.  Indeed, I observed less queueing on higher QDs (16,32) and
> even less for QD=64.  For QD<=8, there was extensive queueing present
> throughout the execution.

Gotcha, this makes a lot of sense. I just misunderstood the queue size
numbers to be queue depth on the IO generation side.

Any idea what is reducing performance at the higher end of queue size
spectrum? Not that I think it's _really_ that interesting, just curious.

> I should provide the queue size over time alongside the latency numbers.
> I have to rerun the benchmarks already to collect the information
> Chaitanya requested.

Thanks.

>> I suspect you are for the second set of numbers, but not for the first
>> one?
> 
> No. both tables show some level of queueing. The shared bitmap in
> table 2 surely has way more intensive queueing, though.

Yep, got it now.

>> Anything that isn't hitting the wait path for tags isn't a very useful
>> test, as I would not expect any changes there.
> 
> Even when there is less to no queueing (QD=64 in this data), we still
> enter sbitmap_queue_wake_up and bail out on the first line
> !wait_active. This is why I think it is important to include QD=64
> here. it is less interesting data, as I mentioned, but it shows no
> regressions of the faspath.

Yes, the checking for whether we need to hit the slow path should be
fast. I will try and run some numbers here too for the pure fast path,
no sleeping at all. For most fast storage this is where we'll be for the
majority of the time, queue depth on NVMe is generally pretty deep.
FWIW, I did run my usual quick peak testing and didn't see any
regressions there. I'll do a quick per-core benchmark tomorrow, that's
more sensitive to cycle issues.

But I like the change in general, and I think your numbers look sane.
Would be nice to turn sbitmap queueing into something that's actually
sane.

-- 
Jens Axboe
