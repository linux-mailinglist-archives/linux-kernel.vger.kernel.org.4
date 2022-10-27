Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0F960F2D4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 10:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbiJ0Ir6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 04:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234730AbiJ0Irz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:47:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2450C10061
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 01:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666860473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nqtSpBMDCcN2ix8DvRzpgy83UP9vW+xusqxBXIW/HTE=;
        b=LsXwdm4G4ZX7LzGUQ8WoFS/N/GA1C6w0iQQ6oMPn7aZCpArbovwI5xrkrawap3ElnxAXGz
        jW0pwbxHG80o6K7rHgQNjJ39LBMGz2RldC+ytTN0zHVQpqntjK3DZWuHFLZWz9lhLPcSC/
        HJudY8cywzbjZiXIHEohqK+9jXdMQbc=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-346-4Gy6yVtNNOmQNAaGUOC4ng-1; Thu, 27 Oct 2022 04:47:50 -0400
X-MC-Unique: 4Gy6yVtNNOmQNAaGUOC4ng-1
Received: by mail-oi1-f197.google.com with SMTP id o12-20020a056808124c00b00353f308fb4bso496662oiv.22
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 01:47:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqtSpBMDCcN2ix8DvRzpgy83UP9vW+xusqxBXIW/HTE=;
        b=Ae86U8QbbiWh0gPpN3zAWH9t1RBQZ/kslmpy+UmDTLLuFrfCn4kM6WcPleWaheLPmf
         yj9i/BolJiCKXdpJQCP2fodtyFrl8zHBtr99mZDH/fHt25VXaH8vemri5UUaPuWyYfcU
         9PajBUO1CLPNlqiu+wcAmK5ppmtEmiZBWcC6+JSPVx90IDx9g9RMQ4T29QmlcsGaI8F/
         fU8mBZM1zEsyMLGajeqQROjhKsp2YVhSmzZZiFmhzO+Fxx3GkfyPwysdRRWDS71h7fSt
         yFG3JdBoxt7eSCMfZQ1JilhPBHb8blVuSrocpCS5j1Us9qNwTLwWoEDDPnV5uH+xCbCO
         EUOg==
X-Gm-Message-State: ACrzQf1SMQAOtGxGNaBZi1Y9CGH5IYiKAh5sSqZjCuS9SmQjAIm6hBe3
        nXEnr4fWF76cDAP/TzrkfbCfzlq99seRwZLe6q6G/kImH6Xf5rE+h+h2Fibo+HZE6ZiU2im40J1
        7zOpVcpQzQOTE8djMk6czobnOSIPrUSmLIOE6cw47
X-Received: by 2002:a05:6808:1985:b0:354:d7cf:9acb with SMTP id bj5-20020a056808198500b00354d7cf9acbmr4205545oib.280.1666860469201;
        Thu, 27 Oct 2022 01:47:49 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7ot3Sx+jwykouqqe2Lf2fwAVDKZwuLJR/DMiwZeh5zpaEMHJ3NtsxJ2TuYlzFthtDd2ATTOXflQ0G9KyJUPJI=
X-Received: by 2002:a05:6808:1985:b0:354:d7cf:9acb with SMTP id
 bj5-20020a056808198500b00354d7cf9acbmr4205528oib.280.1666860468823; Thu, 27
 Oct 2022 01:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <1666392237-4042-1-git-send-email-si-wei.liu@oracle.com>
 <1666392237-4042-4-git-send-email-si-wei.liu@oracle.com> <CACGkMEti0Z2_sqJbBh_bOVq2ijSUJ96OPS-qd+P4bV490XAA3w@mail.gmail.com>
 <5b9efa3a-8a82-4bd1-a5b4-b9ca5b15b51a@oracle.com> <CACGkMEsEN+BMJkAk4YRkatTLnW8nmnZM8d_wzSwgPM0nFfh=Kw@mail.gmail.com>
 <25a18d7a-ebae-3647-32f0-14ad733118be@oracle.com> <38b9648b-8795-5b41-b06c-d13a1a6d5d3f@redhat.com>
 <ab5d903e-f78f-d304-24fb-de7ed73f1c55@oracle.com>
