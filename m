Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D707C63B844
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 03:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbiK2Cws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 21:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235043AbiK2Cwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 21:52:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AC240918
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 18:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669690316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=voR+tVLmQqRlPEriQ7qrA7EW1w9KMIEFVwLJHnvA21w=;
        b=dpxuzZG6J5tZ2SQT+ILLqF3mrJ2VBJAlqjhRkSylg+ER1M6/GPlsVbh1QyAaIq5WaHs/Hc
        9HgDejpOY7aCm9lWUrSgqkizAPkAgk7J+5/AVMTe2S+7yCk/UBPYFgXc55aLIA2MXXvdWv
        88ocToDPab0qTegjx2gw83MHJ1OLDhk=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-557-5Wyuncy2ORCz7ZReFcbXOg-1; Mon, 28 Nov 2022 21:51:52 -0500
X-MC-Unique: 5Wyuncy2ORCz7ZReFcbXOg-1
Received: by mail-oi1-f199.google.com with SMTP id x203-20020acae0d4000000b0035a623fce1aso4700835oig.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 18:51:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voR+tVLmQqRlPEriQ7qrA7EW1w9KMIEFVwLJHnvA21w=;
        b=Pe6ziRq2EFTjV6rCeOIZzPLuhsmcAJ+alVVnAKaby5oylk3ljN2mOzoU0uov16jqvV
         LUh/Ndx0P/ECROe3am0DQfi9vtmJN3amuM74lR066n0BNbvwwXDcx2C9ov7V13vJBTwi
         v/V70GrridSChsjqA/6Tg1H1xlFzY13l5r/lvd98BqVfGxK/1M35upIK3t9NHblWKQUN
         O7A4yzIhlywDgM9PxYNC5e9afn5AdupIZuE0rCszxRT6hgSnPlCKFAXmqWA/+NXkOiFO
         fubVffQwaM3OLJKHGTZIwXXIxZbhsGFILp8lf/p1ohr7B7gILYjszSk1fBeRkTRD8850
         +9rA==
X-Gm-Message-State: ANoB5pnztAmzFJ9srbAM8LbclVIJHrrZsHju289xZhX5pBXmFiaiCraU
        F8RE7GfUlEtpGMpsO+A3T+0uscG6ubOg+u/5dsSyQKC9SP0oP2/DpCnPxwbWXpDFncZhAKyW0/Y
        ZOSuBhiQPuAdez8W9x8gzU2CpeBg43g7GBk2nFntF
X-Received: by 2002:a05:6830:6505:b0:66c:fb5b:4904 with SMTP id cm5-20020a056830650500b0066cfb5b4904mr27308125otb.237.1669690310449;
        Mon, 28 Nov 2022 18:51:50 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5i64WAEvUPfpHCKkpCBIcAQugNY/V1O3fwBYmcHODLU+tduCJsiQwMgVmU/uiF6Nnj3FthdPfwQpIDLPYdyi0=
X-Received: by 2002:a05:6830:6505:b0:66c:fb5b:4904 with SMTP id
 cm5-20020a056830650500b0066cfb5b4904mr27308121otb.237.1669690310105; Mon, 28
 Nov 2022 18:51:50 -0800 (PST)
MIME-Version: 1.0
References: <20221128025558.2152-1-longpeng2@huawei.com> <CACGkMEsWoM1LKkPWPgDALssjkk4UXxfhYm3_aCFktNnpXtWVjQ@mail.gmail.com>
 <53edc14a-74bb-f9c7-06bd-7ea1047fe613@huawei.com> <20221128051555-mutt-send-email-mst@kernel.org>
 <28c1ae52-38ff-42ce-4331-11f7aa040296@huawei.com> <20221128071917-mutt-send-email-mst@kernel.org>
 <9e9545ab-312c-c9c1-c8ae-8bd6b9f8add6@huawei.com> <20221128084741-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221128084741-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 29 Nov 2022 10:51:39 +0800
Message-ID: <CACGkMEvyaryi1NmaY2VUuCWMV=yhSqfnSaayQTUsLRRo8+RPKg@mail.gmail.com>
Subject: Re: [PATCH] vdpasim: support doorbell mapping
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>, stefanha@redhat.com, sgarzare@redhat.com,
        eperezma@redhat.com, cohuck@redhat.com, arei.gonglei@huawei.com,
        yechuan@huawei.com, huangzhichao@huawei.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
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

