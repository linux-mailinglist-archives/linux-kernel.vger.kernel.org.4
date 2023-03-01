Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9DC6A6C15
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 13:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjCAMGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 07:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjCAMGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 07:06:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D04832522
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 04:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677672337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V7efi1NWkDqiCLl8UPO0ZCtqDqsA0oCqrdw66aTRdaA=;
        b=TsWcS9xwkYY9XoxYP55C0Ptu7G+0X98ZFU55ZhAD5o4bRnwQn9IZTH79CGRoMfA2YxQFUA
        yNhdPffTAuItPxooUMDY2gSnSQXlqG5EZgA5la4Q9iNOJw/PbFMuJ0Wz2mod2FbaS1mGpg
        x1Nji/aXlkAwXtrHRmNidtonrnmdq44=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-298-dXIJxVOAP529g2yKoMHoVA-1; Wed, 01 Mar 2023 07:05:36 -0500
X-MC-Unique: dXIJxVOAP529g2yKoMHoVA-1
Received: by mail-ed1-f71.google.com with SMTP id ev6-20020a056402540600b004bc2358ac04so2877580edb.21
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 04:05:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7efi1NWkDqiCLl8UPO0ZCtqDqsA0oCqrdw66aTRdaA=;
        b=KbUhjs4BRLv4KQHZrydh6mI9PudzjYbShoiEx4BiT9+wNDvl66T5nPOGGMh1jcZpbr
         39YuN5rHJqNZcc1hAslqBsU1ef9cUJh6oHRgaVjwFOpBWX+xbwncdsoJm0lhJFobwO0z
         OUJFhQ3gKoUpcVtiPB08HyQcMYfv8R4cxujneltHYRXMxKKulDR4jp/sFK86tGzxGaYg
         sJjfeXeDh1pDKeuGUVW4ThuR87FqxdPM9MG1NCMtF+6iczwJMvCbm9sLeNWzmLmyoZ4u
         p/9yIGrloxM1DQRVmh5GooUNs+UDOkNkB5PdOjY9MSU3/wHLlJp5GwC5CQAitk6E9Caj
         PQbQ==
X-Gm-Message-State: AO0yUKX6ONhDJS+bdu9LpWN7ySka05LyhlAvS43Q6HJVOyTrEMOso322
        INMXlyeefaJWhkIfCNg6mHjqN4mWrYlxMCzMol+vjz6plJgPdI8fb7SvB4yPo+Kr011SV2hgqUQ
        I/X1snI1yRHeBQ/jaGC/7d8rs
X-Received: by 2002:a17:906:36c6:b0:895:ef96:9d9b with SMTP id b6-20020a17090636c600b00895ef969d9bmr6339761ejc.30.1677672335068;
        Wed, 01 Mar 2023 04:05:35 -0800 (PST)
X-Google-Smtp-Source: AK7set+DSZ9RolQqYAU7tw+ZULYaOzAaBrFYnJSgVm5XkEj81s5Z6bHNpTsDtwh9Rjp8MgcSkQyn/w==
X-Received: by 2002:a17:906:36c6:b0:895:ef96:9d9b with SMTP id b6-20020a17090636c600b00895ef969d9bmr6339742ejc.30.1677672334799;
        Wed, 01 Mar 2023 04:05:34 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id h11-20020a1709063c0b00b008e82cb55195sm5666324ejg.203.2023.03.01.04.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 04:05:34 -0800 (PST)
Message-ID: <a2b6ac03-929e-3608-635b-4fbc696ab7c5@redhat.com>
Date:   Wed, 1 Mar 2023 13:05:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] platform/x86/amd: pmc: remove CONFIG_SUSPEND checks
Content-Language: en-US, nl
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Arnd Bergmann <arnd@kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230214152512.806188-1-arnd@kernel.org>
 <MN0PR12MB610112C0A677F1526AB14F2DE2A29@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <MN0PR12MB610112C0A677F1526AB14F2DE2A29@MN0PR12MB6101.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario, Arnd,

