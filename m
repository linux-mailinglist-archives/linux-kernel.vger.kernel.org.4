Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D226F53EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjECJHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjECJHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:07:22 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52001FE3
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 02:07:16 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-2fddb442d47so4548839f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 02:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1683104835; x=1685696835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LQKppYVwf0SeSaMl9IKE/WZzNB7GDromyqxTafCG8fo=;
        b=M1w5GyuqmVVKXv2c8Jk8HydKYSHf++D2z0s0Td6pzIpnFDFE0DJAmUXUwzEz5tuOM3
         LEnsj1GusJ8DbKoMRoVVx0gORrompfxC+qx/Uzf1juvw5Z5f3D6jUpg9rq3gruzjNGjk
         Ywjm11lr7fMEGz7D2B1HzRFkOHfqEKDIAUUPJD1zz+Pxnoxx3dLvYqHSAfdsJINZTRyW
         CMWtAAZl171NljNk37xw5uWw2jK9LZQJFR1nx2jivXfEJSqtphTfEvqyBo5iNnKN/jcQ
         A+efKm11tUBku32haJ1k2ee3V6CfkqMI11+0FcKWNekMZvZmvVpUOkktEleA+KSUwZ7e
         /OLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683104835; x=1685696835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQKppYVwf0SeSaMl9IKE/WZzNB7GDromyqxTafCG8fo=;
        b=YFMoiItzLiPWTlw9lCWfcAY1ryv0nk47jxW502r8T//g8SixhzloyWoODLyfJxtMX/
         M7Klk/kGJh7kf3rtLScxDDSwzXEZzPpooT8OmPf9b7DXmR9VdYLNiRrGh5HAEOuFaxw8
         eXxUTMRwdZFOUjoqqPP8qtfrM3vzocEqf7DEJkkJSawTiI6o5v6gSeqk+T89rUgaH9nk
         hBBnSGVogTL6M96QTGVfqwWnL9SoKIDZ64st5nThlyLvudSHol06vwTEfdKO2rv3sT1e
         2hDG3TXZacFwPonuwdDjgmTYkfVdwvEP2IMXtKynO03rr4KODJYA73yWSnEkoFBdLqXH
         DdYw==
X-Gm-Message-State: AC+VfDxJRzqHIJJ+xBF7YWYCwEuC0Xj6bdLBJRuX+rzmw2nXgFVVOfZZ
        eUS0vby7InKZ3RHXFiY+shRDHQ==
X-Google-Smtp-Source: ACHHUZ6uB5Dhr8F+TRTCy2n35DQqOTOw290JmpRGN9zDp1UFaHs/YXs+RcAVSePF8gkQv2nKJfbqjw==
X-Received: by 2002:adf:eb0a:0:b0:306:3ded:2bf1 with SMTP id s10-20020adfeb0a000000b003063ded2bf1mr1720747wrn.60.1683104835021;
        Wed, 03 May 2023 02:07:15 -0700 (PDT)
Received: from localhost ([147.161.155.99])
        by smtp.gmail.com with ESMTPSA id c10-20020adffb0a000000b00306344eaebfsm4798159wrr.28.2023.05.03.02.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 02:07:14 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Andreas Hindborg <a.hindborg@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <nmi@metaspace.dk>,
        linux-kernel@vger.kernel.org (open list), gost.dev@samsung.com
Subject: [RFC PATCH 00/11] Rust null block driver
Date:   Wed,  3 May 2023 11:06:57 +0200
Message-Id: <20230503090708.2524310-1-nmi@metaspace.dk>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Hindborg <a.hindborg@samsung.com>

Hi All!

This is an early preview of a null block driver written in Rust. It is a follow
up to my LSF topic proposal [1]. I send this series with intention of collecting
feedback and comments at LSF/MM/BPF.

The patches apply on top of the `rust-next` tree (rust-6.4
ea76e08f4d901a450619831a255e9e0a4c0ed162) [4].

A null block driver is a good opportunity to evaluate Rust bindings for the
block layer. It is a small and simple driver and thus should be simple to reason
about. Further, the null block driver is not usually deployed in production
environments. Thus, it should be fairly straight forward to review, and any
potential issues are not going to bring down any production workloads.

Being small and simple, the null block driver is a good place to introduce the
Linux kernel storage community to Rust. This will help prepare the community for
future Rust projects and facilitate a better maintenance process for these
projects.

The statistics presented in my previous message [1] show that the C null block
driver has had a significant amount of memory safety related problems in the
past. 41% of fixes merged for the C null block driver are fixes for memory
safety issues. This makes the null block driver a good candidate for rewriting
in Rust.

Patches in this series prefixed with capitalized RUST are code taken from the
R4L `rust` tree [2]. This code is not yet in mainline Linux and has not yet been
submitted as patches for inclusion in Linux. I am not the original author of
these patches, except for small changes required to include them in this series.

