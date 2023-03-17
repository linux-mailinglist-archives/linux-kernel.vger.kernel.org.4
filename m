Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DCD6BEDA3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjCQQEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjCQQES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:04:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3AA3213DFA;
        Fri, 17 Mar 2023 09:03:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD85213D5;
        Fri, 17 Mar 2023 09:04:37 -0700 (PDT)
Received: from [10.57.53.217] (unknown [10.57.53.217])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4832A3F885;
        Fri, 17 Mar 2023 09:03:51 -0700 (PDT)
Message-ID: <b1518e16-d74b-719c-a0fc-bc172a6011c4@arm.com>
Date:   Fri, 17 Mar 2023 16:03:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH 6/7] of/platform: Skip coresight etm4x devices from AMBA
 bus
To:     Rob Herring <robh+dt@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        scclevenger@os.amperecomputing.com,
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
References: <20230317030501.1811905-1-anshuman.khandual@arm.com>
 <20230317030501.1811905-7-anshuman.khandual@arm.com>
 <CAL_JsqK8vnwTZ3-nTd-S+dpCrQebAUm-NRiaJBE6KkoAVq=Ovg@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <CAL_JsqK8vnwTZ3-nTd-S+dpCrQebAUm-NRiaJBE6KkoAVq=Ovg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob

Thanks for your response.

On 17/03/2023 14:52, Rob Herring wrote:
> On Thu, Mar 16, 2023 at 10:06 PM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
>> Allow other drivers to claim a device, disregarding the "priority" of
>> "arm,primecell". e.g., CoreSight ETM4x devices could be accessed via MMIO
>> (AMBA Bus) or via CPU system instructions.
> 
> The OS can pick which one, use both, or this is a system integration
> time decision?

Not an OS choice. Historically, this has always been MMIO accessed but
with v8.4 TraceFiltering support, CPUs are encouraged to use system
instructions and obsolete MMIO. So, yes, MMIO is still possible but
something that is discouraged and have to be decided at system
integration time.

> 
>> The CoreSight ETM4x platform
>> driver can now handle both types of devices. In order to make sure the
>> driver gets to handle the "MMIO based" devices, which always had the
>> "arm,primecell" compatible, we have two options :
>>
>> 1) Remove the "arm,primecell" from the DTS. But this may be problematic
>>   for an older kernel without the support.
>>
>> 2) The other option is to allow OF code to "ignore" the arm,primecell
>> priority for a selected list of compatibles. This would make sure that
>> both older kernels and the new kernels work fine without breaking
>> the functionality. The new DTS could always have the "arm,primecell"
>> removed.
> 
> 3) Drop patches 6 and 7 and just register as both AMBA and platform
> drivers. It's just some extra boilerplate. I would also do different
> compatible strings for CPU system instruction version (assuming this
> is an integration time decision).

The system instruction (and the reigster layouts) are all part of the
ETMv4/ETE architecture and specific capabilities/features are
discoverable, just like the Arm CPUs. Thus we don't need special
versions within the ETMv4x or ETE minor versions. As of now, we have
one for etm4x and another for ete.

One problem with the AMBA driver in place is having to keep on adding
new PIDs for the CPUs. The other option is to have a blanket mask
for matching the PIDs with AMBA_UCI_ID checks.


> 
>>
>> This patch implements Option (2).
>>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Frank Rowand <frowand.list@gmail.com>
>> Cc: Russell King (Oracle) <linux@armlinux.org.uk>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Co-developed-by: Suzuki Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Suzuki Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   drivers/of/platform.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
>> index b2bd2e783445..59ff1a38ccaa 100644
>> --- a/drivers/of/platform.c
>> +++ b/drivers/of/platform.c
>> @@ -325,6 +325,13 @@ static const struct of_dev_auxdata *of_dev_lookup(const struct of_dev_auxdata *l
>>          return NULL;
>>   }
>>
>> +static const struct of_device_id of_ignore_amba_table[] = {
>> +#ifdef CONFIG_CORESIGHT_SOURCE_ETM4X
>> +       { .compatible = "arm,coresight-etm4x" },
>> +#endif
>> +       {}    /* NULL terminated */
>> +};
>> +
>>   /**
>>    * of_platform_bus_create() - Create a device for a node and its children.
>>    * @bus: device node of the bus to instantiate
>> @@ -373,7 +380,8 @@ static int of_platform_bus_create(struct device_node *bus,
>>                  platform_data = auxdata->platform_data;
>>          }
>>
>> -       if (of_device_is_compatible(bus, "arm,primecell")) {
>> +       if (of_device_is_compatible(bus, "arm,primecell") &&
>> +           unlikely(!of_match_node(of_ignore_amba_table, bus))) {
> 
> of_match_node is going to take orders of magnitude longer than any
> difference unlikely() would make. Drop it.

Agreed.

Suzuki

> 
>>                  /*
>>                   * Don't return an error here to keep compatibility with older
>>                   * device tree files.
>> --
>> 2.25.1
>>

