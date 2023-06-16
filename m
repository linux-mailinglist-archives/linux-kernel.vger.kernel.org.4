Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BB67336DD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346042AbjFPQ5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345962AbjFPQ5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:57:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770544C37;
        Fri, 16 Jun 2023 09:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686934511; x=1718470511;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kEpmcXqvu9bcRZE7eSxcLWpsLyANqUirm2sGpkDahsA=;
  b=JiaNN0BTXrK4I1JOzRXaFl9iR3DoALa5hmn6orUkoMV1USESBldYrNLO
   ER8DQPFQQmdLcYvEAUIM6lRIqtCHD2DRkij4B+kfX0R2Y90DXFaBXL0yL
   JMVskBtJuulnYKUFMHYTnYmPCcOiVqYq9/Fj+C1CqNlkKDpTIjeJWKVI/
   V3UMb7ZEHmzE8Pt5qpKxIJiQhDq86rRKhw/WsmyQqi4neG4wO1B+7NkM4
   nUQABMdUgNZQspLtRTprtj6XPX+DO2Xi4kW0gElM8jhuQYHonTvMwgsbr
   2YXl/7uEi0W2wb6GN+rBpoNBE/y0yX+XTmMZlXB/pnWYxOfdmfA8O2XbC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="338877179"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="338877179"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 09:54:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="837089615"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="837089615"
Received: from jbonds-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.56.162])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 09:54:55 -0700
Message-ID: <5617a6975ff1ac62739697bf315fb34b8b874aec.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] platform/x86/intel/tpmi: Add debugfs interface
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Fri, 16 Jun 2023 09:54:55 -0700
In-Reply-To: <7e269676-6e0-6470-f9f3-4f66dde88e2a@linux.intel.com>
References: <20230615193302.2507338-1-srinivas.pandruvada@linux.intel.com>
         <20230615193302.2507338-3-srinivas.pandruvada@linux.intel.com>
         <7e269676-6e0-6470-f9f3-4f66dde88e2a@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-06-16 at 10:46 +0300, Ilpo Järvinen wrote:
> On Thu, 15 Jun 2023, Srinivas Pandruvada wrote:
> 
> > 

[...]

> > +       seq_puts(s, help);
> 
> The appropriate place to this kinda information would seem to be:
> 
> Documentation/ABI/testing/debugfs-... file.

I prefer to add to Documentation.
But this is for validation folks, who struggle to get documentation,
will ask you 10 question before using. Hence added here.

But I don't have strong preference here. I can move to doc area.


> 
> > +
> > +       return 0;
> > +}
> > +DEFINE_SHOW_ATTRIBUTE(tpmi_help);
> > +
> > +static int tpmi_pfs_dbg_show(struct seq_file *s, void *unused)
> > +{
> > +       struct intel_tpmi_info *tpmi_info = s->private;
> > +       int i, ret;
> > +
> > +       seq_printf(s, "tpmi PFS start offset 0x:%llx\n", tpmi_info-
> > >pfs_start);
> > +       seq_puts(s,
> > "tpmi_id\t\tnum_entries\tentry_size\t\tcap_offset\tattribute\tfull_
> > base_pointer_for_memmap\tlocked\tdisabled\n");
> > +       for (i = 0; i < tpmi_info->feature_count; ++i) {
> > +               struct intel_tpmi_pm_feature *pfs;
> > +               int locked, disabled;
> > +
> > +               pfs = &tpmi_info->tpmi_features[i];
> > +               ret = tpmi_read_feature_status(tpmi_info, pfs-
> > >pfs_header.tpmi_id, &locked, &disabled);
> > +               if (ret) {
> > +                       locked = 'U';
> > +                       disabled = 'U';
> > +               } else {
> > +                       disabled = disabled ? 'Y' : 'N';
> > +                       locked = locked ? 'Y' : 'N';
> > +               }
> > +               seq_printf(s,
> > "0x%02x\t\t0x%02x\t\t0x%06x\t\t0x%04x\t\t0x%02x\t\t0x%x\t\t\t%c\t%c
> > \n",
> 
> The last hex is just %x (not %08x), is it intentional?
Not intentional.

> 
> > +                          pfs->pfs_header.tpmi_id, pfs-
> > >pfs_header.num_entries, pfs->pfs_header.entry_size,
> > +                          pfs->pfs_header.cap_offset, pfs-
> > >pfs_header.attribute, pfs->vsec_offset, locked, disabled);
> 
> Please split parameters to 100 columns (I'm okay with the string 
> exceeding it).
> 
> It would help here if you add pointer also to pfs_header struct. ;-)
> 
Will think about it if useful.

> > +       }
> > +
> > +       return 0;
> > +}
> > +DEFINE_SHOW_ATTRIBUTE(tpmi_pfs_dbg);
> > +
> > +#define MEM_DUMP_COLUMN_COUNT  8
> > +
> > +static int tpmi_mem_dump_show(struct seq_file *s, void *unused)
> > +{
> > +       size_t row_size = MEM_DUMP_COLUMN_COUNT * sizeof(u32);
> > +       struct intel_tpmi_pm_feature *pfs = s->private;
> > +       int count, ret = 0;
> > +       void __iomem *mem;
> > +       u16 size;
> > +       u32 off;
> > +
> > +       off = pfs->vsec_offset;
> > +
> > +       mutex_lock(&tpmi_dev_lock);
> > +
> > +       for (count = 0; count < pfs->pfs_header.num_entries;
> > ++count) {
> > +               u8 *buffer;
> 
> Why only this is declared here? I see no consistency based on 
> variable usage/scope.
I will fix this.

> 
> > +               size = pfs->pfs_header.entry_size * sizeof(u32);
> 
> Can this overflow?
No. Coming from a trusted architectural source. The system will not
pass BIOS if they are wrong.

> 
> > +               buffer = kmalloc(size, GFP_KERNEL);
> > +               if (!buffer) {
> > +                       ret = -ENOMEM;
> > +                       goto done_mem_show;
> > +               }
> > +
> > +               seq_printf(s, "TPMI Instance:%d offset:0x%x\n",
> > count, off);
> > +
> > +               mem = ioremap(off, size);
> > +               if (!mem) {
> > +                       ret = -ENOMEM;
> > +                       kfree(buffer);
> > +                       goto done_mem_show;
> > +               }
> > +
> > +               memcpy_fromio(buffer, mem, size);
> > +
> > +               seq_hex_dump(s, " ", DUMP_PREFIX_OFFSET, row_size,
> > sizeof(u32), buffer, size, false);
> > +
> > +               iounmap(mem);
> > +               kfree(buffer);
> > +
> > +               off += size;
> > +       }
> > +
> > +done_mem_show:
> > +       mutex_unlock(&tpmi_dev_lock);
> > +
> > +       return ret;
> > +}
> > +DEFINE_SHOW_ATTRIBUTE(tpmi_mem_dump);
> > +
> > +static ssize_t mem_write(struct file *file, const char __user
> > *userbuf, size_t len, loff_t *ppos)
> > +{
> > +       struct seq_file *m = file->private_data;
> > +       struct intel_tpmi_pm_feature *pfs = m->private;
> > +       u32 addr, value, punit;
> > +       u32 num_elems, *array;
> > +       void __iomem *mem;
> > +       u16 size;
> > +       int ret;
> > +
> > +       ret = parse_int_array_user(userbuf, len, (int **)&array);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       num_elems = *array;
> > +       if (num_elems != 3) {
> > +               ret = -EINVAL;
> > +               goto exit_write;
> > +       }
> > +
> > +       punit = array[1];
> > +       addr = array[2];
> > +       value = array[3];
> > +
> > +       if (punit >= pfs->pfs_header.num_entries) {
> > +               ret = -EINVAL;
> > +               goto exit_write;
> > +       }
> > +
> > +       size = pfs->pfs_header.entry_size * sizeof(u32);
> 
> There's no consistency in the code, some places do: entry_size * 4
> and 
> here it's entry_size * sizeof(u32). Please convert all of them to the
> latter one. You need to do one additional patch to convert the
> existing 
> users but that's perfectly fine as an additional cleanup patch (don't
> try to put it either of these patches "while at it").
Good idea.

