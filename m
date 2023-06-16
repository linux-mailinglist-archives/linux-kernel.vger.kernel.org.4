Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA2173292A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239202AbjFPHrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245496AbjFPHrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:47:06 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69042977;
        Fri, 16 Jun 2023 00:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686901619; x=1718437619;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DT/9LgWcPlAqkV8cMwWcuzts+9FqpjSknwF8j03JJJc=;
  b=cp2/XQLz/2xjIXuI1zeVCCh8+/hRxcBgGSSe3VUhvxPhIbkPWNKTVA35
   8YXc/l+ku/VRa91c9CM0/8GJdLXdD71jrEtTTykpAYyoY6BYinE9L5uW4
   aDjCVJaEuRA3aiyaD5OORDa/+20/B/Ho6LJjZ/AVfS04uvM4KyzJZ6D/Y
   bCx9O9S2qThVsDXRSyKk4Oz9wLGkBMHChFngGRAxJ46sg0DfQGFlMP51g
   O39JUmTBCHzLywvL3KysLGdPGqZvt+7kjDs0xSxpLlvy9jI1EDEzNly+d
   zu9VpBNONtaSrc3VoqELzat/C38GVbsP5WEYQ7Vs+xMaxbmTp3cSEGM+g
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="356640127"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="356640127"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 00:46:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="742569061"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="742569061"
Received: from ijarvine-mobl2.ger.corp.intel.com ([10.251.211.240])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 00:46:56 -0700
Date:   Fri, 16 Jun 2023 10:46:54 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] platform/x86/intel/tpmi: Add debugfs interface
In-Reply-To: <20230615193302.2507338-3-srinivas.pandruvada@linux.intel.com>
Message-ID: <7e269676-6e0-6470-f9f3-4f66dde88e2a@linux.intel.com>
References: <20230615193302.2507338-1-srinivas.pandruvada@linux.intel.com> <20230615193302.2507338-3-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2023, Srinivas Pandruvada wrote:

> Add debugfs interface for debugging TPMI configuration and register
> contents. This shows PFS (PM Feature structure) for each TPMI device.
> 
> For each feature shows full register contents and allows to modify
> register at an offset.
> 
> There is a help file, which explains debugfs contents and operations.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/platform/x86/intel/tpmi.c | 245 +++++++++++++++++++++++++++++-
>  1 file changed, 238 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
> index 9545e9cdb924..9ec9c56bca68 100644
> --- a/drivers/platform/x86/intel/tpmi.c
> +++ b/drivers/platform/x86/intel/tpmi.c
> @@ -48,12 +48,14 @@
>  
>  #include <linux/auxiliary_bus.h>
>  #include <linux/bitfield.h>
> +#include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/intel_tpmi.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/string_helpers.h>
>  
>  #include "vsec.h"
>  
> @@ -86,12 +88,14 @@ struct intel_tpmi_pfs_entry {
>   * @vsec_offset: Starting MMIO address for this feature in bytes. Essentially
>   *		 this offset = "Address" from VSEC header + PFS Capability
>   *		 offset for this feature entry.
> + * @vsec_dev:	Pointer to intel_vsec_device structure for this TPMI device
>   *
>   * Represents TPMI instance information for one TPMI ID.
>   */
>  struct intel_tpmi_pm_feature {
>  	struct intel_tpmi_pfs_entry pfs_header;
>  	unsigned int vsec_offset;
> +	struct intel_vsec_device *vsec_dev;
>  };
>  
>  /**
> @@ -102,6 +106,7 @@ struct intel_tpmi_pm_feature {
>   * @pfs_start:		Start of PFS offset for the TPMI instances in this device
>   * @plat_info:		Stores platform info which can be used by the client drivers
>   * @tpmi_control_mem:	Memory mapped IO for getting control information
> + * @dbgfs_dir:		debugfs entry pointer
>   *
>   * Stores the information for all TPMI devices enumerated from a single PCI device.
>   */
> @@ -112,6 +117,7 @@ struct intel_tpmi_info {
>  	u64 pfs_start;
>  	struct intel_tpmi_plat_info plat_info;
>  	void __iomem *tpmi_control_mem;
> +	struct dentry *dbgfs_dir;
>  };
>  
>  /**
> @@ -303,6 +309,222 @@ int tpmi_get_feature_status(struct auxiliary_device *auxdev, int feature_id,
>  }
>  EXPORT_SYMBOL_NS_GPL(tpmi_get_feature_status, INTEL_TPMI);
>  
> +static int tpmi_help_show(struct seq_file *s, void *unused)
> +{
> +	const char *help =
> +		"TPMI debugfs help\n"
> +		"There will be multiple instances of debugfs folders, one for each package\n"
> +		"E.g. tpmi-0000:00:03.1\n"
> +		"Attributes:\n"
> +		"\tpfs_dump: Shows all PFS entries. Refer to TPMI spec for details\n"
> +		"\tEach of the TPMI ID will have its folder for read/write register access\n"
> +		"\tThe name of the folder suffixed with tpmi ID\n"
> +		"\tEach folder contains two entries\n"
> +		"\tmem_dump and mem_write\n"
> +		"\tmem_dump: Show register contents of full PFS for all TPMI instances\n"
> +		"\tThe total size will be pfs->entry_size * pfs->number of entries * 4\n"
> +		"\tmem_write: Allows to write at any offset. Hardware ignores writes on read only memory\n"
> +		"\tRead/write is at offset multiples of 4\n"
> +		"\tThe format is instance:offset:contents\n"
> +		"\tThe values are in hex\n"
> +		"\t\tExample: echo 0,0x20,0xff > mem_write\n"
> +		"\t\tExample: echo 1,64,64 > mem_write\n";
> +
> +	seq_puts(s, help);

The appropriate place to this kinda information would seem to be:

Documentation/ABI/testing/debugfs-... file.

> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(tpmi_help);
> +
> +static int tpmi_pfs_dbg_show(struct seq_file *s, void *unused)
> +{
> +	struct intel_tpmi_info *tpmi_info = s->private;
> +	int i, ret;
> +
> +	seq_printf(s, "tpmi PFS start offset 0x:%llx\n", tpmi_info->pfs_start);
> +	seq_puts(s, "tpmi_id\t\tnum_entries\tentry_size\t\tcap_offset\tattribute\tfull_base_pointer_for_memmap\tlocked\tdisabled\n");
> +	for (i = 0; i < tpmi_info->feature_count; ++i) {
> +		struct intel_tpmi_pm_feature *pfs;
> +		int locked, disabled;
> +
> +		pfs = &tpmi_info->tpmi_features[i];
> +		ret = tpmi_read_feature_status(tpmi_info, pfs->pfs_header.tpmi_id, &locked, &disabled);
> +		if (ret) {
> +			locked = 'U';
> +			disabled = 'U';
> +		} else {
> +			disabled = disabled ? 'Y' : 'N';
> +			locked = locked ? 'Y' : 'N';
> +		}
> +		seq_printf(s, "0x%02x\t\t0x%02x\t\t0x%06x\t\t0x%04x\t\t0x%02x\t\t0x%x\t\t\t%c\t%c\n",

The last hex is just %x (not %08x), is it intentional?

> +			   pfs->pfs_header.tpmi_id, pfs->pfs_header.num_entries, pfs->pfs_header.entry_size,
> +			   pfs->pfs_header.cap_offset, pfs->pfs_header.attribute, pfs->vsec_offset, locked, disabled);

Please split parameters to 100 columns (I'm okay with the string 
exceeding it).

It would help here if you add pointer also to pfs_header struct. ;-)

> +	}
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(tpmi_pfs_dbg);
> +
> +#define MEM_DUMP_COLUMN_COUNT	8
> +
> +static int tpmi_mem_dump_show(struct seq_file *s, void *unused)
> +{
> +	size_t row_size = MEM_DUMP_COLUMN_COUNT * sizeof(u32);
> +	struct intel_tpmi_pm_feature *pfs = s->private;
> +	int count, ret = 0;
> +	void __iomem *mem;
> +	u16 size;
> +	u32 off;
> +
> +	off = pfs->vsec_offset;
> +
> +	mutex_lock(&tpmi_dev_lock);
> +
> +	for (count = 0; count < pfs->pfs_header.num_entries; ++count) {
> +		u8 *buffer;

Why only this is declared here? I see no consistency based on 
variable usage/scope.

> +		size = pfs->pfs_header.entry_size * sizeof(u32);

Can this overflow?

> +		buffer = kmalloc(size, GFP_KERNEL);
> +		if (!buffer) {
> +			ret = -ENOMEM;
> +			goto done_mem_show;
> +		}
> +
> +		seq_printf(s, "TPMI Instance:%d offset:0x%x\n", count, off);
> +
> +		mem = ioremap(off, size);
> +		if (!mem) {
> +			ret = -ENOMEM;
> +			kfree(buffer);
> +			goto done_mem_show;
> +		}
> +
> +		memcpy_fromio(buffer, mem, size);
> +
> +		seq_hex_dump(s, " ", DUMP_PREFIX_OFFSET, row_size, sizeof(u32), buffer, size, false);
> +
> +		iounmap(mem);
> +		kfree(buffer);
> +
> +		off += size;
> +	}
> +
> +done_mem_show:
> +	mutex_unlock(&tpmi_dev_lock);
> +
> +	return ret;
> +}
> +DEFINE_SHOW_ATTRIBUTE(tpmi_mem_dump);
> +
> +static ssize_t mem_write(struct file *file, const char __user *userbuf, size_t len, loff_t *ppos)
> +{
> +	struct seq_file *m = file->private_data;
> +	struct intel_tpmi_pm_feature *pfs = m->private;
> +	u32 addr, value, punit;
> +	u32 num_elems, *array;
> +	void __iomem *mem;
> +	u16 size;
> +	int ret;
> +
> +	ret = parse_int_array_user(userbuf, len, (int **)&array);
> +	if (ret < 0)
> +		return ret;
> +
> +	num_elems = *array;
> +	if (num_elems != 3) {
> +		ret = -EINVAL;
> +		goto exit_write;
> +	}
> +
> +	punit = array[1];
> +	addr = array[2];
> +	value = array[3];
> +
> +	if (punit >= pfs->pfs_header.num_entries) {
> +		ret = -EINVAL;
> +		goto exit_write;
> +	}
> +
> +	size = pfs->pfs_header.entry_size * sizeof(u32);

There's no consistency in the code, some places do: entry_size * 4 and 
here it's entry_size * sizeof(u32). Please convert all of them to the 
latter one. You need to do one additional patch to convert the existing 
users but that's perfectly fine as an additional cleanup patch (don't 
try to put it either of these patches "while at it").

> +	if (addr >= size) {
> +		ret = -EINVAL;
> +		goto exit_write;
> +	}
> +
> +	mutex_lock(&tpmi_dev_lock);
> +
> +	mem = ioremap(pfs->vsec_offset + (punit * size), size);

Unnecessary parenthesis.

> +	if (!mem) {
> +		ret = -ENOMEM;
> +		goto unlock_mem_write;
> +	}
> +
> +	writel(value, mem + addr);
> +
> +	iounmap(mem);
> +
> +	ret = len;
> +
> +unlock_mem_write:
> +	mutex_unlock(&tpmi_dev_lock);
> +
> +exit_write:
> +	kfree(array);
> +
> +	return ret;
> +}
> +
> +static int mem_write_show(struct seq_file *s, void *unused)
> +{
> +	return 0;
> +}
> +
> +static int mem_write_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, mem_write_show, inode->i_private);
> +}
> +
> +static const struct file_operations mem_write_ops = {
> +	.open           = mem_write_open,
> +	.read           = seq_read,
> +	.write          = mem_write,
> +	.llseek         = seq_lseek,
> +	.release        = single_release,
> +};
> +
> +#define tpmi_to_dev(info)	(&info->vsec_dev->pcidev->dev)
> +
> +static void tpmi_dbgfs_register(struct intel_tpmi_info *tpmi_info)
> +{
> +	struct dentry *top_dir;
> +	char name[64];
> +	int i;
> +
> +	snprintf(name, sizeof(name), "tpmi-%s", dev_name(tpmi_to_dev(tpmi_info)));
> +	top_dir = debugfs_create_dir(name, NULL);
> +	if (IS_ERR_OR_NULL(top_dir))
> +		return;
> +
> +	tpmi_info->dbgfs_dir = top_dir;
> +
> +	debugfs_create_file("pfs_dump", 0444, top_dir, tpmi_info,
> +			    &tpmi_pfs_dbg_fops);

One line.

> +	debugfs_create_file("help", 0444, top_dir, NULL, &tpmi_help_fops);
> +	for (i = 0; i < tpmi_info->feature_count; ++i) {
> +		struct intel_tpmi_pm_feature *pfs;
> +		struct dentry *dir;
> +
> +		pfs = &tpmi_info->tpmi_features[i];
> +		snprintf(name, sizeof(name), "tpmi-id-%02x", pfs->pfs_header.tpmi_id);
> +		dir = debugfs_create_dir(name, top_dir);
> +
> +		debugfs_create_file("mem_dump", 0444, dir, pfs,
> +				    &tpmi_mem_dump_fops);
> +		debugfs_create_file("mem_write", 0644, dir, pfs,
> +				    &mem_write_ops);

These too can be put to one line.


-- 
 i.

> +	}
> +}
> +
>  static void tpmi_set_control_base(struct auxiliary_device *auxdev,
>  				  struct intel_tpmi_info *tpmi_info,
>  				  struct intel_tpmi_pm_feature *pfs)
> @@ -458,7 +680,7 @@ static int intel_vsec_tpmi_init(struct auxiliary_device *auxdev)
>  	struct pci_dev *pci_dev = vsec_dev->pcidev;
>  	struct intel_tpmi_info *tpmi_info;
>  	u64 pfs_start = 0;
> -	int i;
> +	int ret, i;
>  
>  	tpmi_info = devm_kzalloc(&auxdev->dev, sizeof(*tpmi_info), GFP_KERNEL);
>  	if (!tpmi_info)
> @@ -481,6 +703,7 @@ static int intel_vsec_tpmi_init(struct auxiliary_device *auxdev)
>  		int size, ret;
>  
>  		pfs = &tpmi_info->tpmi_features[i];
> +		pfs->vsec_dev = vsec_dev;
>  
>  		res = &vsec_dev->resource[i];
>  		if (!res)
> @@ -520,7 +743,13 @@ static int intel_vsec_tpmi_init(struct auxiliary_device *auxdev)
>  
>  	auxiliary_set_drvdata(auxdev, tpmi_info);
>  
> -	return tpmi_create_devices(tpmi_info);
> +	ret = tpmi_create_devices(tpmi_info);
> +	if (ret)
> +		return ret;
> +
> +	tpmi_dbgfs_register(tpmi_info);
> +
> +	return 0;
>  }
>  
>  static int tpmi_probe(struct auxiliary_device *auxdev,
> @@ -529,11 +758,12 @@ static int tpmi_probe(struct auxiliary_device *auxdev,
>  	return intel_vsec_tpmi_init(auxdev);
>  }
>  
> -/*
> - * Remove callback is not needed currently as there is no
> - * cleanup required. All memory allocs are device managed. All
> - * devices created by this modules are also device managed.
> - */
> +static void tpmi_remove(struct auxiliary_device *auxdev)
> +{
> +	struct intel_tpmi_info *tpmi_info = auxiliary_get_drvdata(auxdev);
> +
> +	debugfs_remove_recursive(tpmi_info->dbgfs_dir);
> +}
>  
>  static const struct auxiliary_device_id tpmi_id_table[] = {
>  	{ .name = "intel_vsec.tpmi" },
> @@ -544,6 +774,7 @@ MODULE_DEVICE_TABLE(auxiliary, tpmi_id_table);
>  static struct auxiliary_driver tpmi_aux_driver = {
>  	.id_table	= tpmi_id_table,
>  	.probe		= tpmi_probe,
> +	.remove         = tpmi_remove,
>  };
>  
>  module_auxiliary_driver(tpmi_aux_driver);
> 

