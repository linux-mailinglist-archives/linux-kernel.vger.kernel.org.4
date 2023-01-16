Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBA466BCFB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjAPLho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjAPLhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:37:42 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74EA3A9F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:37:41 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NwVJj35N8zJqkv;
        Mon, 16 Jan 2023 19:33:25 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 16 Jan 2023 19:37:37 +0800
Message-ID: <715cfcd3-47c3-f7f4-7dd1-4d76c6b147f8@huawei.com>
Date:   Mon, 16 Jan 2023 19:37:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next 7/7] mm: swap: remove unneeded
 cgroup_throttle_swaprate()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20230112083006.163393-1-wangkefeng.wang@huawei.com>
 <20230112083006.163393-8-wangkefeng.wang@huawei.com>
 <Y8F9rHVHu7XsBg49@casper.infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <Y8F9rHVHu7XsBg49@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On 2023/1/13 23:50, Matthew Wilcox wrote:
> On Thu, Jan 12, 2023 at 04:30:06PM +0800, Kefeng Wang wrote:
>> All the callers of cgroup_throttle_swaprate() are converted to
>> folio_throttle_swaprate(), so make __cgroup_throttle_swaprate()
>> to take a folio, and drop unused cgroup_throttle_swaprate().
> 
> Shouldn't __cgroup_throttle_swaprate() then be called
> __folio_throttle_swaprate()?

Sure.

> 
>> +extern void __cgroup_throttle_swaprate(struct folio *folio, gfp_t gfp_mask);
> 
> Also you can drop the 'extern'.

Ok.

> 
>> +static inline void folio_throttle_swaprate(struct folio *folio, gfp_t gfp_mask)
> 
> And it's not a gfp mask.  It's gfp_flags (we have this mistake all
> through the mm).  Or you can just call it 'gfp'.
> 
> 

Thanks for your kindly review and advise, will update.
