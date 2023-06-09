Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB186729F9B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242048AbjFIQFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241710AbjFIQFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:05:16 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77C926B9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:05:14 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686326713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fjsZ04y6hc5zJ9QRVXOl+odp216CYZq3tOMIcqTyFms=;
        b=N6hiHM9/2QSLdX35l32mJoDcGMUES0Ml2Q2uhvMas38wJQ/HExi6+Tu6TYEhWPIyZMlmV+
        6njvaLcgfG7diux2mPptAALrY8hRvKFRezX0ko/NPymRgPwWaN2czmAO7wXpSQPIyIhW2P
        O7JaA4r+KGSqMtP4uiKko7hWQumHJMVQpn31aQmKcrhdp3aSONOxw8B6zgiz+CVE4aDmZv
        npFX+STvw06wCe0fvh5mOanm08bIWO7E9QcdpFmxBE2QGXSGZW/3/pKiA7S52naEv3I9iP
        VbJ0J3a3c43NZvlmGTDr+x33/1JTNFL2fuhdFMgRxrBIrSLAa0QRcUz4k0iGyQ==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AF1D6C000B;
        Fri,  9 Jun 2023 16:05:12 +0000 (UTC)
Date:   Fri, 9 Jun 2023 18:05:10 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org, Rafael J Wysocki <rafael@kernel.org>
Subject: Re: [PATCH v3 4/4] nvmem: core: Expose cells through sysfs
Message-ID: <20230609180510.707860a0@xps-13>
In-Reply-To: <20aa1fc7-3844-a565-03a2-e2d8ce6055d5@linaro.org>
References: <20230605133422.45840-1-miquel.raynal@bootlin.com>
        <20230605133422.45840-5-miquel.raynal@bootlin.com>
        <20aa1fc7-3844-a565-03a2-e2d8ce6055d5@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

srinivas.kandagatla@linaro.org wrote on Tue, 6 Jun 2023 11:31:07 +0100:

> Thanks for doing this Miquel

Great, I'm glad you like the idea :)

