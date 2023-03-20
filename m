Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58E06C1E4C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjCTRko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbjCTRj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:39:26 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F70303D4;
        Mon, 20 Mar 2023 10:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679333731; x=1710869731;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Am5yY3ShWICJ/fgRdT7iPO2VI2QhvJ0sRM5ORvuu0xI=;
  b=fFNdPmpE3hG7Pdz7EPxCbpPWWwS++4SjSi85SyCG87wbDjyUPNlH4HoU
   tK0eulVGEsac4zQLDzSn74RvDejWFCjYNAtetCP2JAWWc31SpJEcSZwLd
   gatG2yznDzdqGJKGx9sRMcnxr6/NLh8BNsa/qmk06Hex+UmSJ/S8EuCqs
   Rrw80OoWesC0zVqh3tKHi5Ee8fodjwmwbTY03tVUs7ZVtd2GTALq1XLF/
   hovhUPgjFVf/7vWcbIiLYH1MFo8YZvMiUxySOup/GnDwEOpxK4loE/IGb
   KfQ3NeRoLE70EiI7rUtuot/6rehVjncGWcp1OMXj5+sZ1SBQthBC5FDpL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="425003663"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="425003663"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 10:34:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="713650247"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="713650247"
Received: from jcardiel-mobl.amr.corp.intel.com (HELO [10.212.226.30]) ([10.212.226.30])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 10:34:03 -0700
Message-ID: <39d7b92a-8f30-8302-049b-d2ee9e6c1a78@linux.intel.com>
Date:   Mon, 20 Mar 2023 10:34:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v1] ACPI: sysfs: Enable ACPI sysfs support for CCEL
 records
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael J Wysocki <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230302071327.557734-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAJZ5v0gB7WSB3F3+kTnB-r83xO9G7Sk1Vyh2os0=AeYNvHK_Mw@mail.gmail.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <CAJZ5v0gB7WSB3F3+kTnB-r83xO9G7Sk1Vyh2os0=AeYNvHK_Mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 3/20/23 10:15 AM, Rafael J. Wysocki wrote:
> On Thu, Mar 2, 2023 at 8:13 AM Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>
>> The Confidential Computing Event Log (CCEL) table provides the address
>> and length of the CCEL records area in UEFI reserved memory. To access
>> these records, userspace can use /dev/mem to retrieve them. But
>> '/dev/mem' is not enabled on many systems for security reasons.
>>
>> So to allow user space access these event log records without the
>> /dev/mem interface, add support to access it via sysfs interface. The
>> ACPI driver has provided read only access to BERT records area via
>> '/sys/firmware/acpi/tables/data/BERT' in sysfs. So follow the same way,
>> and add support for /sys/firmware/acpi/tables/data/CCEL to enable
>> read-only access to the CCEL recorids area.
>>
>> More details about the CCEL table can be found in ACPI specification
>> r6.5, sec titled "CC Event Log ACPI Table".
>>
>> Original-patch-by: Haibo Xu <haibo1.xu@intel.com>
>> [Original patch is for TDEL table, modified it for CCEL support]
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>  drivers/acpi/sysfs.c | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
>> index 7db3b530279b..afeac925b31b 100644
>> --- a/drivers/acpi/sysfs.c
>> +++ b/drivers/acpi/sysfs.c
>> @@ -458,11 +458,28 @@ static int acpi_bert_data_init(void *th, struct acpi_data_attr *data_attr)
>>         return sysfs_create_bin_file(tables_data_kobj, &data_attr->attr);
>>  }
>>
>> +static int acpi_ccel_data_init(void *th, struct acpi_data_attr *data_attr)
>> +{
>> +       struct acpi_table_ccel *ccel = th;
>> +
>> +       if (ccel->header.length < sizeof(struct acpi_table_ccel) ||
>> +           !(ccel->log_area_start_address) || !(ccel->log_area_minimum_length)) {
> 
> The inner parens in this line are not necessary AFAICS.
> 
> Otherwise I have no objections.

Yes. We can do without it. Shall I submit v2 with this change, or you want to
fix it when applying?

> 
>> +               kfree(data_attr);
>> +               return -EINVAL;
>> +       }
>> +       data_attr->addr = ccel->log_area_start_address;
>> +       data_attr->attr.size = ccel->log_area_minimum_length;
>> +       data_attr->attr.attr.name = "CCEL";
>> +
>> +       return sysfs_create_bin_file(tables_data_kobj, &data_attr->attr);
>> +}
>> +
>>  static struct acpi_data_obj {
>>         char *name;
>>         int (*fn)(void *, struct acpi_data_attr *);
>>  } acpi_data_objs[] = {
>>         { ACPI_SIG_BERT, acpi_bert_data_init },
>> +       { ACPI_SIG_CCEL, acpi_ccel_data_init },
>>  };
>>
>>  #define NUM_ACPI_DATA_OBJS ARRAY_SIZE(acpi_data_objs)
>> --

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
