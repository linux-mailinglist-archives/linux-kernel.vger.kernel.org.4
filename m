Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711AE627718
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbiKNIIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbiKNIIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:08:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC9C193F9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668413240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TVnIeQwtdstHSZF4xEUKJ/5PTA6Y2F9kx5jkqLUsp8M=;
        b=TYISPv/u2Odp0rb9U4/B+anslTLSwqiARVyRazjePz+k3GFDNo29hBewFZAOFMbu3a7kk3
        Z8zcouiowoFqGDX1grKBJEug/z/TDWBkqv1RqmH5mQTeus/nIFIAJEs8nau7nPTszSneED
        c3lYkAuT+gwmXwGxwhw8ZLJkS6++ykc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-407-rZ0oYTOjOeqgmzKR3Q0Pyg-1; Mon, 14 Nov 2022 03:07:19 -0500
X-MC-Unique: rZ0oYTOjOeqgmzKR3Q0Pyg-1
Received: by mail-qk1-f198.google.com with SMTP id v7-20020a05620a0f0700b006faffce43b2so10375094qkl.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:07:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVnIeQwtdstHSZF4xEUKJ/5PTA6Y2F9kx5jkqLUsp8M=;
        b=fvGpBFpkzY+yt2gtHV2lsPKUOQ9UhnNR+p8/LIOz6innelvl1o/CYtjkx6J663pReQ
         zgiHgvM9K57pYn7zAaRLT/v19uwGWSkyMLfQX4gjhEXOUiqAjNz4c9ckkXESFJr2dDVw
         1R0h67yBV+cmhSiOlr7/9KsgL4wUQhuCRGGLj6g/MVjlESXnYkGbkigEbgotTKOZvIGY
         M5qlriITnI0u9OWVlko7zmhUhRjwc8+v6z6rStDyrJxiBUpzCgiZXTIMyQvUvTP57C65
         4bUQxOeADPyp6eahHTHJ0edc2PXVrVzLhdn9ZMENuaa5hbY8IXlomp0qlWne53g8McKn
         Jhuw==
X-Gm-Message-State: ANoB5pk8gz2nqCREXKVY//lso9f8Ya/I/XXqUyCVmjes6BA8Q1e1fwqe
        mO3u9Hn3hIQyxZ2YFGtlE9WrOMjs+SVewiUjtZMt0FCAhjDnsBxmSgN2ET3R4c4AVxAajGswNIk
        Aqm+Qc/JbWDAyfgfnXkOeHnx8
X-Received: by 2002:a05:6214:3c89:b0:4bb:8572:999f with SMTP id ok9-20020a0562143c8900b004bb8572999fmr11321777qvb.6.1668413238573;
        Mon, 14 Nov 2022 00:07:18 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4pm2rdiv95qqEXqf4i9Btz1mfW4FcVF1GpGUkqUaJB6DHaE7Ol2z1XRIaI+UYmqbJVmvEtSw==
X-Received: by 2002:a05:6214:3c89:b0:4bb:8572:999f with SMTP id ok9-20020a0562143c8900b004bb8572999fmr11321764qvb.6.1668413238353;
        Mon, 14 Nov 2022 00:07:18 -0800 (PST)
Received: from redhat.com ([37.19.196.93])
        by smtp.gmail.com with ESMTPSA id bk40-20020a05620a1a2800b006fa4b111c76sm6058153qkb.36.2022.11.14.00.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 00:07:17 -0800 (PST)