> 
> > +       if (addr >= size) {
> > +               ret = -EINVAL;
> > +               goto exit_write;
> > +       }
> > +
> > +       mutex_lock(&tpmi_dev_lock);
> > +
> > +       mem = ioremap(pfs->vsec_offset + (punit * size), size);
> 
> Unnecessary parenthesis.
ok

> 
> > +       if (!mem) {
> > +               ret = -ENOMEM;
> > +               goto unlock_mem_write;
> > +       }
> > +
> > +       writel(value, mem + addr);
> > +
> > +       iounmap(mem);
> > +
> > +       ret = len;
> > +
> > +unlock_mem_write:
> > +       mutex_unlock(&tpmi_dev_lock);
> > +
> > +exit_write:
> > +       kfree(array);
> > +
> > +       return ret;
> > +}
> > +
> > +static int mem_write_show(struct seq_file *s, void *unused)
> > +{
> > +       return 0;
> > +}
> > +
> > +static int mem_write_open(struct inode *inode, struct file *file)
> > +{
> > +       return single_open(file, mem_write_show, inode->i_private);
> > +}
> > +
> > +static const struct file_operations mem_write_ops = {
> > +       .open           = mem_write_open,
> > +       .read           = seq_read,
> > +       .write          = mem_write,
> > +       .llseek         = seq_lseek,
> > +       .release        = single_release,
> > +};
> > +
> > +#define tpmi_to_dev(info)      (&info->vsec_dev->pcidev->dev)
> > +
> > +static void tpmi_dbgfs_register(struct intel_tpmi_info *tpmi_info)
> > +{
> > +       struct dentry *top_dir;
> > +       char name[64];
> > +       int i;
> > +
> > +       snprintf(name, sizeof(name), "tpmi-%s",
> > dev_name(tpmi_to_dev(tpmi_info)));
> > +       top_dir = debugfs_create_dir(name, NULL);
> > +       if (IS_ERR_OR_NULL(top_dir))
> > +               return;
> > +
> > +       tpmi_info->dbgfs_dir = top_dir;
> > +
> > +       debugfs_create_file("pfs_dump", 0444, top_dir, tpmi_info,
> > +                           &tpmi_pfs_dbg_fops);
> 
> One line.
OK

> 
> > +       debugfs_create_file("help", 0444, top_dir, NULL,
> > &tpmi_help_fops);
> > +       for (i = 0; i < tpmi_info->feature_count; ++i) {
> > +               struct intel_tpmi_pm_feature *pfs;
> > +               struct dentry *dir;
> > +
> > +               pfs = &tpmi_info->tpmi_features[i];
> > +               snprintf(name, sizeof(name), "tpmi-id-%02x", pfs-
> > >pfs_header.tpmi_id);
> > +               dir = debugfs_create_dir(name, top_dir);
> > +
> > +               debugfs_create_file("mem_dump", 0444, dir, pfs,
> > +                                   &tpmi_mem_dump_fops);
> > +               debugfs_create_file("mem_write", 0644, dir, pfs,
> > +                                   &mem_write_ops);
> 
> These too can be put to one line.
> 
OK

Thanks,
Srinivas

> 

