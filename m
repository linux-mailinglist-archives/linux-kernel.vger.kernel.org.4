Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB896B98D3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjCNPSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCNPSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:18:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E81ADC3B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678807029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RCbk3xG3tE0ULGvAN5kADccbq661Zfa1vx3Fn/fqP4U=;
        b=EJrrIhzimQJdjO+cK1rJxtTSk9TOf/mE5aiuCAI5UaQAFMsockNHaWmXyifOG6dKPZOB9s
        j46xsLd+1R+2ZiwtKIsz8HIjKIF0y1SkApkhuwbSvq0uu+Sl4IDh6Fr0OxZcuP59c/6js8
        kaYp2O7X3EvRJGERs4m4IjLFWHX9y8c=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-_-VrgCguMiiz89oKB1a-JQ-1; Tue, 14 Mar 2023 11:17:08 -0400
X-MC-Unique: _-VrgCguMiiz89oKB1a-JQ-1
Received: by mail-il1-f198.google.com with SMTP id v14-20020a92c80e000000b0031faea6493cso8305682iln.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678807027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCbk3xG3tE0ULGvAN5kADccbq661Zfa1vx3Fn/fqP4U=;
        b=4JGcEnqRWNWQVItq3giEeqStenjsiRtG0umUGiCF8MLq5R8AyeOPzG4WouO6NHgNuL
         73O4dMBLvVzA6D/LSNVixGhF3W3Y5Iiln8dREejgBglg/T+h099TuL0+lmeayLEd0OX5
         vDGYce6OXFKSigvH2sgftksGh1Pes0IqboI3mmyQ1p9qO5LbTtadi0acT6VmVoQaVH3U
         jlUSCifUx7vWP5ht4sSmaVNHdbeJgQIknUe0rrEinIU3NxzRL0wckS6xXlhIg15aMjL8
         6ZOQHeaj0SvG+t04LOxj2vHhbYVYTvmueoogJLXVo3yqL2nrxhZLRb39IarOVjapI4Pm
         1F6w==
X-Gm-Message-State: AO0yUKWpngKbTm8NoNuTssp02sKxExWpMCXWUj/3VjiRtEWZ1XL31n9r
        ROXA4bnggVqO2HVefSQD8H+IRghFZovpujNGBOzW1cPhTXW/dQ1PIymCrEY0Nz4O7l1xaqvzJJE
        y4GPLk32GGkKOYczmpE28yvJVygNFGvJS
X-Received: by 2002:a05:6602:2593:b0:74c:a93c:9d2c with SMTP id p19-20020a056602259300b0074ca93c9d2cmr22487711ioo.5.1678807026775;
        Tue, 14 Mar 2023 08:17:06 -0700 (PDT)
X-Google-Smtp-Source: AK7set9wTIH7J/AyynSZr5LGA7i3kWji07lOkh+w30hbouMMxbJtN1fwPdc/1OvnAhsx6uX9mr0JhQ==
X-Received: by 2002:a05:6602:2593:b0:74c:a93c:9d2c with SMTP id p19-20020a056602259300b0074ca93c9d2cmr22487694ioo.5.1678807026343;
        Tue, 14 Mar 2023 08:17:06 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id f21-20020a02b795000000b0040071bcb216sm839053jam.102.2023.03.14.08.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 08:17:05 -0700 (PDT)
Date:   Tue, 14 Mar 2023 09:17:04 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     liulongfang <liulongfang@huawei.com>
Cc:     <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH v8 3/5] hisi_acc_vfio_pci: register debugfs for
 hisilicon migration driver
Message-ID: <20230314091704.22e8349a.alex.williamson@redhat.com>
In-Reply-To: <d62c93da-e0c9-ddd6-3e2b-bf1a9b62058b@huawei.com>
References: <20230217084831.35783-1-liulongfang@huawei.com>
        <20230217084831.35783-4-liulongfang@huawei.com>
        <20230310164016.7888a207.alex.williamson@redhat.com>
        <fbdda52e-06b4-9e74-7880-e75df5aef546@huawei.com>
        <d62c93da-e0c9-ddd6-3e2b-bf1a9b62058b@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2023 19:21:29 +0800
