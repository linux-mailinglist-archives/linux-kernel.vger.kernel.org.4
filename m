Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C0C6E67B2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjDRPBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjDRPB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:01:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EF6397
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 08:01:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6C1D168F;
        Tue, 18 Apr 2023 08:02:10 -0700 (PDT)
Received: from [10.1.27.157] (C02CF1NRLVDN.cambridge.arm.com [10.1.27.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6FC83F5A1;
        Tue, 18 Apr 2023 08:01:25 -0700 (PDT)
Message-ID: <be20272f-caed-303b-7c48-c84c585a9cb7@arm.com>
Date:   Tue, 18 Apr 2023 16:01:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH v3 00/60] arm64: Add support for LPA2 at stage1 and WXN
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2023 14:04, Ard Biesheuvel wrote:
> This is a followup to [0], which was a lot smaller. Thanks to Ryan for
> feedback and review. This series is independent from Ryan's work on
> adding support for LPA2 to KVM - the only potential source of conflict
> should be the patch "arm64: kvm: Limit HYP VA and host S2 range to 48
> bits when LPA2 is in effect", which could simply be dropped in favour of
> the KVM changes to make it support LPA2.
> 
> The first ~15 patches of this series rework how the kernel VA space is
> organized, so that the vmemmap region does not take up more space than
> necessary, and so that most of it can be reclaimed when running a build
> capable of 52-bit virtual addressing on hardware that is not. This is
> needed because the vmemmap region will take up a substantial part of the
> upper VA region that it shares with the kernel, modules and
> vmalloc/vmap mappings once we enable LPA2 with 4k pages.
> 
> The next ~30 patches rework the early init code, reimplementing most of
> the page table and relocation handling in C code. There are several
> reasons why this is beneficial:
> - we generally prefer C code over asm for these things, and the macros
>   that currently exist in head.S for creating the kernel pages tables
>   are a good example why;
> - we no longer need to create the kernel mapping in two passes, which
>   means we can remove the logic that copies parts of the fixmap and the
>   KAsan shadow from one set of page tables to the other; this is
>   especially advantageous for KAsan with LPA2, which needs more
>   elaborate shadow handling across multiple levels, since the KAsan
>   region cannot be placed on exact pgd_t bouundaries in that case;
> - we can read the ID registers and parse command line overrides before
>   creating the page tables, which simplifies the LPA2 case, as flicking
>   the global TCR_EL1.DS bit at a later stage would require elaborate
>   repainting of all page table descriptors, some of which with the MMU
>   disabled;
> - we can use more elaborate logic to create the mappings, which means we
>   can use more precise mappings for code and data sections even when
>   using 2 MiB granularity, and this is a prerequisite for running with
>   WXN.
> 
> As part of the ID map changes, we decouple the ID map size from the
> kernel VA size, and switch to a 48-bit VA map for all configurations.
> 
> The next 18 patches rework the existing LVA support as a CPU feature,
> which simplifies some code and gets rid of the vabits_actual variable.
> Then, LPA2 support is implemented in the same vein. This requires adding
> support for 5 level paging as well, given that LPA2 introduces a new
> paging level '-1' when using 4k pages.

I still don't see any changes for TLBI, which I raised in the first round, and
which I think you need when enabling LPA2. I have 2 patches, which I think are
appropriate; one covers the non-range tlbi routines (and is part of my KVM
series) and the other covers the rage-based routines (this would need a bit of
fix up to use your lpa2_is_enabled()). At [1] and [2] respectively.

[1] https://lore.kernel.org/kvmarm/20230306195438.1557851-2-ryan.roberts@arm.com/
[2]
https://gitlab.arm.com/linux-arm/linux-rr/-/commit/38628decb785aea42a349a857b9f8a65a19e9c2b

Thanks,
Ryan