Date:   Mon, 14 Nov 2022 03:07:12 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lulu@redhat.com" <lulu@redhat.com>
Subject: Re: [PATCH 1/7] vdpa/mlx5: Fix rule forwarding VLAN to TIR
Message-ID: <20221114030644-mutt-send-email-mst@kernel.org>
References: <20221113134442.152695-1-elic@nvidia.com>
 <20221113134442.152695-2-elic@nvidia.com>
 <CACGkMEssbrOaYJDrHb1e_brjteKk4Xfw+sVogeiRbYE0RiMgRA@mail.gmail.com>
 <DM8PR12MB54006C35F5CDB250CA757108AB059@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR12MB54006C35F5CDB250CA757108AB059@DM8PR12MB5400.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 06:44:30AM +0000, Eli Cohen wrote:
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Monday, 14 November 2022 6:39
> > To: Eli Cohen <elic@nvidia.com>
> > Cc: mst@redhat.com; linux-kernel@vger.kernel.org; virtualization@lists.linux-
> > foundation.org; si-wei.liu@oracle.com; eperezma@redhat.com;
> > lulu@redhat.com
> > Subject: Re: [PATCH 1/7] vdpa/mlx5: Fix rule forwarding VLAN to TIR
> > 
> > On Sun, Nov 13, 2022 at 9:45 PM Eli Cohen <elic@nvidia.com> wrote:
> > >
> > > Set the VLAN id to the header values field instead of overwriting the
> > > headers criteria field.
> > >
> > > Before this fix, VLAN filtering would not really work and tagged packets
> > > would be forwarded unfiltered to the TIR.
> > >
> > > In addition modify the logic so that VLAN filtering is enforced only
> > > when VIRTIO_NET_F_CTRL_VLAN is negotiated. When not negotiated, all
> > > incoming traffic is accepted as long as it is targeting the net device's
> > > MAC address.
> > >
> > > Fixes: baf2ad3f6a98 ("vdpa/mlx5: Add RX MAC VLAN filter support")
> > >
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > ---
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 11 ++++++++---
> > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index 90913365def4..ea95081eca0c 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -1468,11 +1468,13 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct
> > mlx5_vdpa_net *ndev, u8 *mac,
> > >         dmac_v = MLX5_ADDR_OF(fte_match_param, headers_v,
> > outer_headers.dmac_47_16);
> > >         eth_broadcast_addr(dmac_c);
> > >         ether_addr_copy(dmac_v, mac);
> > > -       MLX5_SET(fte_match_set_lyr_2_4, headers_c, cvlan_tag, 1);
> > > +       if (ndev->mvdev.actual_features & VIRTIO_NET_F_CTRL_VLAN) {
> > > +               MLX5_SET(fte_match_set_lyr_2_4, headers_c, cvlan_tag, 1);
> > > +               MLX5_SET_TO_ONES(fte_match_set_lyr_2_4, headers_c, first_vid);
> > > +       }
> > >         if (tagged) {
> > >                 MLX5_SET(fte_match_set_lyr_2_4, headers_v, cvlan_tag, 1);
> > > -               MLX5_SET_TO_ONES(fte_match_set_lyr_2_4, headers_c, first_vid);
> > > -               MLX5_SET(fte_match_set_lyr_2_4, headers_c, first_vid, vid);
> > > +               MLX5_SET(fte_match_set_lyr_2_4, headers_v, first_vid, vid);
> > >         }
> > >         flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
> > >         dest.type = MLX5_FLOW_DESTINATION_TYPE_TIR;
> > > @@ -1821,6 +1823,9 @@ static virtio_net_ctrl_ack handle_ctrl_vlan(struct
> > mlx5_vdpa_dev *mvdev, u8 cmd)
> > >         size_t read;
> > >         u16 id;
> > >
> > > +       if (!(ndev->mvdev.actual_features &
> > BIT_ULL(VIRTIO_NET_F_CTRL_VLAN)))
> > > +               return status;
> > 
> > Nit: this seems unrelated to the patch.
> > 
> Will put in another patch


OK since you are doing a new version, please split fixes and
features in two patchsets. Thanks!

> > Other than this.
> > 
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > 
> > > +
> > >         switch (cmd) {
> > >         case VIRTIO_NET_CTRL_VLAN_ADD:
> > >                 read = vringh_iov_pull_iotlb(&cvq->vring, &cvq->riov, &vlan,
> > sizeof(vlan));
> > > --
> > > 2.38.1
> > >
> 

