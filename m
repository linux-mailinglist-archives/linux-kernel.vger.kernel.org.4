Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9966D2F71
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 11:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjDAJis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 05:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDAJiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 05:38:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E82F63A97;
        Sat,  1 Apr 2023 02:38:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07E71106F;
        Sat,  1 Apr 2023 02:39:26 -0700 (PDT)
Received: from [10.57.54.53] (unknown [10.57.54.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E43D53F73F;
        Sat,  1 Apr 2023 02:38:38 -0700 (PDT)
Message-ID: <4660d44b-a53c-7323-0e0b-2a285e1a8c76@arm.com>
Date:   Sat, 1 Apr 2023 10:38:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH V2 3/5] coresight: etm4x: Drop pid argument from
 etm4_probe()
To:     scclevenger@os.amperecomputing.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     Rob Herring <robh+dt@kernel.org>,
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
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230327050537.30861-1-anshuman.khandual@arm.com>
 <20230327050537.30861-4-anshuman.khandual@arm.com>
 <d995fec6-1d3f-df37-724e-67d929e9e0db@arm.com>
 <a69dfdc6-31da-f813-858a-fdf246dea4fe@os.amperecomputing.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <a69dfdc6-31da-f813-858a-fdf246dea4fe@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2023 22:24, Steve Clevenger wrote:
> 
> 
> On 3/31/2023 4:06 AM, Suzuki K Poulose wrote:
>> On 27/03/2023 06:05, Anshuman Khandual wrote:
>>> Coresight device pid can be retrieved from its iomem base address,
>>> which is
>>> stored in 'struct etm4x_drvdata'. This drops pid argument from
>>> etm4_probe()
>>> and 'struct etm4_init_arg'. Instead etm4_check_arch_features() derives
>>> the
>>> coresight device pid with a new helper coresight_get_pid(), right
>>> before it
>>> is consumed in etm4_hisi_match_pid().
>>>
>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Cc: Mike Leach <mike.leach@linaro.org>
>>> Cc: Leo Yan <leo.yan@linaro.org>
>>> Cc: coresight@lists.linaro.org
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>>    .../coresight/coresight-etm4x-core.c          | 21 +++++++------------
>>>    include/linux/coresight.h                     | 12 +++++++++++
>>>    2 files changed, 20 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>> b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>> index 5d77571a8df9..3521838ab4fb 100644
>>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>> @@ -66,7 +66,6 @@ static u64 etm4_get_access_type(struct etmv4_config
>>> *config);
>>>    static enum cpuhp_state hp_online;
>>>      struct etm4_init_arg {
>>> -    unsigned int        pid;
>>>        struct device        *dev;
>>>        struct csdev_access    *csa;
>>>    };
>>> @@ -370,8 +369,10 @@ static void etm4_disable_arch_specific(struct
>>> etmv4_drvdata *drvdata)
>>>    }
>>>      static void etm4_check_arch_features(struct etmv4_drvdata *drvdata,
>>> -                      unsigned int id)
>>> +                     struct csdev_access *csa)
>>>    {
>>> +    unsigned int id = coresight_get_pid(csa);
>>> +
>>
>> This throws up the following error on an ETE.
>>
>> ete: trying to read unsupported register @fe0
>>
>> So, I guess this must be performed only for iomem based
>> devices. System instruction based device must be identified
>> by MIDR_EL1/REVIDR_EL1 if needed for specific erratum.
>> This is not required now. So, we could bail out early
>> if we are system instruction based device.
> 
> Besides this, the PID is limited to (I think) 4 bits of ID. TRCIDRs
> offer revision information, but nothing manufacturer specific save for
> the designer. Register fields like MIDR_EL1 Variant + PartNum + Revision
> and TRCPIDR3 REVAND offer help. It may be a combination of registers are
> needed for a manufacturer to adequately ID a part to apply an erratum.
> Perhaps you could at least cache MIDR_EL1 for possible future use?

Like I said, if we ever need them, we could add it. I don't see a point
in storing it right now, if we don't use it.

Suzuki
