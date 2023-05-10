Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B3C6FE4E8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbjEJUPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235708AbjEJUPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:15:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8531310C9
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 13:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683749700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tfsK2yFYcauaq/Kob2svvb9XT2LMlLifPGyY56gbQYk=;
        b=WX8NaeF6jtOF5PeV2lzBDnVZq3PB1aJzijAuPUVToD/UCJMyjTF55Ct1pymJWu09cYYEUv
        VMyrk40EwBiTnaHQR7OWoSrMPySL3205BtpVXLWcA7vqsVoCFx2bS5z405LwB9t81im6IC
        AEoaPjbbOpAFGnZXBOUHqNY1QgHWVMM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-owy2cPQoNXejK_LHd8CZRg-1; Wed, 10 May 2023 16:14:59 -0400
X-MC-Unique: owy2cPQoNXejK_LHd8CZRg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3063287f1c9so2919491f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 13:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683749697; x=1686341697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfsK2yFYcauaq/Kob2svvb9XT2LMlLifPGyY56gbQYk=;
        b=aLBQeDr0g3XKztTUGV4tJ4T6DQLugQEBMCgmjPo4B1IRZOjoSc59ZnBkHC8U8Hjpy7
         zA4FcutsKG9GBCLXtB1SwQKdtkh7xM+jlKxmp7ie2mKwy/pF4YMpC8T8Cod1vv0FfphE
         u/PwA8Ph5Sggv+dQZ7Lz9c8pqDa75gZQLV/7JkO3xA8fGctrEmJVzGjyRPilR3gnFRaN
         tp0hj75kyQuFDIU1Rqr15vCg43OxAOH8D5v3LiNE63TAr9DIhiKFh8Tb3TnB0IdZXu6J
         oB6/fvlMxTUawYLhBUdnPPAAn2k0LvA5DZAaxhKETHm2GJZICd4eYA8TEPEVe53keyr9
         /kKg==
X-Gm-Message-State: AC+VfDyxNtJysWU80v53BLezAZLe1otuSUMI9wXdvtLber076qW33IBH
        qp7eBNXI6s5jWaBuN3JT8HwL0sWU75dnRjewhLfLigihOEQK0UrVoSzE+S7i4wfisFay4LGPe6j
        3cd8mcmZy6bjuLlvGVgLeGgxEjcGTRww7d24=
X-Received: by 2002:a5d:46cc:0:b0:307:1bba:ea61 with SMTP id g12-20020a5d46cc000000b003071bbaea61mr12964300wrs.44.1683749697429;
        Wed, 10 May 2023 13:14:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6nArb47shpuQrNqjz9H3I8yBD/XpXzKkgXB8nTLFpLIl2qlN2WjGoLWMWGwpTTFBJfG4ckpA==
X-Received: by 2002:a5d:46cc:0:b0:307:1bba:ea61 with SMTP id g12-20020a5d46cc000000b003071bbaea61mr12964289wrs.44.1683749697090;
        Wed, 10 May 2023 13:14:57 -0700 (PDT)
Received: from redhat.com ([31.187.78.71])
        by smtp.gmail.com with ESMTPSA id i11-20020adff30b000000b0030644bdefd8sm18246294wro.52.2023.05.10.13.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 13:14:56 -0700 (PDT)
Date:   Wed, 10 May 2023 16:14:53 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Simon Horman <horms@kernel.org>
Cc:     Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: Add missing documentation for structure fields
Message-ID: <20230510161442-mutt-send-email-mst@kernel.org>
References: <20230510-virtio-kdoc-v1-1-d2b1824a9a2b@kernel.org>
 <20230510120332-mutt-send-email-mst@kernel.org>
 <ZFv4DfUcipQAII5R@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFv4DfUcipQAII5R@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 10:01:17PM +0200, Simon Horman wrote:
> On Wed, May 10, 2023 at 12:04:21PM -0400, Michael S. Tsirkin wrote:
> > On Wed, May 10, 2023 at 02:23:12PM +0200, Simon Horman wrote:
> > > Add missing documentation for the vqs_list_lock field of struct virtio_device,
> > > and the validate field of struct virtio_driver.
> > > 
> > > ./scripts/kernel-doc says:
> > > 
> > >  .../virtio.h:131: warning: Function parameter or member 'vqs_list_lock' not described in 'virtio_device'
> > >  .../virtio.h:192: warning: Function parameter or member 'validate' not described in 'virtio_driver'
> > >  2 warnings as Errors
> > > 
> > > No functional changes intended.
> > > 
> > > Signed-off-by: Simon Horman <horms@kernel.org>
> > > ---
> > >  include/linux/virtio.h | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > index b93238db94e3..0b2b82ee3220 100644
> > > --- a/include/linux/virtio.h
> > > +++ b/include/linux/virtio.h
> > > @@ -103,6 +103,7 @@ int virtqueue_resize(struct virtqueue *vq, u32 num,
> > >   * @config_enabled: configuration change reporting enabled
> > >   * @config_change_pending: configuration change reported while disabled
> > >   * @config_lock: protects configuration change reporting
> > > + * @vqs_list_lock: protects @vqs.
> > >   * @dev: underlying device.
> > >   * @id: the device type identification (used to match it with a driver).
> > >   * @config: the configuration ops for this device.
> > > @@ -160,6 +161,7 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev);
> > >   * @feature_table_size: number of entries in the feature table array.
> > >   * @feature_table_legacy: same as feature_table but when working in legacy mode.
> > >   * @feature_table_size_legacy: number of entries in feature table legacy array.
> > > + * @validate: the function to call to vaidate features at probe time.
> > 
> > typo
> > 
> > and this is called before probe actually not at probe time
> 
> Thanks, how about the following?
> 
> * @validate: the function to call to validate features

... and config space

> > >   * @probe: the function to call when a device is found.  Returns 0 or -errno.
> > >   * @scan: optional function to call after successful probe; intended
> > >   *    for virtio-scsi to invoke a scan.
> > 

