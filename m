Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B48D67D559
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjAZT3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjAZT3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:29:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6941633A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674761295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f7dX+59tBr2e29VfGUnKsq1lVOSA2CRLHmOmP0zE/nk=;
        b=bNsUsMUD4Vu9duflOpUqhGnnUNLd6ec+mAoIEoCyGobBMBVp7NzqgppCYmjChcgxTe/9or
        a/V3PoWA8CX8mAEcGv6cuDNiv51NvUIYcx/o+HznHqSEHB0nRKGcFtdnfVWDuJU/0dJBcE
        mdHbVMIl6aRwCP3tx0zo6gvZ9IhE+D0=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-150-Rrk1aPKBOYWgasVufPzoTw-1; Thu, 26 Jan 2023 14:28:13 -0500
X-MC-Unique: Rrk1aPKBOYWgasVufPzoTw-1
Received: by mail-io1-f70.google.com with SMTP id d22-20020a5d9656000000b00704d3bd8c07so1470280ios.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:28:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7dX+59tBr2e29VfGUnKsq1lVOSA2CRLHmOmP0zE/nk=;
        b=lyVn+Bin7+ej9jRk9xKUArNT2qJJQ4wVa2nK8TYcpeeVuGutEI+CKs1i2s4+NmDrlo
         sBEgKdtlrvHoomwoqUZw8O5oiTvQewh178+aXqESoAA6ebTiNxzDfyNCMpIogHvI9uxb
         1zNk2n55NhDZ/tQU43/csxlHU1bu5DzZMrpJzy9QGx6H3Ka2T/uX9BRQMZmxYS56hUhB
         +VcfRGIUj+ooLT6OIssCDCLSaS6MxLpIwUUkFZREftio1Al6SeJ86OFCSJT2vJ/MBq4U
         ZRrC74iMfnU49k2eRrRJIrj+gjqAWfVGv9wUAwFXPeQ2w6ICXKIpAJ8SKFoPPngbH1jJ
         M/qQ==
X-Gm-Message-State: AO0yUKUDB2Vaux8zpmv2hYqleBNx/Z2kF0XuzxMn4ax58coCclzQlxNk
        dpXFhgZ2+KvhkZstEvvpPIaaB2gZeaYMA4x+Zx6QmtgLsLSizDsfBxANgQQLuySVsQ8qA8vyO0N
        ppkpaZymEz+CfAUYJ33Yiixxu
X-Received: by 2002:a05:6e02:1baf:b0:310:9fd7:da2b with SMTP id n15-20020a056e021baf00b003109fd7da2bmr6114258ili.23.1674761293140;
        Thu, 26 Jan 2023 11:28:13 -0800 (PST)
X-Google-Smtp-Source: AK7set/dXlsNCxEjBGp5eb4tp5U0IYZkZLtJyozCdGDWjECQcVUntPMPlYv7FsCr2fNs1kji7GW1sw==
X-Received: by 2002:a05:6e02:1baf:b0:310:9fd7:da2b with SMTP id n15-20020a056e021baf00b003109fd7da2bmr6114236ili.23.1674761292799;
        Thu, 26 Jan 2023 11:28:12 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id k9-20020a02ccc9000000b003a961e5d33fsm596210jaq.49.2023.01.26.11.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 11:28:12 -0800 (PST)
Date:   Thu, 26 Jan 2023 12:28:02 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH v7 3/5] hisi_acc_vfio_pci: register debugfs for
 hisilicon migration driver
Message-ID: <20230126122802.2a6dbc4c.alex.williamson@redhat.com>
In-Reply-To: <20230120032930.43608-4-liulongfang@huawei.com>
References: <20230120032930.43608-1-liulongfang@huawei.com>
        <20230120032930.43608-4-liulongfang@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2023 11:29:28 +0800
Longfang Liu <liulongfang@huawei.com> wrote:

> On the debugfs framework of VFIO, if the CONFIG_DEBUG_FS macro is
> enabled, the debug function is registered for the live migration driver
> of the HiSilicon accelerator device.
> 
> On the basis of the original public debug function, a private debug
> function is added:
> 
> mig_data file: used to get the migration data of the live migration device
> mig_attr file: used to get device attributes of the live migration device
> debug file: used to test for acquiring and writing device state data
> for VF device.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 282 ++++++++++++++++++
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.h    |  11 +
>  2 files changed, 293 insertions(+)
> 
> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> index 6a219b01c965..96e2a021a956 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> @@ -15,6 +15,7 @@
>  #include <linux/anon_inodes.h>
>  
>  #include "hisi_acc_vfio_pci.h"
> +#include "../vfio_pci_debugfs.h"
>  
>  /* Return 0 on VM acc device ready, -ETIMEDOUT hardware timeout */
>  static int qm_wait_dev_not_ready(struct hisi_qm *qm)
> @@ -606,6 +607,18 @@ hisi_acc_check_int_state(struct hisi_acc_vf_core_device *hisi_acc_vdev)
>  	}
>  }
>  
> +static void hisi_acc_vf_migf_save(struct hisi_acc_vf_migration_file *src_migf,
> +	struct hisi_acc_vf_migration_file *dst_migf)
> +{
> +	if (!dst_migf)
> +		return;
> +
> +	dst_migf->disabled = false;
> +	dst_migf->total_length = src_migf->total_length;
> +	memcpy(&dst_migf->vf_data, &src_migf->vf_data,
> +		    sizeof(struct acc_vf_data));
> +}
> +
>  static void hisi_acc_vf_disable_fd(struct hisi_acc_vf_migration_file *migf)
>  {
>  	mutex_lock(&migf->lock);
> @@ -618,12 +631,16 @@ static void hisi_acc_vf_disable_fd(struct hisi_acc_vf_migration_file *migf)
>  static void hisi_acc_vf_disable_fds(struct hisi_acc_vf_core_device *hisi_acc_vdev)
>  {
>  	if (hisi_acc_vdev->resuming_migf) {
> +		hisi_acc_vf_migf_save(hisi_acc_vdev->resuming_migf,
> +						hisi_acc_vdev->debug_migf);
>  		hisi_acc_vf_disable_fd(hisi_acc_vdev->resuming_migf);
>  		fput(hisi_acc_vdev->resuming_migf->filp);
>  		hisi_acc_vdev->resuming_migf = NULL;
>  	}
>  
>  	if (hisi_acc_vdev->saving_migf) {
> +		hisi_acc_vf_migf_save(hisi_acc_vdev->saving_migf,
> +						hisi_acc_vdev->debug_migf);
>  		hisi_acc_vf_disable_fd(hisi_acc_vdev->saving_migf);
>  		fput(hisi_acc_vdev->saving_migf->filp);
>  		hisi_acc_vdev->saving_migf = NULL;
> @@ -1303,6 +1320,265 @@ static long hisi_acc_vfio_pci_ioctl(struct vfio_device *core_vdev, unsigned int
>  	return vfio_pci_core_ioctl(core_vdev, cmd, arg);
>  }
>  
> +static int hisi_acc_vf_debug_io(struct vfio_device *vdev)
> +{
> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
> +	struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
> +	struct device *dev = vdev->dev;
> +	u64 data;
> +	int ret;
> +
> +	ret = qm_wait_dev_not_ready(vf_qm);
> +	if (ret)
> +		dev_err(dev, "VF device not ready!\n");
> +
> +	data = readl(vf_qm->io_base + QM_MB_CMD_SEND_BASE);
> +	dev_info(dev, "debug mailbox val: 0x%llx\n", data);
> +
> +	return ret;
> +}
> +
> +static int hisi_acc_vf_debug_resume(struct vfio_device *vdev)
> +{
> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
> +	struct hisi_acc_vf_migration_file *migf = hisi_acc_vdev->debug_migf;
> +	struct device *dev = vdev->dev;
> +	int ret;
> +
> +	ret = vf_qm_state_save(hisi_acc_vdev, migf);
> +	if (ret) {
> +		dev_err(dev, "failed to save device data!\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = vf_qm_check_match(hisi_acc_vdev, migf);
> +	if (ret) {
> +		dev_err(dev, "failed to match the VF!\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = vf_qm_load_data(hisi_acc_vdev, migf);
> +	if (ret) {
> +		dev_err(dev, "failed to recover the VF!\n");
> +		return -EINVAL;
> +	}
> +
> +	vf_qm_fun_reset(&hisi_acc_vdev->vf_qm);
> +	dev_info(dev, "successful to resume device data!\n");
> +
> +	return 0;
> +}
> +
> +static int hisi_acc_vf_debug_save(struct vfio_device *vdev)
> +{
> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
> +	struct hisi_acc_vf_migration_file *migf = hisi_acc_vdev->debug_migf;
> +	struct device *dev = vdev->dev;
> +	int ret;
> +
> +	ret = vf_qm_state_save(hisi_acc_vdev, migf);
> +	if (ret) {
> +		dev_err(dev, "failed to save device data!\n");
> +		return -EINVAL;
> +	}
> +	dev_info(dev, "successful to save device data!\n");
> +
> +	return 0;
> +}
> +
> +static int
> +hisi_acc_vf_debug_operate(struct vfio_device *vdev, unsigned int cmd)
> +{
> +	int ret;
> +
> +	switch (cmd) {
> +	case STATE_SAVE:
> +		ret = hisi_acc_vf_debug_save(vdev);
> +		if (ret)
> +			return ret;
> +		break;
> +	case STATE_RESUME:
> +		ret = hisi_acc_vf_debug_resume(vdev);
> +		if (ret)
> +			return ret;
> +		break;
> +	case RW_IO_TEST:
> +		ret = hisi_acc_vf_debug_io(vdev);
> +		if (ret)
> +			return ret;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int hisi_acc_vf_debug_check(struct vfio_device *vdev)
> +{
> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
> +	struct hisi_acc_vf_migration_file *migf = hisi_acc_vdev->debug_migf;
> +	enum vfio_device_mig_state state;
> +
> +	if (!vdev->mig_ops || !migf) {
> +		dev_err(vdev->dev, "device not support debugfs!\n");
> +		return -EINVAL;
> +	}
> +
> +	/* If device not opened, the debugfs operation will trigger calltrace */
> +	(void)vdev->mig_ops->migration_get_state(vdev, &state);
> +	if (state == VFIO_DEVICE_STATE_ERROR ||
> +	    state == VFIO_DEVICE_STATE_STOP) {
> +		dev_err(vdev->dev, "device not opened!\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t hisi_acc_vf_debug_write(struct file *filp, const char __user *buffer,
> +			    size_t count, loff_t *pos)
> +{
> +	struct vfio_device	*vdev = filp->private_data;
> +	char tbuf[VFIO_DEV_DBG_LEN];
> +	unsigned long cmd;
> +	int len, ret;
> +
> +	if (*pos)
> +		return 0;
> +
> +	if (count >= VFIO_DEV_DBG_LEN)
> +		return -ENOSPC;
> +
> +	ret = hisi_acc_vf_debug_check(vdev);
> +	if (ret)
> +		return -EINVAL;
> +
> +	len = simple_write_to_buffer(tbuf, VFIO_DEV_DBG_LEN - 1,
> +					pos, buffer, count);
> +	if (len < 0 || len > VFIO_DEV_DBG_LEN - 1)
> +		return -EINVAL;
> +	tbuf[len] = '\0';
> +	if (kstrtoul(tbuf, 0, &cmd))
> +		return -EFAULT;
> +
> +	ret = hisi_acc_vf_debug_operate(vdev, cmd);
> +	if (ret) {
> +		dev_err(vdev->dev, "device debug test failed!\n");
> +		return -EINVAL;
> +	}
> +
> +	return count;
> +}
> +
> +static const struct file_operations hisi_acc_vf_debug_fops = {
> +	.owner = THIS_MODULE,
> +	.open = simple_open,
> +	.write = hisi_acc_vf_debug_write,
> +};
> +
> +static void seq_print_hex_data(struct seq_file *seq, const void *buf, size_t len)
> +{
> +#define HEX_LINE_SIZE		131
> +#define HEX_ROW_SIZE		16
> +	unsigned char linebuf[HEX_LINE_SIZE];
> +	int i, linelen, remaining = len;
> +	const u8 *ptr = buf;
> +
> +	for (i = 0; i < len; i += HEX_ROW_SIZE) {
> +		linelen = min(remaining, HEX_ROW_SIZE);
> +		remaining -= HEX_ROW_SIZE;
> +
> +		hex_dump_to_buffer(ptr + i, linelen, HEX_ROW_SIZE, 1,
> +					linebuf, sizeof(linebuf), false);
> +
> +		seq_printf(seq, "%s%.8x: %s\n", "Mig Data:", i, linebuf);
> +	}
> +}
> +
> +static int hisi_acc_vf_data_read(struct seq_file *seq, void *data)
> +{
> +	struct device *vf_dev = seq->private;
> +	struct vfio_pci_core_device *core_device = dev_get_drvdata(vf_dev);
> +	struct vfio_device	*vdev = &core_device->vdev;
> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
> +	struct hisi_acc_vf_migration_file *debug_migf = hisi_acc_vdev->debug_migf;
> +	size_t vf_data_sz = offsetofend(struct acc_vf_data, padding);
> +
> +	if (debug_migf && debug_migf->total_length)
> +		seq_print_hex_data(seq, (unsigned char *)&debug_migf->vf_data,
> +				vf_data_sz);
> +	else
> +		seq_printf(seq, "%s\n", "device not migrated!");
> +
> +	return 0;
> +}
> +
> +static int hisi_acc_vf_attr_read(struct seq_file *seq, void *data)
> +{
> +	struct device *vf_dev = seq->private;
> +	struct vfio_pci_core_device *core_device = dev_get_drvdata(vf_dev);
> +	struct vfio_device	*vdev = &core_device->vdev;
> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
> +	struct hisi_acc_vf_migration_file *debug_migf = hisi_acc_vdev->debug_migf;
> +
> +	if (debug_migf && debug_migf->total_length) {
> +		seq_printf(seq,
> +			 "acc device:\n"
> +			 "device  state: %d\n"
> +			 "device  ready: %u\n"
> +			 "data    valid: %d\n"
> +			 "data     size: %lu\n",
> +			 hisi_acc_vdev->mig_state,
> +			 hisi_acc_vdev->vf_qm_state,
> +			 debug_migf->disabled,
> +			 debug_migf->total_length);
> +	} else {
> +		seq_printf(seq, "%s\n", "device not migrated!");
> +	}
> +
> +	return 0;
> +}
> +
> +static int hisi_acc_vfio_debug_init(struct hisi_acc_vf_core_device *hisi_acc_vdev)
> +{
> +	struct vfio_device *vdev = &hisi_acc_vdev->core_device.vdev;
> +	struct device *dev = vdev->dev;
> +	void *migf = NULL;
> +
> +	if (!debugfs_initialized())
> +		return 0;
> +
> +	vfio_pci_vf_debugfs_init(vdev);
> +
> +	migf = kzalloc(sizeof(struct hisi_acc_vf_migration_file), GFP_KERNEL);
> +	if (!migf)
> +		return -ENOMEM;
> +
> +	hisi_acc_vdev->debug_migf = migf;
> +
> +	debugfs_create_devm_seqfile(dev, "mig_data", vdev->debug_root,
> +				  hisi_acc_vf_data_read);
> +	debugfs_create_devm_seqfile(dev, "mig_attr", vdev->debug_root,
> +				  hisi_acc_vf_attr_read);
> +
> +	debugfs_create_file("debug", 0200, vdev->debug_root,
> +				  vdev, &hisi_acc_vf_debug_fops);

Naming is rather haphazard.  I think this results in vfio_mig/state,
vfio_mig/mig_data, vfio_mig/mig_attr, vfio_mig/debug.  If would be much
cleaner if we had either {state,data,attr,debug} under vfio/migration/
or migration_{state,data,attr,debug} under vfio/

> +
> +	return 0;
> +}
> +
> +static void hisi_acc_vf_debugfs_exit(struct hisi_acc_vf_core_device *hisi_acc_vdev)
> +{
> +	struct vfio_device *vdev = &hisi_acc_vdev->core_device.vdev;
> +
> +	if (!debugfs_initialized())
> +		return;
> +
> +	kfree(hisi_acc_vdev->debug_migf);
> +	vfio_pci_vf_debugfs_exit(vdev);

Ordering is suspect here, we're freeing data used by the debugfs
entries before removing the entries themselves, which suggests a
use-after-free issue.  Thanks,

Alex

> +}
> +
>  static int hisi_acc_vfio_pci_open_device(struct vfio_device *core_vdev)
>  {
>  	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(core_vdev);
> @@ -1410,6 +1686,9 @@ static int hisi_acc_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device
>  	if (IS_ERR(hisi_acc_vdev))
>  		return PTR_ERR(hisi_acc_vdev);
>  
> +	if (ops == &hisi_acc_vfio_pci_migrn_ops)
> +		hisi_acc_vfio_debug_init(hisi_acc_vdev);
> +
>  	dev_set_drvdata(&pdev->dev, &hisi_acc_vdev->core_device);
>  	ret = vfio_pci_core_register_device(&hisi_acc_vdev->core_device);
>  	if (ret)
> @@ -1417,6 +1696,8 @@ static int hisi_acc_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device
>  	return 0;
>  
>  out_put_vdev:
> +	if (ops == &hisi_acc_vfio_pci_migrn_ops)
> +		hisi_acc_vf_debugfs_exit(hisi_acc_vdev);
>  	vfio_put_device(&hisi_acc_vdev->core_device.vdev);
>  	return ret;
>  }
> @@ -1425,6 +1706,7 @@ static void hisi_acc_vfio_pci_remove(struct pci_dev *pdev)
>  {
>  	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_drvdata(pdev);
>  
> +	hisi_acc_vf_debugfs_exit(hisi_acc_vdev);
>  	vfio_pci_core_unregister_device(&hisi_acc_vdev->core_device);
>  	vfio_put_device(&hisi_acc_vdev->core_device.vdev);
>  }
> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
> index dcabfeec6ca1..ef50b12f018d 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
> @@ -49,6 +49,14 @@
>  #define QM_EQC_DW0		0X8000
>  #define QM_AEQC_DW0		0X8020
>  
> +#define VFIO_DEV_DBG_LEN		256
> +
> +enum mig_debug_cmd {
> +	STATE_SAVE,
> +	STATE_RESUME,
> +	RW_IO_TEST,
> +};
> +
>  struct acc_vf_data {
>  #define QM_MATCH_SIZE offsetofend(struct acc_vf_data, qm_rsv_state)
>  	/* QM match information */
> @@ -113,5 +121,8 @@ struct hisi_acc_vf_core_device {
>  	spinlock_t reset_lock;
>  	struct hisi_acc_vf_migration_file *resuming_migf;
>  	struct hisi_acc_vf_migration_file *saving_migf;
> +
> +	/* For debugfs */
> +	struct hisi_acc_vf_migration_file *debug_migf;
>  };
>  #endif /* HISI_ACC_VFIO_PCI_H */