On Mon, Nov 28, 2022 at 10:17 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Nov 28, 2022 at 09:20:21PM +0800, Longpeng (Mike, Cloud Infrastru=
cture Service Product Dept.) wrote:
> >
> >
> > =E5=9C=A8 2022/11/28 20:20, Michael S. Tsirkin =E5=86=99=E9=81=93:
> > > On Mon, Nov 28, 2022 at 07:59:33PM +0800, Longpeng (Mike, Cloud Infra=
structure Service Product Dept.) wrote:
> > > >
> > > >
> > > > =E5=9C=A8 2022/11/28 18:19, Michael S. Tsirkin =E5=86=99=E9=81=93:
> > > > > On Mon, Nov 28, 2022 at 04:19:30PM +0800, Longpeng (Mike, Cloud I=
nfrastructure Service Product Dept.) wrote:
> > > > > >
> > > > > >
> > > > > > =E5=9C=A8 2022/11/28 12:05, Jason Wang =E5=86=99=E9=81=93:
> > > > > > > On Mon, Nov 28, 2022 at 10:56 AM Longpeng(Mike) <longpeng2@hu=
awei.com> wrote:
> > > > > > > >
> > > > > > > > From: Longpeng <longpeng2@huawei.com>
> > > > > > > >
> > > > > > > > Support doorbell mapping for vdpasim devices, then we can t=
est the notify
> > > > > > > > passthrough feature even if there's no real hardware on han=
d.
> > > > > > >
> > > > > > > You can use vp_vdpa in L1 plus page_ver_vq in L0 to test it i=
n L2.
> > > > > > > That is how I test it.
> > > > > > >
> > > > > > Yes, using nested virtualization can work, but it's hard to dep=
loy in my
> > > > > > working environment for some reasons, so I decided to emulate t=
his
> > > > > > capability in vdpasim, it's much easier.
> > > > > >
> > > > > > > >
> > > > > > > > Allocates a dummy page which used to emulate the notify pag=
e of the device.
> > > > > > > > All values written to this page would be ignored,  a period=
ic work will
> > > > > > > > check whether there're requests that need to process.
> > > > > > >
> > > > > > > This seems tricky, it means the device is working even if the=
re's no
> > > > > >
> > > > > > Right. It just try to make the vdpasim device work properly, bu=
t the vdpasim
> > > > > > device is only used for testing, so maybe the tricky emulation =
is
> > > > > > acceptable?
> > > > >
> > > > > Maybe. You can try enabling VIRTIO_F_NOTIFICATION_DATA and then
> > > > > looking at the data written to figure out whether
> > > > > you need to poll the vq.
> > > > >
> > > > We can try after the kernel supports the VIRTIO_F_NOTIFICATION_DATA=
 feature,
> > > > while there is still a long way to go.
> > >
> > > That would be up to you to implement ;) It's probably 10-20 lines of
> > > code all in all.
> > >
> >
> > Um...The kick operation won't trigger VMEXIT if we support notify mappi=
ng
> > for the vdpasim device.
> > So, does the vdpasim device has to poll the notify
> > address and then decide which VQ to poll?
> > The pro of this approach is we can poll the notify address first instea=
d of
> > the unconditional poll the VQ, right?
>
> Right. In fact you can do this without VIRTIO_F_NOTIFICATION_DATA too,
> just write 0xffff before checking the vq.

+1

Thanks

>
> >
> > > > >
> > > > > > > kick. If we really want to do, we should try to use page faul=
t handler
> > > > > > > (probably by extending the config ops), but I'm not sure it's=
 worth to
