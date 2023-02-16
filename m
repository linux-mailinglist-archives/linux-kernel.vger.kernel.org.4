Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909CB699557
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjBPNOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjBPNOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:14:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83377DBE4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 05:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676553209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bvLVjDVWRdxTXy5JA1Fm8sKhjFQEH5JLViEWIqmHCQw=;
        b=Gw4lgiNkc+HTENv3ODOS3qYAFboJ8A5K/bvAUtfD59rvaXGyPfszF8OjfAQAwj9/M8ZRMG
        N1xz0yZUoecg42fpbSAHmbm5VV6xHuw3S0rpHrgMwN2nb05d9MsUN1984Leiy9HaMrkW4O
        97yAUflKbsyXFY9PRe8y2zxt9jwYKwQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-434-KeG6R44sOie_5YaZYeHizQ-1; Thu, 16 Feb 2023 08:13:28 -0500
X-MC-Unique: KeG6R44sOie_5YaZYeHizQ-1
Received: by mail-ed1-f69.google.com with SMTP id b16-20020a056402279000b004ace822b750so1496744ede.20
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 05:13:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bvLVjDVWRdxTXy5JA1Fm8sKhjFQEH5JLViEWIqmHCQw=;
        b=iV0zC4x6EXnTbT9KYEdkfD1X0ywRLfiSt4bmylQX9VgMTR8boHcujjDGjzrlgxnc3E
         cFGCN+icDDisNeTQFgEkSSoal35eBanWjTjQCvQ3JDs8+L02V89jNlX15Y55X/xZXGId
         MarUvzcoa/LU9aYu1MGgpOFa3vwrBZ/BFaQzceO2aGzP//50n9Enliz3zNixYHjLbhtL
         hCste+LVrWzMdfv17OUmtZi7Lh27rhN0VecZXWVOeK2dDL+TukxwQZYI1aFqCmdYfMn7
         znHWgKo1K5Gz+Y3ecRSW92F1qbsuWyrceoNih5ieukR7Xjl2AF5nSwHRSsBibNHU3H/m
         6gvQ==
X-Gm-Message-State: AO0yUKWHjKOgC14ZWCEpxtwOkDIc1FueOy1ovbiAnsjSap9S3R/eD7cr
        W4hcFK35tewtChiSA9wEFvOd+cdcQFB7Ci4g+dfu5FOP2w1lkS9ppp7MeBmoyF7tBTWOS1VZSVT
        +YyPY+XAfe7DVO8bon7DbfJ3X
X-Received: by 2002:a17:906:5606:b0:881:f2f:6633 with SMTP id f6-20020a170906560600b008810f2f6633mr6158739ejq.50.1676553207477;
        Thu, 16 Feb 2023 05:13:27 -0800 (PST)
X-Google-Smtp-Source: AK7set+Hepcv4wJj0uVTbjK3FjHyoBrI0VAHDomoRMcGsZ7y4ZZVUGk0muIZgI+KwxCcMwcJkDIdCQ==
X-Received: by 2002:a17:906:5606:b0:881:f2f:6633 with SMTP id f6-20020a170906560600b008810f2f6633mr6158713ejq.50.1676553207162;
        Thu, 16 Feb 2023 05:13:27 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id h23-20020a170906261700b008aefb673d33sm807639ejc.55.2023.02.16.05.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 05:13:26 -0800 (PST)
Message-ID: <bac7cf14-fa40-fddf-b19a-5333b86f3c70@redhat.com>
Date:   Thu, 16 Feb 2023 14:13:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 2/5] apple-gmux: refactor gmux types
Content-Language: en-US, nl
To:     Orlando Chamberlain <orlandoch.dev@gmail.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Seth Forshee <sforshee@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>
References: <20230216122342.5918-1-orlandoch.dev@gmail.com>
 <20230216122342.5918-3-orlandoch.dev@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230216122342.5918-3-orlandoch.dev@gmail.com>
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

Hi,

