Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A976AE093
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjCGNbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjCGNbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:31:00 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26344C6C4;
        Tue,  7 Mar 2023 05:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678195817; x=1709731817;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OWnTmtqx2njcHCDeyfR3K5k7oQYJj5/5PcpZS3r/WhQ=;
  b=HUXn9WufBXXE6tK/enGSvjHDKpuHWP/ElwTa1mf8VKYpHaJK6J0CITpt
   pgf11lT06GxkinJEhAtWy7wAuEQhk2MXz9OAXUU9CRHgvwOwFEF1KPio8
   g9QCbFw7Ai1ChoB4g4tJHHRTdeeltJIQ4lXaa87oCzxuwYlkzNQwMydwf
   BVI057hleMuF9pdS9g/kI79MNUP70e8+1WZnvyGpyy7sU/OUYG5H+dLux
   1w6oS27k4hQSbwV98FF8fibzt7GwHlhMu4NiuBmfRqa0sg0tQFdYkB+Ao
   nve5EO3WebACYesIGWZ89lr4+1gWaxP5wWaZQlRcoIgx4qlxi1GRP3V+C
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="319678695"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="319678695"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 05:28:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="709057183"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="709057183"
Received: from rajatkha-mobl.gar.corp.intel.com (HELO [10.215.203.161]) ([10.215.203.161])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 05:28:13 -0800
Message-ID: <b51504d4-8e7c-0dac-3684-c9b4dc2f1943@linux.intel.com>
Date:   Tue, 7 Mar 2023 18:58:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v6] platform/x86/intel/pmc: core: Add support to show
 LTR-ignored components
To:     "Box, David E" <david.e.box@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "irenic.rajneesh@gmail.com" <irenic.rajneesh@gmail.com>
Cc:     "Khandelwal, Rajat" <rajat.khandelwal@intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230301155757.1293131-1-rajat.khandelwal@linux.intel.com>
 <4c01c9e7ef9455c791fdad9de13ce706b4c3e3e2.camel@intel.com>
Content-Language: en-US
From:   Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
In-Reply-To: <4c01c9e7ef9455c791fdad9de13ce706b4c3e3e2.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 3/6/2023 11:29 PM, Box, David E wrote:
> Hi Rajat,
>
> We have some changes coming for this driver in order to support multiple PMC
> devices on the same SoC. As part of this we are modifying the output of ltr_show
> to prefix the IP with number of the managing PMC. For example:
>
> PMC[0]:SOUTHPORT_A	LTR: RAW: 0x0	Non-Snoop(ns): 0	Snoop(ns): 0
> PMC[0]:SOUTHPORT_B	LTR: RAW: 0x0	Non-Snoop(ns): 0	Snoop(ns): 0
> ...
> PMC[1]:SOUTHPORT_A	LTR: RAW: 0x0	Non-Snoop(ns): 0	Snoop(ns): 0
> PMC[1]:SOUTHPORT_B	LTR: RAW: 0x0	Non-Snoop(ns): 0	Snoop(ns): 0
>
> We're thinking that it would be better to have a column in ltr_show for the
> ignore status. This would make everything viewable in one display. A list would
> not be needed. The status can be read back from the ltr_ignore register. Would
> that work for you? Thanks.

Aah, ok. That is doable.
Is the plan to incorporate the ignore column certain? Further, is there an ETA for the
said changes in the upstream?

Thanks
Rajat

