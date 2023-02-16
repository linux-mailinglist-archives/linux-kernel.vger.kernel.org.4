Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40EC699532
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjBPNIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBPNIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:08:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85B841B7D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 05:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676552878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5tfNziE7I62EYh6SyterE30kSNHMO9z+RTw6lOah7rY=;
        b=P1gXkVfDiLyxnIDITYnlU8G3A4SrdZCt5ZFRwO63duS0CuYubSOcY2DWvz90AjQ1AnCjlv
        YzVXdcNE0Ejp8GsspGlgPATJ+XejJpHB5vDcvup0ghxBcHH/UXNbbaqbFtmJvwRYigfgOC
        FxHlwZ/kXzV5kxO6dBBY/V0vCQzOAgw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-201-nLOYMrq-O7K7uzXDzX2z3A-1; Thu, 16 Feb 2023 08:07:56 -0500
X-MC-Unique: nLOYMrq-O7K7uzXDzX2z3A-1
Received: by mail-ej1-f70.google.com with SMTP id 19-20020a170906309300b008b14b9cb779so1510942ejv.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 05:07:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5tfNziE7I62EYh6SyterE30kSNHMO9z+RTw6lOah7rY=;
        b=MyE2rJyTEz/mZ5x/zmDn8IxRoldhrdWFxnn95jEwmWF46o80gq3r7xGKxe/LY9AKXr
         G6pVJh66S3KGdNVDBn4xQSN691rWA245NWmgx2tezjjrRBt24Y7mLq8W82EyOJPaopme
         NZItdjIsm/xHGfrN1q8HkJA27XMhhcSrJ/qOJ2Mz/Jn3fGZyd0+q7pB8R/I3ZX9O9e4f
         XpwVJh0+Fr7A8RyQeSHc0gqo/BPKYkN6698iCn5AQ80QHhf50QHsRDsNvaLiP/aHXD4j
         uCp58pepigVNio0N+xCWBvT3173k/Z3HT7G4aK29SErP1jOqYwNiPwUWzGH/E1Eu5y8k
         BRNQ==
X-Gm-Message-State: AO0yUKUtXSbSQZnhkd48dci1X/7vZzuP5VJjSGIL8pjHDNVC0zLq8nrq
        VGMlN9xQuxFRi6AnYnSz6xwdXKlXaRoPB9WGDYgM10s8putRt/ftWut80YOaNJ4w4fArhasLMwE
        BCwPHpjwP0a68kEm34ogiwaJm
X-Received: by 2002:a17:906:3e56:b0:878:7f6e:38a7 with SMTP id t22-20020a1709063e5600b008787f6e38a7mr8203984eji.44.1676552875794;
        Thu, 16 Feb 2023 05:07:55 -0800 (PST)
X-Google-Smtp-Source: AK7set8aFKVTZuW4klTERDVT/XIBaEprwulezxA3vaCx0kdfWJ10kXqR4fJS7bvMAEgGFDcTi7eIbQ==
X-Received: by 2002:a17:906:3e56:b0:878:7f6e:38a7 with SMTP id t22-20020a1709063e5600b008787f6e38a7mr8203959eji.44.1676552875492;
        Thu, 16 Feb 2023 05:07:55 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ky13-20020a170907778d00b008b138528a53sm771141ejc.224.2023.02.16.05.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 05:07:54 -0800 (PST)
Message-ID: <87d2068b-2644-0307-d722-5539b1f9fb36@redhat.com>
Date:   Thu, 16 Feb 2023 14:07:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 3/5] apple-gmux: Use GMSP acpi method for interrupt
 clear
To:     Orlando Chamberlain <orlandoch.dev@gmail.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Seth Forshee <sforshee@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>
References: <20230216122342.5918-1-orlandoch.dev@gmail.com>
 <20230216122342.5918-4-orlandoch.dev@gmail.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230216122342.5918-4-orlandoch.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Orlando,

Thank you for the new version patches 1 + 2 look good,
one small remark on this one.

