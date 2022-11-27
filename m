Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C7C639BC7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 17:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiK0Qfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 11:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiK0Qft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 11:35:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD73C115E
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 08:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669566887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tv0i6Mb3/67wUHBrHUEJrFYjSPaDixK1VWQy8tVPRpc=;
        b=eKBdDDTwifn2TNWsCEZgGmnL5PwBrYhaYK6T/2fAurn9uEsR685KFyXT+bmFSNw7nu3Rd+
        uLS9FMAcRQfoTg8N4irTdw/iQMT5Vz+BffbVj2hUYmPPZ9M7svfZTtiUsKijtgo43pp7ak
        FbgSa/ENBcXHka6InfJBtdd0xFT3n58=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-655-raS-VGFiMDeCQ0QYJZS8fw-1; Sun, 27 Nov 2022 11:34:46 -0500
X-MC-Unique: raS-VGFiMDeCQ0QYJZS8fw-1
Received: by mail-wm1-f70.google.com with SMTP id o5-20020a05600c510500b003cfca1a327fso5153913wms.8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 08:34:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tv0i6Mb3/67wUHBrHUEJrFYjSPaDixK1VWQy8tVPRpc=;
        b=E4BSKA1tYPm3aPJ6qnzfFbI2fWcadP4EZpOcvqMZOAmpAXK+u6hc1CiadCKxe5NcV5
         TGDzQzj168oJeuHtD9gBAjjQxYJwWI0dkyOnDTwqWIK/drg/dHkACBbRDS4W5nUa5pxb
         OyVXwfkdVSERxkffqtJ88w4cvOYeIMun5dkjuZak2KKiI3P2UhHPGpuFmX6BEJA8Hq59
         oRazBXF87W6JF/8y5WWYeYe1fFKdEmVKSF67gHOu2qiwFcpi+vpka52jmDzM/33cub/1
         jB9q1wMTiqG5zo0cFFQmrNiAcX48kq4fAcwrhKiVAR2vdPRlol+umAWPmrBo5uDXjHzG
         2OXQ==
X-Gm-Message-State: ANoB5pm/YEqfXKK9C1+k2RAUUEgtBtqWSOrdjjYaST3b/Y57ferw1SNv
        sEmITXJfZrfA0wUauLW4RgE7GUfnLC041OtWNWLAJtNoYTSz1tmJXeKoDoZ2rzW7dOI63bwjFRM
        FjXHeYLCyrwLlAKizAujxr8Pd
X-Received: by 2002:a05:600c:4e06:b0:3cf:703e:1d88 with SMTP id b6-20020a05600c4e0600b003cf703e1d88mr23369400wmq.155.1669566885115;
        Sun, 27 Nov 2022 08:34:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5cUmg5EoGEynuuBBNzwkfATchN/A2m3eltFERYL+l0sxG3i2BIa2OQpQfV/VG64yqxo0qrUQ==
X-Received: by 2002:a05:600c:4e06:b0:3cf:703e:1d88 with SMTP id b6-20020a05600c4e0600b003cf703e1d88mr23369394wmq.155.1669566884863;
        Sun, 27 Nov 2022 08:34:44 -0800 (PST)
Received: from redhat.com ([2.52.135.58])
        by smtp.gmail.com with ESMTPSA id b10-20020adfde0a000000b0022e57e66824sm9966230wrm.99.2022.11.27.08.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 08:34:44 -0800 (PST)
Date:   Sun, 27 Nov 2022 11:34:40 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     error27@gmail.com, harshit.m.mogalapalli@gmail.com,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Gautam Dawar <gautam.dawar@xilinx.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Guanjun <guanjun@linux.alibaba.com>,
        Parav Pandit <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vduse: Fix a possible warning in vduse_create_dev()
Message-ID: <20221127113416-mutt-send-email-mst@kernel.org>
References: <20221126040000.775914-1-harshit.m.mogalapalli@oracle.com>
 <20221126181822-mutt-send-email-mst@kernel.org>
 <8253ab3f-b4f2-ff60-7e87-6455c9c10dc8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8253ab3f-b4f2-ff60-7e87-6455c9c10dc8@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2022 at 08:16:24AM +0530, Harshit Mogalapalli wrote:
> Hi Micheal,
> 
> On 27/11/22 4:52 am, Michael S. Tsirkin wrote:
> > On Fri, Nov 25, 2022 at 07:59:58PM -0800, Harshit Mogalapalli wrote:
> > > As 'dev->vq_num' is user-controlled data, if user tries to allocate
> > > memory larger than(>=) MAX_ORDER, then kcalloc() will fail, it
> > > creates a stack trace and messes up dmesg with a warning.
> > > 
> > > Call trace:
> > > -> vduse_ioctl
> > > --> vduse_create_dev
> > > 'config->vq_num' is user data as it comes from ioctl, which is
> > > assigned to 'dev->vq_num'.
> > > 
> > > Add __GFP_NOWARN in order to avoid too large allocation warning.
> > > This is detected by static analysis using smatch.
> > > 
> > > Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> > > Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> > > ---
> > >   drivers/vdpa/vdpa_user/vduse_dev.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > index 35dceee3ed56..5e9546b16165 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -1512,7 +1512,8 @@ static int vduse_create_dev(struct vduse_dev_config *config,
> > >   	dev->config_size = config->config_size;
> > >   	dev->vq_align = config->vq_align;
> > >   	dev->vq_num = config->vq_num;
> > > -	dev->vqs = kcalloc(dev->vq_num, sizeof(*dev->vqs), GFP_KERNEL);
> > > +	dev->vqs = kcalloc(dev->vq_num, sizeof(*dev->vqs),
> > > +			   GFP_KERNEL | __GFP_NOWARN);
> > >   	if (!dev->vqs)
> > >   		goto err_vqs;
> > 
> 
> Thanks for checking the patch.
> 
> > This is insufficient - the real source of the problem is that
> > vq_num is not validated.
> > The thing to do is to validate config and limit vq_num to 0xffff;
> > 
> 
> 1557 static long vduse_ioctl(struct file *file, unsigned int cmd,
> 1558                         unsigned long arg)
> 1559 {
> 1560         int ret;
> 1561         void __user *argp = (void __user *)arg;
> 1564         mutex_lock(&vduse_lock);
> 1565         switch (cmd) {
>              ....
> 1584         case VDUSE_CREATE_DEV: {
> 1585                 struct vduse_dev_config config;
> 1587                 void *buf;
> 1588
> 1589                 ret = -EFAULT;
> 1590                 if (copy_from_user(&config, argp, size))
> 1591                         break;
> 1592
> 1593                 ret = -EINVAL;
> 1594                 if (vduse_validate_config(&config) == false)
> 1595                         break;
> 1596
> 1597                 buf = vmemdup_user(argp + size, config.config_size);
> 1598                 if (IS_ERR(buf)) {
> 1599                         ret = PTR_ERR(buf);
> 1600                         break;
> 1601                 }
> 1602                 config.name[VDUSE_NAME_MAX - 1] = '\0';
> 1603                 ret = vduse_create_dev(&config, buf,
> control->api_version);
> 1604                 if (ret)
> 1605                         kvfree(buf);
> 1606                 break;
> 1607         }
> 
> we have vduse_validate_config() being called in vduse_ioctl() which is the
> caller of vduse_create_dev(), so validate_config() is not necessary in
> vduse_create_dev() ?
> 
> Thanks,
> Harshit

OK but I don't see vduse_validate_config checking vq_num.

> > 
> > > -- 
> > > 2.38.1
> > 

