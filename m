Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7ED567FD0A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 07:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjA2GE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 01:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjA2GEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 01:04:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1ACA233CB
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 22:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674972205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=45bUkiep54tmBTJEkS/MNpluSkiEVK+TLNueCz5nf8c=;
        b=Eyj9EzP7WkcTYLrbykQQmPyRwwTcLqpNZzJdS1FdxoBrpjQBjWRxYl9LzvFJbM7+HJSEWX
        uBoxGDuyy2GzxrayVwV2O13RMmdDFCJcss1aHfAjU/gEeH68Z96s2yg5DMfhdwzA9MfEmH
        LYc/k9vW10EOHH7BciHYOTo8wF2aAXw=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-20-YQM2rnvPMfaDDiddBI2sGA-1; Sun, 29 Jan 2023 01:03:23 -0500
X-MC-Unique: YQM2rnvPMfaDDiddBI2sGA-1
Received: by mail-oo1-f69.google.com with SMTP id n15-20020a4a954f000000b005176ac0674dso67179ooi.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 22:03:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45bUkiep54tmBTJEkS/MNpluSkiEVK+TLNueCz5nf8c=;
        b=OCCV9TfbOn/dpmpvk4iJKUzhA8OoMiBmlnUWrejQaiE2qp9b8HpCaJWJgqZkzC//ph
         piJT6k1E6op7oMuMVY51qcM5zSaR2urd8aQQAW5KUjpbcj4pT0xU5R4Agcg6qhdM/tNG
         b9WsTWL9ftnVjQtkyT67HBj2rb9Tm5o+8N+uAXS3IlYPTM7K5zyx9qEulL/NSuiMqvBb
         wW4uzryBROfuWlTOJP4ei3kUpeiM9rkxUdBIWBkqhH3EfQKU43J9juF9eWImOQMkGaKI
         qGVvCyKeVHMmShkVLN+Mzz1UmCz0N1Et5bVJC5dQI9r0JNILJ0NGFZ601KlNuP18KSM6
         QnPw==
X-Gm-Message-State: AO0yUKVdbfZyHs8aAUM1IqZMo6/OYnPk+Nu3K51uNyFY6THj6fPUK6sC
        J9ejNOXFbNIooy24DWHZRJVvZXwrb77JNjeqMd8sSX/v3ogFIlUMSVEwAaUYBh213eMGZte6UCo
        DoMlAAkGwjtD6qy46lUZC9nrLtOACqH2pCjY18R1z
X-Received: by 2002:a05:6870:959e:b0:163:9cea:eea7 with SMTP id k30-20020a056870959e00b001639ceaeea7mr116365oao.35.1674972202964;
        Sat, 28 Jan 2023 22:03:22 -0800 (PST)
X-Google-Smtp-Source: AK7set/OxwOzdOtXUfhziT4PTwF/YD77C6KS9ss0hcg3WVOqPDIPj+fm526ZXLHopV6orFx6BFjwUHOLW0de94q3pvs=
X-Received: by 2002:a05:6870:959e:b0:163:9cea:eea7 with SMTP id
 k30-20020a056870959e00b001639ceaeea7mr116360oao.35.1674972202797; Sat, 28 Jan
 2023 22:03:22 -0800 (PST)
MIME-Version: 1.0
References: <20230129025034.2000-1-longpeng2@huawei.com> <20230129025034.2000-2-longpeng2@huawei.com>
In-Reply-To: <20230129025034.2000-2-longpeng2@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Sun, 29 Jan 2023 14:03:11 +0800
Message-ID: <CACGkMEuq=17Y6E6uSRdsRG8iuMrU6j9AeVS1s1EhnfHeoB+rkA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] vdpa: support specify the pgprot of vq
 notification area
To:     "Longpeng(Mike)" <longpeng2@huawei.com>
Cc:     mst@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
        arei.gonglei@huawei.com, yechuan@huawei.com,
        huangzhichao@huawei.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, eperezma@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 10:51 AM Longpeng(Mike) <longpeng2@huawei.com> wrote:
>
> From: Longpeng <longpeng2@huawei.com>
>
> Adds get_vq_notification_pgprot operation to vdpa_config_ops to support
> specify the pgprot of vq norification area. It's an optional operation,
> the vdpa framework will treat the pgprot of vq notification area as
> noncached as default as usual.

Missing sob.

Other than this.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vhost/vdpa.c | 4 +++-
>  include/linux/vdpa.h | 9 +++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 166044642fd5..036fe88425c8 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1263,7 +1263,9 @@ static vm_fault_t vhost_vdpa_fault(struct vm_fault *vmf)
>
>         notify = ops->get_vq_notification(vdpa, index);
>
> -       vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +       vma->vm_page_prot = ops->get_vq_notification_pgprot ?
> +               ops->get_vq_notification_pgprot(vdpa, index, vma->vm_page_prot) :
> +               pgprot_noncached(vma->vm_page_prot);
>         if (remap_pfn_range(vma, vmf->address & PAGE_MASK,
>                             PFN_DOWN(notify.addr), PAGE_SIZE,
>                             vma->vm_page_prot))
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 6d0f5e4e82c2..07fcf5e6abc8 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -169,6 +169,12 @@ struct vdpa_map_file {
>   *                             @vdev: vdpa device
>   *                             @idx: virtqueue index
>   *                             Returns the notifcation area
> + * @get_vq_notification_pgprot:        Get the pgprot of the vq's notification area (optional)
> + *                             @vdev: vdpa device
> + *                             @idx: virtqueue index
> + *                             @prot: original page protection value of the
> + *                                    notification area
> + *                             Returns pgprot_t: the pgprot of the notification area
>   * @get_vq_irq:                        Get the irq number of a virtqueue (optional,
>   *                             but must implemented if require vq irq offloading)
>   *                             @vdev: vdpa device
> @@ -305,6 +311,9 @@ struct vdpa_config_ops {
>                                    struct netlink_ext_ack *extack);
>         struct vdpa_notification_area
>         (*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
> +       pgprot_t (*get_vq_notification_pgprot)(struct vdpa_device *vdev,
> +                                              u16 idx,
> +                                              pgprot_t prot);
>         /* vq irq is not expected to be changed once DRIVER_OK is set */
>         int (*get_vq_irq)(struct vdpa_device *vdev, u16 idx);
>
> --
> 2.23.0
>

