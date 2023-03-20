Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB31A6C0A31
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 06:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjCTFiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 01:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCTFiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 01:38:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E27E6EBA;
        Sun, 19 Mar 2023 22:38:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 848C9FEC;
        Sun, 19 Mar 2023 22:38:43 -0700 (PDT)
Received: from [10.162.41.7] (a077893.blr.arm.com [10.162.41.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61EE93F67D;
        Sun, 19 Mar 2023 22:37:54 -0700 (PDT)
Message-ID: <6ac7d093-b11c-b37f-8058-72c8d41fba73@arm.com>
Date:   Mon, 20 Mar 2023 11:07:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 6/7] of/platform: Skip coresight etm4x devices from AMBA
 bus
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>
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
 <b1518e16-d74b-719c-a0fc-bc172a6011c4@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <b1518e16-d74b-719c-a0fc-bc172a6011c4@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/17/23 21:33, Suzuki K Poulose wrote:
>>>   drivers/of/platform.c | 10 +++++++++-
>>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
>>> index b2bd2e783445..59ff1a38ccaa 100644
>>> --- a/drivers/of/platform.c
>>> +++ b/drivers/of/platform.c
>>> @@ -325,6 +325,13 @@ static const struct of_dev_auxdata *of_dev_lookup(const struct of_dev_auxdata *l
>>>          return NULL;
>>>   }
>>>
>>> +static const struct of_device_id of_ignore_amba_table[] = {
>>> +#ifdef CONFIG_CORESIGHT_SOURCE_ETM4X
>>> +       { .compatible = "arm,coresight-etm4x" },
>>> +#endif
>>> +       {}    /* NULL terminated */
>>> +};
>>> +
>>>   /**
>>>    * of_platform_bus_create() - Create a device for a node and its children.
>>>    * @bus: device node of the bus to instantiate
>>> @@ -373,7 +380,8 @@ static int of_platform_bus_create(struct device_node *bus,
>>>                  platform_data = auxdata->platform_data;
>>>          }
>>>
>>> -       if (of_device_is_compatible(bus, "arm,primecell")) {
>>> +       if (of_device_is_compatible(bus, "arm,primecell") &&
>>> +           unlikely(!of_match_node(of_ignore_amba_table, bus))) {
>>
>> of_match_node is going to take orders of magnitude longer than any
>> difference unlikely() would make. Drop it.
> 
> Agreed.

Sure, will drop the unlikely() here.
