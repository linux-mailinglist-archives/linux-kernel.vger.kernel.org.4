Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646A36A7BCE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 08:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjCBH0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 02:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjCBH0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 02:26:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B50211C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 23:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677741937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iUNoRnZ2khkkla6l3VKfRN3P5S1CmE7QZ6Fs397Sj+8=;
        b=GQoAXgAUOG7tRlXLv6t6c+mcYkCKJPz2OXb5l3ulPLZt2vg7IBPbbfqwDlJ7rNlZgoYq7u
        rnHl3WbuFmoUEHtLmd2BDjwoK4BiSatV1XMixVjtppi0/pJKeKMVjFALPEwXCfv6lLbSlj
        omazrzyqIS9Ze+f9x0vVAAwZnD2SeE4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-Es-Toy1WPRu27aB2s7YMkw-1; Thu, 02 Mar 2023 02:25:33 -0500
X-MC-Unique: Es-Toy1WPRu27aB2s7YMkw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E787538041C1;
        Thu,  2 Mar 2023 07:25:32 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 986A7492C3E;
        Thu,  2 Mar 2023 07:25:32 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 3CED71800084; Thu,  2 Mar 2023 08:25:31 +0100 (CET)
Date:   Thu, 2 Mar 2023 08:25:31 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        Chia-I Wu <olvaffe@gmail.com>,
        Ryan Neph <ryanneph@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] drm/virtio: Add option to disable KMS support
Message-ID: <20230302072531.375i6xetk72nis75@sirius.home.kraxel.org>
References: <20230301185432.3010939-1-robdclark@gmail.com>
 <6eb2cde8-f548-73ba-6091-131c1848690c@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6eb2cde8-f548-73ba-6091-131c1848690c@collabora.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 12:39:33AM +0300, Dmitry Osipenko wrote:
> On 3/1/23 21:54, Rob Clark wrote:
> >  /* virtgpu_display.c */
> > +#if defined(CONFIG_DRM_VIRTIO_GPU_KMS)
> >  int virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev);
> >  void virtio_gpu_modeset_fini(struct virtio_gpu_device *vgdev);
> > +#else
> > +static inline int virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev)
> > +{
> > +	return 0;
> > +}
> > +static inline void virtio_gpu_modeset_fini(struct virtio_gpu_device *vgdev)
> > +{
> > +}
> > +#endif
> 
> In v4 Gerd wanted to keep building the virtgpu_display.o and instead add
> the KSM config check to virtio_gpu_modeset_init/fini().

The main point is that the code workflow should be the same in both
cases.  The patch does that for virtio_gpu_modeset_init() but doesn't
for virtio_gpu_modeset_fini().

Return early in the functions (and drop the #ifdef here) is how I would
implement this, but I wouldn't insist on that, there are other ways to
solve this too ;)

take care,
  Gerd

