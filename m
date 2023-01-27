Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2435A67E0AE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjA0JtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbjA0Jsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:48:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950F3820D9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 01:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674812849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zPvO5hCPuj5HXoU2KLCIKyuslLvkxuw/GDDgrq16R18=;
        b=P740As2cDYRauLLhtHuY1ggECDLqBLWPqG2lvWYQ/KQAmA3NcfgpQsCpaPfTb2ZrjdlQYm
        kaclDUHgpMvzxc+E4A6JSW+tPFHxxi9i0S3M2FgGdYrgAGoSNSw4U9ZzUwsFc1fbX+sYeS
        NpVGJzhIysn2GfacTZgKrIOLKGJI86s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-161-9OJuWojGPU6PJK0VoScIkQ-1; Fri, 27 Jan 2023 04:47:28 -0500
X-MC-Unique: 9OJuWojGPU6PJK0VoScIkQ-1
Received: by mail-ej1-f72.google.com with SMTP id jg2-20020a170907970200b0086ee94381fbso3074783ejc.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 01:47:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zPvO5hCPuj5HXoU2KLCIKyuslLvkxuw/GDDgrq16R18=;
        b=gfBfY1SRdP0EJRjMLfgaQcnvx0u4Z2PoLIU0TuIVkjXMVwYSdqGV1Z8GyNeW+o9mpt
         jUSZ+IgJfz3qVGk/71cb5zVXHqjNy9/DBHFmTlnepi3Mnp0b/dSKjdHaDMPz9LOb2W9P
         mXN8JagYB4WQJBtcsVEToCYjm7J7PKcZGy/qAOgtXQxF39Km9UZLhekcr41hAbVmOcKO
         JaK1sBSlcTSDHDZX+j18EYWVoxOxy3CNd0Exy63n0FWi/clVvO+MRBIzoyZgFPc5IQoB
         +fNct3EuXsX3NM5H0T8PnT21SNmw3nAhH31aKo/Pi9i4fLeiK8yGxONxyO5O6+dmQhuF
         MTPg==
X-Gm-Message-State: AO0yUKVxUsfhJcUoqIindVisMzXuV5Nbht5RslNKYQZRTAI3mZjvfKyG
        UIuZxHk84Sme7wSKfqatvunvtRYZp7oVf9N2fKR5CvSalSTDGp+BLYYGCe6cWkhZ2EoXrFiBfKF
        aAj0HP+/ZMPkRfOkGHLib0/OM
X-Received: by 2002:a50:ed82:0:b0:4a2:1f2:ac07 with SMTP id h2-20020a50ed82000000b004a201f2ac07mr1402064edr.10.1674812847085;
        Fri, 27 Jan 2023 01:47:27 -0800 (PST)
X-Google-Smtp-Source: AK7set+Gikoz+rewTlYADpShw9ZnVnOPDQX6YB6eJeB19KO6mjSjomQveMq8OHPZu62BGytpb7pWIQ==
X-Received: by 2002:a50:ed82:0:b0:4a2:1f2:ac07 with SMTP id h2-20020a50ed82000000b004a201f2ac07mr1402054edr.10.1674812846925;
        Fri, 27 Jan 2023 01:47:26 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id e24-20020a17090681d800b0087bda70d3efsm431545ejx.118.2023.01.27.01.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 01:47:26 -0800 (PST)
Message-ID: <06bbd154-0777-11d5-f9db-65f6f701628d@redhat.com>
Date:   Fri, 27 Jan 2023 10:47:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] platform/x86/amd: pmc: add CONFIG_SERIO dependency
Content-Language: en-US, nl
To:     Arnd Bergmann <arnd@kernel.org>, Mark Gross <markgross@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Naveen Krishna Chatradhi <NaveenKrishna.Chatradhi@amd.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230127093950.2368575-1-arnd@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230127093950.2368575-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/27/23 10:39, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Using the serio subsystem now requires the code to be reachable:
> 
> x86_64-linux-ld: drivers/platform/x86/amd/pmc.o: in function `amd_pmc_suspend_handler':
> pmc.c:(.text+0x86c): undefined reference to `serio_bus'
> 
> Add the usual dependency: as other users of serio use 'select'
> rather than 'depends on', use the same here.
> 
> Fixes: 8e60615e8932 ("platform/x86/amd: pmc: Disable IRQ1 wakeup for RN/CZN")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd, I'll include this in my next fixes pull-req to Linus.

Regards,

Hans


> ---
>  drivers/platform/x86/amd/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/amd/Kconfig b/drivers/platform/x86/amd/Kconfig
> index a825af8126c8..2ce8cb2170df 100644
> --- a/drivers/platform/x86/amd/Kconfig
> +++ b/drivers/platform/x86/amd/Kconfig
> @@ -8,6 +8,7 @@ source "drivers/platform/x86/amd/pmf/Kconfig"
>  config AMD_PMC
>  	tristate "AMD SoC PMC driver"
>  	depends on ACPI && PCI && RTC_CLASS
> +	select SERIO
>  	help
>  	  The driver provides support for AMD Power Management Controller
>  	  primarily responsible for S2Idle transactions that are driven from

