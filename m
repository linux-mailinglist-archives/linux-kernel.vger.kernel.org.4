Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4637690A40
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjBINcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjBINbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:31:47 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BA35FE47;
        Thu,  9 Feb 2023 05:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675949467; x=1707485467;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/t8Y9QaXdzABbElXcD4B00e+zQHiJl38CC6YeB+Ptco=;
  b=lcVuPk30qekKGkyRJMWbbJVpE1k9ThYQeJVejwMcsFS9Ya/gUpG59P3b
   g6SZbdDeX3Gqd28o3SEAaTRRxAAm3dZPEWnyPWG++q1oEEC6wb4ThZ3y9
   HrrRVciB47HyAuqtJcWAaW2NQ8fcrakoxUb2VDECHVH1AMzVpKeuazOfz
   MdlcoLW4G28iNxNepS6YFuDWYsAR8rqP6NfzGjW50uC22ktj7OVVCL00A
   lgrm8KjHi/Z/qjIcYGlvlnR5HpHfwl/Tgm1Mt48TEMbNMSjwgGkNspJ0l
   bRXpelPWv/dpWK448BTjWPfquT+ruXfsnnqNZjxvRHYJM+OyI3nXWEyRx
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="310460234"
X-IronPort-AV: E=Sophos;i="5.97,283,1669104000"; 
   d="scan'208";a="310460234"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 05:31:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="698020174"
X-IronPort-AV: E=Sophos;i="5.97,283,1669104000"; 
   d="scan'208";a="698020174"
Received: from rajatkha-mobl.gar.corp.intel.com (HELO [10.67.145.167]) ([10.67.145.167])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 05:31:04 -0800
Message-ID: <8afe0502-2e2a-a89b-dbe0-bf74aef98290@linux.intel.com>
Date:   Thu, 9 Feb 2023 19:00:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v4] platform/x86/intel/pmc: core: Add support to show
 LTR-ignored components
To:     "Box, David E" <david.e.box@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "irenic.rajneesh@gmail.com" <irenic.rajneesh@gmail.com>
Cc:     "Khandelwal, Rajat" <rajat.khandelwal@intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230205174418.1927876-1-rajat.khandelwal@linux.intel.com>
 <75308e1b2e0406118b1012e271c622b2f02c119e.camel@intel.com>
Content-Language: en-US
From:   Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
In-Reply-To: <75308e1b2e0406118b1012e271c622b2f02c119e.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,
Please find the comments inline.

On 2/5/2023 12:49 AM, Box, David E wrote:
> Hi Rajat,
>
> On Sun, 2023-02-05 at 23:14 +0530, Rajat Khandelwal wrote:
>> Currently, 'ltr_ignore' sysfs attribute, when read, returns nothing, even
>> if there are components whose LTR values have been ignored.
>>
>> This patch adds the feature to print out such components, if they exist.
>>
>> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
>> ---
>>
>> v4: Mutex unlock during error conditions
>>
>> v3: Incorporated a mutex lock for accessing 'ltr_ignore_list'
>>
>> v2: kmalloc -> devm_kmalloc
>>
>>   drivers/platform/x86/intel/pmc/core.c | 59 ++++++++++++++++++++++-----
>>   drivers/platform/x86/intel/pmc/core.h |  2 +-
>>   2 files changed, 49 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/platform/x86/intel/pmc/core.c
>> b/drivers/platform/x86/intel/pmc/core.c
>> index 3a15d32d7644..f9d4b2865b03 100644
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
>> @@ -473,13 +477,46 @@ static ssize_t pmc_core_ltr_ignore_write(struct file
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
> Do we need to return an error here? We don't offer a way to undo the ignore and
> rewriting it doesn't hurt anything. I'm okay with ignoring this.

Surely, it won't hurt to just write the value again. It does provide a sense of notion
to the user that "this component was already set" (something like that).
Not that big a deal, but I would like to keep it that way, if that's okay? :)

>
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
>> +       pmc_core_send_ltr_ignore(pmcdev, value);
>> +
>> +out_unlock:
>> +       mutex_unlock(&ltr_entry_mutex);
> You can allocate your entry and do the assignment before you take the list lock.
> If the allocation fails, return immediately without a goto.
>
> You can also move pmc_core_send_ltr_ignore() after the unlock.

Ok, so I allocate it only after I see that the list doesn't already has the value.
That is why I take the lock and proceed.
pmc_core_send_ltr_ignore() can be moved after the unlock.

Please let me know your comments for v5.

Thanks
Rajat

>
> David
>
>>   
>>          return err == 0 ? count : err;
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
>> -- 
>> 2.34.1
>>
