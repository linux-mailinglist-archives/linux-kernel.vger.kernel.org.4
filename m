Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887C25EF310
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbiI2KJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235327AbiI2KJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:09:13 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77088148A30;
        Thu, 29 Sep 2022 03:09:12 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MdTZL54HBz6H76J;
        Thu, 29 Sep 2022 18:07:54 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Thu, 29 Sep 2022 12:09:09 +0200
Received: from [10.126.170.84] (10.126.170.84) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 11:09:09 +0100
Message-ID: <2a4a15a4-55cd-f98b-4b14-474f24e2c308@huawei.com>
Date:   Thu, 29 Sep 2022 11:09:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] perf tools: Fix empty version number when building
 outside of a git repo
To:     Will Chandler <wfc@wfchandler.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220927195228.47304-1-wfc@wfchandler.org>
 <c5181877-2998-b952-abe6-26d733ae2aeb@huawei.com>
 <87A1F5B6-3F60-4988-8BA6-A993E5789C80@wfchandler.org>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <87A1F5B6-3F60-4988-8BA6-A993E5789C80@wfchandler.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.170.84]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 18:26, Will Chandler wrote:
> On 28 Sep 2022, at 5:21, John Garry wrote:
> 
>> This looks ok. But did you consider going back to same flow as pre-7572733b8499 to avoid a Makefile check, like:
>>
>> ---8<----
>>
>> CID=
>> TAG=
>> if test -d ../../.git -o -f ../../.git
>> then
>> TAG=$(MAKEFLAGS= make -sC ../.. kernelversion)
>> CID=$(git log -1 --abbrev=12 --pretty=format:"%h" 2>/dev/null) && CID="-g$CID"
>> elif test -f ../../PERF-VERSION-FILE
>> then
>> TAG=$(cut -d' ' -f3 ../../PERF-VERSION-FILE | sed -e 's/\"//g')
>> fi
>> if test -z "$TAG"
>> then
>> TAG=$(MAKEFLAGS= make -sC ../.. kernelversion)
>> fi
>>
>> --->8---
>>
>> The evaluation for $TAG is not really needed in the first leg since the fallback does the same thing, but just added for clarity.
> 
> I think that would be fine as well. I don't have a strong opinion on which one
> is easier to follow.
> 
> Looking at this more closely, there is a slight difference between the two
> approaches. In the problem scenario my patch will always use `make kernelversion`,
> while pre-7572733b8499 starts with PERF-VERSION-FILE if available, falling
> back to the Makefile.
> 
> With the old approach PERF-VERSION-FILE could be used to manually
> override the version, but this is inconsistent with how the version is
> generated when building in a git repo. Is this relevant?

Hmmm... maybe someone would want to customise PERF-VERSION-FILE for 
their own distro. Not sure. But then fiddling with PERF-VERSION-FILE 
might break the parsing so...I guess not.

BTW, is there any other method of building the perf code not considered? 
So far I know:
a. in git tree
b. perf-tar-src-pkg
c. tarball

Thanks,
John
