Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9A864B845
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbiLMPUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236093AbiLMPUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:20:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A0421E24
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670944759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P0CSk5cc8z+MIxtfJaqK2iC+ecrtBBfDO+a5TkKb2FU=;
        b=XhaOxNIKEIq4IzMHiJ1YAbk/9SkoS76rtnObI36+CDyrBcbMBx/2i4h/SGGCzk38yEqkz4
        lonXM93bE+hEWkDJers7q8GJ/9qAYgKQdFWTWKnbbgjzhGFiElgS3asd6FvgL4zdmE0Ned
        OhMrzmuQiRyzUUwhoPWE6DZDhCrHrGU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-323-1G5IhelTPYimS10JXbgMHg-1; Tue, 13 Dec 2022 10:19:17 -0500
X-MC-Unique: 1G5IhelTPYimS10JXbgMHg-1
Received: by mail-wr1-f71.google.com with SMTP id t12-20020adfa2cc000000b0022adcbb248bso2914114wra.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:19:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0CSk5cc8z+MIxtfJaqK2iC+ecrtBBfDO+a5TkKb2FU=;
        b=byuno+bQfa5UdQjL1ESJcCvfsptsqJk7i6xknSXHelmVjhpi1oZWAW1LQd9M7NfMHP
         7bOnPFHLYvw+6bFjHsoy1AREoS8nSM1BIM9SsRT0FrovYIKbGUleQn1BUOpZ+WKEfNIp
         i8GHg1SBkZdU+qrm7zhQ+8adgCJfN4aTWxSP7vofgH5EpYuJ7IVCleqp5ONMnatBqoXv
         1Lselh4oePlm8xBRRIMf/oREI3duayvLeT1nJMZGcc5nAlH7FqMv/7XpQHDIuWwnL3hj
         0sXUxc2mhBfWcig9wFMQY6EvfoMFJdUrfyflmQGNxy1zyRPZyCOkmUaf0qydF6EdLx3v
         ft6A==
X-Gm-Message-State: ANoB5pmU7Gs0kIUsHet1kwSjAAEj5JTyKbcn5c0DBX61jy+al35+fZGO
        3Pw5iAb95ZrXYx5mcFOTi+9kgYDC4IcOn5wTUJInGlyS7iz0sZBMLwBDRIjhHd9RF5zppeROf6m
        PbUteLKvxsb8sg+LBisYyW5fD
X-Received: by 2002:a05:6000:883:b0:241:94bc:26d3 with SMTP id ca3-20020a056000088300b0024194bc26d3mr12880755wrb.49.1670944756427;
        Tue, 13 Dec 2022 07:19:16 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6seChERFleznECQpOM83h6tXK8y66oPcOVYUArJEX37U9aakvW3lDwTiQIG+CeJ4MrHBQTcw==
X-Received: by 2002:a05:6000:883:b0:241:94bc:26d3 with SMTP id ca3-20020a056000088300b0024194bc26d3mr12880749wrb.49.1670944756196;
        Tue, 13 Dec 2022 07:19:16 -0800 (PST)
Received: from redhat.com ([2.52.138.183])
        by smtp.gmail.com with ESMTPSA id t15-20020adff60f000000b00241c4bd6c09sm68907wrp.33.2022.12.13.07.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 07:19:15 -0800 (PST)
Date:   Tue, 13 Dec 2022 10:19:12 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lulu@redhat.com" <lulu@redhat.com>
Subject: Re: [PATH v2 0/8] vdpa/mlx5: Add debugfs subtree and fixes
Message-ID: <20221213101853-mutt-send-email-mst@kernel.org>
References: <20221114131759.57883-1-elic@nvidia.com>
 <DM8PR12MB540016371DAF2915B3277949AB0F9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <DM8PR12MB540004BAE87EF27CFC6B1C69ABE39@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR12MB540004BAE87EF27CFC6B1C69ABE39@DM8PR12MB5400.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes it's all going into the next pull, thanks!

On Tue, Dec 13, 2022 at 07:33:08AM +0000, Eli Cohen wrote:
> Michael?
> 
> > -----Original Message-----
> > From: Eli Cohen
> > Sent: Thursday, 24 November 2022 8:34
> > To: mst@redhat.com; jasowang@redhat.com; linux-kernel@vger.kernel.org;
> > virtualization@lists.linux-foundation.org
> > Cc: si-wei.liu@oracle.com; eperezma@redhat.com; lulu@redhat.com
> > Subject: RE: [PATH v2 0/8] vdpa/mlx5: Add debugfs subtree and fixes
> > 
> > Hi Michael,
> > 
> > Are you going to pull this series? It has been reviewed.
> > 
> > 
> > > -----Original Message-----
> > > From: Eli Cohen <elic@nvidia.com>
> > > Sent: Monday, 14 November 2022 15:18
> > > To: mst@redhat.com; jasowang@redhat.com; linux-
> > kernel@vger.kernel.org;
> > > virtualization@lists.linux-foundation.org
> > > Cc: si-wei.liu@oracle.com; eperezma@redhat.com; lulu@redhat.com; Eli
> > > Cohen <elic@nvidia.com>
> > > Subject: [PATH v2 0/8] vdpa/mlx5: Add debugfs subtree and fixes
> > >
> > > This series is a resend of previously sent patch list. It adds a few
> > > fixes so I treat as a v0 of a new series.
> > >
> > > It adds a kernel config param CONFIG_MLX5_VDPA_STEERING_DEBUG
> > that
> > > when
> > > eabled allows to read rx unicast and multicast counters per tagged or
> > untagged
> > > traffic.
> > >
> > > Examples:
> > > $ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-
> > > 0/rx/untagged/mcast/packets
> > > $ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-
> > 0/rx/untagged/ucast/bytes
> > >
> > > v1->v2:
> > > 1. Reorder patches so fixes are first
> > > 2. Break "Fix rule forwarding VLAN to TIR" into two patches
> > > 3. Squash fix for bug in first patch from "Add RX counters to debugfs"
> > > 4. Move clearing of nb_registered before calling mlx5_notifier_unregister()
> > in
> > > mlx5_vdpa_dev_del()
> > >
> > >
> > > Eli Cohen (8):
> > >   vdpa/mlx5: Fix rule forwarding VLAN to TIR
> > >   vdpa/mlx5: Return error on vlan ctrl commands if not supported
> > >   vdpa/mlx5: Fix wrong mac address deletion
> > >   vdpa/mlx5: Avoid using reslock in event_handler
> > >   vdpa/mlx5: Avoid overwriting CVQ iotlb
> > >   vdpa/mlx5: Move some definitions to a new header file
> > >   vdpa/mlx5: Add debugfs subtree
> > >   vdpa/mlx5: Add RX counters to debugfs
> > >
> > >  drivers/vdpa/Kconfig               |  12 ++
> > >  drivers/vdpa/mlx5/Makefile         |   2 +-
> > >  drivers/vdpa/mlx5/core/mlx5_vdpa.h |   5 +-
> > >  drivers/vdpa/mlx5/core/mr.c        |  44 ++---
> > >  drivers/vdpa/mlx5/net/debug.c      | 152 ++++++++++++++++++
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 250 ++++++++++++++---------------
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.h  |  94 +++++++++++
> > >  7 files changed, 412 insertions(+), 147 deletions(-)
> > >  create mode 100644 drivers/vdpa/mlx5/net/debug.c
> > >  create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.h
> > >
> > > --
> > > 2.38.1
> 

