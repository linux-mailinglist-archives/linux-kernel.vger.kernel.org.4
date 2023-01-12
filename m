Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30BA667C6A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 18:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjALRTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 12:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjALRSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 12:18:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED36D82F5C
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 08:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673542149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+r/hXDRD0/hcU6hWbPEHUg56pIsqoho5eKzvwcPaPp4=;
        b=Vvz1pHBzTbYGewOckptet5PIgnxic59HrSCPavhd9TQRyFrhdTLS+QOWAEzTNY1ys/eOaP
        orSwedOM9VSsJ0zalWQo6gM5Xjd69zkF9YPd42AWUpx06xuD/ywRdlkV+LOkDAmINpj6cG
        cVsSO3tYLt6O+nouEE/sQ/eN6iDLo2M=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-398--UxK9_JMOuuLhMtablwA4g-1; Thu, 12 Jan 2023 11:45:42 -0500
X-MC-Unique: -UxK9_JMOuuLhMtablwA4g-1
Received: by mail-ej1-f71.google.com with SMTP id hd17-20020a170907969100b007c117851c81so13162408ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 08:45:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+r/hXDRD0/hcU6hWbPEHUg56pIsqoho5eKzvwcPaPp4=;
        b=ceYteZ7O6U1KYYTblKYCWcRLMZUKL/RYjHn7LhOmnK44PNRlA9btxKnNXq5lcSkKxZ
         DP2nOOpUKafLUDkPi/TxQbZBt2rs6NwFWO8TpqA/pmry+IKZy1awocsY1cqfysIAXtU/
         ckeuG6BMAItEN7wumLAL42lV6qZyzARKYvAxFuEgJw5frqDdRBvm2aD0/nXqEYAjMKJL
         QTRdIK6pYiqXjF98XwLBdXl7DKeTjUiVrjeF365uhD5tvL4ZNDcBaX+xOAI4bMkdnmuq
         SuWYTrHfbpkj5ooiXnOQ8d+hz+RRHAaVVIwd7kcuh+qghoYE8ayLah5jqJKvCZylKq7d
         vc4Q==
X-Gm-Message-State: AFqh2kpTorjLjP8/FZvIRrIemJcDUo+jbGSDS7Plji8k2yE3LgqjZvad
        Rnd4I88Ss7RhO7k2QAq2NkAU2K/oUUDbB+sSEudEja5bA9p4K6OZs7TzN8Phh+78zT8FEwCompa
        d712jmD1M7MgEOdFbYpw1rx1Y
X-Received: by 2002:a05:6402:550a:b0:47f:bc9b:46ec with SMTP id fi10-20020a056402550a00b0047fbc9b46ecmr58228726edb.7.1673541940727;
        Thu, 12 Jan 2023 08:45:40 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtRYPCHtPxgfBu2NjQVazdJUM1l0A2rkq+Yvs5GMxjRsWo61/WLz2yRlHT8LDFL0nFXshrMQQ==
X-Received: by 2002:a05:6402:550a:b0:47f:bc9b:46ec with SMTP id fi10-20020a056402550a00b0047fbc9b46ecmr58228716edb.7.1673541940564;
        Thu, 12 Jan 2023 08:45:40 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id i12-20020aa7dd0c000000b0047021294426sm7301988edv.90.2023.01.12.08.45.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 08:45:39 -0800 (PST)
Message-ID: <9b4cea4f-46dd-86da-d54a-0aa43bd00b4d@redhat.com>
Date:   Thu, 12 Jan 2023 17:45:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] platform/x86: touchscreen_dmi: Add info for the CSL
 Panther Tab HD
Content-Language: en-US, nl
To:     Michael Klein <m.klein@mvz-labor-lb.de>,
        Mark Gross <markgross@kernel.org>, linux-input@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221220121103.uiwn5l7fii2iggct@LLGMVZLB-0037>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221220121103.uiwn5l7fii2iggct@LLGMVZLB-0037>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/20/22 13:11, Michael Klein wrote:
> Add touchscreen info for the CSL Panther Tab HD.
> 
> Signed-off-by: Michael Klein <m.klein@mvz-labor-lb.de>

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
>  drivers/platform/x86/touchscreen_dmi.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> index baae3120efd0..f00995390fdf 100644
> --- a/drivers/platform/x86/touchscreen_dmi.c
> +++ b/drivers/platform/x86/touchscreen_dmi.c
> @@ -264,6 +264,23 @@ static const struct ts_dmi_data connect_tablet9_data = {
>  	.properties     = connect_tablet9_props,
>  };
>  
> +static const struct property_entry csl_panther_tab_hd_props[] = {
> +	PROPERTY_ENTRY_U32("touchscreen-min-x", 1),
> +	PROPERTY_ENTRY_U32("touchscreen-min-y", 20),
> +	PROPERTY_ENTRY_U32("touchscreen-size-x", 1980),
> +	PROPERTY_ENTRY_U32("touchscreen-size-y", 1526),
> +	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
> +	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
> +	PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-csl-panther-tab-hd.fw"),
> +	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> +	{ }
> +};
> +
> +static const struct ts_dmi_data csl_panther_tab_hd_data = {
> +	.acpi_name      = "MSSL1680:00",
> +	.properties     = csl_panther_tab_hd_props,
> +};
> +
>  static const struct property_entry cube_iwork8_air_props[] = {
>  	PROPERTY_ENTRY_U32("touchscreen-min-x", 1),
>  	PROPERTY_ENTRY_U32("touchscreen-min-y", 3),
> @@ -1124,6 +1141,14 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "Tablet 9"),
>  		},
>  	},
> +	{
> +		/* CSL Panther Tab HD */
> +		.driver_data = (void *)&csl_panther_tab_hd_data,
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "CSL Computer GmbH & Co. KG"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "CSL Panther Tab HD"),
> +		},
> +	},
>  	{
>  		/* CUBE iwork8 Air */
>  		.driver_data = (void *)&cube_iwork8_air_data,

