Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70F55FA02B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 16:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiJJOYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 10:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiJJOYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 10:24:23 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB18733E5;
        Mon, 10 Oct 2022 07:24:19 -0700 (PDT)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MmLgx4xNpz686q6;
        Mon, 10 Oct 2022 22:21:33 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 16:24:17 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 10 Oct
 2022 15:24:16 +0100
Date:   Mon, 10 Oct 2022 15:24:15 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Robert Richter" <rrichter@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "Terry Bowman" <terry.bowman@amd.com>
Subject: Re: [PATCH 1/2] efi/cper, cxl: Decode CXL Protocol Error Section
Message-ID: <20221010152415.0000113b@huawei.com>
In-Reply-To: <20221007211714.71129-2-Smita.KoralahalliChannabasappa@amd.com>
References: <20221007211714.71129-1-Smita.KoralahalliChannabasappa@amd.com>
        <20221007211714.71129-2-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Oct 2022 21:17:13 +0000
Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:

> Add support for decoding CXL Protocol Error Section as defined in UEFI 2.9
> Section N.2.13.
> 
> Do the section decoding in a new cper_cxl.c file. This new file will be
> used in the future for more CXL CPERs decode support. Add this to the
> existing UEFI_CPER config.
> 
> Decode only the fields that are useful to parse the error.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

Hi Smita,

A few comments inline, but this looks pretty good to me though lots to
build on top of this (trace events, any in kernel handling necessary etc).

Jonathan

> ---
>  drivers/firmware/efi/Makefile   |  2 +-
>  drivers/firmware/efi/cper.c     |  9 ++++
>  drivers/firmware/efi/cper_cxl.c | 87 +++++++++++++++++++++++++++++++++
>  drivers/firmware/efi/cper_cxl.h | 58 ++++++++++++++++++++++
>  4 files changed, 155 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/firmware/efi/cper_cxl.c
>  create mode 100644 drivers/firmware/efi/cper_cxl.h
> 
> diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
> index 8d151e332584..4f332de54173 100644
> --- a/drivers/firmware/efi/Makefile
> +++ b/drivers/firmware/efi/Makefile
> @@ -19,7 +19,7 @@ endif
>  obj-$(CONFIG_EFI_PARAMS_FROM_FDT)	+= fdtparams.o
>  obj-$(CONFIG_EFI_ESRT)			+= esrt.o
>  obj-$(CONFIG_EFI_VARS_PSTORE)		+= efi-pstore.o
> -obj-$(CONFIG_UEFI_CPER)			+= cper.o
> +obj-$(CONFIG_UEFI_CPER)			+= cper.o cper_cxl.o
>  obj-$(CONFIG_EFI_RUNTIME_MAP)		+= runtime-map.o
>  obj-$(CONFIG_EFI_RUNTIME_WRAPPERS)	+= runtime-wrappers.o
>  subdir-$(CONFIG_EFI_STUB)		+= libstub
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index e4e5ea7ce910..181deb9af527 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -24,6 +24,7 @@
>  #include <linux/bcd.h>
>  #include <acpi/ghes.h>
>  #include <ras/ras_event.h>
> +#include "cper_cxl.h"
>  
>  /*
>   * CPER record ID need to be unique even after reboot, because record
> @@ -595,6 +596,14 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
>  			cper_print_fw_err(newpfx, gdata, fw_err);
>  		else
>  			goto err_section_too_small;
> +	} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
> +		struct cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
> +
> +		printk("%ssection_type: CXL Protocol Error\n", newpfx);
> +		if (gdata->error_data_length >= sizeof(*prot_err))
> +			cper_print_prot_err(newpfx, prot_err);
> +		else
> +			goto err_section_too_small;
>  	} else {
>  		const void *err = acpi_hest_get_payload(gdata);
>  
> diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
> new file mode 100644
> index 000000000000..e5f48f0de1a4
> --- /dev/null
> +++ b/drivers/firmware/efi/cper_cxl.c
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * UEFI Common Platform Error Record (CPER) support for CXL Section.
> + *
> + * Copyright (C) 2022 Advanced Micro Devices, Inc.
> + *
> + * Author: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> + */
> +
> +#include <linux/cper.h>
> +#include "cper_cxl.h"
> +
> +#define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
> +#define PROT_ERR_VALID_AGENT_ADDRESS		BIT_ULL(1)
> +#define PROT_ERR_VALID_DEVICE_ID		BIT_ULL(2)
> +#define PROT_ERR_VALID_SERIAL_NUMBER		BIT_ULL(3)
> +#define PROT_ERR_VALID_CAPABILITY		BIT_ULL(4)
> +#define PROT_ERR_VALID_DVSEC			BIT_ULL(5)

Bit 6 has been defined by 2.10 so would be good to add that here as well.
As below, could be a follow up patch.

