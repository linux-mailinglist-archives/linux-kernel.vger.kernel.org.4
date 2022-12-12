Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AE6649846
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 04:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiLLDlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 22:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLLDlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 22:41:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1C0CE1B
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 19:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670816419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v2Jhdgvhqn7/x3jk6M2c7nYsIsvq/mkwoEWQTMNqFBc=;
        b=Sr6Y1zKF22SCsm2cUjf2AaCIn30brryh9YVhrdrcXtOV9yhfCFppA36yym6J5hS/XsYzpQ
        NGJikyUicj4dYO3ZERa5Dm3DrWyE7MAEFa8nHLe0XPkO3TvbNeqUBekC6HqWxAYvbh9e8Y
        snwwl765duMSdBU9WboQXFij5fi1MTc=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-316-xT_YnlqpOR-gWZggl07q6Q-1; Sun, 11 Dec 2022 22:40:17 -0500
X-MC-Unique: xT_YnlqpOR-gWZggl07q6Q-1
Received: by mail-oi1-f198.google.com with SMTP id x15-20020a05680801cf00b0035e5fc05887so2960833oic.16
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 19:40:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2Jhdgvhqn7/x3jk6M2c7nYsIsvq/mkwoEWQTMNqFBc=;
        b=5qtxQ8ha4Ud5Od+l6tYip+/Q/Qz4Kd3KWL6izmSdKaE7S2R8FB9qZp2DdiY9d9ioAc
         QyoMCGLa7t+k/5rpIRd0G7YGzZBRpuR14f/71SEkmyZmK8gTqjjGMvgNYVKR31Gkny4P
         +zKI5XkKrgWViIsFHnnrJeeN0Yp9vBZn1c/0Pnz5do/CPobwHwSWwaDLVhNqBL8/qxNv
         cr1bqx4f32FEIu7O6JptGitfRA2p6z+i116UtOcWG2dQC5qo6HM7wX3ponbv24CERvaZ
         PSqhDOk1balk0QtM3lBL9OwdsGsQp4mQRuHQXr3ORn7CCBM5fEpLu89eXKMGQuXnfKO0
         EQ4Q==
X-Gm-Message-State: ANoB5pni5Lmotsj1qgI5NFnBxntf8E03ggzwRM39KGrKt2rEzvzz5fJ/
        pUlC1/nY+B3fkKQBEtCiqXj2m3Tt4HbcDDfCVBAwfSmg4Z2olU9haGjnYkcA6577q1jluBel0Oj
        J0OpStxLiFkj/Vvqz7o2zIh+EN80zGGApekWnYEWk
X-Received: by 2002:a05:6808:1919:b0:35e:7a42:7ab5 with SMTP id bf25-20020a056808191900b0035e7a427ab5mr295368oib.280.1670816417152;
        Sun, 11 Dec 2022 19:40:17 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6xqg0FYwAn7smR6VfO12bdkkyHZU8tVz0Zwr2ajPOOQ9eBW3VgzKf98/hI9GpMaAG4UHsnOC9WsRT+R1m3vwI=
X-Received: by 2002:a05:6808:1919:b0:35e:7a42:7ab5 with SMTP id
 bf25-20020a056808191900b0035e7a427ab5mr295367oib.280.1670816416850; Sun, 11
 Dec 2022 19:40:16 -0800 (PST)
MIME-Version: 1.0
References: <20221205135130.2336-1-longpeng2@huawei.com> <CACGkMEtdT5fG=ffbpQadkGmzHf6Ax-+L50LsriYqJaW++natMg@mail.gmail.com>
 <fb3a6ad0-dc79-9b58-3a32-06e3145a4dad@huawei.com> <CACGkMEtgOArE-g8Frp0CkOZRa8F9YbHm5vSoN31X3-BxgT8YNA@mail.gmail.com>
 <292a164a-fd34-cdd9-ee0e-a6908295ad4b@huawei.com>
In-Reply-To: <292a164a-fd34-cdd9-ee0e-a6908295ad4b@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 12 Dec 2022 11:40:05 +0800
Message-ID: <CACGkMEt4VrxwnFMwfioVMoUE2TZ95GgTC=s1KHFtL_CHFND-2A@mail.gmail.com>
Subject: Re: [PATCH v2] vdpasim: support doorbell mapping
To:     "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
Cc:     stefanha@redhat.com, mst@redhat.com, sgarzare@redhat.com,
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

On Mon, Dec 12, 2022 at 8:51 AM Longpeng (Mike, Cloud Infrastructure
Service Product Dept.) <longpeng2@huawei.com> wrote:
>
>
>
> =E5=9C=A8 2022/12/8 15:37, Jason Wang =E5=86=99=E9=81=93:
> > On Tue, Dec 6, 2022 at 4:46 PM Longpeng (Mike, Cloud Infrastructure
> > Service Product Dept.) <longpeng2@huawei.com> wrote:
> >>
> >>
> >>
> >> =E5=9C=A8 2022/12/6 14:59, Jason Wang =E5=86=99=E9=81=93:
> >>> On Mon, Dec 5, 2022 at 9:52 PM Longpeng(Mike) <longpeng2@huawei.com> =
wrote:
> >>>>
> >>>> From: Longpeng <longpeng2@huawei.com>
> >>>>
> >>>> Support doorbell mapping for vdpasim devices, then we can test the n=
otify
> >>>> passthrough feature even if there's no real hardware on hand.
> >>>>
> >>>> Allocates a dummy page which is used to emulate the notify page of t=
he device,
> >>>> all VQs share the same notify register  that initiated to 0xffff. A =
 periodic
> >>>> work will check whether there're requests need to process ( the valu=
e of the
> >>>> notify register is 0xffff or not ).
> >>>>
> >>>> This cap is disabled as default, users can enable it as follow:
> >>>>     modprobe vdpa_sim notify_passthrough=3Dtrue
> >>>>
> >>>> Signed-off-by: Longpeng <longpeng2@huawei.com>
> >>>> ---
> >>>> Changes v1->v2:
> >>>>     - support both kick mode and passthrough mode. [Jason]
> >>>>     - poll the notify register first. [Jason, Michael]
> >>>> ---
> >>>>    drivers/vdpa/vdpa_sim/vdpa_sim.c | 77 +++++++++++++++++++++++++++=
+++++
> >>>>    drivers/vdpa/vdpa_sim/vdpa_sim.h |  3 ++
> >>>>    2 files changed, 80 insertions(+)
> >>>>
> >>>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_si=
m/vdpa_sim.c
> >>>> index 7438a89ce939..07096a04dabb 100644
> >>>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >>>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >>>> @@ -14,6 +14,7 @@
> >>>>    #include <linux/slab.h>
> >>>>    #include <linux/sched.h>
> >>>>    #include <linux/dma-map-ops.h>
> >>>> +#include <asm/set_memory.h>
> >>>>    #include <linux/vringh.h>
> >>>>    #include <linux/vdpa.h>
> >>>>    #include <linux/vhost_iotlb.h>
> >>>> @@ -36,9 +37,16 @@ module_param(max_iotlb_entries, int, 0444);
> >>>>    MODULE_PARM_DESC(max_iotlb_entries,
> >>>>                    "Maximum number of iotlb entries for each address=
 space. 0 means unlimited. (default: 2048)");
> >>>>
> >>>> +static bool notify_passthrough;
> >>>> +module_param(notify_passthrough, bool, 0444);
> >>>> +MODULE_PARM_DESC(notify_passthrough,
> >>>> +                "Enable vq notify(doorbell) area mapping. (default:=
 false)");
> >>>
> >>> I'm not sure if it's worth doing this, I think we can afford the cost
> >>> of periodic work (especially considering it's a simulator).
> >>>
> >> We can support kick mode and passthgourh mode simultaneously now, it i=
s
> >> a little unnecessary. I would remove it in next version.
> >>
> >>>> +
> >>>>    #define VDPASIM_QUEUE_ALIGN PAGE_SIZE
> >>>>    #define VDPASIM_QUEUE_MAX 256
> >>>>    #define VDPASIM_VENDOR_ID 0
> >>>> +#define VDPASIM_VRING_POLL_PERIOD 100 /* ms */
> >>>> +#define VDPASIM_NOTIFY_DEFVAL 0xffff
> >>>>
> >>>>    static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
> >>>>    {
> >>>> @@ -246,6 +254,28 @@ static const struct dma_map_ops vdpasim_dma_ops=
 =3D {
> >>>>    static const struct vdpa_config_ops vdpasim_config_ops;
> >>>>    static const struct vdpa_config_ops vdpasim_batch_config_ops;
> >>>>
> >>>> +static void vdpasim_notify_work(struct work_struct *work)
> >>>> +{
> >>>> +       struct vdpasim *vdpasim;
> >>>> +       u16 *val;
> >>>> +
> >>>> +       vdpasim =3D container_of(work, struct vdpasim, notify_work.w=
ork);
> >>>> +
> >>>> +       if (!(vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK))
> >>>> +               goto out;
> >>>> +
> >>>> +       if (!vdpasim->running)
> >>>> +               goto out;
> >>>> +
> >>>> +       val =3D (u16 *)vdpasim->notify;
> >>>> +       if (xchg(val, VDPASIM_NOTIFY_DEFVAL) !=3D VDPASIM_NOTIFY_DEF=
VAL)
> >>>> +               schedule_work(&vdpasim->work);
> >>>> +
> >>>> +out:
> >>>> +       schedule_delayed_work(&vdpasim->notify_work,
> >>>> +                             msecs_to_jiffies(VDPASIM_VRING_POLL_PE=
RIOD));
> >>>> +}
> >>>> +
> >>>>    struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
> >>>>                                  const struct vdpa_dev_set_config *c=
onfig)
> >>>>    {
> >>>> @@ -287,6 +317,18 @@ struct vdpasim *vdpasim_create(struct vdpasim_d=
ev_attr *dev_attr,
> >>>>           set_dma_ops(dev, &vdpasim_dma_ops);
> >>>>           vdpasim->vdpa.mdev =3D dev_attr->mgmt_dev;
> >>>>
> >>>> +       if (notify_passthrough) {
> >>>> +               INIT_DELAYED_WORK(&vdpasim->notify_work, vdpasim_not=
ify_work);
> >>>> +
> >>>> +               vdpasim->notify =3D __get_free_page(GFP_KERNEL | __G=
FP_ZERO);
> >>>> +               if (!vdpasim->notify)
> >>>> +                       goto err_iommu;
> >>>> +#ifdef CONFIG_X86
> >>>> +               set_memory_uc(vdpasim->notify, 1);
> >>>> +#endif
> >>>
> >>> I had the same question with version 1, any reason for having this
> >>> part uncacheable? It's a hint that we have bugs somewhere. Are we
> >>> missing ACCESS/ORDER_PLATFORM or other features?
> >>>
> >> Oh, I had replied you in that thread.
> >>
> >> The vm_page_prot of notify mapping VMA is pgprot_noncached (see
> >> vhost_vdpa_fault) but the vdpasim->notify is WB, so we should set its
> >> memtype to UC here and set it back to WB when releasing the device.
> >
> > Ok, but any reason to have a X86 guard for this? This basically makes
> > it won't work for non-x86 archs?
> >
> Because only X86 defines __HAVE_PFNMAP_TRACKING, track_pfn_remap does
> nothing on other archs.

Ok, but this seems fragile, as we don't have a guarantee that it won't
be implemented in the future.

>
> > I think the correct way is to introduce a new config_ops to fetch the
> > correct pgprot. Then we are fine.
> >
> Is it worth doing this?

I think it's worth since it:

1) only require small tweak on the vdpa core
2) avoid arch specific code in the simulator

> It seems the vdpasim device is just a special
> case (using RAM to emulates the notify area) and other real HW devices
> work fine with the current implementation?

There's no guarantee that we won't have any other software based vDPA
devices. We've already had a simulator and VDUSE. And we should not
exclude the possibility of another one.

Thanks

>
> > Thanks
> >
> >>
> >> Otherwise, the warning in trace_pfn_remap() would be triggered.
> >> For example:
> >> x86/PAT: CPU 16/KVM:17819 map pfn RAM range req uncached-minus for [me=
m
> >> 0x5151f3000-0x5151f3fff], got write-back
> >>
> >>>> +               *(u16 *)vdpasim->notify =3D VDPASIM_NOTIFY_DEFVAL;
> >>>
> >>> WRITE_ONCE()?
> >>>
> >> Okay.
> >>
> >>>> +       }
> >>>> +
> >>>>           vdpasim->config =3D kzalloc(dev_attr->config_size, GFP_KER=
NEL);
> >>>>           if (!vdpasim->config)
> >>>>                   goto err_iommu;
> >>>> @@ -495,6 +537,18 @@ static u8 vdpasim_get_status(struct vdpa_device=
 *vdpa)
> >>>>           return status;
> >>>>    }
> >>>>
> >>>> +static void vdpasim_set_notify_work(struct vdpasim *vdpasim, bool s=
tart)
> >>>> +{
> >>>> +       if (!notify_passthrough)
> >>>> +               return;
> >>>
> >>> Only two callers for this function: one is start another is stop. If
> >>> we decide to get rid of notify_passthrough, I'd rather opencode the
> >>> schedule/cancel_delayed().
> >>>
> >> Okay, thanks.
> >>
> >>> Thanks
> >>>
> >>>> +
> >>>> +       if (start)
> >>>> +               schedule_delayed_work(&vdpasim->notify_work,
> >>>> +                                     msecs_to_jiffies(VDPASIM_VRING=
_POLL_PERIOD));
> >>>> +       else
> >>>> +               cancel_delayed_work_sync(&vdpasim->notify_work);
> >>>> +}
> >>>> +
> >>>>    static void vdpasim_set_status(struct vdpa_device *vdpa, u8 statu=
s)
> >>>>    {
> >>>>           struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
> >>>> @@ -502,12 +556,14 @@ static void vdpasim_set_status(struct vdpa_dev=
ice *vdpa, u8 status)
> >>>>           spin_lock(&vdpasim->lock);
> >>>>           vdpasim->status =3D status;
> >>>>           spin_unlock(&vdpasim->lock);
> >>>> +       vdpasim_set_notify_work(vdpasim, status & VIRTIO_CONFIG_S_DR=
IVER_OK);
> >>>>    }
> >>>>
> >>>>    static int vdpasim_reset(struct vdpa_device *vdpa, bool clear)
> >>>>    {
> >>>>           struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
> >>>>
> >>>> +       vdpasim_set_notify_work(vdpasim, false);
> >>>>           spin_lock(&vdpasim->lock);
> >>>>           vdpasim->status =3D 0;
> >>>>           vdpasim_do_reset(vdpasim);
> >>>> @@ -672,11 +728,24 @@ static int vdpasim_dma_unmap(struct vdpa_devic=
e *vdpa, unsigned int asid,
> >>>>           return 0;
> >>>>    }
> >>>>
> >>>> +static struct vdpa_notification_area
> >>>> +vdpasim_get_vq_notification(struct vdpa_device *vdpa, u16 qid)
> >>>> +{
> >>>> +       struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
> >>>> +       struct vdpa_notification_area notify;
> >>>> +
> >>>> +       notify.addr =3D virt_to_phys((void *)vdpasim->notify);
> >>>> +       notify.size =3D PAGE_SIZE;
> >>>> +
> >>>> +       return notify;
> >>>> +}
> >>>> +
> >>>>    static void vdpasim_free(struct vdpa_device *vdpa)
> >>>>    {
> >>>>           struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
> >>>>           int i;
> >>>>
> >>>> +       vdpasim_set_notify_work(vdpasim, false);
> >>>>           cancel_work_sync(&vdpasim->work);
> >>>>
> >>>>           for (i =3D 0; i < vdpasim->dev_attr.nvqs; i++) {
> >>>> @@ -693,6 +762,12 @@ static void vdpasim_free(struct vdpa_device *vd=
pa)
> >>>>           vhost_iotlb_free(vdpasim->iommu);
> >>>>           kfree(vdpasim->vqs);
> >>>>           kfree(vdpasim->config);
> >>>> +       if (vdpasim->notify) {
> >>>> +#ifdef CONFIG_X86
> >>>> +               set_memory_wb(vdpasim->notify, 1);
> >>>> +#endif
> >>>> +               free_page(vdpasim->notify);
> >>>> +       }
> >>>>    }
> >>>>
> >>>>    static const struct vdpa_config_ops vdpasim_config_ops =3D {
> >>>> @@ -704,6 +779,7 @@ static const struct vdpa_config_ops vdpasim_conf=
ig_ops =3D {
> >>>>           .get_vq_ready           =3D vdpasim_get_vq_ready,
> >>>>           .set_vq_state           =3D vdpasim_set_vq_state,
> >>>>           .get_vq_state           =3D vdpasim_get_vq_state,
> >>>> +       .get_vq_notification    =3D vdpasim_get_vq_notification,
> >>>>           .get_vq_align           =3D vdpasim_get_vq_align,
> >>>>           .get_vq_group           =3D vdpasim_get_vq_group,
> >>>>           .get_device_features    =3D vdpasim_get_device_features,
> >>>> @@ -737,6 +813,7 @@ static const struct vdpa_config_ops vdpasim_batc=
h_config_ops =3D {
> >>>>           .get_vq_ready           =3D vdpasim_get_vq_ready,
> >>>>           .set_vq_state           =3D vdpasim_set_vq_state,
> >>>>           .get_vq_state           =3D vdpasim_get_vq_state,
> >>>> +       .get_vq_notification    =3D vdpasim_get_vq_notification,
> >>>>           .get_vq_align           =3D vdpasim_get_vq_align,
> >>>>           .get_vq_group           =3D vdpasim_get_vq_group,
> >>>>           .get_device_features    =3D vdpasim_get_device_features,
> >>>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_si=
m/vdpa_sim.h
> >>>> index 0e78737dcc16..0769ccbd3911 100644
> >>>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> >>>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> >>>> @@ -69,6 +69,9 @@ struct vdpasim {
> >>>>           bool running;
> >>>>           /* spinlock to synchronize iommu table */
> >>>>           spinlock_t iommu_lock;
> >>>> +       /* dummy notify page */
> >>>> +       unsigned long notify;
> >>>> +       struct delayed_work notify_work;
> >>>>    };
> >>>>
> >>>>    struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *attr,
> >>>> --
> >>>> 2.23.0
> >>>>
> >>>
> >>> .
> >>
> >
> > .
>

