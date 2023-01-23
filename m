Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDA1677D25
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 14:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjAWN4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 08:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjAWN4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:56:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54FC974C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 05:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674482140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b5Oi99eeKZiuzk7Lt402pXDhGidunVt9wodCPyNuBp4=;
        b=XHvkGdTz3P6qS+FDl5DtuN8NWHnBZix2PzLDzh0bsoO/VdQnQPK4UrN+e+KqtMBb1yv+Ip
        3j62HD0+gvV9IEJfvSSmx5CxYJBJ91slIwJ32zeJVuhoZXqrcAy6XU2PPwxVn2DDVsGMY1
        Rmna8h4yAoEtq9Ak9Tme+DGIgpFZb78=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-199-D2RKePYnPhCwekxMJIquPg-1; Mon, 23 Jan 2023 08:55:38 -0500
X-MC-Unique: D2RKePYnPhCwekxMJIquPg-1
Received: by mail-ed1-f71.google.com with SMTP id l17-20020a056402255100b00472d2ff0e59so8493843edb.19
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 05:55:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b5Oi99eeKZiuzk7Lt402pXDhGidunVt9wodCPyNuBp4=;
        b=05nI2tBDJY05GOW6fLQJYi3U/6cDE3q8tmtf/5bloN0c0fnKiY81oTindj11mNnbkR
         TBxKxJpqnFL+CNDGOjux+wECiIGnZ4LR66weU5YkPVMFHQflGu/WWdeTfHWm86cSDHb7
         xWP6G4tS5P0n2N5SBgVIaaZGwYyBoGbGU6BN4+lvjpG8h91jtVVcjHjXDV01wA2rXOlo
         kdIaAiGoJpCo/Ilw/Z7VTbA0QDGzLaN1wg4olZWbAitdgAVLn7RB/rQv6x2rzur/st2+
         7JNoWfq7i9iDdK1S3S6sRlIh7PH7EjP6mxN7M6VmZAe+LJSkSnAuVZgLYcXf9wr9YGdR
         lOZw==
X-Gm-Message-State: AFqh2kpuN2vHCPDmzAaySlhaqmTPVOsFBkfVD6NEuQzYIx+ol8tL9ITb
        BP/UFABrnOWLHpzakGEBBi8DiUAuCKJPF9dv4X+qEmArjDklSEb02icm5CEkcMGQYt+MeHMP5F0
        r/mGB00rywxkQN1/XafW1RCta
X-Received: by 2002:a17:907:8b87:b0:877:91b2:b11a with SMTP id tb7-20020a1709078b8700b0087791b2b11amr13705514ejc.76.1674482137566;
        Mon, 23 Jan 2023 05:55:37 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtGOy09GgPS3i8dzNkmyhPjZbGpXFQ/KruoeKvfMXEpZDppyPHGkjt0v0W6TKdhT5HfM3JtVw==
X-Received: by 2002:a17:907:8b87:b0:877:91b2:b11a with SMTP id tb7-20020a1709078b8700b0087791b2b11amr13705499ejc.76.1674482137347;
        Mon, 23 Jan 2023 05:55:37 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id lb19-20020a170907785300b0084d1efe9af6sm21972880ejc.58.2023.01.23.05.55.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 05:55:36 -0800 (PST)
