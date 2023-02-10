Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF646927B7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 21:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbjBJUQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 15:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjBJUQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 15:16:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFC7298F5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 12:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676060157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZNFnqY613h9bvaBLnYI52rKBZZmmgHMm3e/efaUU+qs=;
        b=Vqjt+ErLjrZaxGv/GO+qvJudqFzABZt//7IS5ySy7pkaXBOh+hq+xvG+k+BmobgMGHVf/1
        nAqmAp3NVDP+zWqalZmEhoPBs6vbelGklizt9me26prX//mSP4EmP3Im1y7werX91yIz9c
        fp+vecDv2pZ04XuMR5EECIPjd4me648=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-457-Tz8RBjYRPvGMKWCOyscPyQ-1; Fri, 10 Feb 2023 15:15:53 -0500
X-MC-Unique: Tz8RBjYRPvGMKWCOyscPyQ-1
Received: by mail-ej1-f72.google.com with SMTP id d14-20020a170906c20e00b00889f989d8deso4203023ejz.15
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 12:15:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNFnqY613h9bvaBLnYI52rKBZZmmgHMm3e/efaUU+qs=;
        b=oljA8FAbPgq80uRqZE5jDWBW1lmqsSugOh5oPhQs6ONB+EPXsGcy0L6kqk4zHNbi+J
         iSwu9bjr9DVT08Ddxnbr7a1yYgCx5A3yKi/tT214TwZ0ovQAR7bstt+mpT38734FGOi4
         Zpgbua94RyP13PJIB/eU+9j+94yn2s6NJiqTIWdkF3Sf2jHq2Qtj8LILUBrPmlxDk605
         WKpRq8sIqakDXujqUUHF/HdXNozd3KyCvVmgw5/xv80r69H31ySA2pFneclLIaiRb/yM
         K4OzBrPv0K+1QYr8PgHHpaYupCFB6G/K7QP5aflj6gYppsw6GrVb6eBsvPFZmOdNDDSR
         M6HA==
X-Gm-Message-State: AO0yUKUxR9pPFRI28im97A0O8bxCee8YvRA6djOfm6clj0Dyh8CZko5m
        LpnWcwG6gVo/hdqU7+CJRlJf3+OTYufx28tSgKd0eMq9ufP+xFmGkiiMaanXROpAMQ7MLMjOYgs
        KxqzEemRhMlcE0TO41fEwoGHa
X-Received: by 2002:a17:906:a102:b0:878:5e84:e1da with SMTP id t2-20020a170906a10200b008785e84e1damr19986658ejy.27.1676060152362;
        Fri, 10 Feb 2023 12:15:52 -0800 (PST)
X-Google-Smtp-Source: AK7set83CY0lAZ6vzuP/e62ituWkImwtPZspb5CjMytMYB/Xmhp1TOSi84e/LdQpynGJdXlN84G9Aw==
X-Received: by 2002:a17:906:a102:b0:878:5e84:e1da with SMTP id t2-20020a170906a10200b008785e84e1damr19986636ejy.27.1676060152166;
        Fri, 10 Feb 2023 12:15:52 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id m10-20020a170906580a00b0086f4b8f9e42sm2813890ejq.65.2023.02.10.12.15.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 12:15:51 -0800 (PST)
Message-ID: <3e6c6cba-ad53-d380-a028-840fb19dbfcb@redhat.com>
Date:   Fri, 10 Feb 2023 21:15:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 7/9] apple-gmux: add sysfs interface
Content-Language: en-US, nl
To:     Orlando Chamberlain <orlandoch.dev@gmail.com>,
        platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>,
        Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Bokun Zhang <Bokun.Zhang@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>, Evan Quan <evan.quan@amd.com>,
        Kerem Karabay <kekrby@gmail.com>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>
References: <20230210044826.9834-1-orlandoch.dev@gmail.com>
 <20230210044826.9834-8-orlandoch.dev@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230210044826.9834-8-orlandoch.dev@gmail.com>
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

On 2/10/23 05:48, Orlando Chamberlain wrote:
> Allow reading gmux ports from userspace. When the unsafe module
> parameter allow_user_writes is true, writing 1 byte
> values is also allowed.
> 
> For example:
> 
> cd /sys/bus/acpi/devices/APP000B:00/physical_node/
> echo 4 > gmux_selected_port
> cat gmux_selected_port_data | xxd -p
> 
> Will show the gmux version information (00000005 in this case)

Please use debugfs for this and as part of the conversion
drop the #ifdef-s (debugfs has stubs for when not enabled)
and drop all the error checking of creating the files, debugfs
is deliberately designed to not have any error checking in
the setup / teardown code.

This also removes the need for the allow_user_writes parameter
replacing it with the new kernel lockdown mechanism. debugfs
will automatically block access to writable files when
the kernel is in lockdown mode.

Regards,

Hans




> Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
> ---
>  drivers/platform/x86/apple-gmux.c | 129 ++++++++++++++++++++++++++++++
>  1 file changed, 129 insertions(+)
> 
> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
> index c38d6ef0c15a..756059d48393 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c
> @@ -66,6 +66,11 @@ struct apple_gmux_data {
>  	enum vga_switcheroo_client_id switch_state_external;
>  	enum vga_switcheroo_state power_state;
>  	struct completion powerchange_done;
> +
> +#ifdef CONFIG_SYSFS
> +	/* sysfs data */
> +	int selected_port;
> +#endif /* CONFIG_SYSFS */
>  };
>  
>  static struct apple_gmux_data *apple_gmux_data;
> @@ -651,6 +656,121 @@ static void gmux_notify_handler(acpi_handle device, u32 value, void *context)
>  		complete(&gmux_data->powerchange_done);
>  }
>  
> +/**
> + * DOC: Sysfs Interface
> + *
> + * gmux ports can be read from userspace as a sysfs interface. For example:
> + *
> + * # echo 4 > /sys/bus/acpi/devices/APP000B:00/physical_node/gmux_selected_port
> + * # cat /sys/bus/acpi/devices/APP000B:00/physical_node/gmux_selected_port_data | xxd -p
> + * 00000005
> + *
> + * Reads 4 bytes from port 4 (GMUX_PORT_VERSION_MAJOR).
> + *
> + * Single byte writes are also supported, however this must be enabled with the
> + * unsafe allow_user_writes module parameter.
> + *
> + */
> +
> +#ifdef CONFIG_SYSFS
> +
> +static bool allow_user_writes;
> +module_param_unsafe(allow_user_writes, bool, 0);
> +MODULE_PARM_DESC(allow_user_writes, "Allow userspace to write to gmux ports (default: false) (bool)");
> +
> +static ssize_t gmux_selected_port_store(struct device *dev,
> +		struct device_attribute *attr, const char *sysfsbuf, size_t count)
> +{
> +	struct apple_gmux_data *gmux_data = dev_get_drvdata(dev);
> +	u8 port;
> +
> +	if (kstrtou8(sysfsbuf, 10, &port) < 0)
> +		return -EINVAL;
> +
> +	/* On pio gmux's, make sure the user doesn't access too high of a port. */
> +	if ((gmux_data->config == &apple_gmux_pio) &&
> +		port > (gmux_data->iolen - 4))
> +		return -EINVAL;
> +
> +	gmux_data->selected_port = port;
> +	return count;
> +}
> +
> +static ssize_t gmux_selected_port_show(struct device *dev,
> +		struct device_attribute *attr, char *sysfsbuf)
> +{
> +	struct apple_gmux_data *gmux_data = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(sysfsbuf, "%d\n", gmux_data->selected_port);
> +}
> +
> +DEVICE_ATTR_RW(gmux_selected_port);
> +
> +static ssize_t gmux_selected_port_data_store(struct device *dev,
> +		struct device_attribute *attr, const char *sysfsbuf, size_t count)
> +{
> +	struct apple_gmux_data *gmux_data = dev_get_drvdata(dev);
> +
> +	if (count == 1)
> +		gmux_write8(gmux_data, gmux_data->selected_port, *sysfsbuf);
> +	else
> +		return -EINVAL;
> +
> +	return count;
> +}
> +
> +static ssize_t gmux_selected_port_data_show(struct device *dev,
> +		struct device_attribute *attr, char *sysfsbuf)
> +{
> +	struct apple_gmux_data *gmux_data = dev_get_drvdata(dev);
> +	u32 data;
> +
> +	data = gmux_read32(gmux_data, gmux_data->selected_port);
> +	memcpy(sysfsbuf, &data, sizeof(data));
> +
> +	return sizeof(data);
> +}
> +
> +struct device_attribute dev_attr_gmux_selected_port_data_rw = __ATTR_RW(gmux_selected_port_data);
> +struct device_attribute dev_attr_gmux_selected_port_data_ro = __ATTR_RO(gmux_selected_port_data);
> +
> +static int gmux_init_sysfs(struct pnp_dev *pnp)
> +{
> +	int ret;
> +
> +	ret = device_create_file(&pnp->dev, &dev_attr_gmux_selected_port);
> +	if (ret)
> +		return ret;
> +	if (allow_user_writes)
> +		ret = device_create_file(&pnp->dev, &dev_attr_gmux_selected_port_data_rw);
> +	else
> +		ret = device_create_file(&pnp->dev, &dev_attr_gmux_selected_port_data_ro);
> +	if (ret)
> +		device_remove_file(&pnp->dev, &dev_attr_gmux_selected_port);
> +	return ret;
> +}
> +
> +static void gmux_fini_sysfs(struct pnp_dev *pnp)
> +{
> +	device_remove_file(&pnp->dev, &dev_attr_gmux_selected_port);
> +	if (allow_user_writes)
> +		device_remove_file(&pnp->dev, &dev_attr_gmux_selected_port_data_rw);
> +	else
> +		device_remove_file(&pnp->dev, &dev_attr_gmux_selected_port_data_ro);
> +}
> +
> +#else
> +
> +static int gmux_init_sysfs(struct pnp_dev *pnp)
> +{
> +	return 0;
> +}
> +static void gmux_fini_sysfs(struct pnp_dev *pnp)
> +{
> +}
> +
> +#endif /* CONFIG_SYSFS */
> +
>  static int gmux_suspend(struct device *dev)
>  {
>  	struct pnp_dev *pnp = to_pnp_dev(dev);
> @@ -846,8 +966,16 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
>  		goto err_register_handler;
>  	}
>  
> +	ret = gmux_init_sysfs(pnp);
> +	if (ret) {
> +		pr_err("Failed to register gmux sysfs entries\n");
> +		goto err_sysfs;
> +	}
> +
>  	return 0;
>  
> +err_sysfs:
> +	vga_switcheroo_unregister_handler();
>  err_register_handler:
>  	gmux_disable_interrupts(gmux_data);
>  	apple_gmux_data = NULL;
> @@ -877,6 +1005,7 @@ static void gmux_remove(struct pnp_dev *pnp)
>  {
>  	struct apple_gmux_data *gmux_data = pnp_get_drvdata(pnp);
>  
> +	gmux_fini_sysfs(pnp);
>  	vga_switcheroo_unregister_handler();
>  	gmux_disable_interrupts(gmux_data);
>  	if (gmux_data->gpe >= 0) {

