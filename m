Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E655E5CAF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 09:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiIVHxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 03:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiIVHxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 03:53:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16A5B6D3D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 00:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663833217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CiB9cgwGik9cVTleJNmc31WLxMKDN3Tl6RLpLoNrDfg=;
        b=DvFOklM7Yuys+7IEsqNNu+mtFEJ8U/LFppfm/ZKUDyVpeDyUrsCOn7j8lQbDcmj1BwgNTc
        aF0SsdeK0rv5v9ef4CLZrU5tRSHAdKtgqMrXTV0ialdL1QJc2sg3EAS3OeU4JqtpVgeuqq
        /DSVr1ahjP01TxhtTwDeYF7KmnVtbHI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-649--q5pqx_DPy-PAZmd2O0OEA-1; Thu, 22 Sep 2022 03:53:35 -0400
X-MC-Unique: -q5pqx_DPy-PAZmd2O0OEA-1
Received: by mail-wr1-f70.google.com with SMTP id t12-20020adfa2cc000000b0022adcbb248bso2992453wra.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 00:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=CiB9cgwGik9cVTleJNmc31WLxMKDN3Tl6RLpLoNrDfg=;
        b=zj0ycHRS9bHwm+JFEhHFbpRXcR6gw7RiCoDkiuuBPBuHi+oe5JH+Vgebrv0Zomzdqf
         0pGydMlxm3rDNK61yjGw+DbE382+KrNy/RcRoj6cfFTRgRZqlZ6qlPlA+bBLyY8dZFiL
         lRvND2ZuvCFyWo2o0X+gCUT1uuUS+4ILSC+EuKeY+QmZvcHlGCsErgZHggcRskBmkSIy
         W8TMG5uK54mmdKwvk7YtkRy3jZsdvGSR3/FiPKPddE0N5qYXIdb0MuFK1t5XZdpUZdlB
         U242IhsTOhLaaM76A0Y6s78gJy6ES40GQ8agQUjB9rparh7qh93E596RMoVuq4Ka4DOv
         /IeQ==
X-Gm-Message-State: ACrzQf0JIuJwjTK91k73+hPAow6b0Tse7TjwcudotRzsxfDonNhynUtm
        tgmMQEyd+NvRcZjFjHlmBzluZ6fPSWEoiPsuxdzVmBxRugcNhK8d3uxWWr6CwEl0qYU5L7IOwPn
        p6LwStvi3RppzNjRJG8MkZTjP
X-Received: by 2002:a1c:440b:0:b0:3b3:330d:88d8 with SMTP id r11-20020a1c440b000000b003b3330d88d8mr1394205wma.31.1663833214621;
        Thu, 22 Sep 2022 00:53:34 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5TzlWYRFYY9faCipZv1rcrv69J4gEWeKFLl4r9bcrqQkV1vatXxBR056G+/UGoKmCZVb/+mA==
X-Received: by 2002:a1c:440b:0:b0:3b3:330d:88d8 with SMTP id r11-20020a1c440b000000b003b3330d88d8mr1394186wma.31.1663833214328;
        Thu, 22 Sep 2022 00:53:34 -0700 (PDT)
Received: from redhat.com ([2.55.47.213])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600c2e4700b003b31fc77407sm4865602wmf.30.2022.09.22.00.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 00:53:33 -0700 (PDT)
Date:   Thu, 22 Sep 2022 03:53:29 -0400
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
Message-ID: <20220922035028-mutt-send-email-mst@kernel.org>
References: <20220922024305.1718-1-jasowang@redhat.com>
 <20220922024305.1718-3-jasowang@redhat.com>
 <DM8PR12MB54005C65A85B32063A5E17A8AB4E9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20220922032858-mutt-send-email-mst@kernel.org>
 <DM8PR12MB5400D6550D2253E9964260F8AB4E9@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR12MB5400D6550D2253E9964260F8AB4E9@DM8PR12MB5400.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 07:47:40AM +0000, Eli Cohen wrote:
