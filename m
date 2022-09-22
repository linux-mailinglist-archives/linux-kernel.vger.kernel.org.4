Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C5E5E5E33
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 11:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiIVJMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 05:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIVJMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 05:12:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD6DB1B92
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 02:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663837935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ttSrBLEpKZyjQV5l0E/DFEKouaPon4bF3E/8yZe2v0g=;
        b=PrB7Pu2W20SZJyzKKI+ctlKEsNzrU7g6jYJat1tSuMdqDzkdrgTcv6WRZIb+pEOTpj88eP
        nDTRcJMUZdWjX0yRIDMfly6f4iO2MlfqlGpD8ZfQDdJBPp1edVlUD8oOVSQ+lA7dbY+oaz
        Cz6EV2YoOM+BOMclON4Gi+l+yLwrG8M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-534-B4XG-UDBO9WFd-_SPo4N1Q-1; Thu, 22 Sep 2022 05:12:06 -0400
X-MC-Unique: B4XG-UDBO9WFd-_SPo4N1Q-1
Received: by mail-wm1-f71.google.com with SMTP id n7-20020a1c2707000000b003a638356355so3804499wmn.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 02:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ttSrBLEpKZyjQV5l0E/DFEKouaPon4bF3E/8yZe2v0g=;
        b=TEntTonkKwxp2TK+fXdZKMLpwue591wldvN2s+NEAuQ9Lm5gS/lfcV0vh99Sjt/lyJ
         /zyYgD/0e0xo+S7GXXQdthYOfDaJXoel2zvctrV0k5JBxJhnhqoj41uPnvEwss1xbEsg
         k573lXQDBRYXU66y7g+HHEH2AbZAicq116jIHKVnwC4JXUvl6hYURqDRaAwi6d4SZaeG
         zIwvQyNmwmpkqMBeaUcAr/+HreOi6xr5aux6QXcifRnGIq9xwhVK1lBxn7/f3wucdMmy
         hkksX46QzeNHMuFkW0oFCq46fxcuzkin0sH8h0xihFSJS5WOcLTuvDqvbd72IuwHSK2O
         awAg==
X-Gm-Message-State: ACrzQf1aYMdyCYFUmd/2saRf6lOyt9YCZd3qx6hTmOMpVedtrfR3ywiv
        9jF+Wx+TE07z2cfWhoZ/5/z3L/PFGZzISHsoYS4kVl+mvKxm+S/Umng7ZGaQ1FXGJDd9j9lzttE
        hBxm7IZRsyckbWxjPhjiR+6Iy
X-Received: by 2002:a05:600c:350f:b0:3b4:c5f2:4295 with SMTP id h15-20020a05600c350f00b003b4c5f24295mr1623638wmq.200.1663837925175;
        Thu, 22 Sep 2022 02:12:05 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6KgIVxrv1hpbdDgKYQPaoxL+qyx5p5U+Vg1s8fE6n6+lqclJ9qu1pSVL6c46b45j52D9hXxA==
X-Received: by 2002:a05:600c:350f:b0:3b4:c5f2:4295 with SMTP id h15-20020a05600c350f00b003b4c5f24295mr1623620wmq.200.1663837924929;
        Thu, 22 Sep 2022 02:12:04 -0700 (PDT)
Received: from redhat.com ([2.55.47.213])
        by smtp.gmail.com with ESMTPSA id l14-20020a5d410e000000b00228aea99efcsm4752657wrp.14.2022.09.22.02.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 02:12:04 -0700 (PDT)
Date:   Thu, 22 Sep 2022 05:11:58 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>,
        Parav Pandit <parav@nvidia.com>,
        "wuzongyong@linux.alibaba.com" <wuzongyong@linux.alibaba.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>,
        "gdawar@xilinx.com" <gdawar@xilinx.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "xieyongji@bytedance.com" <xieyongji@bytedance.com>