>
> David
>
> On Wed, 2023-03-01 at 21:27 +0530, Rajat Khandelwal wrote:
>> Currently, 'ltr_ignore' sysfs attribute, when read, returns nothing, even
>> if there are components whose LTR values have been ignored.
>>
>> Make the sysfs attribute print out such components, if they exist, and
>> return EEXIST, if tried to set an already ignored component.
>>
>> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
>> ---
>>
>> v6: Description written in imperative sense
>>
>> v5:
>> 1. Ignore the LTR of the respective component after unlocking the mutex lock
>> 2. Adding error code details to the commit message
>>
>> v4: Mutex unlock during error conditions
>>
>> v3: Incorporated a mutex lock for accessing 'ltr_ignore_list'
>>
>> v2: kmalloc -> devm_kmalloc
>>
>>   drivers/platform/x86/intel/pmc/core.c | 64 ++++++++++++++++++++++-----
>>   drivers/platform/x86/intel/pmc/core.h |  2 +-
>>   2 files changed, 53 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/platform/x86/intel/pmc/core.c
>> b/drivers/platform/x86/intel/pmc/core.c
>> index 3a15d32d7644..16cf6c634db8 100644
>> --- a/drivers/platform/x86/intel/pmc/core.c
>> +++ b/drivers/platform/x86/intel/pmc/core.c
>> @@ -53,6 +53,17 @@ const struct pmc_bit_map msr_map[] = {
>>          {}
>>   };
>>   
>> +/* Mutual exclusion to access the list of LTR-ignored components */
>> +static DEFINE_MUTEX(ltr_entry_mutex);
>> +
>> +struct ltr_entry {
>> +       u32 comp_index;
>> +       const char *comp_name;
>> +       struct list_head node;
>> +};
>> +
>> +static LIST_HEAD(ltr_ignore_list);
>> +
>>   static inline u32 pmc_core_reg_read(struct pmc_dev *pmcdev, int reg_offset)
>>   {
>>          return readl(pmcdev->regbase + reg_offset);
>> @@ -435,27 +446,18 @@ static int pmc_core_pll_show(struct seq_file *s, void
>> *unused)
>>   }
>>   DEFINE_SHOW_ATTRIBUTE(pmc_core_pll);
>>   
>> -int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value)
>> +void pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value)
>>   {
>>          const struct pmc_reg_map *map = pmcdev->map;
>>          u32 reg;
>> -       int err = 0;
>>   
>>          mutex_lock(&pmcdev->lock);
>>   
>> -       if (value > map->ltr_ignore_max) {
>> -               err = -EINVAL;
>> -               goto out_unlock;
>> -       }
>> -
>>          reg = pmc_core_reg_read(pmcdev, map->ltr_ignore_offset);
>>          reg |= BIT(value);
>>          pmc_core_reg_write(pmcdev, map->ltr_ignore_offset, reg);
>>   
>> -out_unlock:
>>          mutex_unlock(&pmcdev->lock);
>> -
>> -       return err;
>>   }
>>   
>>   static ssize_t pmc_core_ltr_ignore_write(struct file *file,
>> @@ -464,6 +466,8 @@ static ssize_t pmc_core_ltr_ignore_write(struct file
>> *file,
>>   {
>>          struct seq_file *s = file->private_data;
>>          struct pmc_dev *pmcdev = s->private;
>> +       const struct pmc_reg_map *map = pmcdev->map;
>> +       struct ltr_entry *entry;
>>          u32 buf_size, value;
>>          int err;
>>   
>> @@ -473,13 +477,49 @@ static ssize_t pmc_core_ltr_ignore_write(struct file
>> *file,
>>          if (err)
>>                  return err;
>>   
>> -       err = pmc_core_send_ltr_ignore(pmcdev, value);
>> +       if (value > map->ltr_ignore_max)
>> +               return -EINVAL;
>> +
>> +       mutex_lock(&ltr_entry_mutex);
>> +
>> +       list_for_each_entry(entry, &ltr_ignore_list, node) {
>> +               if (entry->comp_index == value) {
>> +                       err = -EEXIST;
>> +                       goto out_unlock;
>> +               }
>> +       }
>> +
>> +       entry = devm_kmalloc(&pmcdev->pdev->dev, sizeof(*entry), GFP_KERNEL);
>> +       if (!entry) {
>> +               err = -ENOMEM;
>> +               goto out_unlock;
>> +       }
>> +
>> +       entry->comp_name = map->ltr_show_sts[value].name;
>> +       entry->comp_index = value;
>> +       list_add_tail(&entry->node, &ltr_ignore_list);
>> +
>> +out_unlock:
>> +       mutex_unlock(&ltr_entry_mutex);
>> +
>> +       if (err)
>> +               return err;
>> +
>> +       pmc_core_send_ltr_ignore(pmcdev, value);
>>   
>> -       return err == 0 ? count : err;
>> +       return count;
>>   }
>>   
>>   static int pmc_core_ltr_ignore_show(struct seq_file *s, void *unused)
>>   {
>> +       struct ltr_entry *entry;
>> +
>> +       mutex_lock(&ltr_entry_mutex);
>> +       list_for_each_entry(entry, &ltr_ignore_list, node) {
>> +               seq_printf(s, "%s\n", entry->comp_name);
>> +       }
>> +       mutex_unlock(&ltr_entry_mutex);
>> +
>>          return 0;
>>   }
>>   
>> diff --git a/drivers/platform/x86/intel/pmc/core.h
>> b/drivers/platform/x86/intel/pmc/core.h
>> index 810204d758ab..da35b0fcbe6e 100644
>> --- a/drivers/platform/x86/intel/pmc/core.h
>> +++ b/drivers/platform/x86/intel/pmc/core.h
>> @@ -396,7 +396,7 @@ extern const struct pmc_reg_map adl_reg_map;
>>   extern const struct pmc_reg_map mtl_reg_map;
>>   
>>   extern void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev);
>> -extern int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value);
>> +extern void pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value);
>>   
>>   void spt_core_init(struct pmc_dev *pmcdev);
>>   void cnp_core_init(struct pmc_dev *pmcdev);