The driver performs similarly to the C driver for the implemented features, see
table below [5].

In this table each cell shows the relative performance of the Rust
driver to the C driver with the throughput of the C driver in parenthesis:
`rel_read rel_write (read_miops write_miops)`. Ex: the Rust driver performs 4.74
percent better than the C driver for fio randread with 2 jobs at 16 KiB
block size.

Over the 432 benchmark configurations, the relative performance of the Rust
driver to the C driver (in terms of IOPS) is between 6.8 and -11.8 percent with
an average of 0.2 percent better for reads. For writes the span is 16.8 to -4.5
percent with an average of 0.9 percent better.

For each measurement the drivers are loaded, a drive is configured with memory
backing and a size of 4 GiB. C null_blk is configured to match the implemented
modes of the Rust driver: `blocksize` is set to 4 KiB, `completion_nsec` to 0,
`irqmode` to 0 (IRQ_NONE), `queue_mode` to 2 (MQ), `hw_queue_depth` to 256 and
`memory_backed` to 1. For both the drivers, the queue scheduler is set to
`none`. These measurements are made using 30 second runs of `fio` with the
`PSYNC` IO engine with workers pinned to separate CPU cores. The measurements
are done inside a virtual machine (qemu/kvm) on an Intel Alder Lake workstation
(i5-12600).

Given the relatively large spread in these numbers, it is possible that there is
quite a bit of noise in the results. If anybody is able to dedicate some CPU
time to run benchmarks in a more controlled and standardized environment, I
would appreciate it.

The feature list of the driver is relatively short for now:

 - `blk-mq` support
 - Direct completion of IO
 - Read and write requests
 - Optional memory backing

Features available in the C null_blk driver that are currently not implemented
in this work:

 - Bio-based submission
 - NUMA support
 - Block size configuration
 - Multiple devices
 - Dynamic device creation/destruction
 - Soft-IRQ and timer mode
 - Queue depth configuration
 - Queue count configuration
 - Discard operation support
 - Cache emulation
 - Bandwidth throttling
 - Per node hctx
 - IO scheduler configuration
 - Blocking submission mode
 - Shared tags configuration (for >1 device)
 - Zoned storage support
 - Bad block simulation
 - Poll queues

The driver is implemented entirely in safe Rust, with all unsafe code fully
contained in wrappers for C APIs.

Patches 07/11 and 08/11 that enable the equivalent of the C
`spin_lock_irqsave()` did appear on the Rust list [6,3] but was not applied to
`rust-next` tree yet [4]. I am not the author of these patches, but I include
them here for convenience. Please defer any discussion of these patches to their
original posts.

The null block driver is provided in patch 10/11. Patches 03/11 and 04/11
introduce Rust abstractions for the block C APIs required by the driver.


[1] https://lore.kernel.org/all/87y1ofj5tt.fsf@metaspace.dk/
[2] https://github.com/Rust-for-Linux/linux/tree/rust
[3] https://lore.kernel.org/all/20230411054543.21278-7-wedsonaf@gmail.com/
[4] https://github.com/Rust-for-Linux/linux/tree/rust-next
[6] https://lore.kernel.org/all/20230411054543.21278-6-wedsonaf@gmail.com/

