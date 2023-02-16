Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82E169A261
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 00:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjBPX3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 18:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjBPX3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 18:29:08 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5E91350B;
        Thu, 16 Feb 2023 15:28:29 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id e1so2239779pgg.9;
        Thu, 16 Feb 2023 15:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlQPnA6noQGF9WD++72QdNY+nDbHwFvnyUuHecqfnlU=;
        b=NX/BDMXJ83hPdJloZFdsY5hoP46cWRHmi0g3W9Dz3l8CcerrE9e/fj2G9R93E7v/1t
         XPvWHV92BffFsdwM3Jp5SzPmZCinNNntG6fqkgB4fC/VillAGNLJqFehbkc/j4GjIWhF
         s9JPWITk+/tMOgWuwHkPNgh+VJUoLyryBXbmFOWZ7IcJ3YrxDqOEz5yVUy2Epg1vwltk
         ET1OmKpZBsQl6tKqLgFG9Lf7dw89/9BLpiROBloOc6zVIbT6ZWfYheCl/2JpXM0M30FR
         5arZALTnZ94tCd5PC+OWBvuPonwWT6Ty8678WyXz9RBzXv/bHYIDGmIBszJt+XNWLW4L
         gzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PlQPnA6noQGF9WD++72QdNY+nDbHwFvnyUuHecqfnlU=;
        b=te5B7f34EuW8JjcYqP70nbWZK7geAQ2OGtjqO1DcgIBbXaDdFDnrIunDummcqTDicq
         DR29tnuwMvFhFa2g2qF9K/VCnFZM/JWgsMB6dDLoN+xwkvy6DrxF5Dw9GcDRMdi9cz4U
         uI9Mfl2IJSDXWE+/0Ty41lwjzoXq0GgKAskmw7UYO1EXKFcooSfQ2Zrzzo9BdGx3YvcJ
         r6JJOTkNcm6E0UUPj8E7ec83kXNBQBAIyQQof41nUh87bfUmjejE2PbMxEft6ewVJYy1
         HSmGPO3kz6IU7l/tS49F+8yUIOff1owQ0/Ygpb0eE9kUTidaQ/Y1S43iK1q9Teli4nNJ
         2/+A==
X-Gm-Message-State: AO0yUKXLWMTB4TOOb+bm4W2x5In0u85ambrzWv8ETbBAz0gVEjFmZ4Sj
        8xDINZqA0P9pFVrKPEckDUk=
X-Google-Smtp-Source: AK7set+Rmc8hAU0M5NxAa8ytHcGb7SmzWXH1nLqVqTHSe7isXNmDRBJ6gSow0GhDSz1oyuQa9YMsyA==
X-Received: by 2002:a05:6a00:348d:b0:5a8:ac15:534d with SMTP id cp13-20020a056a00348d00b005a8ac15534dmr3357829pfb.13.1676590104706;
        Thu, 16 Feb 2023 15:28:24 -0800 (PST)
Received: from redecorated-mbp ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id j26-20020a62b61a000000b00592626fe48csm1808397pff.122.2023.02.16.15.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 15:28:24 -0800 (PST)
Date:   Fri, 17 Feb 2023 10:28:16 +1100
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Seth Forshee <sforshee@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>
Subject: Re: [PATCH v2 5/5] apple-gmux: add debugfs interface
Message-ID: <20230217102816.728dc1c3@redecorated-mbp>
In-Reply-To: <0a58bf19-d943-b8c6-a882-7209d0543823@redhat.com>
References: <20230216122342.5918-1-orlandoch.dev@gmail.com>
        <20230216122342.5918-6-orlandoch.dev@gmail.com>
        <0a58bf19-d943-b8c6-a882-7209d0543823@redhat.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2023 14:20:27 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 2/16/23 13:23, Orlando Chamberlain wrote:
> > Allow reading and writing gmux ports from userspace.
> > 
> > For example:
> > 
> > echo 4 > /sys/kernel/debug/apple_gmux/selected_port
> > cat /sys/kernel/debug/apple_gmux/selected_port_data | xxd -p
> > 
> > Will show the gmux version information (00000005 in this case)
> > 
> > Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
> > ---
> > v1->v2: Use debugfs instead of sysfs.
> >  drivers/platform/x86/apple-gmux.c | 88
> > +++++++++++++++++++++++++++++++ 1 file changed, 88 insertions(+)
> > 
> > diff --git a/drivers/platform/x86/apple-gmux.c
> > b/drivers/platform/x86/apple-gmux.c index
> > 5bac6dcfada0..e8a35d98b113 100644 ---
> > a/drivers/platform/x86/apple-gmux.c +++
> > b/drivers/platform/x86/apple-gmux.c @@ -22,6 +22,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/pci.h>
> >  #include <linux/vga_switcheroo.h>
> > +#include <linux/debugfs.h>
> >  #include <asm/io.h>
> >  
> >  /**
> > @@ -66,6 +67,10 @@ struct apple_gmux_data {
> >  	enum vga_switcheroo_client_id switch_state_external;
> >  	enum vga_switcheroo_state power_state;
> >  	struct completion powerchange_done;
> > +
> > +	/* debugfs data */
> > +	u8 selected_port;
> > +	struct dentry *debug_dentry;
> >  };
> >  
> >  static struct apple_gmux_data *apple_gmux_data;
> > @@ -674,6 +679,87 @@ static void gmux_notify_handler(acpi_handle
> > device, u32 value, void *context)
> > complete(&gmux_data->powerchange_done); }
> >  
> > +/**
> > + * DOC: Debugfs Interface
> > + *
> > + * gmux ports can be accessed from userspace as a debugfs
> > interface. For example:
> > + *
> > + * # echo 4 > /sys/kernel/debug/apple_gmux/selected_port
> > + * # cat /sys/kernel/debug/apple_gmux/selected_port_data | xxd -p
> > + * 00000005
> > + *
> > + * Reads 4 bytes from port 4 (GMUX_PORT_VERSION_MAJOR).
> > + *
> > + * 1 and 4 byte writes are also allowed.
> > + */
> > +
> > +static ssize_t gmux_selected_port_data_write(struct file *file,
> > +		const char __user *userbuf, size_t count, loff_t
> > *ppos) +{
> > +	struct apple_gmux_data *gmux_data = file->private_data;
> > +	int ret;
> > +
> > +	if (*ppos)
> > +		return -EINVAL;
> > +
> > +	if (count == 1) {
> > +		u8 data;
> > +
> > +		ret = copy_from_user(&data, userbuf, 1);
> > +		if (ret)
> > +			return ret;
> > +		gmux_write8(gmux_data, gmux_data->selected_port,
> > data);
> > +	} else if (count == 4) {
> > +		u32 data;
> > +
> > +		ret = copy_from_user(&data, userbuf, 4);
> > +		if (ret)
> > +			return ret;
> > +		gmux_write32(gmux_data, gmux_data->selected_port,
> > data);
> > +	} else
> > +		return -EINVAL;
> > +
> > +	return count;
> > +}
> > +
> > +static ssize_t gmux_selected_port_data_read(struct file *file,
> > +		char __user *userbuf, size_t count, loff_t *ppos)
> > +{
> > +	struct apple_gmux_data *gmux_data = file->private_data;
> > +	u32 data;
> > +
> > +	data = gmux_read32(gmux_data, gmux_data->selected_port);
> > +
> > +	return simple_read_from_buffer(userbuf, count, ppos,
> > &data, sizeof(data)); +}
> > +
> > +static const struct file_operations gmux_port_data_ops = {
> > +	.open = simple_open,
> > +	.write = gmux_selected_port_data_write,
> > +	.read = gmux_selected_port_data_read
> > +};
> > +
> > +static void gmux_init_debugfs(struct apple_gmux_data *gmux_data)
> > +{
> > +	struct dentry *debug_dentry;
> > +
> > +	debug_dentry = debugfs_create_dir(KBUILD_MODNAME, NULL);
> > +
> > +	if (IS_ERR(debug_dentry))
> > +		return;  
> 
> This error check is not necessary here. The debugfs_create_*
> and debugfs_remove_recursive() functions will happily take
> the ERR_PTR value and ignore it.
> 
> This is what I tried to say when I said that no error handling
> is necessary with debugfs (by design).
> 

I see, I'll simplify it to not check that in v3.

> Regards,
> 
> Hans
> 
> 
> > +
> > +	gmux_data->debug_dentry = debug_dentry;
> > +
> > +	debugfs_create_u8("selected_port", 0644, debug_dentry,
> > &gmux_data->selected_port);
> > +	debugfs_create_file("selected_port_data", 0644,
> > debug_dentry,
> > +			gmux_data, &gmux_port_data_ops);
> > +}
> > +
> > +static void gmux_fini_debugfs(struct apple_gmux_data *gmux_data)
> > +{
> > +	debugfs_remove_recursive(gmux_data->debug_dentry);
> > +}
> > +
> >  static int gmux_suspend(struct device *dev)
> >  {
> >  	struct pnp_dev *pnp = to_pnp_dev(dev);
> > @@ -874,6 +960,7 @@ static int gmux_probe(struct pnp_dev *pnp,
> > const struct pnp_device_id *id) goto err_register_handler;
> >  	}
> >  
> > +	gmux_init_debugfs(gmux_data);
> >  	return 0;
> >  
> >  err_register_handler:
> > @@ -905,6 +992,7 @@ static void gmux_remove(struct pnp_dev *pnp)
> >  {
> >  	struct apple_gmux_data *gmux_data = pnp_get_drvdata(pnp);
> >  
> > +	gmux_fini_debugfs(gmux_data);
> >  	vga_switcheroo_unregister_handler();
> >  	gmux_disable_interrupts(gmux_data);
> >  	if (gmux_data->gpe >= 0) {  
> 

