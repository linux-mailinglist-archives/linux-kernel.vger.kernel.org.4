Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6D6702D51
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242066AbjEONAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242084AbjEOM75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:59:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A06E5
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 05:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684155545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EU+jyy76OpL76hfSFfdqt6GtYdlVi8X+l+3db/Ak20c=;
        b=GR3Jkigrg/6hmozFcarro1Wl3jBJ/9o4qOPgvqiwy22YyEYc0uyleqMfV5GLboKlJJ77jB
        5SfX8VWm8ZFU/7/7qhVu3/YWclrc25NxIIyHqar1am555XKSr0tjhKyVDEYg0WH/len0ee
        vELB44uqu8ei+h+LgyvqOXhu1zbzrNc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-VW2kbYdeNqSDeDQ9U9Nvgg-1; Mon, 15 May 2023 08:59:03 -0400
X-MC-Unique: VW2kbYdeNqSDeDQ9U9Nvgg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5105d6d5756so1157022a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 05:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684155542; x=1686747542;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EU+jyy76OpL76hfSFfdqt6GtYdlVi8X+l+3db/Ak20c=;
        b=alEI4VLZP/W4/GBccFtTJLV9kGRDf9MpsrMz6/fUvCORsRbVBkrfGxfD5pzjkG+iJg
         drlooZtBDrTDS8Dy7yOBDUPfBtRDVKlQezVCASrdkh485rSF8Hd/S2lhjM+HyvcEM/Rm
         r/u/cz8YnVVUj0isQqBErZ+qacztpqDG3MOWf1Fcb9l3o7ASOp5WNqgBahIkjYl0Jaqe
         wb5PFvfitzpQxoTJtn3Go87vPFXjNfZMhSJJKH6Hba0+laMmaQkN+lnKQ8fo6n01EMKA
         fpllrLywHQU3HdUcz+Qfq9VKYqLdLnLiy+0UcUiZ3k8eKS2poiUu0jP8dVE7g0CX6tYu
         UPNA==
X-Gm-Message-State: AC+VfDynGZuuCb/7RJmDXkuwyZs0hJs7w/lP1oLQophbMtIYkrLb2LRV
        T7FEwhJ/cMm8mqT760EHvQiCo1gn1LDGhnHg0Je/CcgxAqYFwqyTKx2ZrfOagtI3GGmw+aT0/ue
        gMjJEvHU78f1YtseJ1E7PfBoR
X-Received: by 2002:aa7:df11:0:b0:505:4f7:8a50 with SMTP id c17-20020aa7df11000000b0050504f78a50mr24996507edy.5.1684155542271;
        Mon, 15 May 2023 05:59:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6j0ketmGZXip/XZj7GOC3Vz8V7KmOq4GJCNCQqS+CJf5Q3VtBVCE/4Qufc/wg0JVIrOhgqIA==
X-Received: by 2002:aa7:df11:0:b0:505:4f7:8a50 with SMTP id c17-20020aa7df11000000b0050504f78a50mr24996495edy.5.1684155541929;
        Mon, 15 May 2023 05:59:01 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id k23-20020a05640212d700b0050c0b9d31a7sm7323068edx.22.2023.05.15.05.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 05:59:01 -0700 (PDT)
