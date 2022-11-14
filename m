Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7848962755D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 05:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbiKNElZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 23:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbiKNElX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 23:41:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F82E083
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 20:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668400827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2AITeW9SUbg+X03mosFnSodKHnylEEh3d619uSKZzAg=;
        b=HSoLjxNHhOUYbZ4/IFdYpZotczvZ+c8Mz31Nm8Qts/cmgKlfmMccm/yVjryQNQEZPtlcxd
        fFc0349j6O/1DrfrH5m+8oCpEOyvaXDrZ9kqmHYXC/Jfy0kFABIRWlmKitw4zgHwF5eTk3
        AIWnd17pDRGUQEcX4Y6W16JC5mVWegU=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-333-elHG-UTIP0KyxNgVTZrncg-1; Sun, 13 Nov 2022 23:40:26 -0500
X-MC-Unique: elHG-UTIP0KyxNgVTZrncg-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-13af11be44dso4970791fac.21
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 20:40:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2AITeW9SUbg+X03mosFnSodKHnylEEh3d619uSKZzAg=;
        b=zFXsKYzFnNuHiD5NF9KH72uc1Wqzzlw+2tItz1gI59EIszm5J9Kkxc7QSeIXXNxHkh
         I2l9M0dxsSq3XATaGgwQbZ9gSKQYM5makmEXmKp8NQxof1ZCymzQUEVm+8i3gsmQ6yfB
         pmAOAgnZ3aK7GVzSiUVOWdjd/ECXDW5yrBhKr2W17iugkT3Xsb02fYSIPICYb1NB+wpI
         pkA85Y96aBMPX4sJ68bM1hjd2MBbEBF//MPmx691lSX9ejpYIXNIxzOUy5AmJtHl6vH4
         hoft17NGBqt/rUC49Cd8KirNxc3bwRZAImAmZVshmglW83qhi+OwhXecEsxz4t+loMN5
         vzZQ==
X-Gm-Message-State: ANoB5pnrLRErzCnI8axt1NR2h4+VapfonGdSoNZsFnsgGCQCTYBXJ+M/
        zYq6GRCCEvDjXbCcO2icyYFfCdQ4JS2wJNlwpY+ameM0Y8AStefCCVZy1puR63yqNpLRoThSGNk
        rfaGkGVHcfZ09o/TfQfEqixiOQ3DYBfpdktTUt5pz
X-Received: by 2002:a54:4605:0:b0:354:68aa:9c59 with SMTP id p5-20020a544605000000b0035468aa9c59mr5016273oip.35.1668400825293;
        Sun, 13 Nov 2022 20:40:25 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7o1mzaVUMbysjWFfjZ1n8y2KTX5oFhKdFGWORBEYdEwS80wGhVDcsEa8CrPxN+qWO8ycrR83QFKV94ZMdM620=
X-Received: by 2002:a54:4605:0:b0:354:68aa:9c59 with SMTP id
 p5-20020a544605000000b0035468aa9c59mr5016269oip.35.1668400825116; Sun, 13 Nov
 2022 20:40:25 -0800 (PST)
MIME-Version: 1.0
References: <20221113134442.152695-1-elic@nvidia.com> <20221113134442.152695-3-elic@nvidia.com>
In-Reply-To: <20221113134442.152695-3-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 14 Nov 2022 12:40:14 +0800
Message-ID: <CACGkMEuD0234xsjS2eOmJXvNup_VEN67NCxm-iR0vP6p-kbNKA@mail.gmail.com>
Subject: Re: [PATCH 2/7] vdpa/mlx5: Fix wrong mac address deletion
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
> Delete the old MAC from the table and not the new one which is not there
> yet.
>
> Fixes: baf2ad3f6a98 ("vdpa/mlx5: Add RX MAC VLAN filter support")
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index ea95081eca0c..c54d5088ed4f 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1686,7 +1686,7 @@ static virtio_net_ctrl_ack handle_ctrl_mac(struct mlx5_vdpa_dev *mvdev, u8 cmd)
>
>                 /* Need recreate the flow table entry, so that the packet could forward back
>                  */
> -               mac_vlan_del(ndev, ndev->config.mac, 0, false);
> +               mac_vlan_del(ndev, mac_back, 0, false);
>
>                 if (mac_vlan_add(ndev, ndev->config.mac, 0, false)) {
>                         mlx5_vdpa_warn(mvdev, "failed to insert forward rules, try to restore\n");
> --
> 2.38.1
>

