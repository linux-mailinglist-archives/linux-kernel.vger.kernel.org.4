Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3545BA856
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 10:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiIPInL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 04:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiIPInI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 04:43:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0884BA7AAA
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 01:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663317786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VbO+Lm6okm9qbgHERmbkye329u238iBYwsZHrrR1iRI=;
        b=aso8VfP/XMU/5aI7dlvAn5VWsZtY7VeJmQVq2JDZKMlQ038J6pYtyc8dEixkBBguZn4MOW
        gTHSgqTupkGh8pkGS3RGaSflwyrBWTjWjUj0VX6MzFw8NxZF+/T43x3S5Y0XXoeidpX0gD
        Uw15PH8zhvzIRVjfV974LUiZyhY4slw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-558-EGli8JF5NRuZV1i_nsjLqQ-1; Fri, 16 Sep 2022 04:43:04 -0400
X-MC-Unique: EGli8JF5NRuZV1i_nsjLqQ-1
Received: by mail-ej1-f72.google.com with SMTP id go7-20020a1709070d8700b007793ffa7c44so8720257ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 01:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=VbO+Lm6okm9qbgHERmbkye329u238iBYwsZHrrR1iRI=;
        b=VQe1vR4t7kX2tfFr5ajTC7UZtfX8Xym4eL41rX3xw3oMJiOuT4aqVu5p3VmU1QFGlM
         aNP0WtsBX7KNKS2bgxokpFWFA8X6gLILjwjT/qPJ9L+yJ9tSwhFBRGhM5A079QXxGr30
         LBdWwYYeLDkyzh1eKJygAu90yJPhqoFwO01Y29fgnt9JfsIxOP5L2GWJRdSdUocbRx6S
         h5J2/DSInlSuhp4u778IiRq7F4PVdalagSF82XGe40UfGXgGCZogGb/vjth35+fcGSWH
         Y+46HgowOo6kFomePPUxtdSS/fpVZlOCSYO4qM65952l6Ia9Jg7k4K3wu6vrrMpYZoc4
         JUSA==
X-Gm-Message-State: ACrzQf3yqc48PbS31YCe4e/NKrVJdNASk8Kab8bC/2dH78/vFfqVIrPi
        O37857ASJYQIDTlRXOpjZgiIZ6hZ1Mf/fQwNCWp02VlUw4YIyXwHAQ90MuCtQVRm9DOOe5MBvfN
        zk1qUQ5NAPnw9gJHr6SiBYoDG
X-Received: by 2002:a17:906:9bce:b0:770:2600:2cef with SMTP id de14-20020a1709069bce00b0077026002cefmr2695254ejc.611.1663317783705;
        Fri, 16 Sep 2022 01:43:03 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM759gvZBCB6O2D2gJJ1AFr4bzGtpik89lSSdGx3I+fQrZSmG1RYEyHiJYSHpT68QQAT/44CcQ==
X-Received: by 2002:a17:906:9bce:b0:770:2600:2cef with SMTP id de14-20020a1709069bce00b0077026002cefmr2695243ejc.611.1663317783518;
        Fri, 16 Sep 2022 01:43:03 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id s1-20020a056402014100b0044e8d0682b2sm13047094edu.71.2022.09.16.01.43.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 01:43:02 -0700 (PDT)
Message-ID: <42663baa-2d8c-a45a-a33e-571119ec12aa@redhat.com>
Date:   Fri, 16 Sep 2022 10:43:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] ACPI / x86: Add a quirk for Dell Inspiron 14 2-in-1 for
 StorageD3Enable
To:     Mario Limonciello <mario.limonciello@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     Luya Tshimbalanga <luya@fedoraproject.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
References: <20220915182315.276-1-mario.limonciello@amd.com>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220915182315.276-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/15/22 20:23, Mario Limonciello wrote:
> Dell Inspiron 14 2-in-1 has two ACPI nodes under GPP1 both with _ADR of
> 0, both without _HID.  It's ambiguous which the kernel should take, but
> it seems to take "DEV0".  Unfortunately "DEV0" is missing the device
> property `StorageD3Enable` which is present on "NVME".
> 
> To avoid this causing problems for suspend, add a quirk for this system
> to behave like `StorageD3Enable` property was found.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216440
> Reported-and-tested-by: Luya Tshimbalanga <luya@fedoraproject.org>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
> I had attempted to modify the heuristics for when two ACPI devices
> have the same _ADR to prefer the one with a _DSD, but this wasn't enough
> of a help. As the ACPI node doesn't contain anything valuable besides
> the _DSD, it seems that a quirk for the system is a fine enough solution.
> 
>  drivers/acpi/x86/utils.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index 664070fc8349..d7cdd8406c84 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -207,9 +207,26 @@ static const struct x86_cpu_id storage_d3_cpu_ids[] = {
>  	{}
>  };
>  
> +static const struct dmi_system_id force_storage_d3_dmi[] = {
> +	{
> +		/*
> +		 * _ADR is ambiguous between GPP1.DEV0 and GPP1.NVME
> +		 * but .NVME is needed to get StorageD3Enable node
> +		 * https://bugzilla.kernel.org/show_bug.cgi?id=216440
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 14 7425 2-in-1"),
> +		}
> +	},
> +	{}
> +};
> +
>  bool force_storage_d3(void)
>  {
> -	return x86_match_cpu(storage_d3_cpu_ids);
> +	const struct dmi_system_id *dmi_id = dmi_first_match(force_storage_d3_dmi);
> +
> +	return dmi_id || x86_match_cpu(storage_d3_cpu_ids);
>  }
>  
>  /*