Subject: Re: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
Message-ID: <20220922050639-mutt-send-email-mst@kernel.org>
References: <20220922024305.1718-1-jasowang@redhat.com>
 <20220922024305.1718-3-jasowang@redhat.com>
 <DM8PR12MB54005C65A85B32063A5E17A8AB4E9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20220922032858-mutt-send-email-mst@kernel.org>
 <DM8PR12MB5400D6550D2253E9964260F8AB4E9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20220922035028-mutt-send-email-mst@kernel.org>
 <DM8PR12MB5400EC129B7A2B0D86EE72F2AB4E9@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR12MB5400EC129B7A2B0D86EE72F2AB4E9@DM8PR12MB5400.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 08:01:23AM +0000, Eli Cohen wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, 22 September 2022 10:53
> > To: Eli Cohen <elic@nvidia.com>
> > Cc: Jason Wang <jasowang@redhat.com>; si-wei.liu@oracle.com; Parav
> > Pandit <parav@nvidia.com>; wuzongyong@linux.alibaba.com;
> > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > eperezma@redhat.com; lingshan.zhu@intel.com; gdawar@xilinx.com;
> > lulu@redhat.com; xieyongji@bytedance.com
> > Subject: Re: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
> > 
> > On Thu, Sep 22, 2022 at 07:47:40AM +0000, Eli Cohen wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Thursday, 22 September 2022 10:30
> > > > To: Eli Cohen <elic@nvidia.com>
> > > > Cc: Jason Wang <jasowang@redhat.com>; si-wei.liu@oracle.com; Parav
> > > > Pandit <parav@nvidia.com>; wuzongyong@linux.alibaba.com;
> > > > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > > > eperezma@redhat.com; lingshan.zhu@intel.com; gdawar@xilinx.com;
> > > > lulu@redhat.com; xieyongji@bytedance.com
> > > > Subject: Re: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
> > > >
> > > > On Thu, Sep 22, 2022 at 05:13:59AM +0000, Eli Cohen wrote:
> > > > > > From: Jason Wang <jasowang@redhat.com>
> > > > > > Sent: Thursday, 22 September 2022 5:43
> > > > > > To: mst@redhat.com; jasowang@redhat.com
> > > > > > Cc: Eli Cohen <elic@nvidia.com>; si-wei.liu@oracle.com; Parav Pandit
> > > > > > <parav@nvidia.com>; wuzongyong@linux.alibaba.com;
> > > > > > virtualization@lists.linux-foundation.org; linux-
> > kernel@vger.kernel.org;
> > > > > > eperezma@redhat.com; lingshan.zhu@intel.com;
> > gdawar@xilinx.com;
> > > > > > lulu@redhat.com; xieyongji@bytedance.com
> > > > > > Subject: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
> > > > > >
> > > > > > This patch implements features provisioning for vdpa_sim_net.
> > > > > >
> > > > > > 1) validating the provisioned features to be a subset of the parent
> > > > > >    features.
> > > > > > 2) clearing the features that is not wanted by the userspace
> > > > > >
> > > > > > For example:
> > > > > >
> > > > > > # vdpa mgmtdev show
> > > > > > vdpasim_net:
> > > > > >   supported_classes net
> > > > > >   max_supported_vqs 3
> > > > > >   dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT
> > > > > > VERSION_1 ACCESS_PLATFORM
> > > > > >
> > > > > > 1) provision vDPA device with all features that are supported by the
> > > > > >    net simulator
> > > > > >
> > > > > > # vdpa dev add name dev1 mgmtdev vdpasim_net
> > > > > > # vdpa dev config show
> > > > > > dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
> > > > > >   negotiated_features MTU MAC CTRL_VQ CTRL_MAC_ADDR
> > VERSION_1
> > > > > > ACCESS_PLATFORM
> > > > > >
> > > > > > 2) provision vDPA device with a subset of the features
> > > > > >
> > > > > > # vdpa dev add name dev1 mgmtdev vdpasim_net device_features
> > > > > > 0x300020000
> > > > >
> > > > > How about "features_mask" instead of "device_features"? Could avoid
> > > > confusion.
> > > >
> > > > Not sure I agree.
> > > > features_mask to me would mean it is & with features. Not the case here.
> > > >
> > >
> > >
> > > See the code below
> > >
> > > @@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct
> > vdpa_mgmt_dev *mdev, const char *name,
> > >  	dev_attr.work_fn = vdpasim_net_work;
> > >  	dev_attr.buffer_size = PAGE_SIZE;
> > >
> > > +	if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> > > +		if (config->device_features &
> > > +		    ~dev_attr.supported_features)
> > > +			return -EINVAL;
> > > +		dev_attr.supported_features &=
> > > +			 config->device_features;
> > > +	}
> > > +
> > 
> > Oh I didn't notice. It's unnecessary, isn't it?
> > Can just equivalently be
> > 
> > 	dev_attr.supported_features = config->device_features;
> > 
> > right?
> > 
> 
> I don't think so. You want to mask the set of features that the device will offer but you cannot dictate it.

Sure, but it's already a given because device_features is a subset of
supported_features. Observe:

After this line:

         if (config->device_features &
            ~dev_attr.supported_features)
                return -EINVAL;

we know that config->device_features & ~dev_attr.supported_features
is 0.

Therefore logically

config->device_features  == 
    (config->device_features & ~dev_attr.supported_features) |
    (config->device_features & dev_attr.supported_features); 

it follows that

config->device_features  == 
    0 |
    (config->device_features & dev_attr.supported_features); 

and finally

config->device_features  == 
    (config->device_features & dev_attr.supported_features); 


now

		dev_attr.supported_features &=
			 config->device_features;

is equivalent to

		dev_attr.supported_features =
    (config->device_features & dev_attr.supported_features); 

and therefore to

		dev_attr.supported_features = config->device_features;



> > 
> > > > > > # vdpa dev config show
> > > > > > dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
> > > > > >   negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
> > > > > >
> > > > > > Reviewed-by: Eli Cohen <elic@nvidia.com>
> > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > ---
> > > > > >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 11 ++++++++++-
> > > > > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > > > > b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > > > > index 886449e88502..a9ba02be378b 100644
> > > > > > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > > > > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > > > > @@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct
> > > > > > vdpa_mgmt_dev *mdev, const char *name,
> > > > > >  	dev_attr.work_fn = vdpasim_net_work;
> > > > > >  	dev_attr.buffer_size = PAGE_SIZE;
> > > > > >
> > > > > > +	if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> > > > > > +		if (config->device_features &
> > > > > > +		    ~dev_attr.supported_features)
> > > > > > +			return -EINVAL;
> > > > > > +		dev_attr.supported_features &=
> > > > > > +			 config->device_features;
> > > > > > +	}
> > > > > > +
> > > > > >  	simdev = vdpasim_create(&dev_attr);
> > > > > >  	if (IS_ERR(simdev))
> > > > > >  		return PTR_ERR(simdev);
> > > > > > @@ -294,7 +302,8 @@ static struct vdpa_mgmt_dev mgmt_dev = {
> > > > > >  	.id_table = id_table,
> > > > > >  	.ops = &vdpasim_net_mgmtdev_ops,
> > > > > >  	.config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
> > > > > > -			     1 << VDPA_ATTR_DEV_NET_CFG_MTU),
> > > > > > +			     1 << VDPA_ATTR_DEV_NET_CFG_MTU |
> > > > > > +		             1 << VDPA_ATTR_DEV_FEATURES),
> > > > > >  	.max_supported_vqs = VDPASIM_NET_VQ_NUM,
> > > > > >  	.supported_features = VDPASIM_NET_FEATURES,
> > > > > >  };
> > > > > > --
> > > > > > 2.25.1
> > > > >
> > >
> 

