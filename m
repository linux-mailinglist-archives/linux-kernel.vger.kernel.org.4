Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D957A67D55A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjAZT3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjAZT3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:29:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9651166E4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674761297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pibdsb1m7bN3Fran8uvYRWJu5eY5gEBJ+VgRn+KTWlk=;
        b=ObyPMFe0QoKFdj1oWvUyj5s4mY4StHRIEGu9QxUeSnaJrLAyQeWWRRCpINsy7lNpKbyQ0y
        UJo/zHuihZBlKSlNr+mGBGE0gkQ9W5ISnTnrufin1zWV5svq5y1LJVgMkOzl8ENhhH4Pvc
        Ge9cLkJoB9zGsPCLvbpaqo4FwRmDQIE=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-441-IZJEDLvdP_KmYl_SBU9tGQ-1; Thu, 26 Jan 2023 14:28:15 -0500
X-MC-Unique: IZJEDLvdP_KmYl_SBU9tGQ-1
Received: by mail-io1-f70.google.com with SMTP id f12-20020a056602038c00b00704b6f4685dso1490641iov.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:28:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pibdsb1m7bN3Fran8uvYRWJu5eY5gEBJ+VgRn+KTWlk=;
        b=HyxHT5fOYFgND3K2l58ioTpmMJRPXxje8ZOnqlN8+8yuN2wE92SHAw3EWdPH4gpGDL
         LlUJVGvnjaLlhGEfwy0bgEaIZR3cqmBiOLCVn/gNJoh4TWRHJzjC4ULNXBjVL+dm3Gc4
         mj9gOk3Vg2dqaOnSWBp1NDooj6rmiyI01C7p4GV4UpKo9KvrOdMz8tR2+5LDSyJhRlHO
         Q9E2k2qHVBCKN0z3BvwLtwTebHouvikY+gV/gPTLokD17tFIVTCG+oeAFvhqH+YLJDQe
         16C/zaJHsSIavyn/IPQzW0JgMEUEwU+0iueu7A4lMwUK+6FDvHPjY4pnpdL/5SEBqI6C
         oCOw==
X-Gm-Message-State: AO0yUKXweRkiZAs2IooxDWK33heQUp7yVVlsY9egVJ4OinG2SVJfJfru
        qEGZdbG7tjQIYvtMEZVY8G8TWhmvAc5IFPudr1bnhs5yxoyppmRyokZK5M6oeXAvn47PSiVik8q
        OK7rgnsAiYp8H1twBtJv7vbAE
X-Received: by 2002:a92:9403:0:b0:310:a923:772e with SMTP id c3-20020a929403000000b00310a923772emr1682901ili.21.1674761294944;
        Thu, 26 Jan 2023 11:28:14 -0800 (PST)
X-Google-Smtp-Source: AK7set82G8yizpFnJomwfaj3Vkzsb/W3hNUrA/Fe/f3rkOfhgB5nSqPOpev8I8m01BTodYQuDtVfBg==
X-Received: by 2002:a92:9403:0:b0:310:a923:772e with SMTP id c3-20020a929403000000b00310a923772emr1682893ili.21.1674761294698;
        Thu, 26 Jan 2023 11:28:14 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id k9-20020a02ccc9000000b003a961e5d33fsm596210jaq.49.2023.01.26.11.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 11:28:14 -0800 (PST)
Date:   Thu, 26 Jan 2023 12:28:08 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH v7 5/5] vfio: update live migration device status
Message-ID: <20230126122808.3c0963f2.alex.williamson@redhat.com>
In-Reply-To: <20230120032930.43608-6-liulongfang@huawei.com>
References: <20230120032930.43608-1-liulongfang@huawei.com>
        <20230120032930.43608-6-liulongfang@huawei.com>
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

On Fri, 20 Jan 2023 11:29:30 +0800
Longfang Liu <liulongfang@huawei.com> wrote:

> migration debugfs needs to perform debug operations based on the
> status of the current device. If the device is not loaded or has
> stopped, debugfs does not allow operations.
> 
> so, after the live migration function is executed and the device is
> turned off, the device no longer needs to be accessed. At this time,
> the status of the device needs to be set to stop.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 3 +++
>  drivers/vfio/pci/mlx5/main.c                   | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> index 96e2a021a956..bdb9043f88f1 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> @@ -1607,6 +1607,9 @@ static void hisi_acc_vfio_pci_close_device(struct vfio_device *core_vdev)
>  	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(core_vdev);
>  	struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
>  
> +	if (core_vdev->mig_ops)
> +		hisi_acc_vdev->mig_state = VFIO_DEVICE_STATE_STOP;
> +
>  	iounmap(vf_qm->io_base);
>  	vfio_pci_core_close_device(core_vdev);
>  }
> diff --git a/drivers/vfio/pci/mlx5/main.c b/drivers/vfio/pci/mlx5/main.c
> index 031ac8cc215d..64b2fe58355a 100644
> --- a/drivers/vfio/pci/mlx5/main.c
> +++ b/drivers/vfio/pci/mlx5/main.c
> @@ -1092,6 +1092,9 @@ static void mlx5vf_pci_close_device(struct vfio_device *core_vdev)
>  	struct mlx5vf_pci_core_device *mvdev = container_of(
>  		core_vdev, struct mlx5vf_pci_core_device, core_device.vdev);
>  
> +	if (mvdev->migrate_cap)
> +		mvdev->mig_state = VFIO_DEVICE_STATE_STOP;
> +
>  	mlx5vf_cmd_close_migratable(mvdev);
>  	vfio_pci_core_close_device(core_vdev);
>  }

It seems prone to issues to manipulate the migration state outside of
the driver state machine.  If the device is closed, shouldn't the
debugfs state interface return -EINVAL?  Thanks,

Alex

