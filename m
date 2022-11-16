Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FC262B41E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 08:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbiKPHpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 02:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbiKPHpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 02:45:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D909ED113
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 23:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668584654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=px67Q9G9Ko7skpsPW+A59m2Q23W6Z7m+9mGvjMTfUZc=;
        b=cfT2XyPQD4eKeRvgjwXCc4eWsJiq4QPmEK4748JL28VOrF/ASxLA4oJ6lXhto8pLw8o1Xx
        s3jirHVvqEaMPF+tKpM6BhDPbfacsxqta+nCbJaWboEhKz5UeGrbxFVcAYIEA9ByTNB2tf
        pS1EKXvCxTNlEvBFs2qoH9XwrFb4O60=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-650-SEr4rRELPf6xwISoSFs_Fw-1; Wed, 16 Nov 2022 02:44:13 -0500
X-MC-Unique: SEr4rRELPf6xwISoSFs_Fw-1
Received: by mail-ed1-f70.google.com with SMTP id b14-20020a056402278e00b004621a2642d7so11633377ede.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 23:44:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=px67Q9G9Ko7skpsPW+A59m2Q23W6Z7m+9mGvjMTfUZc=;
        b=ofV2ZiLBxSrVJhWMtK0lz0gYCbM3rroJsK6ekxmIEjMzbZExNpXI5sQvKwXO6HtAPO
         NMmSSL0WoivYak2yBgSbvBUyEUFlOSI+cVVailtJbeMXDHWBsA0zUkzrRMRkpZ+dIsd/
         1uN9rWGjj00H8R16QrcvCRAXSid0mf0lZBL8l4mYp06dULcgtQzNdv9d4qlr2/POmhFy
         2Ehkij/8zJDt5xjt5rXvlRO3kcysWkXKJGKbYTWiqaYxqLiX14pkNMIQNHFUcp4QI1za
         cMCFbboAsT3+iCInQ2AO3rQAy/n0LwfXgbvlRYhCu4kZMnSsWgBlhMWfk7bVtFCALi9e
         Au4w==
X-Gm-Message-State: ANoB5pkhHzXolWr0z2D5yMI95/Ccoyug90CdP1LKsjsWiOxCnVs6FUFd
        9xXToT7U4JZfKLaGmdoOuu77sF+NUsxvcbpRW4JuPvoOdrRYgPQuOvP/p1mXEe28SW4p/Gw9Nnv
        7XbqYk6jd6QvDr/o01f1jxkbX
X-Received: by 2002:a05:6402:2407:b0:467:5e4f:591 with SMTP id t7-20020a056402240700b004675e4f0591mr17853815eda.414.1668584652050;
        Tue, 15 Nov 2022 23:44:12 -0800 (PST)
X-Google-Smtp-Source: AA0mqf712prrYUCC64TH9pHr3rG4LYjbhI9B+bizTPhSQkwyIMLJRFVZEIX3EOyEGrzMoJ4mm9q05w==
X-Received: by 2002:a05:6402:2407:b0:467:5e4f:591 with SMTP id t7-20020a056402240700b004675e4f0591mr17853802eda.414.1668584651871;
        Tue, 15 Nov 2022 23:44:11 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id g7-20020a056402320700b00463c475684csm7183124eda.73.2022.11.15.23.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 23:44:11 -0800 (PST)
Message-ID: <ac5c3f8f-8d3a-be5e-a12f-6b164f0b235a@redhat.com>
Date:   Wed, 16 Nov 2022 08:44:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] platform/surface: aggregator_registry: Add support for
 Surface Laptop 5
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221115231440.1338142-1-luzmaximilian@gmail.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221115231440.1338142-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/16/22 00:14, Maximilian Luz wrote:
> Add device nodes to enable support for battery and charger status, the
> ACPI platform profile, as well as internal HID devices (including
> touchpad and keyboard) on the Surface Laptop 5.
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

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
>  .../surface/surface_aggregator_registry.c        | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
> index db82c2a7c567..023f126121d7 100644
> --- a/drivers/platform/surface/surface_aggregator_registry.c
> +++ b/drivers/platform/surface/surface_aggregator_registry.c
> @@ -234,6 +234,19 @@ static const struct software_node *ssam_node_group_sl3[] = {
>  	NULL,
>  };
>  
> +/* Devices for Surface Laptop 5. */
> +static const struct software_node *ssam_node_group_sl5[] = {
> +	&ssam_node_root,
> +	&ssam_node_bat_ac,
> +	&ssam_node_bat_main,
> +	&ssam_node_tmp_pprof,
> +	&ssam_node_hid_main_keyboard,
> +	&ssam_node_hid_main_touchpad,
> +	&ssam_node_hid_main_iid5,
> +	&ssam_node_hid_sam_ucm_ucsi,
> +	NULL,
> +};
> +
>  /* Devices for Surface Laptop Studio. */
>  static const struct software_node *ssam_node_group_sls[] = {
>  	&ssam_node_root,
> @@ -345,6 +358,9 @@ static const struct acpi_device_id ssam_platform_hub_match[] = {
>  	/* Surface Laptop 4 (13", Intel) */
>  	{ "MSHW0250", (unsigned long)ssam_node_group_sl3 },
>  
> +	/* Surface Laptop 5 */
> +	{ "MSHW0350", (unsigned long)ssam_node_group_sl5 },
> +
>  	/* Surface Laptop Go 1 */
>  	{ "MSHW0118", (unsigned long)ssam_node_group_slg1 },
>  

