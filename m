Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B606647337
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiLHPgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiLHPfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:35:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2429B2AE
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670513569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ch+bMl5xfA9Hf3nS+/biOqToHC0qb1UdXSnrlmsi/Rc=;
        b=KDNA8rL0L6X1CZS5mPHrpBLaki1y65QbJi1fnbtxPsNXxtK5OKJpXrpPoB0iKX0xvO/E4t
        gNJpu/txD9YEe1iZnMnCBKfCT0fXpWGnVsKzHpWY96noxmceAjoFC2yloLyQpc6im53P5w
        yxDmhdV6h+NS0xz2q9D1G5RFUfeUdQc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-616-mFVvKtAyMFKTjeduCj9Hug-1; Thu, 08 Dec 2022 10:32:48 -0500
X-MC-Unique: mFVvKtAyMFKTjeduCj9Hug-1
Received: by mail-ej1-f72.google.com with SMTP id ds15-20020a170907724f00b007c0abebc958so1380902ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 07:32:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ch+bMl5xfA9Hf3nS+/biOqToHC0qb1UdXSnrlmsi/Rc=;
        b=cKOqFJAYu7o0/if+sXOn23sL46IrXBAT9FocnLg35IgHOWCk5GaPkiC8FpaCp4gCzb
         vChQmdI08mZAgo/D2heuX0OgO1rb/JnQF70sOGwxHH6DabF1aqFD0Gd9qmTD+B0KBo2k
         NWI+/gAgtrAH6dpJUPXiwfQMAap49yB0qOPpals2x9Lxp9VHlZAbaAA1Qj299DYS9dU0
         rZIvq5bc2ze0HRQZkhpQBxwWU28fgj8emICLedlZ0LmTcF9pXmcMMnOCkHwjYDy8wZmR
         aQlDGoTO+lmRf1UA+WKkkkTQA8h0LwVgmDYyjANS0s/ZmfFdSpco0tohCLBKJ+q4IQ8u
         cyEQ==
X-Gm-Message-State: ANoB5pnAMdXKp12ZL30JSjqG+PeMDpj1QmTXCZSY0SWFxy42L+iAOgal
        +BGHMXbmJYHflXeu6qWvw5Wh/pBM+izLcn7BtQv/uRd8SHaE1LmGC/qJ341ptFNMRCDTW3fyx+u
        4cXLxuI6BN07yoeMGUkx908ac
X-Received: by 2002:a05:6402:10c3:b0:462:9baa:e3b6 with SMTP id p3-20020a05640210c300b004629baae3b6mr2330561edu.29.1670513567378;
        Thu, 08 Dec 2022 07:32:47 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6P5yoOOuo2f0PZ+KC9fdSNgnGA/vUIF5+EZ/cxnnP+CruEtg/L+db1HtLIcam7aP48WyAgTQ==
X-Received: by 2002:a05:6402:10c3:b0:462:9baa:e3b6 with SMTP id p3-20020a05640210c300b004629baae3b6mr2330545edu.29.1670513567178;
        Thu, 08 Dec 2022 07:32:47 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id b20-20020aa7dc14000000b00457b5ba968csm3480779edu.27.2022.12.08.07.32.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 07:32:46 -0800 (PST)
Message-ID: <87f62d40-9b2d-8a99-0758-cf2a482ef56d@redhat.com>
Date:   Thu, 8 Dec 2022 16:32:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] platform/x86: mxm-wmi: fix memleak in
 mxm_wmi_call_mx[ds|mx]()
Content-Language: en-US, nl
To:     Yu Liao <liaoyu15@huawei.com>, markgross@kernel.org
Cc:     airlied@redhat.com, mjg@redhat.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        liwei391@huawei.com
References: <20221129011101.2042315-1-liaoyu15@huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221129011101.2042315-1-liaoyu15@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/29/22 02:11, Yu Liao wrote:
> The ACPI buffer memory (out.pointer) returned by wmi_evaluate_method()
> is not freed after the call, so it leads to memory leak.
> 
> The method results in ACPI buffer is not used, so just pass NULL to
> wmi_evaluate_method() which fixes the memory leak.
> 
> Fixes: 99b38b4acc0d ("platform/x86: add MXM WMI driver.")
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
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
>  drivers/platform/x86/mxm-wmi.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/x86/mxm-wmi.c b/drivers/platform/x86/mxm-wmi.c
> index 9a19fbd2f734..9a457956025a 100644
> --- a/drivers/platform/x86/mxm-wmi.c
> +++ b/drivers/platform/x86/mxm-wmi.c
> @@ -35,13 +35,11 @@ int mxm_wmi_call_mxds(int adapter)
>  		.xarg = 1,
>  	};
>  	struct acpi_buffer input = { (acpi_size)sizeof(args), &args };
> -	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
>  	acpi_status status;
>  
>  	printk("calling mux switch %d\n", adapter);
>  
> -	status = wmi_evaluate_method(MXM_WMMX_GUID, 0x0, adapter, &input,
> -				     &output);
> +	status = wmi_evaluate_method(MXM_WMMX_GUID, 0x0, adapter, &input, NULL);
>  
>  	if (ACPI_FAILURE(status))
>  		return status;
> @@ -60,13 +58,11 @@ int mxm_wmi_call_mxmx(int adapter)
>  		.xarg = 1,
>  	};
>  	struct acpi_buffer input = { (acpi_size)sizeof(args), &args };
> -	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
>  	acpi_status status;
>  
>  	printk("calling mux switch %d\n", adapter);
>  
> -	status = wmi_evaluate_method(MXM_WMMX_GUID, 0x0, adapter, &input,
> -				     &output);
> +	status = wmi_evaluate_method(MXM_WMMX_GUID, 0x0, adapter, &input, NULL);
>  
>  	if (ACPI_FAILURE(status))
>  		return status;