> +
> +static const char * const prot_err_agent_type_strs[] = {
> +	"Restricted CXL Device",
> +	"Restricted CXL Host DP",

Values up to 7 now defined, so good to list the ones we know...
https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#compute-express-link-cxl-protocol-error-section
even if they aren't going to be generated by your firmware.

I've hacked qemu to poke out appropriate records in the past
(for CCIX a while back) and it would be easy enough to add
them for these cases if needed (obviously that's a dirty hack
but it works for testing these flows ;)

I guess I can send a follow up patch if you aren't happy jumping
directly to the 2.10 version of these structures.

> +};
> +
> +enum {
> +	RCD,
> +	RCH_DP,
> +};
> +
> +void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err)
> +{
> +	if (prot_err->valid_bits & PROT_ERR_VALID_AGENT_TYPE)
> +		pr_info("%s agent_type: %d, %s\n", pfx, prot_err->agent_type,
> +			prot_err->agent_type < ARRAY_SIZE(prot_err_agent_type_strs)
> +			? prot_err_agent_type_strs[prot_err->agent_type]
> +			: "unknown");
> +
> +	if (prot_err->valid_bits & PROT_ERR_VALID_AGENT_ADDRESS) {
> +		switch (prot_err->agent_type) {
> +		case RCD:
> +			pr_info("%s agent_address: %04x:%02x:%02x.%x\n",
> +				pfx, prot_err->segment, prot_err->bus,
> +				prot_err->device, prot_err->function);
> +			break;
> +		case RCH_DP:
> +			pr_info("%s rcrb_base_address: 0x%016llx\n", pfx,
> +				prot_err->agent_addr);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	if (prot_err->valid_bits & PROT_ERR_VALID_DEVICE_ID) {
> +		const __u8 *class_code;
> +
> +		switch (prot_err->agent_type) {
> +		case RCD:
> +			pr_info("%s slot: %d\n", pfx,
> +				prot_err->device_id.slot >> CPER_PCIE_SLOT_SHIFT);
> +			pr_info("%s vendor_id: 0x%04x, device_id: 0x%04x\n",
> +				pfx, prot_err->device_id.vendor_id,
> +				prot_err->device_id.device_id);
> +			pr_info("%s sub_vendor_id: 0x%04x, sub_device_id: 0x%04x\n",
> +				pfx, prot_err->device_id.sub_vendor_id,
> +				prot_err->device_id.sub_device_id);
> +			class_code = prot_err->device_id.class_code;
> +			pr_info("%s class_code: %02x%02x\n", pfx,
> +				class_code[1], class_code[0]);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	if (prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER) {
> +		switch (prot_err->agent_type) {
> +		case RCD:
> +			pr_info("%s lower_dw: 0x%08x, upper_dw: 0x%08x\n", pfx,
> +				prot_err->dev_serial_num.lower_dw,
> +				prot_err->dev_serial_num.upper_dw);
> +			break;
> +		default:
> +			break;
> +		}
> +	}

Nice to pretty print the cap structure and appropriate DVSEC and Error logs as well
if valid, but that could be a follow up patch.

> +}
> diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
> new file mode 100644
> index 000000000000..f924d96e4bb2
> --- /dev/null
> +++ b/drivers/firmware/efi/cper_cxl.h
> @@ -0,0 +1,58 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * UEFI Common Platform Error Record (CPER) support for CXL Section.
> + *
> + * Copyright (C) 2022 Advanced Micro Devices, Inc.
> + *
> + * Author: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> + */
> +
> +#ifndef LINUX_CPER_CXL_H
> +#define LINUX_CPER_CXL_H
> +
> +/* CXL Protocol Error Section */
> +#define CPER_SEC_CXL_PROT_ERR						\
> +	GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,	\
> +		  0x4B, 0x77, 0x10, 0x48)
> +
> +#pragma pack(1)
> +
> +/* Compute Express Link Protocol Error Section, UEFI v2.9 sec N.2.13 */

Given 2.10 is out an expands on a few corners of this. Perhaps update
an switch the reference over to that to cover that.
I haven't checked, but assume the additional Agent Types were added in 2.10.

> +struct cper_sec_prot_err {
> +	u64			valid_bits;
> +	u8			agent_type;
> +	u8			reserved[7];
> +	union {
> +		u64		agent_addr;

Perhaps useful to add a few comments to say when the different union
elements are relevant.  Perhaps also name the field as per the spec
which would give the overall union the agent_address.
I admit that is a little confusing with the union element having
the same name for when it's treated as an address.
Perhaps call the union element rcrb_base_addr?

> +		struct {
> +			u8	function;
> +			u8	device;
> +			u8	bus;
> +			u16	segment;
> +			u8	reserved_1[3];
> +		};
> +	};
> +	struct {
> +		u16		vendor_id;	
> +		u16		device_id;
> +		u16		sub_vendor_id;
> +		u16		sub_device_id;

This is always fun.  Far as I can tell not all PCI elements
have subsystem IDs - so who knows what goes in these..
Also, there is wonderfully no such thing as a PCI subsystem device ID.
It's just called subsystem ID in the PCI spec.

> +		u8		class_code[2];

Why treat class code as two u8s?  If doing so, shall
we name them?  base_class_code, sub_class_code?

> +		u16		slot;
> +		u8		reserved_1[4];
> +	}			device_id;

I would not align device-id structure name with the contents.
I'm not personally a big fan of aligning structure elements
because it often goes wrong, but if you want to do it, drop
the alignment of device_id by a few levels.

	} device_id;

> +	struct {
> +		u32		lower_dw;
> +		u32		upper_dw;
> +	}			dev_serial_num;
> +	u8			capability[60];
> +	u16			dvsec_len;
> +	u16			err_len;
> +	u8			reserved_2[4];

You could add a [] array on the end to make it clear there are more elements.
That's not a perfect solution though given there are two different variable length
fields on the end.  They aren't that variable (as defined by the structures
in the CXL spec) however the complexity comes from the fact that they may not
be valid / lengths will be 0 (I assume lengths will be 0
if not valid anyway, the spec doesn't seem to say either way...)

Either way, adding a variable array element gives a good way to address the first
one, and provides a good location for a comment on what else might be here.

> +};
> +
> +#pragma pack()

I would push the structure definition down into the c file and provide a forwards
definition only in the header.

struct cper_sec_prot_err;


> +
> +void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err);
> +
> +#endif //__CPER_CXL_

