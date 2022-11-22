Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E4E6336C6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbiKVIN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbiKVINY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:13:24 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBACE1B78C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:13:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC6F01FB;
        Tue, 22 Nov 2022 00:13:28 -0800 (PST)
Received: from [10.162.40.16] (unknown [10.162.40.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 636BE3F73D;
        Tue, 22 Nov 2022 00:13:20 -0800 (PST)
Message-ID: <879e561c-e834-196c-b9c5-6e44ac2c0296@arm.com>
Date:   Tue, 22 Nov 2022 13:43:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] arm64/mm: Intercept pfn changes in set_pte_at()
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20221116031001.292236-1-anshuman.khandual@arm.com>
 <20221118141317.GF4046@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20221118141317.GF4046@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/18/22 19:43, Will Deacon wrote:
> On Wed, Nov 16, 2022 at 08:40:01AM +0530, Anshuman Khandual wrote:
>> Changing pfn on a user page table mapped entry, without first going through
>> break-before-make (BBM) procedure is unsafe. This just updates set_pte_at()
>> to intercept such changes, via an updated pgattr_change_is_safe(). This new
>> check happens via __check_racy_pte_update(), which has now been renamed as
>> __check_safe_pte_update().
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com> 
>> Cc: Andrew Morton <akpm@linux-foundation.org> 
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> This applies on v6.1-rc4
>>
>>  arch/arm64/include/asm/pgtable.h | 8 ++++++--
>>  arch/arm64/mm/mmu.c              | 8 +++++++-
>>  2 files changed, 13 insertions(+), 3 deletions(-)
> 
> I remember Mark saying that BBM is sometimes violated by the core code in
> cases where the pte isn't actually part of a live pgtable (e.g. if it's on
> the stack or part of a newly allocated table). Won't that cause false
> positives here?

Could you please elaborate ? If the pte is not on a live page table, then
pte_valid() will return negative on such entries. So any update there will
be safe. I am wondering, how this change will cause false positives which
would not have been possible earlier.
