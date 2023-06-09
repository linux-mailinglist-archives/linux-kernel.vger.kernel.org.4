Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E34729FC4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241383AbjFIQM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241444AbjFIQMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:12:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A8930CD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686327131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y4bm62kfkkLTnjUJmvlgyp+ign6wrzvvVnxHsSjlw0Y=;
        b=L57/Q6T/MjON98tLl04U/JNeRC0jftZ71dzDJFlLzD+dzJVUil1Zypd0p0Hk73cxZbkThR
        IemHx1bXSQl30SegB9UtNbTX6NLGzBE6WqOCHpG0tCeF1dS5O0wHQOPaFQHDbHiyj6dN+t
        nLUYFAC0gxNlM78xGyowqEEeOPv3+lk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-sjpRqg5RMZadSmgev_kipw-1; Fri, 09 Jun 2023 12:12:10 -0400
X-MC-Unique: sjpRqg5RMZadSmgev_kipw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f7678c74beso12418815e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 09:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686327129; x=1688919129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4bm62kfkkLTnjUJmvlgyp+ign6wrzvvVnxHsSjlw0Y=;
        b=c91/7tPtSSjSlI9eh3cyXdtxVCo0eHug3Lt8SnEuD30ZtYNyT4xvz9x3zwhmzuib5Z
         HwnZwIaujtYTtew1b9ticim4nORf+hfHF/+i8Z2I3iIlEoJRxqu2bVAnBYSghX7vDXoa
         G9fkHKRGGqG7UQXkGo1y0MWCP8hA83nGM9ClY6rAmkmXaGhSkIef2alcN2apVUU/EdAs
         b3wb1Tldv/NHjRuFNd2wi50Gdy8hfxccuWib7yGrJeb2siEOqdmpPiL/Sxe2mmLuXGt/
         8rpsADXmywozV7P5oE0UDu2VPGYEKgzX4Bms0H3yyLnRS8YAEM+D469RQYT3zziQ0nA9
         Svag==
X-Gm-Message-State: AC+VfDy6Es5wVPPKihLCE+RaSE09K6T+8Sfoaw3kz5Rh3NEDm4pQQ4z2
        abeCu9BxZ7C+0Ojq2Mo7wl/FpFQTqhzIAb6Pu40nLIZ+VJhAkMkcUEbRgoFLFjDHrJ17/dkTn8q
        gR1QIrnahxmBLr6aQ/KtSORZM
X-Received: by 2002:a7b:c84c:0:b0:3f6:76e:604b with SMTP id c12-20020a7bc84c000000b003f6076e604bmr1525962wml.0.1686327129333;
        Fri, 09 Jun 2023 09:12:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5xm9yUTrC2OmG8c4yJjmFGfxA7jlxP+M4arKQJPvSSV953T9IiEEH9ysAY86JxwiufCmeo3g==
X-Received: by 2002:a7b:c84c:0:b0:3f6:76e:604b with SMTP id c12-20020a7bc84c000000b003f6076e604bmr1525952wml.0.1686327129048;
        Fri, 09 Jun 2023 09:12:09 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7403:2800:22a6:7656:500:4dab])
        by smtp.gmail.com with ESMTPSA id x15-20020a5d650f000000b0030adfa48e1esm4815815wru.29.2023.06.09.09.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 09:12:08 -0700 (PDT)
Date:   Fri, 9 Jun 2023 12:12:06 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Angus Chen <angus.chen@jaguarmicro.com>
Cc:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] vdpa/vp_vdpa: Check queue number of vdpa device from
 add_config
Message-ID: <20230609120939-mutt-send-email-mst@kernel.org>
References: <20230608090124.1807-1-angus.chen@jaguarmicro.com>
 <20230608154400-mutt-send-email-mst@kernel.org>
 <TY2PR06MB34248F29ED36A5DBB4FE0E2E8551A@TY2PR06MB3424.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY2PR06MB34248F29ED36A5DBB4FE0E2E8551A@TY2PR06MB3424.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 12:42:22AM +0000, Angus Chen wrote:
> 
> 
> > -----Original Message-----
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Friday, June 9, 2023 3:45 AM
> > To: Angus Chen <angus.chen@jaguarmicro.com>
> > Cc: jasowang@redhat.com; virtualization@lists.linux-foundation.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v2] vdpa/vp_vdpa: Check queue number of vdpa device from
> > add_config
> > 
> > On Thu, Jun 08, 2023 at 05:01:24PM +0800, Angus Chen wrote:
> > > When add virtio_pci vdpa device,check the vqs number of device cap
> > > and max_vq_pairs from add_config.
> > > Simply starting from failing if the provisioned #qp is not
> > > equal to the one that hardware has.
> > >
> > > Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> > 
> > I am not sure about this one. How does userspace know
> > which values are legal?
> Maybe we can print device cap of device in dev_err?

No one reads these except kernel devs. Surely not userspace.

> > 
> > If there's no way then maybe we should just cap the value
> > to what device can support but otherwise keep the device
> > working.
> We I use max_vqs pair to test vp_vdpa,it doesn't work as expect.
> And there is no any hint of this.

So things don't work either way just differently.
Let's come up with a way for userspace to know what's legal
so things can start working.


> > 
> > > ---
> > > v1: Use max_vqs from add_config
> > > v2: Just return fail if max_vqs from add_config is not same as device
> > > 	cap. Suggested by jason.
> > >
> > >  drivers/vdpa/virtio_pci/vp_vdpa.c | 35 ++++++++++++++++++-------------
> > >  1 file changed, 21 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c
> > b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > > index 281287fae89f..c1fb6963da12 100644
> > > --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> > > +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > > @@ -480,32 +480,39 @@ static int vp_vdpa_dev_add(struct
> > vdpa_mgmt_dev *v_mdev, const char *name,
> > >  	u64 device_features;
> > >  	int ret, i;
> > >
> > > -	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
> > > -				    dev, &vp_vdpa_ops, 1, 1, name, false);
> > > -
> > > -	if (IS_ERR(vp_vdpa)) {
> > > -		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
> > > -		return PTR_ERR(vp_vdpa);
> > > +	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) {
> > > +		if (add_config->net.max_vq_pairs != (v_mdev->max_supported_vqs /
> > 2)) {
> > > +			dev_err(&pdev->dev, "max vqs 0x%x should be equal to 0x%x
> > which device has\n",
> > > +				add_config->net.max_vq_pairs*2,
> > v_mdev->max_supported_vqs);
> > > +			return -EINVAL;
> > > +		}
> > >  	}
> > >
> > > -	vp_vdpa_mgtdev->vp_vdpa = vp_vdpa;
> > > -
> > > -	vp_vdpa->vdpa.dma_dev = &pdev->dev;
> > > -	vp_vdpa->queues = vp_modern_get_num_queues(mdev);
> > > -	vp_vdpa->mdev = mdev;
> > > -
> > >  	device_features = vp_modern_get_features(mdev);
> > >  	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> > >  		if (add_config->device_features & ~device_features) {
> > > -			ret = -EINVAL;
> > >  			dev_err(&pdev->dev, "Try to provision features "
> > >  				"that are not supported by the device: "
> > >  				"device_features 0x%llx provisioned 0x%llx\n",
> > >  				device_features, add_config->device_features);
> > > -			goto err;
> > > +			return -EINVAL;
> > >  		}
> > >  		device_features = add_config->device_features;
> > >  	}
> > > +
> > > +	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
> > > +				    dev, &vp_vdpa_ops, 1, 1, name, false);
> > > +
> > > +	if (IS_ERR(vp_vdpa)) {
> > > +		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
> > > +		return PTR_ERR(vp_vdpa);
> > > +	}
> > > +
> > > +	vp_vdpa_mgtdev->vp_vdpa = vp_vdpa;
> > > +
> > > +	vp_vdpa->vdpa.dma_dev = &pdev->dev;
> > > +	vp_vdpa->queues = v_mdev->max_supported_vqs;
> > > +	vp_vdpa->mdev = mdev;
> > >  	vp_vdpa->device_features = device_features;
> > >
> > >  	ret = devm_add_action_or_reset(dev, vp_vdpa_free_irq_vectors, pdev);
> > > --
> > > 2.25.1
> 

