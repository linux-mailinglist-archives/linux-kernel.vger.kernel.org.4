Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19586694DF2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 18:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjBMR0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 12:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjBMR0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 12:26:52 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E0D1EFFF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:26:20 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r2so13024324wrv.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdB4bLMRqGg5/rDPrBY4SK/ZGCvV/97ci3ClbiI2Aa4=;
        b=D9XbGN5aNuVWSy3QJDkq8LUe5yMpGpmyv2WhEU62l9LahDBR5kxa7m33xmIUs3e8l0
         eOLulDSyDaGI6H35gq1aRDUHlB0x8NgxlC0HonnBLWm5pbwC2kL1YNR/FjzQTyS8Kg/o
         wVEASRy1WF96pH8Kw2BPKobF4t6+nHjdpcR/4RAaO1nvHcllnTqupIDL0pr5FFMstLyW
         BQEU+vhZVFGVeKT4jqBz6OHY4cCox6HCFxYWv+KooAQsP7dT3L8M0zL6XJyjRIL/vmwi
         9k+adAuqD6G5gHrHflBoJxTe+L52C9UdMzpLStnCz1agfz2UfBO9mUevAWsfn0jP09vZ
         Ne8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdB4bLMRqGg5/rDPrBY4SK/ZGCvV/97ci3ClbiI2Aa4=;
        b=2tIWIwbX2mgD6SnEVfdlk49D2/1o2NfF/Jc+Ti7TqwzdUcTYy2bKMfWtV8jEikoFhj
         KpVgaOXocj9/+cIusM6bdZM8BMJoDG320QGEKsgsXVGYnDqWkWrylO/zH5ldvJSIIHOK
         NsWGeHtQurwbAOrT1M8CmZ2j6g9Vi2ICHt31LCXldfkqcAYvmdGiWsu5f061dck9WXhR
         h9R6ajWgQVLXSDL2CMNL+Vmqp0b9LModMT47GCavOq4B1sEPqAuq3Y3sArLZFRBDwE+d
         EMYMnX8eBUvxczhHfxpfnBVUrvhbe9JcmNzo21ohLv9j6v/+z2HP7w2WO20CsFJcG7T9
         e0kQ==
X-Gm-Message-State: AO0yUKUTxGNEzrTJoMbOOT0CLuta1xQT3WhLdYi2b1+/V5sqnbQ1OZMF
        VHR0LkIank6rqzgVKIdyOVprPw==
X-Google-Smtp-Source: AK7set8A7pJic60bSGlXIm5zn5pKPq70hzhF9X3JRd41EdaworN6smzMRFHQj3f/IA7ogP26MCQIyQ==
X-Received: by 2002:a5d:63cc:0:b0:2c5:52f5:c63b with SMTP id c12-20020a5d63cc000000b002c552f5c63bmr4979603wrw.11.1676309174098;
        Mon, 13 Feb 2023 09:26:14 -0800 (PST)
Received: from smtpclient.apple (global-5-143.n-2.net.cam.ac.uk. [131.111.5.143])
        by smtp.gmail.com with ESMTPSA id x10-20020a5d54ca000000b002bfb5ebf8cfsm10719006wrv.21.2023.02.13.09.26.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Feb 2023 09:26:13 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 06/24] RISC-V: ACPI: Add PCI functions to build ACPI core
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20230130182225.2471414-7-sunilvl@ventanamicro.com>
Date:   Mon, 13 Feb 2023 17:26:13 +0000
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-doc@vger.kernel.org, Atish Patra <atishp@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <33DF2416-0629-414D-B50E-D99CB55A83AA@jrtc27.com>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <20230130182225.2471414-7-sunilvl@ventanamicro.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Jan 2023, at 18:22, Sunil V L <sunilvl@ventanamicro.com> wrote:
>=20
> When CONFIG_PCI is enabled, ACPI core expects few arch
> functions related to PCI. Add those functions so that
> ACPI core gets build. These are levraged from arm64.

Presumably this is pretty generic and applies to anything without x86
weirdness. Copying all this supposedly architecture specific code
that=E2=80=99s really generic seems like bad practice to me as an =
outsider.
Should this not be unifying the two in a shared location as has been
done for other subsystems?

Jess

> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
> arch/riscv/kernel/Makefile |   1 +
> arch/riscv/kernel/pci.c    | 173 +++++++++++++++++++++++++++++++++++++
> 2 files changed, 174 insertions(+)
> create mode 100644 arch/riscv/kernel/pci.c
>=20
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index f979dc8cf47d..e9d37639751d 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -92,3 +92,4 @@ obj-$(CONFIG_COMPAT)		+=3D =
compat_signal.o
> obj-$(CONFIG_COMPAT)		+=3D compat_vdso/
>=20
> obj-$(CONFIG_ACPI)              +=3D acpi.o
> +obj-$(CONFIG_PCI)               +=3D pci.o
> diff --git a/arch/riscv/kernel/pci.c b/arch/riscv/kernel/pci.c
> new file mode 100644
> index 000000000000..3388af3a67a0
> --- /dev/null
> +++ b/arch/riscv/kernel/pci.c
> @@ -0,0 +1,173 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Code borrowed from ARM64
> + *
> + * Copyright (C) 2003 Anton Blanchard <anton@au.ibm.com>, IBM
> + * Copyright (C) 2014 ARM Ltd.
> + * Copyright (C) 2022-2023 Ventana Micro System Inc.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/pci.h>
> +#include <linux/pci-acpi.h>
> +#include <linux/pci-ecam.h>
> +
> +#ifdef CONFIG_ACPI
> +
> +/*
> + * raw_pci_read/write - Platform-specific PCI config space access.
> + */
> +int raw_pci_read(unsigned int domain, unsigned int bus,
> +		  unsigned int devfn, int reg, int len, u32 *val)
> +{
> +	struct pci_bus *b =3D pci_find_bus(domain, bus);
> +
> +	if (!b)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	return b->ops->read(b, devfn, reg, len, val);
> +}
> +
> +int raw_pci_write(unsigned int domain, unsigned int bus,
> +		unsigned int devfn, int reg, int len, u32 val)
> +{
> +	struct pci_bus *b =3D pci_find_bus(domain, bus);
> +
> +	if (!b)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	return b->ops->write(b, devfn, reg, len, val);
> +}
> +
> +
> +struct acpi_pci_generic_root_info {
> +	struct acpi_pci_root_info	common;
> +	struct pci_config_window	*cfg;	/* config space mapping =
*/
> +};
> +
> +int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
> +{
> +	struct pci_config_window *cfg =3D bus->sysdata;
> +	struct acpi_device *adev =3D to_acpi_device(cfg->parent);
> +	struct acpi_pci_root *root =3D acpi_driver_data(adev);
> +
> +	return root->segment;
> +}
> +
> +static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info =
*ci)
> +{
> +	struct resource_entry *entry, *tmp;
> +	int status;
> +
> +	status =3D acpi_pci_probe_root_resources(ci);
> +	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
> +		if (!(entry->res->flags & IORESOURCE_WINDOW))
> +			resource_list_destroy_entry(entry);
> +	}
> +	return status;
> +}
> +
> +/*
> + * Lookup the bus range for the domain in MCFG, and set up config =
space
> + * mapping.
> + */
> +static struct pci_config_window *
> +pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
> +{
> +	struct device *dev =3D &root->device->dev;
> +	struct resource *bus_res =3D &root->secondary;
> +	u16 seg =3D root->segment;
> +	const struct pci_ecam_ops *ecam_ops;
> +	struct resource cfgres;
> +	struct acpi_device *adev;
> +	struct pci_config_window *cfg;
> +	int ret;
> +
> +	ret =3D pci_mcfg_lookup(root, &cfgres, &ecam_ops);
> +	if (ret) {
> +		dev_err(dev, "%04x:%pR ECAM region not found\n", seg, =
bus_res);
> +		return NULL;
> +	}
> +
> +	adev =3D acpi_resource_consumer(&cfgres);
> +	if (adev)
> +		dev_info(dev, "ECAM area %pR reserved by %s\n", &cfgres,
> +			 dev_name(&adev->dev));
> +	else
> +		dev_warn(dev, FW_BUG "ECAM area %pR not reserved in ACPI =
namespace\n",
> +			 &cfgres);
> +
> +	cfg =3D pci_ecam_create(dev, &cfgres, bus_res, ecam_ops);
> +	if (IS_ERR(cfg)) {
> +		dev_err(dev, "%04x:%pR error %ld mapping ECAM\n", seg, =
bus_res,
> +			PTR_ERR(cfg));
> +		return NULL;
> +	}
> +
> +	return cfg;
> +}
> +
> +/* release_info: free resources allocated by init_info */
> +static void pci_acpi_generic_release_info(struct acpi_pci_root_info =
*ci)
> +{
> +	struct acpi_pci_generic_root_info *ri;
> +
> +	ri =3D container_of(ci, struct acpi_pci_generic_root_info, =
common);
> +	pci_ecam_free(ri->cfg);
> +	kfree(ci->ops);
> +	kfree(ri);
> +}
> +
> +
> +/* Interface called from ACPI code to setup PCI host controller */
> +struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
> +{
> +	struct acpi_pci_generic_root_info *ri;
> +	struct pci_bus *bus, *child;
> +	struct acpi_pci_root_ops *root_ops;
> +	struct pci_host_bridge *host;
> +
> +	ri =3D kzalloc(sizeof(*ri), GFP_KERNEL);
> +	if (!ri)
> +		return NULL;
> +
> +	root_ops =3D kzalloc(sizeof(*root_ops), GFP_KERNEL);
> +	if (!root_ops) {
> +		kfree(ri);
> +		return NULL;
> +	}
> +
> +	ri->cfg =3D pci_acpi_setup_ecam_mapping(root);
> +	if (!ri->cfg) {
> +		kfree(ri);
> +		kfree(root_ops);
> +		return NULL;
> +	}
> +
> +	root_ops->release_info =3D pci_acpi_generic_release_info;
> +	root_ops->prepare_resources =3D pci_acpi_root_prepare_resources;
> +	root_ops->pci_ops =3D (struct pci_ops *)&ri->cfg->ops->pci_ops;
> +	bus =3D acpi_pci_root_create(root, root_ops, &ri->common, =
ri->cfg);
> +	if (!bus)
> +		return NULL;
> +
> +	/* If we must preserve the resource configuration, claim now */
> +	host =3D pci_find_host_bridge(bus);
> +	if (host->preserve_config)
> +		pci_bus_claim_resources(bus);
> +
> +	/*
> +	 * Assign whatever was left unassigned. If we didn't claim =
above,
> +	 * this will reassign everything.
> +	 */
> +	pci_assign_unassigned_root_bus_resources(bus);
> +
> +	list_for_each_entry(child, &bus->children, node)
> +		pcie_bus_configure_settings(child);
> +
> +	return bus;
> +}
> +
> +#endif
> --=20
> 2.38.0
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

