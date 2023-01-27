Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A1867E250
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjA0Kyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjA0Kyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:54:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757D71DBAB
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674816823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wJ1GI3G85fJFqYm06GI8lKzcGyIkLgYi7jejhumzexw=;
        b=F3kwA4PJL5dzMkqbr5gRhfsgwdbHy6jYmNY1AOQ5JPlFhc6DpNDk2g9ucpLdsZxNw+c80l
        6fKUCP2eXNuLyVV/sjV0a98FB7Povuxq/KlkgXdIlSHvsOGtzDLIRPDnbc1Q0QNGJ40/y5
        yBeFrSUHBTc5iogOKelXUxSX2tn5mPQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-180-Ul528OitMKWjKeuPA1ygLw-1; Fri, 27 Jan 2023 05:53:42 -0500
X-MC-Unique: Ul528OitMKWjKeuPA1ygLw-1
Received: by mail-wm1-f71.google.com with SMTP id k20-20020a05600c1c9400b003db2e916b3aso4442200wms.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:53:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wJ1GI3G85fJFqYm06GI8lKzcGyIkLgYi7jejhumzexw=;
        b=Ig/iZTd0eAN8+52fJjkXID7ctWRpTE/Mgwkqltlf6EN/QSr8ScU9SmQvSPO79RaIwj
         j4svbkAMvCz2C3e3YLANQtUPKTLK7X71tVnaGPiaKYzuZuypoO+uOMAUOqIRCGASlTsE
         O8V0gNcdFtRtO9MeNirgW/1VGwwLmckNjdtUkedk8GJxDiiJHFENSVKc/Lz/ME3T3SyD
         yMopIJKvAeHvXMP6GxhoJzo08djgNJ48ZR4Lsec89gv4aaSykvVHhsGL7RBgHvKSc4g/
         bsi/xuDy/L11dnbKalSv9AaPPDJ5qYIjHMgcOi9QUmWaSgiJwdHbUu5vST3jPiyvQpPr
         /Cpw==
X-Gm-Message-State: AFqh2kqyDl8zqk2w3528oRK6K2UPNNdcgnF+HIkHPb5n7dn+AfwCS+/S
        TAi5FZoDTkMaM6AWT9ibYWM1RRiqBhMxTAC8swjNrdT7A1mf7OTOBsjvECzVujMEhOUt5XqjLaS
        cdDNMeHtRTlSh4MCfSnGQE8wf
X-Received: by 2002:a05:600c:4a27:b0:3db:3ef:2369 with SMTP id c39-20020a05600c4a2700b003db03ef2369mr38655057wmp.40.1674816821129;
        Fri, 27 Jan 2023 02:53:41 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtRdTDcoX64da1qVXSSsJF8re3QcHQbT7S3uNuQv82lkftjUWFmD9UXAuPYItMnIUX9MLx2Sg==
X-Received: by 2002:a05:600c:4a27:b0:3db:3ef:2369 with SMTP id c39-20020a05600c4a2700b003db03ef2369mr38655044wmp.40.1674816820937;
        Fri, 27 Jan 2023 02:53:40 -0800 (PST)
Received: from redhat.com ([2.52.137.69])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600c1d0400b003db2dede1a2sm8068848wms.26.2023.01.27.02.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 02:53:40 -0800 (PST)
Date:   Fri, 27 Jan 2023 05:53:36 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc:     leiyang@redhat.com, Laurent Vivier <lvivier@redhat.com>,
        sgarzare@redhat.com, jasowang@redhat.com,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        virtualization@lists.linux-foundation.org, si-wei.liu@oracle.com,
        linux-kernel@vger.kernel.org, lulu@redhat.com,
        Gautam Dawar <gdawar@xilinx.com>, alvaro.karsz@solid-run.com
Subject: Re: [PATCH 0/2] Fix expected set_vq_state behavior on vdpa_sim
Message-ID: <20230127055303-mutt-send-email-mst@kernel.org>
References: <20230118164359.1523760-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230118164359.1523760-1-eperezma@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 05:43:57PM +0100, Eugenio Pérez wrote:
> The use of set_vq_state is to indicate vdpa device the state of a virtqueue.
> In the case of split, it means the avail_idx.  This is mandatory for use
> cases like live migration.
> 
> However, vdpa_sim reset the vq state at vdpasim_queue_ready since it calls
> vringh_init_iotlb.
> 
> Also, to starting from an used_idx different than 0 is needed in use cases like
> virtual machine migration.  Not doing so and letting the caller set an avail
> idx different than 0 causes destination device to try to use old buffers that
> source driver already recover and are not available anymore.
> 
> This series fixes both problems allowing to migrate to a vdpa_sim_net device.

Jason problems you pointed out are all consmetic do you ack
the patchset? Or expect another revision?

> Eugenio Pérez (2):
>   vdpa_sim: not reset state in vdpasim_queue_ready
>   vringh: fetch used_idx from vring at vringh_init_iotlb
> 
>  drivers/vdpa/vdpa_sim/vdpa_sim.c |  2 ++
>  drivers/vhost/vringh.c           | 25 +++++++++++++++++++++++--
>  2 files changed, 25 insertions(+), 2 deletions(-)
> 
> -- 
> 2.31.1
> 

