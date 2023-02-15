Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0446697408
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 03:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjBOCBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 21:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjBOCBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 21:01:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EF7234FE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 18:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676426445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1jbzmLQHVv2tkOdLBbVZkdyTHtnIEvKSkdpfnMaOErA=;
        b=d9KHA5YdytIADEYu2bDRV4dLymIHBdYhg/2LsL3Quc1+2bodIqMqPNFL4VINC9M91Qwep6
        G681O3Zmh9el3l1Rm+gFw3gOaBW72c3RoCmKfesFizGiMdGvpCRorxY4s+hufXqwzTCpMq
        28NairRBREvT2psKj2vnJlkh32VaHVI=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-333-VbDfs1WzMBibt8H4YQ1TEg-1; Tue, 14 Feb 2023 21:00:44 -0500
X-MC-Unique: VbDfs1WzMBibt8H4YQ1TEg-1
Received: by mail-oi1-f200.google.com with SMTP id q14-20020a056808200e00b0037ab5869804so3508810oiw.22
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 18:00:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jbzmLQHVv2tkOdLBbVZkdyTHtnIEvKSkdpfnMaOErA=;
        b=Fh3sc88+Ld4s7ropZ+bj4Z5C9KXRA+Kuc+qUxMo1YK1CS4lySluU6Ax0G7N49y5D3g
         4Ut86pmVaVQHdTW2i7EFrbHZlB0xtVA05AwH+jSYSwOQPNB+S239yiFV6l766WKK24nU
         zCfsk78oJtZeiX5Z1/gtDOduvRheDKNv2+6PZvLn6tz/fETcFBoGu/XcvfSzs3Hnc8GN
         k6HDEL4PoX58OTMEnrgYSWz15mKvV2nRl8p9EVIaZw1hwl+GiNUPykgrCZed7MQClE2X
         +YhOUZ9zT+OKcnADKu2NUn/ibjvRDEVtKRiRJaElxGc4W2nFs8dr4d88nBdh9JR7/Pcb
         jfSA==
X-Gm-Message-State: AO0yUKUNDYN1NMnnv8EZdS+8VSDrYbFjRZwYkAKOxUjI6V5SAe1tiQKc
        UnAkciPuD9CHwSepm4YWt1+p2CvS75kaJIsQstghEySWSTdD2jIRMFrA3HkH2PdLpaO/9YxTrAI
        /rHV/V1Xl4KomgqJW7Kc/ntSKhTJginDlVFOWLgtO
X-Received: by 2002:aca:1119:0:b0:37d:5d77:e444 with SMTP id 25-20020aca1119000000b0037d5d77e444mr93981oir.35.1676426443506;
        Tue, 14 Feb 2023 18:00:43 -0800 (PST)
X-Google-Smtp-Source: AK7set/qjD0jsbngTzW6Ai6mzSW3H5nHco+/NJVQUkWR/xFc2QQvufuo+qETx3tdntuJ7uWec6Z8ZZrWeFqRJJKM0O0=
X-Received: by 2002:aca:1119:0:b0:37d:5d77:e444 with SMTP id
 25-20020aca1119000000b0037d5d77e444mr93974oir.35.1676426443204; Tue, 14 Feb
 2023 18:00:43 -0800 (PST)
MIME-Version: 1.0
References: <20230131145310.2069-1-longpeng2@huawei.com> <db99245c-606a-2f24-52fe-836a6972437f@redhat.com>
 <35b94992-0c6b-a190-1fce-5dda9c8dcf4b@huawei.com>
