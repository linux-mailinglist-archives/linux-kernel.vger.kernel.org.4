Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A8F5B9A51
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiIOMGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiIOMGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:06:01 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1968574E1A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 05:05:59 -0700 (PDT)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MSwNc6Ms8z68967;
        Thu, 15 Sep 2022 19:44:48 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 15 Sep 2022 13:45:44 +0200
Received: from [10.126.175.63] (10.126.175.63) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 15 Sep 2022 12:45:43 +0100
Message-ID: <bdb9abaf-2703-6d4c-9cab-f6e15e3e8b30@huawei.com>
Date:   Thu, 15 Sep 2022 12:45:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] iommu/iova: Fix module config properly
To:     Thierry Reding <thierry.reding@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <will@kernel.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
References: <548c2f683ca379aface59639a8f0cccc3a1ac050.1663069227.git.robin.murphy@arm.com>
 <4740744e-2e12-520d-8598-188b8d2ebd6b@huawei.com>
 <38988c89-ec61-faa1-6b15-2fd3aa51eede@arm.com> <YyGjPoM6ooNeJKhT@orome>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <YyGjPoM6ooNeJKhT@orome>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.175.63]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2022 10:47, Thierry Reding wrote:
> On Tue, Sep 13, 2022 at 03:15:18PM +0100, Robin Murphy wrote:
>> On 2022-09-13 14:01, John Garry wrote:
>>> On 13/09/2022 12:47, Robin Murphy wrote:
>>>> IOMMU_IOVA is intended to be an optional library for users to select as
>>>> and when they desire. Since it can be a module now, this means that
>>>> built-in code which has chosen not to select it should not fail to link
>>>> if it happens to have selected as a module by someone else. Replace
>>>> IS_ENABLED() with IS_REACHABLE() to do the right thing.
>>>
>>> Hi Robin,
>>>
>>> Recently you mentioned "I wonder if we couldn't replace the IS_ENABLED()
>>> with IS_REACHABLE() and restore some of the previously-conditional
>>> selects", and pointed me to 84db889e6d82 as an example of when a
>>> conditional select was made unconditional.
>>>
>>> So will you also restore some previously-conditional selects next?
>>
>> I figured I'd leave that up to Thierry (and/or anyone else with a vested
>> interest), but having mulled it over since that previous thread, there's
>> really no excuse for the API itself not to do the right thing either way, so
>> I felt compelled to write up this much.
> 
> On Tegra specifically, as the commit message says, we don't really care
> about the conditional selection because practically we always want IOMMU
> support enabled. So instead of adding back the conditional select it
> would make more sense to select IOMMU_API instead and then get rid of
> the handful of #ifdef blocks we have for that.

Out of curiosity, does the same go to host1x, whose kconfig got the same 
treatment as tegra with regards to selecting IOMMU_IOVA? I mean, will 
you not go back to conditionally selecting IOMMU_IOVA, and instead 
select IOMMU_API and IOMMU_IOVA always?

Thanks,
John

> 
> On a side note: I'm looking at a subtle regression right now where some
> corner case no longer works and that's primarily due to the fact that we
> can have four different scenarios: non-IOMMU, IOMMU, DMA/IOMMU and IOMMU
> but devices with no iommus property in their DT nodes. This has all
> become very unwieldy and becomes increasingly difficult to test. So
> anything that we can do to keep down the number of permutations is
> welcome.
> 
> While that's not directly related to this issue, the lesson learned is
> that, at least on the Tegra side, we have in the past made things
> unnecessarily difficult for ourselves based on the misguided assumption
> that maximum configurability is key.
> 
> Thierry

