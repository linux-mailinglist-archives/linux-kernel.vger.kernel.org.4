Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D9C6E3F39
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 07:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjDQF66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 01:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDQF6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 01:58:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD8F2D53;
        Sun, 16 Apr 2023 22:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681711134; x=1713247134;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XpJA/VDNInNwpx1Q3RwqthdftS7G80YAsj9WRQgRluU=;
  b=Z4Kqbq3SVDJ4CwXMlLScjTX1bUZyURvOxMWYPpSwdyG/ZVXgPmr8n1Pe
   zG6OzSpioyBr+SseNcNgb4Di5oYnc3CesP2lj7qMsRogH9vkbDjJ9yx2i
   0vWYcBck6dVZWF6/SSjpDgrdtSO9Xe+Kzr6tLFeX7NWBaWTLqBzVuqM7e
   zKAahQlYKSqMdrvGHBOcEvtH1JawX38sqddPsqzEINevHUV7R8Lx1oDmp
   xFCPyd09wLnn4ha3kz7aH4Lz1PKrpVZXlCeWf5yv2sSP3S1aSxgGQIOxW
   1DaRbWgTC0oUjKbcvMkiaudmvggF73F4spSIaRseXXFwKkd4Jr+7V+d5V
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="344810312"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="344810312"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 22:58:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="864882178"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="864882178"
Received: from rajatkha-mobl.gar.corp.intel.com (HELO [10.67.146.22]) ([10.67.146.22])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 22:58:48 -0700
Message-ID: <2c960f0c-5cbb-4c2d-07cb-dafd94d22414@linux.intel.com>
Date:   Mon, 17 Apr 2023 11:28:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2] usb: typec: intel_pmc_mux: Expose IOM port status to
 debugfs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230414081910.1336405-1-rajat.khandelwal@linux.intel.com>
 <ZDo2mzmjZpWIKbxk@kroah.com>
Content-Language: en-US
From:   Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
In-Reply-To: <ZDo2mzmjZpWIKbxk@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/15/2023 11:01 AM, Greg KH wrote:
> On Fri, Apr 14, 2023 at 01:49:10PM +0530, Rajat Khandelwal wrote:
>> IOM status has a crucial role during debugging to check the
>> current state of the type-C port.
>> There are ways to fetch the status, but all those require the
>> IOM port status offset, which could change with platform.
>>
>> Make a debugfs directory for intel_pmc_mux and expose the status
>> under it per port basis.
>>
>> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
>> ---
>>
>> v2:
>> 1. Remove static declaration of the debugfs root for 'intel_pmc_mux'
>> 2. Remove explicitly defined one-liner functions
>>
>>   drivers/usb/typec/mux/intel_pmc_mux.c | 34 +++++++++++++++++++++++++++
>>   1 file changed, 34 insertions(+)
>>
>> diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
>> index 34e4188a40ff..1d43b111781e 100644
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
>> @@ -639,9 +640,34 @@ static int pmc_usb_probe_iom(struct pmc_usb *pmc)
>>   	return 0;
>>   }
>>   
>> +static int port_iom_status_show(struct seq_file *s, void *unused)
>> +{
>> +	struct pmc_usb_port *port = s->private;
>> +
>> +	update_port_status(port);
>> +	seq_printf(s, "0x%08x\n", port->iom_status);
>> +
>> +	return 0;
>> +}
>> +DEFINE_SHOW_ATTRIBUTE(port_iom_status);
>> +
>> +static void pmc_mux_port_debugfs_init(struct pmc_usb_port *port,
>> +				      struct dentry *pmc_mux_debugfs_root)
>> +{
>> +	struct dentry *debugfs_dir;
>> +	char name[6];
>> +
>> +	snprintf(name, sizeof(name), "port%d", port->usb3_port - 1);
>> +
>> +	debugfs_dir = debugfs_create_dir(name, pmc_mux_debugfs_root);
>> +	debugfs_create_file("iom_status", 0400, debugfs_dir, port,
>> +			    &port_iom_status_fops);
>> +}
>> +
>>   static int pmc_usb_probe(struct platform_device *pdev)
>>   {
>>   	struct fwnode_handle *fwnode = NULL;
>> +	struct dentry *pmc_mux_debugfs_root;
>>   	struct pmc_usb *pmc;
>>   	int i = 0;
>>   	int ret;
>> @@ -674,6 +700,8 @@ static int pmc_usb_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		return ret;
>>   
>> +	pmc_mux_debugfs_root = debugfs_create_dir("intel_pmc_mux", NULL);
> What happens when you have more than one device in the system at the
> same time?

I'm sorry I didn't understand the question. We would have separate directories
for all the ports which would contain the 'iom_status' file, thus representing
status for all the ports individually.
Can you rephrase the question since I guess you had something else in mind?

Thanks
Rajat

>
> thanks,
>
> greg k-h
