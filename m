Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AAF6A87E0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 18:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjCBR2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 12:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjCBR2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 12:28:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EB63B0D8
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 09:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677778036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=taZnUIskUDKhma9jU5HVtD2d3fqkdXORT/OzHkjNDbY=;
        b=YCVSFbF9Um74eIS475oPFS0ntoqPSe+CLX3OvCu2bkw1CoXxGdLMGMAn2EZm8eKa+Nz+9d
        zqBsW3PD/mQ7Q08qPJbmIUBrNGZxkWDjLYNL5sDCmXUTiRTLMMQQ5HNbdIs5ZtZff3pS5I
        gdDO1VDS8upspWJ3fRtult2nWgByYK4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-624-CksbpUKuMqG6kdqlX6llGw-1; Thu, 02 Mar 2023 12:27:14 -0500
X-MC-Unique: CksbpUKuMqG6kdqlX6llGw-1
Received: by mail-qt1-f200.google.com with SMTP id ga17-20020a05622a591100b003bfdf586476so352qtb.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 09:27:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677778034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=taZnUIskUDKhma9jU5HVtD2d3fqkdXORT/OzHkjNDbY=;
        b=P5JOfopQ/vO+pa1ccRwFK7uIqsAiBw5sWaKaD0jBLK+1aaaSrgzpCSVdTJLOQF0f/c
         ogMzMOz01G0tJyG1DdGbFuKUNOnoEHMS6PKLbmsM2mguN2t6tXXwWeiHJjOVLyDqsikf
         +Co1tbt4SSJIgNbrZykO/2FF2o06VX5lBjbfPr3C9XAb/ggWDQqdyBf9cuD8lz4RkVLO
         cgG1srgTR17nfQlZxVzvaIFMhnBxkwIt6KX27i8IZPvQkuDQJkSJ8GUqvRufKj6at4tF
         hFpaKdpLY2m5IjCrXUMJYoahbraHmBZzQK4kcyShFtbzA+nXqmOP4bP/arCkoHs0vSyI
         TEgQ==
X-Gm-Message-State: AO0yUKUnWwJ+mO/EppkYutnhpiADgRMjXLk+4uM0FLTXtwHLKGyQnACd
        /9s9sMmvdxZNzBB2xBn+OjNeJ5i450VHtAezqEdNRg0lyTYXlQEf1BtleRQ12sVkT0pS1KVRNUr
        QWGyzbyryqV9LpL5mQdE6i+E0
X-Received: by 2002:a0c:9a43:0:b0:56c:222d:427a with SMTP id q3-20020a0c9a43000000b0056c222d427amr19519716qvd.1.1677778033871;
        Thu, 02 Mar 2023 09:27:13 -0800 (PST)
X-Google-Smtp-Source: AK7set9uOP3CD3qJVsAZhk5lIgft5Ka5qkWjcQx7eXp+HakmNI2Ev035+Qw0dV9io636wOMCj/WfDQ==
X-Received: by 2002:a0c:9a43:0:b0:56c:222d:427a with SMTP id q3-20020a0c9a43000000b0056c222d427amr19519688qvd.1.1677778033532;
        Thu, 02 Mar 2023 09:27:13 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id t190-20020a3746c7000000b0074235745fdasm31572qka.58.2023.03.02.09.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 09:27:12 -0800 (PST)
Date:   Thu, 2 Mar 2023 12:27:11 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 01/11] mm/vmstat: remove remote node draining
Message-ID: <ZADcb+3sU08MHhy3@x1n>
References: <20230209150150.380060673@redhat.com>
 <20230209153204.656996515@redhat.com>
 <ZADbC9RnmVtpC6kE@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZADbC9RnmVtpC6kE@x1n>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 12:21:15PM -0500, Peter Xu wrote:
> On Thu, Feb 09, 2023 at 12:01:51PM -0300, Marcelo Tosatti wrote:
> > Draining of pages from the local pcp for a remote zone was necessary
> > since:
> > 
> > "Note that remote node draining is a somewhat esoteric feature that is
> > required on large NUMA systems because otherwise significant portions
> > of system memory can become trapped in pcp queues. The number of pcp is
> > determined by the number of processors and nodes in a system. A system
> > with 4 processors and 2 nodes has 8 pcps which is okay. But a system
> > with 1024 processors and 512 nodes has 512k pcps with a high potential
> > for large amount of memory being caught in them."
> 
> How about mentioning more details on where does this come from?
> 
> afaict it's from commit 4037d45 since 2007.
> 
> So I digged that out mostly because I want to know why we did flush pcp at
> all during vmstat update.  It already sounds weird to me but I could have
> been missing important details.
> 
> The rational I had here is refresh_cpu_vm_stats(true) is mostly being
> called by the shepherd afaict, while:
> 
>   (1) The frequency of that interval is defined as sysctl_stat_interval,
>       which has nothing yet to do with pcp pages but only stat at least in
>       the name of it, and,
> 
>   (2) vmstat_work is only queued if need_update() here:
> 
> 	for_each_online_cpu(cpu) {
> 		struct delayed_work *dw = &per_cpu(vmstat_work, cpu);
> 
> 		if (!delayed_work_pending(dw) && need_update(cpu))
> 			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
> 
> 		cond_resched();
> 	}
> 
>       need_update() tells us "we should flush vmstats", nothing it tells
>       about "we should flush pcp list"..
> 
> I looked into the 2007 commit, besides what Marcelo quoted, I do see
> there's a major benefit of reusing cache lines, quotting from the commit:
> 
>         Move the node draining so that is is done when the vm statistics
>         are updated.  At that point we are already touching all the
>         cachelines with the pagesets of a processor.
> 
> However I didn't see why it's rational to flush pcp list when vmstat needs
> flushing either.  I also don't know whether that "cacheline locality" hold
> true or not, because I saw that the pcp page list is split from vmstats
> since 2021:
> 
>     commit 28f836b6777b6f42dce068a40d83a891deaaca37
>     Author: Mel Gorman <mgorman@techsingularity.net>
>     Date:   Mon Jun 28 19:41:38 2021 -0700
> 
>     mm/page_alloc: split per cpu page lists and zone stats
> 
> I'm not even sure my A-b or R-b worth anything at all here, just offer
> something I got from git archaeology so maybe helpful to readers and
> reasoning to this patch.  The correctness of archaeology needs help from
> others (Christoph and Gel?)..  I would just say if there's anything useful
> or correct may worth collect some into the commit log.
> 
> So from what I can tell this patch makes sense.

One thing I forgot to mention, which may be a slight abi change, is that I
think the pcp page drain is also triggered by /proc/PID/refresh_vm_stats
(even though again I don't see why flushing pcp is strictly needed).  It's
just that I don't know whether there's potential user app that can leverage
this.

The worst case is we can drain pcp list for refresh_vm_stats procfs
explicitly, but I'm not sure whether it'll be worthwhile either, probably
just to be safe.

-- 
Peter Xu