[5]:
+---------+-----------+-------------------------------+-----------------------------+-------------------------------+
| jobs/bs |  workload |               1               |              2              |               3               |
+---------+-----------+-------------------------------+-----------------------------+-------------------------------+
|    4k   |  randread |      1.54 0.00 (0.7,0.0)      |     0.35 0.00 (1.3,0.0)     |      -0.52 0.00 (1.3,0.0)     |
|    8k   |  randread |      3.30 0.00 (0.57,0.0)     |     6.79 0.00 (0.92,0.0)    |      0.24 0.00 (0.97,0.0)     |
|   16k   |  randread |      0.89 0.00 (0.42,0.0)     |     4.74 0.00 (0.64,0.0)    |      3.98 0.00 (0.65,0.0)     |
|   32k   |  randread |      2.04 0.00 (0.27,0.0)     |     3.26 0.00 (0.37,0.0)    |      1.41 0.00 (0.37,0.0)     |
|   64k   |  randread |      1.35 0.00 (0.16,0.0)     |     0.71 0.00 (0.21,0.0)    |      0.66 0.00 (0.22,0.0)     |
|   128k  |  randread |      0.59 0.00 (0.09,0.0)     |     0.13 0.00 (0.1,0.0)     |     -6.47 0.00 (0.11,0.0)     |
|   256k  |  randread |     0.13 0.00 (0.048,0.0)     |    1.00 0.00 (0.055,0.0)    |     0.03 0.00 (0.059,0.0)     |
|   512k  |  randread |     1.16 0.00 (0.023,0.0)     |    -1.82 0.00 (0.027,0.0)   |     -0.90 0.00 (0.028,0.0)    |
|  1024k  |  randread |     0.14 0.00 (0.011,0.0)     |    0.58 0.00 (0.012,0.0)    |     -1.14 0.00 (0.013,0.0)    |
|  2048k  |  randread |     2.02 0.00 (0.005,0.0)     |    0.13 0.00 (0.0062,0.0)   |    -0.37 0.00 (0.0062,0.0)    |
|  4096k  |  randread |     1.21 0.00 (0.0026,0.0)    |   -5.68 0.00 (0.0031,0.0)   |    -2.39 0.00 (0.0029,0.0)    |
|  8192k  |  randread |    -1.02 0.00 (0.0013,0.0)    |    0.66 0.00 (0.0013,0.0)   |    -1.72 0.00 (0.0013,0.0)    |
|    4k   |   randrw  |     2.82 2.82 (0.25,0.25)     |     2.94 2.94 (0.3,0.3)     |     3.19 3.20 (0.34,0.34)     |
|    8k   |   randrw  |     2.80 2.82 (0.21,0.21)     |    2.32 2.32 (0.25,0.25)    |     1.95 1.96 (0.28,0.28)     |
|   16k   |   randrw  |     4.54 4.52 (0.16,0.16)     |     2.29 2.29 (0.2,0.2)     |     2.27 2.30 (0.21,0.21)     |
|   32k   |   randrw  |     3.51 3.51 (0.11,0.11)     |    2.43 2.40 (0.13,0.13)    |     1.38 1.38 (0.14,0.14)     |
|   64k   |   randrw  |    2.40 2.42 (0.069,0.069)    |    1.98 1.99 (0.08,0.08)    |    0.51 0.51 (0.082,0.082)    |
|   128k  |   randrw  |    1.50 1.49 (0.039,0.039)    |   1.28 1.27 (0.042,0.042)   |    0.83 0.84 (0.043,0.043)    |
|   256k  |   randrw  |    2.02 2.06 (0.021,0.021)    |   0.92 0.91 (0.022,0.022)   |    0.70 0.75 (0.022,0.022)    |
|   512k  |   randrw  |    0.82 0.82 (0.011,0.011)    |   0.69 0.70 (0.011,0.011)   |    0.97 0.98 (0.011,0.011)    |
|  1024k  |   randrw  |   3.78 3.84 (0.0046,0.0046)   |  0.98 0.98 (0.0053,0.0053)  |   1.30 1.29 (0.0054,0.0054)   |
|  2048k  |   randrw  |   1.60 1.54 (0.0023,0.0023)   |  1.76 1.69 (0.0026,0.0026)  |   1.23 0.92 (0.0026,0.0026)   |
|  4096k  |   randrw  |   1.18 1.10 (0.0011,0.0012)   |  1.32 1.20 (0.0014,0.0014)  |   1.49 1.41 (0.0013,0.0013)   |
|  8192k  |   randrw  | -2.01 -1.89 (0.00057,0.00057) | 1.20 1.14 (0.00061,0.00061) |  -0.74 -0.61 (0.0006,0.00062) |
|    4k   | randwrite |      0.00 2.48 (0.0,0.41)     |     0.00 3.61 (0.0,0.39)    |      0.00 3.93 (0.0,0.44)     |
|    8k   | randwrite |      0.00 3.46 (0.0,0.35)     |     0.00 1.90 (0.0,0.34)    |      0.00 2.20 (0.0,0.37)     |
|   16k   | randwrite |      0.00 3.01 (0.0,0.28)     |     0.00 2.86 (0.0,0.27)    |      0.00 2.25 (0.0,0.29)     |
|   32k   | randwrite |      0.00 3.02 (0.0,0.19)     |     0.00 2.68 (0.0,0.19)    |      0.00 2.20 (0.0,0.21)     |
|   64k   | randwrite |      0.00 3.39 (0.0,0.12)     |     0.00 3.75 (0.0,0.12)    |     0.00 -0.79 (0.0,0.14)     |
|   128k  | randwrite |     0.00 3.81 (0.0,0.069)     |    0.00 1.10 (0.0,0.072)    |     0.00 5.48 (0.0,0.078)     |
|   256k  | randwrite |     0.00 4.28 (0.0,0.038)     |    0.00 1.27 (0.0,0.037)    |     0.00 -0.10 (0.0,0.041)    |
|   512k  | randwrite |     0.00 2.71 (0.0,0.019)     |    0.00 0.46 (0.0,0.017)    |     0.00 2.96 (0.0,0.019)     |
|  1024k  | randwrite |     0.00 2.67 (0.0,0.0082)    |    0.00 2.54 (0.0,0.0087)   |     0.00 0.20 (0.0,0.0093)    |
|  2048k  | randwrite |     0.00 2.40 (0.0,0.0041)    |    0.00 1.90 (0.0,0.0041)   |     0.00 3.44 (0.0,0.0043)    |
|  4096k  | randwrite |     0.00 3.38 (0.0,0.002)     |    0.00 1.69 (0.0,0.0025)   |     0.00 6.00 (0.0,0.0025)    |
|  8192k  | randwrite |    0.00 3.09 (0.0,0.00098)    |    0.00 1.10 (0.0,0.0012)   |     0.00 0.45 (0.0,0.0012)    |
|    4k   |    read   |      1.26 0.00 (1.0,0.0)      |     1.65 0.00 (2.0,0.0)     |      -9.94 0.00 (2.8,0.0)     |
|    8k   |    read   |      1.86 0.00 (0.78,0.0)     |     4.60 0.00 (1.5,0.0)     |      0.47 0.00 (1.7,0.0)      |
|   16k   |    read   |      1.13 0.00 (0.54,0.0)     |     4.00 0.00 (0.95,0.0)    |     -10.28 0.00 (0.97,0.0)    |
|   32k   |    read   |      0.64 0.00 (0.32,0.0)     |     5.54 0.00 (0.46,0.0)    |     -0.67 0.00 (0.47,0.0)     |
|   64k   |    read   |      0.29 0.00 (0.18,0.0)     |    -0.08 0.00 (0.25,0.0)    |     -0.82 0.00 (0.25,0.0)     |
|   128k  |    read   |     0.11 0.00 (0.095,0.0)     |     0.12 0.00 (0.11,0.0)    |     -4.99 0.00 (0.12,0.0)     |
|   256k  |    read   |      1.66 0.00 (0.05,0.0)     |    -0.41 0.00 (0.058,0.0)   |     -0.30 0.00 (0.061,0.0)    |
|   512k  |    read   |     1.06 0.00 (0.024,0.0)     |    -1.77 0.00 (0.029,0.0)   |     0.81 0.00 (0.029,0.0)     |
|  1024k  |    read   |     0.41 0.00 (0.011,0.0)     |    -2.28 0.00 (0.013,0.0)   |     -0.33 0.00 (0.013,0.0)    |
|  2048k  |    read   |    -1.18 0.00 (0.0053,0.0)    |    1.41 0.00 (0.0063,0.0)   |    -0.86 0.00 (0.0063,0.0)    |
|  4096k  |    read   |    -0.54 0.00 (0.0027,0.0)    |   -11.77 0.00 (0.0031,0.0)  |     0.02 0.00 (0.003,0.0)     |
|  8192k  |    read   |    -1.60 0.00 (0.0013,0.0)    |   -4.25 0.00 (0.0013,0.0)   |    -1.64 0.00 (0.0013,0.0)    |
|    4k   | readwrite |     1.01 1.01 (0.34,0.34)     |    1.00 1.00 (0.42,0.42)    |     1.30 1.29 (0.45,0.44)     |
|    8k   | readwrite |     1.54 1.54 (0.28,0.28)     |    1.65 1.66 (0.32,0.32)    |     1.18 1.18 (0.36,0.36)     |
|   16k   | readwrite |      1.07 1.08 (0.2,0.2)      |    2.82 2.81 (0.24,0.24)    |     0.40 0.39 (0.26,0.26)     |
|   32k   | readwrite |     0.56 0.56 (0.13,0.13)     |   -1.31 -1.30 (0.16,0.16)   |     0.09 0.09 (0.16,0.16)     |
|   64k   | readwrite |    1.82 1.83 (0.077,0.077)    |  -0.96 -0.96 (0.091,0.091)  |   -0.99 -0.97 (0.092,0.092)   |
|   128k  | readwrite |    2.09 2.10 (0.041,0.041)    |   1.07 1.06 (0.045,0.045)   |    0.28 0.29 (0.045,0.045)    |
|   256k  | readwrite |    2.06 2.05 (0.022,0.022)    |   1.84 1.85 (0.023,0.023)   |    0.66 0.59 (0.023,0.023)    |
|   512k  | readwrite |     5.90 5.84 (0.01,0.01)     |   1.20 1.17 (0.011,0.011)   |    1.18 1.21 (0.011,0.011)    |
|  1024k  | readwrite |   1.94 1.89 (0.0047,0.0047)   |  2.43 2.48 (0.0053,0.0053)  |   2.18 2.21 (0.0054,0.0054)   |
|  2048k  | readwrite |  -0.47 -0.47 (0.0023,0.0023)  |  2.45 2.38 (0.0026,0.0026)  |   1.76 1.78 (0.0026,0.0026)   |
|  4096k  | readwrite |   1.88 1.77 (0.0011,0.0012)   |  1.37 1.17 (0.0014,0.0014)  |   1.80 1.90 (0.0013,0.0013)   |
|  8192k  | readwrite |  1.27 1.42 (0.00057,0.00057)  | 0.86 0.73 (0.00061,0.00062) | -0.99 -1.28 (0.00061,0.00062) |
|    4k   |   write   |      0.00 1.53 (0.0,0.51)     |     0.00 0.35 (0.0,0.51)    |      0.00 0.92 (0.0,0.52)     |
|    8k   |   write   |      0.00 1.04 (0.0,0.42)     |     0.00 1.01 (0.0,0.4)     |      0.00 2.90 (0.0,0.44)     |
|   16k   |   write   |      0.00 0.86 (0.0,0.32)     |     0.00 1.89 (0.0,0.35)    |     0.00 -1.38 (0.0,0.36)     |
|   32k   |   write   |      0.00 0.47 (0.0,0.21)     |    0.00 -0.52 (0.0,0.26)    |     0.00 -1.40 (0.0,0.24)     |
|   64k   |   write   |      0.00 0.30 (0.0,0.13)     |    0.00 13.34 (0.0,0.14)    |      0.00 2.01 (0.0,0.15)     |
|   128k  |   write   |     0.00 2.24 (0.0,0.073)     |    0.00 16.77 (0.0,0.076)   |     0.00 -0.36 (0.0,0.085)    |
|   256k  |   write   |     0.00 3.49 (0.0,0.039)     |    0.00 9.76 (0.0,0.039)    |     0.00 -4.52 (0.0,0.043)    |
|   512k  |   write   |      0.00 4.08 (0.0,0.02)     |    0.00 1.03 (0.0,0.017)    |     0.00 1.05 (0.0,0.019)     |
|  1024k  |   write   |     0.00 2.72 (0.0,0.0083)    |    0.00 2.89 (0.0,0.0086)   |     0.00 2.98 (0.0,0.0095)    |
|  2048k  |   write   |     0.00 2.14 (0.0,0.0041)    |    0.00 3.12 (0.0,0.0041)   |     0.00 1.84 (0.0,0.0044)    |
|  4096k  |   write   |     0.00 1.76 (0.0,0.002)     |    0.00 1.80 (0.0,0.0026)   |     0.00 6.01 (0.0,0.0025)    |
|  8192k  |   write   |    0.00 1.41 (0.0,0.00099)    |    0.00 0.98 (0.0,0.0012)   |     0.00 0.13 (0.0,0.0012)    |
+---------+-----------+-------------------------------+-----------------------------+-------------------------------+

