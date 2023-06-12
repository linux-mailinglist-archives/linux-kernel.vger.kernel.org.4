Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838CB72C59F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 15:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjFLNRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 09:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjFLNQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 09:16:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07854D3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 06:16:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B7061FB;
        Mon, 12 Jun 2023 06:17:41 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.27.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F23A3F587;
        Mon, 12 Jun 2023 06:16:55 -0700 (PDT)
Date:   Mon, 12 Jun 2023 14:16:28 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marc Zyngier <maz@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Reiji Watanabe <reijiw@google.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] perf/core: Drop __weak attribute from
 arch_perf_update_userpage() prototype
Message-ID: <ZIcarHx0qbfC2iyy@FVFF77S0Q05N>
References: <20230603082519.1088285-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230603082519.1088285-1-maz@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 03, 2023 at 09:25:19AM +0100, Marc Zyngier wrote:
> Reiji reports that the arm64 implementation of arch_perf_update_userpage()
> is now ignored and replaced by the dummy stub in core code.
> This seems to happen since the PMUv3 driver was moved to driver/perf.

I guess we should have a Cc stable then?

The below implies this has always been on dodgy ground, and so it's probably
inaccurate to give this a Fixes tag pointing to the move.

> As it turns out, dropping the __weak attribute from the *prototype*
> of the function solves the problem. You're right, this doesn't seem
> to make much sense. And yet... It appears that both symbols get
> flagged as weak, and that the first one to appear in the link order
> wins:
> 
> $ nm drivers/perf/arm_pmuv3.o|grep arch_perf_update_userpage
> 0000000000001db0 W arch_perf_update_userpage

Ah, so having it on th *declaration* will apply to any *definition*. :/

That suggests this is a bad pattern generally, and we should probably remove
the other __weak instances in headers. Lukcily it seems there aren't that many:

[mark@lakrids:~/src/linux]% git grep __weak -- **/*.h | wc -l
50

IMO we'd should aim to remove __weak entirely; it causes a number of weird
things like this and it'd be much easier to manage with a small amount of
ifdeffery.

Peter, thoughts?

> Dropping the attribute from the prototype restores the expected
> behaviour, and arm64 is able to enjoy arch_perf_update_userpage()
> again.
> 
> Reported-by: Reiji Watanabe <reijiw@google.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Tested-by: Reiji Watanabe <reijiw@google.com>

FWIW, regardless of the above:

Acked-by: Mark Rutland <mark.rutland@arm.com>

> ---
>  include/linux/perf_event.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index d5628a7b5eaa..c8dcfdbda1f4 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1845,9 +1845,9 @@ int perf_event_exit_cpu(unsigned int cpu);
>  #define perf_event_exit_cpu	NULL
>  #endif
>  
> -extern void __weak arch_perf_update_userpage(struct perf_event *event,
> -					     struct perf_event_mmap_page *userpg,
> -					     u64 now);
> +extern void arch_perf_update_userpage(struct perf_event *event,
> +				      struct perf_event_mmap_page *userpg,
> +				      u64 now);
>  
>  #ifdef CONFIG_MMU
>  extern __weak u64 arch_perf_get_page_size(struct mm_struct *mm, unsigned long addr);

Luckily, arch_perf_get_page_size() has no callers or definition since commit:

  8af26be062721e52 ("perf/core: Fix arch_perf_get_page_size()")

... so we can just delete that prototype.

Mark
