Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7201C64C9B0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 14:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238348AbiLNNGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 08:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiLNNG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 08:06:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9772F9FCF
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 05:06:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EEBF61A53
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 13:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12022C433EF;
        Wed, 14 Dec 2022 13:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671023185;
        bh=lDTCePU+j9rTmUoYes8Iq93CXo/8hTpg8U7Xkcd7nSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bpOQNBvOIxYPP5gha0MzWOwEbjSLjH+Dpxd5pdWy+dq48PGHa0SHi25xqKtlz/dX+
         hPakhCKAJZHH7tb/0jzt3zANCux/YV6pzDnuh+4FoDdWqYOtCRFcBlbSw3WcAk5KLx
         d5iUM1Qg4MyMbe5KaCL78nXlHvtzlEA+5ycESor5Fg1O2ekz1dMvAllkulDvwE1BVs
         1FO8mn0hJdG2tMoFZ32AqEpT3KPX4HBWo3jZrkignyxDCJzoUzt5jOGMKndrH9SpcY
         hhDyLR3BGEDu73I3M7qCEYQkbnhJO9Puq4EBFuQyi8/lfd7YxFQEViYfw/pLHV3mW5
         TaYYMklb2IGZA==
Date:   Wed, 14 Dec 2022 14:06:22 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     atomlin@redhat.com, cl@linux.com, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org, pauld@redhat.com,
        neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v9 1/5] mm/vmstat: Add CPU-specific variable to track a
 vmstat discrepancy
Message-ID: <20221214130622.GD1930067@lothringen>
References: <20221206161826.698593151@redhat.com>
 <20221206162416.404740300@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206162416.404740300@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 01:18:27PM -0300, Marcelo Tosatti wrote:
> From: Aaron Tomlin <atomlin@redhat.com>
> 
> Introduce a CPU-specific variable namely vmstat_dirty to indicate
> if a vmstat imbalance is present for a given CPU. Therefore, at
> the appropriate time, we can fold all the remaining differentials.
> This patch also provides trivial helpers for modification and testing.
> 
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>

Your SOB is also missing here and on other patches.

Thanks.

> ---
>  mm/vmstat.c |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> Index: linux-2.6/mm/vmstat.c
> ===================================================================
> --- linux-2.6.orig/mm/vmstat.c
> +++ linux-2.6/mm/vmstat.c
> @@ -194,6 +194,22 @@ void fold_vm_numa_events(void)
>  #endif
>  
>  #ifdef CONFIG_SMP
> +static DEFINE_PER_CPU_ALIGNED(bool, vmstat_dirty);
> +
> +static inline void vmstat_mark_dirty(void)
> +{
> +	this_cpu_write(vmstat_dirty, true);
> +}
> +
> +static inline void vmstat_clear_dirty(void)
> +{
> +	this_cpu_write(vmstat_dirty, false);
> +}
> +
> +static inline bool is_vmstat_dirty(void)
> +{
> +	return this_cpu_read(vmstat_dirty);
> +}
>  
>  int calculate_pressure_threshold(struct zone *zone)
>  {
> 
> 
