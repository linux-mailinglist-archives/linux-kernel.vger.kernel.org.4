Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0CC602747
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiJRIlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiJRIlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:41:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418B533866
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666082508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i/RR1Hxk78BsheEc9xl3vHs3B1J+Z1NZWyjHts3Iyx8=;
        b=Eg6onwx07S6M0eLYG8jyurDIvCbCDtQVeZjgK4geQRUw0K1LbZzBzLSjHhJKohbXkMdfnD
        zbnXF64y7BBjOCZ7NSrTrYXllYjs5GE83v8l2eCXPd0zSVhdfQxtxBCRRAkjQaBNnlxfzW
        kAlUIIalaWZ+VfyWulbDBx+SU520O9U=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-395-TVMBG5CdMaWs9Qxe4yVG-g-1; Tue, 18 Oct 2022 04:41:39 -0400
X-MC-Unique: TVMBG5CdMaWs9Qxe4yVG-g-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-132b6ed45b3so5667105fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/RR1Hxk78BsheEc9xl3vHs3B1J+Z1NZWyjHts3Iyx8=;
        b=VGdlc4PdvP2D2XJfK3wJbZ423yUmXQ868Cgv/kVxEEOfqsHpdpJqPrZnNXRmgtmD7N
         nnQkf++3lp2XnE/HBc9xUN0FdY7ANfR+gzaNwLC8NgroL1pOTM4PxSsw+jOvIWBCYQV7
         TNA7LUwok0Y1mXUPDyVz0/mVQx/gCUPEwylD6ZoK8FU+Z9j1LDyMlSFAbYqpGAibcoi5
         tz2eEAX5mkmmH1i3zYxgPPlDD0jKrN1eUuvKzq+ghg/sEQRRD9SbOq/OzcZGAcan1jqS
         s52SJlpGmIqk4Q+FIOL2eIEQbq8bwDp0e41ZVeHfeF72CHSUeHFrWCDyghjg0xhfepX0
         s8dQ==
X-Gm-Message-State: ACrzQf0pcGV+mK9dF1wwdub753Xo3ICa+2DupbmFXCyLORChF16Ij+iv
        /Yy9i3JCcA6lYJINNk2H4eRO/Xc/yiM3TBQwNrYRK36L4V3IfiIE2pctAx5hRtnespoY5/2jAmc
        983VrJhk/1KlmOgL8DG0epIJv8+R1OJJp+yJRbWjF
X-Received: by 2002:a05:6870:c1d3:b0:136:c4f6:53af with SMTP id i19-20020a056870c1d300b00136c4f653afmr17250464oad.35.1666082498732;
        Tue, 18 Oct 2022 01:41:38 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7bNteYYU1ndwP/j/qAvOCjhKctfznqudVZ4PsSFW8zC58kN1VT9u3gUVrhXGIrPekqtFmAadEQ0UolmMdnPKg=
X-Received: by 2002:a05:6870:c1d3:b0:136:c4f6:53af with SMTP id
 i19-20020a056870c1d300b00136c4f653afmr17250453oad.35.1666082498433; Tue, 18
 Oct 2022 01:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <1665793690-28120-1-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEvaKnqS-0p7iqyHP_Wbbj1YdmPFA7ABfKK_8FbXMsZEkg@mail.gmail.com> <4f76d968-3086-0280-48fc-fcf250f11c67@oracle.com>
In-Reply-To: <4f76d968-3086-0280-48fc-fcf250f11c67@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 18 Oct 2022 16:41:26 +0800
Message-ID: <CACGkMEs6tsPUsoP1TmEB3metqCHQF-i95G+oP3koJGAOS_5PWQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] vDPA: dev config export via "vdpa dev show" command
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Sean Mooney <smooney@redhat.com>,
        Daniel Berrange <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 6:58 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
>
>
> On 10/17/2022 12:08 AM, Jason Wang wrote:
> > Adding Sean and Daniel for more thoughts.
> >
> > On Sat, Oct 15, 2022 at 9:33 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
> >> Live migration of vdpa would typically require re-instate vdpa
> >> device with an idential set of configs on the destination node,
> >> same way as how source node created the device in the first place.
> >>
> >> In order to allow live migration orchestration software to export the
> >> initial set of vdpa attributes with which the device was created, it
> >> will be useful if the vdpa tool can report the config on demand with
> >> simple query.
> > For live migration, I think the management layer should have this
> > knowledge and they can communicate directly without bothering the vdpa
> > tool on the source. If I was not wrong this is the way libvirt is
> > doing now.
> I think this series doesn't conflict with what libvirt is doing now. For
> example it can still remember the supported features for the parent
> mgmtdev, and mtu and mac properties for vdpa creation, and use them to
> replicate vdpa device on  destination node. The extra benefit is - the
> management software (for live migration) doesn't need to care those
> mgmtdev specifics - such as what features the parent mgmtdev supports,
> whether some features are mandatory, and what are the default values for
> those, whether there's enough system or hardware resource available to
> create vdpa with requested features et al. This kind of process can be
> simplified by just getting a vdpa created with the exact same features
> and configus exposed via the 'vdpa dev show' command. Essentially this
> export facility just provides the layer of abstraction needed for virtio
> related device configuration and for the very core need of vdpa live
> migration. For e.g. what're exported can even be useful to facilitate
> live migration from vdpa to software virtio. Basically, it doesn't
> prevent libvirt from implementing another layer on top to manage vdpa
> between mgmtdev devices and vdpa creation, and on the other hand, would
> benefit light-weighted mgmt software implementation with device
> management and live migration orchestration decoupled in the upper level.

Ok, I think this is fine.

>
> >> This will ease the orchestration software implementation
> >> so that it doesn't have to keep track of vdpa config change, or have
> >> to persist vdpa attributes across failure and recovery, in fear of
> >> being killed due to accidental software error.
> >>
> >> In this series, the initial device config for vdpa creation will be
> >> exported via the "vdpa dev show" command.
> >> This is unlike the "vdpa
> >> dev config show" command that usually goes with the live value in
> >> the device config space, which is not reliable subject to the dynamics
> >> of feature negotiation and possible change in device config space.
> >>
> >> Examples:
> >>
> >> 1) Create vDPA by default without any config attribute
> >>
> >> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0
> >> $ vdpa dev show vdpa0
> >> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
> >> $ vdpa dev -jp show vdpa0
> >> {
> >>      "dev": {
> >>          "vdpa0": {
> >>              "type": "network",
> >>              "mgmtdev": "pci/0000:41:04.2",
> >>              "vendor_id": 5555,
> >>              "max_vqs": 9,
> >>              "max_vq_size": 256,
> >>          }
> >>      }
> >> }
> >>
> >> 2) Create vDPA with config attribute(s) specified
> >>
> >> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0 \
> >>      mac e4:11:c6:d3:45:f0 max_vq_pairs 4
> >> $ vdpa dev show
> >> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
> >>    mac e4:11:c6:d3:45:f0 max_vq_pairs 4
> >> $ vdpa dev -jp show
> >> {
> >>      "dev": {
> >>          "vdpa0": {
> >>              "type": "network",
> >>              "mgmtdev": "pci/0000:41:04.2",
> > So "mgmtdev" looks not necessary for live migration.
> Right, so once the resulting device_features is exposed to the 'vdpa dev
> show' output, the mgmt software could infer the set of config options to
> recreate vdpa with, and filter out those unwanted attributes (or pick
> what it really wants).

Ok,  so I wonder if it is this better to have a new command instead of
mixing it with "dev show"?

Or at least have separated key for virtio like

"vdpa0": {
     "mgmtdev": "vdpasim_net",
     "virtio config: {
          ....
      }
}

Thanks

>
> -Siwei
>
> >
> > Thanks
> >
> >>              "vendor_id": 5555,
> >>              "max_vqs": 9,
> >>              "max_vq_size": 256,
> >>              "mac": "e4:11:c6:d3:45:f0",
> >>              "max_vq_pairs": 4
> >>          }
> >>      }
> >> }
> >>
> >> ---
> >>
> >> Si-Wei Liu (4):
> >>    vdpa: save vdpa_dev_set_config in struct vdpa_device
> >>    vdpa: pass initial config to _vdpa_register_device()
> >>    vdpa: show dev config as-is in "vdpa dev show" output
> >>    vdpa: fix improper error message when adding vdpa dev
> >>
> >>   drivers/vdpa/ifcvf/ifcvf_main.c      |  2 +-
> >>   drivers/vdpa/mlx5/net/mlx5_vnet.c    |  2 +-
> >>   drivers/vdpa/vdpa.c                  | 63 +++++++++++++++++++++++++++++++++---
> >>   drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  2 +-
> >>   drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  2 +-
> >>   drivers/vdpa/vdpa_user/vduse_dev.c   |  2 +-
> >>   drivers/vdpa/virtio_pci/vp_vdpa.c    |  3 +-
> >>   include/linux/vdpa.h                 | 26 ++++++++-------
> >>   8 files changed, 80 insertions(+), 22 deletions(-)
> >>
> >> --
> >> 1.8.3.1
> >>
>