One small nit below.

On 2/16/23 13:23, Orlando Chamberlain wrote:
> Add apple_gmux_config struct containing operations and data specific to
> each mux type.
> 
> This is in preparation for adding a third, MMIO based, gmux type.
> 
> Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
> ---
> v1->v2: Handle the two ways of reading the version as part of this type
> system (read_version_as_u32).
>  drivers/platform/x86/apple-gmux.c | 93 ++++++++++++++++++++-----------
>  include/linux/apple-gmux.h        | 18 ++++--
>  2 files changed, 74 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
> index ec99e05e532c..36208e93d745 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c
> @@ -5,6 +5,7 @@
>   *  Copyright (C) Canonical Ltd. <seth.forshee@canonical.com>
>   *  Copyright (C) 2010-2012 Andreas Heider <andreas@meetr.de>
>   *  Copyright (C) 2015 Lukas Wunner <lukas@wunner.de>
> + *  Copyright (C) 2023 Orlando Chamberlain <orlandoch.dev@gmail.com>
>   */
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> @@ -43,10 +44,12 @@
>   *     http://www.renesas.com/products/mpumcu/h8s/h8s2100/h8s2113/index.jsp
>   */
>  
> +struct apple_gmux_config;
> +
>  struct apple_gmux_data {
>  	unsigned long iostart;
>  	unsigned long iolen;
> -	bool indexed;
> +	const struct apple_gmux_config *config;
>  	struct mutex index_lock;
>  
>  	struct backlight_device *bdev;
> @@ -64,6 +67,18 @@ struct apple_gmux_data {
>  
>  static struct apple_gmux_data *apple_gmux_data;
>  
> +struct apple_gmux_config {
> +	u8 (*read8)(struct apple_gmux_data *gmux_data, int port);
> +	void (*write8)(struct apple_gmux_data *gmux_data, int port, u8 val);
> +	u32 (*read32)(struct apple_gmux_data *gmux_data, int port);
> +	void (*write32)(struct apple_gmux_data *gmux_data, int port, u32 val);
> +	const struct vga_switcheroo_handler *gmux_handler;
> +	enum vga_switcheroo_handler_flags_t handler_flags;
> +	unsigned long resource_type;
> +	bool read_version_as_u32;
> +	char *name;
> +};
> +
>  #define GMUX_INTERRUPT_ENABLE		0xff
>  #define GMUX_INTERRUPT_DISABLE		0x00
>  
> @@ -195,35 +210,23 @@ static void gmux_index_write32(struct apple_gmux_data *gmux_data, int port,
>  
>  static u8 gmux_read8(struct apple_gmux_data *gmux_data, int port)
>  {
> -	if (gmux_data->indexed)
> -		return gmux_index_read8(gmux_data, port);
> -	else
> -		return gmux_pio_read8(gmux_data, port);
> +	return gmux_data->config->read8(gmux_data, port);
>  }
>  
>  static void gmux_write8(struct apple_gmux_data *gmux_data, int port, u8 val)
>  {
> -	if (gmux_data->indexed)
> -		gmux_index_write8(gmux_data, port, val);
> -	else
> -		gmux_pio_write8(gmux_data, port, val);
> +	return gmux_data->config->write8(gmux_data, port, val);
>  }
>  
>  static u32 gmux_read32(struct apple_gmux_data *gmux_data, int port)
>  {
> -	if (gmux_data->indexed)
> -		return gmux_index_read32(gmux_data, port);
> -	else
> -		return gmux_pio_read32(gmux_data, port);
> +	return gmux_data->config->read32(gmux_data, port);
>  }
>  
>  static void gmux_write32(struct apple_gmux_data *gmux_data, int port,
>  			     u32 val)
>  {
> -	if (gmux_data->indexed)
> -		gmux_index_write32(gmux_data, port, val);
> -	else
> -		gmux_pio_write32(gmux_data, port, val);
> +	return gmux_data->config->write32(gmux_data, port, val);
>  }
>  
>  /**
> @@ -463,19 +466,43 @@ static enum vga_switcheroo_client_id gmux_get_client_id(struct pci_dev *pdev)
>  		return VGA_SWITCHEROO_DIS;
>  }
>  
> -static const struct vga_switcheroo_handler gmux_handler_indexed = {
> +static const struct vga_switcheroo_handler gmux_handler_no_ddc = {
>  	.switchto = gmux_switchto,
>  	.power_state = gmux_set_power_state,
>  	.get_client_id = gmux_get_client_id,
>  };
>  
> -static const struct vga_switcheroo_handler gmux_handler_classic = {
> +static const struct vga_switcheroo_handler gmux_handler_ddc = {
>  	.switchto = gmux_switchto,
>  	.switch_ddc = gmux_switch_ddc,
>  	.power_state = gmux_set_power_state,
>  	.get_client_id = gmux_get_client_id,
>  };
>  
> +static const struct apple_gmux_config apple_gmux_pio = {
> +	.read8 = &gmux_pio_read8,
> +	.write8 = &gmux_pio_write8,
> +	.read32 = &gmux_pio_read32,
> +	.write32 = &gmux_pio_write32,
> +	.gmux_handler = &gmux_handler_ddc,
> +	.handler_flags = VGA_SWITCHEROO_CAN_SWITCH_DDC,
> +	.resource_type = IORESOURCE_IO,
> +	.read_version_as_u32 = false,
> +	.name = "classic"
> +};
> +
> +static const struct apple_gmux_config apple_gmux_index = {
> +	.read8 = &gmux_index_read8,
> +	.write8 = &gmux_index_write8,
> +	.read32 = &gmux_index_read32,
> +	.write32 = &gmux_index_write32,
> +	.gmux_handler = &gmux_handler_no_ddc,
> +	.handler_flags = VGA_SWITCHEROO_NEEDS_EDP_CONFIG,
> +	.resource_type = IORESOURCE_IO,
> +	.read_version_as_u32 = true,
> +	.name = "indexed"
> +};
> +
>  /**
>   * DOC: Interrupt
>   *
> @@ -565,13 +592,13 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
>  	int ret = -ENXIO;
>  	acpi_status status;
>  	unsigned long long gpe;
> -	bool indexed = false;
> +	enum apple_gmux_type type;
>  	u32 version;
>  
>  	if (apple_gmux_data)
>  		return -EBUSY;
>  
> -	if (!apple_gmux_detect(pnp, &indexed)) {
> +	if (!apple_gmux_detect(pnp, &type)) {
>  		pr_info("gmux device not present\n");
>  		return -ENODEV;
>  	}
> @@ -581,6 +608,16 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
>  		return -ENOMEM;
>  	pnp_set_drvdata(pnp, gmux_data);
>  
> +	switch (type) {
> +	case APPLE_GMUX_TYPE_INDEXED:
> +		gmux_data->config = &apple_gmux_index;
> +		mutex_init(&gmux_data->index_lock);
> +		break;
> +	case APPLE_GMUX_TYPE_PIO:
> +		gmux_data->config = &apple_gmux_pio;
> +		break;
> +	}
> +
>  	res = pnp_get_resource(pnp, IORESOURCE_IO, 0);
>  	gmux_data->iostart = res->start;
>  	gmux_data->iolen = resource_size(res);
> @@ -591,9 +628,7 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
>  		goto err_free;
>  	}
>  
> -	if (indexed) {
> -		mutex_init(&gmux_data->index_lock);
> -		gmux_data->indexed = true;
> +	if (gmux_data->config->read_version_as_u32) {
>  		version = gmux_read32(gmux_data, GMUX_PORT_VERSION_MAJOR);
>  		ver_major = (version >> 24) & 0xff;
>  		ver_minor = (version >> 16) & 0xff;
> @@ -604,7 +639,7 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
>  		ver_release = gmux_read8(gmux_data, GMUX_PORT_VERSION_RELEASE);
>  	}
>  	pr_info("Found gmux version %d.%d.%d [%s]\n", ver_major, ver_minor,
> -		ver_release, (gmux_data->indexed ? "indexed" : "classic"));
> +		ver_release, gmux_data->config->name);
>  
>  	memset(&props, 0, sizeof(props));
>  	props.type = BACKLIGHT_PLATFORM;
> @@ -694,12 +729,8 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
>  	 *
>  	 * Pre-retina MacBook Pros can switch the panel's DDC separately.
>  	 */
> -	if (gmux_data->indexed)
> -		ret = vga_switcheroo_register_handler(&gmux_handler_indexed,
> -					      VGA_SWITCHEROO_NEEDS_EDP_CONFIG);
> -	else
> -		ret = vga_switcheroo_register_handler(&gmux_handler_classic,
> -					      VGA_SWITCHEROO_CAN_SWITCH_DDC);
> +	ret = vga_switcheroo_register_handler(gmux_data->config->gmux_handler,
> +			gmux_data->config->handler_flags);
>  	if (ret) {
>  		pr_err("Failed to register vga_switcheroo handler\n");
>  		goto err_register_handler;
> diff --git a/include/linux/apple-gmux.h b/include/linux/apple-gmux.h
> index 1f68b49bcd68..5f658439f7f8 100644
> --- a/include/linux/apple-gmux.h
> +++ b/include/linux/apple-gmux.h
> @@ -36,6 +36,11 @@
>  
>  #define GMUX_MIN_IO_LEN			(GMUX_PORT_BRIGHTNESS + 4)
>  
> +enum apple_gmux_type {
> +	APPLE_GMUX_TYPE_PIO,
> +	APPLE_GMUX_TYPE_INDEXED

In the kernel with things like enum "values" or array initializers we
typically add a , at the end of the last entry, to avoid needless
churn when adding more entry.

The one exception is this when there is a special entry which
marks the end of the array / enum. But that is not the case here.


> +};
> +
>  #if IS_ENABLED(CONFIG_APPLE_GMUX)
>  static inline bool apple_gmux_is_indexed(unsigned long iostart)
>  {
> @@ -65,13 +70,13 @@ static inline bool apple_gmux_is_indexed(unsigned long iostart)
>   * Return: %true if a supported gmux ACPI device is detected and the kernel
>   * was configured with CONFIG_APPLE_GMUX, %false otherwise.
>   */
> -static inline bool apple_gmux_detect(struct pnp_dev *pnp_dev, bool *indexed_ret)
> +static inline bool apple_gmux_detect(struct pnp_dev *pnp_dev, enum apple_gmux_type *type_ret)
>  {
>  	u8 ver_major, ver_minor, ver_release;
>  	struct device *dev = NULL;
>  	struct acpi_device *adev;
>  	struct resource *res;
> -	bool indexed = false;
> +	enum apple_gmux_type type = APPLE_GMUX_TYPE_PIO;
>  	bool ret = false;
>  
>  	if (!pnp_dev) {
> @@ -99,13 +104,14 @@ static inline bool apple_gmux_detect(struct pnp_dev *pnp_dev, bool *indexed_ret)
>  	ver_minor = inb(res->start + GMUX_PORT_VERSION_MINOR);
>  	ver_release = inb(res->start + GMUX_PORT_VERSION_RELEASE);
>  	if (ver_major == 0xff && ver_minor == 0xff && ver_release == 0xff) {
> -		indexed = apple_gmux_is_indexed(res->start);
> -		if (!indexed)
> +		if (apple_gmux_is_indexed(res->start))
> +			type = APPLE_GMUX_TYPE_INDEXED;
> +		else
>  			goto out;
>  	}
>  
> -	if (indexed_ret)
> -		*indexed_ret = indexed;
> +	if (type_ret)
> +		*type_ret = type;
>  
>  	ret = true;
>  out:

