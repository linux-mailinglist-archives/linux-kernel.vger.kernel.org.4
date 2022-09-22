Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76F85E5E6A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 11:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiIVJXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 05:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiIVJXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 05:23:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B038246D8E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 02:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663838581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SuTHYJVFAUSisqUYJ7aEiJ6bas6gBkFhem0cKwxhc6c=;
        b=AkO5071BwPuRRz1yfJMEIA4qTsXYx7g49xRU2KjfzLojQumgDaAuhtWVWpT5V6fxyAhcd/
        D69scul02o4Q4cuTHnNxmM/hO2gju91VWC2MtCGUZXORQH1dKgOtCZjwIOyWc0c2tGp69b
        712lErZQJ53CrlPe1UcaH369tV45Id0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-437-cvE68U8nMrKP43kt3DIGdQ-1; Thu, 22 Sep 2022 05:23:00 -0400
X-MC-Unique: cvE68U8nMrKP43kt3DIGdQ-1
Received: by mail-qk1-f197.google.com with SMTP id i7-20020a05620a404700b006ced0d02b68so6212278qko.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 02:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=SuTHYJVFAUSisqUYJ7aEiJ6bas6gBkFhem0cKwxhc6c=;
        b=KUmYrbKRMa4F9Lfxt0ue5wazYyC7q4mwHKdKx5UnWXM5wKpJ8vqmUjggW3R0leLjHp
         pqsqRgBGvNANMBbnPE4alqDpZomqMfc/DiQxMq6ZQyfixnZXEZc8/ZEmI7keLOvDe2Wx
         dm1mPY5ZLSunGY382yA5xgCIjILoHTdDpkqGvT/ZFOH+HQxEyVvgWYi01w/axcmDD678
         29Ozq3N6RAOLS2pJ8FZx8uLTMRAm+QdplnR5oUC4D2felP1z+mHpyDVQHDaQLCd+3wY+
         uuSQJsRPxmFMUDSUWuzjuMgEN3H4xhXYQMfrDfsD50PVqMXlG87fZawbPWQoJhpwpLUa
         bXww==
X-Gm-Message-State: ACrzQf3kepCvH0cYzN86b+hyxBr4jM/sgHZaPXyfXnM93jYzWvN8SfVZ
        w8H5k8Y9B9EiNl9WRzhmbwHxbd02z5hTBeiYKlsfnMhUD8Ti35wEy9BzzTifgtBbxLRoVci4drz
        PAfmqMxyzIzP/t3dAX2T4yB30
X-Received: by 2002:ac8:5d89:0:b0:35b:b58a:2bcb with SMTP id d9-20020ac85d89000000b0035bb58a2bcbmr1954236qtx.273.1663838580263;
        Thu, 22 Sep 2022 02:23:00 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM719h5lWWPYiNaxVsN/CPer8q5YrppAFE1Z2dDMsAoQmzX/B3T49d7wpsslOfN8ulseMZmieg==
X-Received: by 2002:ac8:5d89:0:b0:35b:b58a:2bcb with SMTP id d9-20020ac85d89000000b0035bb58a2bcbmr1954229qtx.273.1663838580053;
        Thu, 22 Sep 2022 02:23:00 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-69.retail.telecomitalia.it. [87.11.6.69])
        by smtp.gmail.com with ESMTPSA id q20-20020a05620a0d9400b006b919c6749esm3689379qkl.91.2022.09.22.02.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 02:22:59 -0700 (PDT)
Date:   Thu, 22 Sep 2022 11:22:50 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, lulu@redhat.com, xieyongji@bytedance.com,
        linux-kernel@vger.kernel.org, gdawar@xilinx.com,
        virtualization@lists.linux-foundation.org, eperezma@redhat.com,
        wuzongyong@linux.alibaba.com, elic@nvidia.com,
        lingshan.zhu@intel.com
Subject: Re: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
Message-ID: <20220922092250.pj26iutmywlemvbm@sgarzare-redhat>
References: <20220922024305.1718-1-jasowang@redhat.com>
 <20220922024305.1718-3-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220922024305.1718-3-jasowang@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 10:43:04AM +0800, Jason Wang wrote:
>This patch implements features provisioning for vdpa_sim_net.
>
>1) validating the provisioned features to be a subset of the parent
>   features.
>2) clearing the features that is not wanted by the userspace
>
>For example:
>
># vdpa mgmtdev show
>vdpasim_net:
>  supported_classes net
>  max_supported_vqs 3
>  dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM
>
>1) provision vDPA device with all features that are supported by the
>   net simulator
>
># vdpa dev add name dev1 mgmtdev vdpasim_net
># vdpa dev config show
>dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
>  negotiated_features MTU MAC CTRL_VQ CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM
>
>2) provision vDPA device with a subset of the features
>
># vdpa dev add name dev1 mgmtdev vdpasim_net device_features 0x300020000
># vdpa dev config show
>dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
>  negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
>
>Reviewed-by: Eli Cohen <elic@nvidia.com>
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 11 ++++++++++-
> 1 file changed, 10 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>index 886449e88502..a9ba02be378b 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>@@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
> 	dev_attr.work_fn = vdpasim_net_work;
> 	dev_attr.buffer_size = PAGE_SIZE;
>
>+	if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
>+		if (config->device_features &
>+		    ~dev_attr.supported_features)
>+			return -EINVAL;
>+		dev_attr.supported_features &=
>+			 config->device_features;
>+	}
>+

How about doing this inside vdpasim_create()?

That way we support this feature in all simulators.

Thanks,
Stefano

> 	simdev = vdpasim_create(&dev_attr);
> 	if (IS_ERR(simdev))
> 		return PTR_ERR(simdev);
>@@ -294,7 +302,8 @@ static struct vdpa_mgmt_dev mgmt_dev = {
> 	.id_table = id_table,
> 	.ops = &vdpasim_net_mgmtdev_ops,
> 	.config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
>-			     1 << VDPA_ATTR_DEV_NET_CFG_MTU),
>+			     1 << VDPA_ATTR_DEV_NET_CFG_MTU |
>+		             1 << VDPA_ATTR_DEV_FEATURES),
> 	.max_supported_vqs = VDPASIM_NET_VQ_NUM,
> 	.supported_features = VDPASIM_NET_FEATURES,
> };
>-- 
>2.25.1
>
>_______________________________________________
>Virtualization mailing list
>Virtualization@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>