Message-ID: <247af7d9-f6b1-def5-a138-780f567f48cb@redhat.com>
Date:   Mon, 15 May 2023 14:59:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] platform/x86/amd/pmf: Fix CnQF and auto-mode after resume
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Shyam-sundar.S-k@amd.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230513011408.958-1-mario.limonciello@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230513011408.958-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/13/23 03:14, Mario Limonciello wrote:
> After suspend/resume cycle there is an error message and auto-mode
> or CnQF stops working.
> 
> [ 5741.447511] amd-pmf AMDI0100:00: SMU cmd failed. err: 0xff
> [ 5741.447523] amd-pmf AMDI0100:00: AMD_PMF_REGISTER_RESPONSE:ff
> [ 5741.447527] amd-pmf AMDI0100:00: AMD_PMF_REGISTER_ARGUMENT:7
> [ 5741.447531] amd-pmf AMDI0100:00: AMD_PMF_REGISTER_MESSAGE:16
> [ 5741.447540] amd-pmf AMDI0100:00: [AUTO_MODE] avg power: 0 mW mode: QUIET
> 
> This is because the DRAM address used for accessing metrics table
> needs to be refreshed after a suspend resume cycle. Add a resume
> callback to reset this again.
> 
> Fixes: 1a409b35c995 ("platform/x86/amd/pmf: Get performance metrics from PMFW")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Thank you for your patch, I've applied this patch to my fixes
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Note it will show up in my fixes branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans



> ---
>  drivers/platform/x86/amd/pmf/core.c | 32 ++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
> index d5bb775dadcf..ee5f124f78b6 100644
> --- a/drivers/platform/x86/amd/pmf/core.c
> +++ b/drivers/platform/x86/amd/pmf/core.c
> @@ -245,24 +245,29 @@ static const struct pci_device_id pmf_pci_ids[] = {
>  	{ }
>  };
>  
> -int amd_pmf_init_metrics_table(struct amd_pmf_dev *dev)
> +static void amd_pmf_set_dram_addr(struct amd_pmf_dev *dev)
>  {
>  	u64 phys_addr;
>  	u32 hi, low;
>  
> -	INIT_DELAYED_WORK(&dev->work_buffer, amd_pmf_get_metrics);
> +	phys_addr = virt_to_phys(dev->buf);
> +	hi = phys_addr >> 32;
> +	low = phys_addr & GENMASK(31, 0);
> +
> +	amd_pmf_send_cmd(dev, SET_DRAM_ADDR_HIGH, 0, hi, NULL);
> +	amd_pmf_send_cmd(dev, SET_DRAM_ADDR_LOW, 0, low, NULL);
> +}
>  
> +int amd_pmf_init_metrics_table(struct amd_pmf_dev *dev)
> +{
>  	/* Get Metrics Table Address */
>  	dev->buf = kzalloc(sizeof(dev->m_table), GFP_KERNEL);
>  	if (!dev->buf)
>  		return -ENOMEM;
>  
> -	phys_addr = virt_to_phys(dev->buf);
> -	hi = phys_addr >> 32;
> -	low = phys_addr & GENMASK(31, 0);
> +	INIT_DELAYED_WORK(&dev->work_buffer, amd_pmf_get_metrics);
>  
> -	amd_pmf_send_cmd(dev, SET_DRAM_ADDR_HIGH, 0, hi, NULL);
> -	amd_pmf_send_cmd(dev, SET_DRAM_ADDR_LOW, 0, low, NULL);
> +	amd_pmf_set_dram_addr(dev);
>  
>  	/*
>  	 * Start collecting the metrics data after a small delay
> @@ -273,6 +278,18 @@ int amd_pmf_init_metrics_table(struct amd_pmf_dev *dev)
>  	return 0;
>  }
>  
> +static int amd_pmf_resume_handler(struct device *dev)
> +{
> +	struct amd_pmf_dev *pdev = dev_get_drvdata(dev);
> +
> +	if (pdev->buf)
> +		amd_pmf_set_dram_addr(pdev);
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(amd_pmf_pm, NULL, amd_pmf_resume_handler);
> +
>  static void amd_pmf_init_features(struct amd_pmf_dev *dev)
>  {
>  	int ret;
> @@ -413,6 +430,7 @@ static struct platform_driver amd_pmf_driver = {
>  		.name = "amd-pmf",
>  		.acpi_match_table = amd_pmf_acpi_ids,
>  		.dev_groups = amd_pmf_driver_groups,
> +		.pm = pm_sleep_ptr(&amd_pmf_pm),
>  	},
>  	.probe = amd_pmf_probe,
>  	.remove_new = amd_pmf_remove,

