Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB145BC180
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 04:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiISCqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 22:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiISCqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 22:46:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C214BF70;
        Sun, 18 Sep 2022 19:46:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72BE613D5;
        Sun, 18 Sep 2022 19:46:50 -0700 (PDT)
Received: from [10.162.41.7] (unknown [10.162.41.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 053413F5A1;
        Sun, 18 Sep 2022 19:46:34 -0700 (PDT)
Message-ID: <7403e6bb-0011-381b-a99e-cbd9d7b1a270@arm.com>
Date:   Mon, 19 Sep 2022 08:16:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 4/4] arm64: support batched/deferred tlb shootdown
 during page reclamation
Content-Language: en-US
To:     Nadav Amit <namit@vmware.com>, Barry Song <21cnbao@gmail.com>
Cc:     Yicong Yang <yangyicong@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
        "yangyicong@hisilicon.com" <yangyicong@hisilicon.com>,
        "huzhanyuan@oppo.com" <huzhanyuan@oppo.com>,
        "lipeifeng@oppo.com" <lipeifeng@oppo.com>,
        "zhangshiming@oppo.com" <zhangshiming@oppo.com>,
        "guojian@oppo.com" <guojian@oppo.com>,
        "realmz6@gmail.com" <realmz6@gmail.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "xhao@linux.alibaba.com" <xhao@linux.alibaba.com>,
        "prime.zeng@hisilicon.com" <prime.zeng@hisilicon.com>,
        Barry Song <v-songbaohua@oppo.com>,
        Mel Gorman <mgorman@suse.de>
References: <20220822082120.8347-1-yangyicong@huawei.com>
 <20220822082120.8347-5-yangyicong@huawei.com>
 <1e8642d5-0e2d-5747-d0d2-5aa0817ea4af@arm.com>
 <CAGsJ_4xD4m-szM1Cm4N5ZRCODGC0fbW+BLBhy8g6+eK=aHPQNw@mail.gmail.com>
 <1125554b-c183-23c4-5516-95b918a761cc@arm.com>
 <CAGsJ_4zkRv7RYCB2SC0uydMSQWfwXs3-nkjxMoR7wgn2nt43gA@mail.gmail.com>
 <2AB9EC05-16B4-46F8-B716-53941C1C9A50@vmware.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <2AB9EC05-16B4-46F8-B716-53941C1C9A50@vmware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/22 20:01, Nadav Amit wrote:
> 
> 
>> On Sep 14, 2022, at 11:42 PM, Barry Song <21cnbao@gmail.com> wrote:
>>
>>>
>>> The very idea behind TLB deferral is the opportunity it (might) provide
>>> to accumulate address ranges and cpu masks so that individual TLB flush
>>> can be replaced with a more cost effective range based TLB flush. Hence
>>> I guess unless address range or cpumask based cost effective TLB flush
>>> is available, deferral does not improve the unmap performance as much.
>>
>>
>> After sending tlbi, if we wait for the completion of tlbi, we have to get Ack
>> from all cpus in the system, tlbi is not scalable. The point here is that we
>> avoid waiting for each individual TLBi. Alternatively, they are batched. If
>> you read the benchmark in the commit log, you can find the great decline
>> in the cost to swap out a page.
> 
> Just a minor correction: arch_tlbbatch_flush() does not collect ranges.
> On x86 it only accumulate CPU mask.

Thanks Nadav for the clarification.