On 2/14/23 17:36, Limonciello, Mario wrote:
> [Public]
> 
> 
> 
>> -----Original Message-----
>> From: Arnd Bergmann <arnd@kernel.org>
>> Sent: Tuesday, February 14, 2023 09:25
>> To: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>; Hans de Goede
>> <hdegoede@redhat.com>; Mark Gross <markgross@kernel.org>
>> Cc: Arnd Bergmann <arnd@arndb.de>; Limonciello, Mario
>> <Mario.Limonciello@amd.com>; Nathan Chancellor <nathan@kernel.org>;
>> Rafael J. Wysocki <rafael.j.wysocki@intel.com>; platform-driver-
>> x86@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: [PATCH] platform/x86/amd: pmc: remove CONFIG_SUSPEND checks
>>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The amd_pmc_write_stb() function was previously hidden in an
>> ifdef to avoid a warning when CONFIG_SUSPEND is disabled, but
>> now there is an additional caller:
>>
>> drivers/platform/x86/amd/pmc.c: In function
>> 'amd_pmc_stb_debugfs_open_v2':
>> drivers/platform/x86/amd/pmc.c:256:8: error: implicit declaration of function
>> 'amd_pmc_write_stb'; did you mean 'amd_pmc_read_stb'? [-
>> Werror=implicit-function-declaration]
>>   256 |  ret = amd_pmc_write_stb(dev, AMD_PMC_STB_DUMMY_PC);
>>       |        ^~~~~~~~~~~~~~~~~
>>       |        amd_pmc_read_stb
>>
>> There is now an easier way to handle this by using
>> DEFINE_SIMPLE_DEV_PM_OPS()
>> to replace all the #ifdefs, letting gcc drop any of the unused functions
>> silently.
>>
>> Fixes: b0d4bb973539 ("platform/x86/amd: pmc: Write dummy postcode into
>> the STB DRAM")
> 
> I suspect this is not an appropriate fixes tag.  SIMPLE_DEV_PM_OPS only came in
> 8e60615e89321 ("platform/x86/amd: pmc: Disable IRQ1 wakeup for RN/CZN")

That commit is older then the fixes commit Arnd points to,
Arnd's Fixes tag points to the commit causing the compile error
Arnd hit, which is one of the last commits to drivers/platform/x86/amd/pmc.c .

So the Fixes tag seems fine to me.

I've applied this patch to my review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note I've squashed in one small fixup, see my inline comment below.

I'll rebase that branch once 6.3-rc1 is out and then push the rebased
patch to the fixes branch and include it in my next 6.3 fixes pull-req
to Linus.

>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/platform/x86/amd/pmc.c | 25 ++++++-------------------
>>  1 file changed, 6 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/platform/x86/amd/pmc.c
>> b/drivers/platform/x86/amd/pmc.c
>> index ab05b9ee6655..641085906baf 100644
>> --- a/drivers/platform/x86/amd/pmc.c
>> +++ b/drivers/platform/x86/amd/pmc.c
>> @@ -171,9 +171,7 @@ MODULE_PARM_DESC(disable_workarounds,
>> "Disable workarounds for platform bugs");
>>  static struct amd_pmc_dev pmc;
>>  static int amd_pmc_send_cmd(struct amd_pmc_dev *dev, u32 arg, u32
>> *data, u8 msg, bool ret);
>>  static int amd_pmc_read_stb(struct amd_pmc_dev *dev, u32 *buf);
>> -#ifdef CONFIG_SUSPEND
>>  static int amd_pmc_write_stb(struct amd_pmc_dev *dev, u32 data);
>> -#endif
>>
>>  static inline u32 amd_pmc_reg_read(struct amd_pmc_dev *dev, int
>> reg_offset)
>>  {
>> @@ -386,7 +384,6 @@ static int get_metrics_table(struct amd_pmc_dev
>> *pdev, struct smu_metrics *table
>>  	return 0;
>>  }
>>
>> -#ifdef CONFIG_SUSPEND
>>  static void amd_pmc_validate_deepest(struct amd_pmc_dev *pdev)
>>  {
>>  	struct smu_metrics table;
>> @@ -400,7 +397,6 @@ static void amd_pmc_validate_deepest(struct
>> amd_pmc_dev *pdev)
>>  		dev_dbg(pdev->dev, "Last suspend in deepest state for
>> %lluus\n",
>>  			 table.timein_s0i3_lastcapture);
>>  }
>> -#endif
>>
>>  static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
>>  {
>> @@ -673,7 +669,6 @@ static int amd_pmc_send_cmd(struct amd_pmc_dev
>> *dev, u32 arg, u32 *data, u8 msg,
>>  	return rc;
>>  }
>>
>> -#ifdef CONFIG_SUSPEND
>>  static int amd_pmc_get_os_hint(struct amd_pmc_dev *dev)
>>  {
>>  	switch (dev->cpu_id) {
>> @@ -861,9 +856,7 @@ static int __maybe_unused
>> amd_pmc_suspend_handler(struct device *dev)
>>  	return 0;
>>  }
>>
>> -static SIMPLE_DEV_PM_OPS(amd_pmc_pm, amd_pmc_suspend_handler,
>> NULL);
>> -
>> -#endif
>> +static DEFINE_SIMPLE_DEV_PM_OPS(amd_pmc_pm,
>> amd_pmc_suspend_handler, NULL);
>>
>>  static const struct pci_device_id pmc_pci_ids[] = {
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_PS) },
>> @@ -905,7 +898,6 @@ static int amd_pmc_s2d_init(struct amd_pmc_dev
>> *dev)
>>  	return 0;
>>  }
>>
>> -#ifdef CONFIG_SUSPEND
>>  static int amd_pmc_write_stb(struct amd_pmc_dev *dev, u32 data)
>>  {
>>  	int err;
>> @@ -926,7 +918,6 @@ static int amd_pmc_write_stb(struct amd_pmc_dev
>> *dev, u32 data)
>>
>>  	return 0;
>>  }
>> -#endif
>>
>>  static int amd_pmc_read_stb(struct amd_pmc_dev *dev, u32 *buf)
>>  {
>> @@ -1017,11 +1008,10 @@ static int amd_pmc_probe(struct
>> platform_device *pdev)
>>  	}
>>
>>  	platform_set_drvdata(pdev, dev);
>> -#ifdef CONFIG_SUSPEND
>> -	err = acpi_register_lps0_dev(&amd_pmc_s2idle_dev_ops);
>> +	if (IS_ENABLED(CONFIG_SUSPEND))
>> +		err = acpi_register_lps0_dev(&amd_pmc_s2idle_dev_ops);
>>  	if (err)
>>  		dev_warn(dev->dev, "failed to register LPS0 sleep handler,

This will work since err is guaranteed to be 0 here, but IMHO it is
cleaner to put the err check for the acpi_register_lps0_dev() check
inside the if block.

I have fixed this up while applying the patch.

Regards,

Hans



>> expect increased power consumption\n");
>> -#endif
>>
>>  	amd_pmc_dbgfs_register(dev);
>>  	return 0;
>> @@ -1035,9 +1025,8 @@ static int amd_pmc_remove(struct platform_device
>> *pdev)
>>  {
>>  	struct amd_pmc_dev *dev = platform_get_drvdata(pdev);
>>
>> -#ifdef CONFIG_SUSPEND
>> -	acpi_unregister_lps0_dev(&amd_pmc_s2idle_dev_ops);
>> -#endif
>> +	if (IS_ENABLED(CONFIG_SUSPEND))
>> +		acpi_unregister_lps0_dev(&amd_pmc_s2idle_dev_ops);
>>  	amd_pmc_dbgfs_unregister(dev);
>>  	pci_dev_put(dev->rdev);
>>  	mutex_destroy(&dev->lock);
>> @@ -1061,9 +1050,7 @@ static struct platform_driver amd_pmc_driver = {
>>  		.name = "amd_pmc",
>>  		.acpi_match_table = amd_pmc_acpi_ids,
>>  		.dev_groups = pmc_groups,
>> -#ifdef CONFIG_SUSPEND
>> -		.pm = &amd_pmc_pm,
>> -#endif
>> +		.pm = pm_sleep_ptr(&amd_pmc_pm),
>>  	},
>>  	.probe = amd_pmc_probe,
>>  	.remove = amd_pmc_remove,
>> --
>> 2.39.1
> 