liulongfang <liulongfang@huawei.com> wrote:

> On 2023/3/14 19:04, liulongfang wrote:
> > On 2023/3/11 7:40, Alex Williamson wrote: =20
> >> On Fri, 17 Feb 2023 16:48:29 +0800
> >> Longfang Liu <liulongfang@huawei.com> wrote:
> >> =20
> >>> On the debugfs framework of VFIO, if the CONFIG_DEBUG_FS macro is
> >>> enabled, the debug function is registered for the live migration driv=
er
> >>> of the HiSilicon accelerator device.
> >>>
> >>> On the basis of the original public debug function, a private debug
> >>> function is added:
> >>>
> >>> mig_data file: used to get the migration data of the live migration d=
evice
> >>> mig_attr file: used to get device attributes of the live migration de=
vice
> >>> debug file: used to test for acquiring and writing device state data
> >>> for VF device.
> >>>
> >>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> >>> ---
> >>>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 282 ++++++++++++++++=
++
> >>>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.h    |  11 +
> >>>  2 files changed, 293 insertions(+)
> >>>
> >>> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers=
/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> >>> index a1589947e721..a0ecb1cd5707 100644
> >>> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> >>> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> >>> @@ -15,6 +15,7 @@
> >>>  #include <linux/anon_inodes.h>
> >>> =20
> >>>  #include "hisi_acc_vfio_pci.h"
> >>> +#include "../../vfio.h"
> >>> =20
> >>>  /* Return 0 on VM acc device ready, -ETIMEDOUT hardware timeout */
> >>>  static int qm_wait_dev_not_ready(struct hisi_qm *qm)
> >>> @@ -606,6 +607,18 @@ hisi_acc_check_int_state(struct hisi_acc_vf_core=
_device *hisi_acc_vdev)
> >>>  	}
> >>>  }
> >>> =20
> >>> +static void hisi_acc_vf_migf_save(struct hisi_acc_vf_migration_file =
*src_migf,
> >>> +	struct hisi_acc_vf_migration_file *dst_migf)
> >>> +{
> >>> +	if (!dst_migf)
> >>> +		return;
> >>> +
> >>> +	dst_migf->disabled =3D false;
> >>> +	dst_migf->total_length =3D src_migf->total_length;
> >>> +	memcpy(&dst_migf->vf_data, &src_migf->vf_data,
> >>> +		    sizeof(struct acc_vf_data));
> >>> +}
> >>> +
> >>>  static void hisi_acc_vf_disable_fd(struct hisi_acc_vf_migration_file=
 *migf)
