Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BAA6F5844
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 14:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjECMzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 08:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjECMzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 08:55:46 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB4A59D1
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 05:55:33 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so6317157a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 05:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1683118532; x=1685710532;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=6kYxRlCY3DiRAUyVahK0tkAYUy3+IuQkjxYPl95xXCw=;
        b=3bTv7UUYES7MGkQlWXBOyzgXFfa/J6rURe5VYP8MZCJsdrfyzUca2vQPf9Y26c3hRE
         UndVtBcYacShlr3CJmDlqC2oXWlRoeiDmi1RrY2TENoqvXNt1paR7eIdZtlICxLCV1vx
         CTfbeEIHDeXi+kuEtrDU9Ar3WdEULJuTWdJSNqdUoNYJBBQnNIAtTP6fdtVQIfj2XORD
         ODd0ENUr47svLvtxzLKHsH7d2jHeh+2RKLJQ4mIQmQW2d8VbdBZP1S5HxEnTlSwQRnpu
         a2P5Spkb3FlI4ybbqHcazvdANQ6hCpVCmUFzxgbj8x5ifPbcgACclIKsB1bUmSBhdf6B
         SuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683118532; x=1685710532;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kYxRlCY3DiRAUyVahK0tkAYUy3+IuQkjxYPl95xXCw=;
        b=Dh8vU0GlUhrMaqtffTyNVyJF70/Akie+QXAPuftF02K/Qz/iRrGRopZVXpR1wm2Ha3
         6H/PTkr5zWiRt01anNKxUNsBSZbglxAQ5CUncXiU9ZYEBArm0KauSleNACSy+eyP5HPW
         4LN3HOzX0oJSvM2vlo1Th3uN2105engun1NGQ5SfxbdFB0MFBCr9dGd22S182PsamGEk
         vhUaVpInpKdwzsl2h+ZwS1K1BgX7yZ5zG79UvswuI5yn6YM0dC+UJKoZnRtQVelOB8z7
         phsTjlfN2gBRs/xFn/Zk8Mvp37j/t0V/+npsfTJEUfhZAgq01O9CUFlvlxSwbQM1tOQq
         Z8AQ==
X-Gm-Message-State: AC+VfDwUSsESttTxDGaFQrK3T914AIQn4/SyRMPuM86VBMM1wLyXbNvK
        BJeBw67LJojqcCwBWq7MNb5cpFHp04xd13Hzqac=
X-Google-Smtp-Source: ACHHUZ6M5whg5AQa7qA0Gb4FW+Z6M8VCHzQ4fzfLNRXh7lWyA7OgoKzaE2LRblCb+VFVh86YkxFY7A==
X-Received: by 2002:a17:907:6e0f:b0:953:7f08:a9ee with SMTP id sd15-20020a1709076e0f00b009537f08a9eemr1787966ejc.1.1683118531888;
        Wed, 03 May 2023 05:55:31 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id w1-20020a170906480100b0094f0f0de1bcsm17350222ejq.200.2023.05.03.05.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 05:55:31 -0700 (PDT)
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <ZFJGWwlRbSS3zFnc@x1-carbon>
User-agent: mu4e 1.10.3; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        open list <linux-kernel@vger.kernel.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 00/11] Rust null block driver
Date:   Wed, 03 May 2023 14:29:08 +0200
In-reply-to: <ZFJGWwlRbSS3zFnc@x1-carbon>
Message-ID: <87mt2l4lrw.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Niklas,

Niklas Cassel <Niklas.Cassel@wdc.com> writes:

> On Wed, May 03, 2023 at 11:06:57AM +0200, Andreas Hindborg wrote:
>> From: Andreas Hindborg <a.hindborg@samsung.com>
>> 
>
> (cut)
>
>> 
>> For each measurement the drivers are loaded, a drive is configured with memory
>> backing and a size of 4 GiB. C null_blk is configured to match the implemented
>> modes of the Rust driver: `blocksize` is set to 4 KiB, `completion_nsec` to 0,
>> `irqmode` to 0 (IRQ_NONE), `queue_mode` to 2 (MQ), `hw_queue_depth` to 256 and
>> `memory_backed` to 1. For both the drivers, the queue scheduler is set to
>> `none`. These measurements are made using 30 second runs of `fio` with the
>> `PSYNC` IO engine with workers pinned to separate CPU cores. The measurements
>> are done inside a virtual machine (qemu/kvm) on an Intel Alder Lake workstation
>> (i5-12600).
>
> Hello Andreas,
>
> I'm curious why you used psync ioengine for the benchmarks.
>
> As psync is a sync ioengine, it means queue depth == 1.
>
> Wouldn't it have been more interesting to see an async ioengine,
> together with different queue depths?

That would also be interesting. I was a bit constrained on CPU cycles so
I had to choose. I intend to produce the numbers you ask for. For now
here is two runs of random read using io_uring with queue depth 128
(same table style):


For iodepth_batch_submit=1, iodepth_batch_complete=1:
+---------+----------+---------------------+---------------------+
| jobs/bs | workload |          1          |          6          |
+---------+----------+---------------------+---------------------+
|    4k   | randread | 2.97 0.00 (0.9,0.0) | 4.06 0.00 (1.8,0.0) |
+---------+----------+---------------------+---------------------+

For iodepth_batch_submit=16, iodepth_batch_complete=16:
+---------+----------+---------------------+---------------------+
| jobs/bs | workload |          1          |          6          |
+---------+----------+---------------------+---------------------+
|    4k   | randread | 4.40 0.00 (1.1,0.0) | 4.87 0.00 (1.8,0.0) |
+---------+----------+---------------------+---------------------+

Above numbers are 60 second runs on bare metal, so not entirely
comparable with the ones in the cover letter.

> You might want to explain your table a bit more.

I understand that the table can be difficult to read. It is not easy to
convey all this information in ASCII email. The numbers in parenthesis
in the cells _are_ IOPS x 10e6 (read,write). Referring to he second
table above, for 1 job at 4k bs the Rust driver performed 4.8 percent
more IOPS than the C driver. The C driver did 1.1M IOPS. I hope this
clarifies the table, otherwise let me know!

> It might be nice to see IOPS and average latencies.

I did collect latency info as well, including completion latency
percentiles. It's just difficult to fit all that data in an email. I
have the fio json output, let me know if you want it and I will find a
way to get it to you. I am considering setting up some kind of CI that
will publish the performance results online automatically so that it
will be a link instead of an inline table.

>
> As an example of a table that I find easier to interpret,
> see e.g. the table on page 29 in the SPDK performance report:
> https://ci.spdk.io/download/performance-reports/SPDK_nvme_bdev_perf_report_2301.pdf

Thanks for the input, I will be sure to reference that next time. Just
for clarity, as you mentioned there is only one queue depth in play for
the numbers in the cover letter.

Best regards
Andreas
