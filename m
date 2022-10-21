Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA99606E09
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 04:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiJUCv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 22:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJUCv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 22:51:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4591863FD
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 19:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666320685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f8nJsDIhGjL0WmXtL/oaf6x1BSko8WuXhvBUkczAonU=;
        b=hUrkB/n2B7wN4sFoWm5txoxzFXAmA6FiJqjUG71qbEmxztpuTES4JAtaJ5+t1MFMiG1i5M
        jnTTU6TwpKO/IJMOBkcWaOzIg9IJvvVX15MrinJW0jvfdrOptY613UOjAr2pDoQ5qrfsvS
        JH9WAIgKPLbk9QvDsLG5+WixQfm0xWU=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-490-zXlpH67TN2uMX9eOREFZOQ-1; Thu, 20 Oct 2022 22:51:24 -0400
X-MC-Unique: zXlpH67TN2uMX9eOREFZOQ-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-132e28ef8faso950710fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 19:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f8nJsDIhGjL0WmXtL/oaf6x1BSko8WuXhvBUkczAonU=;
        b=v8XTXQ3Sh91eRzT4F5inLsLw5GkHei9fOzd6VmYGDuII02t1u7tHosR06zz38PPZLr
         nQbVATjB36xMWJk+v7zMEvB6tf8yD73wrUjP0/8hSZDD7zw/GuCpm6Pw/FmZYFKVSVcx
         9854puu4ScTVe696VoaFs1suz6JPZr9FzlLHE9XS+YKJWZEm9CcfWq5SVFR04/buphTd
         LnH204wrrtouIuDLrlh3QOuQ74H587BAfGCX+h5rdc2H4K8930yOQ8cdZ5KJB6XevwAE
         bVc3zgGM7m/qsJQpyLuEjQ8S86FCZy4GM5WTndTZJPWY2MdJ8r6gyX2Ha+PCjgFTnFs4
         zO+w==
X-Gm-Message-State: ACrzQf2tP3p3ltgqpE7tg3aYNtMR83zMQdDAGb+Vv9pt4qWLzpsyMuhD
        cirEnB8VJ2OPXZTH84YHqzXF1o2VrN1rrZY74WmfhlqRXr2A1v7HtgfhQjhjkiNJaN3RhKDcd7G
        u7kpfNWAcYi3phn1vDAbWD6Xhm9CsE40d9i1G/2lD
X-Received: by 2002:a05:6808:1483:b0:354:a36e:5b with SMTP id e3-20020a056808148300b00354a36e005bmr22695039oiw.35.1666320683354;
        Thu, 20 Oct 2022 19:51:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6jXx55f2XoCzq7zsnbn1o7BGBzsS+7s+2DhVS/SZHXKqbXS+XjLnpm/P3QxGseqXrw+RPvZ5VhyW6y7unxjaw=
X-Received: by 2002:a05:6808:1483:b0:354:a36e:5b with SMTP id
 e3-20020a056808148300b00354a36e005bmr22695032oiw.35.1666320683101; Thu, 20
 Oct 2022 19:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <1666137032-28192-1-git-send-email-si-wei.liu@oracle.com>
 <1666137032-28192-3-git-send-email-si-wei.liu@oracle.com> <CACGkMEuT7O1xLrB9=eYHAtuHYdwbNXxqtC+Mh4qkWSkLM+QTjg@mail.gmail.com>
 <68312622-0206-f456-146e-e242e36be04d@oracle.com>
In-Reply-To: <68312622-0206-f456-146e-e242e36be04d@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 21 Oct 2022 10:51:11 +0800
Message-ID: <CACGkMEtjseNBZ53x7=k79X8q3wogtksFPPC7NG2Uofj0HSEq+Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] vdpa: pass initial config to _vdpa_register_device()
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Wu Zongyong <wuzongyong@linux.alibaba.com>
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

On Fri, Oct 21, 2022 at 2:45 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
>
>
> On 10/19/2022 10:20 PM, Jason Wang wrote:
> > On Wed, Oct 19, 2022 at 8:56 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
> >> Just as _vdpa_register_device taking @nvqs as the number of queues
> > I wonder if it's better to embed nvqs in the config structure.
> Hmmm, the config structure is mostly for containing the configurables
> specified in the 'vdpa dev add' command, while each field is
> conditionally set and guarded by a corresponding mask bit. If @nvqs
> needs to be folded into a structure, I feel it might be better to use
> another struct for holding the informational fields (i.e. those are
> read-only and always exist). But doing this would make @nvqs a weird
> solo member in that struct with no extra benefit, and all the other
> informational fields shown in the 'vdpa dev show' command would be
> gotten from the device through config_ops directly. Maybe do this until
> another read-only field comes around?

That's fine.

>
> >
> >> to feed userspace inquery via vdpa_dev_fill(), we can follow the
> >> same to stash config attributes in struct vdpa_device at the time
> >> of vdpa registration.
> >>
> >> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> >> ---
> >>   drivers/vdpa/ifcvf/ifcvf_main.c      |  2 +-
> >>   drivers/vdpa/mlx5/net/mlx5_vnet.c    |  2 +-
> >>   drivers/vdpa/vdpa.c                  | 15 +++++++++++----
> >>   drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  2 +-
> >>   drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  2 +-
> >>   drivers/vdpa/vdpa_user/vduse_dev.c   |  2 +-
> >>   drivers/vdpa/virtio_pci/vp_vdpa.c    |  3 ++-
> >>   include/linux/vdpa.h                 |  3 ++-
> >>   8 files changed, 20 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> >> index f9c0044..c54ab2c 100644
> >> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> >> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> >> @@ -771,7 +771,7 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
> >>          else
> >>                  ret = dev_set_name(&vdpa_dev->dev, "vdpa%u", vdpa_dev->index);
> >>
> >> -       ret = _vdpa_register_device(&adapter->vdpa, vf->nr_vring);
> >> +       ret = _vdpa_register_device(&adapter->vdpa, vf->nr_vring, config);
> >>          if (ret) {
> >>                  put_device(&adapter->vdpa.dev);
> >>                  IFCVF_ERR(pdev, "Failed to register to vDPA bus");
> >> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >> index 9091336..376082e 100644
> >> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >> @@ -3206,7 +3206,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> >>          mlx5_notifier_register(mdev, &ndev->nb);
> >>          ndev->nb_registered = true;
> >>          mvdev->vdev.mdev = &mgtdev->mgtdev;
> >> -       err = _vdpa_register_device(&mvdev->vdev, max_vqs + 1);
> >> +       err = _vdpa_register_device(&mvdev->vdev, max_vqs + 1, add_config);
> >>          if (err)
> >>                  goto err_reg;
> >>
> >> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> >> index febdc99..566c1c6 100644
> >> --- a/drivers/vdpa/vdpa.c
> >> +++ b/drivers/vdpa/vdpa.c
> >> @@ -215,11 +215,16 @@ static int vdpa_name_match(struct device *dev, const void *data)
> >>          return (strcmp(dev_name(&vdev->dev), data) == 0);
> >>   }
> >>
> >> -static int __vdpa_register_device(struct vdpa_device *vdev, u32 nvqs)
> >> +static int __vdpa_register_device(struct vdpa_device *vdev, u32 nvqs,
> >> +                                 const struct vdpa_dev_set_config *cfg)
> >>   {
> >>          struct device *dev;
> >>
> >>          vdev->nvqs = nvqs;
> >> +       if (cfg)
> >> +               vdev->vdev_cfg = *cfg;
> >> +       else
> >> +               vdev->vdev_cfg.mask = 0ULL;
> > I think it would be nice if we can convert eni to use netlink then we
> > don't need any workaround like this.
> Yes, Alibaba ENI is the only consumer of the old vdpa_register_device()
> API without being ported to the netlink API. Not sure what is needed but
> it seems another work to make netlink API committed to support a legacy
> compatible model?

It's only about the provisioning (which is kind of out of the spec).
So if I was not wrong, it should be something similar like the work
that Cindy has done, (per VF mgmtdev):

commit ffbda8e9df10d1784d5427ec199e7d8308e3763f
Author: Cindy Lu <lulu@redhat.com>
Date:   Fri Apr 29 17:10:30 2022 +0800

    vdpa/vp_vdpa : add vdpa tool support in vp_vdpa

Thanks

>
> -Siwei
>
> >
> > Thanks
> >
>

