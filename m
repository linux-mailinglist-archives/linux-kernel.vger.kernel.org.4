Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83D26BBE22
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 21:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjCOUtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 16:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjCOUtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 16:49:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3B01727;
        Wed, 15 Mar 2023 13:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678913337; x=1710449337;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=E4QvHz5/lztNPge03YUIVMejLGXxxoCdgoGd9i4c/Ao=;
  b=jjvuLMoYbtOOeqSkAPp0oLQ33Jmy1HCt2xXIn1/mDu13RZz7bBcfCQH/
   EoIRZi+YaJZd7o7gUG6LJaj5f6c9Vux8paRtUfzF3BFDHkWv9GsOMS1m5
   emRzL+4EGmLNV6Wqdl7nLYFrrQ4koJ1icJ7fVaHvtXt7ZpC3uMWoMUWwV
   TeM8fVZcPKDzGHureg35Z+dlS431OBCVNeVoaWGx5zPAc3d+4gm1HwTCJ
   7Y5MagU8XFvAIhN9tuCuRCJi2a6bKFR+s5TuOyr3LjreGs8+jQrAVAu4i
   MiMBjPV6Lfvl2ZWxyuwyD0DUdrCMsRYikfGOUUjmDTxkDqkeCYW4g9Cor
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="339354902"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="339354902"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 13:48:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="748593596"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="748593596"
Received: from kaliving-mobl.amr.corp.intel.com (HELO [10.212.158.22]) ([10.212.158.22])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 13:48:56 -0700
Message-ID: <b051ecb7-54d7-9616-5f87-7d6cca1eba6e@linux.intel.com>
Date:   Wed, 15 Mar 2023 13:48:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v1] ACPI: sysfs: Enable ACPI sysfs support for CCEL
 records
Content-Language: en-US
To:     Rafael J Wysocki <rjw@rjwysocki.net>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230302071327.557734-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230302071327.557734-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

Gentle ping! Any comments on this patch?

On 3/1/23 11:13 PM, Kuppuswamy Sathyanarayanan wrote:
> The Confidential Computing Event Log (CCEL) table provides the address
> and length of the CCEL records area in UEFI reserved memory. To access
> these records, userspace can use /dev/mem to retrieve them. But
> '/dev/mem' is not enabled on many systems for security reasons.
> 
> So to allow user space access these event log records without the
> /dev/mem interface, add support to access it via sysfs interface. The
> ACPI driver has provided read only access to BERT records area via
> '/sys/firmware/acpi/tables/data/BERT' in sysfs. So follow the same way,
> and add support for /sys/firmware/acpi/tables/data/CCEL to enable
> read-only access to the CCEL recorids area.
> 
> More details about the CCEL table can be found in ACPI specification
> r6.5, sec titled "CC Event Log ACPI Table".
> 
> Original-patch-by: Haibo Xu <haibo1.xu@intel.com>
> [Original patch is for TDEL table, modified it for CCEL support]
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/acpi/sysfs.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index 7db3b530279b..afeac925b31b 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -458,11 +458,28 @@ static int acpi_bert_data_init(void *th, struct acpi_data_attr *data_attr)
>  	return sysfs_create_bin_file(tables_data_kobj, &data_attr->attr);
>  }
>  
> +static int acpi_ccel_data_init(void *th, struct acpi_data_attr *data_attr)
> +{
> +	struct acpi_table_ccel *ccel = th;
> +
> +	if (ccel->header.length < sizeof(struct acpi_table_ccel) ||
> +	    !(ccel->log_area_start_address) || !(ccel->log_area_minimum_length)) {
> +		kfree(data_attr);
> +		return -EINVAL;
> +	}
> +	data_attr->addr = ccel->log_area_start_address;
> +	data_attr->attr.size = ccel->log_area_minimum_length;
> +	data_attr->attr.attr.name = "CCEL";
> +
> +	return sysfs_create_bin_file(tables_data_kobj, &data_attr->attr);
> +}
> +
>  static struct acpi_data_obj {
>  	char *name;
>  	int (*fn)(void *, struct acpi_data_attr *);
>  } acpi_data_objs[] = {
>  	{ ACPI_SIG_BERT, acpi_bert_data_init },
> +	{ ACPI_SIG_CCEL, acpi_ccel_data_init },
>  };
>  
>  #define NUM_ACPI_DATA_OBJS ARRAY_SIZE(acpi_data_objs)

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
