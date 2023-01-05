Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FFC65F390
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 19:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjAESPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 13:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjAESPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 13:15:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE2F4FCCF;
        Thu,  5 Jan 2023 10:15:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3498761BEC;
        Thu,  5 Jan 2023 18:15:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EDBC433D2;
        Thu,  5 Jan 2023 18:15:01 +0000 (UTC)
Date:   Thu, 5 Jan 2023 18:14:58 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        will@kernel.org, anshuman.khandual@arm.com,
        linux-doc@vger.kernel.org, corbet@lwn.net, peterz@infradead.org,
        arnd@arndb.de, punit.agrawal@bytedance.com,
        linux-kernel@vger.kernel.org, darren@os.amperecomputing.com,
        yangyicong@hisilicon.com, huzhanyuan@oppo.com, lipeifeng@oppo.com,
        zhangshiming@oppo.com, guojian@oppo.com, realmz6@gmail.com,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, Barry Song <21cnbao@gmail.com>,
        wangkefeng.wang@huawei.com, xhao@linux.alibaba.com,
        prime.zeng@hisilicon.com, Barry Song <v-songbaohua@oppo.com>,
        Nadav Amit <namit@vmware.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH v7 2/2] arm64: support batched/deferred tlb shootdown
 during page reclamation
Message-ID: <Y7cToj5mWd1ZbMyQ@arm.com>
References: <20221117082648.47526-1-yangyicong@huawei.com>
 <20221117082648.47526-3-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117082648.47526-3-yangyicong@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 04:26:48PM +0800, Yicong Yang wrote:
> It is tested on 4,8,128 CPU platforms and shows to be beneficial on
> large systems but may not have improvement on small systems like on
> a 4 CPU platform. So make ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH depends
> on CONFIG_EXPERT for this stage and make this disabled on systems
> with less than 8 CPUs. User can modify this threshold according to
> their own platforms by CONFIG_NR_CPUS_FOR_BATCHED_TLB.

What's the overhead of such batching on systems with 4 or fewer CPUs? If
it isn't noticeable, I'd rather have it always on than some number
chosen on whichever SoC you tested.

Another option would be to make this a sysctl tunable.

>  .../features/vm/TLB/arch-support.txt          |  2 +-
>  arch/arm64/Kconfig                            |  6 +++
>  arch/arm64/include/asm/tlbbatch.h             | 12 +++++
>  arch/arm64/include/asm/tlbflush.h             | 52 ++++++++++++++++++-
>  arch/x86/include/asm/tlbflush.h               |  5 +-
>  include/linux/mm_types_task.h                 |  4 +-
>  mm/rmap.c                                     | 10 ++--

Please keep any function prototype changes in a preparatory patch so
that the arm64 one only introduces the arch specific changes. Easier to
review.

> +static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
> +{
> +	/*
> +	 * TLB batched flush is proved to be beneficial for systems with large
> +	 * number of CPUs, especially system with more than 8 CPUs. TLB shutdown
> +	 * is cheap on small systems which may not need this feature. So use
> +	 * a threshold for enabling this to avoid potential side effects on
> +	 * these platforms.
> +	 */
> +	if (num_online_cpus() < CONFIG_ARM64_NR_CPUS_FOR_BATCHED_TLB)
> +		return false;

The x86 implementation tracks the cpumask of where a task has run. We
don't have such tracking on arm64 and I don't think it matters. As
noticed/described in this series, the bottleneck is the actual DSB
synchronisation (which sends a DVM Sync message to all the other CPUs
and waits for a DVM Complete response). So I think it makes sense not to
bother with an mm_cpumask(). What this patch aims to optimise is
actually the number of DSBs issued on an SMP system by
ptep_clear_flush().

The DVM is not an architected concept (well, it's part of AMBA AXI). I'd
be curious to know how such patch behaves on Apple's M1/M2 hardware. My
preference would be to have this always on for num_online_cpus() > 1 if
there's no overhead.

-- 
Catalin