In-Reply-To: <ab5d903e-f78f-d304-24fb-de7ed73f1c55@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 27 Oct 2022 16:47:37 +0800
Message-ID: <CACGkMEvJGfYRY5kF1WWKfT9irGLt8jfVK42g1Bp0UJWdMo_RAQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] vdpa: show dev config as-is in "vdpa dev show" output
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     mst@redhat.com, parav@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Cindy Lu <lulu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 2:31 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
>
>
> On 10/25/2022 9:44 PM, Jason Wang wrote:
> >
> > =E5=9C=A8 2022/10/26 09:10, Si-Wei Liu =E5=86=99=E9=81=93:
> >>
> >>
> >> On 10/24/2022 7:24 PM, Jason Wang wrote:
> >>> On Tue, Oct 25, 2022 at 3:14 AM Si-Wei Liu<si-wei.liu@oracle.com>
> >>> wrote:
> >>>> On 10/24/2022 1:40 AM, Jason Wang wrote:
> >>>>> On Sat, Oct 22, 2022 at 7:49 AM Si-Wei Liu<si-wei.liu@oracle.com>
> >>>>> wrote:
> >>>>>> Live migration of vdpa would typically require re-instate vdpa
> >>>>>> device with an idential set of configs on the destination node,
> >>>>>> same way as how source node created the device in the first
> >>>>>> place. In order to save orchestration software from memorizing
> >>>>>> and keeping track of vdpa config, it will be helpful if the vdpa
> >>>>>> tool provides the aids for exporting the initial configs as-is,
> >>>>>> the way how vdpa device was created. The "vdpa dev show" command
> >>>>>> seems to be the right vehicle for that. It is unlike the "vdpa dev
> >>>>>> config show" command output which usually goes with the live value
> >>>>>> in the device config space, and is not quite reliable subject to
> >>>>>> the dynamics of feature negotiation or possible change by the
> >>>>>> driver to the config space.
> >>>>>>
> >>>>>> Examples:
> >>>>>>
> >>>>>> 1) Create vDPA by default without any config attribute
> >>>>>>
> >>>>>> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0
> >>>>>> $ vdpa dev show vdpa0
> >>>>>> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555
> >>>>>> max_vqs 9 max_vq_size 256
> >>>>>> $ vdpa dev -jp show vdpa0
> >>>>>> {
> >>>>>>       "dev": {
> >>>>>>           "vdpa0": {
> >>>>>>               "type": "network",
> >>>>>>               "mgmtdev": "pci/0000:41:04.2",
> >>>>>>               "vendor_id": 5555,
> >>>>>>               "max_vqs": 9,
> >>>>>>               "max_vq_size": 256,
> >>>>>>           }
> >>>>>>       }
> >>>>>> }
> >>>>>>
> >>>>>> 2) Create vDPA with config attribute(s) specified
> >>>>>>
> >>>>>> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0 \
> >>>>>>       mac e4:11:c6:d3:45:f0 max_vq_pairs 4
> >>>>>> $ vdpa dev show
> >>>>>> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555
> >>>>>> max_vqs 9 max_vq_size 256
> >>>>>>     initial_config: mac e4:11:c6:d3:45:f0 max_vq_pairs 4
> >>>>>> $ vdpa dev -jp show
> >>>>>> {
> >>>>>>       "dev": {
> >>>>>>           "vdpa0": {
> >>>>>>               "type": "network",
> >>>>>>               "mgmtdev": "pci/0000:41:04.2",
> >>>>>>               "vendor_id": 5555,
> >>>>>>               "max_vqs": 9,
> >>>>>>               "max_vq_size": 256,
> >>>>>>               "initial_config": {
> >>>>>>                   "mac": "e4:11:c6:d3:45:f0",
> >>>>>>                   "max_vq_pairs": 4
> >>>>>>               }
> >>>>>>           }
> >>>>>>       }
> >>>>>> }
> >>>>>>
> >>>>>> Signed-off-by: Si-Wei Liu<si-wei.liu@oracle.com>
> >>>>>> ---
> >>>>>>    drivers/vdpa/vdpa.c | 39 ++++++++++++++++++++++++++++++++++++++=
+
> >>>>>>    1 file changed, 39 insertions(+)
> >>>>>>
> >>>>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> >>>>>> index bebded6..bfb8f54 100644
> >>>>>> --- a/drivers/vdpa/vdpa.c
> >>>>>> +++ b/drivers/vdpa/vdpa.c
> >>>>>> @@ -677,6 +677,41 @@ static int
> >>>>>> vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct
> >>>>>> genl_info *i
> >>>>>>    }
> >>>>>>
> >>>>>>    static int
> >>>>>> +vdpa_dev_initcfg_fill(struct vdpa_device *vdev, struct sk_buff
> >>>>>> *msg, u32 device_id)
> >>>>>> +{
> >>>>>> +       struct vdpa_dev_set_config *cfg =3D &vdev->init_cfg;
> >>>>>> +       int err =3D -EMSGSIZE;
> >>>>>> +
> >>>>>> +       if (!cfg->mask)
> >>>>>> +               return 0;
> >>>>>> +
> >>>>>> +       switch (device_id) {
> >>>>>> +       case VIRTIO_ID_NET:
> >>>>>> +               if ((cfg->mask &
> >>>>>> BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR)) !=3D 0 &&
> >>>>>> +                   nla_put(msg, VDPA_ATTR_DEV_NET_CFG_MACADDR,
> >>>>>> +                           sizeof(cfg->net.mac), cfg->net.mac))
> >>>>>> +                       return err;
> >>>>>> +               if ((cfg->mask &
> >>>>>> BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) !=3D 0 &&
> >>>>>> +                   nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU,
> >>>>>> cfg->net.mtu))
> >>>>>> +                       return err;
> >>>>>> +               if ((cfg->mask &
> >>>>>> BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) !=3D 0 &&
> >>>>>> +                   nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP=
,
> >>>>>> + cfg->net.max_vq_pairs))
> >>>>>> +                       return err;
> >>>>>> +               break;
> >>>>>> +       default:
> >>>>>> +               break;
> >>>>>> +       }
> >>>>>> +
> >>>>>> +       if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) !=3D 0 &=
&
> >>>>>> +           nla_put_u64_64bit(msg, VDPA_ATTR_DEV_FEATURES,
> >>>>>> +                             cfg->device_features, VDPA_ATTR_PAD)=
)
> >>>>>> +               return err;
> >>>>> A question: If any of those above attributes were not provisioned,
> >>>>> should we show the ones that are inherited from the parent?
> >>>> A simple answer would be yes, but the long answer is that I am not
> >>>> sure
> >>>> if there's any for the moment - there's no  default value for mtu,
> >>>> mac,
> >>>> and max_vqp that can be inherited from the parent (max_vqp by defaul=
t
> >>>> being 1 is spec defined, not something inherited from the parent).
> >>> Note that it is by default from driver level that if _F_MQ is not
> >>> negotiated. But I think we are talking about something different that
> >>> is out of the spec here, what if:
> >>>
> >>> vDPA inherit _F_MQ but mqx_vqp is not provisioned via netlink.
> >>>
> >>> Or is it not allowed?
> >> My understanding is that this is not allowed any more since the
> >> introduction of max_vqp attribute. Noted, currently we don't have a
> >> way for vendor driver to report the default value for mqx_vqp,
> >
> >
> > I think it can be reported in this patch?
> Yes, we can add, but I am not sure whether or not this will be
> practically useful, for e.g. the same command without max_vqp specified
> may render different number of queues across different devices, or
> different revisions of the same vendor's devices. Does it complicate the
> mgmt software even more, I'm not sure....

