Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D645BFC9D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 12:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiIUKyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 06:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiIUKyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 06:54:08 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F90A7CAA0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 03:54:06 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MXZtl1XHMzmWL9;
        Wed, 21 Sep 2022 18:50:07 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 18:54:02 +0800
Received: from [10.67.101.149] (10.67.101.149) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 18:54:02 +0800
Subject: Re: [PATCH v2] iommu/iova: Optimize alloc_iova with rbtree_augmented
To:     Peng Zhang <zhangpeng.00@bytedance.com>, <joro@8bytes.org>,
        <will@kernel.org>
References: <20220824095139.66477-1-zhangpeng.00@bytedance.com>
 <42909903-5b6c-efe8-9ed3-3ac012f1a421@huawei.com>
 <bdcf9676-7846-1f14-1dd1-80cb9dcb0794@bytedance.com>
CC:     <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <robin.murphy@arm.com>, <haifeng.zhao@linux.intel.com>,
        <john.garry@huawei.com>
From:   "wangjie (L)" <wangjie125@huawei.com>
Message-ID: <36ce6959-a4ed-bf33-9e7c-f35a63bf9434@huawei.com>
Date:   Wed, 21 Sep 2022 18:54:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <bdcf9676-7846-1f14-1dd1-80cb9dcb0794@bytedance.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.149]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Jie Wang <wangjie125@huawei.com>

On 2022/9/21 11:55, Peng Zhang wrote:
>> This patch seems to solve the performance issues i have.  Currently my
>> nic's rx performance is unstable in large-capacity scenarios. I
>> applied this patch to 5.19 rc4 and tested 8 times rx performance in
>> these scenes. Here are test results, "before" row is the result of
>> 5.19 rc4. "after" row means 5.19 rc4 with this patch, the unit is Mbits/s
>>
>>      1    2    3    4    5    6    7    8
>> before    55430    76701    84194    77560    88292    90106
>> 87770    77273
>> after    92770    92767    92792    92764    92742    92696
>> 92781    92756
>>
>> Obviously, after using this patch, the performance is stable.
>
> Thank you for your test. Can you add a "Tested-by" token?
> I plan to update the commit message in the next version.
> .
>
