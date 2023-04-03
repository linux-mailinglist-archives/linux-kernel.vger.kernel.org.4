Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CC36D501E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjDCSRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjDCSRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:17:39 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF978172C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 11:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1680545856;
        bh=MMINr1wx2F4/gc5fF+IUmCs4/SrHkSmZpW+gy0rM4v8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=vKmibUHnM6T2OpUInYHWDvDvZY+/+IgQXhvr9ODrqryot8PRwb/d+hIv+RyfOyZ3W
         0OVXGX6Fspi4UGxk3GIC6MYClZ473+SZFuHHNbKEE9/B5wWSBPLs6LdnFmtuEn85rG
         X4PQYt3jcZl+TiioWKZeRuFD2x/Mvg46vVEjg8RwdsPfREZnXVyYWiU+cC0dT865dh
         ZcB3mTu3OusUMqApO0L5dsIpquyDfmoInJEGa7DLwFuyx+6orCCcc7xor1v/t9mKha
         zWI2et+ViutntWGcLacSsxyaeswRqc7pMo/DKI2QYAW85LBMENvRM7+cE3ZGqa2goS
         XYQz9c+/QGSMw==
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4PqzdX564HztWT;
        Mon,  3 Apr 2023 14:17:36 -0400 (EDT)
Message-ID: <371efe6e-114f-f9fe-b14a-42b34f2ef61f@efficios.com>
Date:   Mon, 3 Apr 2023 14:17:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH] sched: Introduce per-mm/cpu concurrency id state
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
References: <20230330230911.228720-1-mathieu.desnoyers@efficios.com>
 <20230331085229.GB186694@ziqianlu-desk2>
Content-Language: en-US
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230331085229.GB186694@ziqianlu-desk2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-31 04:52, Aaron Lu wrote:
> On Thu, Mar 30, 2023 at 07:09:11PM -0400, Mathieu Desnoyers wrote:
>> Keep track of the currently allocated mm_cid for each mm/cpu rather than
>> freeing them immediately. This eliminates most atomic ops when context
>> switching back and forth between threads belonging to different memory
>> spaces in multi-threaded scenarios (many processes, each with many
>> threads).
> 
> Good news, the lock contention is now gone and back to v6.2 level:

Hi Aaron,

Can you please test the updated patch I've sent ? I have updated the
subject to make it clear that this is a fix for a performance regression,
improved comments, and it now passes more thorough testing. See:

https://lore.kernel.org/lkml/20230403181342.210896-1-mathieu.desnoyers@efficios.com/

Thanks,

Mathieu

> 
> node0_0.profile:     0.07%     0.07%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node0_1.profile:     0.06%     0.06%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node0_2.profile:     0.09%     0.09%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node0_3.profile:     0.08%     0.08%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node0_4.profile:     0.09%     0.09%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node0_5.profile:     0.10%     0.10%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node0_6.profile:     0.10%     0.10%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node0_7.profile:     0.07%     0.07%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node0_8.profile:     0.08%     0.08%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node0_9.profile:     0.06%     0.06%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node1_0.profile:     0.41%     0.41%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node1_1.profile:     0.38%     0.38%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node1_2.profile:     0.44%     0.44%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node1_3.profile:     5.64%     5.64%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node1_4.profile:     6.08%     6.08%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node1_5.profile:     3.45%     3.45%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node1_6.profile:     2.09%     2.09%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node1_7.profile:     2.72%     2.72%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node1_8.profile:     0.16%     0.16%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node1_9.profile:     0.15%     0.15%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> (those few profiles from node1's cpus that have more than 2% contention
> are from thermal functions)
> 
> Tested-by: Aaron Lu <aaron.lu@intel.com> # lock contention part




-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

