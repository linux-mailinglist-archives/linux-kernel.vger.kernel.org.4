Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534AC62755A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 05:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbiKNEkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 23:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235820AbiKNEkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 23:40:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23160E083
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 20:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668400752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2P5JLtakyBrCkExNJO7eBOS82+EuGUA4zafN/5TFNYg=;
        b=gW+Sqi6t0uJK+FExoS7yXwJeTUYgWvQjEky8qvj9l/RyaKGmezqHTtanQsD6ersCcIfgUU
        +3TsH1ORtRgP4XXZK9b2ivsI9GLYKZ6BUIsubojx+Ci2eq+C52uca2GoSQSaJg4fRToHOg
        xyAKcRt8P/QBeVKdLSSMKN2EHyapVjI=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-550-KUg-C0J8P9u5JSGgKq-pNA-1; Sun, 13 Nov 2022 23:39:07 -0500
X-MC-Unique: KUg-C0J8P9u5JSGgKq-pNA-1
Received: by mail-oo1-f70.google.com with SMTP id w18-20020a4a6d52000000b0049f209d84bbso3339078oof.7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 20:39:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2P5JLtakyBrCkExNJO7eBOS82+EuGUA4zafN/5TFNYg=;
        b=j6UbEsdwD6mMivzy2QV7MAfUKAummX/zYKQApGLJO6oowkXWrITs+OrUjorq+zK+v8
         P9zzoTKHqnLjLeRfXvFM1xRmxNBd8RLbB44YNw/H7jRE+K0yDLg4zeZ9n9zV6z9i+oHx
         uH4wCfD1AT/vs9Z7u+evBvYNi9oharHXZ3x+29PuXU6aIoNHon4tFfMNy/eyBMT6P6aq
         /fZ8Q4GraUeGN9FDQej5zU68Ia+P3wxXeh2vEfLL2ZzQug1H3NCYvaGyQMgXVJc8xKr+
         E/PKt7lqv3OqNT0nBnWUlxI8ZcKdyYrVvqt7PS+l7ElL57BVotd6WBQwnNER1SLrwwAJ
         h1cA==
X-Gm-Message-State: ANoB5pnojlqTTiWH2dryKnYPy3SKzge9OzqEmqroi5BBE2hIWeKZ483x
        6bOF1kIiBr5WpcLV3LuQsP5/h+OO326FM9J51yovAstF1dSPENveKuK2CCUVOVTurVW5OEQmOpa
        Y9oEOM3knCW6Qa0AFfLl6u7vik9DlKHrsHLoopFor
X-Received: by 2002:a05:6808:22a1:b0:359:f5eb:82ec with SMTP id bo33-20020a05680822a100b00359f5eb82ecmr4892972oib.280.1668400746095;
        Sun, 13 Nov 2022 20:39:06 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7fJUsmjqI+Jmj9tM/5tR+JUN3DdIOrpKo3YC1vWG9405AVoIjCJXIogxKiZwKraUv6o3fb/hS8tFzrq2UyCr4=
X-Received: by 2002:a05:6808:22a1:b0:359:f5eb:82ec with SMTP id
 bo33-20020a05680822a100b00359f5eb82ecmr4892963oib.280.1668400745912; Sun, 13
 Nov 2022 20:39:05 -0800 (PST)
MIME-Version: 1.0
References: <20221113134442.152695-1-elic@nvidia.com> <20221113134442.152695-2-elic@nvidia.com>
In-Reply-To: <20221113134442.152695-2-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 14 Nov 2022 12:38:54 +0800
Message-ID: <CACGkMEssbrOaYJDrHb1e_brjteKk4Xfw+sVogeiRbYE0RiMgRA@mail.gmail.com>
Subject: Re: [PATCH 1/7] vdpa/mlx5: Fix rule forwarding VLAN to TIR
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
> Set the VLAN id to the header values field instead of overwriting the
> headers criteria field.
>
> Before this fix, VLAN filtering would not really work and tagged packets
> would be forwarded unfiltered to the TIR.
>
> In addition modify the logic so that VLAN filtering is enforced only
> when VIRTIO_NET_F_CTRL_VLAN is negotiated. When not negotiated, all
> incoming traffic is accepted as long as it is targeting the net device's
> MAC address.
>
> Fixes: baf2ad3f6a98 ("vdpa/mlx5: Add RX MAC VLAN filter support")
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 90913365def4..ea95081eca0c 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1468,11 +1468,13 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
>         dmac_v = MLX5_ADDR_OF(fte_match_param, headers_v, outer_headers.dmac_47_16);
>         eth_broadcast_addr(dmac_c);
>         ether_addr_copy(dmac_v, mac);
> -       MLX5_SET(fte_match_set_lyr_2_4, headers_c, cvlan_tag, 1);
> +       if (ndev->mvdev.actual_features & VIRTIO_NET_F_CTRL_VLAN) {
> +               MLX5_SET(fte_match_set_lyr_2_4, headers_c, cvlan_tag, 1);
> +               MLX5_SET_TO_ONES(fte_match_set_lyr_2_4, headers_c, first_vid);
> +       }
>         if (tagged) {
>                 MLX5_SET(fte_match_set_lyr_2_4, headers_v, cvlan_tag, 1);
> -               MLX5_SET_TO_ONES(fte_match_set_lyr_2_4, headers_c, first_vid);
> -               MLX5_SET(fte_match_set_lyr_2_4, headers_c, first_vid, vid);
> +               MLX5_SET(fte_match_set_lyr_2_4, headers_v, first_vid, vid);
>         }
>         flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
>         dest.type = MLX5_FLOW_DESTINATION_TYPE_TIR;
> @@ -1821,6 +1823,9 @@ static virtio_net_ctrl_ack handle_ctrl_vlan(struct mlx5_vdpa_dev *mvdev, u8 cmd)
>         size_t read;
>         u16 id;
>
> +       if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VLAN)))
> +               return status;

Nit: this seems unrelated to the patch.

Other than this.

Acked-by: Jason Wang <jasowang@redhat.com>

> +
>         switch (cmd) {
>         case VIRTIO_NET_CTRL_VLAN_ADD:
>                 read = vringh_iov_pull_iotlb(&cvq->vring, &cvq->riov, &vlan, sizeof(vlan));
> --
> 2.38.1
>

