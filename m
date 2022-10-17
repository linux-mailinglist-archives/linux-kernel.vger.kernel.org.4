Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7141360074D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiJQHIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJQHIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:08:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526FD222B1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665990513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9usayBzkIcBIJW6WysoHYem7xlHhVzBoZ4SlpZHoo4A=;
        b=Go1D+lqZVbAgDdgIUZlzl225sPs/fBAG69n02p+TwVS5+2213FabiQSumffic8NsfuYmBu
        Vg6582j9a2CyS+anto2AORnpY9sclW6I0ANY8bziHiCA5kFeckQfl0iYV8ZTeHPv/ZmCFC
        NYp6at1/GmVVte8VX9DKSnZHBhd2QpY=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-288-9N3sY7MKNWudKcI5Mxm6TA-1; Mon, 17 Oct 2022 03:08:32 -0400
X-MC-Unique: 9N3sY7MKNWudKcI5Mxm6TA-1
Received: by mail-oo1-f69.google.com with SMTP id f26-20020a4a9d5a000000b0044e0692f7d0so4371777ook.19
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9usayBzkIcBIJW6WysoHYem7xlHhVzBoZ4SlpZHoo4A=;
        b=yLpraIaKlWmBIFFHCfW5cRbahj+pS9RbyUoFb31e4YQUdKxiqGBSTq4iADpphTFmMM
         bbZnPCd3XNyv+U6nBX2F85765OMB4K39gYwSPp8LFpblZxYiQkSR+bOwUxbmkNgKDGaV
         yDWN8NDbLrJJey0OF1X5CGAfhHCDMc2BLu/FdjIpiV7hLwf+Ucg7Jr+qcv2bhhT18OJk
         zfjIFGDYybmf2W/A4rIfMv7uNOsF+objfARAZTOWB5NJO8aUTPZY8Y7DZMmpE9wjIQXi
         GU9yun5D53n6m1dyYP0D2pU2QJJsHte6uNq1xPcx8euVTNLR/9A/+GyKW9dI7EOQbB5H
         w99Q==
X-Gm-Message-State: ACrzQf2vbT3WZT3hogeTony/zb5N5KgIi9DqzN4qtjNHNixNUXk/sW0i
        JrF6UbBC7OoIoriRSWGl5GoMoT06p0OPNsR6Mph48Sui9JhhQgjCCQ8eKU8S9Md83QRwL06ju/R
        y5nVrmEIUwD9M5KmVIodg5/s/W55/OcUZbFPqj1qK
X-Received: by 2002:a9d:7dcf:0:b0:661:dc25:ba0 with SMTP id k15-20020a9d7dcf000000b00661dc250ba0mr4354071otn.201.1665990511560;
        Mon, 17 Oct 2022 00:08:31 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7waEHbw1nll8KdB1C4R8PTMAQG1p6WJ5GlAY6zu0wGd9AgaUqPoF5K8EbsNvAlZhX7DHOjTO4jupaDYWXW7W4=
X-Received: by 2002:a9d:7dcf:0:b0:661:dc25:ba0 with SMTP id
 k15-20020a9d7dcf000000b00661dc250ba0mr4354061otn.201.1665990511336; Mon, 17
 Oct 2022 00:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <1665793690-28120-1-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1665793690-28120-1-git-send-email-si-wei.liu@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 17 Oct 2022 15:08:19 +0800
Message-ID: <CACGkMEvaKnqS-0p7iqyHP_Wbbj1YdmPFA7ABfKK_8FbXMsZEkg@mail.gmail.com>
Subject: Re: [PATCH 0/4] vDPA: dev config export via "vdpa dev show" command
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Sean Mooney <smooney@redhat.com>,
        Daniel Berrange <berrange@redhat.com>
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

Adding Sean and Daniel for more thoughts.

On Sat, Oct 15, 2022 at 9:33 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
> Live migration of vdpa would typically require re-instate vdpa
> device with an idential set of configs on the destination node,
> same way as how source node created the device in the first place.
>
> In order to allow live migration orchestration software to export the
> initial set of vdpa attributes with which the device was created, it
> will be useful if the vdpa tool can report the config on demand with
> simple query.

For live migration, I think the management layer should have this
knowledge and they can communicate directly without bothering the vdpa
tool on the source. If I was not wrong this is the way libvirt is
doing now.

> This will ease the orchestration software implementation
> so that it doesn't have to keep track of vdpa config change, or have
> to persist vdpa attributes across failure and recovery, in fear of
> being killed due to accidental software error.
>
> In this series, the initial device config for vdpa creation will be
> exported via the "vdpa dev show" command.
> This is unlike the "vdpa
> dev config show" command that usually goes with the live value in
> the device config space, which is not reliable subject to the dynamics
> of feature negotiation and possible change in device config space.
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
>   mac e4:11:c6:d3:45:f0 max_vq_pairs 4
> $ vdpa dev -jp show
> {
>     "dev": {
>         "vdpa0": {
>             "type": "network",
>             "mgmtdev": "pci/0000:41:04.2",

So "mgmtdev" looks not necessary for live migration.

Thanks

>             "vendor_id": 5555,
>             "max_vqs": 9,
>             "max_vq_size": 256,
>             "mac": "e4:11:c6:d3:45:f0",
>             "max_vq_pairs": 4
>         }
>     }
> }
>
> ---
>
> Si-Wei Liu (4):
>   vdpa: save vdpa_dev_set_config in struct vdpa_device
>   vdpa: pass initial config to _vdpa_register_device()
>   vdpa: show dev config as-is in "vdpa dev show" output
>   vdpa: fix improper error message when adding vdpa dev
>
>  drivers/vdpa/ifcvf/ifcvf_main.c      |  2 +-
>  drivers/vdpa/mlx5/net/mlx5_vnet.c    |  2 +-
>  drivers/vdpa/vdpa.c                  | 63 +++++++++++++++++++++++++++++++++---
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  2 +-
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  2 +-
>  drivers/vdpa/vdpa_user/vduse_dev.c   |  2 +-
>  drivers/vdpa/virtio_pci/vp_vdpa.c    |  3 +-
>  include/linux/vdpa.h                 | 26 ++++++++-------
>  8 files changed, 80 insertions(+), 22 deletions(-)
>
> --
> 1.8.3.1
>

