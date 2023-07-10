Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EF374D77F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjGJN2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbjGJN2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:28:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48003103
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 06:28:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7BE02B;
        Mon, 10 Jul 2023 06:29:01 -0700 (PDT)
Received: from [10.57.77.63] (unknown [10.57.77.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC7BC3F67D;
        Mon, 10 Jul 2023 06:28:16 -0700 (PDT)
Message-ID: <4dc1d2e1-d5d7-2812-aa8b-f8ba6b9fb207@arm.com>
Date:   Mon, 10 Jul 2023 14:28:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v1 00/14] Transparent Contiguous PTEs for User Mappings
To:     Barry Song <21cnbao@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230622144210.2623299-1-ryan.roberts@arm.com>
 <CAGsJ_4x4b5Qe2RNTHyR2MQqSkRxcuchrUgrap9WTaDtuMUttcA@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4x4b5Qe2RNTHyR2MQqSkRxcuchrUgrap9WTaDtuMUttcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2023 13:05, Barry Song wrote:
> On Thu, Jun 22, 2023 at 11:00 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> Hi All,
>>
[...]
>>
>> Performance
>> -----------
>>
>> Below results show 2 benchmarks; kernel compilation and speedometer 2.0 (a
>> javascript benchmark running in Chromium). Both cases are running on Ampere
>> Altra with 1 NUMA node enabled, Ubuntu 22.04 and XFS filesystem. Each benchmark
>> is repeated 15 times over 5 reboots and averaged.
>>
>> All improvements are relative to baseline-4k. anonfolio and exefolio are as
>> described above. contpte is this series. (Note that exefolio only gives an
>> improvement because contpte is already in place).
>>
>> Kernel Compilation (smaller is better):
>>
>> | kernel       |   real-time |   kern-time |   user-time |
>> |:-------------|------------:|------------:|------------:|
>> | baseline-4k  |        0.0% |        0.0% |        0.0% |
>> | anonfolio    |       -5.4% |      -46.0% |       -0.3% |
>> | contpte      |       -6.8% |      -45.7% |       -2.1% |
>> | exefolio     |       -8.4% |      -46.4% |       -3.7% |
> 
> sorry i am a bit confused. in exefolio case, is anonfolio included?
> or it only has large cont-pte folios on exe code? in the other words,
> Does the 8.4% improvement come from iTLB miss reduction only,
> or from both dTLB and iTLB miss reduction?

The anonfolio -> contpte -> exefolio results are incremental. So:

anonfolio: baseline-4k + anonfolio changes
contpte: anonfolio + contpte changes
exefolio: contpte + exefolio changes

So yes, exefolio includes anonfolio. Sorry for the confusion.

> 
>> | baseline-16k |       -8.7% |      -49.2% |       -3.7% |
>> | baseline-64k |      -10.5% |      -66.0% |       -3.5% |
>>
>> Speedometer 2.0 (bigger is better):
>>
>> | kernel       |   runs_per_min |
>> |:-------------|---------------:|
>> | baseline-4k  |           0.0% |
>> | anonfolio    |           1.2% |
>> | contpte      |           3.1% |
>> | exefolio     |           4.2% |
> 
> same question as above.

same answer as above.

Thanks,
Ryan


> 
>> | baseline-16k |           5.3% |
>>

