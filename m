Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBF7694AFE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjBMPXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjBMPXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:23:20 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958CC13D58
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:23:11 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id d2so12223321pjd.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9obGSHJL1jP8Gz5Kbja6klYurFoCmsJVYRk2S1vme9o=;
        b=eie3aBv1kf9buidJAGpA6sjCUIspKM3onHNjyA3f+XMBsaiyyUh+ez6iOqtEj/wtIZ
         9HNAuexGDa8/GC28zBv4NlEjiFFtGteGZuCGW32sdX4szU1e3cY32JiCqZA+vM7+hlmM
         soLyT5ta/pCQQUgNsQ0M0EGpqUCixLpzwfEEwgTlgWMesYaHmEf1p7vCRecs+gmeTLaX
         CwVQ3ZiJHuNOKsHsP5KqD4kmRIMfJVKYyz+tBw771oSDw9ROyggzKXLGY8C1r/J8LWNs
         MB8hhp6nwjqcDdRr6iA8kvd5MGao6qygP2exDTg6IgKDEVukRKQN0AgTuIyhGE5fAEfF
         WObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9obGSHJL1jP8Gz5Kbja6klYurFoCmsJVYRk2S1vme9o=;
        b=DSW896hvcM2DtMXCkoJ3cZbMKawLGZQuQd0AM5Whpl0vK8kwlYHhyBYMImAr2qUB4q
         ZVKBCTH72MQRW2cEvB9XqlOaodCN9tVjCYA9ElnWY+nrC3oPD5YysxozzI160TkxzXQl
         5pPtmrA4L/106nKc/7ekmEZze9D/5ujppvlmtPgdyCxOOh793gIWTOR91pcRoPGOqtof
         nLef51bjwOySVqlrLSwqsqM36E1mkxrskGOqOwQ9aLPwfMkb7jZw99T/PNIc51uWp0zN
         72IZRXjogvsvxGklxtVgInZLF9vRYl7nLOLdWDE0YkhSogzGb50ykkulbObWJYTQCsbS
         ziMg==
X-Gm-Message-State: AO0yUKXPvMGeGntcQYLKLqjU0Fsl4TReB57c7cSxpaiGo7Vb6cW8f1Jv
        e1LyCD4YvSUGDk/vzhk9SJ1I5w==
X-Google-Smtp-Source: AK7set8Rza+nET49jhPHmTTBGt8AkRlUlcToHz5dQzC5MrTSlKyoWJUrwmupMo9PQo0vP9FvMR9CNA==
X-Received: by 2002:a17:902:ce88:b0:19a:8304:21f1 with SMTP id f8-20020a170902ce8800b0019a830421f1mr9743420plg.69.1676301791021;
        Mon, 13 Feb 2023 07:23:11 -0800 (PST)
Received: from sunil-laptop ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id jn9-20020a170903050900b0018963b8e131sm8318234plb.290.2023.02.13.07.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 07:23:10 -0800 (PST)
Date:   Mon, 13 Feb 2023 20:53:01 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH 06/24] RISC-V: ACPI: Add PCI functions to build ACPI core
Message-ID: <Y+pV1aafHUNP6QfU@sunil-laptop>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <20230130182225.2471414-7-sunilvl@ventanamicro.com>
 <Y+QToXO2kYQ2ipdz@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+QToXO2kYQ2ipdz@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 09:26:57PM +0000, Conor Dooley wrote:
> On Mon, Jan 30, 2023 at 11:52:07PM +0530, Sunil V L wrote:
> > When CONFIG_PCI is enabled, ACPI core expects few arch
> > functions related to PCI. Add those functions so that
> > ACPI core gets build. These are levraged from arm64.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  arch/riscv/kernel/Makefile |   1 +
> >  arch/riscv/kernel/pci.c    | 173 +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 174 insertions(+)
> >  create mode 100644 arch/riscv/kernel/pci.c
> 
> > diff --git a/arch/riscv/kernel/pci.c b/arch/riscv/kernel/pci.c
> > new file mode 100644
> > index 000000000000..3388af3a67a0
> > --- /dev/null
> > +++ b/arch/riscv/kernel/pci.c
> > @@ -0,0 +1,173 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Code borrowed from ARM64
> > + *
> > + * Copyright (C) 2003 Anton Blanchard <anton@au.ibm.com>, IBM
> > + * Copyright (C) 2014 ARM Ltd.
> > + * Copyright (C) 2022-2023 Ventana Micro System Inc.
> > + */
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/init.h>
> > +#include <linux/io.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mm.h>
> > +#include <linux/pci.h>
> > +#include <linux/pci-acpi.h>
> > +#include <linux/pci-ecam.h>
> > +
> > +#ifdef CONFIG_ACPI
> 
> Quickly checking against ARM64, they do not wrap the read/write
> functions in this ifdef, so why do we need to do so?
> 
I didn't find any callers other than ACPI. But let me keep them outside so
that we are consistent.

> > +/*
> > + * raw_pci_read/write - Platform-specific PCI config space access.
> > + */
> > +int raw_pci_read(unsigned int domain, unsigned int bus,
> > +		  unsigned int devfn, int reg, int len, u32 *val)
> > +{
> > +	struct pci_bus *b = pci_find_bus(domain, bus);
> > +
> > +	if (!b)
> > +		return PCIBIOS_DEVICE_NOT_FOUND;
> > +	return b->ops->read(b, devfn, reg, len, val);
> 
> A newline before the return would be appreciated by my eyes :)
> 
Okay.

> > +}
> > +
> > +int raw_pci_write(unsigned int domain, unsigned int bus,
> > +		unsigned int devfn, int reg, int len, u32 val)
> 
> Also, both read and write functions here appear to have incorrect
> alignment on the second lines.
> 
Okay.

> > +{
> > +	struct pci_bus *b = pci_find_bus(domain, bus);
> > +
> > +	if (!b)
> > +		return PCIBIOS_DEVICE_NOT_FOUND;
> > +	return b->ops->write(b, devfn, reg, len, val);
> > +}
> > +
> > +
> 
> Extra newline here too, looks to be exactly where you deleted the numa
> stuff from arm64 ;)
> 
Okay.

> > +struct acpi_pci_generic_root_info {
> > +	struct acpi_pci_root_info	common;
> > +	struct pci_config_window	*cfg;	/* config space mapping */
> > +};
> > +
> > +int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
> > +{
> > +	struct pci_config_window *cfg = bus->sysdata;
> > +	struct acpi_device *adev = to_acpi_device(cfg->parent);
> > +	struct acpi_pci_root *root = acpi_driver_data(adev);
> > +
> > +	return root->segment;
> > +}
> > +
> > +static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
> 
> Rhetorical question perhaps, but what does "ci" mean?
>
I don't know either :-). I guess since there is one more generic
ri, this is named as ci.

> > +{
> > +	struct resource_entry *entry, *tmp;
> > +	int status;
> > +
> > +	status = acpi_pci_probe_root_resources(ci);
> > +	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
> > +		if (!(entry->res->flags & IORESOURCE_WINDOW))
> > +			resource_list_destroy_entry(entry);
> > +	}
> > +	return status;
> 
> Perhaps that extra newline from above could migrate down to the line
> above the return here.
>
Okay.

> > +}
> > +
> > +/*
> > + * Lookup the bus range for the domain in MCFG, and set up config space
> > + * mapping.
> > + */
> > +static struct pci_config_window *
> > +pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
> 
> This all fits on 1 line.
> 
It actually goes beyond 80 characters, right?

