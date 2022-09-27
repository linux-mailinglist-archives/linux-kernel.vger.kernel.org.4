Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F695EBA6D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 08:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiI0GQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 02:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiI0GQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 02:16:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E7045E309;
        Mon, 26 Sep 2022 23:16:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E1121042;
        Mon, 26 Sep 2022 23:16:57 -0700 (PDT)
Received: from [10.162.41.7] (unknown [10.162.41.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FBDD3F73B;
        Mon, 26 Sep 2022 23:16:41 -0700 (PDT)
Message-ID: <168eac93-a6ee-0b2e-12bb-4222eff24561@arm.com>
Date:   Tue, 27 Sep 2022 11:46:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 2/2] arm64: support batched/deferred tlb shootdown
 during page reclamation
Content-Language: en-US
To:     Yicong Yang <yangyicong@huawei.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, peterz@infradead.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, darren@os.amperecomputing.com,
        yangyicong@hisilicon.com, huzhanyuan@oppo.com, lipeifeng@oppo.com,
        zhangshiming@oppo.com, guojian@oppo.com, realmz6@gmail.com,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, Barry Song <21cnbao@gmail.com>,
        wangkefeng.wang@huawei.com, xhao@linux.alibaba.com,
        prime.zeng@hisilicon.com, Barry Song <v-songbaohua@oppo.com>,
        Nadav Amit <namit@vmware.com>, Mel Gorman <mgorman@suse.de>
References: <20220921084302.43631-1-yangyicong@huawei.com>
 <20220921084302.43631-3-yangyicong@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220921084302.43631-3-yangyicong@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

On 9/21/22 14:13, Yicong Yang wrote:
> +static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
> +{
> +	/* for small systems with small number of CPUs, TLB shootdown is cheap */
> +	if (num_online_cpus() <= 4)

It would be great to have some more inputs from others, whether 4 (which should
to be codified into a macro e.g ARM64_NR_CPU_DEFERRED_TLB, or something similar)
is optimal for an wide range of arm64 platforms.

> +		return false;> +
> +#ifdef CONFIG_ARM64_WORKAROUND_REPEAT_TLBI
> +	if (unlikely(this_cpu_has_cap(ARM64_WORKAROUND_REPEAT_TLBI)))
> +		return false;
> +#endif
> +
> +	return true;
> +}
> +

[...]
