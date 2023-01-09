Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CD5662156
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbjAIJVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237062AbjAIJVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:21:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED4EB87C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 01:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673255840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=25BMe6/yueYnQUVqJo+FFVWhclGca3esmjGYXD2LPpE=;
        b=NYAe5+dmOaGEfo927uxVc4BiN+MX3Po59rPgfk5rbO6imT8zKuHijLomm9tkIU/9jBOD+W
        HOQxtVEqmYM/Cw9lK6uEXHk8EXAKBIQr1aLpj7gIUNJpEkzXgWudwNfg7UZ5Q7Hi9KTojI
        wlf7Y+eo75OlQNipJiTwDHOJc+CRzKM=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-187-D9YMZA1FMdyY_ONCQBNa6A-1; Mon, 09 Jan 2023 04:17:18 -0500
X-MC-Unique: D9YMZA1FMdyY_ONCQBNa6A-1
Received: by mail-ot1-f69.google.com with SMTP id x26-20020a9d629a000000b0066ea531ed32so4109711otk.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 01:17:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=25BMe6/yueYnQUVqJo+FFVWhclGca3esmjGYXD2LPpE=;
        b=xWtW4WGkcuLb6n5CfFDRPnVXrnK1pDPZeBlGr54bSFCwdR7tLSWsEnTieiu90aLfId
         cMIRFc/fGQxy+XutF/T9GclCDJAAirVHmFcHpLT7zH+zaPvKmUf3dlTFNKsLxNvgjnJg
         0pASbtYtOHcI09ng+8sEbXVsxJ6Z5gFVbJ9W62JqK9BwtjbfuZVql/VMv0D529piXiod
         335euoEUD9vI1ULS2K6ii7ocBB/vh4/dvVyMmTeKuEQetU8SI6c+47fYO6H3me6thhmz
         kmklqGpXjvupKx4tPCbAKV7fUvhtf3XrCyrvD/Lk0tyKtlwI90klxA0KQQWsKCQbgS+o
         idjA==
X-Gm-Message-State: AFqh2kpK640rJWRXjpGN2ta3b9A47TwS3Qg93ZEO+jl6diOhj2MSyYnU
        NiXLWuvb5akl44fSPbEYPYGWVf6P0cM8a6vc/ION5rRvDvY7pKd0TjL2TrzDMee29AOHUdgsIwV
        u8nPVYgPf+gxw0gXQ867s8j8Ms+fF7ASsaqL0XFmb
X-Received: by 2002:a05:6870:4413:b0:144:a97b:1ae2 with SMTP id u19-20020a056870441300b00144a97b1ae2mr3402509oah.35.1673255838107;
        Mon, 09 Jan 2023 01:17:18 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsVc7FkrBVh4eyyu8ylFzm+tvjw2olQNRGzYMHDAoSv2FvHTacfyMd4VFo7/SzjZzra83iQY8953Dy5c5UFkF0=
X-Received: by 2002:a05:6870:4413:b0:144:a97b:1ae2 with SMTP id
 u19-20020a056870441300b00144a97b1ae2mr3402505oah.35.1673255837859; Mon, 09
 Jan 2023 01:17:17 -0800 (PST)
MIME-Version: 1.0
References: <20230104042519.170-1-longpeng2@huawei.com> <20230104014642-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230104014642-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 9 Jan 2023 17:17:06 +0800
Message-ID: <CACGkMEubj2n6oWbgAg_=+b-QC_ApQzSyTJd8ZvANnuKoFMurtA@mail.gmail.com>
Subject: Re: [PATCH v3] vp_vdpa: harden the logic of set status
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     "Longpeng(Mike)" <longpeng2@huawei.com>, sgarzare@redhat.com,
        arei.gonglei@huawei.com, yechuan@huawei.com,
        huangzhichao@huawei.com, virtualization@lists.linux-foundation.org,
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

