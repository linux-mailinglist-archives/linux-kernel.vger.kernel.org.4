Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAB9617CF9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiKCMrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiKCMqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:46:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D00710B5C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 05:46:49 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N33MP0xPXzpWBG;
        Thu,  3 Nov 2022 20:43:13 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 20:46:47 +0800
Received: from [10.174.178.178] (10.174.178.178) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 20:46:46 +0800
Message-ID: <a62ed166-1929-e7da-feef-f3a4b1a2234e@huawei.com>
Date:   Thu, 3 Nov 2022 20:46:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH] mm: fix pcp count beyond pcp high in pcplist allocation
To:     Mel Gorman <mgorman@techsingularity.net>
CC:     <akpm@linux-foundation.org>, <vbabka@suse.cz>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <wangkefeng.wang@huawei.com>
References: <20221024134146.3442393-1-chenwandun@huawei.com>
 <20221024145555.oaoisy6m723h4axc@techsingularity.net>
 <f189c530-1576-21fa-4c12-caa62739bbd0@huawei.com>
 <20221025131959.sd47fipimhehf76i@techsingularity.net>
 <316bc0a2-34d9-e485-11d2-f3dffd0fdea4@huawei.com>
 <20221101104040.o6gqtyyd5d4pkhle@techsingularity.net>
From:   Chen Wandun <chenwandun@huawei.com>
In-Reply-To: <20221101104040.o6gqtyyd5d4pkhle@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.178]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/11/1 18:40, Mel Gorman 写道:
> On Mon, Oct 31, 2022 at 11:37:35AM +0800, Chen Wandun wrote:
>>>>>     As is, the patch could result in a batch request of 0 and
>>>>    I foget this, the patch need some improve, thanks.
>>>>
>>>>> fall through to allocating from the zone list anyway defeating the
>>>>> purpose of the PCP allocator and probably regressing performance in some
>>>>> csaes.
>>>> Same as I understand???how about set high/batch for each order in pcplist???
>>> Using anything would than (X >> order) consumes storage. Even if storage
>>> was to be used, selecting a value per-order would be impossible because
>>> the correct value would depend on frequency of requests for each order.
>>> That can only be determined at runtime and the cost of determining the
>>> value would likely exceed the benefit.
>> Can we set a experience value for pcp batch for each order during init
>> stage?
> I'm not sure what you mean by "experience value" but maybe you meant
> experimental value?
yes, experimental value,  sorry for that.
>
>> If so we can make accurately control for pcp size. Nowdays, the size of each
>> order in pcp list is full of randomness. I dont konw which scheme is better
>> for performance.
>>
> It is something that could be experimented with but the main question is
> -- what should those per-order values be? One option would be to enforce
> pcp->high for all high-order values except THP if THP is enabled. That would
> limit some of the issues with pcp->high being exceeded as even if two THPs
> are refilled, one of them is allocated immediately. I wasn't convinced it was
> necessary when implementing high-order PCP support but it could be evaluated.
Thank you for your suggestion, I will do some tests.