In-Reply-To: <35b94992-0c6b-a190-1fce-5dda9c8dcf4b@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 15 Feb 2023 10:00:32 +0800
Message-ID: <CACGkMEt0Rgkcmt9k4dWsp-qqtPvrM40mtgmSERc0A7Ve1wzKHw@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: cleanup memory maps when closing vdpa fds
To:     "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
Cc:     mst@redhat.com, arei.gonglei@huawei.com, yechuan@huawei.com,
        huangzhichao@huawei.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Feb 14, 2023 at 2:28 PM Longpeng (Mike, Cloud Infrastructure
Service Product Dept.) <longpeng2@huawei.com> wrote:
>
>
>
> =E5=9C=A8 2023/2/14 14:16, Jason Wang =E5=86=99=E9=81=93:
> >
> > =E5=9C=A8 2023/1/31 22:53, Longpeng(Mike) =E5=86=99=E9=81=93:
> >> From: Longpeng <longpeng2@huawei.com>
> >>
> >> We must cleanup all memory maps when closing the vdpa fds, otherwise
> >> some critical resources (e.g. memory, iommu map) will leaked if the
> >> userspace exits unexpectedly (e.g. kill -9).
> >
> >
> > Sounds like a bug of the kernel, should we fix there?
> >
>
> For example, the iommu map is setup when QEMU calls VHOST_IOTLB_UPDATE
> ioctl and it'll be freed if QEMU calls VHOST_IOTLB_INVALIDATE ioctl.
>
> So maybe we release these resources in vdpa framework in kernel is a
> suitable choice?

I think I need understand what does "resources" mean here:

For iommu mapping, it should be freed by vhost_vdpa_free_domain() in
vhost_vdpa_release()?

static int vhost_vdpa_release(struct inode *inode, struct file *filep)
{
        struct vhost_vdpa *v =3D filep->private_data;
        struct vhost_dev *d =3D &v->vdev;

        mutex_lock(&d->mutex);
        filep->private_data =3D NULL;
        vhost_vdpa_clean_irq(v);
        vhost_vdpa_reset(v);
        vhost_dev_stop(&v->vdev);
        vhost_vdpa_free_domain(v);
        vhost_vdpa_config_put(v);
        vhost_vdpa_cleanup(v);
        mutex_unlock(&d->mutex);

        atomic_dec(&v->opened);
        complete(&v->completion);

        return 0;
}

>
> By the way, Jason, can you reproduce the problem in your machine?
>

Haven't got time in doing this but it should be the responsibility of
the author to validate this anyhow.

Thanks

> > Thanks
> >
> >
> >>
> >> Signed-off-by: Longpeng <longpeng2@huawei.com>
> >> ---
> >>   drivers/vhost/vdpa.c | 13 +++++++++++++
> >>   1 file changed, 13 insertions(+)
> >>
> >> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> >> index a527eeeac637..37477cffa5aa 100644
> >> --- a/drivers/vhost/vdpa.c
> >> +++ b/drivers/vhost/vdpa.c
> >> @@ -823,6 +823,18 @@ static void vhost_vdpa_unmap(struct vhost_vdpa *v=
,
> >>           vhost_vdpa_remove_as(v, asid);
> >>   }
> >> +static void vhost_vdpa_clean_map(struct vhost_vdpa *v)
> >> +{
> >> +    struct vhost_vdpa_as *as;
> >> +    u32 asid;
> >> +
> >> +    for (asid =3D 0; asid < v->vdpa->nas; asid++) {
> >> +        as =3D asid_to_as(v, asid);
> >> +        if (as)
> >> +            vhost_vdpa_unmap(v, &as->iotlb, 0ULL, 0ULL - 1);
> >> +    }
> >> +}
> >> +
> >>   static int vhost_vdpa_va_map(struct vhost_vdpa *v,
> >>                    struct vhost_iotlb *iotlb,
> >>                    u64 iova, u64 size, u64 uaddr, u32 perm)
> >> @@ -1247,6 +1259,7 @@ static int vhost_vdpa_release(struct inode
> >> *inode, struct file *filep)
> >>       vhost_vdpa_clean_irq(v);
> >>       vhost_vdpa_reset(v);
> >>       vhost_dev_stop(&v->vdev);
> >> +    vhost_vdpa_clean_map(v);
> >>       vhost_vdpa_free_domain(v);
> >>       vhost_vdpa_config_put(v);
> >>       vhost_vdpa_cleanup(v);
> >
> > .
>

