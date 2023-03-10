Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C25E6B55CA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 00:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjCJXlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 18:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjCJXlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:41:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAAB148B78
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 15:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678491628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wu9LkmSpxOiAtUFYVPhtOuM8r6GB/anATzvVtGiRNo0=;
        b=AyqXZqaHb2CqAppaAJnFNBfAHYjkIQMz+hTYMVnSqNiOJoIyI6Hu5JZzuUv1YwKcbpT1gn
        NHXygRSanxgxq+9CqZgYSKCfTWBUJSwDdY9tV1Z3kfVnxBv2KYQAKnhvr7l0I+yO9OWRUj
        u+XNxEd6PBhRNzVICFParl+AGIzEWH0=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-16m9N-PyMtud-pguwUkMlg-1; Fri, 10 Mar 2023 18:40:27 -0500
X-MC-Unique: 16m9N-PyMtud-pguwUkMlg-1
Received: by mail-io1-f71.google.com with SMTP id v10-20020a056602058a00b007076e06ba3dso3279959iox.20
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 15:40:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678491627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wu9LkmSpxOiAtUFYVPhtOuM8r6GB/anATzvVtGiRNo0=;
        b=pq+pSSE23+yv2colQDVaa0Xtl0jKABpU6n7fnECHbyW9Z/BABn4VhDmlS8u95ArCnd
         QGc/bS56YzcPxr7zICtgErGCWc2JdwbGh2w+n4IJE0olzXBuoeDf7aKPeGd2zqWSiUbB
         ufQCn3qTskPIBor4khT8/OeJhxPGrnko7JFGXzb+EAXYgpnQoZQJ3FLDSuVn33lzTH8a
         D2nJafPQoVLHJBc2Opnx/QV9Y9cssJSDRsPQTZ/40U9neoiNPK4SY83ek9/+cTWcXedJ
         tKvfwHScaXay1/RZP5ryBCXPSmXLOsWV6Xx6197Oh6iY9hrF8+a+Mi/hKv156Qpo3Q7/
         Y/WQ==
X-Gm-Message-State: AO0yUKXOxJM7j8LZ+zUOiJ6JyNhTnd76oTITjyK1LQb1lpLc2M6tXLBz
        7kN3/sHUVbmO9K3Sq1/kFQ+tZ1GVdSEg6QxMIKavYf6X9OxwQOj86YdO5H3Kmvk7pihOLGN0pF3
        fg68WP1uMI4hz7fv0vATwoFC+
X-Received: by 2002:a05:6e02:188f:b0:316:fcc6:6ec0 with SMTP id o15-20020a056e02188f00b00316fcc66ec0mr8620370ilu.0.1678491626877;
        Fri, 10 Mar 2023 15:40:26 -0800 (PST)
X-Google-Smtp-Source: AK7set/fQ+pzCRfyKJ7ayOSADT3MUVvFfjT7tizz6cxjbZ/dPFxPxBQy02YvtSyfMauMsNytvFrcTg==
X-Received: by 2002:a05:6e02:188f:b0:316:fcc6:6ec0 with SMTP id o15-20020a056e02188f00b00316fcc66ec0mr8620347ilu.0.1678491626595;
        Fri, 10 Mar 2023 15:40:26 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id x16-20020a029710000000b003bf39936d1esm371961jai.131.2023.03.10.15.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 15:40:26 -0800 (PST)
Date:   Fri, 10 Mar 2023 16:40:16 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH v8 3/5] hisi_acc_vfio_pci: register debugfs for
 hisilicon migration driver
Message-ID: <20230310164016.7888a207.alex.williamson@redhat.com>
In-Reply-To: <20230217084831.35783-4-liulongfang@huawei.com>
References: <20230217084831.35783-1-liulongfang@huawei.com>
        <20230217084831.35783-4-liulongfang@huawei.com>
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

On Fri, 17 Feb 2023 16:48:29 +0800
Longfang Liu <liulongfang@huawei.com> wrote:

> On the debugfs framework of VFIO, if the CONFIG_DEBUG_FS macro is
> enabled, the debug function is registered for the live migration driver
> of the HiSilicon accelerator device.
>=20
> On the basis of the original public debug function, a private debug
> function is added:
>=20
> mig_data file: used to get the migration data of the live migration device
> mig_attr file: used to get device attributes of the live migration device
> debug file: used to test for acquiring and writing device state data
> for VF device.
>=20
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 282 ++++++++++++++++++
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.h    |  11 +
>  2 files changed, 293 insertions(+)
>=20
> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfi=
o/pci/hisilicon/hisi_acc_vfio_pci.c
> index a1589947e721..a0ecb1cd5707 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> @@ -15,6 +15,7 @@
>  #include <linux/anon_inodes.h>
> =20
>  #include "hisi_acc_vfio_pci.h"
> +#include "../../vfio.h"
> =20
>  /* Return 0 on VM acc device ready, -ETIMEDOUT hardware timeout */
>  static int qm_wait_dev_not_ready(struct hisi_qm *qm)
> @@ -606,6 +607,18 @@ hisi_acc_check_int_state(struct hisi_acc_vf_core_dev=
ice *hisi_acc_vdev)
>  	}
>  }
> =20
> +static void hisi_acc_vf_migf_save(struct hisi_acc_vf_migration_file *src=
_migf,
> +	struct hisi_acc_vf_migration_file *dst_migf)
> +{
> +	if (!dst_migf)
> +		return;
> +
> +	dst_migf->disabled =3D false;
> +	dst_migf->total_length =3D src_migf->total_length;
> +	memcpy(&dst_migf->vf_data, &src_migf->vf_data,
> +		    sizeof(struct acc_vf_data));
> +}
> +
>  static void hisi_acc_vf_disable_fd(struct hisi_acc_vf_migration_file *mi=
gf)
>  {
>  	mutex_lock(&migf->lock);
> @@ -618,12 +631,16 @@ static void hisi_acc_vf_disable_fd(struct hisi_acc_=
vf_migration_file *migf)
>  static void hisi_acc_vf_disable_fds(struct hisi_acc_vf_core_device *hisi=
_acc_vdev)
>  {
>  	if (hisi_acc_vdev->resuming_migf) {
> +		hisi_acc_vf_migf_save(hisi_acc_vdev->resuming_migf,
> +						hisi_acc_vdev->debug_migf);
>  		hisi_acc_vf_disable_fd(hisi_acc_vdev->resuming_migf);
>  		fput(hisi_acc_vdev->resuming_migf->filp);
>  		hisi_acc_vdev->resuming_migf =3D NULL;
>  	}
> =20
>  	if (hisi_acc_vdev->saving_migf) {
> +		hisi_acc_vf_migf_save(hisi_acc_vdev->saving_migf,
> +						hisi_acc_vdev->debug_migf);
>  		hisi_acc_vf_disable_fd(hisi_acc_vdev->saving_migf);
>  		fput(hisi_acc_vdev->saving_migf->filp);
>  		hisi_acc_vdev->saving_migf =3D NULL;
> @@ -1303,6 +1320,265 @@ static long hisi_acc_vfio_pci_ioctl(struct vfio_d=
evice *core_vdev, unsigned int
>  	return vfio_pci_core_ioctl(core_vdev, cmd, arg);
>  }
> =20
> +static int hisi_acc_vf_debug_io(struct vfio_device *vdev)
> +{
> +	struct hisi_acc_vf_core_device *hisi_acc_vdev =3D hisi_acc_get_vf_dev(v=
dev);
> +	struct hisi_qm *vf_qm =3D &hisi_acc_vdev->vf_qm;
> +	struct device *dev =3D vdev->dev;
> +	u64 data;
> +	int ret;
> +
> +	ret =3D qm_wait_dev_not_ready(vf_qm);
> +	if (ret)
> +		dev_err(dev, "VF device not ready!\n");
> +
> +	data =3D readl(vf_qm->io_base + QM_MB_CMD_SEND_BASE);
> +	dev_info(dev, "debug mailbox val: 0x%llx\n", data);
> +
> +	return ret;
> +}
> +
> +static int hisi_acc_vf_debug_resume(struct vfio_device *vdev)
> +{
> +	struct hisi_acc_vf_core_device *hisi_acc_vdev =3D hisi_acc_get_vf_dev(v=
dev);
> +	struct hisi_acc_vf_migration_file *migf =3D hisi_acc_vdev->debug_migf;
> +	struct device *dev =3D vdev->dev;
> +	int ret;
> +
> +	ret =3D vf_qm_state_save(hisi_acc_vdev, migf);
> +	if (ret) {
> +		dev_err(dev, "failed to save device data!\n");
> +		return -EINVAL;
> +	}
> +
> +	ret =3D vf_qm_check_match(hisi_acc_vdev, migf);
> +	if (ret) {
> +		dev_err(dev, "failed to match the VF!\n");
> +		return -EINVAL;
> +	}
> +
> +	ret =3D vf_qm_load_data(hisi_acc_vdev, migf);
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
> +	struct hisi_acc_vf_core_device *hisi_acc_vdev =3D hisi_acc_get_vf_dev(v=
dev);
> +	struct hisi_acc_vf_migration_file *migf =3D hisi_acc_vdev->debug_migf;
> +	struct device *dev =3D vdev->dev;
> +	int ret;
> +
> +	ret =3D vf_qm_state_save(hisi_acc_vdev, migf);
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
> +		ret =3D hisi_acc_vf_debug_save(vdev);
> +		if (ret)
> +			return ret;
> +		break;
> +	case STATE_RESUME:
> +		ret =3D hisi_acc_vf_debug_resume(vdev);
> +		if (ret)
> +			return ret;
> +		break;
> +	case RW_IO_TEST:
> +		ret =3D hisi_acc_vf_debug_io(vdev);
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
> +	struct hisi_acc_vf_core_device *hisi_acc_vdev =3D hisi_acc_get_vf_dev(v=
dev);
> +	struct hisi_acc_vf_migration_file *migf =3D hisi_acc_vdev->debug_migf;
> +	enum vfio_device_mig_state state;
> +
> +	if (!vdev->mig_ops || !migf) {
> +		dev_err(vdev->dev, "device not support debugfs!\n");
> +		return -EINVAL;
> +	}
> +
> +	/* If device not opened, the debugfs operation will trigger calltrace */
> +	(void)vdev->mig_ops->migration_get_state(vdev, &state);
> +	if (state =3D=3D VFIO_DEVICE_STATE_ERROR ||
> +	    state =3D=3D VFIO_DEVICE_STATE_STOP) {
> +		dev_err(vdev->dev, "device not opened!\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t hisi_acc_vf_debug_write(struct file *filp, const char __u=
ser *buffer,
> +			    size_t count, loff_t *pos)
> +{
> +	struct vfio_device	*vdev =3D filp->private_data;
> +	char tbuf[VFIO_DEV_DBG_LEN];
> +	unsigned long cmd;
> +	int len, ret;
> +
> +	if (*pos)
> +		return 0;
> +
> +	if (count >=3D VFIO_DEV_DBG_LEN)
> +		return -ENOSPC;
> +
> +	ret =3D hisi_acc_vf_debug_check(vdev);
> +	if (ret)
> +		return -EINVAL;
> +
> +	len =3D simple_write_to_buffer(tbuf, VFIO_DEV_DBG_LEN - 1,
> +					pos, buffer, count);
> +	if (len < 0 || len > VFIO_DEV_DBG_LEN - 1)
> +		return -EINVAL;
> +	tbuf[len] =3D '\0';
> +	if (kstrtoul(tbuf, 0, &cmd))
> +		return -EFAULT;
> +
> +	ret =3D hisi_acc_vf_debug_operate(vdev, cmd);
> +	if (ret) {
> +		dev_err(vdev->dev, "device debug test failed!\n");
> +		return -EINVAL;
> +	}
> +
> +	return count;
> +}
> +
> +static const struct file_operations hisi_acc_vf_debug_fops =3D {
> +	.owner =3D THIS_MODULE,
> +	.open =3D simple_open,
> +	.write =3D hisi_acc_vf_debug_write,
> +};
> +
> +static void seq_print_hex_data(struct seq_file *seq, const void *buf, si=
ze_t len)
> +{
> +#define HEX_LINE_SIZE		131
> +#define HEX_ROW_SIZE		16
> +	unsigned char linebuf[HEX_LINE_SIZE];
> +	int i, linelen, remaining =3D len;
> +	const u8 *ptr =3D buf;
> +
> +	for (i =3D 0; i < len; i +=3D HEX_ROW_SIZE) {
> +		linelen =3D min(remaining, HEX_ROW_SIZE);
> +		remaining -=3D HEX_ROW_SIZE;
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
> +	struct device *vf_dev =3D seq->private;
> +	struct vfio_pci_core_device *core_device =3D dev_get_drvdata(vf_dev);
> +	struct vfio_device	*vdev =3D &core_device->vdev;
> +	struct hisi_acc_vf_core_device *hisi_acc_vdev =3D hisi_acc_get_vf_dev(v=
dev);
> +	struct hisi_acc_vf_migration_file *debug_migf =3D hisi_acc_vdev->debug_=
migf;
> +	size_t vf_data_sz =3D offsetofend(struct acc_vf_data, padding);
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
> +	struct device *vf_dev =3D seq->private;
> +	struct vfio_pci_core_device *core_device =3D dev_get_drvdata(vf_dev);
> +	struct vfio_device	*vdev =3D &core_device->vdev;
> +	struct hisi_acc_vf_core_device *hisi_acc_vdev =3D hisi_acc_get_vf_dev(v=
dev);
> +	struct hisi_acc_vf_migration_file *debug_migf =3D hisi_acc_vdev->debug_=
migf;
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
> +static int hisi_acc_vfio_debug_init(struct hisi_acc_vf_core_device *hisi=
_acc_vdev)
> +{
> +	struct vfio_device *vdev =3D &hisi_acc_vdev->core_device.vdev;
> +	struct device *dev =3D vdev->dev;
> +	void *migf =3D NULL;
> +
> +	if (!debugfs_initialized())
> +		return 0;
> +
> +	vfio_vf_debugfs_init(vdev);
> +
> +	migf =3D kzalloc(sizeof(struct hisi_acc_vf_migration_file), GFP_KERNEL);
> +	if (!migf)
> +		return -ENOMEM;
> +
> +	hisi_acc_vdev->debug_migf =3D migf;
> +
> +	debugfs_create_devm_seqfile(dev, "migration_data", vdev->debug_root,
> +				  hisi_acc_vf_data_read);
> +	debugfs_create_devm_seqfile(dev, "migration_attr", vdev->debug_root,
> +				  hisi_acc_vf_attr_read);
> +
> +	debugfs_create_file("migration_debug", 0200, vdev->debug_root,
> +				  vdev, &hisi_acc_vf_debug_fops);
> +

All of these are going to be device specific, right?  So do we really
want a debugfs file structure that looks like:

vfio
=E2=94=94=E2=94=80=E2=94=80 migration
    =E2=94=9C=E2=94=80=E2=94=80 hisi_acc
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 attr
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 data
    =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 debug
    =E2=94=94=E2=94=80=E2=94=80 state

Thanks,
Alex

> +	return 0;
> +}
> +
> +static void hisi_acc_vf_debugfs_exit(struct hisi_acc_vf_core_device *his=
i_acc_vdev)
> +{
> +	struct vfio_device *vdev =3D &hisi_acc_vdev->core_device.vdev;
> +
> +	if (!debugfs_initialized())
> +		return;
> +
> +	vfio_vf_debugfs_exit(vdev);
> +	kfree(hisi_acc_vdev->debug_migf);
> +}
> +
>  static int hisi_acc_vfio_pci_open_device(struct vfio_device *core_vdev)
>  {
>  	struct hisi_acc_vf_core_device *hisi_acc_vdev =3D hisi_acc_get_vf_dev(c=
ore_vdev);
> @@ -1416,6 +1692,9 @@ static int hisi_acc_vfio_pci_probe(struct pci_dev *=
pdev, const struct pci_device
>  	if (IS_ERR(hisi_acc_vdev))
>  		return PTR_ERR(hisi_acc_vdev);
> =20
> +	if (ops =3D=3D &hisi_acc_vfio_pci_migrn_ops)
> +		hisi_acc_vfio_debug_init(hisi_acc_vdev);
> +
>  	dev_set_drvdata(&pdev->dev, &hisi_acc_vdev->core_device);
>  	ret =3D vfio_pci_core_register_device(&hisi_acc_vdev->core_device);
>  	if (ret)
> @@ -1423,6 +1702,8 @@ static int hisi_acc_vfio_pci_probe(struct pci_dev *=
pdev, const struct pci_device
>  	return 0;
> =20
>  out_put_vdev:
> +	if (ops =3D=3D &hisi_acc_vfio_pci_migrn_ops)
> +		hisi_acc_vf_debugfs_exit(hisi_acc_vdev);
>  	vfio_put_device(&hisi_acc_vdev->core_device.vdev);
>  	return ret;
>  }
> @@ -1431,6 +1712,7 @@ static void hisi_acc_vfio_pci_remove(struct pci_dev=
 *pdev)
>  {
>  	struct hisi_acc_vf_core_device *hisi_acc_vdev =3D hisi_acc_drvdata(pdev=
);
> =20
> +	hisi_acc_vf_debugfs_exit(hisi_acc_vdev);
>  	vfio_pci_core_unregister_device(&hisi_acc_vdev->core_device);
>  	vfio_put_device(&hisi_acc_vdev->core_device.vdev);
>  }
> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h b/drivers/vfi=
o/pci/hisilicon/hisi_acc_vfio_pci.h
> index dcabfeec6ca1..ef50b12f018d 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
> @@ -49,6 +49,14 @@
>  #define QM_EQC_DW0		0X8000
>  #define QM_AEQC_DW0		0X8020
> =20
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

