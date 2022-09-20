Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F248C5BDEA1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiITHo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiITHoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:44:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F9F5E644
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 00:42:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F17862072
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9CDC433D6;
        Tue, 20 Sep 2022 07:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663659775;
        bh=nWPqcQ+k8fQn2uzfqc5Cff9bIXh9MOsUqh6sUrWx750=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=f9PSvtGCYG0K8iqdBca6m9ANsvqfiaBIBFyI36VFb4Z5mWHm4jYS5djU6gjAHlF2G
         aXFecMhNvuzYvmNRKlbWVKnP2nf1Ut+oF0hBToI9IvpkMqPC2lGOXt1J6tss1a8w1n
         vn1HoVR7Qbb3d6QF47tuyqrXHZ0RJW/dK3qSNm6iiP15OGfX4WqrGhVuP9sz6F5Xii
         cYH7rxC0mcC+8Rn4f2DASpYvbSFwnsItVKbayHJjrc78bWfSsn/A9/cE6rHoccDfbt
         HTMVeT8e0FbC9hK7qi0Xir8lW2R+ZzS68WjSxy8abbN+GXoL9uEYnduhR6p6SonnMN
         u3iMm452hjvcA==
Message-ID: <53ba30f1-c867-f34e-b262-08df67ef26fb@kernel.org>
Date:   Tue, 20 Sep 2022 09:42:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] trace/osnoise: Fix possible recursive locking in
 stop_per_cpu_kthreads
To:     Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mingo@redhat.com
References: <20220919144932.3064014-1-npache@redhat.com>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220919144932.3064014-1-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nico!

On 9/19/22 16:49, Nico Pache wrote:
> There is a recursive lock on the cpu_hotplug_lock.
> 
> In kernel/trace/trace_osnoise.c:<start/stop>_per_cpu_kthreads:
>     - start_per_cpu_kthreads calls cpus_read_lock() and if
> 	start_kthreads returns a error it will call stop_per_cpu_kthreads.
>     - stop_per_cpu_kthreads then calls cpus_read_lock() again causing
>       deadlock.

Yep, I see the problem.

> Fix this by calling cpus_read_unlock() before calling
> stop_per_cpu_kthreads. This behavior can also be seen in commit
> f46b16520a08 ("trace/hwlat: Implement the per-cpu mode").

Correct, we have a similar function that *without* this problem.

> This error was noticed during the LTP ftrace-stress-test:
> 
> WARNING: possible recursive locking detected
> --------------------------------------------
> sh/275006 is trying to acquire lock:
> ffffffffb02f5400 (cpu_hotplug_lock){++++}-{0:0}, at: stop_per_cpu_kthreads
> 
> but task is already holding lock:
> ffffffffb02f5400 (cpu_hotplug_lock){++++}-{0:0}, at: start_per_cpu_kthreads
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>       CPU0
>       ----
>  lock(cpu_hotplug_lock);
>  lock(cpu_hotplug_lock);
> 
>  *** DEADLOCK ***
> 
> May be due to missing lock nesting notation
> 
> 3 locks held by sh/275006:
>  #0: ffff8881023f0470 (sb_writers#24){.+.+}-{0:0}, at: ksys_write
>  #1: ffffffffb084f430 (trace_types_lock){+.+.}-{3:3}, at: rb_simple_write
>  #2: ffffffffb02f5400 (cpu_hotplug_lock){++++}-{0:0}, at: start_per_cpu_kthreads
> 
> Fixes: c8895e271f79 ("trace/osnoise: Support hotplug operations")
> Signed-off-by: Nico Pache <npache@redhat.com>

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks!
-- Daniel
