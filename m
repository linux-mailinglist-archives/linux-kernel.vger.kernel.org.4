Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F331264E72E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 07:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiLPGD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 01:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLPGD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 01:03:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BB4DEE0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 22:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671170592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UuNQMA6JcfSSdnhdfJmqcm9JUwGwugR4wse2RVyEn1M=;
        b=g0/2hB8wsKd71IZz+DBfC7fZ60WH3M5J0LDj9/cphyWgrZwABVkGzYdGzpyHqBprrSWmIK
        nl1cGW3Tk5IByge1v9gviVf2MKg7X0uwi5kcGUkulSW6p1ycsqctMh4NeQDSwfdIVoOsNX
        5JA+rsrLHH7nQAZB0ZZEEdepj+0c1KQ=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-497-lJ2nYENfPUuzG42YGy4C5A-1; Fri, 16 Dec 2022 01:03:11 -0500
X-MC-Unique: lJ2nYENfPUuzG42YGy4C5A-1
Received: by mail-oo1-f69.google.com with SMTP id v5-20020a056820004500b004a35517bb38so758267oob.18
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 22:03:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UuNQMA6JcfSSdnhdfJmqcm9JUwGwugR4wse2RVyEn1M=;
        b=f3q+gVseRVh88AmywgVUcjP68AjLiHjpMEkHEENCspEQKegsiarZwhw4RfhPvyArme
         Uzc4kx2T3D+r7xgfw7o32HZHTdHqh21dHR5wt/ZLiQLRSKbgVmio08ku/qSMLa9JXFjr
         xF7dBKOIdPDcFDPt7F879S04k7r666WXSb3XFr18aTMHJ5GeHuBBcDmNcvnTrkFFXksm
         SXHP2ch/otFvoaOhpws/q8ei2BscrdGmqiBnix2l2lTllnL0Fr4PydW508Zg0xJlI/Fy
         k+d1byDOS6y4FGKQvX3FNdZ3ZGvLD7tegHm+IwhUOSXD/UQxyozj/xqkef3W9IsHsB7z
         DzjQ==
X-Gm-Message-State: ANoB5pmNMw/WstCLtPRlvHe7xTwd+ZLmkIkOLBgVm+NiEbsCr8+XdAzE
        TzrRECuds09fhgeV6GfJDl9c2asqtZne71KPuohgIPq3MfMBkZW3omOOB5BN4zOdWKcxavfEbyV
        CzQmoTCdh4GDv96oEk43d8y8FDP+UkoVNXkxyEuqc
X-Received: by 2002:a05:6830:6505:b0:66c:fb5b:4904 with SMTP id cm5-20020a056830650500b0066cfb5b4904mr49188797otb.237.1671170590056;
        Thu, 15 Dec 2022 22:03:10 -0800 (PST)
X-Google-Smtp-Source: AA0mqf44wCtaLEGrmygRsNYPZSB/qx0UBsq4nNqJgssZ8o67Es/2EoyDrCzZkJkKlrgTFV17aSqnSElYGuRideppYUs=
X-Received: by 2002:a05:6830:6505:b0:66c:fb5b:4904 with SMTP id
 cm5-20020a056830650500b0066cfb5b4904mr49188794otb.237.1671170589839; Thu, 15
 Dec 2022 22:03:09 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com> <20221205090243.791-1-xieyongji@bytedance.com>
 <20221205090243.791-5-xieyongji@bytedance.com>
In-Reply-To: <20221205090243.791-5-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 16 Dec 2022 14:02:58 +0800
Message-ID: <CACGkMEsf64xOqxzySXDE807-nGy6dwrjT36y7O8ZyPFDrm0Yfw@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] vduse: Support specifying bounce buffer size via sysfs
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     mst@redhat.com, tglx@linutronix.de, hch@lst.de,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
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

On Mon, Dec 5, 2022 at 5:03 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> As discussed in [1], this adds sysfs interface to support
> specifying bounce buffer size in virtio-vdpa case. It would
> be a performance tuning parameter for high throughput workloads.
>
> [1] https://www.spinics.net/lists/netdev/msg754288.html
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 45 +++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index bd1ba6c33e09..0458d61cee1f 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -38,8 +38,11 @@
>  #define DRV_LICENSE  "GPL v2"
>
>  #define VDUSE_DEV_MAX (1U << MINORBITS)
> +#define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> +#define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
>  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> -#define VDUSE_IOVA_SIZE (128 * 1024 * 1024)
> +/* 128 MB reserved for virtqueue creation */
> +#define VDUSE_IOVA_SIZE (VDUSE_MAX_BOUNCE_SIZE + 128 * 1024 * 1024)
>  #define VDUSE_MSG_DEFAULT_TIMEOUT 30
>
>  struct vduse_virtqueue {
> @@ -1795,8 +1798,48 @@ static ssize_t msg_timeout_store(struct device *device,
>
>  static DEVICE_ATTR_RW(msg_timeout);
>
> +static ssize_t bounce_size_show(struct device *device,
> +                               struct device_attribute *attr, char *buf)
> +{
> +       struct vduse_dev *dev = dev_get_drvdata(device);
> +
> +       return sysfs_emit(buf, "%u\n", dev->bounce_size);
> +}
> +
> +static ssize_t bounce_size_store(struct device *device,
> +                                struct device_attribute *attr,
> +                                const char *buf, size_t count)
> +{
> +       struct vduse_dev *dev = dev_get_drvdata(device);
> +       unsigned int bounce_size;
> +       int ret;
> +
> +       ret = -EPERM;
> +       mutex_lock(&dev->domain_lock);
> +       if (dev->domain)
> +               goto unlock;
> +
> +       ret = kstrtouint(buf, 10, &bounce_size);
> +       if (ret < 0)
> +               goto unlock;
> +
> +       ret = -EINVAL;
> +       if (bounce_size > VDUSE_MAX_BOUNCE_SIZE ||
> +           bounce_size < VDUSE_MIN_BOUNCE_SIZE)
> +               goto unlock;
> +
> +       dev->bounce_size = bounce_size & PAGE_MASK;
> +       ret = count;
> +unlock:
> +       mutex_unlock(&dev->domain_lock);
> +       return ret;
> +}
> +
> +static DEVICE_ATTR_RW(bounce_size);
> +
>  static struct attribute *vduse_dev_attrs[] = {
>         &dev_attr_msg_timeout.attr,
> +       &dev_attr_bounce_size.attr,
>         NULL
>  };
>
> --
> 2.20.1
>

