Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8CF6D6A4A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbjDDRTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbjDDRTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:19:02 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AEE4ED5;
        Tue,  4 Apr 2023 10:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680628723; x=1712164723;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Efgn0wgG6M3dPrOoOF4i+0f2G3SonPMACefzAUfo3bY=;
  b=eQ816N22jGlonHOa0mgO/tr3XhTJCpLzj6AZBZR1Ywsw0BQi/KWLgBgJ
   WUSF4ypWKWwiRFzwh2PHlvQl7WwkxDxSJqe9S+4DQuz0Jp/hy9DLDbQIv
   buCsNwrlr68psQerSRiiQN2731IKnRqijIbKQYpLd6eNTpdeqmPEWOcM1
   j2XZ4o4GQzdK6MhGE/DStifScQ4RCsWlwun3g3lOVculDmMrF/QsntCIS
   GJ2xj1dkCj9ysSlLTXLVEt6E8mGOIUw4YUMYFIWuBDM2AUOyRDO1NRoHO
   +R31qVSGSLDFzP9AFGohTcSwGyXXLtVH6eDq+JagiL0TT8YRFzdOwHxcB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="330847141"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="330847141"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 10:18:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="1016186296"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="1016186296"
Received: from rajatkha-mobl.gar.corp.intel.com (HELO [10.215.121.35]) ([10.215.121.35])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 10:18:41 -0700
Message-ID: <c82c6577-a363-241b-ffd6-f5c4c9ed838d@linux.intel.com>
Date:   Tue, 4 Apr 2023 22:48:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] usb: typec: intel_pmc_mux: Expose IOM port status to
 debugfs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230330104821.773053-1-rajat.khandelwal@linux.intel.com>
 <ZCVsH2KkfcMA86hJ@kroah.com>
Content-Language: en-US
From:   Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
In-Reply-To: <ZCVsH2KkfcMA86hJ@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/30/2023 4:31 PM, Greg KH wrote:
> On Thu, Mar 30, 2023 at 04:18:21PM +0530, Rajat Khandelwal wrote:
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
>>   drivers/usb/typec/mux/intel_pmc_mux.c | 44 +++++++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>
>> diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
>> index 34e4188a40ff..c99d20888f5d 100644
>> --- a/drivers/usb/typec/mux/intel_pmc_mux.c
>> +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
>> @@ -15,6 +15,7 @@
>>   #include <linux/usb/typec_mux.h>
>>   #include <linux/usb/typec_dp.h>
>>   #include <linux/usb/typec_tbt.h>
>> +#include <linux/debugfs.h>
>>   
>>   #include <asm/intel_scu_ipc.h>
>>   
>> @@ -145,6 +146,8 @@ struct pmc_usb {
>>   	u32 iom_port_status_offset;
>>   };
>>   
>> +static struct dentry *pmc_mux_debugfs_root;
> Why not just look up the dentry and delete it when you want it with a
> call to debugfs_lookup_and_remove() instead?  That way you don't have to
> keep it around (hint, pass it back from your call to
> pmc_mux_debugfs_init() or better yet, don't even have a
> pmc_mux_debugfs_init() function as it only contains one line and is
> only called in one place.
>
> This will save you the storage space of this variable if debugfs is not
> enabled in your kernel.  A small amount, yes, but it's nicer, right?

I see. Yes, though a small amount, you're anyways right.

1. Though a single-line function, I explicitly defined it to make it more readable.
ATM, maintaining a small different framework within the file for another function
(debugfs) somehow presents a more 'organized' code to me, if that makes sense? :)

2. About the suggestion of not keeping the debugfs_root static throughout the
execution, I can change it as per your suggestion, but I'd like to keep it this
way, if that's ok? This way, it would fit nice in the future if more variables
are to be added.

Let me know your thoughts.

Thanks
Rajat

>
> thanks,
>
> greg k-h
