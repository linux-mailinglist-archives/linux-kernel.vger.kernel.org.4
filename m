Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4270570D136
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbjEWC20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjEWC2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:28:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E146CA;
        Mon, 22 May 2023 19:28:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5F3811FB;
        Mon, 22 May 2023 19:29:07 -0700 (PDT)
Received: from [10.162.42.7] (unknown [10.162.42.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF45E3F67D;
        Mon, 22 May 2023 19:28:16 -0700 (PDT)
Message-ID: <f1b6f213-78d4-e0ea-ceb1-c220d081a88f@arm.com>
Date:   Tue, 23 May 2023 07:58:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V3 3/6] coresight: etm4x: Drop pid argument from
 etm4_probe()
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org
Cc:     Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        Steve Clevenger <scclevenger@os.amperecomputing.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <20230519052149.1367814-1-anshuman.khandual@arm.com>
 <20230519052149.1367814-4-anshuman.khandual@arm.com>
 <b40b3512-1782-80ad-2bcc-6a7558fc64a2@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <b40b3512-1782-80ad-2bcc-6a7558fc64a2@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/23 18:08, Suzuki K Poulose wrote:
> On 19/05/2023 06:21, Anshuman Khandual wrote:
>> Coresight device pid can be retrieved from its iomem base address, which is
>> stored in 'struct etm4x_drvdata'. This drops pid argument from etm4_probe()
>> and 'struct etm4_init_arg'. Instead etm4_check_arch_features() derives the
>> coresight device pid with a new helper coresight_get_pid(), right before it
>> is consumed in etm4_hisi_match_pid().
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: Leo Yan <leo.yan@linaro.org>
>> Cc: coresight@lists.linaro.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   .../coresight/coresight-etm4x-core.c          | 29 ++++++++++---------
>>   include/linux/coresight.h                     | 12 ++++++++
>>   2 files changed, 27 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index 748d2ef53cb0..914ef6eb85d1 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -66,7 +66,6 @@ static u64 etm4_get_access_type(struct etmv4_config *config);
>>   static enum cpuhp_state hp_online;
>>     struct etm4_init_arg {
>> -    unsigned int        pid;
>>       struct device        *dev;
>>       struct csdev_access    *csa;
>>   };
>> @@ -370,9 +369,17 @@ static void etm4_disable_arch_specific(struct etmv4_drvdata *drvdata)
>>   }
>>     static void etm4_check_arch_features(struct etmv4_drvdata *drvdata,
>> -                      unsigned int id)
>> +                     struct csdev_access *csa)
>>   {
>> -    if (etm4_hisi_match_pid(id))
>> +    /*
>> +     * coresight_get_pid() fetches device PID from the iomem
>> +     * register based accesses, which cannot be performed on
>> +     * system instruction based devices.
>> +     */
> 
> Minor nit: Please fix the comment to say something like :
> 
>     /*
>      * TRCPIDR* registers are not required for ETMs with system
>      * instructions. They must be identified by the MIDR+REVIDRs.
>      * Skip the TRCPID checks for now.
>      */
> 
> Rest looks good to me.

Will change the in-code comment as suggested.
