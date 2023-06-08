Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B07728B3D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 00:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbjFHWua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 18:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjFHWu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 18:50:28 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3FD2D59
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 15:50:27 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-653fcd58880so976945b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 15:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686264626; x=1688856626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6luut61uqU4fANMPFzraWacgCeHAb+K+QzesfcLcZz0=;
        b=phHGMX7mmxF0hKooMNbDU8AR5Zo+AYuKDqgvjNyAXNGqdcDnuzQbvPb51ca39A+nMA
         xBcfDu91SNNdpPgAsEm4/9kF4mYx7vZ8aypBVYxl/Z5n0y3bumCwUhQlw9fsNT6fxygS
         O7M974GYqJaf1D/5m0IuHBhdSfSbg1HX2M4JPTsFmyB+18BRphQ/JwLPGb1OULLlTTXb
         YrxENn4i84Q0ldlfpJwgKN5SXKzEN44inkm4cBCJDfPJuvXAF7t5zEjr/w3Om2Ln8T5s
         Yjbuf2NrP0EeU/cihULlPhD9FTCKNQEPnCFHqi/korHyVQPu3ZZifCmkF3uJnPMlfWkt
         BC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686264626; x=1688856626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6luut61uqU4fANMPFzraWacgCeHAb+K+QzesfcLcZz0=;
        b=F4pJm0e3d4pnrpG1eioJ/A8zbGBiK7Dqibql0mcUDBsZy6jOrSr9dIJo1bkfyAyfxU
         aLiAUGp6zt+5UYvVpZBkLIup7C73ubyE/Df4VT48pJtbTeazXno/euUb+KEC/6H7DMTn
         tyZkkjbMqWMAbmvsjl35lXZzBNjnq2da4vxn3spYplAk6TTyw260gMPLoatKvzB476DY
         ATdfzYX2wbAxGNaf+HP2VvTn+ewGsAWvSBLjDofQ6GQzU6znikbr97bUH0YKCNDU99UL
         kvd6h/cCU63IY9/C8EgpjhYc2ytl3+CqO9TDe1Be6YQ+LJUwB7GCW3zRSZyaJyoOcSgr
         FrIQ==
X-Gm-Message-State: AC+VfDzq4pq5ravN+awU2P5qIndEJwtJH05uhKHmRhROXR8CVOnCID6d
        wm5KnyUSzf8EVRRkIW0/tMM=
X-Google-Smtp-Source: ACHHUZ4SJdF75GTDFPh0b0uzMk3+EmgL20sUGOiGHJVnvMK5xNg827zd//Y3Swby+u3681xdKAiMPQ==
X-Received: by 2002:a05:6a20:d80d:b0:10c:5745:3f44 with SMTP id iv13-20020a056a20d80d00b0010c57453f44mr4725187pzb.61.1686264625913;
        Thu, 08 Jun 2023 15:50:25 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id z24-20020a63c058000000b0051ba9d772f9sm1718588pgi.59.2023.06.08.15.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 15:50:25 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 8 Jun 2023 12:50:25 -1000
From:   Tejun Heo <tj@kernel.org>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     Sandeep Dhavale <dhavale@google.com>, jiangshanlai@gmail.com,
        torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, kernel-team@android.com
Subject: Re: [PATCH 14/24] workqueue: Generalize unbound CPU pods
Message-ID: <ZIJbMQOu_k07jkFf@slm.duckdns.org>
References: <20230519001709.2563-1-tj@kernel.org>
 <20230519001709.2563-15-tj@kernel.org>
 <CAB=BE-S=cxewXu7nqJY1DC5w9Bapar_C0cTjpZOQ-Qd5GGwYyw@mail.gmail.com>
 <c307ba94-0d8c-3cbf-19da-44ee31751428@amd.com>
 <ZIEBB-A1arYKSK2P@slm.duckdns.org>
 <fb3461cd-3fc2-189a-a86b-c638816a2440@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb3461cd-3fc2-189a-a86b-c638816a2440@amd.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jun 08, 2023 at 08:31:34AM +0530, K Prateek Nayak wrote:
...
> Thank you for sharing the debug branch. I've managed to hit some one of
> the WARN_ON_ONCE() consistently but I still haven't seen a kernel panic
> yet. Sharing the traces below:

Yeah, that's good. It does a dirty fix-up. Shouldn't crash.

> o Early Boot
> 
>     [    4.182411] ------------[ cut here ]------------
>     [    4.186313] WARNING: CPU: 0 PID: 1 at kernel/workqueue.c:1130 kick_pool+0xdb/0xe0
>     [    4.186313] Modules linked in:
>     [    4.186313] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.4.0-rc1-tj-wq-valid-cpu+ #481
>     [    4.186313] Hardware name: Dell Inc. PowerEdge R6525/024PW1, BIOS 2.7.3 03/30/2022
>     [    4.186313] RIP: 0010:kick_pool+0xdb/0xe0
>     [    4.186313] Code: 6b c0 d0 01 73 24 41 89 45 64 49 8b 54 24 f8 48 89 d0 30 c0 83 e2 04 ba 00 00 00 00 48 0f 44 c2 48 83 80 c0 00 00 00 01 eb 82 <0f> 0b eb dc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f
>     [    4.186313] RSP: 0018:ffffbc1b800e7dd8 EFLAGS: 00010046
>     [    4.186313] RAX: 0000000000000100 RBX: ffff97c73d2321c0 RCX: 0000000000000000
>     [    4.186313] RDX: 0000000000000040 RSI: 0000000000000001 RDI: ffff9788c0159728
>     [    4.186313] RBP: ffffbc1b800e7df0 R08: 0000000000000100 R09: ffff9788c01593e0
>     [    4.186313] R10: ffff9788c01593c0 R11: 0000000000000001 R12: ffffffff8c582430
>     [    4.186313] R13: ffff9788c03fcd40 R14: 0000000000000000 R15: ffff97c73d2324b0
>     [    4.186313] FS:  0000000000000000(0000) GS:ffff97c73d200000(0000) knlGS:0000000000000000
>     [    4.186313] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     [    4.186313] CR2: ffff97cecee01000 CR3: 000000470d43a001 CR4: 0000000000770ef0
>     [    4.186313] PKRU: 55555554
>     [    4.186313] Call Trace:
>     [    4.186313]  <TASK>
>     [    4.186313]  create_worker+0x14e/0x280
>     [    4.186313]  ? wake_up_process+0x15/0x20
>     [    4.186313]  workqueue_init+0x22a/0x3d0
>     [    4.186313]  kernel_init_freeable+0x1fe/0x4f0
>     [    4.186313]  ? __pfx_kernel_init+0x10/0x10
>     [    4.186313]  kernel_init+0x1b/0x1f0
>     [    4.186313]  ? __pfx_kernel_init+0x10/0x10
>     [    4.186313]  ret_from_fork+0x2c/0x50
>     [    4.186313]  </TASK>
>     [    4.186313] ---[ end trace 0000000000000000 ]---
> 
> o I consistently see a WARN_ON_ONCE() in kick_pool() being hit when I
>   run "sudo ./stress-ng --iomix 96 --timeout 1m". I've seen few
>   different stack traces so far. Including all below just in case:
...
> This is the same WARN_ON_ONCE() you had added in the HEAD commit:
> 
>     $ scripts/faddr2line vmlinux kick_pool+0xdb
>     kick_pool+0xdb/0xe0:
>     kick_pool at kernel/workqueue.c:1130 (discriminator 1)
> 
>     $ sed -n 1130,1132p kernel/workqueue.c
>     if (!WARN_ON_ONCE(wake_cpu >= nr_cpu_ids))
>         p->wake_cpu = wake_cpu;
>     get_work_pwq(work)->stats[PWQ_STAT_REPATRIATED]++;
> 
> Let me know if you need any more data from my test setup.
> P.S. The kernel is still up and running (~30min) despite hitting this
> WARN_ON_ONCE() in my case :)

Okay, that was me being stupid and not initializing the new fields for
per-cpu workqueues. Can you please test the following branch? It should have
both bugs fixed properly.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git affinity-scopes-v2

If that doesn't crash, I'd love to hear how it affects the perf regressions
reported over that past few months.

Thanks.

-- 
tejun
