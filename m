Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED7E609CF8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiJXIk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiJXIkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:40:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B35C2B1B0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666600817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jOtyWoqxkZ/eX0vtXBOH4xVpL53S8rDbYyVtgKpmPhw=;
        b=gRZ1adkOMpgbwP8zDM+HREsurDCpTgZ3HyovEVuGiYRLutdPiraCU29uPfviyxsi7Hg1yY
        4VEnhEPa3c60oUex/PR0O+ykRSZ0iRk8+eAb638FF37hgHao69lwCiDySrfPhYMlz8WU8R
        4bR/ekmy0Pd21iNDTIrNHj6jAlqz8Iw=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-607-uq-TimqrMFSwv110FKldlA-1; Mon, 24 Oct 2022 04:40:15 -0400
X-MC-Unique: uq-TimqrMFSwv110FKldlA-1
Received: by mail-ot1-f70.google.com with SMTP id g18-20020a9d6a12000000b00661a4599b64so5215670otn.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOtyWoqxkZ/eX0vtXBOH4xVpL53S8rDbYyVtgKpmPhw=;
        b=Wl4m6NSK57u2bMXEc1wNIqvJnI8XJpTnU+XGfL7/WkF5vSx1FgQKxq2hQsydDWG0WU
         iLrnfRKGjAh29kQKoh7Dhb5uytpjAbk2/iTfa7Xv0yX80o6SCQt5fX7VbZkQo2cv9ev/
         ElgwU/Y4mRSYbj0+jKB+qfpkfEWsZ4gr1ySSKwrYhXOg3LpA9zu1JC2V1CSL909c6jHg
         BY0TG7EaeC3ui6iTUeFd7piuRC25U3ClHBgcG/RX2RCOC93Q/HaWPTOWRzGL8CHf2PCd
         6QlUD+zk92tMmsMmK61UVnltRIqnFF3TyEB2rhABmdLT30VEHBTYUn3/+H6VKEw+9CK8
         12TQ==
X-Gm-Message-State: ACrzQf13feHktM79R1gFed6b1vk8fHvbHGjyFnJOHuRz8//V7Irez8p1
        Oj4rx2SBccAyqMH/TSAFHMSQDVFCR0+hnHn7d7X0RSaxMf2NXjVycY72x16Fs7HEIItfRAop9tU
        PgbBufBON6dBeydPJereWaYlOgguiNl9Hs9P7ReNG
X-Received: by 2002:a4a:c590:0:b0:480:5ecf:85f4 with SMTP id x16-20020a4ac590000000b004805ecf85f4mr14098472oop.93.1666600814956;
        Mon, 24 Oct 2022 01:40:14 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4Ujz325p1cEEZ0K87dSJzKxjltvHmnBxpIgouVrUw+DXeA7g2lWNByih9zLWwML4S4QBTumyt6BFF4MfxxWKI=
X-Received: by 2002:a4a:c590:0:b0:480:5ecf:85f4 with SMTP id
 x16-20020a4ac590000000b004805ecf85f4mr14098460oop.93.1666600814718; Mon, 24
 Oct 2022 01:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <1666392237-4042-1-git-send-email-si-wei.liu@oracle.com> <1666392237-4042-4-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1666392237-4042-4-git-send-email-si-wei.liu@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 24 Oct 2022 16:40:03 +0800
Message-ID: <CACGkMEti0Z2_sqJbBh_bOVq2ijSUJ96OPS-qd+P4bV490XAA3w@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] vdpa: show dev config as-is in "vdpa dev show" output
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     mst@redhat.com, parav@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 7:49 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
> Live migration of vdpa would typically require re-instate vdpa
> device with an idential set of configs on the destination node,
> same way as how source node created the device in the first
> place. In order to save orchestration software from memorizing
> and keeping track of vdpa config, it will be helpful if the vdpa
> tool provides the aids for exporting the initial configs as-is,
> the way how vdpa device was created. The "vdpa dev show" command
> seems to be the right vehicle for that. It is unlike the "vdpa dev
> config show" command output which usually goes with the live value
> in the device config space, and is not quite reliable subject to
> the dynamics of feature negotiation or possible change by the
> driver to the config space.
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
>   initial_config: mac e4:11:c6:d3:45:f0 max_vq_pairs 4
> $ vdpa dev -jp show
> {
>     "dev": {
>         "vdpa0": {
>             "type": "network",
>             "mgmtdev": "pci/0000:41:04.2",
>             "vendor_id": 5555,
>             "max_vqs": 9,
>             "max_vq_size": 256,
>             "initial_config": {
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
> index bebded6..bfb8f54 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -677,6 +677,41 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct genl_info *i
>  }
>
>  static int
> +vdpa_dev_initcfg_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 device_id)
> +{
> +       struct vdpa_dev_set_config *cfg = &vdev->init_cfg;
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
> +       default:
> +               break;
> +       }
> +
> +       if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) != 0 &&
> +           nla_put_u64_64bit(msg, VDPA_ATTR_DEV_FEATURES,
> +                             cfg->device_features, VDPA_ATTR_PAD))
> +               return err;

A question: If any of those above attributes were not provisioned,
should we show the ones that are inherited from the parent?

Thanks

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
> +       err = vdpa_dev_initcfg_fill(vdev, msg, device_id);
> +       if (err)
> +               goto msg_err;
> +
>         genlmsg_end(msg, hdr);
>         return 0;
>
> --
> 1.8.3.1
>

