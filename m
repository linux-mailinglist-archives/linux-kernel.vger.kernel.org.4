Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B148169A256
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 00:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjBPX07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 18:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjBPX05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 18:26:57 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C9E2004E;
        Thu, 16 Feb 2023 15:26:28 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id r17so2460188pff.9;
        Thu, 16 Feb 2023 15:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YDkPGh1jeUHdTv/OgQBv1CXTvnen3OvFq+RRBlZd44=;
        b=EG8Ka4PaDKc68MouvuxdqnmANi6gDR9yYqgOn9bGBafrT24UEE5WTNbxBdJCp+5hwb
         AtCFUe77iX0Q6XGnDh8Ux7eIDLz0/i5LdHosbIg7ii11EU8BqEIzL7hzHQakZ+592YXO
         lPCg+UMFW6ocuSUNYnUjURSWeLwfyjx4H3c4Rqhmr6sC5FUXYZKUouGht2uIxajpfh7x
         iQb0ir6qwOuzoTZQfFBhAy+y/ta5dlsX34dIWFPBw09V55nQ+BkH6PyNHpECQ40z6GFR
         LGTyviVIaxFosEKqW9/5xmDwdF5WfxAyfiI//eAhhiIiRWD3epUzJKdjDNh6GuqLX9Tl
         M+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/YDkPGh1jeUHdTv/OgQBv1CXTvnen3OvFq+RRBlZd44=;
        b=rgHflQYVs8k0aQBC1pYq6NsY49aa6uHasmTNpfE7eJCsWKcfIuqI8NcRhcq5pzd8OE
         ESTJQaNCPVwaKgj4i98VVU//+VdGJ6j/8MzrF08P974vQehrAwG9Gz2vmRI3hBFhD9le
         mO/6r+JKPgB4zRxecNGnXLXa7wgjUeHh7mNVLFGE0KpmUBBnBV7AehBdY2GmXN5lhT5s
         UgE5H//Wjfn/LX45kJUMoT/fgb2Axo7XQQAYJIQhs87cxuin3ef91CXx5XciCuYnHcmD
         EJ29BA2YVdygmdZ8N2FROmU/b3fPMZe+PViKYbWkDfc502Dtd5JQQ7LWDYfkQtp3HIxt
         2IlQ==
X-Gm-Message-State: AO0yUKW5yJLoIYCcmITwk1xw3S2TAkHkG5OjLs3AvxU9VjOdzWf0MrsO
        GKdG74ON7ZiW+40+8hFJMrI=
X-Google-Smtp-Source: AK7set8nN64lF1xD4OxrI45AOo3C9uTcQ0o2Hhv8UF7uKzwEdL4wTgHgaaOel2tHQT8DcSknFNoOGg==
X-Received: by 2002:aa7:989a:0:b0:5a8:4883:4213 with SMTP id r26-20020aa7989a000000b005a848834213mr5986024pfl.20.1676589929391;
        Thu, 16 Feb 2023 15:25:29 -0800 (PST)
Received: from redecorated-mbp ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id y26-20020a62b51a000000b00592417157f2sm1825842pfe.148.2023.02.16.15.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 15:25:29 -0800 (PST)
Date:   Fri, 17 Feb 2023 10:25:21 +1100
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Seth Forshee <sforshee@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>
Subject: Re: [PATCH v2 4/5] apple-gmux: support MMIO gmux on T2 Macs
Message-ID: <20230217102521.0f22fbde@redecorated-mbp>
In-Reply-To: <8de35754-4f31-1f4d-3a6b-7a56cb5fe162@redhat.com>
References: <20230216122342.5918-1-orlandoch.dev@gmail.com>
        <20230216122342.5918-5-orlandoch.dev@gmail.com>
        <8de35754-4f31-1f4d-3a6b-7a56cb5fe162@redhat.com>
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