It depends on the use case, e.g if we want to compare the migration
compatibility, having a single vdpa command query is much easier than
having two or more.

> Could we instead mandate
> max_vqp to be 1 from vdpa core level if user doesn't explicitly specify
> the value?

This seems to be not easy, at least not easy in the vDPA core. We can
probably document this somewhere but max_vqp is only one example, we
have other mq devices like block/SCSI/console.

> That way it is more consistent in terms of the resulting
> number of queue pairs (=3D1) with the case where parent device does not
> offer the _F_MQ feature.

Right, but a corner case is to provision _F_MQ but without max_vqp.

>
> >
> >
> >> if not otherwise specified in the CLI. Without getting the default
> >> value reported in 'vdpa mgmtdev show' level, it'd just confuse mgmt
> >> software even more.
> >
> >
> > Yes, this is something that we need to fix. And what's more in order
> > to support dynamic provisioning, we need a way to report the number of
> > available instances that could be used for vDPA device provisioning.
> Wouldn't it be possible to achieve that by simply checking how many
> parent mgmtdev instances don't have vdpa device provisioned yet? e.g.
>
> inuse=3D$(vdpa dev show | grep mgmtdev | wc -l)
> total=3D$(vdpa mgmtdev show  | grep "supported_classes" | wc -l )
> echo $((total - inuse))

I meant how many available vDPA devices that are available for the
mgmt to create?

E.g in the case of sub function or simulator a mgmtdev can create more
than 1 vdpa devices.