> >>>  {
> >>>  	mutex_lock(&migf->lock);
> >>> @@ -618,12 +631,16 @@ static void hisi_acc_vf_disable_fd(struct hisi_=
acc_vf_migration_file *migf)
> >>>  static void hisi_acc_vf_disable_fds(struct hisi_acc_vf_core_device *=
hisi_acc_vdev)
> >>>  {
> >>>  	if (hisi_acc_vdev->resuming_migf) {
> >>> +		hisi_acc_vf_migf_save(hisi_acc_vdev->resuming_migf,
> >>> +						hisi_acc_vdev->debug_migf);
> >>>  		hisi_acc_vf_disable_fd(hisi_acc_vdev->resuming_migf);
> >>>  		fput(hisi_acc_vdev->resuming_migf->filp);
> >>>  		hisi_acc_vdev->resuming_migf =3D NULL;
> >>>  	}
> >>> =20
> >>>  	if (hisi_acc_vdev->saving_migf) {
> >>> +		hisi_acc_vf_migf_save(hisi_acc_vdev->saving_migf,
> >>> +						hisi_acc_vdev->debug_migf);
> >>>  		hisi_acc_vf_disable_fd(hisi_acc_vdev->saving_migf);
> >>>  		fput(hisi_acc_vdev->saving_migf->filp);
> >>>  		hisi_acc_vdev->saving_migf =3D NULL;
> >>> @@ -1303,6 +1320,265 @@ static long hisi_acc_vfio_pci_ioctl(struct vf=
io_device *core_vdev, unsigned int
> >>>  	return vfio_pci_core_ioctl(core_vdev, cmd, arg);
> >>>  }
> >>> =20
> >>> +static int hisi_acc_vf_debug_io(struct vfio_device *vdev)
> >>> +{
> >>> +	struct hisi_acc_vf_core_device *hisi_acc_vdev =3D hisi_acc_get_vf_d=
ev(vdev);
> >>> +	struct hisi_qm *vf_qm =3D &hisi_acc_vdev->vf_qm;
> >>> +	struct device *dev =3D vdev->dev;
> >>> +	u64 data;
> >>> +	int ret;
> >>> +
> >>> +	ret =3D qm_wait_dev_not_ready(vf_qm);
> >>> +	if (ret)
> >>> +		dev_err(dev, "VF device not ready!\n");
> >>> +
> >>> +	data =3D readl(vf_qm->io_base + QM_MB_CMD_SEND_BASE);
> >>> +	dev_info(dev, "debug mailbox val: 0x%llx\n", data);
> >>> +
> >>> +	return ret;
> >>> +}
> >>> +
> >>> +static int hisi_acc_vf_debug_resume(struct vfio_device *vdev)
> >>> +{
> >>> +	struct hisi_acc_vf_core_device *hisi_acc_vdev =3D hisi_acc_get_vf_d=
ev(vdev);
> >>> +	struct hisi_acc_vf_migration_file *migf =3D hisi_acc_vdev->debug_mi=
gf;
> >>> +	struct device *dev =3D vdev->dev;
> >>> +	int ret;
> >>> +
> >>> +	ret =3D vf_qm_state_save(hisi_acc_vdev, migf);
> >>> +	if (ret) {
> >>> +		dev_err(dev, "failed to save device data!\n");
> >>> +		return -EINVAL;
> >>> +	}
> >>> +
> >>> +	ret =3D vf_qm_check_match(hisi_acc_vdev, migf);
> >>> +	if (ret) {
> >>> +		dev_err(dev, "failed to match the VF!\n");
> >>> +		return -EINVAL;
> >>> +	}
> >>> +
> >>> +	ret =3D vf_qm_load_data(hisi_acc_vdev, migf);
> >>> +	if (ret) {
> >>> +		dev_err(dev, "failed to recover the VF!\n");
> >>> +		return -EINVAL;
> >>> +	}
> >>> +
> >>> +	vf_qm_fun_reset(&hisi_acc_vdev->vf_qm);
> >>> +	dev_info(dev, "successful to resume device data!\n");
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static int hisi_acc_vf_debug_save(struct vfio_device *vdev)
> >>> +{
> >>> +	struct hisi_acc_vf_core_device *hisi_acc_vdev =3D hisi_acc_get_vf_d=
ev(vdev);
> >>> +	struct hisi_acc_vf_migration_file *migf =3D hisi_acc_vdev->debug_mi=
gf;
> >>> +	struct device *dev =3D vdev->dev;
> >>> +	int ret;
> >>> +
> >>> +	ret =3D vf_qm_state_save(hisi_acc_vdev, migf);
> >>> +	if (ret) {
> >>> +		dev_err(dev, "failed to save device data!\n");
> >>> +		return -EINVAL;
> >>> +	}
> >>> +	dev_info(dev, "successful to save device data!\n");
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static int
> >>> +hisi_acc_vf_debug_operate(struct vfio_device *vdev, unsigned int cmd)
> >>> +{
> >>> +	int ret;
> >>> +
> >>> +	switch (cmd) {
> >>> +	case STATE_SAVE:
> >>> +		ret =3D hisi_acc_vf_debug_save(vdev);
> >>> +		if (ret)
> >>> +			return ret;
> >>> +		break;
> >>> +	case STATE_RESUME:
> >>> +		ret =3D hisi_acc_vf_debug_resume(vdev);
> >>> +		if (ret)
> >>> +			return ret;
> >>> +		break;
> >>> +	case RW_IO_TEST:
> >>> +		ret =3D hisi_acc_vf_debug_io(vdev);
> >>> +		if (ret)
> >>> +			return ret;
> >>> +		break;
> >>> +	default:
> >>> +		return -EINVAL;
> >>> +	}
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static int hisi_acc_vf_debug_check(struct vfio_device *vdev)
> >>> +{
> >>> +	struct hisi_acc_vf_core_device *hisi_acc_vdev =3D hisi_acc_get_vf_d=
ev(vdev);
> >>> +	struct hisi_acc_vf_migration_file *migf =3D hisi_acc_vdev->debug_mi=
gf;
> >>> +	enum vfio_device_mig_state state;
> >>> +
> >>> +	if (!vdev->mig_ops || !migf) {
> >>> +		dev_err(vdev->dev, "device not support debugfs!\n");
> >>> +		return -EINVAL;
> >>> +	}
> >>> +
> >>> +	/* If device not opened, the debugfs operation will trigger calltra=
ce */
> >>> +	(void)vdev->mig_ops->migration_get_state(vdev, &state);
> >>> +	if (state =3D=3D VFIO_DEVICE_STATE_ERROR ||
> >>> +	    state =3D=3D VFIO_DEVICE_STATE_STOP) {
> >>> +		dev_err(vdev->dev, "device not opened!\n");
> >>> +		return -EINVAL;
> >>> +	}
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static ssize_t hisi_acc_vf_debug_write(struct file *filp, const char=
 __user *buffer,
> >>> +			    size_t count, loff_t *pos)
> >>> +{
> >>> +	struct vfio_device	*vdev =3D filp->private_data;
> >>> +	char tbuf[VFIO_DEV_DBG_LEN];
> >>> +	unsigned long cmd;
> >>> +	int len, ret;
> >>> +
> >>> +	if (*pos)
> >>> +		return 0;
> >>> +
> >>> +	if (count >=3D VFIO_DEV_DBG_LEN)
> >>> +		return -ENOSPC;
> >>> +
> >>> +	ret =3D hisi_acc_vf_debug_check(vdev);
> >>> +	if (ret)
> >>> +		return -EINVAL;
> >>> +
> >>> +	len =3D simple_write_to_buffer(tbuf, VFIO_DEV_DBG_LEN - 1,
> >>> +					pos, buffer, count);
> >>> +	if (len < 0 || len > VFIO_DEV_DBG_LEN - 1)
> >>> +		return -EINVAL;
> >>> +	tbuf[len] =3D '\0';
> >>> +	if (kstrtoul(tbuf, 0, &cmd))
> >>> +		return -EFAULT;
> >>> +
> >>> +	ret =3D hisi_acc_vf_debug_operate(vdev, cmd);
> >>> +	if (ret) {
> >>> +		dev_err(vdev->dev, "device debug test failed!\n");
> >>> +		return -EINVAL;
> >>> +	}
> >>> +
> >>> +	return count;
> >>> +}
> >>> +
> >>> +static const struct file_operations hisi_acc_vf_debug_fops =3D {
> >>> +	.owner =3D THIS_MODULE,
> >>> +	.open =3D simple_open,
> >>> +	.write =3D hisi_acc_vf_debug_write,
> >>> +};
> >>> +
> >>> +static void seq_print_hex_data(struct seq_file *seq, const void *buf=
, size_t len)
> >>> +{
> >>> +#define HEX_LINE_SIZE		131
> >>> +#define HEX_ROW_SIZE		16
> >>> +	unsigned char linebuf[HEX_LINE_SIZE];
> >>> +	int i, linelen, remaining =3D len;
> >>> +	const u8 *ptr =3D buf;
> >>> +
> >>> +	for (i =3D 0; i < len; i +=3D HEX_ROW_SIZE) {
> >>> +		linelen =3D min(remaining, HEX_ROW_SIZE);
> >>> +		remaining -=3D HEX_ROW_SIZE;
> >>> +
> >>> +		hex_dump_to_buffer(ptr + i, linelen, HEX_ROW_SIZE, 1,
> >>> +					linebuf, sizeof(linebuf), false);
> >>> +
> >>> +		seq_printf(seq, "%s%.8x: %s\n", "Mig Data:", i, linebuf);
> >>> +	}
> >>> +}
> >>> +
> >>> +static int hisi_acc_vf_data_read(struct seq_file *seq, void *data)
> >>> +{
> >>> +	struct device *vf_dev =3D seq->private;
> >>> +	struct vfio_pci_core_device *core_device =3D dev_get_drvdata(vf_dev=
);
> >>> +	struct vfio_device	*vdev =3D &core_device->vdev;
> >>> +	struct hisi_acc_vf_core_device *hisi_acc_vdev =3D hisi_acc_get_vf_d=
ev(vdev);
> >>> +	struct hisi_acc_vf_migration_file *debug_migf =3D hisi_acc_vdev->de=
bug_migf;
> >>> +	size_t vf_data_sz =3D offsetofend(struct acc_vf_data, padding);
> >>> +
> >>> +	if (debug_migf && debug_migf->total_length)
> >>> +		seq_print_hex_data(seq, (unsigned char *)&debug_migf->vf_data,
> >>> +				vf_data_sz);
> >>> +	else
> >>> +		seq_printf(seq, "%s\n", "device not migrated!");
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static int hisi_acc_vf_attr_read(struct seq_file *seq, void *data)
> >>> +{
> >>> +	struct device *vf_dev =3D seq->private;
> >>> +	struct vfio_pci_core_device *core_device =3D dev_get_drvdata(vf_dev=
);
> >>> +	struct vfio_device	*vdev =3D &core_device->vdev;
> >>> +	struct hisi_acc_vf_core_device *hisi_acc_vdev =3D hisi_acc_get_vf_d=
ev(vdev);
> >>> +	struct hisi_acc_vf_migration_file *debug_migf =3D hisi_acc_vdev->de=
bug_migf;
> >>> +
> >>> +	if (debug_migf && debug_migf->total_length) {
> >>> +		seq_printf(seq,
> >>> +			 "acc device:\n"
> >>> +			 "device  state: %d\n"
> >>> +			 "device  ready: %u\n"
> >>> +			 "data    valid: %d\n"
> >>> +			 "data     size: %lu\n",
> >>> +			 hisi_acc_vdev->mig_state,
> >>> +			 hisi_acc_vdev->vf_qm_state,
> >>> +			 debug_migf->disabled,
> >>> +			 debug_migf->total_length);
> >>> +	} else {
> >>> +		seq_printf(seq, "%s\n", "device not migrated!");
> >>> +	}
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static int hisi_acc_vfio_debug_init(struct hisi_acc_vf_core_device *=
hisi_acc_vdev)
> >>> +{
> >>> +	struct vfio_device *vdev =3D &hisi_acc_vdev->core_device.vdev;
> >>> +	struct device *dev =3D vdev->dev;
> >>> +	void *migf =3D NULL;
> >>> +
> >>> +	if (!debugfs_initialized())
> >>> +		return 0;
> >>> +
> >>> +	vfio_vf_debugfs_init(vdev);
> >>> +
> >>> +	migf =3D kzalloc(sizeof(struct hisi_acc_vf_migration_file), GFP_KER=
NEL);
> >>> +	if (!migf)
> >>> +		return -ENOMEM;
> >>> +
> >>> +	hisi_acc_vdev->debug_migf =3D migf;
> >>> +
> >>> +	debugfs_create_devm_seqfile(dev, "migration_data", vdev->debug_root,
> >>> +				  hisi_acc_vf_data_read);
> >>> +	debugfs_create_devm_seqfile(dev, "migration_attr", vdev->debug_root,
> >>> +				  hisi_acc_vf_attr_read);
> >>> +
> >>> +	debugfs_create_file("migration_debug", 0200, vdev->debug_root,
> >>> +				  vdev, &hisi_acc_vf_debug_fops);
> >>> + =20
> >>
> >> All of these are going to be device specific, right?  So do we really
> >> want a debugfs file structure that looks like:
> >>
> >> vfio
> >> =E2=94=94=E2=94=80=E2=94=80 migration
> >>     =E2=94=9C=E2=94=80=E2=94=80 hisi_acc
> >>     =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 attr
> >>     =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 data
> >>     =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 debug
> >>     =E2=94=94=E2=94=80=E2=94=80 state
> >> =20
> >=20
> > According to this directory structure, I also need to change.
> >=20
> > Thanks
> > Longfang. =20
>=20
> If there are multiple devices participating in live migration, their curr=
ent directory structure
> is like this:
> vfio
> =E2=94=9C=E2=94=80=E2=94=80 hisi_acc_1
> =E2=94=82     =E2=94=9C=E2=94=80=E2=94=80 attr
> =E2=94=82     =E2=94=9C=E2=94=80=E2=94=80 data
> =E2=94=82     =E2=94=9C=E2=94=80=E2=94=80 debug
> =E2=94=82     =E2=94=94=E2=94=80=E2=94=80 state
> =E2=94=82
> =E2=94=94=E2=94=80=E2=94=80 hisi_acc_2
>        =E2=94=9C=E2=94=80=E2=94=80 attr
>        =E2=94=9C=E2=94=80=E2=94=80 data
>        =E2=94=9C=E2=94=80=E2=94=80 debug
>        =E2=94=94=E2=94=80=E2=94=80 state
>=20
>=20
> If you want to change to the above directory structure, which directory s=
hould the
> =E2=80=98state=E2=80=99 file be placed in the case of multiple devices?
> vfio
>  =E2=94=94=E2=94=80 migration
>      =E2=94=9C=E2=94=80=E2=94=80 hisi_acc
>      =E2=94=82     =E2=94=9C=E2=94=80=E2=94=80 attr
>      =E2=94=82     =E2=94=9C=E2=94=80=E2=94=80 data
>      =E2=94=82     =E2=94=94=E2=94=80=E2=94=80 debug
>      =E2=94=94=E2=94=80=E2=94=80 state
>=20
> Like this or other directory structure?
> vfio
> =E2=94=94=E2=94=80 migration
>     =E2=94=9C=E2=94=80=E2=94=80 hisi_acc_1
>     =E2=94=82     =E2=94=9C=E2=94=80=E2=94=80 attr
>     =E2=94=82     =E2=94=9C=E2=94=80=E2=94=80 data
>     =E2=94=82     =E2=94=94=E2=94=80=E2=94=80 debug
>     =E2=94=9C=E2=94=80=E2=94=80 hisi_acc_2
>     =E2=94=82     =E2=94=9C=E2=94=80=E2=94=80 attr
>     =E2=94=82     =E2=94=9C=E2=94=80=E2=94=80 data
>     =E2=94=82     =E2=94=94=E2=94=80=E2=94=80 debug
>     =E2=94=94=E2=94=80=E2=94=80 state
> 	   =E2=94=9C=E2=94=80=E2=94=80 hisi_acc_1
> 	   =E2=94=94=E2=94=80=E2=94=80 hisi_acc_2>=20

I was thinking:

vfio
=E2=94=9C=E2=94=80=E2=94=80 <name1>
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 migration
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 hisi_acc
=E2=94=82=C2=A0=C2=A0     =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 attr
=E2=94=82=C2=A0=C2=A0     =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 data
=E2=94=82=C2=A0=C2=A0     =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80=
 debug
=E2=94=82=C2=A0=C2=A0     =E2=94=94=E2=94=80=E2=94=80 state
=E2=94=94=E2=94=80=E2=94=80 <name2>
    =E2=94=94=E2=94=80=E2=94=80 migration
        =E2=94=9C=E2=94=80=E2=94=80 hisi_acc
        =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 attr
        =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 data
        =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 debug
        =E2=94=94=E2=94=80=E2=94=80 state

My concern is that if {attr,data,debug} have driver specific
definitions, they should have their own driver specific namespace.
Thanks,

Alex

=20
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static void hisi_acc_vf_debugfs_exit(struct hisi_acc_vf_core_device =
*hisi_acc_vdev)
> >>> +{
> >>> +	struct vfio_device *vdev =3D &hisi_acc_vdev->core_device.vdev;
> >>> +
> >>> +	if (!debugfs_initialized())
> >>> +		return;
> >>> +
> >>> +	vfio_vf_debugfs_exit(vdev);
> >>> +	kfree(hisi_acc_vdev->debug_migf);
> >>> +}
> >>> +
> >>>  static int hisi_acc_vfio_pci_open_device(struct vfio_device *core_vd=
ev)
> >>>  {
> >>>  	struct hisi_acc_vf_core_device *hisi_acc_vdev =3D hisi_acc_get_vf_d=
ev(core_vdev);
> >>> @@ -1416,6 +1692,9 @@ static int hisi_acc_vfio_pci_probe(struct pci_d=
ev *pdev, const struct pci_device
> >>>  	if (IS_ERR(hisi_acc_vdev))
> >>>  		return PTR_ERR(hisi_acc_vdev);
> >>> =20
> >>> +	if (ops =3D=3D &hisi_acc_vfio_pci_migrn_ops)
> >>> +		hisi_acc_vfio_debug_init(hisi_acc_vdev);
> >>> +
> >>>  	dev_set_drvdata(&pdev->dev, &hisi_acc_vdev->core_device);
> >>>  	ret =3D vfio_pci_core_register_device(&hisi_acc_vdev->core_device);
> >>>  	if (ret)
> >>> @@ -1423,6 +1702,8 @@ static int hisi_acc_vfio_pci_probe(struct pci_d=
ev *pdev, const struct pci_device
> >>>  	return 0;
> >>> =20
> >>>  out_put_vdev:
> >>> +	if (ops =3D=3D &hisi_acc_vfio_pci_migrn_ops)
> >>> +		hisi_acc_vf_debugfs_exit(hisi_acc_vdev);
> >>>  	vfio_put_device(&hisi_acc_vdev->core_device.vdev);
> >>>  	return ret;
> >>>  }
> >>> @@ -1431,6 +1712,7 @@ static void hisi_acc_vfio_pci_remove(struct pci=
_dev *pdev)
> >>>  {
> >>>  	struct hisi_acc_vf_core_device *hisi_acc_vdev =3D hisi_acc_drvdata(=
pdev);
> >>> =20
> >>> +	hisi_acc_vf_debugfs_exit(hisi_acc_vdev);
> >>>  	vfio_pci_core_unregister_device(&hisi_acc_vdev->core_device);
> >>>  	vfio_put_device(&hisi_acc_vdev->core_device.vdev);
> >>>  }
> >>> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h b/drivers=
/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
> >>> index dcabfeec6ca1..ef50b12f018d 100644
> >>> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
> >>> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
> >>> @@ -49,6 +49,14 @@
> >>>  #define QM_EQC_DW0		0X8000
> >>>  #define QM_AEQC_DW0		0X8020
> >>> =20
> >>> +#define VFIO_DEV_DBG_LEN		256
> >>> +
> >>> +enum mig_debug_cmd {
> >>> +	STATE_SAVE,
> >>> +	STATE_RESUME,
> >>> +	RW_IO_TEST,
> >>> +};
> >>> +
> >>>  struct acc_vf_data {
> >>>  #define QM_MATCH_SIZE offsetofend(struct acc_vf_data, qm_rsv_state)
> >>>  	/* QM match information */
> >>> @@ -113,5 +121,8 @@ struct hisi_acc_vf_core_device {
> >>>  	spinlock_t reset_lock;
> >>>  	struct hisi_acc_vf_migration_file *resuming_migf;
> >>>  	struct hisi_acc_vf_migration_file *saving_migf;
> >>> +
> >>> +	/* For debugfs */
> >>> +	struct hisi_acc_vf_migration_file *debug_migf;
> >>>  };
> >>>  #endif /* HISI_ACC_VFIO_PCI_H */ =20
> >>
> >> .
> >> =20
>=20

