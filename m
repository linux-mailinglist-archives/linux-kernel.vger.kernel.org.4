Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA4370B979
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjEVJyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbjEVJyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:54:23 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2778CC2;
        Mon, 22 May 2023 02:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684749262; x=1716285262;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Tpv33id8FXgSyWY15secqhEjCEaHD/wMEKZRfaT7ChE=;
  b=l8L7ePGqHJgHfE+GKVySJ0ZjsJ3r5rXPC9JPUr2ycjst71zrJnV6Z2R4
   3zQYa8m8NIi1jnL6UA1h7X+sU6l7UxWTs8X5RF9Di1IfrAwaaar36dhdl
   mO/V40e0Ox9flskIMwUOi4eeoHwPULYIJx//sAs+WyL0j5NtkOe9PEL7F
   ZyKh55ST6x469aakH88C5Ai6GcotboebaJe0fpBmNbssjN2Qq2J797YyP
   lcqzSub2AXnX8ycBKFI6qfJ6IIF/ufsqCTPzYc2mIg5F0mcdnaPqAh9EW
   HOS2HQA6/8FywqZgzbsGqwp4lNlC4OHuVwcumuXXiyjfXsxjq3DZQcqsL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="352900229"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="352900229"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 02:54:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="653884244"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="653884244"
Received: from rajatkha-mobl.gar.corp.intel.com (HELO [10.67.146.41]) ([10.67.146.41])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 02:54:16 -0700
Message-ID: <ab993b87-8475-7c71-f526-da9a0b5fa3a8@linux.intel.com>
Date:   Mon, 22 May 2023 15:24:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4] usb: typec: intel_pmc_mux: Expose IOM port status to
 debugfs
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230522070343.3675581-1-rajat.khandelwal@linux.intel.com>
 <2023052216-railway-zipfile-680f@gregkh>
From:   Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
In-Reply-To: <2023052216-railway-zipfile-680f@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/22/2023 1:07 PM, Greg KH wrote:
> On Mon, May 22, 2023 at 12:33:43PM +0530, Rajat Khandelwal wrote:
>> IOM status has a crucial role during debugging to check the
>> current state of the type-C port.
>> There are ways to fetch the status, but all those require the
>> IOM port status offset, which could change with platform.
>>
>> Make a debugfs directory for intel_pmc_mux and expose the status
>> under it per port basis.
>>
>> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
>> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> ---
>>
>> v4:
>> 1. Maintain a root directory for PMC module and incorporate devices
>> under it
>> 2. Add the debugfs module under '/sys/kernel/debug/usb'
>> 3. Use the platform device 'pmc->dev' to assign the device's name
>>
>> v3: Allocate the debugfs directory name for the platform device with
>> its ACPI dev name included
>>
>> v2:
>> 1. Remove static declaration of the debugfs root for 'intel_pmc_mux'
>> 2. Remove explicitly defined one-liner functions
>>
>>   drivers/usb/typec/mux/intel_pmc_mux.c | 54 ++++++++++++++++++++++++++-
>>   1 file changed, 53 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
>> index 34e4188a40ff..f400094c76f2 100644
>> --- a/drivers/usb/typec/mux/intel_pmc_mux.c
>> +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
>> @@ -15,6 +15,8 @@
>>   #include <linux/usb/typec_mux.h>
>>   #include <linux/usb/typec_dp.h>
>>   #include <linux/usb/typec_tbt.h>
>> +#include <linux/debugfs.h>
>> +#include <linux/usb.h>
>>   
>>   #include <asm/intel_scu_ipc.h>
>>   
>> @@ -143,8 +145,14 @@ struct pmc_usb {
>>   	struct acpi_device *iom_adev;
>>   	void __iomem *iom_base;
>>   	u32 iom_port_status_offset;
>> +
>> +#ifdef CONFIG_DEBUG_FS
>> +	struct dentry *dentry;
>> +#endif
> No need for the #ifdef anymore, right?  In fact, I think it will break
> the build if you have it this way and CONFIG_DEBUG_FS is not enabled,
> right?

I guess you're right. Maybe it'd have been fine if the rest of the
debugfs stuff was also enclosed within the conditional macros.

Anyways, removing it seems appropriate now.

Also, is it OK to send you v5 on the public list directly?

Thanks
Rajat

> thanks,
>
> greg k-h