+---------+-----------+-------------------------------+------------------------------+-------------------------------+
| jobs/bs |  workload |               4               |              5               |               6               |
+---------+-----------+-------------------------------+------------------------------+-------------------------------+
|    4k   |  randread |      1.66 0.00 (1.3,0.0)      |     -0.81 0.00 (1.3,0.0)     |      -0.50 0.00 (1.2,0.0)     |
|    8k   |  randread |      2.52 0.00 (0.98,0.0)     |     2.54 0.00 (0.95,0.0)     |      2.52 0.00 (0.92,0.0)     |
|   16k   |  randread |      0.68 0.00 (0.65,0.0)     |     3.43 0.00 (0.64,0.0)     |      5.84 0.00 (0.63,0.0)     |
|   32k   |  randread |      1.88 0.00 (0.38,0.0)     |     0.46 0.00 (0.38,0.0)     |      2.33 0.00 (0.37,0.0)     |
|   64k   |  randread |      1.28 0.00 (0.21,0.0)     |     0.64 0.00 (0.21,0.0)     |     -0.26 0.00 (0.21,0.0)     |
|   128k  |  randread |     -0.05 0.00 (0.11,0.0)     |     0.10 0.00 (0.11,0.0)     |      0.09 0.00 (0.11,0.0)     |
|   256k  |  randread |     -0.01 0.00 (0.059,0.0)    |    -1.01 0.00 (0.059,0.0)    |     -0.39 0.00 (0.059,0.0)    |
|   512k  |  randread |     -1.17 0.00 (0.029,0.0)    |    0.39 0.00 (0.028,0.0)     |     -0.33 0.00 (0.028,0.0)    |
|  1024k  |  randread |     -0.20 0.00 (0.013,0.0)    |    -0.85 0.00 (0.013,0.0)    |     -0.57 0.00 (0.013,0.0)    |
|  2048k  |  randread |    -0.07 0.00 (0.0062,0.0)    |   -0.26 0.00 (0.0061,0.0)    |     -0.15 0.00 (0.006,0.0)    |
|  4096k  |  randread |    -0.25 0.00 (0.0027,0.0)    |   -2.70 0.00 (0.0027,0.0)    |    -2.35 0.00 (0.0026,0.0)    |
|  8192k  |  randread |    -2.94 0.00 (0.0013,0.0)    |   -3.01 0.00 (0.0012,0.0)    |    -2.09 0.00 (0.0012,0.0)    |
|    4k   |   randrw  |     2.83 2.84 (0.36,0.36)     |    2.24 2.23 (0.37,0.37)     |     3.49 3.50 (0.38,0.38)     |
|    8k   |   randrw  |     1.31 1.32 (0.29,0.29)     |     2.01 2.01 (0.3,0.3)      |      2.09 2.09 (0.3,0.3)      |
|   16k   |   randrw  |     1.96 1.95 (0.22,0.22)     |    1.61 1.61 (0.22,0.22)     |     1.99 2.00 (0.22,0.22)     |
|   32k   |   randrw  |     1.01 1.03 (0.14,0.14)     |    0.58 0.59 (0.14,0.14)     |    -0.04 -0.05 (0.14,0.14)    |
|   64k   |   randrw  |   -0.19 -0.18 (0.081,0.081)   |  -0.72 -0.72 (0.081,0.081)   |   -0.50 -0.50 (0.081,0.081)   |
|   128k  |   randrw  |    0.42 0.42 (0.043,0.043)    |  -0.33 -0.36 (0.043,0.043)   |   -0.62 -0.59 (0.043,0.043)   |
|   256k  |   randrw  |    0.38 0.41 (0.022,0.022)    |  -0.35 -0.35 (0.022,0.022)   |    0.37 0.31 (0.022,0.022)    |
|   512k  |   randrw  |    0.40 0.41 (0.011,0.011)    |  -0.29 -0.26 (0.011,0.011)   |     2.76 2.48 (0.01,0.01)     |
|  1024k  |   randrw  |   1.16 1.01 (0.0052,0.0052)   |  0.74 0.72 (0.0051,0.0051)   |    1.72 1.77 (0.005,0.005)    |
|  2048k  |   randrw  |   1.09 0.96 (0.0026,0.0026)   |  1.19 1.57 (0.0026,0.0026)   |   1.49 1.21 (0.0025,0.0025)   |
|  4096k  |   randrw  |   -0.13 0.06 (0.0013,0.0013)  |  0.69 0.77 (0.0013,0.0013)   |  -0.20 -0.13 (0.0012,0.0012)  |
|  8192k  |   randrw  | -0.71 -1.27 (0.00059,0.00061) | -1.78 -2.02 (0.00059,0.0006) | -1.60 -1.25 (0.00058,0.00059) |
|    4k   | randwrite |      0.00 2.17 (0.0,0.44)     |     0.00 4.08 (0.0,0.45)     |      0.00 5.47 (0.0,0.46)     |
|    8k   | randwrite |      0.00 0.98 (0.0,0.38)     |     0.00 2.39 (0.0,0.39)     |      0.00 2.30 (0.0,0.4)      |
|   16k   | randwrite |      0.00 2.02 (0.0,0.3)      |     0.00 2.63 (0.0,0.3)      |      0.00 3.17 (0.0,0.3)      |
|   32k   | randwrite |      0.00 1.82 (0.0,0.21)     |     0.00 1.12 (0.0,0.22)     |      0.00 1.40 (0.0,0.21)     |
|   64k   | randwrite |      0.00 1.41 (0.0,0.14)     |     0.00 1.92 (0.0,0.13)     |      0.00 1.76 (0.0,0.13)     |
|   128k  | randwrite |     0.00 2.32 (0.0,0.075)     |    0.00 4.61 (0.0,0.074)     |     0.00 2.31 (0.0,0.074)     |
|   256k  | randwrite |     0.00 -0.77 (0.0,0.038)    |    0.00 2.61 (0.0,0.036)     |     0.00 2.48 (0.0,0.036)     |
|   512k  | randwrite |     0.00 1.83 (0.0,0.019)     |    0.00 1.68 (0.0,0.018)     |     0.00 2.80 (0.0,0.018)     |
|  1024k  | randwrite |     0.00 3.32 (0.0,0.0086)    |    0.00 1.20 (0.0,0.0087)    |     0.00 0.92 (0.0,0.0081)    |
|  2048k  | randwrite |     0.00 0.92 (0.0,0.0043)    |    0.00 2.95 (0.0,0.0042)    |     0.00 3.15 (0.0,0.0042)    |
|  4096k  | randwrite |     0.00 3.22 (0.0,0.0025)    |    0.00 0.50 (0.0,0.0024)    |     0.00 0.40 (0.0,0.0024)    |
|  8192k  | randwrite |    0.00 -0.57 (0.0,0.0012)    |   0.00 -0.41 (0.0,0.0011)    |    0.00 -0.36 (0.0,0.0011)    |
|    4k   |    read   |      4.34 0.00 (2.5,0.0)      |     -0.40 0.00 (2.6,0.0)     |      -8.45 0.00 (2.6,0.0)     |
|    8k   |    read   |      -1.43 0.00 (1.7,0.0)     |     0.01 0.00 (1.7,0.0)      |      -3.89 0.00 (1.7,0.0)     |
|   16k   |    read   |      1.68 0.00 (0.96,0.0)     |    -0.38 0.00 (0.94,0.0)     |      0.47 0.00 (0.91,0.0)     |
|   32k   |    read   |     -0.98 0.00 (0.48,0.0)     |    -0.09 0.00 (0.47,0.0)     |     -1.24 0.00 (0.47,0.0)     |
|   64k   |    read   |     -0.42 0.00 (0.25,0.0)     |    -0.26 0.00 (0.25,0.0)     |     -0.94 0.00 (0.25,0.0)     |
|   128k  |    read   |     -0.49 0.00 (0.12,0.0)     |     0.06 0.00 (0.12,0.0)     |     -0.59 0.00 (0.12,0.0)     |
|   256k  |    read   |     -0.89 0.00 (0.062,0.0)    |    -0.11 0.00 (0.062,0.0)    |     -0.77 0.00 (0.062,0.0)    |
|   512k  |    read   |     -0.64 0.00 (0.03,0.0)     |    -0.11 0.00 (0.03,0.0)     |      0.08 0.00 (0.03,0.0)     |
|  1024k  |    read   |     0.00 0.00 (0.013,0.0)     |    -0.05 0.00 (0.013,0.0)    |     0.42 0.00 (0.013,0.0)     |
|  2048k  |    read   |    -0.69 0.00 (0.0063,0.0)    |   -0.36 0.00 (0.0063,0.0)    |     1.12 0.00 (0.006,0.0)     |
|  4096k  |    read   |    -2.69 0.00 (0.0029,0.0)    |   -1.85 0.00 (0.0027,0.0)    |    -1.13 0.00 (0.0026,0.0)    |
|  8192k  |    read   |    -2.15 0.00 (0.0013,0.0)    |   -1.66 0.00 (0.0013,0.0)    |    -2.90 0.00 (0.0012,0.0)    |
|    4k   | readwrite |     0.32 0.32 (0.46,0.46)     |    0.68 0.69 (0.47,0.47)     |     -0.26 -0.26 (0.5,0.5)     |
|    8k   | readwrite |     0.18 0.18 (0.37,0.37)     |    0.77 0.76 (0.38,0.38)     |    -0.47 -0.48 (0.39,0.39)    |
|   16k   | readwrite |     0.24 0.25 (0.27,0.27)     |   -0.17 -0.15 (0.27,0.27)    |    -0.51 -0.52 (0.27,0.27)    |
|   32k   | readwrite |    -0.91 -0.91 (0.17,0.17)    |   -1.40 -1.37 (0.17,0.17)    |    -1.67 -1.70 (0.17,0.17)    |
|   64k   | readwrite |    -1.22 -1.21 (0.09,0.09)    |   -1.33 -1.30 (0.09,0.09)    |   -2.49 -2.50 (0.091,0.091)   |
|   128k  | readwrite |   -0.67 -0.69 (0.045,0.045)   |  -1.23 -1.24 (0.045,0.045)   |   -1.01 -0.96 (0.045,0.045)   |
|   256k  | readwrite |   -0.31 -0.35 (0.023,0.023)   |  -0.28 -0.28 (0.023,0.023)   |    0.25 0.08 (0.022,0.023)    |
|   512k  | readwrite |    0.77 0.72 (0.011,0.011)    |   0.96 0.96 (0.011,0.011)    |    0.62 1.16 (0.011,0.011)    |
|  1024k  | readwrite |   0.93 0.91 (0.0053,0.0053)   |  0.72 0.78 (0.0051,0.0051)   |  -0.48 -0.10 (0.0051,0.0051)  |
|  2048k  | readwrite |   1.84 1.77 (0.0026,0.0026)   |  0.86 0.71 (0.0026,0.0026)   |   0.31 1.37 (0.0026,0.0026)   |
|  4096k  | readwrite |   2.71 2.43 (0.0013,0.0013)   |  1.54 1.73 (0.0013,0.0013)   |  -1.18 -0.79 (0.0012,0.0013)  |
|  8192k  | readwrite |  -2.61 -1.52 (0.0006,0.00061) | -1.83 -1.27 (0.00059,0.0006) | -2.25 -1.53 (0.00059,0.00059) |
|    4k   |   write   |     0.00 -2.94 (0.0,0.53)     |    0.00 -2.23 (0.0,0.57)     |      0.00 0.93 (0.0,0.56)     |
|    8k   |   write   |     0.00 -1.78 (0.0,0.45)     |    0.00 -1.14 (0.0,0.47)     |      0.00 0.47 (0.0,0.47)     |
|   16k   |   write   |     0.00 -1.46 (0.0,0.35)     |    0.00 -1.46 (0.0,0.36)     |      0.00 0.25 (0.0,0.36)     |
|   32k   |   write   |     0.00 -1.05 (0.0,0.24)     |    0.00 -1.53 (0.0,0.24)     |     0.00 -0.74 (0.0,0.24)     |
|   64k   |   write   |     0.00 -2.78 (0.0,0.15)     |     0.00 1.39 (0.0,0.15)     |     0.00 -2.42 (0.0,0.15)     |
|   128k  |   write   |     0.00 -0.03 (0.0,0.082)    |    0.00 0.32 (0.0,0.081)     |     0.00 2.76 (0.0,0.079)     |
|   256k  |   write   |     0.00 -0.33 (0.0,0.039)    |    0.00 -0.32 (0.0,0.038)    |     0.00 -2.37 (0.0,0.038)    |
|   512k  |   write   |     0.00 4.00 (0.0,0.019)     |     0.00 6.45 (0.0,0.02)     |     0.00 2.94 (0.0,0.019)     |
|  1024k  |   write   |     0.00 1.22 (0.0,0.0088)    |    0.00 1.57 (0.0,0.0088)    |    0.00 -3.98 (0.0,0.0087)    |
|  2048k  |   write   |     0.00 0.05 (0.0,0.0043)    |    0.00 3.33 (0.0,0.0044)    |     0.00 8.69 (0.0,0.0044)    |
|  4096k  |   write   |     0.00 2.36 (0.0,0.0025)    |    0.00 1.52 (0.0,0.0024)    |     0.00 0.44 (0.0,0.0024)    |
|  8192k  |   write   |    0.00 -0.35 (0.0,0.0012)    |   0.00 -0.45 (0.0,0.0011)    |    0.00 -0.73 (0.0,0.0011)    |
+---------+-----------+-------------------------------+------------------------------+-------------------------------+


