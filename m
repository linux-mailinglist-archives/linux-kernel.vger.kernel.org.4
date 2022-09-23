Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137565E7278
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 05:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbiIWDeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 23:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiIWDd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 23:33:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDCB1166F3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 20:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663904036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jfwRdGDNcq40RH+ojb8JkEtDCmxqgfcCO3MCP5Icg8s=;
        b=Q8e4fDzvNXxUPyztI7YliAQljbz+Xe9zwnmrL0otDWzMQSfrc2gqz0W+RusSTAsZcJizak
        a/g6RY9zXlK4lXReuaaAwY555qnfCxG2IxvF1F0GdpAgJGaR4xxkaRNJagVA3jSs260Tyn
        u22a01y2pghlxG9iqLKJtX6NnZSEKkI=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-344-FwYLun0vPLCtGTTbKcqfjQ-1; Thu, 22 Sep 2022 23:33:55 -0400
X-MC-Unique: FwYLun0vPLCtGTTbKcqfjQ-1
Received: by mail-ot1-f70.google.com with SMTP id p4-20020a9d4544000000b0065952fed1aeso5381287oti.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 20:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=jfwRdGDNcq40RH+ojb8JkEtDCmxqgfcCO3MCP5Icg8s=;
        b=tOXK6bAFcjUt8sjUOIQGYlQ5euyNKllUNQT6tpPIp0KZxQFfUOLrubhGBXyos8h00/
         ekfrEI7lm90TstqA9Bj+OvuCGKTyPswrOw0VLs/27pzw4FeOkqyozMttwGBmxVCEwItj
         nnbIcJWiogQrTPumLSGatPuJrMchZ6Cn7RYMOw7/dmw3/Lz1VJgEM4qlgSoSjcAoOecs
         w3FbsVMNoAvLtxU9n3Da6FYKV6sQEel6sGSx2OacOOE28cVc21dQNq1GJ0Zf841qW2R1
         JvX2ZVB7WV+g4AX/7Durf1l4IgX6Fy43BMJqHuZ7E9XGsET2JTIzj0OTBMRfVNVxwCWh
         6vPw==
X-Gm-Message-State: ACrzQf0PgQN3dDCkDkWSbKFai4yoleRJ3iBaS0stm86vq8kwdUUOLGwl
        XOHV+btkMwGl+2vKBT2Az+wPz7yuYHHNHsVfvS4vGkBIywQvWxqPwkoX3Y7NNma690G4P8BEJ8S
        2YLdTl7VayJjTiO4kriCsDlwOa93hOt96+zD45O97
X-Received: by 2002:a4a:d351:0:b0:476:46fd:c2f1 with SMTP id d17-20020a4ad351000000b0047646fdc2f1mr2002945oos.93.1663904034605;
        Thu, 22 Sep 2022 20:33:54 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5eqtkRyiERFEunZk642z2/M048SWtLReDOqGxDyluNWX4hDNUDToBGyDd/A5vZWaP/MZjmW7s5p1mxQp+9v60=
X-Received: by 2002:a4a:d351:0:b0:476:46fd:c2f1 with SMTP id
 d17-20020a4ad351000000b0047646fdc2f1mr2002935oos.93.1663904034409; Thu, 22
 Sep 2022 20:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220922024305.1718-1-jasowang@redhat.com> <20220922024305.1718-3-jasowang@redhat.com>
 <20220922092250.pj26iutmywlemvbm@sgarzare-redhat>
In-Reply-To: <20220922092250.pj26iutmywlemvbm@sgarzare-redhat>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 23 Sep 2022 11:33:43 +0800
Message-ID: <CACGkMEvcZdPE7-jhhcYn=ZAf0BgEE=CEurqe68dOtWGcZzRM8Q@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     mst <mst@redhat.com>, Cindy Lu <lulu@redhat.com>,
        Yongji Xie <xieyongji@bytedance.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gautam Dawar <gdawar@xilinx.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        eperezma <eperezma@redhat.com>,
        Wu Zongyong <wuzongyong@linux.alibaba.com>,
        Eli Cohen <elic@nvidia.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 5:23 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Thu, Sep 22, 2022 at 10:43:04AM +0800, Jason Wang wrote:
> >This patch implements features provisioning for vdpa_sim_net.
> >
> >1) validating the provisioned features to be a subset of the parent
> >   features.
> >2) clearing the features that is not wanted by the userspace
> >
> >For example:
> >
> ># vdpa mgmtdev show
> >vdpasim_net:
> >  supported_classes net
> >  max_supported_vqs 3
> >  dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM
> >
> >1) provision vDPA device with all features that are supported by the
> >   net simulator
> >
> ># vdpa dev add name dev1 mgmtdev vdpasim_net
> ># vdpa dev config show
> >dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
> >  negotiated_features MTU MAC CTRL_VQ CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM
> >
> >2) provision vDPA device with a subset of the features
> >
> ># vdpa dev add name dev1 mgmtdev vdpasim_net device_features 0x300020000
> ># vdpa dev config show
> >dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
> >  negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
> >
> >Reviewed-by: Eli Cohen <elic@nvidia.com>
> >Signed-off-by: Jason Wang <jasowang@redhat.com>
> >---
> > drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 11 ++++++++++-
> > 1 file changed, 10 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> >index 886449e88502..a9ba02be378b 100644
> >--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> >+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> >@@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
> >       dev_attr.work_fn = vdpasim_net_work;
> >       dev_attr.buffer_size = PAGE_SIZE;
> >
> >+      if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> >+              if (config->device_features &
> >+                  ~dev_attr.supported_features)
> >+                      return -EINVAL;
> >+              dev_attr.supported_features &=
> >+                       config->device_features;
> >+      }
> >+
>
> How about doing this inside vdpasim_create()?
>
> That way we support this feature in all simulators.

Yes, let me do that in the next version.

Thanks

>
> Thanks,
> Stefano
>
> >       simdev = vdpasim_create(&dev_attr);
> >       if (IS_ERR(simdev))
> >               return PTR_ERR(simdev);
> >@@ -294,7 +302,8 @@ static struct vdpa_mgmt_dev mgmt_dev = {
> >       .id_table = id_table,
> >       .ops = &vdpasim_net_mgmtdev_ops,
> >       .config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
> >-                           1 << VDPA_ATTR_DEV_NET_CFG_MTU),
> >+                           1 << VDPA_ATTR_DEV_NET_CFG_MTU |
> >+                           1 << VDPA_ATTR_DEV_FEATURES),
> >       .max_supported_vqs = VDPASIM_NET_VQ_NUM,
> >       .supported_features = VDPASIM_NET_FEATURES,
> > };
> >--
> >2.25.1
> >
> >_______________________________________________
> >Virtualization mailing list
> >Virtualization@lists.linux-foundation.org
> >https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> >
>

