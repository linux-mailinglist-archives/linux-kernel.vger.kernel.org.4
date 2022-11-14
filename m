Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC1562765A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbiKNH16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235415AbiKNH14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:27:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA17D2E0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668410825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MOMWpm5CCVU3kUo0zgauw8Rj2SwIfM2Q5f5rHRWKMIU=;
        b=CWGl6uHFiNxRdkLDyP6JSmvajOJZ1Qvv1WxJvg6hz56Z1j6+prTyWWFnQPxe40FXi1Wic8
        /dUXITDo7ZYYGFz8mXKrTUWN64SyetOseDVi+Twf6iUZKM9MMtAL2d6WWyUvrb41oaFAi+
        wJ8QR82hBbCtuseGjUJqZsxikVvG8nk=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-526-7EdMIGS8NdCdR-oShA_tUg-1; Mon, 14 Nov 2022 02:26:59 -0500
X-MC-Unique: 7EdMIGS8NdCdR-oShA_tUg-1
Received: by mail-oo1-f69.google.com with SMTP id g1-20020a4ad841000000b0049f25cf96afso3530190oov.20
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:26:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MOMWpm5CCVU3kUo0zgauw8Rj2SwIfM2Q5f5rHRWKMIU=;
        b=YkjPqdR3SEwULw93FMX7YmR4s7z3kT6wr+9Z4oWw0Pzop7JO26XS1wuMBmo2bM8XnR
         7jKEA6FJ28Blv2pm3Q2+nSbZe8Owy//x0idhimavg2X/AkNHI1uJrXu/EaZODBzoCb+0
         jsextBOfB1SGvnEqQHEC0QqX15RYUSduQBiStuFicGdPN6NggPdYVhSgSc4t/Jvhf+VZ
         jEgq5n5f399N8HJcQab6rc4dj3WMpivubKCBXh6gmz7uYWGZBjR1lpFJQu48kcSoxMBg
         D8B8f4UZUfQy/+yWKxUv/qRSGQH3oQg3Vrhi0sciXe4P5olqofGMikg9XFiKngtQX/nT
         vffQ==
X-Gm-Message-State: ANoB5plMJdWIsYxsu+Q8C6cfsaWo703/ENzM++t8D1WpWMF/X/iRbpGC
        CYMMqFjlEI9+t+QVluC9fdRAexgWKshPCx4difvtpSHgSpiyJEf9SfAAK3vq4FpvsD3NvXTBogw
        G9QJ1ZsHTNI5eCYkrAdxjYdJMELw+I5X4f4/ZyK+E
X-Received: by 2002:a54:4605:0:b0:354:68aa:9c59 with SMTP id p5-20020a544605000000b0035468aa9c59mr5184760oip.35.1668410818429;
        Sun, 13 Nov 2022 23:26:58 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5C84VexBmAOzE61dCyw9QsbIJnHVsDzgFJer5/jEMAQ8yPSAWkeqlIJU/M8//CIQ5zkOkg3LjzGkZPhWF85AM=
X-Received: by 2002:a54:4605:0:b0:354:68aa:9c59 with SMTP id
 p5-20020a544605000000b0035468aa9c59mr5184750oip.35.1668410818105; Sun, 13 Nov
 2022 23:26:58 -0800 (PST)
MIME-Version: 1.0
References: <20221113134442.152695-1-elic@nvidia.com> <20221113134442.152695-6-elic@nvidia.com>
In-Reply-To: <20221113134442.152695-6-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 14 Nov 2022 15:26:46 +0800
Message-ID: <CACGkMEs4YpUUtkW-rWkQpYQY4vFLh2YcwY6bSqUGTd60Xq37_w@mail.gmail.com>
Subject: Re: [PATCH 5/7] vdpa/mlx5: Add RX counters to debugfs
To:     Eli Cohen <elic@nvidia.com>
Cc:     mst@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, si-wei.liu@oracle.com,
        eperezma@redhat.com, lulu@redhat.com
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

On Sun, Nov 13, 2022 at 9:45 PM Eli Cohen <elic@nvidia.com> wrote:
>
> For each interface, either VLAN tagged or untagged, add two hardware
> counters: one for unicast and another for multicast. The counters count
> RX packets and bytes and can be read through debugfs:
>
> $ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/untagged/mcast/packets
> $ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/untagged/ucast/bytes
>
> This feature is controlled via the config option
> MLX5_VDPA_STEERING_DEBUG. It is off by default as it may have some
> impact on performance.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/vdpa/Kconfig              |  12 +++
>  drivers/vdpa/mlx5/net/debug.c     |  86 ++++++++++++++++++++++
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 118 +++++++++++++++++++++++-------
>  drivers/vdpa/mlx5/net/mlx5_vnet.h |  30 ++++++++
>  4 files changed, 218 insertions(+), 28 deletions(-)
>

[...]

> +       vid = key2vid(node->macvlan);
>         spec->match_criteria_enable = MLX5_MATCH_OUTER_HEADERS;
>         headers_c = MLX5_ADDR_OF(fte_match_param, spec->match_criteria, outer_headers);
>         headers_v = MLX5_ADDR_OF(fte_match_param, spec->match_value, outer_headers);
> @@ -1430,48 +1475,62 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
>         dmac_v = MLX5_ADDR_OF(fte_match_param, headers_v, outer_headers.dmac_47_16);
>         eth_broadcast_addr(dmac_c);
>         ether_addr_copy(dmac_v, mac);
> -       if (ndev->mvdev.actual_features & VIRTIO_NET_F_CTRL_VLAN) {
> +       if (ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VLAN)) {


This seems like a fix for patch 1? If yes, let's just squash this.

Thanks