Andreas Hindborg (9):
  rust: add radix tree abstraction
  rust: add `pages` module for handling page allocation
  rust: block: introduce `kernel::block::mq` module
  rust: block: introduce `kernel::block::bio` module
  RUST: add `module_params` macro
  rust: apply cache line padding for `SpinLock`
  RUST: implement `ForeignOwnable` for `Pin`
  rust: add null block driver
  rust: inline a number of short functions

Wedson Almeida Filho (2):
  rust: lock: add support for `Lock::lock_irqsave`
  rust: lock: implement `IrqSaveBackend` for `SpinLock`

 drivers/block/Kconfig              |   4 +
 drivers/block/Makefile             |   4 +
 drivers/block/rnull-helpers.c      |  60 ++++
 drivers/block/rnull.rs             | 177 ++++++++++
 rust/bindings/bindings_helper.h    |   4 +
 rust/bindings/lib.rs               |   1 +
 rust/helpers.c                     |  91 ++++++
 rust/kernel/block.rs               |   6 +
 rust/kernel/block/bio.rs           |  93 ++++++
 rust/kernel/block/bio/vec.rs       | 181 +++++++++++
 rust/kernel/block/mq.rs            |  15 +
 rust/kernel/block/mq/gen_disk.rs   | 133 ++++++++
 rust/kernel/block/mq/operations.rs | 260 +++++++++++++++
 rust/kernel/block/mq/raw_writer.rs |  30 ++
 rust/kernel/block/mq/request.rs    |  87 +++++
 rust/kernel/block/mq/tag_set.rs    |  92 ++++++
 rust/kernel/cache_padded.rs        |  33 ++
 rust/kernel/error.rs               |   4 +
 rust/kernel/lib.rs                 |  13 +
 rust/kernel/module_param.rs        | 501 +++++++++++++++++++++++++++++
 rust/kernel/pages.rs               | 284 ++++++++++++++++
 rust/kernel/radix_tree.rs          | 156 +++++++++
 rust/kernel/sync/lock.rs           |  49 ++-
 rust/kernel/sync/lock/mutex.rs     |   2 +
 rust/kernel/sync/lock/spinlock.rs  |  50 ++-
 rust/kernel/types.rs               |  30 ++
 rust/macros/helpers.rs             |  46 ++-
 rust/macros/module.rs              | 402 +++++++++++++++++++++--
 scripts/Makefile.build             |   2 +-
 29 files changed, 2766 insertions(+), 44 deletions(-)
 create mode 100644 drivers/block/rnull-helpers.c
 create mode 100644 drivers/block/rnull.rs
 create mode 100644 rust/kernel/block.rs
 create mode 100644 rust/kernel/block/bio.rs
 create mode 100644 rust/kernel/block/bio/vec.rs
 create mode 100644 rust/kernel/block/mq.rs
 create mode 100644 rust/kernel/block/mq/gen_disk.rs
 create mode 100644 rust/kernel/block/mq/operations.rs
 create mode 100644 rust/kernel/block/mq/raw_writer.rs
 create mode 100644 rust/kernel/block/mq/request.rs
 create mode 100644 rust/kernel/block/mq/tag_set.rs
 create mode 100644 rust/kernel/cache_padded.rs
 create mode 100644 rust/kernel/module_param.rs
 create mode 100644 rust/kernel/pages.rs
 create mode 100644 rust/kernel/radix_tree.rs


base-commit: ea76e08f4d901a450619831a255e9e0a4c0ed162
-- 
2.40.0

