Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF270719605
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjFAIvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjFAIvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:51:21 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7D89F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 01:51:18 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685609477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aij0dxNSnkPSFxsZp9Idyq4pHH6ncKRFbkXLyxSBtm8=;
        b=ZSCGXA1M5DkFUx58phdUGNJTzLp2X22ctXjxdoPLBRz7A4MjF4OExiabMynMaZReUqqaua
        REguxRt5MOD81mIdx3cATP9WHmjsJnaBIc59gDlW79EgaUTT6RDPfTt16PeUphLqVI7Tp+
        1G3pBgkzsvxUOJA5Zr4q94eumLl14cdgkjFNLjC+y0PwIxA3VzyRP/Ryfy/Ye5RW46Q9yf
        HVB2F2aOf4W7U5Jqj4Us1P3yWRGKZ2wLS/mGm5xR/PfnoV4lPJ6q5mm/9tWxsVH68l9HJO
        mIk/Io+FZmJCfy+2vQexAkbEHvxCBxN5XaMHvsz2B9Ig1b8NrQGP/aNDwiU/Pw==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4DB87240003;
        Thu,  1 Jun 2023 08:51:16 +0000 (UTC)
Date:   Thu, 1 Jun 2023 10:51:14 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] nvmem: core: Expose cells through sysfs
Message-ID: <20230601105114.58749075@xps-13>
In-Reply-To: <2023053132-divorcee-aqueduct-70fa@gregkh>
References: <20230530100929.285235-1-miquel.raynal@bootlin.com>
        <20230530100929.285235-3-miquel.raynal@bootlin.com>
        <2023053132-divorcee-aqueduct-70fa@gregkh>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

gregkh@linuxfoundation.org wrote on Wed, 31 May 2023 20:16:37 +0100:

