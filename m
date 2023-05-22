Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DA770B535
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjEVGlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjEVGll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:41:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A93AA1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:41:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22DDF61072
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 06:41:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86B1C433EF;
        Mon, 22 May 2023 06:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684737699;
        bh=e6Gayw9cpiuj1SxIPCAYehG3fnJ8MCgfauEu1Z8Jw18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZpU4X3gIFcZq7VYbzs6ulBjXXPTjY7vtTiZPMnGvixTMBMel2Je25WBhtVtRur849
         CduiRQBmovwct1OfR73OtDmsXbUYHoaz7QZb5oxWKGMnpabSlnt/ksYlj3bfThXwZq
         Wxdl0pFAsU8l6/qXSKWWfwrwnoIS2h4l0grrrLEWV+wvo9/PzFeJSuXNRz/De/Uww6
         HGTAM8t5NhjRrqllRBNNHAOGrAX0MfhLQ3OMfUTDzRo0BXIAtDGx65Rz5T0dURhdcM
         jJ13kKzwPXPH+Bl9CSKsDxRC0UnxAyuN2ZpInSByr3ZdVYy4plpVC8sdy/zbgVCpVe
         96jBYqn8Pg5uQ==
Date:   Mon, 22 May 2023 09:41:34 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Tejun Heo <tj@kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     jiangshanlai@gmail.com, torvalds@linux-foundation.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, joshdon@google.com, brho@google.com,
        briannorris@chromium.org, nhuck@google.com, agk@redhat.com,
        snitzer@kernel.org, void@manifault.com,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>
Subject: Re: [PATCH 09/24] workqueue: Make unbound workqueues to use per-cpu
 pool_workqueues
Message-ID: <20230522064134.GA786644@unreal>
References: <20230519001709.2563-1-tj@kernel.org>
 <20230519001709.2563-10-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519001709.2563-10-tj@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 02:16:54PM -1000, Tejun Heo wrote:
> A pwq (pool_workqueue) represents an association between a workqueue and a
> worker_pool. When a work item is queued, the workqueue selects the pwq to
> use, which in turn determines the pool, and queues the work item to the pool
> through the pwq. pwq is also what implements the maximum concurrency limit -
> @max_active.
> 
> As a per-cpu workqueue should be assocaited with a different worker_pool on
> each CPU, it always had per-cpu pwq's that are accessed through wq->cpu_pwq.
> However, unbound workqueues were sharing a pwq within each NUMA node by
> default. The sharing has several downsides:
> 
> * Because @max_active is per-pwq, the meaning of @max_active changes
>   depending on the machine configuration and whether workqueue NUMA locality
>   support is enabled.
> 
> * Makes per-cpu and unbound code deviate.
> 
> * Gets in the way of making workqueue CPU locality awareness more flexible.
> 
> This patch makes unbound workqueues use per-cpu pwq's the same way per-cpu
> workqueues do by making the following changes:
> 
> * wq->numa_pwq_tbl[] is removed and unbound workqueues now use wq->cpu_pwq
>   just like per-cpu workqueues. wq->cpu_pwq is now RCU protected for unbound
>   workqueues.
> 
> * numa_pwq_tbl_install() is renamed to install_unbound_pwq() and installs
>   the specified pwq to the target CPU's wq->cpu_pwq.
> 
> * apply_wqattrs_prepare() now always allocates a separate pwq for each CPU
>   unless the workqueue is ordered. If ordered, all CPUs use wq->dfl_pwq.
>   This makes the return value of wq_calc_node_cpumask() unnecessary. It now
>   returns void.
> 
> * @max_active now means the same thing for both per-cpu and unbound
>   workqueues. WQ_UNBOUND_MAX_ACTIVE now equals WQ_MAX_ACTIVE and
>   documentation is updated accordingly. WQ_UNBOUND_MAX_ACTIVE is no longer
>   used in workqueue implementation and will be removed later.
> 
> * All unbound pwq operations which used to be per-numa-node are now per-cpu.
> 
> For most unbound workqueue users, this shouldn't cause noticeable changes.
> Work item issue and completion will be a small bit faster, flush_workqueue()
> would become a bit more expensive, and the total concurrency limit would
> likely become higher. All @max_active==1 use cases are currently being
> audited for conversion into alloc_ordered_workqueue() and they shouldn't be
> affected once the audit and conversion is complete.
> 
> One area where the behavior change may be more noticeable is
> workqueue_congested() as the reported congestion state is now per CPU
> instead of NUMA node. There are only two users of this interface -
> drivers/infiniband/hw/hfi1 and net/smc. Maintainers of both subsystems are
> cc'd. Inputs on the behavior change would be very much appreciated.

At least for hfi1, it seems like your changes won't cause to any
differences as NUMA node is expected to be connected to closest CPU
anyway in setups relevant to hfi1.

Dennis, am I right?

Thanks
