Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA08626FF5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 14:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbiKMN6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 08:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbiKMN6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 08:58:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A96DE8B
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 05:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668347874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sxn4y8zEogALzM6SceTBzYKfTeerKNoCiWqt/Q5KsoU=;
        b=b/snuWI+OPRuiVRu1oz5QL5cCz20os/AGJXp+U+ocRWXx9zqVHuaT2QQ1I5rRPlZiOP2yK
        Zxh8Eq6AOFmzt3NeafUIQSrRB5ncvZDcitAe7tllmJHy5D2H40MqJ9CtbA1lQ6LZRxJZJS
        DpYxBZW2WwfevdbRxtBuBqY3gzKEcsU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-201-KA7yHCbuO_eMC4jDN7FEjA-1; Sun, 13 Nov 2022 08:57:52 -0500
X-MC-Unique: KA7yHCbuO_eMC4jDN7FEjA-1
Received: by mail-wm1-f70.google.com with SMTP id 1-20020a05600c028100b003cf7833293cso7489378wmk.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 05:57:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sxn4y8zEogALzM6SceTBzYKfTeerKNoCiWqt/Q5KsoU=;
        b=VEVJv3piiwaPozpwd/JOSo/yd+W8Arfc5a8nMqdUKgOd+CGDQ/uE+ujSUPYl+YR9Jd
         P7WPV9UTOpF/lDpw6Avll8oXwNIxAxEAiyfeiSi8XCXOt/daw6mQIDmfEwUtankGaNgq
         zuKKPmftdu70eHAauZEdNQbnQ8sXgPFFSIkumYgyswZ56qs1zAvazzT9zilaGa/3a2vm
         6O32IWIeJQXia07RRG10M7G2/dKavttzoTTwUEQImHVMFqHNO9C6WIk3ISha3U/lGEZ+
         9OXCyIzp9yPtKpmrVy9MIdU4Mv603Zu48+N+hnihVrvEEX39oJnRPf27zVufDn0fuaWi
         fOLw==
X-Gm-Message-State: ANoB5pmQ/dzcJil3OZptYmnqevKeOTNo3BzXJBQ+7zXpCv9XJ6t2mmK1
        QndAA5gRf1nq7zDStyf+yXjbwcsrK3CljiCsqiSbmurU3vTkTUl+/DHz60hZciHFSGUJ8ruQHF2
        qm2Mku3eEHUV2mWklbK86Oi4Q
X-Received: by 2002:a05:600c:1e83:b0:3cf:6ab3:4a60 with SMTP id be3-20020a05600c1e8300b003cf6ab34a60mr5850610wmb.32.1668347871753;
        Sun, 13 Nov 2022 05:57:51 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6sj46Yoe6+WzbEdbDAptfcusvqC0lkHaz7X1vmJQK6RoGsd1oLq6ETs2H2lhekrgkToe+DKg==
X-Received: by 2002:a05:600c:1e83:b0:3cf:6ab3:4a60 with SMTP id be3-20020a05600c1e8300b003cf6ab34a60mr5850601wmb.32.1668347871500;
        Sun, 13 Nov 2022 05:57:51 -0800 (PST)
Received: from redhat.com ([2.52.4.127])
        by smtp.gmail.com with ESMTPSA id q10-20020adff94a000000b0022cc6b8df5esm6970526wrr.7.2022.11.13.05.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 05:57:51 -0800 (PST)
Date:   Sun, 13 Nov 2022 08:57:47 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lulu@redhat.com" <lulu@redhat.com>
Subject: Re: [PATCH 0/7] vdpa/mlx5: Add debugfs subtree and fixes
Message-ID: <20221113085723-mutt-send-email-mst@kernel.org>
References: <20221113134442.152695-1-elic@nvidia.com>
 <20221113085044-mutt-send-email-mst@kernel.org>
 <DM8PR12MB5400DB70B0AA6831E6ABF7AAAB029@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR12MB5400DB70B0AA6831E6ABF7AAAB029@DM8PR12MB5400.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2022 at 01:56:00PM +0000, Eli Cohen wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Sunday, 13 November 2022 15:52
> > To: Eli Cohen <elic@nvidia.com>
> > Cc: jasowang@redhat.com; linux-kernel@vger.kernel.org;
> > virtualization@lists.linux-foundation.org; si-wei.liu@oracle.com;
> > eperezma@redhat.com; lulu@redhat.com
> > Subject: Re: [PATCH 0/7] vdpa/mlx5: Add debugfs subtree and fixes
> > 
> > On Sun, Nov 13, 2022 at 03:44:35PM +0200, Eli Cohen wrote:
> > > This series is a resend of previously sent patch list. It adds a few
> > > fixes so I treat as a v0 of a new series.
> > >
> > > It adds a kernel config param CONFIG_MLX5_VDPA_STEERING_DEBUG that
> > when
> > > eabled allows to read rx unicast and multicast counters per tagged or
> > untagged traffic.
> > >
> > > Examples:
> > > $ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-
> > 0/rx/untagged/mcast/packets
> > > $ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-
> > 0/rx/untagged/ucast/bytes
> > 
> > 
> > Thanks!
> > Is this patchset intended for 6.2 then?
> > 
> 
> The debugfs part can go to 6.2 but maybe the fixes should go to 6.1.


Tat's fine - do they apply cleanly if I just drop 4/7?

> > >
> > > Eli Cohen (7):
> > >   vdpa/mlx5: Fix rule forwarding VLAN to TIR
> > >   vdpa/mlx5: Fix wrong mac address deletion
> > >   vdpa/mlx5: Move some definitions to a new header file
> > >   vdpa/mlx5: Add debugfs subtree
> > >   vdpa/mlx5: Add RX counters to debugfs
> > >   vdpa/mlx5: Avoid using reslock in event_handler
> > >   vdpa/mlx5: Avoid overwriting CVQ iotlb
> > >
> > >  drivers/vdpa/Kconfig               |  12 ++
> > >  drivers/vdpa/mlx5/Makefile         |   2 +-
> > >  drivers/vdpa/mlx5/core/mlx5_vdpa.h |   5 +-
> > >  drivers/vdpa/mlx5/core/mr.c        |  44 ++---
> > >  drivers/vdpa/mlx5/net/debug.c      | 152 ++++++++++++++++++
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 248 ++++++++++++++---------------
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.h  |  94 +++++++++++
> > >  7 files changed, 411 insertions(+), 146 deletions(-)
> > >  create mode 100644 drivers/vdpa/mlx5/net/debug.c
> > >  create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.h
> > >
> > > --
> > > 2.38.1
> 

