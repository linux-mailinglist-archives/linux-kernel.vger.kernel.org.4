Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4CF62364B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 23:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiKIWG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 17:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiKIWG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 17:06:57 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD772D77B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 14:06:56 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 136so13521010pga.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 14:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w1kN61EnRKaChQ1fkwaCN+ptQqZpPbW4ujl9+V5bmcE=;
        b=e0ala+O8t181ZXmcwJ4LSFM7Ku5JGM9H8xOWlwiLTlk6T+xzWOOKE3LK4EjX0kTUNS
         M8jQZDoHOqJbq/hbt/hVrV8IlxNv5StJ7Z4dhn2FzdHRjCs1Kd1mEmRJuCTgMhDmP1ie
         ngutleR7D9gwlHoee73prYuvFYZyaIgmmMQ9PJYcct/cpM57TK28jcE7fD7r9E0OeMBS
         pKgTJ8fJnexqK/ekR6euN3qYSflkecyIW0QoFURDNz6LIAzRaSdF+8pb7C0VAoGUqmbw
         ER8iuIQ3+0Gt4HjcQuVBkIT2PbvZbrQRaJoMKQKUiv/C+rUC/R1paBcfogen+Vm7toQb
         BVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w1kN61EnRKaChQ1fkwaCN+ptQqZpPbW4ujl9+V5bmcE=;
        b=jq03ZsQZiaIVZYiY3lMmgMeGVtCJ/Sr0HLFdKXH5XDWWN2Mratp984CDkUuU4NrTAM
         zBXRSi4LCnPaKPrhTBaGFPGDHCRbC4Emjj+rs3fEsUEXOCKwDSIdQGeXLjql3O56fnNK
         IOL+8wRh0LJz2L6/eUc3RzpTWAeRDMy+Z06TrI7KYwTL37ephlmv2QtwpujZd52z6L8l
         cKadF8xr9zz5Xo2CyugqgLYZlbexkBsX3cXix4+P8Z5S7iEEWSEKtAOselr8dl+RGhbO
         eb7ptGWl++2TyPWtFZPDyMxyaYuLJ1TmlMUiPly3OvgCsTvG1DHp8AB61fLWZuJPN5/n
         N7pw==
X-Gm-Message-State: ACrzQf3cwMpDXu+oUAeWDatjVBciBfCVylk1m6lYpexGJLWMLYsY2OEo
        FEphNUxRo3x8raKTM1v/RAsJ5Q==
X-Google-Smtp-Source: AMsMyM5PQ/S7O0iKR4GfJ2ZbKVvb05S41xzc+yPFshPiVV74bjRWKKiDVp5RG2za4ocPdwcObDYLQw==
X-Received: by 2002:a05:6a00:3699:b0:56c:80f6:bee with SMTP id dw25-20020a056a00369900b0056c80f60beemr63455778pfb.13.1668031615662;
        Wed, 09 Nov 2022 14:06:55 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p27-20020aa79e9b000000b0056cc99862f8sm9010774pfq.92.2022.11.09.14.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 14:06:54 -0800 (PST)
Message-ID: <cd88f306-1da4-a243-ec23-fea033142fbb@kernel.dk>
Date:   Wed, 9 Nov 2022 15:06:52 -0700
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
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221105231055.25953-1-krisman@suse.de>
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

On 11/5/22 5:10 PM, Gabriel Krisman Bertazi wrote:
> sbitmap suffers from code complexity, as demonstrated by recent fixes,
> and eventual lost wake ups on nested I/O completion.  The later happens,
> from what I understand, due to the non-atomic nature of the updates to
> wait_cnt, which needs to be subtracted and eventually reset when equal
> to zero.  This two step process can eventually miss an update when a
> nested completion happens to interrupt the CPU in between the wait_cnt
> updates.  This is very hard to fix, as shown by the recent changes to
> this code.
> 
> The code complexity arises mostly from the corner cases to avoid missed
> wakes in this scenario.  In addition, the handling of wake_batch
> recalculation plus the synchronization with sbq_queue_wake_up is
> non-trivial.
> 
> This patchset implements the idea originally proposed by Jan [1], which
> removes the need for the two-step updates of wait_cnt.  This is done by
> tracking the number of completions and wakeups in always increasing,
> per-bitmap counters.  Instead of having to reset the wait_cnt when it
> reaches zero, we simply keep counting, and attempt to wake up N threads
> in a single wait queue whenever there is enough space for a batch.
> Waking up less than batch_wake shouldn't be a problem, because we
> haven't changed the conditions for wake up, and the existing batch
> calculation guarantees at least enough remaining completions to wake up
> a batch for each queue at any time.
> 
> Performance-wise, one should expect very similar performance to the
> original algorithm for the case where there is no queueing.  In both the
> old algorithm and this implementation, the first thing is to check
> ws_active, which bails out if there is no queueing to be managed. In the
> new code, we took care to avoid accounting completions and wakeups when
> there is no queueing, to not pay the cost of atomic operations
> unnecessarily, since it doesn't skew the numbers.
> 
> For more interesting cases, where there is queueing, we need to take
> into account the cross-communication of the atomic operations.  I've
> been benchmarking by running parallel fio jobs against a single hctx
> nullb in different hardware queue depth scenarios, and verifying both
> IOPS and queueing.
> 
> Each experiment was repeated 5 times on a 20-CPU box, with 20 parallel
> jobs. fio was issuing fixed-size randwrites with qd=64 against nullb,
> varying only the hardware queue length per test.
> 
> queue size 2                 4                 8                 16                 32                 64
> 6.1-rc2    1681.1K (1.6K)    2633.0K (12.7K)   6940.8K (16.3K)   8172.3K (617.5K)   8391.7K (367.1K)   8606.1K (351.2K)
> patched    1721.8K (15.1K)   3016.7K (3.8K)    7543.0K (89.4K)   8132.5K (303.4K)   8324.2K (230.6K)   8401.8K (284.7K)
> 
> The following is a similar experiment, ran against a nullb with a single
> bitmap shared by 20 hctx spread across 2 NUMA nodes. This has 40
> parallel fio jobs operating on the same device
> 
> queue size 2 	             4                 8              	16             	    32		       64
> 6.1-rc2	   1081.0K (2.3K)    957.2K (1.5K)     1699.1K (5.7K) 	6178.2K (124.6K)    12227.9K (37.7K)   13286.6K (92.9K)
> patched	   1081.8K (2.8K)    1316.5K (5.4K)    2364.4K (1.8K) 	6151.4K  (20.0K)    11893.6K (17.5K)   12385.6K (18.4K)

What's the queue depth of these devices? That's the interesting question
here, as it'll tell us if any of these are actually hitting the slower
path where you made changes. I suspect you are for the second set of
numbers, but not for the first one?

Anything that isn't hitting the wait path for tags isn't a very useful
test, as I would not expect any changes there.

-- 
Jens Axboe