> On Tue, May 30, 2023 at 12:09:29PM +0200, Miquel Raynal wrote:
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
> > situations.
> >=20
> > Exposed cells are read-only. There is, in practice, everything in the
> > core to support a write path, but as I don't see any need for that, I
> > prefer to keep the interface simple (and probably safer). The interface
> > is documented as being in the "testing" state which means we can later
> > add a write attribute if though relevant.
> >=20
> > Of course the relevant NVMEM sysfs Kconfig option must be enabled for
> > this support to be compiled-in.
> >=20
> > The current implementation leads to the 'cells' folder to be always
> > present even when no cell is actually exposed. This is due to a sysfs
> > limitation which might in the future be overcome. In order to be as
> > close as how sysfs was designed, despite the cells .bin_attrs attribute
> > group member being assigned at runtime (and thus, not movable to a RO
> > section), we provide a .is_bin_visible hook which might become really
> > useful if the series avoiding the creation of empty directories borns.
> >=20
> > There is one limitation though: if a layout is built as a module but is
> > not properly installed in the system and loaded manually with insmod
> > while the nvmem device driver was built-in, the cells won't appear in
> > sysfs. But if done like that, the cells won't be usable by the built-in
> > kernel drivers anyway.
> >=20
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/nvmem/core.c | 145 +++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 141 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > index 342cd380b420..02b70f065ebc 100644
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c
> > @@ -325,6 +325,76 @@ static umode_t nvmem_bin_attr_is_visible(struct ko=
bject *kobj,
> >  	return nvmem_bin_attr_get_umode(nvmem);
> >  }
> > =20
> > +static struct nvmem_cell *nvmem_create_cell(struct nvmem_cell_entry *e=
ntry,
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
> > +		dev =3D attr->private;
> > +	else
> > +		dev =3D kobj_to_dev(kobj);
> > +	nvmem =3D to_nvmem_device(dev);
> > +
> > +	mutex_lock(&nvmem_mutex);
> > +	list_for_each_entry(entry, &nvmem->cells, node) {
> > +		if (strncmp(entry->name, attr->attr.name, XATTR_NAME_MAX))
> > +			continue;
> > +
> > +		cell =3D nvmem_create_cell(entry, entry->name, 0);
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
> > +	read_len =3D min_t(unsigned int, cell_sz - pos, count);
> > +	memcpy(buf, content + pos, read_len);
> > +	kfree(content);
> > +
> > +destroy_cell:
> > +	kfree_const(cell->id);
> > +	kfree(cell);
> > +
> > +	return read_len;
> > +}
> > +
> > +static umode_t nvmem_cells_is_visible(struct kobject *kobj,
> > +				      struct bin_attribute *attr, int i)
> > +{
> > +	struct device *dev =3D kobj_to_dev(kobj);
> > +	struct nvmem_device *nvmem =3D to_nvmem_device(dev);
> > +	umode_t mode =3D 0444;
> > +
> > +	mutex_lock(&nvmem_mutex);
> > +	if (list_empty(&nvmem->cells))
> > +		mode =3D 0;
> > +	mutex_unlock(&nvmem_mutex); =20
>=20
> As the list can change right after you have unlocked this, why care
> about the locking at all?

Just to mimic the existing code which protects this list. I don't think
a race can happen here anyway, the locks are not needed indeed.

>=20
> But in looking deeper here, is this really even needed?  As you manually
> create the attributes in here anyway, the group starts out empty and
> then you manually add them, so this should never fail, right?

Absolutely. I put these lines in the commit log:

"In order to be as close as how sysfs was designed, despite the cells
.bin_attrs attribute group member being assigned at runtime (and thus,
not movable to a RO section), we provide a .is_bin_visible hook which
might become really useful if the series avoiding the creation of empty
directories borns."

It was a try to prepare the future :) But I agree it is not needed,
statically defining the rights is more than enough, so I'll just get
rid of it.

>=20
> > +
> > +	return mode;
> > +}
> > +
> >  /* default read/write permissions */
> >  static struct bin_attribute bin_attr_rw_nvmem =3D {
> >  	.attr	=3D {
> > @@ -346,8 +416,15 @@ static const struct attribute_group
> > nvmem_bin_group =3D { .is_bin_visible =3D nvmem_bin_attr_is_visible,
> >  };
> > =20
> > +/* Cell attributes will be dynamically allocated */
> > +static struct attribute_group nvmem_cells_group =3D {
> > +	.name		=3D "cells",
> > +	.is_bin_visible =3D nvmem_cells_is_visible,
> > +};
> > +
> >  static const struct attribute_group *nvmem_dev_groups[] =3D {
> >  	&nvmem_bin_group,
> > +	&nvmem_cells_group,
> >  	NULL,
> >  };
> > =20
> > @@ -406,6 +483,60 @@ static void nvmem_sysfs_remove_compat(struct
> > nvmem_device *nvmem, device_remove_bin_file(nvmem->base_dev,
> > &nvmem->eeprom); }
> > =20
> > +static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
> > +{
> > +	struct bin_attribute **cells_attrs, *attrs;
> > +	struct nvmem_cell_entry *entry;
> > +	unsigned int ncells =3D 0, i =3D 0;
> > +	int ret =3D 0;
> > +
> > +	mutex_lock(&nvmem_mutex);
> > +
> > +	list_for_each_entry(entry, &nvmem->cells, node)
> > +		ncells++;
> > +
> > +	/* Allocate an array of attributes with a sentinel */
> > +	cells_attrs =3D devm_kcalloc(&nvmem->dev, ncells + 1,
> > +				   sizeof(struct bin_attribute *),
> > GFP_KERNEL);
> > +	if (!cells_attrs) {
> > +		ret =3D -ENOMEM;
> > +		goto unlock_mutex;
> > +	}
> > +
> > +	nvmem_cells_group.bin_attrs =3D cells_attrs;
> > +
> > +	/* Without exposed cells, successfully exit after
> > assigning an empty attributes array */
> > +	if (!ncells)
> > +		goto unlock_mutex; =20
>=20
> Shouldn't this check be higher up _before_ you allocate any memory?
> If the attribute group list is empty, nothing should be created,
> right?  Or will the driver core crash?

As you rightfully guessed it, the core will crash if no list is
provided at all. I need to provide an empty list with just an empty
member and everything goes smoothly.=20

Thanks,
Miqu=C3=A8l
