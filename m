Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F6E6FA30E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbjEHJPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbjEHJPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:15:02 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C659ECF;
        Mon,  8 May 2023 02:15:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0Vi312Yk_1683537294;
Received: from 30.221.149.87(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0Vi312Yk_1683537294)
          by smtp.aliyun-inc.com;
          Mon, 08 May 2023 17:14:56 +0800
Message-ID: <b640e7e2-bbdd-c746-4006-d086a55a9615@linux.alibaba.com>
Date:   Mon, 8 May 2023 17:14:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/5] driver/perf: Add identifier sysfs file for CMN
To:     John Garry <john.g.garry@oracle.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>
References: <1682329456-19418-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1682329456-19418-2-git-send-email-renyu.zj@linux.alibaba.com>
 <df63b597-4355-b9fc-6002-5a390b1a56f5@oracle.com>
 <12bf4a7f-e99c-47cf-e8e4-e2700db6c5c9@arm.com>
 <da55ef21-e199-79c3-5b65-d51edb2e754b@oracle.com>
 <6bb7eaee-2d00-46f5-89ff-95133aea9a5d@arm.com>
 <98eaaa87-ae33-5479-dee0-71e42bc5d798@oracle.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <98eaaa87-ae33-5479-dee0-71e42bc5d798@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/5 下午8:24, John Garry 写道:
> On 04/05/2023 13:15, Robin Murphy wrote:
>>>
>>> ok, I see, that's what I was asking about in the cmn-700 JSON review; and from what you say, it is not the case that we always have the same events for every revision. So we need a more fine-grained identifier.
>>
>> Yes, it's mostly just a case of new events getting added as the microarchitecture evolves over the product's lifetime,
> 
> I might have mentioned this before: Currently userspace matches both the PMU sysfs name and this HW identifier for creating these event aliases. For fixed events - like those non-IMPDEF ones on the PMCG - userspace could just assume those standard ones are implemented and not need to check the HW identifier. Maybe this will help with scalability of JSONs for CMN PMU implementations. Or even HW identifier wildcard matching. However, as you might anticipate, we may need to add some sort of userspace support for times when HW implementations get messed up...
> 
>> but there has been at least one event ID which had a meaning in very early versions of CMN-600, was subsequently removed, and then got reused for a *different* event a couple of revisions after that.
>> Thankfully I believe those earliest versions only ever existed on FPGA internally, and the TRMs were never made public, so upstream doesn't care about that specific case.
> 
> ok, good
> 

Thanks John and Robin, perhaps using CMN's model and revision to form an identifier is currently the most feasible solution?
For example: CMN600_R1P0, CMN600_R1P1. The revision of CMN can be obtained from the revision register.

>>
>>> For DT support, I suppose per-revision compat strings could be added, but I would not be sure what to do about ACPI.
>>

Yes, I also have this doubt. On DT, char* can be passed in through the data field because it is of void* type, but the driver_data
field of ACPI is ulong. In addition, the revision is read out through the register, and I cannot get the revision in
arm_cmn_acpi/of_match[]. We still need to compose the identifier in the probe function. So, I wonder if it is better to use an
additional function to form the identifier instead of passing the identifier through arm_cmn_acpi/of_match[]?

>> We know the version from the ID registers, that's no problem - it's already used to manage visibility of the sysfs event aliases. In principle we *should* have a model code in CFGM_PERIPH_ID_0 as well, and be able to compose an identifier exactly the same way as smmu_pmu_get_iidr() does in the SMMUv3 PMCG driver, but as I mentioned before I'm not entirely confident in the implementation: I do happen to know what codes have been nominally assigned for each product, but the TRMs claim otherwise 🙁
> 
> Thanks,
> John


Thanks,
Jing