> > > > > > > bother (or if we can find a use case for no simulator devices=
).
> > > > > > >
> > > > > > This need to modify the framework, it seems unworthy.
> > > > > >
> > > > > > > >
> > > > > > > > This cap is disabled as default, users can enable it as fol=
low:
> > > > > > > >      modprobe vdpa_sim notify_passthrough=3Dtrue
> > > > > > > >
> > > > > > > > Signed-off-by: Longpeng <longpeng2@huawei.com>
> > > > > > > > ---
> > > > > > > >     drivers/vdpa/vdpa_sim/vdpa_sim.c     | 71 +++++++++++++=
+++++++++++++--
> > > > > > > >     drivers/vdpa/vdpa_sim/vdpa_sim.h     |  5 +-
> > > > > > > >     drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  5 +-
> > > > > > > >     drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  4 +-
> > > > > > > >     4 files changed, 76 insertions(+), 9 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdp=
a/vdpa_sim/vdpa_sim.c
> > > > > > > > index 7438a89ce939..5c215b56b78b 100644
> > > > > > > > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > > > > > > > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > > > > > > > @@ -14,6 +14,7 @@
> > > > > > > >     #include <linux/slab.h>
> > > > > > > >     #include <linux/sched.h>
> > > > > > > >     #include <linux/dma-map-ops.h>
> > > > > > > > +#include <asm/set_memory.h>
> > > > > > > >     #include <linux/vringh.h>
> > > > > > > >     #include <linux/vdpa.h>
> > > > > > > >     #include <linux/vhost_iotlb.h>
> > > > > > > > @@ -36,9 +37,15 @@ module_param(max_iotlb_entries, int, 044=
4);
> > > > > > > >     MODULE_PARM_DESC(max_iotlb_entries,
> > > > > > > >                     "Maximum number of iotlb entries for ea=
ch address space. 0 means unlimited. (default: 2048)");
> > > > > > > >
> > > > > > > > +static bool notify_passthrough;
> > > > > > > > +module_param(notify_passthrough, bool, 0444);
> > > > > > > > +MODULE_PARM_DESC(notify_passthrough,
> > > > > > > > +                "Enable vq notify(doorbell) area mapping. =
(default: false)");
> > > > > > > > +
> > > > > > > >     #define VDPASIM_QUEUE_ALIGN PAGE_SIZE
> > > > > > > >     #define VDPASIM_QUEUE_MAX 256
> > > > > > > >     #define VDPASIM_VENDOR_ID 0
> > > > > > > > +#define VDPASIM_VRING_POLL_PERIOD 100 /* ms */
> > > > > > > >
> > > > > > > >     static struct vdpasim *vdpa_to_sim(struct vdpa_device *=
vdpa)
> > > > > > > >     {
> > > > > > > > @@ -276,7 +283,7 @@ struct vdpasim *vdpasim_create(struct v=
dpasim_dev_attr *dev_attr,
> > > > > > > >            }
> > > > > > > >
> > > > > > > >            vdpasim->dev_attr =3D *dev_attr;
> > > > > > > > -       INIT_WORK(&vdpasim->work, dev_attr->work_fn);
> > > > > > > > +       INIT_DELAYED_WORK(&vdpasim->vring_work, dev_attr->w=
ork_fn);
> > > > > > > >            spin_lock_init(&vdpasim->lock);
> > > > > > > >            spin_lock_init(&vdpasim->iommu_lock);
> > > > > > > >
> > > > > > > > @@ -287,6 +294,15 @@ struct vdpasim *vdpasim_create(struct =
vdpasim_dev_attr *dev_attr,
> > > > > > > >            set_dma_ops(dev, &vdpasim_dma_ops);
> > > > > > > >            vdpasim->vdpa.mdev =3D dev_attr->mgmt_dev;
> > > > > > > >
> > > > > > > > +       if (notify_passthrough) {
> > > > > > > > +               vdpasim->notify =3D __get_free_page(GFP_KER=
NEL | __GFP_ZERO);
> > > > > > > > +               if (!vdpasim->notify)
> > > > > > > > +                       goto err_iommu;
> > > > > > > > +#ifdef CONFIG_X86
> > > > > > > > +               set_memory_uc(vdpasim->notify, 1);
> > > > > > > > +#endif
> > > > > > >
> > > > > > > What's the reason for using uc memory?
> > > > > > >
> > > > > > The vma->vm_page_prot of notify mapping is pgprot_noncached (se=
e
> > > > > > vhost_vdpa_fault) but the vdpasim->notify is WB, so we should s=
et its
> > > > > > memtype to UC here and set it back to WB when releasing the dev=
ice.
> > > > >
> > > > > You never look at this memory though. Why does it matter whether
> > > > > it's UC or WB?
> > > > >
> > > >
> > > > The warning in trace_pfn_remap() would be triggered.
> > > >
> > > > For example:
> > > >
> > > > x86/PAT: CPU 16/KVM:17819 map pfn RAM range req uncached-minus for =
[mem
> > > > 0x5151f3000-0x5151f3fff], got write-back
> > > >
> > > >
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > >            vdpasim->config =3D kzalloc(dev_attr->config_siz=
e, GFP_KERNEL);
> > > > > > > >            if (!vdpasim->config)
> > > > > > > >                    goto err_iommu;
> > > > > > > > @@ -357,8 +373,11 @@ static void vdpasim_kick_vq(struct vdp=
a_device *vdpa, u16 idx)
> > > > > > > >            struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
> > > > > > > >            struct vdpasim_virtqueue *vq =3D &vdpasim->vqs[i=
dx];
> > > > > > > >
> > > > > > > > +       if (notify_passthrough)
> > > > > > > > +               return;
> > > > > > >
> > > > > > > So we should keep the two paths to be used at the same time. =
Userspace
> > > > > > > can choose to not map doorbells?
> > > > > > >
> > > > > > It can work even if the userspace does not to map doorbells (e.=
g start
> > > > > > without page-per-vq=3Don), because the device will periodic che=
ck its vqs.
> > > > > >
> > > > > > > Thanks
> > > > > > >
> > > > > > > > +
> > > > > > > >            if (vq->ready)
> > > > > > > > -               schedule_work(&vdpasim->work);
> > > > > > > > +               schedule_work(&vdpasim->vring_work.work);
> > > > > > > >     }
> > > > > > > >
> > > > > > > >     static void vdpasim_set_vq_cb(struct vdpa_device *vdpa,=
 u16 idx,
> > > > > > > > @@ -495,6 +514,18 @@ static u8 vdpasim_get_status(struct vd=
pa_device *vdpa)
> > > > > > > >            return status;
> > > > > > > >     }
> > > > > > > >
> > > > > > > > +static void vdpasim_set_vring_work(struct vdpasim *vdpasim=
, bool start)
> > > > > > > > +{
> > > > > > > > +       if (!notify_passthrough)
> > > > > > > > +               return;
> > > > > > > > +
> > > > > > > > +       if (start)
> > > > > > > > +               schedule_delayed_work(&vdpasim->vring_work,
> > > > > > > > +                               msecs_to_jiffies(VDPASIM_VR=
ING_POLL_PERIOD));
> > > > > > > > +       else
> > > > > > > > +               cancel_delayed_work_sync(&vdpasim->vring_wo=
rk);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >     static void vdpasim_set_status(struct vdpa_device *vdpa=
, u8 status)
> > > > > > > >     {
> > > > > > > >            struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
> > > > > > > > @@ -502,12 +533,16 @@ static void vdpasim_set_status(struct=
 vdpa_device *vdpa, u8 status)
> > > > > > > >            spin_lock(&vdpasim->lock);
> > > > > > > >            vdpasim->status =3D status;
> > > > > > > >            spin_unlock(&vdpasim->lock);
> > > > > > > > +
> > > > > > > > +       vdpasim_set_vring_work(vdpasim, status & VIRTIO_CON=
FIG_S_DRIVER_OK);
> > > > > > > >     }
> > > > > > > >
> > > > > > > >     static int vdpasim_reset(struct vdpa_device *vdpa, bool=
 clear)
> > > > > > > >     {
> > > > > > > >            struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
> > > > > > > >
> > > > > > > > +       vdpasim_set_vring_work(vdpasim, false);
> > > > > > > > +
> > > > > > > >            spin_lock(&vdpasim->lock);
> > > > > > > >            vdpasim->status =3D 0;
> > > > > > > >            vdpasim_do_reset(vdpasim);
> > > > > > > > @@ -672,12 +707,24 @@ static int vdpasim_dma_unmap(struct v=
dpa_device *vdpa, unsigned int asid,
> > > > > > > >            return 0;
> > > > > > > >     }
> > > > > > > >
> > > > > > > > +static struct vdpa_notification_area
> > > > > > > > +vdpasim_get_vq_notification(struct vdpa_device *vdpa, u16 =
qid)
> > > > > > > > +{
> > > > > > > > +       struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
> > > > > > > > +       struct vdpa_notification_area notify;
> > > > > > > > +
> > > > > > > > +       notify.addr =3D virt_to_phys((void *)vdpasim->notif=
y);
> > > > > > > > +       notify.size =3D PAGE_SIZE;
> > > > > > > > +
> > > > > > > > +       return notify;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >     static void vdpasim_free(struct vdpa_device *vdpa)
> > > > > > > >     {
> > > > > > > >            struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
> > > > > > > >            int i;
> > > > > > > >
> > > > > > > > -       cancel_work_sync(&vdpasim->work);
> > > > > > > > +       cancel_delayed_work_sync(&vdpasim->vring_work);
> > > > > > > >
> > > > > > > >            for (i =3D 0; i < vdpasim->dev_attr.nvqs; i++) {
> > > > > > > >                    vringh_kiov_cleanup(&vdpasim->vqs[i].out=
_iov);
> > > > > > > > @@ -693,7 +740,23 @@ static void vdpasim_free(struct vdpa_d=
evice *vdpa)
> > > > > > > >            vhost_iotlb_free(vdpasim->iommu);
> > > > > > > >            kfree(vdpasim->vqs);
> > > > > > > >            kfree(vdpasim->config);
> > > > > > > > +       if (vdpasim->notify) {
> > > > > > > > +#ifdef CONFIG_X86
> > > > > > > > +               set_memory_wb(vdpasim->notify, 1);
> > > > > > > > +#endif
> > > > > > > > +               free_page(vdpasim->notify);
> > > > > > > > +       }
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +void vdpasim_schedule_work(struct vdpasim *vdpasim, bool s=
ched_now)
> > > > > > > > +{
> > > > > > > > +       if (sched_now)
> > > > > > > > +               schedule_work(&vdpasim->vring_work.work);
> > > > > > > > +       else if (notify_passthrough)
> > > > > > > > +               schedule_delayed_work(&vdpasim->vring_work,
> > > > > > > > +                                     msecs_to_jiffies(VDPA=
SIM_VRING_POLL_PERIOD));
> > > > > > > >     }
> > > > > > > > +EXPORT_SYMBOL_GPL(vdpasim_schedule_work);
> > > > > > > >
> > > > > > > >     static const struct vdpa_config_ops vdpasim_config_ops =
=3D {
> > > > > > > >            .set_vq_address         =3D vdpasim_set_vq_addre=
ss,
> > > > > > > > @@ -704,6 +767,7 @@ static const struct vdpa_config_ops vdp=
asim_config_ops =3D {
> > > > > > > >            .get_vq_ready           =3D vdpasim_get_vq_ready=
,
> > > > > > > >            .set_vq_state           =3D vdpasim_set_vq_state=
,
> > > > > > > >            .get_vq_state           =3D vdpasim_get_vq_state=
,
> > > > > > > > +       .get_vq_notification    =3D vdpasim_get_vq_notifica=
tion,
> > > > > > > >            .get_vq_align           =3D vdpasim_get_vq_align=
,
> > > > > > > >            .get_vq_group           =3D vdpasim_get_vq_group=
,
> > > > > > > >            .get_device_features    =3D vdpasim_get_device_f=
eatures,
> > > > > > > > @@ -737,6 +801,7 @@ static const struct vdpa_config_ops vdp=
asim_batch_config_ops =3D {
> > > > > > > >            .get_vq_ready           =3D vdpasim_get_vq_ready=
,
> > > > > > > >            .set_vq_state           =3D vdpasim_set_vq_state=
,
> > > > > > > >            .get_vq_state           =3D vdpasim_get_vq_state=
,
> > > > > > > > +       .get_vq_notification    =3D vdpasim_get_vq_notifica=
tion,
> > > > > > > >            .get_vq_align           =3D vdpasim_get_vq_align=
,
> > > > > > > >            .get_vq_group           =3D vdpasim_get_vq_group=
,
> > > > > > > >            .get_device_features    =3D vdpasim_get_device_f=
eatures,
> > > > > > > > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdp=
a/vdpa_sim/vdpa_sim.h
> > > > > > > > index 0e78737dcc16..da0866834918 100644
> > > > > > > > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> > > > > > > > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> > > > > > > > @@ -53,7 +53,7 @@ struct vdpasim_dev_attr {
> > > > > > > >     struct vdpasim {
> > > > > > > >            struct vdpa_device vdpa;
> > > > > > > >            struct vdpasim_virtqueue *vqs;
> > > > > > > > -       struct work_struct work;
> > > > > > > > +       struct delayed_work vring_work;
> > > > > > > >            struct vdpasim_dev_attr dev_attr;
> > > > > > > >            /* spinlock to synchronize virtqueue state */
> > > > > > > >            spinlock_t lock;
> > > > > > > > @@ -69,10 +69,13 @@ struct vdpasim {
> > > > > > > >            bool running;
> > > > > > > >            /* spinlock to synchronize iommu table */
> > > > > > > >            spinlock_t iommu_lock;
> > > > > > > > +       /* dummy notify page */
> > > > > > > > +       unsigned long notify;
> > > > > > > >     };
> > > > > > > >
> > > > > > > >     struct vdpasim *vdpasim_create(struct vdpasim_dev_attr =
*attr,
> > > > > > > >                                   const struct vdpa_dev_set=
_config *config);
> > > > > > > > +void vdpasim_schedule_work(struct vdpasim *vdpasim, bool s=
ched_now);
> > > > > > > >
> > > > > > > >     /* TODO: cross-endian support */
> > > > > > > >     static inline bool vdpasim_is_little_endian(struct vdpa=
sim *vdpasim)
> > > > > > > > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers=
/vdpa/vdpa_sim/vdpa_sim_blk.c
> > > > > > > > index c6db1a1baf76..8a640ea82284 100644
> > > > > > > > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> > > > > > > > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> > > > > > > > @@ -288,7 +288,7 @@ static bool vdpasim_blk_handle_req(stru=
ct vdpasim *vdpasim,
> > > > > > > >
> > > > > > > >     static void vdpasim_blk_work(struct work_struct *work)
> > > > > > > >     {
> > > > > > > > -       struct vdpasim *vdpasim =3D container_of(work, stru=
ct vdpasim, work);
> > > > > > > > +       struct vdpasim *vdpasim =3D container_of(work, stru=
ct vdpasim, vring_work.work);
> > > > > > > >            bool reschedule =3D false;
> > > > > > > >            int i;
> > > > > > > >
> > > > > > > > @@ -325,8 +325,7 @@ static void vdpasim_blk_work(struct wor=
k_struct *work)
> > > > > > > >     out:
> > > > > > > >            spin_unlock(&vdpasim->lock);
> > > > > > > >
> > > > > > > > -       if (reschedule)
> > > > > > > > -               schedule_work(&vdpasim->work);
> > > > > > > > +       vdpasim_schedule_work(vdpasim, reschedule);
> > > > > > > >     }
> > > > > > > >
> > > > > > > >     static void vdpasim_blk_get_config(struct vdpasim *vdpa=
sim, void *config)
> > > > > > > > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers=
/vdpa/vdpa_sim/vdpa_sim_net.c
> > > > > > > > index c3cb225ea469..8b998952384b 100644
> > > > > > > > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > > > > > > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > > > > > > @@ -145,7 +145,7 @@ static void vdpasim_handle_cvq(struct v=
dpasim *vdpasim)
> > > > > > > >
> > > > > > > >     static void vdpasim_net_work(struct work_struct *work)
> > > > > > > >     {
> > > > > > > > -       struct vdpasim *vdpasim =3D container_of(work, stru=
ct vdpasim, work);
> > > > > > > > +       struct vdpasim *vdpasim =3D container_of(work, stru=
ct vdpasim, vring_work.work);
> > > > > > > >            struct vdpasim_virtqueue *txq =3D &vdpasim->vqs[=
1];
> > > > > > > >            struct vdpasim_virtqueue *rxq =3D &vdpasim->vqs[=
0];
> > > > > > > >            ssize_t read, write;
> > > > > > > > @@ -196,7 +196,7 @@ static void vdpasim_net_work(struct wor=
k_struct *work)
> > > > > > > >                    vdpasim_net_complete(rxq, write);
> > > > > > > >
> > > > > > > >                    if (++pkts > 4) {
> > > > > > > > -                       schedule_work(&vdpasim->work);
> > > > > > > > +                       vdpasim_schedule_work(vdpasim, true=
);
> > > > > > > >                            goto out;
> > > > > > > >                    }
> > > > > > > >            }
> > > > > > > > --
> > > > > > > > 2.23.0
> > > > > > > >
> > > > > > >
> > > > > > > .
> > > > >
> > > > > .
> > >
> > > .
>

