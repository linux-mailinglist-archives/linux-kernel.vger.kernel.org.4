Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F26A72CD42
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbjFLRyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234208AbjFLRyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:54:03 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A51319B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:54:02 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-77af9ee36d0so24837939f.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686592441; x=1689184441;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3fQNgNzuA1xLIJP7vU8TndmEPfYIrtst1yzrc/yrHA4=;
        b=yvdVi4Bh9WeC/lTfOlqHnIvRf/w6x7R7/uJfHzTkFjfgtIgXOuS4Cm9wfoyEUVow08
         n5upQhziZHsoEURC8x4gS4XS+v1vPQueJZmuAuOgscsbCirfrB+DNZt6VbmA/RQ1GHmS
         NRfDmSzmZtXRCkvMgLBPUtZGZpBYksJfMe/viyhTtdbJHc7nqs54tfGTGEQ7wSE0Btmz
         buht5gYg04O0TyQhlYiwECaX3dhGtASCYyTbT1YgnCtvRNJW/G8L+S5ZxLO6JIP1XBAB
         /YA9Max3Fbpf0graZOvM/XNQzzA6L5E/HOuQ80Wsbr2AWGsCp9Xg5IGvw5xLwv79hzL1
         KrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686592441; x=1689184441;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3fQNgNzuA1xLIJP7vU8TndmEPfYIrtst1yzrc/yrHA4=;
        b=F4EHDyjeadxZT6IlZCd16sssslLewPamEhmYu80syubCq0qrHqZ/NN53FplUEAzEMM
         8rh6eIKsj9H1+v8iyUpuYu8O7BjXL/9vkvmZF97SI2uZZGUFZ1jpxGNd1t6X75P3wi/+
         irovaQjjsmNyqU74i4jt8bGPBaMAAX5cswknOpf79TtjiwNMUvahkwGIK/f4RVFk+ux+
         8J5fafjRAHnfDc5WavmukIIIRSZO6hj4DHDPgruYN4VdX8yWF3NvbuBwIeUL0hPEbrkb
         zSyWd4Y6heBV5kzWL1/+TDYHmqLvrhiK4uAoqd97NvUl1esrO/KqtlvPFgCLloJxS9ib
         7uwQ==
X-Gm-Message-State: AC+VfDx6XnzvRVGTRosavSBDeOPZYqzSmcKk7655rwyvvA3GtbV/eKOy
        DSqv/9eQTr4h592+VvY2wNLADw==
X-Google-Smtp-Source: ACHHUZ6kvptc3paAngHhyRPCIJVOdCsMYQrpBYvNUKtOFm7GqFkWZRs1tVG74djBYg22gjfsT+56Gw==
X-Received: by 2002:a6b:5810:0:b0:777:b7c8:ad32 with SMTP id m16-20020a6b5810000000b00777b7c8ad32mr6666017iob.0.1686592441652;
        Mon, 12 Jun 2023 10:54:01 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id dj14-20020a0566384b8e00b004165289bf0csm2922380jab.168.2023.06.12.10.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 10:54:00 -0700 (PDT)
Message-ID: <8a97ca5d-69ef-d716-9f61-2b9b2a26dd14@kernel.dk>
Date:   Mon, 12 Jun 2023 11:53:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [6.5-rc5 regression] core dump hangs (was Re: [Bug report]
 fstests generic/051 (on xfs) hang on latest linux v6.5-rc5+)
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Zorro Lang <zlang@redhat.com>, linux-xfs@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mike Christie <michael.christie@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
References: <20230611124836.whfktwaumnefm5z5@zlang-mailbox>
 <ZIZSPyzReZkGBEFy@dread.disaster.area>
 <20230612015145.GA11441@frogsfrogsfrogs>
 <ZIaBQnCKJ6NsqGhd@dread.disaster.area>
 <CAHk-=whJqZLKPR-cpX-V4wJTXVX-_tG5Vjuj2q9knvKGCPdfkg@mail.gmail.com>
 <20230612153629.GA11427@frogsfrogsfrogs>
 <CAHk-=wiN-JcUh4uhDNmA4hp26Mg+c2DTuzgWY2fZ6hytDtOMCg@mail.gmail.com>
 <af31cadf-8c15-8d88-79fb-066dc87f0324@kernel.dk>
 <13d9e4f2-17c5-0709-0cc0-6f92bfe9f30d@kernel.dk>
 <CAHk-=wgdBfqyNHk0iNyYpEuBUdVgq1KMzHMuEqn=ADtfyK_pkQ@mail.gmail.com>
 <212a190c-f81e-2876-cf14-6d1e37d47192@kernel.dk>
 <CAHk-=wh0hrFjcU5C8uHvLBThrT5vQsFHb7Jk6HRP3LAJqdNx1A@mail.gmail.com>
 <ff34a007-fdd0-8575-8482-919ead39fc88@kernel.dk>
 <CAHk-=whXt9+-YfhgjBYxT9_ATjHbMDZ0yJdK7umrJGU8zBVZ9w@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=whXt9+-YfhgjBYxT9_ATjHbMDZ0yJdK7umrJGU8zBVZ9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/23 11:51?AM, Linus Torvalds wrote:
> On Mon, Jun 12, 2023 at 10:29?AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Looks fine to me to just kill it indeed, whatever we did need this
>> for is definitely no longer the case. I _think_ we used to have
>> something in the worker exit that would potentially sleep which
>> is why we killed it before doing that, now it just looks like dead
>> code.
> 
> Ok, can you (and the fsstress people) confirm that this
> whitespace-damaged patch fixes the coredump issue:
> 
> 
>   --- a/io_uring/io-wq.c
>   +++ b/io_uring/io-wq.c
>   @@ -221,9 +221,6 @@ static void io_worker_exit(..
>         raw_spin_unlock(&wq->lock);
>         io_wq_dec_running(worker);
>         worker->flags = 0;
>   -     preempt_disable();
>   -     current->flags &= ~PF_IO_WORKER;
>   -     preempt_enable();
> 
>         kfree_rcu(worker, rcu);
>         io_worker_ref_put(wq);

Yep, it fixes it on my end and it passes my basic tests as well.

> Jens, I think that the two lines above there, ie the whole
> 
>         io_wq_dec_running(worker);
>         worker->flags = 0;
> 
> thing may actually be the (partial?) reason for those PF_IO_WORKER
> games. It's basically doing "now I'm doing stats by hand", and I
> wonder if now it decrements the running worker one time too much?
> 
> Ie when the finally *dead* worker schedules away, never to return,
> that's when that io_wq_worker_sleeping() case triggers and decrements
> things one more time.
> 
> So there might be some bookkeeping reason for those games, but it
> looks like if that's the case, then that
> 
>         worker->flags = 0;
> 
> will have already taken care of it.
> 
> I wonder if those two lines could just be removed too. But I think
> that's separate from the "let's fix the core dumping" issue.

Something like that was/is my worry. Let me add some tracing to confirm
it's fine, don't fully trust just my inspection of it. I'll send out the
patch separately once done, and then would be great if you can just pick
it up so it won't have to wait until I need to send a pull later in the
week. Particularly as I have nothing planned for 6.4 unless something
else comes up of course.

-- 
Jens Axboe

