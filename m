Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01550626FED
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 14:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbiKMNwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 08:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbiKMNwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 08:52:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCB711C3F
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 05:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668347496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K2EsNeyXyYyKVLHR+aWkmyeBAXArz2HHJA7VFNui1Vw=;
        b=P5vuobHB2EfVb6VIpNZAklESOTg5fhiBVCJBV7Ij9PskYqjhP2FtBGUoRceNtiQXoLgk5Y
        r/Shg0cg4ob/xV6xYNyC5UT1oShFl2oxGwl3Lydak5jZ+pVC1PZc60XqRgcoY3FgkwyxFW
        yQAe5gdLSq/FuPqbAUKHdZXPf255EOw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-175-ncOufMUsOomdmoOhg_hIVw-1; Sun, 13 Nov 2022 08:51:35 -0500
X-MC-Unique: ncOufMUsOomdmoOhg_hIVw-1
Received: by mail-wm1-f70.google.com with SMTP id l42-20020a05600c1d2a00b003cf8e70c1ecso7479264wms.4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 05:51:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2EsNeyXyYyKVLHR+aWkmyeBAXArz2HHJA7VFNui1Vw=;
        b=DGvwybxCzybh9BdbEv9oPWTR50U4sWprYoCjvagUP/LmUyhMy4KS4dyKdR71J9dWJY
         yrf3aYODEcW/SUVl2VyIz5CSv42Y/YBS0gmbBq+1d4EckpNDwMkqLmzhMAa3Rp2m87Xh
         PoJRvydZ3D+3SSR7+p/NpsFvXCMfgp4b4AEW1h0J8vsqt4lLXKF7aG5uRjDodpdzOuUu
         QzeKkKP/GrX0tPJjjvELqOqxmXAJYfw4fleQik2sUMHYef3BkmZPAfFKIFAb+VVZtBkN
         kXigFXWEeeP77oFwAWVhugqF0FQUvPbBYF4Ny9lKevM1rIIDQJI/CbpVKvoHmgyQw/V9
         GDBw==
X-Gm-Message-State: ANoB5pmmNpdKkvxoZoQs+6yBeQmByk9Gw69hfvETKaV32wS4kRbpny3f
        bR2C+REG88fCzZm80aeqh8Yk+WK5YMkBojMBq093b7zxcGvCqtVnzvDCS5AX7b4RM8SvWFK80V7
        hLfXY2x0tYXuHZjg7xLD9b+wQ
X-Received: by 2002:adf:f502:0:b0:238:c1d5:3293 with SMTP id q2-20020adff502000000b00238c1d53293mr5206671wro.446.1668347493912;
        Sun, 13 Nov 2022 05:51:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4wod2BYxiettS1eLmQzICjf4VHtw9Y5QjE6qq4HdDPw+URGaNVqNF3AD3g0sPJxpVkObInww==
X-Received: by 2002:adf:f502:0:b0:238:c1d5:3293 with SMTP id q2-20020adff502000000b00238c1d53293mr5206663wro.446.1668347493650;
        Sun, 13 Nov 2022 05:51:33 -0800 (PST)
Received: from redhat.com ([2.52.4.127])
        by smtp.gmail.com with ESMTPSA id m66-20020a1c2645000000b003cfd58409desm5641085wmm.13.2022.11.13.05.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 05:51:33 -0800 (PST)
Date:   Sun, 13 Nov 2022 08:51:30 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     jasowang@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, si-wei.liu@oracle.com,
        eperezma@redhat.com, lulu@redhat.com
Subject: Re: [PATCH 0/7] vdpa/mlx5: Add debugfs subtree and fixes
Message-ID: <20221113085044-mutt-send-email-mst@kernel.org>
References: <20221113134442.152695-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221113134442.152695-1-elic@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2022 at 03:44:35PM +0200, Eli Cohen wrote:
> This series is a resend of previously sent patch list. It adds a few
> fixes so I treat as a v0 of a new series.
> 
> It adds a kernel config param CONFIG_MLX5_VDPA_STEERING_DEBUG that when
> eabled allows to read rx unicast and multicast counters per tagged or untagged traffic.
> 
> Examples:
> $ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/untagged/mcast/packets
> $ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/untagged/ucast/bytes


Thanks!
Is this patchset intended for 6.2 then?

> 
> Eli Cohen (7):
>   vdpa/mlx5: Fix rule forwarding VLAN to TIR
>   vdpa/mlx5: Fix wrong mac address deletion
>   vdpa/mlx5: Move some definitions to a new header file
>   vdpa/mlx5: Add debugfs subtree
>   vdpa/mlx5: Add RX counters to debugfs
>   vdpa/mlx5: Avoid using reslock in event_handler
>   vdpa/mlx5: Avoid overwriting CVQ iotlb
> 
>  drivers/vdpa/Kconfig               |  12 ++
>  drivers/vdpa/mlx5/Makefile         |   2 +-
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h |   5 +-
>  drivers/vdpa/mlx5/core/mr.c        |  44 ++---
>  drivers/vdpa/mlx5/net/debug.c      | 152 ++++++++++++++++++
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 248 ++++++++++++++---------------
>  drivers/vdpa/mlx5/net/mlx5_vnet.h  |  94 +++++++++++
>  7 files changed, 411 insertions(+), 146 deletions(-)
>  create mode 100644 drivers/vdpa/mlx5/net/debug.c
>  create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.h
> 
> -- 
> 2.38.1

