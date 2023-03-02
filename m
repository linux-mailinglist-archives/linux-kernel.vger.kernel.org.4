Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160226A87C7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 18:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjCBRWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 12:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCBRWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 12:22:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CC3168B0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 09:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677777688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z19v7MXKb8AKOCqgrXYO60C645U6qWX+/Cu/AHRQzmQ=;
        b=WUAJHB0flVuYPUc4U958azQB2XYgFG92yVF3VSu2eEcoTZjKOfYFAdTWaXtlE0GlAy+vY9
        /rYUB0F/JW8T4cLXywZBC3xEGMWlBdVDVABwpwOO4pVyCTRraM/YgwAAp5drTRqA3Tqx9m
        EzyAYH6Or6wOLhioqOJ83i9zWw8defU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-453-IJ-Y3V8HOZiqolKEwRXtKg-1; Thu, 02 Mar 2023 12:21:24 -0500
X-MC-Unique: IJ-Y3V8HOZiqolKEwRXtKg-1
Received: by mail-qk1-f198.google.com with SMTP id c15-20020a37e10f000000b00741a3333881so10456500qkm.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 09:21:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677777678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z19v7MXKb8AKOCqgrXYO60C645U6qWX+/Cu/AHRQzmQ=;
        b=0+H6zajNl2Up3JjpuZIAXQvJbEcATfnCii9Kd+NGzLhbBLp3/GE+tUhe4YFLepIpt5
         Wuwj3fuG4+9mtAhlVVtVyawKIIX0HzGY7sApKBu1xxayGZUXb5JiAK2jKEJqWLp1kJFz
         gx3mZ5d9WYctHs6zue642DDMFKrZRngDXM8y2vquGqp7CnfZTDtiHHYz/YkpCz2AIK5/
         ybPlhpD9X9mNQhNR5Nj6jCuWGOTxKn+rtCAp0QsnZjWjkcckq/bi78hjyTK1uBwiidLO
         jDnnvzoGKjv1dvVaitijpnFYO6HN+hli/Hv0x3BBuUwIe0GH+Jj62Xz/Jevp0kwYFKMH
         EXCw==
X-Gm-Message-State: AO0yUKVlFnF2Ql6m8yI3KVjt0Xjjrtlmwbs8lDsEMVUn7CCdDvlUUafy
        FEgrrDL2gAnv528ie9Z3vYWfOLvTSFw30hPa3/Oay5UoyNA7LMqVftikOC4vnZuBYw7F+pCFiES
        8aFX6/F5DAIgn5FjMB2N1QgBAresixg==
X-Received: by 2002:ac8:7e87:0:b0:3bf:f7d0:9ba9 with SMTP id w7-20020ac87e87000000b003bff7d09ba9mr11125219qtj.5.1677777678020;
        Thu, 02 Mar 2023 09:21:18 -0800 (PST)
X-Google-Smtp-Source: AK7set9655JRdCvXNBMMODLkWTf3aygdgdxwgN+WSco8cUroxUBDyqAX41ub2H/ZnN7moPgkTzWHgQ==
X-Received: by 2002:ac8:7e87:0:b0:3bf:f7d0:9ba9 with SMTP id w7-20020ac87e87000000b003bff7d09ba9mr11125185qtj.5.1677777677688;
        Thu, 02 Mar 2023 09:21:17 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id b13-20020ac8540d000000b003ba19e53e43sm63118qtq.25.2023.03.02.09.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 09:21:17 -0800 (PST)
Date:   Thu, 2 Mar 2023 12:21:15 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 01/11] mm/vmstat: remove remote node draining
Message-ID: <ZADbC9RnmVtpC6kE@x1n>
References: <20230209150150.380060673@redhat.com>
 <20230209153204.656996515@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230209153204.656996515@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 12:01:51PM -0300, Marcelo Tosatti wrote:
> Draining of pages from the local pcp for a remote zone was necessary
> since:
> 
> "Note that remote node draining is a somewhat esoteric feature that is
> required on large NUMA systems because otherwise significant portions
> of system memory can become trapped in pcp queues. The number of pcp is
> determined by the number of processors and nodes in a system. A system
> with 4 processors and 2 nodes has 8 pcps which is okay. But a system
> with 1024 processors and 512 nodes has 512k pcps with a high potential
> for large amount of memory being caught in them."

How about mentioning more details on where does this come from?

afaict it's from commit 4037d45 since 2007.

So I digged that out mostly because I want to know why we did flush pcp at
all during vmstat update.  It already sounds weird to me but I could have
been missing important details.

The rational I had here is refresh_cpu_vm_stats(true) is mostly being
called by the shepherd afaict, while:

  (1) The frequency of that interval is defined as sysctl_stat_interval,
      which has nothing yet to do with pcp pages but only stat at least in
      the name of it, and,

  (2) vmstat_work is only queued if need_update() here:

	for_each_online_cpu(cpu) {
		struct delayed_work *dw = &per_cpu(vmstat_work, cpu);

		if (!delayed_work_pending(dw) && need_update(cpu))
			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);

		cond_resched();
	}

      need_update() tells us "we should flush vmstats", nothing it tells
      about "we should flush pcp list"..

I looked into the 2007 commit, besides what Marcelo quoted, I do see
there's a major benefit of reusing cache lines, quotting from the commit:

        Move the node draining so that is is done when the vm statistics
        are updated.  At that point we are already touching all the
        cachelines with the pagesets of a processor.

However I didn't see why it's rational to flush pcp list when vmstat needs
flushing either.  I also don't know whether that "cacheline locality" hold
true or not, because I saw that the pcp page list is split from vmstats
since 2021:

    commit 28f836b6777b6f42dce068a40d83a891deaaca37
    Author: Mel Gorman <mgorman@techsingularity.net>
    Date:   Mon Jun 28 19:41:38 2021 -0700

    mm/page_alloc: split per cpu page lists and zone stats

I'm not even sure my A-b or R-b worth anything at all here, just offer
something I got from git archaeology so maybe helpful to readers and
reasoning to this patch.  The correctness of archaeology needs help from
others (Christoph and Gel?)..  I would just say if there's anything useful
or correct may worth collect some into the commit log.

So from what I can tell this patch makes sense.

-- 
Peter Xu

