Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A096670D586
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbjEWHoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbjEWHob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:44:31 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7555695;
        Tue, 23 May 2023 00:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684827870; x=1716363870;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lZbI7pLXiFlhXhGMkTTyFN8Mh1aISQz9hrjO+FHTjkg=;
  b=WkO+J0dgiUVvWvuOCz+UtlaJuXqctOo0V52Cr65LdbH9wgMy4LnbkPy+
   EgOcM244+nj2XpnGWr9CF33HF8FwAi285vbQT3jG7XVe9Z60/zgC+gURF
   SOckxmGTFh6noWl0Ni9jjBVMQV/kYjVcJcgjz6ErFPKqKUb0Lbc2LxP4y
   vaDA9TWhIdY6xKle8rxY5rndnKWBH3p++U4FWghgk7bN2px7Az7lilQu6
   b5s0CHwXEURUcVU5tAUu6FPqtVGNxZNcZulztku//2zV6f/0TBbV+gTnk
   OVoRaatHDqocI4r9af4ZfDk2imB0ALbXPvN4SjIvTpW+b5H3+9YoDWNUA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="342623939"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="342623939"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 00:43:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="1033958232"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="1033958232"
Received: from rajatkha-mobl.gar.corp.intel.com (HELO [10.67.146.41]) ([10.67.146.41])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 00:43:40 -0700
Message-ID: <81e51edf-9ae8-4ce4-c203-af05f0d82f48@linux.intel.com>
Date:   Tue, 23 May 2023 13:13:37 +0530
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
 <ab993b87-8475-7c71-f526-da9a0b5fa3a8@linux.intel.com>
 <2023052215-skilled-polygraph-33dd@gregkh>
From:   Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
In-Reply-To: <2023052215-skilled-polygraph-33dd@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/22/2023 9:56 PM, Greg KH wrote:
> On Mon, May 22, 2023 at 03:24:13PM +0530, Rajat Khandelwal wrote:
>> Hi,
>>
>> On 5/22/2023 1:07 PM, Greg KH wrote:
>>> On Mon, May 22, 2023 at 12:33:43PM +0530, Rajat Khandelwal wrote:
>>>> IOM status has a crucial role during debugging to check the
>>>> current state of the type-C port.
>>>> There are ways to fetch the status, but all those require the
>>>> IOM port status offset, which could change with platform.
>>>>
>>>> Make a debugfs directory for intel_pmc_mux and expose the status
>>>> under it per port basis.
>>>>
>>>> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
>>>> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>>>> ---
>>>>
>>>> v4:
>>>> 1. Maintain a root directory for PMC module and incorporate devices
>>>> under it
>>>> 2. Add the debugfs module under '/sys/kernel/debug/usb'
>>>> 3. Use the platform device 'pmc->dev' to assign the device's name
>>>>
>>>> v3: Allocate the debugfs directory name for the platform device with
>>>> its ACPI dev name included
>>>>
>>>> v2:
>>>> 1. Remove static declaration of the debugfs root for 'intel_pmc_mux'
>>>> 2. Remove explicitly defined one-liner functions
>>>>
>>>>    drivers/usb/typec/mux/intel_pmc_mux.c | 54 ++++++++++++++++++++++++++-
>>>>    1 file changed, 53 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
>>>> index 34e4188a40ff..f400094c76f2 100644
>>>> --- a/drivers/usb/typec/mux/intel_pmc_mux.c
>>>> +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
>>>> @@ -15,6 +15,8 @@
>>>>    #include <linux/usb/typec_mux.h>
>>>>    #include <linux/usb/typec_dp.h>
>>>>    #include <linux/usb/typec_tbt.h>
>>>> +#include <linux/debugfs.h>
>>>> +#include <linux/usb.h>
>>>>    #include <asm/intel_scu_ipc.h>
>>>> @@ -143,8 +145,14 @@ struct pmc_usb {
>>>>    	struct acpi_device *iom_adev;
>>>>    	void __iomem *iom_base;
>>>>    	u32 iom_port_status_offset;
>>>> +
>>>> +#ifdef CONFIG_DEBUG_FS
>>>> +	struct dentry *dentry;
>>>> +#endif
>>> No need for the #ifdef anymore, right?  In fact, I think it will break
>>> the build if you have it this way and CONFIG_DEBUG_FS is not enabled,
>>> right?
>> I guess you're right. Maybe it'd have been fine if the rest of the
>> debugfs stuff was also enclosed within the conditional macros.
> Which is not needed and not good kernel coding style, so it's right that
> they are not there.

Sure.

>
>> Anyways, removing it seems appropriate now.
>>
>> Also, is it OK to send you v5 on the public list directly?
> Where else would you send it?

I was under the impression that you'd again require the review
internally under Intel before releasing out to public list.
Anyways, sending out v5.

Thanks
Rajat

>
> confused,
>
> greg k-h