Message-ID: <74a63457-52fd-2f16-1b76-d3b3497b5a5d@redhat.com>
Date:   Mon, 23 Jan 2023 14:55:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] platform/x86: amd: pmc: Disable IRQ1 wakeup for
 RN/CZN
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc:     kai.heng.feng@canonical.com, xaver.hugl@gmail.com,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230120191519.15926-1-mario.limonciello@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230120191519.15926-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/20/23 20:15, Mario Limonciello wrote:
> By default when the system is configured for low power idle in the FADT
> the keyboard is set up as a wake source.  This matches the behavior that
> Windows uses for Modern Standby as well.
> 
> It has been reported that a variety of AMD based designs there are
> spurious wakeups are happening where two IRQ sources are active.
> 
> For example:
> ```
> PM: Triggering wakeup from IRQ 9
> PM: Triggering wakeup from IRQ 1
> ```
> 
> In these designs IRQ 9 is the ACPI SCI and IRQ 1 is the keyboard.
> One way to trigger this problem is to suspend the laptop and then unplug
> the AC adapter.  The SOC will be in a hardware sleep state and plugging
> in the AC adapter returns control to the kernel's s2idle loop.
> 
> Normally if just IRQ 9 was active the s2idle loop would advance any EC
> transactions and no other IRQ being active would cause the s2idle loop
> to put the SOC back into hardware sleep state.
> 
> When this bug occurred IRQ 1 is also active even if no keyboard activity
> occurred. This causes the s2idle loop to break and the system to wake.
> 
> This is a platform firmware bug triggering IRQ1 without keyboard activity.
> This occurs in Windows as well, but Windows will enter "SW DRIPS" and
> then with no activity enters back into "HW DRIPS" (hardware sleep state).
> 
> This issue affects Renoir, Lucienne, Cezanne, and Barcelo platforms. It
> does not happen on newer systems such as Mendocino or Rembrandt.
> 
> It's been fixed in newer platform firmware.  To avoid triggering the bug
> on older systems check the SMU F/W version and adjust the policy at suspend
> time for s2idle wakeup from keyboard on these systems. A lot of thought
> and experimentation has been given around the timing of disabling IRQ1,
> and to make it work the "suspend" PM callback is restored.
> 
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Reported-by: Xaver Hugl <xaver.hugl@gmail.com>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2115
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1951
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
>  drivers/platform/x86/amd/pmc.c | 50 ++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
> index 8d924986381be..be1b49824edbd 100644
> --- a/drivers/platform/x86/amd/pmc.c
> +++ b/drivers/platform/x86/amd/pmc.c
> @@ -22,6 +22,7 @@
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
>  #include <linux/rtc.h>
> +#include <linux/serio.h>
>  #include <linux/suspend.h>
>  #include <linux/seq_file.h>
>  #include <linux/uaccess.h>
> @@ -653,6 +654,33 @@ static int amd_pmc_get_os_hint(struct amd_pmc_dev *dev)
>  	return -EINVAL;
>  }
>  
> +static int amd_pmc_czn_wa_irq1(struct amd_pmc_dev *pdev)
> +{
> +	struct device *d;
> +	int rc;
> +
> +	if (!pdev->major) {
> +		rc = amd_pmc_get_smu_version(pdev);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	if (pdev->major > 64 || (pdev->major == 64 && pdev->minor > 65))
> +		return 0;
> +
> +	d = bus_find_device_by_name(&serio_bus, NULL, "serio0");
> +	if (!d)
> +		return 0;
> +	if (device_may_wakeup(d)) {
> +		dev_info_once(d, "Disabling IRQ1 wakeup source to avoid platform firmware bug\n");
> +		disable_irq_wake(1);
> +		device_set_wakeup_enable(d, false);
> +	}
> +	put_device(d);
> +
> +	return 0;
> +}
> +
>  static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
>  {
>  	struct rtc_device *rtc_device;
> @@ -782,6 +810,25 @@ static struct acpi_s2idle_dev_ops amd_pmc_s2idle_dev_ops = {
>  	.check = amd_pmc_s2idle_check,
>  	.restore = amd_pmc_s2idle_restore,
>  };
> +
> +static int __maybe_unused amd_pmc_suspend_handler(struct device *dev)
> +{
> +	struct amd_pmc_dev *pdev = dev_get_drvdata(dev);
> +
> +	if (pdev->cpu_id == AMD_CPU_ID_CZN) {
> +		int rc = amd_pmc_czn_wa_irq1(pdev);
> +
> +		if (rc) {
> +			dev_err(pdev->dev, "failed to adjust keyboard wakeup: %d\n", rc);
> +			return rc;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(amd_pmc_pm, amd_pmc_suspend_handler, NULL);
> +
>  #endif
>  
>  static const struct pci_device_id pmc_pci_ids[] = {
> @@ -980,6 +1027,9 @@ static struct platform_driver amd_pmc_driver = {
>  		.name = "amd_pmc",
>  		.acpi_match_table = amd_pmc_acpi_ids,
>  		.dev_groups = pmc_groups,
> +#ifdef CONFIG_SUSPEND
> +		.pm = &amd_pmc_pm,
> +#endif
>  	},
>  	.probe = amd_pmc_probe,
>  	.remove = amd_pmc_remove,

