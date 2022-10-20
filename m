Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2F26056BD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 07:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiJTF0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 01:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiJTF0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 01:26:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA10918DA84
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 22:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666243570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+RSA0RntEqf7QmuVbJ4H4/9krr36kS4aFkfU2E/RUmU=;
        b=QptxlI3GcWlYlGaR0t32Q90hYid+JX69jd+sE63AsZlcMCDy/ZAbcH+VVIZuLqvhWUxDTK
        DX7CAcpDotNya32bWsahbhkCX5Au3DLnAtC+nZ677ZDfBGisnKROKl6GpSB4FmDuhtlt00
        CAuGuSGhG6phANK7RXJwY+ChWCzFfv8=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-422-hVXrWNvvOjyXVOZ7-EZGSw-1; Thu, 20 Oct 2022 01:26:09 -0400
X-MC-Unique: hVXrWNvvOjyXVOZ7-EZGSw-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-136fd83729dso9282384fac.20
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 22:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+RSA0RntEqf7QmuVbJ4H4/9krr36kS4aFkfU2E/RUmU=;
        b=T4VxDChm63KocfimthL8kBBd48bqkuLNL8GorOdZKQ0cAsIv9/HawFYdmnW3V6zv8F
         N4c6+iO5Fcn0wmEbKD1C3B7pgkxI3WD4sNlYCmryGbwv10+TGvXGS9f75fLYI1Q9efo9
         rLoZEQWC82vKIuLsC3T85YYp1XtsrUiIelKP/lwqGcM3cVR5b4O2I7xfVt/EE5Mqvl4u
         UX13Ha4AD8o6DUi7OA/KbrDRJHLguPo33YJqurcyWUhLMkn7Sld7gsWFk6BHMtOcb3F6
         nCyPnv+fCIXCwRrRz58jgeXKkENqqYuPnfOwzLmXHZ7ufKUyWd0k9DTQmue1MjMN/Ybw
         VqfQ==
X-Gm-Message-State: ACrzQf04yAMGPe1XbO/zp9sUy6qwhureWr7nvautG5/oE1lPjldtU3sB
        EX5vDVLtmEHCNqpN1DuTFTJbkxp6ZwmNOtUSEQzwd7y0rfdRdDIw7jpRD4KHzIaKxICSmsyMdqD
        lnyyDutjBRFWMTuuifpVdrUEr8QGdFTMkk4TVt+hV
X-Received: by 2002:a9d:12a8:0:b0:661:a06f:33d7 with SMTP id g37-20020a9d12a8000000b00661a06f33d7mr6035172otg.237.1666243567543;
        Wed, 19 Oct 2022 22:26:07 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5nSvUC0HcWvAHFOesU6EeZfKDqnoOFz1h2xahVvfHticSDonuZxkzjvKKM0os702cuEIZFj9+ghX/ZL0FOJ/Y=
X-Received: by 2002:a9d:12a8:0:b0:661:a06f:33d7 with SMTP id
 g37-20020a9d12a8000000b00661a06f33d7mr6035164otg.237.1666243567310; Wed, 19
 Oct 2022 22:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <1666137032-28192-1-git-send-email-si-wei.liu@oracle.com> <1666137032-28192-4-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1666137032-28192-4-git-send-email-si-wei.liu@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 20 Oct 2022 13:25:55 +0800
Message-ID: <CACGkMEuDn+Y8OEw6uK+FC0oOOd6+kj0EXS4Fm-+54GjrqY3_Gw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] vdpa: show dev config as-is in "vdpa dev show" output
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
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

On Wed, Oct 19, 2022 at 8:56 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
> Live migration of vdpa would typically require re-instate vdpa
> device with an idential set of configs on the destination node,
> same way as how source node created the device in the first
> place. In order to save orchestration software from memorizing
> and keeping track of vdpa config, it will be helpful if the vdpa
> tool provides the aids for exporting the initial configs from
> which vdpa device was created as-is. The "vdpa dev show" command
> seems to be the right vehicle for that. It is unlike the "vdpa dev
> config show" command output that usually goes with the live value
> in the device config space, which is not quite reliable subject to
> the dynamics of feature negotiation and possible change in device
> config space.
>
> Examples:
>
> 1) Create vDPA by default without any config attribute
>
> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0
> $ vdpa dev show vdpa0
> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
> $ vdpa dev -jp show vdpa0
> {
>     "dev": {
>         "vdpa0": {
>             "type": "network",
>             "mgmtdev": "pci/0000:41:04.2",
>             "vendor_id": 5555,
>             "max_vqs": 9,
>             "max_vq_size": 256,
>         }
>     }
> }
>
> 2) Create vDPA with config attribute(s) specified
>
> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0 \
>     mac e4:11:c6:d3:45:f0 max_vq_pairs 4
> $ vdpa dev show
> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
>   virtio_config: mac e4:11:c6:d3:45:f0 max_vq_pairs 4
> $ vdpa dev -jp show
> {
>     "dev": {
>         "vdpa0": {
>             "type": "network",
>             "mgmtdev": "pci/0000:41:04.2",
>             "vendor_id": 5555,
>             "max_vqs": 9,
>             "max_vq_size": 256,
>             "virtio_config": {
>                 "mac": "e4:11:c6:d3:45:f0",
>                 "max_vq_pairs": 4
>             }
>         }
>     }
> }
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  drivers/vdpa/vdpa.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 566c1c6..91eca6d 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -677,6 +677,41 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct genl_info *i
>  }
>
>  static int
> +vdpa_dev_cfgattrs_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 device_id)
> +{
> +       struct vdpa_dev_set_config *cfg = &vdev->vdev_cfg;
> +       int err = -EMSGSIZE;
> +
> +       if (!cfg->mask)
> +               return 0;
> +
> +       switch (device_id) {
> +       case VIRTIO_ID_NET:
> +               if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR)) != 0 &&
> +                   nla_put(msg, VDPA_ATTR_DEV_NET_CFG_MACADDR,
> +                           sizeof(cfg->net.mac), cfg->net.mac))
> +                       return err;
> +               if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) != 0 &&
> +                   nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, cfg->net.mtu))
> +                       return err;
> +               if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) != 0 &&
> +                   nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP,
> +                               cfg->net.max_vq_pairs))
> +                       return err;
> +               break;

This makes me think if we can reuse the virtio_net_config structure
other than duplicate it slowly with a dedicated nested structure
inside vdpa_dev_set_config then we can reuse the
vdpa_dev_net_config_fill().

Thanks

> +       default:
> +               break;
> +       }
> +
> +       if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) != 0 &&
> +           nla_put_u64_64bit(msg, VDPA_ATTR_DEV_FEATURES,
> +                             cfg->device_features, VDPA_ATTR_PAD))
> +               return err;
> +
> +       return 0;
> +}
> +
> +static int
>  vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq,
>               int flags, struct netlink_ext_ack *extack)
>  {
> @@ -715,6 +750,10 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct genl_info *i
>         if (nla_put_u16(msg, VDPA_ATTR_DEV_MIN_VQ_SIZE, min_vq_size))
>                 goto msg_err;
>
> +       err = vdpa_dev_cfgattrs_fill(vdev, msg, device_id);
> +       if (err)
> +               goto msg_err;
> +
>         genlmsg_end(msg, hdr);
>         return 0;
>
> --
> 1.8.3.1
>

