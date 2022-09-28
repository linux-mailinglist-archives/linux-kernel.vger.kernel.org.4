Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAAC5ED32F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 04:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiI1CzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 22:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiI1CzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 22:55:06 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC0190190
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 19:55:05 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mcgwd07V6zWgn8;
        Wed, 28 Sep 2022 10:50:57 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 10:55:02 +0800
Received: from [10.67.109.54] (10.67.109.54) by kwepemm600005.china.huawei.com
 (7.193.23.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 28 Sep
 2022 10:55:01 +0800
Subject: Re: [PATCH] mm/hwpoison: fix build error without
 CONFIG_MEMORY_FAILURE
To:     Bagas Sanjaya <bagasdotme@gmail.com>
References: <20220927102946.98622-1-tanghui20@huawei.com>
 <YzLpkmPrw0tbIo1W@debian.me>
CC:     <naoya.horiguchi@nec.com>, <linmiaohe@huawei.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
From:   Hui Tang <tanghui20@huawei.com>
Message-ID: <6960475d-3487-a328-e7e0-e1deff6df3bc@huawei.com>
Date:   Wed, 28 Sep 2022 10:55:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YzLpkmPrw0tbIo1W@debian.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.54]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/27 20:16, Bagas Sanjaya wrote:
> On Tue, Sep 27, 2022 at 06:29:46PM +0800, Hui Tang wrote:
>> Building without CONFIG_MEMORY_FAILURE will fail:
>>
>> mm/memory-failure.o: In function `action_result':
>> memory-failure.c: undefined reference to `memblk_nr_poison_inc'
>> mm/memory-failure.o: In function `page_handle_poison':
>> memory-failure.c: undefined reference to `memblk_nr_poison_inc'
>> mm/memory-failure.o: In function `__get_huge_page_for_hwpoison':
>> memory-failure.c: undefined reference to `memblk_nr_poison_inc'
>> mm/memory-failure.o: In function `unpoison_memory':
>> memory-failure.c: undefined reference to `memblk_nr_poison_sub'
>> mm/memory-failure.o: In function `num_poisoned_pages_inc':
>> memory-failure.c: undefined reference to `memblk_nr_poison_inc'
>>
>> Add CONFIG_MEMORY_FAILURE wrapper for invoking memblk_nr_poison_{inc|sub}.
>>
>
> Better say "Guard memblk_nr_poison_{inc,sub} under CONFIG_MEMORY_FAILURE".

Thanks.
