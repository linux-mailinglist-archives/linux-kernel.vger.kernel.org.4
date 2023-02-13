Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705D4693D15
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 04:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjBMDlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 22:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBMDlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 22:41:45 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C300CDFE;
        Sun, 12 Feb 2023 19:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676259690; x=1707795690;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kOm/lqLnIhrBfbKI2sllGDgMmet2FVVHyUaQ+tQOp88=;
  b=OGEbqrYUQ8KgNYvMiF7o80mHSCnLVT0kwt/n3++43ACI3IgSWovpGXju
   2m2UbLPF42bX75kTGoEFjQRdKRPvq7s2mwSZNeVRTApCbGU4MyV8jInxb
   JRwuHVi1YZ/3ed5LeeS2fDDBkBcGr/cppf0Qwd9fbqbPYu0ItZq4ryz2s
   NNmkNabmAoaC4/ss20TOxBDbp1JtZ995pi4cAwV7P8LgY6xFGun2tX4EQ
   igZCm4tXOyIa8rjSGHtxsKMO4S6uXgpv5pSeu0ZrXhyyRyYBPCrk7ux2P
   W84wO/pc5kVuh7K2SJQampI5Mwy4C6XhkfCwq92+BqpwFYYs/i61NU3iV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="332937980"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="332937980"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 19:41:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="668669864"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="668669864"
Received: from rajatkha-mobl.gar.corp.intel.com (HELO [10.213.70.43]) ([10.213.70.43])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 19:41:17 -0800
Message-ID: <15eda586-b094-8d42-a6cb-deb8fd5eaca8@linux.intel.com>
Date:   Mon, 13 Feb 2023 09:11:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v5] platform/x86/intel/pmc: core: Add support to show
 LTR-ignored components
To:     "Box, David E" <david.e.box@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "irenic.rajneesh@gmail.com" <irenic.rajneesh@gmail.com>
Cc:     "Khandelwal, Rajat" <rajat.khandelwal@intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230210181614.192578-1-rajat.khandelwal@linux.intel.com>
 <7853400f2472fe799540de86bebddfe4b3d76c6c.camel@intel.com>
Content-Language: en-US
From:   Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
In-Reply-To: <7853400f2472fe799540de86bebddfe4b3d76c6c.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,
I didn't know such restriction exists in the upstream community. :)

How about?
"Currently, 'ltr_ignore' sysfs attribute, when read, returns nothing, even
if there are components whose LTR values have been ignored.

Make the sysfs attribute print out such components, if they exist, and return
EEXIST, if tried to set an already ignored component."

Thanks
Rajat

On 2/13/2023 12:58 AM, Box, David E wrote:
> On Fri, 2023-02-10 at 23:46 +0530, Rajat Khandelwal wrote:
>> Currently, 'ltr_ignore' sysfs attribute, when read, returns nothing, even
>> if there are components whose LTR values have been ignored.
>>
>> This patch adds the feature to print out such components, if they exist.
>> Further, if user tries to set an already ignored component, he will
>> encounter the error code of EEXIST.
> Sorry to nit, but should describe the changes in "imperative mood" per the
> guidelines in submitting-patches.rst.
>
> David
>
>> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
>> ---
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
