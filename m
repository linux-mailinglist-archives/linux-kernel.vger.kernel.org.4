Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61985E5C73
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 09:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiIVHaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 03:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiIVHaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 03:30:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFB6A0605
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 00:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663831799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kbup5Fpy9jSUW1POLJvMYeKDSQiZ2Bk6VOpsIsxqqKs=;
        b=DoknsvFROvjp+E1k/QqbedKyYug0P/ZchcA/SxU3I4ASpSlPwPqPrdcXRVcQXa6qBA58M2
        AnTPN7dxWfCFgZ7X0jWqxgv6xnj5djTHuizB3pLst0k7jl6HZZaeB8J142HmS6xPonmofU
        t+VCiQ0vVVmTZ4XG2kEtM2ArccfnGr0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-508-mat5elJwNPGiFJLqt3A7Lg-1; Thu, 22 Sep 2022 03:29:57 -0400
X-MC-Unique: mat5elJwNPGiFJLqt3A7Lg-1
Received: by mail-wm1-f70.google.com with SMTP id g8-20020a05600c4ec800b003b4bcbdb63cso3683135wmq.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 00:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Kbup5Fpy9jSUW1POLJvMYeKDSQiZ2Bk6VOpsIsxqqKs=;
        b=uIEt3a+vnKIpQBTIRfEXvLOiJCiTHzap2bfys871ORovAabLIFS3w+/Qyy2mL19UGl
         Li62W5oxVJG5bzVud7jJlRZW0N6G1NoqpXlJuTblhkjWaAXnVR0cDslO6QosR24PH4UA
         mB5EuUWy0BT3MVttHIALQZdk+b0EUs4IincKMc/mtOEQhwedyKR50JHo3zd7f7R5YDYV
         H4cH/VuFLL7Z2GERZdCtnHlGSZWtS0Y+iy56csKFXzBgHoAYgzMx9eihdxOSOOnK9gEg
         B63/AcjLtEjuneYS0dmSOpLhS6m+wWtmJOqTUfh4+3439faRbgh7Fxc0i+BDzvuHeHXM
         i+4A==
X-Gm-Message-State: ACrzQf2A877QYU0jSoUBt84ss1ER3a0ri71eSILm3DROrVL7CO3fw6pQ
        hqAQIHxp55iEYtZN3SjG0jlQJgbIPMH8NmBZIgRrIL3KFAG7yHLvyYlSaOKlHfcUH2YkEmvXNvG
        zjidh+PfWRFMBNEft16/IOnIN
X-Received: by 2002:a05:600c:3595:b0:3b4:8378:98d2 with SMTP id p21-20020a05600c359500b003b4837898d2mr1351505wmq.64.1663831796651;
        Thu, 22 Sep 2022 00:29:56 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6d3sPnC0/xR5T1IuwaFJ8oueiIl2rfbv0L00UmB89dILcchBGOD5u01PouOpp4WE/e99xU+A==
X-Received: by 2002:a05:600c:3595:b0:3b4:8378:98d2 with SMTP id p21-20020a05600c359500b003b4837898d2mr1351482wmq.64.1663831796418;
        Thu, 22 Sep 2022 00:29:56 -0700 (PDT)
Received: from redhat.com ([2.55.47.213])
        by smtp.gmail.com with ESMTPSA id p4-20020a05600c358400b003b4935f04a4sm6386230wmq.5.2022.09.22.00.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 00:29:55 -0700 (PDT)
Date:   Thu, 22 Sep 2022 03:29:50 -0400
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
Message-ID: <20220922032858-mutt-send-email-mst@kernel.org>
References: <20220922024305.1718-1-jasowang@redhat.com>
 <20220922024305.1718-3-jasowang@redhat.com>
 <DM8PR12MB54005C65A85B32063A5E17A8AB4E9@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR12MB54005C65A85B32063A5E17A8AB4E9@DM8PR12MB5400.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 05:13:59AM +0000, Eli Cohen wrote:
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Thursday, 22 September 2022 5:43
> > To: mst@redhat.com; jasowang@redhat.com
> > Cc: Eli Cohen <elic@nvidia.com>; si-wei.liu@oracle.com; Parav Pandit
> > <parav@nvidia.com>; wuzongyong@linux.alibaba.com;
> > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > eperezma@redhat.com; lingshan.zhu@intel.com; gdawar@xilinx.com;
> > lulu@redhat.com; xieyongji@bytedance.com
> > Subject: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
> > 
> > This patch implements features provisioning for vdpa_sim_net.
> > 
> > 1) validating the provisioned features to be a subset of the parent
> >    features.
> > 2) clearing the features that is not wanted by the userspace
> > 
> > For example:
> > 
> > # vdpa mgmtdev show
> > vdpasim_net:
> >   supported_classes net
> >   max_supported_vqs 3
> >   dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT
> > VERSION_1 ACCESS_PLATFORM
> > 
> > 1) provision vDPA device with all features that are supported by the
> >    net simulator
> > 
> > # vdpa dev add name dev1 mgmtdev vdpasim_net
> > # vdpa dev config show
> > dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
> >   negotiated_features MTU MAC CTRL_VQ CTRL_MAC_ADDR VERSION_1
> > ACCESS_PLATFORM
> > 
> > 2) provision vDPA device with a subset of the features
> > 
> > # vdpa dev add name dev1 mgmtdev vdpasim_net device_features
> > 0x300020000
> 
> How about "features_mask" instead of "device_features"? Could avoid confusion.

Not sure I agree.
features_mask to me would mean it is & with features. Not the case here.

> > # vdpa dev config show
> > dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
> >   negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
> > 
> > Reviewed-by: Eli Cohen <elic@nvidia.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > index 886449e88502..a9ba02be378b 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > @@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct
> > vdpa_mgmt_dev *mdev, const char *name,
> >  	dev_attr.work_fn = vdpasim_net_work;
> >  	dev_attr.buffer_size = PAGE_SIZE;
> > 
> > +	if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> > +		if (config->device_features &
> > +		    ~dev_attr.supported_features)
> > +			return -EINVAL;
> > +		dev_attr.supported_features &=
> > +			 config->device_features;
> > +	}
> > +
> >  	simdev = vdpasim_create(&dev_attr);
> >  	if (IS_ERR(simdev))
> >  		return PTR_ERR(simdev);
> > @@ -294,7 +302,8 @@ static struct vdpa_mgmt_dev mgmt_dev = {
> >  	.id_table = id_table,
> >  	.ops = &vdpasim_net_mgmtdev_ops,
> >  	.config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
> > -			     1 << VDPA_ATTR_DEV_NET_CFG_MTU),
> > +			     1 << VDPA_ATTR_DEV_NET_CFG_MTU |
> > +		             1 << VDPA_ATTR_DEV_FEATURES),
> >  	.max_supported_vqs = VDPASIM_NET_VQ_NUM,
> >  	.supported_features = VDPASIM_NET_FEATURES,
> >  };
> > --
> > 2.25.1
> 

