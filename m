Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936316B968C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjCNNlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjCNNk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:40:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB2362862;
        Tue, 14 Mar 2023 06:38:31 -0700 (PDT)
Received: from kwepemm600009.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PbXCJ24CrzHwfB;
        Tue, 14 Mar 2023 20:00:12 +0800 (CST)
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 14 Mar 2023 20:02:21 +0800
Subject: Re: [PATCH v2 0/6] md/raid10: several simple obvious bugfix
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
CC:     <guoqing.jiang@linux.dev>, <jgq516@gmail.com>, <neilb@suse.de>,
        <shli@fb.com>, <lzhong@suse.com>, <linux-raid@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, "yukuai (C)" <yukuai3@huawei.com>
References: <20230310073855.1337560-1-yukuai1@huaweicloud.com>
 <CAPhsuW4x9KScK4DZPMMWi4vpGLWMq5pdzqOKR4L0zNYWfjK1Ow@mail.gmail.com>
From:   Yu Kuai <yukuai3@huawei.com>
Message-ID: <bfe08af3-d89b-9052-42c8-dd0529c16b3d@huawei.com>
Date:   Tue, 14 Mar 2023 20:02:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4x9KScK4DZPMMWi4vpGLWMq5pdzqOKR4L0zNYWfjK1Ow@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Song!

在 2023/03/14 6:37, Song Liu 写道:
> On Thu, Mar 9, 2023 at 11:39 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> We're running many tests for raid10 currently, and we found a lot of
>> problems already. This patchset is the first part for some simple and
>> obvious problems. Most of the patches were sent separately already, but
>> I think a patchset is better for review.
>>

We had many testcase for raid10 locally，just consulte that is mdadm the
only place to push some new tests? We're maintaining tests through
blktests, is't ok if we push those tests to blktests?

Thanks,
Kuai

>> Yu Kuai (6):
>>    md/raid10: don't call bio_start_io_acct twice for bio which
>>      experienced read error
>>    md: fix soft lockup in status_resync
>>    md/raid10: don't BUG_ON() in raise_barrier()
>>    md/radi10: fix leak of 'r10bio->remaining' for recovery
>>    md/raid10: fix memleak for 'conf->bio_split'
>>    md/raid10: fix memleak of md thread
> 
> Applied 2/6 to 6/6 to md-next. Thanks!
> 
> Song
> 
>>
>>   drivers/md/md.c     | 18 +++++------
>>   drivers/md/raid10.c | 78 +++++++++++++++++++++++----------------------
>>   2 files changed, 49 insertions(+), 47 deletions(-)
>>
>> --
>> 2.31.1
>>
> .
> 
