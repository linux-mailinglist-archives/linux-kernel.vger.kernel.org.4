Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F106C1FE8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjCTSf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjCTSe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:34:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D9F1CBEB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:27:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 97BB121A97;
        Mon, 20 Mar 2023 18:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679336756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6NyzBHrEFFt3x3wldfOH2t3owxOVtgcPmDv2HFH2MaU=;
        b=KryhIWdPnkDXrKEVLwDhapgy4b89AdPaHUXhLEd8LGuRasPsuJuEhANGgml6FxbEFO8qVs
        DJmxoWjBSyQVvkrrXOEsiRWW5dSJwWtlEnI384hbyv8/2UnEWtLJnJ/ifZ4eVrbjcv80+d
        ZLDbxx8GuJ2iHrjnPpJup6CgbZuNaZY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7760313416;
        Mon, 20 Mar 2023 18:25:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7406GjSlGGRsKAAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 20 Mar 2023 18:25:56 +0000
Date:   Mon, 20 Mar 2023 19:25:55 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v7 00/13] fold per-CPU vmstats remotely
Message-ID: <ZBilM1JR2HKElIR1@dhcp22.suse.cz>
References: <20230320180332.102837832@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320180332.102837832@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20-03-23 15:03:32, Marcelo Tosatti wrote:
> This patch series addresses the following two problems:
> 
> 1. A customer provided evidence indicating that a process
>    was stalled in direct reclaim:
> 
This is addressed by the trivial patch 1.

[...]
>  2. With a task that busy loops on a given CPU,
>     the kworker interruption to execute vmstat_update
>     is undesired and may exceed latency thresholds
>     for certain applications.

Yes it can but why does that matter?

> By having vmstat_shepherd flush the per-CPU counters to the
> global counters from remote CPUs.
> 
> This is done using cmpxchg to manipulate the counters,
> both CPU locally (via the account functions),
> and remotely (via cpu_vm_stats_fold).
> 
> Thanks to Aaron Tomlin for diagnosing issue 1 and writing
> the initial patch series.
> 
> 
> Performance details for the kworker interruption:
> 
> oslat   1094.456862: sys_mlock(start: 7f7ed0000b60, len: 1000)
> oslat   1094.456971: workqueue_queue_work: ... function=vmstat_update ...
> oslat   1094.456974: sched_switch: prev_comm=oslat ... ==> next_comm=kworker/5:1 ...
> kworker 1094.456978: sched_switch: prev_comm=kworker/5:1 ==> next_comm=oslat ...
>  
> The example above shows an additional 7us for the
> 
>         oslat -> kworker -> oslat
> 
> switches. In the case of a virtualized CPU, and the vmstat_update
> interruption in the host (of a qemu-kvm vcpu), the latency penalty
> observed in the guest is higher than 50us, violating the acceptable
> latency threshold for certain applications.

I do not think we have ever promissed any specific latency guarantees
for vmstat. These are statistics have been mostly used for debugging
purposes AFAIK. I am not aware of any specific user space use case that
would be latency sensitive. Your changelog doesn't go into details there
either.

[...]
>  mm/vmstat.c                         |  440 +++++++++++++++++++++++++++++++++++++++++++++++------------------------------

This requires much more detailed story why we really need that.
-- 
Michal Hocko
SUSE Labs
