Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B336AE385
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjCGO7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCGO6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:58:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDE09079F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678200113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=4ygI/x1GYEj/V+iFapis9+U0j5L90poPGMG3zDcgRww=;
        b=bO/tBlCMZfGXnhVZXscOVHhf7E+TGy7MzcSrVCviwGEJSAev+3897++vtBHgLaWcb2PRZI
        YA4yUnuwYkQnglWgAzJ4x9W3Ii0NESJshDJizeQhb+t1aqIid9EYBSFdHksj/Nw/tfbJ1M
        LK9CkdL2gA4xhIPh4IyTLTo4sQU3rQs=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-kaWr1rxQOyyZl-RsEoeHCw-1; Tue, 07 Mar 2023 09:41:52 -0500
X-MC-Unique: kaWr1rxQOyyZl-RsEoeHCw-1
Received: by mail-yb1-f200.google.com with SMTP id c192-20020a25c0c9000000b0092aabd4fa90so14334563ybf.18
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 06:41:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678200112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ygI/x1GYEj/V+iFapis9+U0j5L90poPGMG3zDcgRww=;
        b=WY3isE3+f+Hi2RFPCYar4goNkaEkt9kevXyfEr9NErb2koz9SrTcF3h9b2+075ypav
         1Kf7c1CzPXxeXkcvZBq9xpKnSpSfeRxAtOOa9rTrtHPoIFR7qFrVjSrJ4lzjW6vufX11
         oKAeHkhKQaQZpfczqR59QQ8YHwdT6M/EMBwHPDWAg28jp2opngJDdPyg8Daqip12hLFB
         BIIqGSPBAtEnUdLbsFVad/ZiT+Jl91YnSEV1xfFyY+VcgwQYmxaChRrT1Rn9s9CqC8r9
         aBfnEr+LTdJH0FStdnleRBVDSKoTY6OMnmTAkkd3zxzy4+KsygrP9tTJ1TTizdsBqh/5
         UeQQ==
X-Gm-Message-State: AO0yUKXZ62I2PwcwHYd2eygSPSVykQuu8Ty7uPiVZAnzRqeLaVsV1S9S
        IGN6Pvp/CyTg6uKnJZKIqneVr3fKYjTibhynZ+sGv/0LJCqKLI32tbpQdFtwxIyyAtMtJCfrY/y
        ysuPMe7udP9JE0vLMv2M83UcsjDJFUqebKB3JTWl0
X-Received: by 2002:a81:af52:0:b0:52e:b48f:7349 with SMTP id x18-20020a81af52000000b0052eb48f7349mr9533930ywj.6.1678200112113;
        Tue, 07 Mar 2023 06:41:52 -0800 (PST)
X-Google-Smtp-Source: AK7set9ixXAAHHo/8o29LDnmEb5f6L2XNGBVYyCaZKFPomMROpar6Cg07AkJfPb1iOUBXcvRdnJgpJfRxV1yopb92kE=
X-Received: by 2002:a81:af52:0:b0:52e:b48f:7349 with SMTP id
 x18-20020a81af52000000b0052eb48f7349mr9533913ywj.6.1678200111807; Tue, 07 Mar
 2023 06:41:51 -0800 (PST)
MIME-Version: 1.0
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Tue, 7 Mar 2023 15:41:15 +0100
Message-ID: <CAJaqyWdSRksBh0PX-6Hz6Qy4EZ48zLYh79+_hROQn-7oo_fsww@mail.gmail.com>
Subject: Emulated CVQ in vdpa-net framework
To:     Stefano Garzarella <sgarzare@redhat.com>,
        Shannon Nelson <snelson@pensando.io>,
        Gautam Dawar <gdawar@xilinx.com>,
        Laurent Vivier <lvivier@redhat.com>,
        Alvaro Karsz <alvaro.karsz@solid-run.com>,
        Longpeng <longpeng2@huawei.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Cindy Lu <lulu@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Liuxiangdong <liuxiangdong5@huawei.com>,
        Parav Pandit <parav@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        Harpreet Singh Anand <hanand@xilinx.com>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

