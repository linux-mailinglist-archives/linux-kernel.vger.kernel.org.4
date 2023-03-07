Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374416AF875
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjCGWUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjCGWUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:20:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B203B219
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:20:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72C6AB81A88
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 22:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C792C433D2;
        Tue,  7 Mar 2023 22:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1678227628;
        bh=8igepYudrBDgBGP0BH8iVimdwg7sin/v8nkfuII5Cig=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A0AQYV7bOaqS9eqOoYjVsErfIDPISR8Tmf4ZT3znJM4eZsaCOrS0t2QnJLDXDjcbX
         bJ1c7a53HycjGRHRC+QDHPOGEXwMPfw7CgOZzha/MtZI19QVM3qtIiMaKUzue/Jyge
         krnCiryUXbggF/hOnuIEY7nkFvBpbSSpGBipn8s4=
Date:   Tue, 7 Mar 2023 14:20:26 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     tkhai@ya.ru, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com, rppt@kernel.org,
        sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/8] make slab shrink lockless
Message-Id: <20230307142026.31c964475fd3c9554a4f62cb@linux-foundation.org>
In-Reply-To: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
References: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Mar 2023 14:55:57 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:

> Hi all,
> 
> This patch series aims to make slab shrink lockless.

The v3 discussion did contain requests for some sort of measurements of
real-world workloads.  And Kirill did suggest a workload which could be
used for this measurement.

It's quite important that we have this info, please.  I mean, speeding
up real-world workloads is the entire point of the patchset and without
measurements, we don't know if the patchset achieves its primary
objective!


> 3. Reproduction and testing
> ===========================
> 
> We can reproduce the down_read_trylock() hotspot through the following script:
> 
> ```
> #!/bin/bash
> 
> DIR="/root/shrinker/memcg/mnt"
> 
> do_create()
> {
>     mkdir -p /sys/fs/cgroup/memory/test
>     mkdir -p /sys/fs/cgroup/perf_event/test
>     echo 4G > /sys/fs/cgroup/memory/test/memory.limit_in_bytes
>     for i in `seq 0 $1`;
>     do
>         mkdir -p /sys/fs/cgroup/memory/test/$i;
>         echo $$ > /sys/fs/cgroup/memory/test/$i/cgroup.procs;
>         echo $$ > /sys/fs/cgroup/perf_event/test/cgroup.procs;
>         mkdir -p $DIR/$i;
>     done
> }
> 
> do_mount()
> {
>     for i in `seq $1 $2`;
>     do
>         mount -t tmpfs $i $DIR/$i;
>     done
> }
> 
> do_touch()
> {
>     for i in `seq $1 $2`;
>     do
>         echo $$ > /sys/fs/cgroup/memory/test/$i/cgroup.procs;
>         echo $$ > /sys/fs/cgroup/perf_event/test/cgroup.procs;
>             dd if=/dev/zero of=$DIR/$i/file$i bs=1M count=1 &
>     done
> }
> 
> case "$1" in
>   touch)
>     do_touch $2 $3
>     ;;
>   test)
>       do_create 4000
>     do_mount 0 4000
>     do_touch 0 3000
>     ;;
>   *)
>     exit 1
>     ;;
> esac
> ```
> 
> Save the above script, then run test and touch commands. Then we can use the
> following perf command to view hotspots:

Well.  Simply runnimg

	time that-script

before and after and including the info in the changelog would be a start?