On Thu, 16 Feb 2023 14:15:16 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 2/16/23 13:23, Orlando Chamberlain wrote:
> > In some newer dual gpu MacBooks, gmux is controlled by the T2
> > security chip, and acessed with MMIO. Add support for these gmux
> > controllers
> > 
> > Interestingly, the ACPI table only allocates 8 bytes for GMUX, but
> > we actually need 16, and as such we request 16 with
> > request_mem_region.
> > 
> > Reading and writing from ports:
> >     16 bytes from 0xfe0b0200 are used. 0x0 to 0x4 are where data
> >     to read appears, and where data to write goes. Writing to 0xe
> >     sets the gmux port being accessed, and writing to 0xf sends
> > commands.
> > 
> >     These commands are 0x40 & data_length for write, and
> > data_length for read, where data_length is 1, 2 or 4. Once byte
> > base+0xf is 0, the command is done.
> > 
> > Issues:
> >     As with other retina models, we can't switch DDC lines so
> >     switching at runtime doesn't work if the inactive gpu driver
> >     already disabled eDP due to it not being connected when that
> >     driver loaded.
> > 
> >     Additionally, turning on the dgpu back on the MacBookPro16,1
> > does not work.
> > 
> > Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
> > ---
> > v1->v2: Document some chips present, and clarify which chips aren't
> > present on MMIO gmux laptops.
> >  drivers/platform/x86/apple-gmux.c | 142
> > +++++++++++++++++++++++++++--- include/linux/apple-gmux.h        |
> > 40 ++++++--- 2 files changed, 158 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/apple-gmux.c
> > b/drivers/platform/x86/apple-gmux.c index
> > 12a93fc49c36..5bac6dcfada0 100644 ---
> > a/drivers/platform/x86/apple-gmux.c +++
> > b/drivers/platform/x86/apple-gmux.c @@ -28,15 +28,17 @@
> >   * DOC: Overview
> >   *
> >   * gmux is a microcontroller built into the MacBook Pro to support
> > dual GPUs:
> > - * A `Lattice XP2`_ on pre-retinas, a `Renesas R4F2113`_ on
> > retinas.
> > + * A `Lattice XP2`_ on pre-retinas, a `Renesas R4F2113`_ on pre-T2
> > retinas.
> > + * The chip used on T2 Macs is not known.
> >   *
> >   * (The MacPro6,1 2013 also has a gmux, however it is unclear why
> > since it has
> >   * dual GPUs but no built-in display.)
> >   *
> >   * gmux is connected to the LPC bus of the southbridge. Its I/O
> > ports are
> >   * accessed differently depending on the microcontroller: Driver
> > functions
> > - * to access a pre-retina gmux are infixed ``_pio_``, those for a
> > retina gmux
> > - * are infixed ``_index_``.
> > + * to access a pre-retina gmux are infixed ``_pio_``, those for a
> > pre-T2
> > + * retina gmux are infixed ``_index_``, and those on T2 Macs are
> > infixed
> > + * with ``_mmio_``.
> >   *
> >   * .. _Lattice XP2:
> >   *
> > http://www.latticesemi.com/en/Products/FPGAandCPLD/LatticeXP2.aspx
> > @@ -47,6 +49,7 @@ struct apple_gmux_config;
> >  
> >  struct apple_gmux_data {
> > +	u8 *__iomem iomem_base;
> >  	unsigned long iostart;
> >  	unsigned long iolen;
> >  	const struct apple_gmux_config *config;
> > @@ -209,6 +212,79 @@ static void gmux_index_write32(struct
> > apple_gmux_data *gmux_data, int port,
> > mutex_unlock(&gmux_data->index_lock); }
> >  
> > +static int gmux_mmio_wait(struct apple_gmux_data *gmux_data)
> > +{
> > +	int i = 200;
> > +	u8 gwr = ioread8(gmux_data->iomem_base +
> > GMUX_MMIO_COMMAND_SEND); +
> > +	while (i && gwr) {
> > +		gwr = ioread8(gmux_data->iomem_base +
> > GMUX_MMIO_COMMAND_SEND);
> > +		udelay(100);
> > +		i--;
> > +	}
> > +
> > +	return !!i;
> > +}
> > +
> > +static u8 gmux_mmio_read8(struct apple_gmux_data *gmux_data, int
> > port) +{
> > +	u8 val;
> > +
> > +	mutex_lock(&gmux_data->index_lock);
> > +	gmux_mmio_wait(gmux_data);
> > +	iowrite8((port & 0xff), gmux_data->iomem_base +
> > GMUX_MMIO_PORT_SELECT);
> > +	iowrite8(GMUX_MMIO_READ | sizeof(val),
> > +		gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
> > +	gmux_mmio_wait(gmux_data);
> > +	val = ioread8(gmux_data->iomem_base);
> > +	mutex_unlock(&gmux_data->index_lock);
> > +
> > +	return val;
> > +}
> > +
> > +static void gmux_mmio_write8(struct apple_gmux_data *gmux_data,
> > int port,
> > +			      u8 val)
> > +{
> > +	mutex_lock(&gmux_data->index_lock);
> > +	gmux_mmio_wait(gmux_data);
> > +	iowrite8(val, gmux_data->iomem_base);
> > +
> > +	iowrite8(port & 0xff, gmux_data->iomem_base +
> > GMUX_MMIO_PORT_SELECT);
> > +	iowrite8(GMUX_MMIO_WRITE | sizeof(val),
> > +		gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
> > +
> > +	gmux_mmio_wait(gmux_data);
> > +	mutex_unlock(&gmux_data->index_lock);
> > +}
> > +
> > +static u32 gmux_mmio_read32(struct apple_gmux_data *gmux_data, int
> > port) +{
> > +	u32 val;
> > +
> > +	mutex_lock(&gmux_data->index_lock);
> > +	gmux_mmio_wait(gmux_data);
> > +	iowrite8((port & 0xff), gmux_data->iomem_base +
> > GMUX_MMIO_PORT_SELECT);
> > +	iowrite8(GMUX_MMIO_READ | sizeof(val),
> > +		gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
> > +	gmux_mmio_wait(gmux_data);
> > +	val = be32_to_cpu(ioread32(gmux_data->iomem_base));
> > +	mutex_unlock(&gmux_data->index_lock);
> > +
> > +	return val;
> > +}
> > +
> > +static void gmux_mmio_write32(struct apple_gmux_data *gmux_data,
> > int port,
> > +			       u32 val)
> > +{
> > +	mutex_lock(&gmux_data->index_lock);
> > +	iowrite32(cpu_to_be32(val), gmux_data->iomem_base);
> > +	iowrite8(port & 0xff, gmux_data->iomem_base +
> > GMUX_MMIO_PORT_SELECT);
> > +	iowrite8(GMUX_MMIO_WRITE | sizeof(val),
> > +		gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
> > +	gmux_mmio_wait(gmux_data);
> > +	mutex_unlock(&gmux_data->index_lock);
> > +}
> > +
> >  static u8 gmux_read8(struct apple_gmux_data *gmux_data, int port)
> >  {
> >  	return gmux_data->config->read8(gmux_data, port);
> > @@ -237,8 +313,8 @@ static void gmux_write32(struct apple_gmux_data
> > *gmux_data, int port,
> >   * the GPU. On dual GPU MacBook Pros by contrast, either GPU may
> > be suspended
> >   * to conserve energy. Hence the PWM signal needs to be generated
> > by a separate
> >   * backlight driver which is controlled by gmux. The earliest
> > generation
> > - * MBP5 2008/09 uses a `TI LP8543`_ backlight driver. All newer
> > models
> > - * use a `TI LP8545`_.
> > + * MBP5 2008/09 uses a `TI LP8543`_ backlight driver. Newer models
> > + * use a `TI LP8545`_ or a TI LP8548.
> >   *
> >   * .. _TI LP8543: https://www.ti.com/lit/ds/symlink/lp8543.pdf
> >   * .. _TI LP8545: https://www.ti.com/lit/ds/symlink/lp8545.pdf
> > @@ -302,8 +378,8 @@ static const struct backlight_ops gmux_bl_ops =
> > {
> >   * connecting it either to the discrete GPU or the Thunderbolt
> > controller.
> >   * Oddly enough, while the full port is no longer switchable, AUX
> > and HPD
> >   * are still switchable by way of an `NXP CBTL03062`_ (on
> > pre-retinas
> > - * MBP8 2011 and MBP9 2012) or two `TI TS3DS10224`_ (on retinas)
> > under the
> > - * control of gmux. Since the integrated GPU is missing the main
> > link,
> > + * MBP8 2011 and MBP9 2012) or two `TI TS3DS10224`_ (on pre-t2
> > retinas) under
> > + * the control of gmux. Since the integrated GPU is missing the
> > main link,
> >   * external displays appear to it as phantoms which fail to
> > link-train. *
> >   * gmux receives the HPD signal of all display connectors and
> > sends an @@ -506,6 +582,20 @@ static const struct apple_gmux_config
> > apple_gmux_index = { .name = "indexed"
> >  };
> >  
> > +static const struct apple_gmux_config apple_gmux_mmio = {
> > +	.read8 = &gmux_mmio_read8,
> > +	.write8 = &gmux_mmio_write8,
> > +	.read32 = &gmux_mmio_read32,
> > +	.write32 = &gmux_mmio_write32,
> > +	.gmux_handler = &gmux_handler_no_ddc,
> > +	.handler_flags = VGA_SWITCHEROO_NEEDS_EDP_CONFIG,
> > +	.resource_type = IORESOURCE_MEM,
> > +	.read_version_as_u32 = true,
> > +	.use_acpi_gmsp = true,
> > +	.name = "T2"
> > +};
> > +
> > +
> >  /**
> >   * DOC: Interrupt
> >   *
> > @@ -637,6 +727,25 @@ static int gmux_probe(struct pnp_dev *pnp,
> > const struct pnp_device_id *id) pnp_set_drvdata(pnp, gmux_data);
> >  
> >  	switch (type) {
> > +	case APPLE_GMUX_TYPE_MMIO:
> > +		gmux_data->config = &apple_gmux_mmio;
> > +		mutex_init(&gmux_data->index_lock);
> > +
> > +		res = pnp_get_resource(pnp, IORESOURCE_MEM, 0);
> > +		gmux_data->iostart = res->start;
> > +		/* Although the ACPI table only allocates 8 bytes,
> > we need 16. */
> > +		gmux_data->iolen = 16;
> > +		if (!request_mem_region(gmux_data->iostart,
> > gmux_data->iolen,
> > +					"Apple gmux")) {
> > +			pr_err("gmux I/O already in use\n");
> > +			goto err_free;
> > +		}
> > +		gmux_data->iomem_base =
> > ioremap(gmux_data->iostart, gmux_data->iolen);
> > +		if (!gmux_data->iomem_base) {
> > +			pr_err("couldn't remap gmux mmio region");
> > +			goto err_release;
> > +		}
> > +		goto get_version;
> >  	case APPLE_GMUX_TYPE_INDEXED:
> >  		gmux_data->config = &apple_gmux_index;
> >  		mutex_init(&gmux_data->index_lock);
> > @@ -656,6 +765,7 @@ static int gmux_probe(struct pnp_dev *pnp,
> > const struct pnp_device_id *id) goto err_free;
> >  	}
> >  
> > +get_version:
> >  	if (gmux_data->config->read_version_as_u32) {
> >  		version = gmux_read32(gmux_data,
> > GMUX_PORT_VERSION_MAJOR); ver_major = (version >> 24) & 0xff;
> > @@ -686,7 +796,7 @@ static int gmux_probe(struct pnp_dev *pnp,
> > const struct pnp_device_id *id) gmux_data, &gmux_bl_ops, &props);
> >  	if (IS_ERR(bdev)) {
> >  		ret = PTR_ERR(bdev);
> > -		goto err_release;
> > +		goto err_unmap;
> >  	}
> >  
> >  	gmux_data->bdev = bdev;
> > @@ -753,7 +863,7 @@ static int gmux_probe(struct pnp_dev *pnp,
> > const struct pnp_device_id *id) /*
> >  	 * Retina MacBook Pros cannot switch the panel's AUX
> > separately
> >  	 * and need eDP pre-calibration. They are distinguishable
> > from
> > -	 * pre-retinas by having an "indexed" gmux.
> > +	 * pre-retinas by having an "indexed" or "T2" gmux.
> >  	 *
> >  	 * Pre-retina MacBook Pros can switch the panel's DDC
> > separately. */
> > @@ -778,8 +888,14 @@ static int gmux_probe(struct pnp_dev *pnp,
> > const struct pnp_device_id *id) &gmux_notify_handler);
> >  err_notify:
> >  	backlight_device_unregister(bdev);
> > +err_unmap:
> > +	if (gmux_data->iomem_base)
> > +		iounmap(gmux_data->iomem_base);
> >  err_release:
> > -	release_region(gmux_data->iostart, gmux_data->iolen);
> > +	if (gmux_data->config->resource_type == IORESOURCE_MEM)
> > +		release_mem_region(gmux_data->iostart,
> > gmux_data->iolen);
> > +	else
> > +		release_region(gmux_data->iostart,
> > gmux_data->iolen); err_free:
> >  	kfree(gmux_data);
> >  	return ret;
> > @@ -800,7 +916,11 @@ static void gmux_remove(struct pnp_dev *pnp)
> >  
> >  	backlight_device_unregister(gmux_data->bdev);
> >  
> > -	release_region(gmux_data->iostart, gmux_data->iolen);
> > +	if (gmux_data->iomem_base) {
> > +		iounmap(gmux_data->iomem_base);
> > +		release_mem_region(gmux_data->iostart,
> > gmux_data->iolen);
> > +	} else
> > +		release_region(gmux_data->iostart,
> > gmux_data->iolen); apple_gmux_data = NULL;
> >  	kfree(gmux_data);
> >  
> > diff --git a/include/linux/apple-gmux.h b/include/linux/apple-gmux.h
> > index 5f658439f7f8..b7532f26b756 100644
> > --- a/include/linux/apple-gmux.h
> > +++ b/include/linux/apple-gmux.h
> > @@ -34,11 +34,18 @@
> >  #define GMUX_PORT_READ			0xd0
> >  #define GMUX_PORT_WRITE			0xd4
> >  
> > +#define GMUX_MMIO_PORT_SELECT		0x0e
> > +#define GMUX_MMIO_COMMAND_SEND		0x0f
> > +
> > +#define GMUX_MMIO_READ			0x00
> > +#define GMUX_MMIO_WRITE			0x40
> > +
> >  #define GMUX_MIN_IO_LEN
> > (GMUX_PORT_BRIGHTNESS + 4) 
> >  enum apple_gmux_type {
> >  	APPLE_GMUX_TYPE_PIO,
> > -	APPLE_GMUX_TYPE_INDEXED
> > +	APPLE_GMUX_TYPE_INDEXED,
> > +	APPLE_GMUX_TYPE_MMIO
> >  };  
> 
> With my suggested change to patch 2/5 the - + for
> APPLE_GMUX_TYPE_INDEXED will go away because the , is already there.
> Likewise please add a , after APPLE_GMUX_TYPE_MMIO in case we want to
> add more entries in the future.

I've made those changes and will use them in v3.

> 
> Otherwise this patch looks good to me.
> 
> Regards,
> 
> Hans
> 
> 
> >  
> >  #if IS_ENABLED(CONFIG_APPLE_GMUX)
> > @@ -93,19 +100,24 @@ static inline bool apple_gmux_detect(struct
> > pnp_dev *pnp_dev, enum apple_gmux_ty }
> >  
> >  	res = pnp_get_resource(pnp_dev, IORESOURCE_IO, 0);
> > -	if (!res || resource_size(res) < GMUX_MIN_IO_LEN)
> > -		goto out;
> > -
> > -	/*
> > -	 * Invalid version information may indicate either that
> > the gmux
> > -	 * device isn't present or that it's a new one that uses
> > indexed io.
> > -	 */
> > -	ver_major = inb(res->start + GMUX_PORT_VERSION_MAJOR);
> > -	ver_minor = inb(res->start + GMUX_PORT_VERSION_MINOR);
> > -	ver_release = inb(res->start + GMUX_PORT_VERSION_RELEASE);
> > -	if (ver_major == 0xff && ver_minor == 0xff && ver_release
> > == 0xff) {
> > -		if (apple_gmux_is_indexed(res->start))
> > -			type = APPLE_GMUX_TYPE_INDEXED;
> > +	if (res && resource_size(res) >= GMUX_MIN_IO_LEN) {
> > +		/*
> > +		 * Invalid version information may indicate either
> > that the gmux
> > +		 * device isn't present or that it's a new one
> > that uses indexed io.
> > +		 */
> > +		ver_major = inb(res->start +
> > GMUX_PORT_VERSION_MAJOR);
> > +		ver_minor = inb(res->start +
> > GMUX_PORT_VERSION_MINOR);
> > +		ver_release = inb(res->start +
> > GMUX_PORT_VERSION_RELEASE);
> > +		if (ver_major == 0xff && ver_minor == 0xff &&
> > ver_release == 0xff) {
> > +			if (apple_gmux_is_indexed(res->start))
> > +				type = APPLE_GMUX_TYPE_INDEXED;
> > +			else
> > +				goto out;
> > +		}
> > +	} else {
> > +		res = pnp_get_resource(pnp_dev, IORESOURCE_MEM, 0);
> > +		if (res)
> > +			type = APPLE_GMUX_TYPE_MMIO;
> >  		else
> >  			goto out;
> >  	}  
> 

