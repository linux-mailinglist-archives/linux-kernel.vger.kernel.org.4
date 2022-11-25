Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB64638B42
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiKYNeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiKYNe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:34:29 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5401D27CE1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 05:34:28 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o5-20020a17090a678500b00218cd5a21c9so4162976pjj.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 05:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPjVEmqI7FcTxDQjOjFdkmZXOdhj/g4dR9UU5XqZtdo=;
        b=O3dV9w1EznnqADFI8HcfaP1tcl7bzoQWW4zf5eraPg2rOgS9vRJaZuljjONKu0gF9h
         tcs0R6/MKfPkBaPsSzY6ZqrBf5ISGy0WXmzRxuzWXDlj0OIKtU20MIypxCNhFiHe7Nj5
         AEt9L+DwkGeTu/MWXGDfID17tvy6pJnZw8C+4Dwa+ApcaRGi6rof+HINiZ39GponcGqy
         AG2PS+epA/XcG8T29bGeOxPLFxqEerOJijlV9/zHsS5R0c7QlThgZzgZ9nKGPhFdTl6u
         CaUk3ZksCZR996RcyL8UXmNTV+ABrcGZZ8f+dD4x2U8mD2sQw2+daLjueh4jc76s648H
         2o2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPjVEmqI7FcTxDQjOjFdkmZXOdhj/g4dR9UU5XqZtdo=;
        b=TgM2Gw5H0jBmyyGIlpa4InrxSgNT2OYgN6+TSQjeDivkt35qmHbSSX9aqkaDWOjbtW
         6/R4hz4JM+pj2vxKKc26FUD9x9XNy6nrplJCyhj7luKi6RzF8b43AgG2mEVZEG9O/5Eq
         /E/FOuc7fgrRKNpY08XStRJgvM1c0FgAedR1ymc2nI7D+OUedHMrPFbrkdLaUL4hz1hG
         IoFlrsaFw8TxrcxGW0j9AJN40uPdgv58M19WzFWUfu/hX15mKLkJmUxin5zQr6FtfnzB
         yg4vn/oXZtjlhLOZGBUKfK2IlfzxITt3fBD9N/GO4o/sDnWxY9v6XZtBwR6q33037iRd
         JTKA==
X-Gm-Message-State: ANoB5plDJQgh++3miS8NR9FJ3OYk5jX+GYlFcfqXlYByVdWoFo34+r+s
        4OuqCVfIWWEZ6yKfavKhMlCvUA==
X-Google-Smtp-Source: AA0mqf6eo32xt+wquQDb1/qpXiRb26CIfPGb9VQMeM20qi/Yqwf5T/k6XRavx/rLl/caSk/fa+58Og==
X-Received: by 2002:a17:902:ce8e:b0:174:b537:266d with SMTP id f14-20020a170902ce8e00b00174b537266dmr18444274plg.144.1669383267666;
        Fri, 25 Nov 2022 05:34:27 -0800 (PST)
Received: from [127.0.0.1] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id k145-20020a628497000000b0056246403534sm3071291pfd.88.2022.11.25.05.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 05:34:26 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ye Bin <yebin@huaweicloud.com>
Cc:     Ye Bin <yebin10@huawei.com>, ming.lei@redhat.com
In-Reply-To: <20221117022940.873959-1-yebin@huaweicloud.com>
References: <20221117022940.873959-1-yebin@huaweicloud.com>
Subject: Re: [PATCH] blk-mq: fix possible memleak when register 'hctx' failed
Message-Id: <166938326642.10648.1942082324154053183.b4-ty@kernel.dk>
Date:   Fri, 25 Nov 2022 06:34:26 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-28747
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2022 10:29:40 +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> There's issue as follows when do fault injection test:
> unreferenced object 0xffff888132a9f400 (size 512):
>   comm "insmod", pid 308021, jiffies 4324277909 (age 509.733s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 08 f4 a9 32 81 88 ff ff  ...........2....
>     08 f4 a9 32 81 88 ff ff 00 00 00 00 00 00 00 00  ...2............
>   backtrace:
>     [<00000000e8952bb4>] kmalloc_node_trace+0x22/0xa0
>     [<00000000f9980e0f>] blk_mq_alloc_and_init_hctx+0x3f1/0x7e0
>     [<000000002e719efa>] blk_mq_realloc_hw_ctxs+0x1e6/0x230
>     [<000000004f1fda40>] blk_mq_init_allocated_queue+0x27e/0x910
>     [<00000000287123ec>] __blk_mq_alloc_disk+0x67/0xf0
>     [<00000000a2a34657>] 0xffffffffa2ad310f
>     [<00000000b173f718>] 0xffffffffa2af824a
>     [<0000000095a1dabb>] do_one_initcall+0x87/0x2a0
>     [<00000000f32fdf93>] do_init_module+0xdf/0x320
>     [<00000000cbe8541e>] load_module+0x3006/0x3390
>     [<0000000069ed1bdb>] __do_sys_finit_module+0x113/0x1b0
>     [<00000000a1a29ae8>] do_syscall_64+0x35/0x80
>     [<000000009cd878b0>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> [...]

Applied, thanks!

[1/1] blk-mq: fix possible memleak when register 'hctx' failed
      commit: 4b7a21c57b14fbcd0e1729150189e5933f5088e9

Best regards,
-- 
Jens Axboe