>=20
> Few minor comments below.
>=20
> On 05/06/2023 14:34, Miquel Raynal wrote:
> > The binary content of nvmem devices is available to the user so in the
> > easiest cases, finding the content of a cell is rather easy as it is
> > just a matter of looking at a known and fixed offset. However, nvmem
> > layouts have been recently introduced to cope with more advanced
> > situations, where the offset and size of the cells is not known in
> > advance or is dynamic. When using layouts, more advanced parsers are
> > used by the kernel in order to give direct access to the content of each
> > cell, regardless of its position/size in the underlying
> > device. Unfortunately, these information are not accessible by users,
> > unless by fully re-implementing the parser logic in userland.
> >=20
> > Let's expose the cells and their content through sysfs to avoid these
> > situations. Of course the relevant NVMEM sysfs Kconfig option must be
> > enabled for this support to be available.
> >=20
> > Not all nvmem devices expose cells. Indeed, the .bin_attrs attribute
> > group member will be filled at runtime only when relevant and will
> > remain empty otherwise. In this case, as the cells attribute group will
> > be empty, it will not lead to any additional folder/file creation.
> >=20
> > Exposed cells are read-only. There is, in practice, everything in the
> > core to support a write path, but as I don't see any need for that, I
> > prefer to keep the interface simple (and probably safer). The interface
> > is documented as being in the "testing" state which means we can later
> > add a write attribute if though relevant.
> >=20
> > There is one limitation though: if a layout is built as a module but is
> > not properly installed in the system and loaded manually with insmod
> > while the nvmem device driver was built-in, the cells won't appear in
> > sysfs. But if done like that, the cells won't be usable by the built-in
> > kernel drivers anyway.
> >=20
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >   drivers/nvmem/core.c | 128 +++++++++++++++++++++++++++++++++++++++++--
> >   1 file changed, 124 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > index 342cd380b420..625e3de273b7 100644
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c
> > @@ -325,6 +325,61 @@ static umode_t nvmem_bin_attr_is_visible(struct ko=
bject *kobj,
> >   	return nvmem_bin_attr_get_umode(nvmem);
> >   } =20
> >   > +static struct nvmem_cell *nvmem_create_cell(struct nvmem_cell_entr=
y *entry, =20
> > +					    const char *id, int index);
> > +
> > +static ssize_t nvmem_cell_attr_read(struct file *filp, struct kobject =
*kobj,
> > +				    struct bin_attribute *attr, char *buf,
> > +				    loff_t pos, size_t count)
> > +{
> > +	struct nvmem_cell_entry *entry;
> > +	struct nvmem_cell *cell =3D NULL;
> > +	struct nvmem_device *nvmem;
> > +	size_t cell_sz, read_len;
> > +	struct device *dev;
> > +	void *content;
> > +
> > +	if (attr->private)
> > +		dev =3D attr->private; =20
> I see no point in this, as we do not set any private data for this attrib=
ute.
>=20
> How about storing nvmem_cell_entry in private and using it here.
> This should also avoid looping for every cell in the follow on code.

Mmmh, excellent idea, that will simplify a lot the helper, I'll do
that, thanks a lot for the suggestion!

>=20
> > +	else
> > +		dev =3D kobj_to_dev(kobj); =20
>=20
> new line here.
>=20
> > +	nvmem =3D to_nvmem_device(dev);
> > +
> > +	mutex_lock(&nvmem_mutex);
> > +	list_for_each_entry(entry, &nvmem->cells, node) {
> > +		if (strncmp(entry->name, attr->attr.name, XATTR_NAME_MAX))
> > +			continue;
> > +
> > +		cell =3D nvmem_create_cell(entry, entry->name, 0); =20
>=20
> > +		if (IS_ERR(cell)) {
> > +			mutex_unlock(&nvmem_mutex);
> > +			return PTR_ERR(cell);
> > +		}
> > +
> > +		break;
> > +	}
> > +	mutex_unlock(&nvmem_mutex);
> > +
> > +	if (!cell)
> > +		return -EINVAL;
> > +
> > +	content =3D nvmem_cell_read(cell, &cell_sz);
> > +	if (IS_ERR(content)) {
> > +		read_len =3D PTR_ERR(content);
> > +		goto destroy_cell;
> > +	}
> > +
> > +	read_len =3D min_t(unsigned int, cell_sz - pos, count); > +	memcpy(bu=
f, content + pos, read_len);
> > +	kfree(content);
> > +
> > +destroy_cell:
> > +	kfree_const(cell->id);
> > +	kfree(cell);
> > +
> > +	return read_len;
> > +}
> > +
> >   /* default read/write permissions */
> >   static struct bin_attribute bin_attr_rw_nvmem =3D {
> >   	.attr	=3D {
> > @@ -346,8 +401,14 @@ static const struct attribute_group nvmem_bin_grou=
p =3D {
> >   	.is_bin_visible =3D nvmem_bin_attr_is_visible,
> >   }; =20
> >   > +/* Cell attributes will be dynamically allocated */ =20
> > +static struct attribute_group nvmem_cells_group =3D {
> > +	.name		=3D "cells",
> > +};
> > +
> >   static const struct attribute_group *nvmem_dev_groups[] =3D {
> >   	&nvmem_bin_group,
> > +	&nvmem_cells_group,
> >   	NULL,
> >   }; =20
> >   > @@ -406,6 +467,59 @@ static void nvmem_sysfs_remove_compat(struct n=
vmem_device *nvmem, =20
> >   		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
> >   } =20
> >   > +static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem) =
=20
> > +{
> > +	struct bin_attribute **cells_attrs, *attrs;
> > +	struct nvmem_cell_entry *entry;
> > +	unsigned int ncells =3D 0, i =3D 0;
> > +	int ret =3D 0;
> > +
> > +	mutex_lock(&nvmem_mutex);
> > +
> > +	if (list_empty(&nvmem->cells))
> > +		goto unlock_mutex;
> > +
> > +	list_for_each_entry(entry, &nvmem->cells, node)
> > +		ncells++; =20
>=20
> list_count_nodes?

I didn't even know about this macro. Of course I'll use it!

> > +
> > +	/* Allocate an array of attributes with a sentinel */
> > +	cells_attrs =3D devm_kcalloc(&nvmem->dev, ncells + 1,
> > +				   sizeof(struct bin_attribute *), GFP_KERNEL);
> > +	if (!cells_attrs) {
> > +		ret =3D -ENOMEM;
> > +		goto unlock_mutex;
> > +	}
> > +
> > +	attrs =3D devm_kcalloc(&nvmem->dev, ncells, sizeof(struct bin_attribu=
te), GFP_KERNEL);
> > +	if (!attrs) {
> > +		ret =3D -ENOMEM;
> > +		goto unlock_mutex;
> > +	}
> > +
> > +	/* Initialize each attribute to take the name and size of the cell */
> > +	list_for_each_entry(entry, &nvmem->cells, node) {
> > +		sysfs_bin_attr_init(&attrs[i]);
> > +		attrs[i].attr.name =3D devm_kstrdup(&nvmem->dev, entry->name, GFP_KE=
RNEL);
> > +		attrs[i].attr.mode =3D 0444;
> > +		attrs[i].size =3D entry->bytes;
> > +		attrs[i].read =3D &nvmem_cell_attr_read;
> > +		if (!attrs[i].attr.name) {
> > +			ret =3D -ENOMEM;
> > +			goto unlock_mutex;
> > +		}
> > +
> > +		cells_attrs[i] =3D &attrs[i];
> > +		i++;
> > +	}
> > +
> > +	nvmem_cells_group.bin_attrs =3D cells_attrs;
> > +
> > +unlock_mutex:
> > +	mutex_unlock(&nvmem_mutex);
> > +
> > +	return ret;
> > +}
> > +
> >   #else /* CONFIG_NVMEM_SYSFS */ =20
> >   >   static int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem, =
=20
> > @@ -976,16 +1090,22 @@ struct nvmem_device *nvmem_register(const struct=
 nvmem_config *config)
> >   	if (rval)
> >   		goto err_remove_cells; =20
> >   > +	rval =3D nvmem_add_cells_from_layout(nvmem); =20
> > +	if (rval)
> > +		goto err_remove_cells;
> > +
> > +#ifdef CONFIG_NVMEM_SYSFS
> > +	rval =3D nvmem_populate_sysfs_cells(nvmem);
> > +	if (rval)
> > +		goto err_remove_cells;
> > +#endif
> > +
> >   	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);=
 =20
> >   >   	rval =3D device_add(&nvmem->dev); =20
> >   	if (rval)
> >   		goto err_remove_cells; =20
> >   > -	rval =3D nvmem_add_cells_from_layout(nvmem); =20
> > -	if (rval)
> > -		goto err_remove_cells;
> > -
> >   	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem); =20
> >   >   	return nvmem; =20


Thanks,
Miqu=C3=A8l