>
> >
> >
> >>
> >>>    At least some time in the past, mlx5 were
> >>> enabled with MQ with 8 queue pairs by default.
> >> That was the situation when there's no max_vqp attribute support from
> >> vdpa netlink API level. I think now every driver honors the vdpa core
> >> disposition to get a single queue pair if max_vqp config is missing.
> >
> > So we have:
> >
> > int vdpa_register_device(struct vdpa_device *vdev, int nvqs)
> >
> > This means technically, parent can allocate a multiqueue devices with
> > _F_MQ features if max_vqp and device_features is not provisioned. And
> > what's more, what happens if _F_MQ is provisioned by max_vqp is not
> > specified?
> >
> > The question is:
> >
> > When a attribute is not specificed/provisioned via net link, what's
> > the default value? The answer should be consistent: if device_features
> > is determined by the parent, we should do the same for mqx_vqp.
> OK I got your point.
>
> > And it looks to me all of those belongs to the initial config
> > (self-contained)
> Right. I wonder if we can have vdpa core define the default value (for
> e.g. max_vqp=3D1) for those unspecified attribute (esp. when the
> corresponding device feature is offered and provisioned) whenever
> possible. Which I think it'll be more consistent for the same command to
> get to the same result between different vendor drivers. While we still
> keep the possibility for future extension to allow driver override the
> vdpa core disposition if the real use case emerges. What do you think?

That's possible but we may end up with device specific code in the
vDPA core which is not elegant, and the code will grow as the number
of supported types grows.

Note that, max_vqp is not the only attribute that may suffer from
this, basically any config field that depends on a specific feature
bit may have the same issue.

>
> >
> >
> >> And the mlx5_vdpa driver with 8 queue pairs in the wild days is just
> >> irrelevant to be manageable by mgmt software, regardless of live
> >> migration.
> >>>> And
> >>>> the device_features if inherited is displayed at 'vdpa dev config
> >>>> show'
> >>>> output. Can you remind me of a good example for inherited value
> >>>> that we
> >>>> may want to show here?
> >>> Some other cases:
> >>>
> >>> 1) MTU: there should be something that the device needs to report if
> >>> _F_MTU is negotiated even if it is not provisioned from netlink.
> >> I am not sure I understand the ask here. Noted the QEMU argument has
> >> to offer host_mtu=3DX with the maximum MTU value for guest to use (and
> >> applied as the initial MTU config during virtio-net probing for Linux
> >> driver),
> >
> >
> > Adding Cindy.
> >
> > I think it's a known issue that we need to do sanity check to make
> > sure cli parameters matches what is provisioned from netlink.
> Right. How's the plan for QEMU to get to the mtu provisioned by netlink,
> via a new vhost-vdpa ioctl call?

I think netlink is not designed for qemu to use, the design is to
expose a vhost device to Qemu.

> If so, will  QEMU be able to read it
> directly from kernel when it comes to the vhost-vdpa backend, without
> having user to specify host_mtu from CLI?

I'm not sure I get the question, but Qemu should get this via config
space (otherwise it should be a bug). And Qemu need to verify the mtu
got from cli vs the mtu got from vhost and fail the device
initialization if they don't match.

> >
> >
> >> and the way to get the parent device MTU and whether that's relevant
> >> to vdpa device's MTU is very vendor specific.
> >
> >
> > So I think the max MTU of parent should be equal to the max MTU of the
> > vDPA.
> Noted here the parent might not be necessarily the mgmtdev where vdpa
> gets created over. It may well end up with the MTU on the PF (uplink
> port) which the mgmt software has to concern with. My point is the
> utility and tool chain able to derive the maximal MTU effectively
> allowed for vDPA device may live out of vDPA's realm. It's a rare or
> even invalid configuration to have vDPA configured with a bigger value
> than the MTU on the uplink port or parent device. It's more common when
> MTU config is involved, it has to be consistently configured across all
> the network links along, from parent device (uplink port) down to the
> switchdev representor port, vdpa device, and QEMU virtio-net object.

Ok, right.

>
> >
> >
> >> I think we would need new attribute(s) in the mgmtdev level to
> >> support what you want here?
> >
> >
> > Not sure, but what I want to ask is consider we provision MTU feature
> > but without max MTU value, do we need to report the initial max MTU her=
e?
> Yep, maybe. I'm not very sure if this will be very useful to be honest,
> consider it's kinda a rare case to me were to provision MTU feature
> without a specific MTU value. If one cares about MTU, mgmt software
> should configure some mtu through "vdpa dev add ... mtu ...", no?

Yes, but this only works if all config fields could be provisioned,
which seems not the case now, vdpa_dev_set_config is currently a
subset of virtio_net_config. So this goes back to the question I
raised earlier. Is the time to switch to use virtio_net_config and
allow all fields to be provisioned?

And even for mtu we're lacking a way to report the maximum MTU allowed
by mgmt dev (e.g the uplink MTU via netlink):

1) report the maximum host mtu supported by the mgmtdev via netlink
(not done, so management needs to guess the maximum value now)
2) allow mtu to be provisioned (done)
3) show initial mtu (done by this patch)

We probably need to do the above for all fields to be self-contained.

>
> On the other hand, no mtu value specified may mean "go with what the
> uplink port or parent device has". I think this is a pretty useful case
> if the vendor's NIC supports updating MTU on the fly without having to
> tear down QEMU and reconfigure vdpa. I'm not sure if we end up with
> killing this use case by limiting initial max MTU to a fixed value.
>
> >
> >
> >>
> >>> 2) device_features: if device_features is not provisioned, we should
> >>> still report it via netlink here
> >> Not the way I expected it, but with Lingshan's series to expose
> >> fields out of FEATURES_OK, the device_features is now reported
> >> through 'vdpa dev config show' regardless being specified or not, if
> >> I am not mistaken?
> >
> >
> > Yes.
> Do you want me to relocate to 'vdpa dev show', or it's okay to leave it
> behind there?

It's probably too late for the relocation but I feel it's better to
place all the initial/inherited attributes into a single command even
if some of them are already somewhere in another command, but we can
hear from others.

>
> >
> >
> >>
> >> Currently we export the config attributes upon vdpa creation under
> >> the "initial_config" key. If we want to expose more default values
> >> inherited from mgmtdev, I think we can wrap up these default values
> >> under another key "inherited_config" to display in 'vdpa dev show'
> >> output. Does it fit what you have in mind?
> >
> >
> > I wonder if it's better to merge those two, or is there any advantages
> > of splitting them?
> I think for the most part "initial_config" will be sufficient for those
> config attributes with "vdpa dev add" equivalents, be it user specified,
> vdpa enforced default if missing user input, or default overridden by
> the parent device. "inherited_config" will be useful for the configs
> with no "vdpa dev add" equivalent or live out side of vdpa tool, but
> still important for mgmt software to replicate identical vdpa setup.
> Like max-supported-mtu (for the uplink port or parent device),
> effective-link-speed, effective-link-status et al. Let's see if there's
> more when we get there.

So one point I can see is that, if there's no difference from the
userpsace perspective, we'd better merge them. And I don't see any
difference between the initial versus inherited from the view of user
space. Do you?

Thanks

>
> Thanks,
> -Siwei
>
> >
> >
> >>
> >>> or do you mean the mgmt can assume it
> >>> should be the same as mgmtdev. Anyhow if we don't show device_feature=
s
> >>> if it is not provisioned, it will complicate the mgmt software.
> >> Yes, as I said earlier, since the device_features attr getting added
> >> to the 'vdpa dev config show' command, this divergence started to
> >> complicate mgmt software already.
> >>
> >> Thanks,
> >
> >
> > Thanks
> >
> >
> >> -Siwei
> >>> Thanks
> >>>
> >>>> Thanks,
> >>>> -Siwei
> >>>>
> >>>>
> >>>>> Thanks
> >>>>>
> >>>>>> +
> >>>>>> +       return 0;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int
> >>>>>>    vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg,
> >>>>>> u32 portid, u32 seq,
> >>>>>>                 int flags, struct netlink_ext_ack *extack)
> >>>>>>    {
> >>>>>> @@ -715,6 +750,10 @@ static int
> >>>>>> vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct
> >>>>>> genl_info *i
> >>>>>>           if (nla_put_u16(msg, VDPA_ATTR_DEV_MIN_VQ_SIZE,
> >>>>>> min_vq_size))
> >>>>>>                   goto msg_err;
> >>>>>>
> >>>>>> +       err =3D vdpa_dev_initcfg_fill(vdev, msg, device_id);
> >>>>>> +       if (err)
> >>>>>> +               goto msg_err;
> >>>>>> +
> >>>>>>           genlmsg_end(msg, hdr);
> >>>>>>           return 0;
> >>>>>>
> >>>>>> --
> >>>>>> 1.8.3.1
> >>>>>>
> >>
> >
>

