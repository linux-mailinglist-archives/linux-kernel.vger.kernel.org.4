Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3871D6B55C9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 00:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjCJXlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 18:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjCJXlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:41:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCC414ACFF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 15:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678491632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HxX8vHov5bz7n1g1xgu+FlENzzVSYF734USchdmNzEc=;
        b=RdblyYiTgW+a8qnNed9Gysl9vUDKhzu2VhWxaylxDwb5t2vRkB4aPi0jMMDxyBIDPP1sEX
        y4JjWrzbJ1j1TBNHLloxoWpsEN/K8ka8PnP6eclcGyH95VY3tTyCp2L61AG3zakTwu9BDe
        PJNR1VBoIJVOYTLI5EK9QqhscAU/FKk=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-oMJ1-qKyP5G3dhCW-5hTzA-1; Fri, 10 Mar 2023 18:40:31 -0500
X-MC-Unique: oMJ1-qKyP5G3dhCW-5hTzA-1
Received: by mail-io1-f70.google.com with SMTP id i2-20020a5d9e42000000b0074cfcc4ed07so3355048ioi.22
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 15:40:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678491631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HxX8vHov5bz7n1g1xgu+FlENzzVSYF734USchdmNzEc=;
        b=MeDeAhpVc0EHRB/qzF63KdNiHYZQ6CXZcCNAdswYYueXczlQUbbrX6/sIJMLFq/hyZ
         1NbhD6KhNNPsDFQ3tQ6raq4edcc4grTpoCbSONpQ1FTttDxI8u9F46bt1QEcEspfIhew
         ok1gOs3u7YOxdscc8D1e0pmgsW+etrBFkhhvs3bJzqR1djzUm1UpdVisHVxz/qIBsWHC
         AQtBU0imI5gUWAmt3MvPcd8UH7lp6BCoKSzXlj+noQlIJn/ZZWLsczuKj3O3KZtblsLF
         zSCPSXr8wDGtDv82lrs8UBX9EbkkHQ2KYSkeCZmUUb9SvTCy7iw50a4HP6hvpl2vJSs2
         d40w==
X-Gm-Message-State: AO0yUKXX+y4wSZJika5UeoBTcbXfvF2VSw8rNtleCY2Wta/S8xAFQrIR
        j0G691aD4ejrGSyvR2UmUmVXV00bL9f/Au5mgkqY7Qt1UwtKWKQB2DJPUarfYnWsU+pFPRZU1lq
        8nXB8X4bq7bqZbJ59Zcs+Jg8s
X-Received: by 2002:a05:6e02:1c23:b0:316:e793:9dba with SMTP id m3-20020a056e021c2300b00316e7939dbamr8201924ilh.26.1678491630932;
        Fri, 10 Mar 2023 15:40:30 -0800 (PST)
X-Google-Smtp-Source: AK7set+g7dzZB3wAykaA9NHfj3M1KHQRgFSg2d4t4+X9F8jbwnjlzIyGhDiwEiFLag/gzXZHtuRf1Q==
X-Received: by 2002:a05:6e02:1c23:b0:316:e793:9dba with SMTP id m3-20020a056e021c2300b00316e7939dbamr8201908ilh.26.1678491630723;
        Fri, 10 Mar 2023 15:40:30 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id x16-20020a029710000000b003bf39936d1esm371961jai.131.2023.03.10.15.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 15:40:29 -0800 (PST)
Date:   Fri, 10 Mar 2023 16:40:10 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH v8 2/5] hisi_acc_vfio_pci: extract public functions for
 container_of
Message-ID: <20230310164010.3428141f.alex.williamson@redhat.com>
In-Reply-To: <20230217084831.35783-3-liulongfang@huawei.com>
References: <20230217084831.35783-1-liulongfang@huawei.com>
        <20230217084831.35783-3-liulongfang@huawei.com>
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

On Fri, 17 Feb 2023 16:48:28 +0800
Longfang Liu <liulongfang@huawei.com> wrote:

> In the current driver, vdev is obtained from struct
> hisi_acc_vf_core_device through the container_of function.
> This method is used in many places in the driver. In order to
> reduce this repetitive operation, I extracted a public function
> to replace it.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 21 ++++++++++---------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> index a117eaf21c14..a1589947e721 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> @@ -630,6 +630,12 @@ static void hisi_acc_vf_disable_fds(struct hisi_acc_vf_core_device *hisi_acc_vde
>  	}
>  }
>  
> +static struct hisi_acc_vf_core_device *hisi_acc_get_vf_dev(struct vfio_device *vdev)
> +{
> +	return container_of(vdev, struct hisi_acc_vf_core_device,
> +			    core_device.vdev);
> +}

This type of function is often named to_foo_bar(), ex. to_pci_dev(),
and often macros.  Perhaps:

#define to_hisi_acc_dev(n) container_of(n, \
	struct hisi_acc_vf_core_device, core_device,vdev)

Thanks,
Alex

> +
>  /*
>   * This function is called in all state_mutex unlock cases to
>   * handle a 'deferred_reset' if exists.
> @@ -1042,8 +1048,7 @@ static struct file *
>  hisi_acc_vfio_pci_set_device_state(struct vfio_device *vdev,
>  				   enum vfio_device_mig_state new_state)
>  {
> -	struct hisi_acc_vf_core_device *hisi_acc_vdev = container_of(vdev,
> -			struct hisi_acc_vf_core_device, core_device.vdev);
> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
>  	enum vfio_device_mig_state next_state;
>  	struct file *res = NULL;
>  	int ret;
> @@ -1084,8 +1089,7 @@ static int
>  hisi_acc_vfio_pci_get_device_state(struct vfio_device *vdev,
>  				   enum vfio_device_mig_state *curr_state)
>  {
> -	struct hisi_acc_vf_core_device *hisi_acc_vdev = container_of(vdev,
> -			struct hisi_acc_vf_core_device, core_device.vdev);
> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
>  
>  	mutex_lock(&hisi_acc_vdev->state_mutex);
>  	*curr_state = hisi_acc_vdev->mig_state;
> @@ -1301,8 +1305,7 @@ static long hisi_acc_vfio_pci_ioctl(struct vfio_device *core_vdev, unsigned int
>  
>  static int hisi_acc_vfio_pci_open_device(struct vfio_device *core_vdev)
>  {
> -	struct hisi_acc_vf_core_device *hisi_acc_vdev = container_of(core_vdev,
> -			struct hisi_acc_vf_core_device, core_device.vdev);
> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(core_vdev);
>  	struct vfio_pci_core_device *vdev = &hisi_acc_vdev->core_device;
>  	int ret;
>  
> @@ -1325,8 +1328,7 @@ static int hisi_acc_vfio_pci_open_device(struct vfio_device *core_vdev)
>  
>  static void hisi_acc_vfio_pci_close_device(struct vfio_device *core_vdev)
>  {
> -	struct hisi_acc_vf_core_device *hisi_acc_vdev = container_of(core_vdev,
> -			struct hisi_acc_vf_core_device, core_device.vdev);
> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(core_vdev);
>  	struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
>  
>  	iounmap(vf_qm->io_base);
> @@ -1341,8 +1343,7 @@ static const struct vfio_migration_ops hisi_acc_vfio_pci_migrn_state_ops = {
>  
>  static int hisi_acc_vfio_pci_migrn_init_dev(struct vfio_device *core_vdev)
>  {
> -	struct hisi_acc_vf_core_device *hisi_acc_vdev = container_of(core_vdev,
> -			struct hisi_acc_vf_core_device, core_device.vdev);
> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(core_vdev);
>  	struct pci_dev *pdev = to_pci_dev(core_vdev->dev);
>  	struct hisi_qm *pf_qm = hisi_acc_get_pf_qm(pdev);
>  

