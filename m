Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0437189F1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 21:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjEaTQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 15:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjEaTQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 15:16:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F610124
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 12:16:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFE0D61532
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:16:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C1FC4339B;
        Wed, 31 May 2023 19:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685560602;
        bh=K6SPdxu8Fblon3ZiS3ptejR3+D6/NaiIx3pau9srpCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XTCuaqu9eVou0NZa5SdabkXplwkGAH1v6RAjoBbtMZz/H2T0cz4RqjSnydScqOC3j
         xIGwPOmH/W/NV0D0UjCGIcvOx99Rm++9ty1nud67mWxE7GsBRD4OVcxHu6lWLnzvDx
         KXCAhsGWxo8wxYtAOjD/thBdQ9U4yvnUER+oSDPE=
Date:   Wed, 31 May 2023 20:16:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] nvmem: core: Expose cells through sysfs
Message-ID: <2023053132-divorcee-aqueduct-70fa@gregkh>
References: <20230530100929.285235-1-miquel.raynal@bootlin.com>
 <20230530100929.285235-3-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530100929.285235-3-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 12:09:29PM +0200, Miquel Raynal wrote:
> The binary content of nvmem devices is available to the user so in the
> easiest cases, finding the content of a cell is rather easy as it is
> just a matter of looking at a known and fixed offset. However, nvmem
> layouts have been recently introduced to cope with more advanced
> situations, where the offset and size of the cells is not known in
> advance or is dynamic. When using layouts, more advanced parsers are
> used by the kernel in order to give direct access to the content of each
> cell, regardless of its position/size in the underlying
> device. Unfortunately, these information are not accessible by users,
> unless by fully re-implementing the parser logic in userland.
> 
> Let's expose the cells and their content through sysfs to avoid these
> situations.
> 
> Exposed cells are read-only. There is, in practice, everything in the
> core to support a write path, but as I don't see any need for that, I
> prefer to keep the interface simple (and probably safer). The interface
> is documented as being in the "testing" state which means we can later
> add a write attribute if though relevant.
> 
> Of course the relevant NVMEM sysfs Kconfig option must be enabled for
> this support to be compiled-in.
> 
> The current implementation leads to the 'cells' folder to be always
> present even when no cell is actually exposed. This is due to a sysfs
> limitation which might in the future be overcome. In order to be as
> close as how sysfs was designed, despite the cells .bin_attrs attribute
> group member being assigned at runtime (and thus, not movable to a RO
> section), we provide a .is_bin_visible hook which might become really
> useful if the series avoiding the creation of empty directories borns.
> 
> There is one limitation though: if a layout is built as a module but is
> not properly installed in the system and loaded manually with insmod
> while the nvmem device driver was built-in, the cells won't appear in
> sysfs. But if done like that, the cells won't be usable by the built-in
> kernel drivers anyway.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/nvmem/core.c | 145 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 141 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 342cd380b420..02b70f065ebc 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -325,6 +325,76 @@ static umode_t nvmem_bin_attr_is_visible(struct kobject *kobj,
>  	return nvmem_bin_attr_get_umode(nvmem);
>  }
>  
> +static struct nvmem_cell *nvmem_create_cell(struct nvmem_cell_entry *entry,
> +					    const char *id, int index);
> +
> +static ssize_t nvmem_cell_attr_read(struct file *filp, struct kobject *kobj,
> +				    struct bin_attribute *attr, char *buf,
> +				    loff_t pos, size_t count)
> +{
> +	struct nvmem_cell_entry *entry;
> +	struct nvmem_cell *cell = NULL;
> +	struct nvmem_device *nvmem;
> +	size_t cell_sz, read_len;
> +	struct device *dev;
> +	void *content;
> +
> +	if (attr->private)
> +		dev = attr->private;
> +	else
> +		dev = kobj_to_dev(kobj);
> +	nvmem = to_nvmem_device(dev);
> +
> +	mutex_lock(&nvmem_mutex);
> +	list_for_each_entry(entry, &nvmem->cells, node) {
> +		if (strncmp(entry->name, attr->attr.name, XATTR_NAME_MAX))
> +			continue;
> +
> +		cell = nvmem_create_cell(entry, entry->name, 0);
> +		if (IS_ERR(cell)) {
> +			mutex_unlock(&nvmem_mutex);
> +			return PTR_ERR(cell);
> +		}
> +
> +		break;
> +	}
> +	mutex_unlock(&nvmem_mutex);
> +
> +	if (!cell)
> +		return -EINVAL;
> +
> +	content = nvmem_cell_read(cell, &cell_sz);
> +	if (IS_ERR(content)) {
> +		read_len = PTR_ERR(content);
> +		goto destroy_cell;
> +	}
> +
> +	read_len = min_t(unsigned int, cell_sz - pos, count);
> +	memcpy(buf, content + pos, read_len);
> +	kfree(content);
> +
> +destroy_cell:
> +	kfree_const(cell->id);
> +	kfree(cell);
> +
> +	return read_len;
> +}
> +
> +static umode_t nvmem_cells_is_visible(struct kobject *kobj,
> +				      struct bin_attribute *attr, int i)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct nvmem_device *nvmem = to_nvmem_device(dev);
> +	umode_t mode = 0444;
> +
> +	mutex_lock(&nvmem_mutex);
> +	if (list_empty(&nvmem->cells))
> +		mode = 0;
> +	mutex_unlock(&nvmem_mutex);

As the list can change right after you have unlocked this, why care
about the locking at all?

But in looking deeper here, is this really even needed?  As you manually
create the attributes in here anyway, the group starts out empty and
then you manually add them, so this should never fail, right?

> +
> +	return mode;
> +}
> +
>  /* default read/write permissions */
>  static struct bin_attribute bin_attr_rw_nvmem = {
>  	.attr	= {
> @@ -346,8 +416,15 @@ static const struct attribute_group nvmem_bin_group = {
>  	.is_bin_visible = nvmem_bin_attr_is_visible,
>  };
>  
> +/* Cell attributes will be dynamically allocated */
> +static struct attribute_group nvmem_cells_group = {
> +	.name		= "cells",
> +	.is_bin_visible = nvmem_cells_is_visible,
> +};
> +
>  static const struct attribute_group *nvmem_dev_groups[] = {
>  	&nvmem_bin_group,
> +	&nvmem_cells_group,
>  	NULL,
>  };
>  
> @@ -406,6 +483,60 @@ static void nvmem_sysfs_remove_compat(struct nvmem_device *nvmem,
>  		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
>  }
>  
> +static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
> +{
> +	struct bin_attribute **cells_attrs, *attrs;
> +	struct nvmem_cell_entry *entry;
> +	unsigned int ncells = 0, i = 0;
> +	int ret = 0;
> +
> +	mutex_lock(&nvmem_mutex);
> +
> +	list_for_each_entry(entry, &nvmem->cells, node)
> +		ncells++;
> +
> +	/* Allocate an array of attributes with a sentinel */
> +	cells_attrs = devm_kcalloc(&nvmem->dev, ncells + 1,
> +				   sizeof(struct bin_attribute *), GFP_KERNEL);
> +	if (!cells_attrs) {
> +		ret = -ENOMEM;
> +		goto unlock_mutex;
> +	}
> +
> +	nvmem_cells_group.bin_attrs = cells_attrs;
> +
> +	/* Without exposed cells, successfully exit after assigning an empty attributes array */
> +	if (!ncells)
> +		goto unlock_mutex;

Shouldn't this check be higher up _before_ you allocate any memory?  If
the attribute group list is empty, nothing should be created, right?  Or
will the driver core crash?

thanks,

greg k-h