On Wed, Jan 4, 2023 at 2:50 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Jan 04, 2023 at 12:25:19PM +0800, Longpeng(Mike) wrote:
> > From: Longpeng <longpeng2@huawei.com>
> >
> > 1. We should not set status to 0 when invoking vp_vdpa_set_status(),
> >    trigger a warning in that case.
> >
> > 2. The driver MUST wait for a read of device_status to return 0 before
> >    reinitializing the device. But we also don't want to keep us in an
> >    infinite loop forever, so wait for 5s if we try to reset the device.
> >
> > Signed-off-by: Longpeng <longpeng2@huawei.com>
> > ---
> > Changes v3->v2:
> >  - move VP_VDPA_RESET_TIMEOUT_US near the other macros. [Stefano]
> >  - refer v1.2 in comments. [Stefano]
> >  - s/keep/keeping/  [Jason]
> >  - use readx_poll_timeout. [Jason]
> >
> > Changes v1->v2:
> >  - use WARN_ON instead of BUG_ON. [Stefano]
> >  - use "warning + failed" instead of "infinite loop". [Jason, Stefano]
> >  - use usleep_range instead of msleep (checkpatch). [Longpeng]
> >
> > ---
> >  drivers/vdpa/virtio_pci/vp_vdpa.c | 22 +++++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > index d448db0c4de3..3fc496aea456 100644
> > --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> > +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > @@ -10,6 +10,7 @@
> >
> >  #include <linux/interrupt.h>
> >  #include <linux/module.h>
> > +#include <linux/iopoll.h>
> >  #include <linux/pci.h>
> >  #include <linux/vdpa.h>
> >  #include <linux/virtio.h>
> > @@ -22,6 +23,7 @@
> >  #define VP_VDPA_QUEUE_MAX 256
> >  #define VP_VDPA_DRIVER_NAME "vp_vdpa"
> >  #define VP_VDPA_NAME_SIZE 256
> > +#define VP_VDPA_RESET_TIMEOUT_US 5000000 /* 5s */
> >
> >  struct vp_vring {
> >       void __iomem *notify;
> > @@ -214,6 +216,9 @@ static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
> >       struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
> >       u8 s = vp_vdpa_get_status(vdpa);
> >
> > +     /* We should never be setting status to 0. */
> > +     WARN_ON(status == 0);
> > +
> >       if (status & VIRTIO_CONFIG_S_DRIVER_OK &&
> >           !(s & VIRTIO_CONFIG_S_DRIVER_OK)) {
> >               vp_vdpa_request_irq(vp_vdpa);
>
> Isn't this user-triggerable? What prevents that?

I think it's this in vhost_vdpa_set_status()

    if (status == 0) {
                ret = vdpa_reset(vdpa);
                if (ret)
                        return ret;

The reset was factored out to dedicated config ops.

>
> > @@ -226,10 +231,25 @@ static int vp_vdpa_reset(struct vdpa_device *vdpa)
> >  {
> >       struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> >       struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
> > -     u8 s = vp_vdpa_get_status(vdpa);
> > +     u8 tmp, s = vp_vdpa_get_status(vdpa);
> > +     int ret;
> >
> >       vp_modern_set_status(mdev, 0);
> >
> > +     /*
> > +      * As the virtio v1.1/v1.2 spec (4.1.4.3.2) says: After writing 0 to
> > +      * device_status, the driver MUST wait for a read of device_status
> > +      * to return 0 before reinitializing the device.
> > +      * To avoid keeping us here forever, we only wait for 5 seconds.
> > +      */

5 second might not be sufficient see the discussion about sleep
instead of poll for cvq[1]

> > +     ret = readx_poll_timeout(vp_ioread8, &mdev->common->device_status, tmp,
> > +                              tmp == 0, 1000, VP_VDPA_RESET_TIMEOUT_US);
> > +     if (ret) {
> > +             dev_err(&mdev->pci_dev->dev,
> > +                     "vp_vdpa: fail to reset device, %d\n", ret);
> > +             return ret;
> > +     }
> > +
> >       if (s & VIRTIO_CONFIG_S_DRIVER_OK)
> >               vp_vdpa_free_irq(vp_vdpa);
>
> Do all callers actually check return status of reset?
> If not they will happily reinitialize the device and violate the spec.

Can we simply:

1) start with a very long timeout 1minutes etc
2) break the device when timeout?

Thanks

[1] https://www.spinics.net/lists/netdev/msg869953.html

>
>
>
> > --
> > 2.23.0
>

