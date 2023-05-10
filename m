Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248FD6FE54B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbjEJUlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbjEJUlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:41:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED9E5FD3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 13:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683751218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c+YVOgzbPmVhXEjjEWcuvNv2oF/4/N7gIelXpRLUbJk=;
        b=LxhfOZ/YRVlidjE1asv1mxyclInc32VbhAC6w61AJBG3FHBfLHYJ+nDVTmRqCMlURRVE0T
        GrMAFl5VWSkXWi0npkwTTY9cCuxBYAAWZw4Q/aydCbmdsQRfFtu0KwlvCq0xFo9qJRsk6+
        elW5ryhlfghjfUBVedeb6RD2sTx3Wn8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-4KTB9fucMa6UjWKmbtTWQg-1; Wed, 10 May 2023 16:40:15 -0400
X-MC-Unique: 4KTB9fucMa6UjWKmbtTWQg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f41dcf1e28so18845365e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 13:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683751214; x=1686343214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+YVOgzbPmVhXEjjEWcuvNv2oF/4/N7gIelXpRLUbJk=;
        b=GCZdrB2Z+BclNIWEBFBlbc65mesxVlPhxr4JnLCcECNyKC49GNvV5qcduFKj4pDX0K
         XjZBWM0wRstKrcdMTV3NZePjXZJR85z2acN16HFUBmwB9waQlUXiL0uUdyF4BLsEiywB
         4eif/il5bm7P+WHcz7FHP5VQ2zbfJG0df0edBm0VsGDR1xtzGnvkKft9uZND5T7C3xdg
         8cvM4kvVwRWjXr+DgQfvAlJH6M+ZRyc9Mizz8LWYe7emNjuExmfRPYxEm+9JRvfl3FF5
         t4L8xPFtVZw1eYSwUdzMB9SR5j0RG4HCvXM1N1Q2OYfEHyvNPYSQySl52L08Lj6FFCWG
         PhFg==
X-Gm-Message-State: AC+VfDwemkNEHsWJTSKfCnX23s4d9ZyMQtk2UkupVvEGx3etW+aa1qpN
        FNSR14ALuwAxPleUkBV7JpcneBMhxlCkLJeQs8HGcJyoVV4GEJoDACDHwahrENo/pOeHKb62qdu
        6AnOwYHEZAEe2GrM2X0AsEqYb
X-Received: by 2002:a1c:7319:0:b0:3f1:8ef0:7e2f with SMTP id d25-20020a1c7319000000b003f18ef07e2fmr12174292wmb.25.1683751213961;
        Wed, 10 May 2023 13:40:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6eDoURduChHVCCN6+Chl5iorNMrvcKwRG8uiLTVLS+FrkSHsjJPGzuXrbkWId0VcjA4xStFA==
X-Received: by 2002:a1c:7319:0:b0:3f1:8ef0:7e2f with SMTP id d25-20020a1c7319000000b003f18ef07e2fmr12174282wmb.25.1683751213568;
        Wed, 10 May 2023 13:40:13 -0700 (PDT)
Received: from redhat.com ([31.187.78.71])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c22ca00b003f42158288dsm12676432wmg.20.2023.05.10.13.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 13:40:12 -0700 (PDT)
Date:   Wed, 10 May 2023 16:40:04 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Simon Horman <horms@kernel.org>
Cc:     Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: Add missing documentation for structure fields
Message-ID: <20230510163954-mutt-send-email-mst@kernel.org>
References: <20230510-virtio-kdoc-v1-1-d2b1824a9a2b@kernel.org>
 <20230510120332-mutt-send-email-mst@kernel.org>
 <ZFv4DfUcipQAII5R@kernel.org>
 <20230510161442-mutt-send-email-mst@kernel.org>
 <ZFv8GSdpg1sgVqxy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFv8GSdpg1sgVqxy@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 10:18:33PM +0200, Simon Horman wrote:
> On Wed, May 10, 2023 at 04:14:53PM -0400, Michael S. Tsirkin wrote:
> > On Wed, May 10, 2023 at 10:01:17PM +0200, Simon Horman wrote:
> > > On Wed, May 10, 2023 at 12:04:21PM -0400, Michael S. Tsirkin wrote:
> > > > On Wed, May 10, 2023 at 02:23:12PM +0200, Simon Horman wrote:
> > > > > Add missing documentation for the vqs_list_lock field of struct virtio_device,
> > > > > and the validate field of struct virtio_driver.
> > > > > 
> > > > > ./scripts/kernel-doc says:
> > > > > 
> > > > >  .../virtio.h:131: warning: Function parameter or member 'vqs_list_lock' not described in 'virtio_device'
> > > > >  .../virtio.h:192: warning: Function parameter or member 'validate' not described in 'virtio_driver'
> > > > >  2 warnings as Errors
> > > > > 
> > > > > No functional changes intended.
> > > > > 
> > > > > Signed-off-by: Simon Horman <horms@kernel.org>
> > > > > ---
> > > > >  include/linux/virtio.h | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > > 
> > > > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > > > index b93238db94e3..0b2b82ee3220 100644
> > > > > --- a/include/linux/virtio.h
> > > > > +++ b/include/linux/virtio.h
> > > > > @@ -103,6 +103,7 @@ int virtqueue_resize(struct virtqueue *vq, u32 num,
> > > > >   * @config_enabled: configuration change reporting enabled
> > > > >   * @config_change_pending: configuration change reported while disabled
> > > > >   * @config_lock: protects configuration change reporting
> > > > > + * @vqs_list_lock: protects @vqs.
> > > > >   * @dev: underlying device.
> > > > >   * @id: the device type identification (used to match it with a driver).
> > > > >   * @config: the configuration ops for this device.
> > > > > @@ -160,6 +161,7 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev);
> > > > >   * @feature_table_size: number of entries in the feature table array.
> > > > >   * @feature_table_legacy: same as feature_table but when working in legacy mode.
> > > > >   * @feature_table_size_legacy: number of entries in feature table legacy array.
> > > > > + * @validate: the function to call to vaidate features at probe time.
> > > > 
> > > > typo
> > > > 
> > > > and this is called before probe actually not at probe time
> > > 
> > > Thanks, how about the following?
> > > 
> > > * @validate: the function to call to validate features
> > 
> > ... and config space
> 
> Ok, so:
> 
> * @validate: the function to call to validate features and config spaces

config space

> > > > >   * @probe: the function to call when a device is found.  Returns 0 or -errno.
> > > > >   * @scan: optional function to call after successful probe; intended
> > > > >   *    for virtio-scsi to invoke a scan.
> > > > 
> > 