tl;dr the emulated CVQ is duplicated across some vdpa-net devices (For
example, betwen vdpa-sim-net and mlx5). This emulated CVQ is useful to
the rest of the parent drivers because it helps them to offload the
process of the virtio CVQ commands and convert them to device-specific
messages in the driver.

To merge these implementations in a separated object will reduce the
duplication of the code and the maintenance costs of the parent
drivers.
---

I'd distribute the work in two phases. The first one consists of
adding a specialized vringh module to make CVQ tasks. Let's call it
net_ctrl_vringh provisionally. I'll use the mlx5 vdpa driver as an
example, although there is no need to actually modify mlx5_vdpa in
this first stage.

This first step would simply merge vdpasim_handle_cvq and
mlx5_cvq_kick_handler to abstract the CVQ message handling. The parent
driver is still in charge of receiving the kick and forwarding it to
net_ctrl_vringh. We should be able to replace all vringh referenced
code for this new net_ctrl_vringh in the mlx5 driver

Since control messages actually need to handle each message
differently, the vendor driver must supply a struct of pointers in the
line of:
net_ctrl_vringh_ops = {
  .mac_table_set = ...
  .mac_addr_set = ...
  .vlan_add = ...
  .vlan_del = ...
  ...
}
---

So cmd handling and validation is shared between all parent drivers.
Let's say the net_ctrl_vringh callback to fetch a control message is
net_ctrl_vringh_handle_cvq(net_ctrl_vringh *v, ...). We can choose
between passing this struct as a parameter or to embed it in
net_ctrl_vringh. I prefer to use parameters.

This is already a big win as we offload vendors drivers to have to
worry about vringh nuances.

Second phase is to actually move it to the vdpa frontend. This step is
less defined at this moment, but it should be also doable with little
effort.

My main goal with this is to offload vendors from having to worry of
DMA and ASID nuances if they don't need to. These simple parent
drivers do not need to contain a single line about ASID, DMA, etc: All
of that is handled by vdpa frontend.

There are many possibilities to do it. One of them is to include some
property on vdpa_device like "emulated_virtqueues" or similar. Another
could be to create vdpa_net_device, which uses vdpa_device internally.
Although I think the second is simpler, it would be great if we can
abstract emulated virtqueues somehow.

For simplicity, I'm going to assume we create a new vdpa_net_device.
It will be in the line of:
struct vdpa_net_device {
  struct vdpa_device v;
  struct vringh ctrl_vq;
  const struct vdpa_config_ops *parent_ops;
  const struct
  ...
}
---

And it creates / register itself like a regular vdpa device, but
wrapping vendor's properties and callbacks to accommodate this new
CVQ. So we can do what Jason proposes in [1] vdpa-wise, not
vendor-wise. If the vdpa_device has an emulated CVQ, we can do:

int vhost_vdpa_net_set_vq_address(vdev, idx, areas...) {
  if (!is_ctrl_vq_idx(vdev, idx)) {
    return parent_ops->set_vq_address(vdev, idx, areas);
  }

  vdev->ctrl_vq.desc_addr = ...
  ...
}

struct vdpa_net_ops = {
  .set_vq_address = vhost_vdpa_net_set_vq_address
  ...
}

struct vdpa_net_device *vdpa_net_alloc_device(struct device *parent,
ngroups, nas, ...) {
  nas++; // emulated CVQ can always be in another AS
  ngroups++ // emulated CVQ will always be in an independent group
  ...
  vdpa_alloc_device(vdev, parent, vdpa_net_ops, ngroups, nas, ...
}
---

So the simple HW that does not care about DMA, ASID, etc does not need
to include a single line about these aspects. I think this can be done
incrementally too.

Thoughts?

Thanks!

[1] https://lore.kernel.org/virtualization/20230119061525.75068-6-jasowang@redhat.com/