> > +{
> > +	struct device *dev = &root->device->dev;
> > +	struct resource *bus_res = &root->secondary;
> > +	u16 seg = root->segment;
> > +	const struct pci_ecam_ops *ecam_ops;
> > +	struct resource cfgres;
> > +	struct acpi_device *adev;
> > +	struct pci_config_window *cfg;
> > +	int ret;
> > +
> > +	ret = pci_mcfg_lookup(root, &cfgres, &ecam_ops);
> > +	if (ret) {
> > +		dev_err(dev, "%04x:%pR ECAM region not found\n", seg, bus_res);
> > +		return NULL;
> > +	}
> > +
> > +	adev = acpi_resource_consumer(&cfgres);
> > +	if (adev)
> > +		dev_info(dev, "ECAM area %pR reserved by %s\n", &cfgres,
> > +			 dev_name(&adev->dev));
> > +	else
> > +		dev_warn(dev, FW_BUG "ECAM area %pR not reserved in ACPI namespace\n",
> > +			 &cfgres);
> > +
> > +	cfg = pci_ecam_create(dev, &cfgres, bus_res, ecam_ops);
> > +	if (IS_ERR(cfg)) {
> > +		dev_err(dev, "%04x:%pR error %ld mapping ECAM\n", seg, bus_res,
> > +			PTR_ERR(cfg));
> > +		return NULL;
> > +	}
> > +
> > +	return cfg;
> > +}
> > +
> > +/* release_info: free resources allocated by init_info */
> 
> The fact that you haven't picked a consistent comment style for this
> functions really bothers my OCD. Yes, it may be copy-paste from arm64,
> but since this is "new code" I don't think there's harm in at least
> *starting* with something that looks cohesive.
> 
Agree. Will try to fix them in the next revision.

> > +static void pci_acpi_generic_release_info(struct acpi_pci_root_info *ci)
> > +{
> > +	struct acpi_pci_generic_root_info *ri;
> > +
> > +	ri = container_of(ci, struct acpi_pci_generic_root_info, common);
> > +	pci_ecam_free(ri->cfg);
> > +	kfree(ci->ops);
> > +	kfree(ri);
> > +}
> > +
> > +
> 
> Extra newline here.
>
Okay.
 
> > +/* Interface called from ACPI code to setup PCI host controller */
> > +struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
> > +{
> > +	struct acpi_pci_generic_root_info *ri;
> > +	struct pci_bus *bus, *child;
> > +	struct acpi_pci_root_ops *root_ops;
> > +	struct pci_host_bridge *host;
> > +
> > +	ri = kzalloc(sizeof(*ri), GFP_KERNEL);
> > +	if (!ri)
> > +		return NULL;
> > +
> > +	root_ops = kzalloc(sizeof(*root_ops), GFP_KERNEL);
> > +	if (!root_ops) {
> > +		kfree(ri);
> > +		return NULL;
> > +	}
> > +
> > +	ri->cfg = pci_acpi_setup_ecam_mapping(root);
> > +	if (!ri->cfg) {
> > +		kfree(ri);
> > +		kfree(root_ops);
> > +		return NULL;
> > +	}
> > +
> > +	root_ops->release_info = pci_acpi_generic_release_info;
> > +	root_ops->prepare_resources = pci_acpi_root_prepare_resources;
> > +	root_ops->pci_ops = (struct pci_ops *)&ri->cfg->ops->pci_ops;
> > +	bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
> > +	if (!bus)
> > +		return NULL;
> > +
> > +	/* If we must preserve the resource configuration, claim now */
> > +	host = pci_find_host_bridge(bus);
> > +	if (host->preserve_config)
> > +		pci_bus_claim_resources(bus);
> > +
> > +	/*
> > +	 * Assign whatever was left unassigned. If we didn't claim above,
> > +	 * this will reassign everything.
> > +	 */
> > +	pci_assign_unassigned_root_bus_resources(bus);
> > +
> > +	list_for_each_entry(child, &bus->children, node)
> > +		pcie_bus_configure_settings(child);
> > +
> > +	return bus;
> > +}
> 
> Anyways, this does look to be "leveraged from arm64" as you say and I
> only had minor nits to comment about...
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
Thanks!
Sunil