On 2/16/23 13:23, Orlando Chamberlain wrote:
> This is needed for interrupts to be cleared correctly on MMIO based
> gmux's. It is untested if this helps/hinders other gmux types, so
> currently this is only enabled for the MMIO gmux's.
> 
> There is also a "GMLV" acpi method, and the "GMSP" method can be called
> with 1 as its argument, but the purposes of these aren't known and they
> don't seem to be needed.
> 
> Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
> ---
> v1->v2: Only enable this on MMIO gmux's
>  drivers/platform/x86/apple-gmux.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
> index 36208e93d745..12a93fc49c36 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c
> @@ -76,6 +76,7 @@ struct apple_gmux_config {
>  	enum vga_switcheroo_handler_flags_t handler_flags;
>  	unsigned long resource_type;
>  	bool read_version_as_u32;
> +	bool use_acpi_gmsp;
>  	char *name;
>  };
>  
> @@ -488,6 +489,7 @@ static const struct apple_gmux_config apple_gmux_pio = {
>  	.handler_flags = VGA_SWITCHEROO_CAN_SWITCH_DDC,
>  	.resource_type = IORESOURCE_IO,
>  	.read_version_as_u32 = false,
> +	.use_acpi_gmsp = false,
>  	.name = "classic"
>  };
>  
> @@ -500,6 +502,7 @@ static const struct apple_gmux_config apple_gmux_index = {
>  	.handler_flags = VGA_SWITCHEROO_NEEDS_EDP_CONFIG,
>  	.resource_type = IORESOURCE_IO,
>  	.read_version_as_u32 = true,
> +	.use_acpi_gmsp = false,
>  	.name = "indexed"
>  };
>  
> @@ -511,8 +514,29 @@ static const struct apple_gmux_config apple_gmux_index = {
>   * MCP79, on all following generations it's GPIO pin 6 of the Intel PCH.
>   * The GPE merely signals that an interrupt occurred, the actual type of event
>   * is identified by reading a gmux register.
> + *
> + * On MMIO gmux's, we also need to call the acpi method GMSP to properly clear
> + * interrupts.
>   */
>  
> +static int gmux_call_acpi_gmsp(struct apple_gmux_data *gmux_data, int arg)
> +{
> +	acpi_status status = AE_OK;
> +	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
> +	struct acpi_object_list arg_list = { 1, &arg0 };
> +
> +	arg0.integer.value = arg;
> +
> +	status = acpi_evaluate_object(gmux_data->dhandle, "GMSP", &arg_list, NULL);
> +	if (ACPI_FAILURE(status)) {
> +		pr_err("GMSP call failed: %s\n",
> +		       acpi_format_exception(status));
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
>  static inline void gmux_disable_interrupts(struct apple_gmux_data *gmux_data)
>  {
>  	gmux_write8(gmux_data, GMUX_PORT_INTERRUPT_ENABLE,
> @@ -536,7 +560,11 @@ static void gmux_clear_interrupts(struct apple_gmux_data *gmux_data)
>  
>  	/* to clear interrupts write back current status */
>  	status = gmux_interrupt_get_status(gmux_data);
> -	gmux_write8(gmux_data, GMUX_PORT_INTERRUPT_STATUS, status);
> +	if (status) {
> +		gmux_write8(gmux_data, GMUX_PORT_INTERRUPT_STATUS, status);
> +		if (gmux_data->config->use_acpi_gmsp)
> +			gmux_call_acpi_gmsp(gmux_data, 0);
> +	}

This changes the behavior on the existing supported models to
only write back status when it is non 0. This is likely fine
but given that we seem to lack testers for the old models
I would prefer to not change the behavior there.

So how about:

	gmux_write8(gmux_data, GMUX_PORT_INTERRUPT_STATUS, status);
	if (status && gmux_data->config->use_acpi_gmsp)
		gmux_call_acpi_gmsp(gmux_data, 0);

?

The 0 write to what presumably is a register with
write 1 to clear bits should be harmless.

You can test that it is harmless on the new MMIO models
and this way we don't change the behavior on the older models.

Regards,

Hans

