Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3DB5F6E5C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbiJFTnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbiJFTno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:43:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD43E31BE;
        Thu,  6 Oct 2022 12:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=x1WQykTFdogUNfR/FNlEZcCnzyPKG+DrPzkj2b/37Xk=; b=w1lNjOWBjh4SLHvwVNZj6Wxwky
        lSk7tlIz9Uak/Z51JxUD8K4Jy/t3c/Yx6NZNPdsU/f1luUouGUaO+cInlwbNBVtfnqa/4acurxr6P
        j8XDC4aZmeusE4Cy1SfCxRc/2svCFbz+2VcXIgLI6mVFw6wDq3+Rj/DsTbY9w06+RLm5QfhIthGbZ
        UEZJzfSBzwPFpvy0HDJYxuEKDn+JC3I39Wquz0LNUrxB9RuN7++bEUfNrCjeEClReBPdoDdkD0jjY
        mXbGqsNemRrhNpd/WMwu33jUtYgB2wZY70u5nbqZMN6B92Ek9BFFgOSbRdooyzmj3mt67Flm46uA1
        86/lZJyg==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ogWmR-004pAa-55; Thu, 06 Oct 2022 19:43:39 +0000
Message-ID: <abe23973-700f-76e7-977f-8248328ada1b@infradead.org>
Date:   Thu, 6 Oct 2022 12:43:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] of: fdt: add stub for early_init_dt_scan()
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Rich Felker <dalias@libc.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <20221006031116.13586-1-rdunlap@infradead.org>
 <20221006193820.GA61296-robh@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221006193820.GA61296-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/22 12:38, Rob Herring wrote:
> On Wed, Oct 05, 2022 at 08:11:16PM -0700, Randy Dunlap wrote:
>> When CONFIG_OF_EARLY_FLATTREE and CONFIG_SH_DEVICE_TREE are not set,
>> SH3 build fails with a call to early_init_dt_scan(), so add a stub for
>> this function.
>>
>> ../arch/sh/kernel/setup.c: In function 'sh_fdt_init':
>> ../arch/sh/kernel/setup.c:262:26: error: implicit declaration of function 'early_init_dt_scan' [-Werror=implicit-function-declaration]
>>   262 |         if (!dt_virt || !early_init_dt_scan(dt_virt)) {
> 
> I think that sh_fdt_init() needs to be enclosed in 
> CONFIG_OF_EARLY_FLATTREE instead of CONFIG_OF_FLATTREE.
> 

OK, I'll try that. Thanks.

>>
>> Fixes: 7480e0aabd5f ("sh: add device tree support and generic board using device tree")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Frank Rowand <frowand.list@gmail.com>
>> Cc: devicetree@vger.kernel.org
>> Cc: Rich Felker <dalias@libc.org>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  include/linux/of_fdt.h |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> --- a/include/linux/of_fdt.h
>> +++ b/include/linux/of_fdt.h
>> @@ -85,6 +85,7 @@ extern void early_init_devtree(void *);
>>  extern void early_get_first_memblock_info(void *, phys_addr_t *);
>>  #else /* CONFIG_OF_EARLY_FLATTREE */
>>  static inline void early_init_dt_check_for_usable_mem_range(void) {}
>> +static inline bool early_init_dt_scan(void *params) { return false; }
>>  static inline int early_init_dt_scan_chosen_stdout(void) { return -ENODEV; }
>>  static inline void early_init_fdt_scan_reserved_mem(void) {}
>>  static inline void early_init_fdt_reserve_self(void) {}
>>

-- 
~Randy
