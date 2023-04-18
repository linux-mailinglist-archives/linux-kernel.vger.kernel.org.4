Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543C36E5EAD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 12:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjDRKZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 06:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjDRKYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:24:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14198A7B;
        Tue, 18 Apr 2023 03:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681813463; x=1713349463;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L/G68DZojDRuvyygR4O8tyMLzhnlu0E7JmqGEGw0ABA=;
  b=dZurOMNjMvl0TeZq5vyTdtsaStmvxIcddviF+2qmkx+CMazZMzEvpKEW
   P+eBV1IWRr9NXA324w2zAWXs+MMlmohiMQJHmBLQucv+9e7/kG/asYok1
   xqblFtmyfYCzK+TXHKWoI1FSKDUNx8pFQ653+83WeHrVy4tsnM60tZjeh
   vYB/sLh/a42VO/opTy6jilKhbozOBTgx/llRGZZl98cgxaUJFgX5F5KkG
   SF2OL3XOoA+vm/gSnxYMu+x5H75tgqG65Tk0GBYpKgopQS2F0kUvRdpNJ
   7Tw4nAULv3Vrx+FKeVUj7u0LffFUfU1ENIm6KCr7VhSPMAcxnDVl6L6EJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="408031901"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="408031901"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 03:23:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="834831484"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="834831484"
Received: from rajatkha-mobl.gar.corp.intel.com (HELO [10.67.146.22]) ([10.67.146.22])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 03:23:48 -0700
Message-ID: <19c137ac-ac95-e6da-27d8-27d9cc8e9e40@linux.intel.com>
Date:   Tue, 18 Apr 2023 15:53:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2] usb: typec: intel_pmc_mux: Expose IOM port status to
 debugfs
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230414081910.1336405-1-rajat.khandelwal@linux.intel.com>
 <ZDo2mzmjZpWIKbxk@kroah.com>
 <2c960f0c-5cbb-4c2d-07cb-dafd94d22414@linux.intel.com>
 <ZDzjVG7QZP1z9gNX@kroah.com>
 <20cc057d-6b2b-5fc1-524f-c2c579c96a6b@linux.intel.com>
 <2023041859-humpback-thespian-e28c@gregkh>
From:   Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
In-Reply-To: <2023041859-humpback-thespian-e28c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/18/2023 3:48 PM, Greg KH wrote:
> On Tue, Apr 18, 2023 at 03:10:47PM +0530, Rajat Khandelwal wrote:
>> Hi,
>>
>> On 4/17/2023 11:42 AM, Greg KH wrote:
>>> On Mon, Apr 17, 2023 at 11:28:18AM +0530, Rajat Khandelwal wrote:
>>>> Hi,
>>>>
>>>> On 4/15/2023 11:01 AM, Greg KH wrote:
>>>>> On Fri, Apr 14, 2023 at 01:49:10PM +0530, Rajat Khandelwal wrote:
>>>>>> IOM status has a crucial role during debugging to check the
>>>>>> current state of the type-C port.
>>>>>> There are ways to fetch the status, but all those require the
>>>>>> IOM port status offset, which could change with platform.
>>>>>>
>>>>>> Make a debugfs directory for intel_pmc_mux and expose the status
>>>>>> under it per port basis.
>>>>>>
>>>>>> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
>>>>>> ---
>>>>>>
>>>>>> v2:
>>>>>> 1. Remove static declaration of the debugfs root for 'intel_pmc_mux'
>>>>>> 2. Remove explicitly defined one-liner functions
>>>>>>
>>>>>>     drivers/usb/typec/mux/intel_pmc_mux.c | 34 +++++++++++++++++++++++++++
>>>>>>     1 file changed, 34 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
>>>>>> index 34e4188a40ff..1d43b111781e 100644
>>>>>> --- a/drivers/usb/typec/mux/intel_pmc_mux.c
>>>>>> +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
>>>>>> @@ -15,6 +15,7 @@
>>>>>>     #include <linux/usb/typec_mux.h>
>>>>>>     #include <linux/usb/typec_dp.h>
>>>>>>     #include <linux/usb/typec_tbt.h>
>>>>>> +#include <linux/debugfs.h>
>>>>>>     #include <asm/intel_scu_ipc.h>
>>>>>> @@ -639,9 +640,34 @@ static int pmc_usb_probe_iom(struct pmc_usb *pmc)
>>>>>>     	return 0;
>>>>>>     }
>>>>>> +static int port_iom_status_show(struct seq_file *s, void *unused)
>>>>>> +{
>>>>>> +	struct pmc_usb_port *port = s->private;
>>>>>> +
>>>>>> +	update_port_status(port);
>>>>>> +	seq_printf(s, "0x%08x\n", port->iom_status);
>>>>>> +
>>>>>> +	return 0;
>>>>>> +}
>>>>>> +DEFINE_SHOW_ATTRIBUTE(port_iom_status);
>>>>>> +
>>>>>> +static void pmc_mux_port_debugfs_init(struct pmc_usb_port *port,
>>>>>> +				      struct dentry *pmc_mux_debugfs_root)
>>>>>> +{
>>>>>> +	struct dentry *debugfs_dir;
>>>>>> +	char name[6];
>>>>>> +
>>>>>> +	snprintf(name, sizeof(name), "port%d", port->usb3_port - 1);
>>>>>> +
>>>>>> +	debugfs_dir = debugfs_create_dir(name, pmc_mux_debugfs_root);
>>>>>> +	debugfs_create_file("iom_status", 0400, debugfs_dir, port,
>>>>>> +			    &port_iom_status_fops);
>>>>>> +}
>>>>>> +
>>>>>>     static int pmc_usb_probe(struct platform_device *pdev)
>>>>>>     {
>>>>>>     	struct fwnode_handle *fwnode = NULL;
>>>>>> +	struct dentry *pmc_mux_debugfs_root;
>>>>>>     	struct pmc_usb *pmc;
>>>>>>     	int i = 0;
>>>>>>     	int ret;
>>>>>> @@ -674,6 +700,8 @@ static int pmc_usb_probe(struct platform_device *pdev)
>>>>>>     	if (ret)
>>>>>>     		return ret;
>>>>>> +	pmc_mux_debugfs_root = debugfs_create_dir("intel_pmc_mux", NULL);
>>>>> What happens when you have more than one device in the system at the
>>>>> same time?
>>>> I'm sorry I didn't understand the question. We would have separate directories
>>>> for all the ports which would contain the 'iom_status' file, thus representing
>>>> status for all the ports individually.
>>>> Can you rephrase the question since I guess you had something else in mind?
>>> Can you please show the output of the directory
>>> /sys/kernel/debug/intel_pmc_mux/ with multiple pmc devices in the system
>>> at the same time?
>> Sorry, I don't own a system with multiple PMCs. Anyways, do we even have
>> a system with such design?
> You might tomorrow.  So please don't create problems like this when you
> do not have to.

We still didn't arrive on a culminating note. :)
What do you suggest I could do for now? This would be a useful debug tool
for us since we deal with it quite often.

If we don't have anything constraining this for now, can we keep it like
this? Let's ameliorate it once such systems actually arrive.
Suggestions?

Thanks
Rajat

>
> greg k-h
