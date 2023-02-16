Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1C1699598
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjBPNV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjBPNVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:21:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7488A5D4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 05:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676553639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VmypGMX3hxQz21N6rcBT8E1yhlwVSv2aRa81TfF+OWM=;
        b=L2fBmgX9P1KbcM4Lro+eZ60T50od7QvylTCI97e8varc4Mi6DcrfhdNOCBw8f5aAZIhJyx
        IP1bknoCIecEVKeOxdG/79RrY8n7wYsUEHvtwVb9Hxqsb2wk13mcKEUEUQHBuTHoYopyt+
        7s549P26qMkCIp7jvbesBHxVEsAGmIo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-594-vyJlEXP7MYK6N_USP9tAPg-1; Thu, 16 Feb 2023 08:20:30 -0500
X-MC-Unique: vyJlEXP7MYK6N_USP9tAPg-1
Received: by mail-ej1-f70.google.com with SMTP id lj27-20020a170906f9db00b008b14f129875so1550465ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 05:20:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VmypGMX3hxQz21N6rcBT8E1yhlwVSv2aRa81TfF+OWM=;
        b=QZ9fwbVGK2cCNkZeBJtmPjJV9A2oUpbDAW6MDDxLo4OKtAHBZy9PkGHf0fVH+z7r83
         x2uQ3NOA6RTbFiGUWgMBLYexReHmMKdMlMNAXFWTKDQtHUW7uitgzUO5zfscWcS8erId
         FqACgoCBq0GFHRCJ6HSJZMRGetHpMXoW2gqwongPqH1Q8jLK/hupLVAKK8+9zOSZP/VT
         l+phTOduYDbrTVGJoNMqxY6X7RtrlVIXql0hBd4DfIic9j7/lvy9w2BrCTF9/VigmIOZ
         56F4FlpfyJSXGzCXBScnc/7GjXvv9vi5iWpcuveDSXk0BAL+JqHY1F0xRUBXfI+Bf2LW
         omqw==
X-Gm-Message-State: AO0yUKUJmzqsXKKf3v6ur/xk0EMCCXKyvaut0m/nYqe0BLDRS2XHIORn
        ItyMbQJRj/C8x6V6TmQcqi4TaIZC5QLa8POowx/8aKb1NKyyZYgMEyDdixNyvT5ycscd7UUR4N3
        ryBl7CdTRndQ1l0YfOmmz11VD
X-Received: by 2002:a17:906:1d03:b0:8b1:3d15:1e2c with SMTP id n3-20020a1709061d0300b008b13d151e2cmr6651614ejh.9.1676553629303;
        Thu, 16 Feb 2023 05:20:29 -0800 (PST)
X-Google-Smtp-Source: AK7set91YxgYVfjkKYE8byh4AKMzFpHM5u0gmr0V+jxpnf45Av6+pw5nHtYBhOjnZNAzrDRQfkFDkA==
X-Received: by 2002:a17:906:1d03:b0:8b1:3d15:1e2c with SMTP id n3-20020a1709061d0300b008b13d151e2cmr6651592ejh.9.1676553629054;
        Thu, 16 Feb 2023 05:20:29 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id bk26-20020a170906b0da00b0089d5aaf85besm796575ejb.219.2023.02.16.05.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 05:20:28 -0800 (PST)
Message-ID: <0a58bf19-d943-b8c6-a882-7209d0543823@redhat.com>
Date:   Thu, 16 Feb 2023 14:20:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 5/5] apple-gmux: add debugfs interface
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
 <20230216122342.5918-6-orlandoch.dev@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230216122342.5918-6-orlandoch.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/16/23 13:23, Orlando Chamberlain wrote:
> Allow reading and writing gmux ports from userspace.
> 
> For example:
> 
> echo 4 > /sys/kernel/debug/apple_gmux/selected_port
> cat /sys/kernel/debug/apple_gmux/selected_port_data | xxd -p
> 
> Will show the gmux version information (00000005 in this case)
> 
> Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
> ---
> v1->v2: Use debugfs instead of sysfs.
>  drivers/platform/x86/apple-gmux.c | 88 +++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
> 
> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
> index 5bac6dcfada0..e8a35d98b113 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c
> @@ -22,6 +22,7 @@
>  #include <linux/delay.h>
>  #include <linux/pci.h>
>  #include <linux/vga_switcheroo.h>
> +#include <linux/debugfs.h>
>  #include <asm/io.h>
>  
>  /**
> @@ -66,6 +67,10 @@ struct apple_gmux_data {
>  	enum vga_switcheroo_client_id switch_state_external;
>  	enum vga_switcheroo_state power_state;
>  	struct completion powerchange_done;
> +
> +	/* debugfs data */
> +	u8 selected_port;
> +	struct dentry *debug_dentry;
>  };
>  
>  static struct apple_gmux_data *apple_gmux_data;
> @@ -674,6 +679,87 @@ static void gmux_notify_handler(acpi_handle device, u32 value, void *context)
>  		complete(&gmux_data->powerchange_done);
>  }
>  
> +/**
> + * DOC: Debugfs Interface
> + *
> + * gmux ports can be accessed from userspace as a debugfs interface. For example:
> + *
> + * # echo 4 > /sys/kernel/debug/apple_gmux/selected_port
> + * # cat /sys/kernel/debug/apple_gmux/selected_port_data | xxd -p
> + * 00000005
> + *
> + * Reads 4 bytes from port 4 (GMUX_PORT_VERSION_MAJOR).
> + *
> + * 1 and 4 byte writes are also allowed.
> + */
> +
> +static ssize_t gmux_selected_port_data_write(struct file *file,
> +		const char __user *userbuf, size_t count, loff_t *ppos)
> +{
> +	struct apple_gmux_data *gmux_data = file->private_data;
> +	int ret;
> +
> +	if (*ppos)
> +		return -EINVAL;
> +
> +	if (count == 1) {
> +		u8 data;
> +
> +		ret = copy_from_user(&data, userbuf, 1);
> +		if (ret)
> +			return ret;
> +		gmux_write8(gmux_data, gmux_data->selected_port, data);
> +	} else if (count == 4) {
> +		u32 data;
> +
> +		ret = copy_from_user(&data, userbuf, 4);
> +		if (ret)
> +			return ret;
> +		gmux_write32(gmux_data, gmux_data->selected_port, data);
> +	} else
> +		return -EINVAL;
> +
> +	return count;
> +}
> +
> +static ssize_t gmux_selected_port_data_read(struct file *file,
> +		char __user *userbuf, size_t count, loff_t *ppos)
> +{
> +	struct apple_gmux_data *gmux_data = file->private_data;
> +	u32 data;
> +
> +	data = gmux_read32(gmux_data, gmux_data->selected_port);
> +
> +	return simple_read_from_buffer(userbuf, count, ppos, &data, sizeof(data));
> +}
> +
> +static const struct file_operations gmux_port_data_ops = {
> +	.open = simple_open,
> +	.write = gmux_selected_port_data_write,
> +	.read = gmux_selected_port_data_read
> +};
> +
> +static void gmux_init_debugfs(struct apple_gmux_data *gmux_data)
> +{
> +	struct dentry *debug_dentry;
> +
> +	debug_dentry = debugfs_create_dir(KBUILD_MODNAME, NULL);
> +
> +	if (IS_ERR(debug_dentry))
> +		return;

This error check is not necessary here. The debugfs_create_*
and debugfs_remove_recursive() functions will happily take
the ERR_PTR value and ignore it.

This is what I tried to say when I said that no error handling
is necessary with debugfs (by design).

Regards,

Hans


> +
> +	gmux_data->debug_dentry = debug_dentry;
> +
> +	debugfs_create_u8("selected_port", 0644, debug_dentry, &gmux_data->selected_port);
> +	debugfs_create_file("selected_port_data", 0644, debug_dentry,
> +			gmux_data, &gmux_port_data_ops);
> +}
> +
> +static void gmux_fini_debugfs(struct apple_gmux_data *gmux_data)
> +{
> +	debugfs_remove_recursive(gmux_data->debug_dentry);
> +}
> +
>  static int gmux_suspend(struct device *dev)
>  {
>  	struct pnp_dev *pnp = to_pnp_dev(dev);
> @@ -874,6 +960,7 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
>  		goto err_register_handler;
>  	}
>  
> +	gmux_init_debugfs(gmux_data);
>  	return 0;
>  
>  err_register_handler:
> @@ -905,6 +992,7 @@ static void gmux_remove(struct pnp_dev *pnp)
>  {
>  	struct apple_gmux_data *gmux_data = pnp_get_drvdata(pnp);
>  
> +	gmux_fini_debugfs(gmux_data);
>  	vga_switcheroo_unregister_handler();
>  	gmux_disable_interrupts(gmux_data);
>  	if (gmux_data->gpe >= 0) {