> 
> 
> > -----Original Message-----
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, 22 September 2022 10:30
> > To: Eli Cohen <elic@nvidia.com>
> > Cc: Jason Wang <jasowang@redhat.com>; si-wei.liu@oracle.com; Parav
> > Pandit <parav@nvidia.com>; wuzongyong@linux.alibaba.com;
> > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > eperezma@redhat.com; lingshan.zhu@intel.com; gdawar@xilinx.com;
> > lulu@redhat.com; xieyongji@bytedance.com
> > Subject: Re: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
> > 
> > On Thu, Sep 22, 2022 at 05:13:59AM +0000, Eli Cohen wrote:
> > > > From: Jason Wang <jasowang@redhat.com>
> > > > Sent: Thursday, 22 September 2022 5:43
> > > > To: mst@redhat.com; jasowang@redhat.com
> > > > Cc: Eli Cohen <elic@nvidia.com>; si-wei.liu@oracle.com; Parav Pandit
> > > > <parav@nvidia.com>; wuzongyong@linux.alibaba.com;
> > > > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > > > eperezma@redhat.com; lingshan.zhu@intel.com; gdawar@xilinx.com;
> > > > lulu@redhat.com; xieyongji@bytedance.com
> > > > Subject: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
> > > >
> > > > This patch implements features provisioning for vdpa_sim_net.
> > > >
> > > > 1) validating the provisioned features to be a subset of the parent
> > > >    features.
> > > > 2) clearing the features that is not wanted by the userspace
> > > >
> > > > For example:
> > > >
> > > > # vdpa mgmtdev show
> > > > vdpasim_net:
> > > >   supported_classes net
> > > >   max_supported_vqs 3
> > > >   dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT
> > > > VERSION_1 ACCESS_PLATFORM
> > > >
> > > > 1) provision vDPA device with all features that are supported by the
> > > >    net simulator
> > > >
> > > > # vdpa dev add name dev1 mgmtdev vdpasim_net
> > > > # vdpa dev config show
> > > > dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
> > > >   negotiated_features MTU MAC CTRL_VQ CTRL_MAC_ADDR VERSION_1
> > > > ACCESS_PLATFORM
> > > >
> > > > 2) provision vDPA device with a subset of the features
> > > >
> > > > # vdpa dev add name dev1 mgmtdev vdpasim_net device_features
> > > > 0x300020000
> > >
> > > How about "features_mask" instead of "device_features"? Could avoid
> > confusion.
> > 
> > Not sure I agree.
> > features_mask to me would mean it is & with features. Not the case here.
> > 
> 
> 
> See the code below
> 
> @@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>  	dev_attr.work_fn = vdpasim_net_work;
>  	dev_attr.buffer_size = PAGE_SIZE;
>  
> +	if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> +		if (config->device_features &
> +		    ~dev_attr.supported_features)
> +			return -EINVAL;
> +		dev_attr.supported_features &=
> +			 config->device_features;
> +	}
> +

Oh I didn't notice. It's unnecessary, isn't it?
Can just equivalently be

	dev_attr.supported_features = config->device_features;

right?


> > > > # vdpa dev config show
> > > > dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
> > > >   negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
> > > >
> > > > Reviewed-by: Eli Cohen <elic@nvidia.com>
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 11 ++++++++++-
> > > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > > b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > > index 886449e88502..a9ba02be378b 100644
> > > > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > > @@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct
> > > > vdpa_mgmt_dev *mdev, const char *name,
> > > >  	dev_attr.work_fn = vdpasim_net_work;
> > > >  	dev_attr.buffer_size = PAGE_SIZE;
> > > >
> > > > +	if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> > > > +		if (config->device_features &
> > > > +		    ~dev_attr.supported_features)
> > > > +			return -EINVAL;
> > > > +		dev_attr.supported_features &=
> > > > +			 config->device_features;
> > > > +	}
> > > > +
> > > >  	simdev = vdpasim_create(&dev_attr);
> > > >  	if (IS_ERR(simdev))
> > > >  		return PTR_ERR(simdev);
> > > > @@ -294,7 +302,8 @@ static struct vdpa_mgmt_dev mgmt_dev = {
> > > >  	.id_table = id_table,
> > > >  	.ops = &vdpasim_net_mgmtdev_ops,
> > > >  	.config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
> > > > -			     1 << VDPA_ATTR_DEV_NET_CFG_MTU),
> > > > +			     1 << VDPA_ATTR_DEV_NET_CFG_MTU |
> > > > +		             1 << VDPA_ATTR_DEV_FEATURES),
> > > >  	.max_supported_vqs = VDPASIM_NET_VQ_NUM,
> > > >  	.supported_features = VDPASIM_NET_FEATURES,
> > > >  };
> > > > --
> > > > 2.25.1
> > >
> 

