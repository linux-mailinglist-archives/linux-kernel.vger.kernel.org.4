Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CE2699416
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjBPMPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBPMPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:15:41 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E161BC3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:15:40 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id y1so1665565wru.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=piaqzgCKFZLQmY10k4IjC7MluutMq0LDizDNTJemOVE=;
        b=ZwmW+/tsxiqhy4Fe8h8o+D+0Y3rKgPhqnPVd3h2SXXjq9GFWsGM/IYJuSGdI/VS12v
         ONNkkDZVd0AjsYVwEKCHys6pJs4ZVXw9sDzzrSQZ72h1ZFRYSu92lypNMVcYe8A7bQeU
         Emw+iqP0l5YYH99k1kkz89QUaXRVbiZ7JWnEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=piaqzgCKFZLQmY10k4IjC7MluutMq0LDizDNTJemOVE=;
        b=rNPt8uaTKAJD2+tEPSs8rH8Jck9i/SweFz31sOcKiPDCouHrMDXO8Ym2vL7yMkZbF3
         X+nDItOBM4Kp/npu4G90s8tdy3ulxlPQpwMqPDdQP6Qv+J4TnaxohIYDeB0lHVSejffK
         MkhxeOqFlFvjiQWVSlS8jMef1amSlD1Sk8l6nICbgqM/5gPzOjz1y4oKmjdlHBOuDBj1
         EzeaqLwwstlz8vFNOSgPKLbXw8rv8KkTlGQlU43PEWVRD5qeLSywQmT/V4I/epG3RMCk
         a815ZHOFpjpxfgroGo0ebUf98co/HZrmyI/R0On8vgPKkzyFEDB+N8MBtjT2/gyoUwZn
         RY6w==
X-Gm-Message-State: AO0yUKUU0GE2hzGdije5RZ2VuuQz54kVoljE9kmAxNYGvvyBNd9qsyVT
        LRdZKOm8rIxGvhGzEV8AntHNXg==
X-Google-Smtp-Source: AK7set8htScoYo9KcDutSph1npWSqUrZBvhCgkZbtOlJws9UnAqhqfODu6C0HWh4XJFXcCSIORzQUA==
X-Received: by 2002:a5d:46d1:0:b0:2bf:de9c:4595 with SMTP id g17-20020a5d46d1000000b002bfde9c4595mr3616218wrs.5.1676549739053;
        Thu, 16 Feb 2023 04:15:39 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id u11-20020a5d514b000000b002425be3c9e2sm1364716wrt.60.2023.02.16.04.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 04:15:38 -0800 (PST)
Date:   Thu, 16 Feb 2023 13:15:30 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
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
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Herring <robh@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v10 00/11] Add generic memory shrinker to VirtIO-GPU and
 Panfrost DRM drivers
Message-ID: <Y+4eYqdH1Xw2OYX5@phenom.ffwll.local>
Mail-Followup-To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org,
        David Airlie <airlied@gmail.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>, Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Herring <robh@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <20230108210445.3948344-1-dmitry.osipenko@collabora.com>
 <e5e9e8dd-a5b6-cfd2-44d6-4d5aa768e56c@collabora.com>
 <20230127081339.yovxofpboc4gfdgo@sirius.home.kraxel.org>
 <0081b2c3-56c9-3ed8-b419-5ce8a151999e@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0081b2c3-56c9-3ed8-b419-5ce8a151999e@collabora.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 03:02:10PM +0300, Dmitry Osipenko wrote:
> On 1/27/23 11:13, Gerd Hoffmann wrote:
> > On Thu, Jan 26, 2023 at 01:55:09AM +0300, Dmitry Osipenko wrote:
> >> Hello Thomas and Gerd,
> >>
> >> On 1/9/23 00:04, Dmitry Osipenko wrote:
> >>> This series:
> >>>
> >>>   1. Makes minor fixes for drm_gem_lru and Panfrost
> >>>   2. Brings refactoring for older code
> >>>   3. Adds common drm-shmem memory shrinker
> >>>   4. Enables shrinker for VirtIO-GPU driver
> >>>   5. Switches Panfrost driver to the common shrinker
> >>>
> >>> Changelog:
> >>>
> >>> v10:- Rebased on a recent linux-next.
> >>>
> >>>     - Added Rob's ack to MSM "Prevent blocking within shrinker loop" patch.
> >>>
> >>>     - Added Steven's ack/r-b/t-b for the Panfrost patches.
> >>>
> >>>     - Fixed missing export of the new drm_gem_object_evict() function.
> >>>
> >>>     - Added fixes tags to the first two patches that are making minor fixes,
> >>>       for consistency.
> >>
> >> Do you have comments on this version? Otherwise ack will be appreciated.
> >> Thanks in advance!
> > 
> > Don't feel like signing off on the locking changes, I'm not that
> > familiar with the drm locking rules.  So someone else looking at them
> > would be good.  Otherwise the series and specifically the virtio changes
> > look good to me.
> > 
> > Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> Thomas was looking at the the DRM core changes. I expect he'll ack them.
> 
> Thank you for reviewing the virtio patches!

I think best-case would be an ack from msm people that this looks good
(even better a conversion for msm to start using this).

Otherwise I think the locking looks reasonable, I think the tricky bits
have been moving the dma-buf rules, but if you want I can try to take
another in-depth look. But would need to be in 2 weeks since I'm going on
vacations, pls ping me on irc if I'm needed.

Otherwise would be great if we can land this soon, so that it can soak the
entire linux-next cycle to catch any driver specific issues.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
