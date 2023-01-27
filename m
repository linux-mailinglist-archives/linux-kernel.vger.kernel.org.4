Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CCA67DEE8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 09:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjA0IOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 03:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjA0IO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 03:14:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6FA38013
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 00:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674807227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wQyPt/6bZriSvjC5ZXh5l3TKz/N7A4kc1yntO2MilN0=;
        b=a3EcuUiJbgankfsGqdQjUxuYeqpXjm+33ZRDUapjw6HIc8qUwm6zNtTrnTmOfKn2Ot0B7p
        h2ar9hwYb0FBKyPLvBCDgOPMpYytJzvrWb+/0AgE4lV8CgYpq+pRaHPWOO3+YpVtb/lqU3
        T84tU4WJzJR5h1iZz600A3anLoUvjxo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-252-Z6Nj1TXBPmq0ujnQ2BEItg-1; Fri, 27 Jan 2023 03:13:42 -0500
X-MC-Unique: Z6Nj1TXBPmq0ujnQ2BEItg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39FAA3C0D845;
        Fri, 27 Jan 2023 08:13:41 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE9E5400DE84;
        Fri, 27 Jan 2023 08:13:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id B10301800606; Fri, 27 Jan 2023 09:13:39 +0100 (CET)
Date:   Fri, 27 Jan 2023 09:13:39 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org,
        David Airlie <airlied@gmail.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Herring <robh@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v10 00/11] Add generic memory shrinker to VirtIO-GPU and
 Panfrost DRM drivers
Message-ID: <20230127081339.yovxofpboc4gfdgo@sirius.home.kraxel.org>
References: <20230108210445.3948344-1-dmitry.osipenko@collabora.com>
 <e5e9e8dd-a5b6-cfd2-44d6-4d5aa768e56c@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5e9e8dd-a5b6-cfd2-44d6-4d5aa768e56c@collabora.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 01:55:09AM +0300, Dmitry Osipenko wrote:
> Hello Thomas and Gerd,
> 
> On 1/9/23 00:04, Dmitry Osipenko wrote:
> > This series:
> > 
> >   1. Makes minor fixes for drm_gem_lru and Panfrost
> >   2. Brings refactoring for older code
> >   3. Adds common drm-shmem memory shrinker
> >   4. Enables shrinker for VirtIO-GPU driver
> >   5. Switches Panfrost driver to the common shrinker
> > 
> > Changelog:
> > 
> > v10:- Rebased on a recent linux-next.
> > 
> >     - Added Rob's ack to MSM "Prevent blocking within shrinker loop" patch.
> > 
> >     - Added Steven's ack/r-b/t-b for the Panfrost patches.
> > 
> >     - Fixed missing export of the new drm_gem_object_evict() function.
> > 
> >     - Added fixes tags to the first two patches that are making minor fixes,
> >       for consistency.
> 
> Do you have comments on this version? Otherwise ack will be appreciated.
> Thanks in advance!

Don't feel like signing off on the locking changes, I'm not that
familiar with the drm locking rules.  So someone else looking at them
would be good.  Otherwise the series and specifically the virtio changes
look good to me.

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

take care,
  Gerd

