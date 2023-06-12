Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB4372CCEA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbjFLRad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjFLRaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:30:09 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A569D12C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:30:07 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-33d0c740498so2852465ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686591007; x=1689183007;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5RPcRE6tiWFIxK8XnR+X/u8/QF01H2IFuqo02Af8LI0=;
        b=gaSultT3agv77Ptz7IgmCB716FfHzRuaRPYtJbyJshm6nFQ1iltKSxSet3ZARNLd6D
         +CK08jk9zDf4Y8qoDWgEcnoejTImo1KRpuRf1/Xmf0eDafcKXtz2Gull+nnWKVBQjHvL
         h6o3MK65hs0yIDq+nVp/sgFbxZRPM+T7KwmDOHzK1J2ISTW9bg/Dq01LRF7DsEGKJcHt
         mnFcNNhwJUoOgxRVUVE7INO5Y75eRmXcg4s9HBqMmtwF9Q8+X67aCWpX0lpH6wM/hyRW
         ozLsSCJif+AXAwMq6VIFjmnb0vdSq+6Rj+V4xpQvpdpZqSlK0f6YR2KmLBCNbw1WQyr/
         5dOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686591007; x=1689183007;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5RPcRE6tiWFIxK8XnR+X/u8/QF01H2IFuqo02Af8LI0=;
        b=FwHsZyrtSRbbtHttd47M0NHoemZLOZ9tdhLE1U0bQWAGA2lWZe3tz9MY8WhcoeV7sk
         6HmLuKS/b1vZlqB8Pk0SkRRS85SpZ8FQEC7hIpvJh+L9zYVvcsl34rYk5CQr6B4dbfwG
         +8rllYIA5hvqDFPsxvGg/KYzMP//HytO3vutR1BXSGY5QjEzkF29I57ZvTuu45OsHYxP
         +2kGwXumXM3L/lQsnIy1nDsPSYKRCV45T6hbdrqtVggOpuhJ5/mEiKOb84SNpgGz2t6k
         Mtx+z4aMhXerMw3HtQb7oISF+72zRlgkS03cphu64w0ggY0AeL02vcYDsiVK7BlhMTH5
         W5yQ==
X-Gm-Message-State: AC+VfDzv+/FMllOMPOgEE4NHigAiFGL9P8676FTQ26Co8CzI3FsiL4Fi
        sfTZpGPyNxTqV0wDaZnqoVbDLg==
X-Google-Smtp-Source: ACHHUZ6Qxv2v/O2e6XUksaMe95AnFpCgNCDBl5RYBP76jjawGbEnNPf/YOuWsAm2sApprg1XlWkKxw==
X-Received: by 2002:a6b:8d4b:0:b0:777:b6a9:64ba with SMTP id p72-20020a6b8d4b000000b00777b6a964bamr6726006iod.2.1686591005499;
        Mon, 12 Jun 2023 10:30:05 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x24-20020a02ac98000000b00420c5d10c38sm2801036jan.74.2023.06.12.10.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 10:30:03 -0700 (PDT)
Message-ID: <b80ed751-8f9d-f6a5-c357-276f71157417@kernel.dk>
Date:   Mon, 12 Jun 2023 11:30:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [6.5-rc5 regression] core dump hangs (was Re: [Bug report]
 fstests generic/051 (on xfs) hang on latest linux v6.5-rc5+)
Content-Language: en-US
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Zorro Lang <zlang@redhat.com>, linux-xfs@vger.kernel.org,
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
 <87wn08ppvs.fsf@email.froward.int.ebiederm.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <87wn08ppvs.fsf@email.froward.int.ebiederm.org>
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

On 6/12/23 11:11?AM, Eric W. Biederman wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
>> On Mon, Jun 12, 2023 at 9:45?AM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> You snipped the suspicion in my reply on why that exists, to avoid
>>> io_wq_worker_sleeping() triggering.
>>
>> I'm not seeing why triggering io_wq_worker_sleeping() should even be a
>> problem in the first place.
>>
>> I suspect that is entirely historical too, and has to do with how it
>> used to do that
>>
>>         struct io_worker *worker = kthread_data(tsk);
>>         struct io_wqe *wqe = worker->wqe;
>>
>> back in the bad old days of kthreads.
>>
>> But yeah, I don't know that code.
> 
> If it is a problem it looks like the thread shutdown can clear
> "worker->flags & IO_WORKER_F_UP" rather than
> "current->flags & PF_IO_WORKER".
> 
> I don't see how it makes sense for the load balancing logic for
> a per-process thread pool to be running at that point.

Yep that was my thinking too, if we did need it, we could fiddle with
the UP flag instead. But as per the previous reply, it should be able to
just get removed at this point.

-- 
Jens Axboe

