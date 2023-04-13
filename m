Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0616E093B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 10:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjDMIqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 04:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDMIqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:46:34 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9BA6183
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 01:46:32 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-94a342f4c8eso62624066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 01:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1681375590; x=1683967590;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cU47L3sLeOYrkDWs84Myga16bAiwQGB6q0rl/Fg1mzk=;
        b=ev61Sb/spDPgQ85fk+r6/L0drS29wujhVCQDZc1oIvnuDEGc8EEO3YjY6mLz3Fzv9o
         EijAY1sQ6ptnmzi91HIZ/JPtrpRpzDuIvB7MyGIOWm6H8jTJMFPnTDT9GlaYiUwCKuzq
         hb+oaLvnHIbJCdWDNIHUY4fdjbPvZcAKyijbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681375590; x=1683967590;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cU47L3sLeOYrkDWs84Myga16bAiwQGB6q0rl/Fg1mzk=;
        b=Exw4MHA2M2Jo+K+52BwgBRbvY44O9amH4vLtJO3sQB0uOsPoI1vJxI+wIAbKv7aTG+
         OuHe8CtI54gLD+FMcSTJdN4dgZwHc45FdmPlbIbc/Z50lF5opk/PE4LmPs9upzNemgoS
         bBnoSVBxUXrQdBY1YYD2br7h7d9S3SCAllM8r3OjkFfHedkykBB9LfeY3L6Wdll7iXnx
         VGIKlh4lLPwUHC/EX4HMBQy6iO4+YBjsWfGcIW7f4x7Vx5m2wP+5p9izU1yrsQH45KCF
         AYm0uVopItJ2cFON4QNGnmLAExP25FXzOO1ehaZiweHV7Bcm8V40vjXPLZreYHwZ6kj5
         xggw==
X-Gm-Message-State: AAQBX9fm+g4UIUeSCBAoS3d3Cl1BjG9xNu7Rdhvh+SsnQQN+DYrbRrnG
        SezwNf14y//ZNFTdFib2ewkPJw==
X-Google-Smtp-Source: AKy350ayrJkpPJdsjI/YoN1IZKT+GlbEBPHLdDhM6jlRev4fxFd1ZU3slcUdb/yNo5zYIA0tiIY7GA==
X-Received: by 2002:a17:906:150:b0:94e:4843:5e32 with SMTP id 16-20020a170906015000b0094e48435e32mr1674681ejh.5.1681375590474;
        Thu, 13 Apr 2023 01:46:30 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709064b0e00b0094e60ac9678sm642373eju.122.2023.04.13.01.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 01:46:30 -0700 (PDT)
Date:   Thu, 13 Apr 2023 10:46:28 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/6] drm: Add common fdinfo helper
Message-ID: <ZDfBZIuiAuMhuULd@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230412224311.23511-1-robdclark@gmail.com>
 <20230412224311.23511-2-robdclark@gmail.com>
 <ce87917c-6cf1-b1e7-4782-61a7e47aa92d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce87917c-6cf1-b1e7-4782-61a7e47aa92d@amd.com>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 10:07:11AM +0200, Christian König wrote:
> Am 13.04.23 um 00:42 schrieb Rob Clark:
> > From: Rob Clark <robdclark@chromium.org>
> > 
> > Handle a bit of the boiler-plate in a single case, and make it easier to
> > add some core tracked stats.
> > 
> > v2: Update drm-usage-stats.rst, 64b client-id, rename drm_show_fdinfo
> > 
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >   Documentation/gpu/drm-usage-stats.rst | 10 +++++++-
> >   drivers/gpu/drm/drm_file.c            | 35 +++++++++++++++++++++++++++
> >   include/drm/drm_drv.h                 |  7 ++++++
> >   include/drm/drm_file.h                |  4 +++
> >   4 files changed, 55 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/drm-usage-stats.rst
> > index b46327356e80..2ab32c40e93c 100644
> > --- a/Documentation/gpu/drm-usage-stats.rst
> > +++ b/Documentation/gpu/drm-usage-stats.rst
> > @@ -126,7 +126,15 @@ percentage utilization of the engine, whereas drm-engine-<str> only reflects
> >   time active without considering what frequency the engine is operating as a
> >   percentage of it's maximum frequency.
> > +Implementation Details
> > +======================
> > +
> > +Drivers should use drm_show_fdinfo() in their `struct file_operations`, and
> > +implement &drm_driver.show_fdinfo if they wish to provide any stats which
> > +are not provided by drm_show_fdinfo().  But even driver specific stats should
> > +be documented above and where possible, aligned with other drivers.
> 
> I'm really wondering if it wouldn't be less mid-layering if we let the
> drivers call the drm function to print the common values instead of the
> other way around?

The idea is that we plug this into DRM_GEM_FOPS and then everyone gets it
by default. So it's a bit a tradeoff between midlayering and having
inconsistent uapi between drivers. And there's generic tools that parse
this, so consistency across drivers is good.

My gut feeling was that after a bit of experimenting with lots of
different drivers for fdinfo stuff it's time to push for a bit more
standardization and less fragmentation.

We can of course later on course-correct and shuffle things around again,
e.g. by pushing more things into the gem_bo_fops->status hook (ttm and
other memory manager libs could implement a decent one by default), or
moving more into the drm_driver->show_fdinfo callback again.

If you look at kms we also shuffle things back&forth between core (for
more consistency) and drivers (for more flexibility where needed).

The important part here imo is that we start with some scaffolding to be
able to do this. Like another thing that I think we want is some
drm_fdinfo_print functions that make sure the formatting is guaranteed
consistents and we don't trip up parsers (like some drivers use " \t" as
separator instead of just "\t", I guess by accident).

> Apart from thatquestion the patch looks good to me.

Ack? Or want the above recorded in the commit message, I think it'd make
sense to put it there.
-Daniel

> 
> Christian.
> 
> > +
> >   Driver specific implementations
> > -===============================
> > +-------------------------------
> >   :ref:`i915-usage-stats`
> > diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> > index a51ff8cee049..6d5bdd684ae2 100644
> > --- a/drivers/gpu/drm/drm_file.c
> > +++ b/drivers/gpu/drm/drm_file.c
> > @@ -148,6 +148,7 @@ bool drm_dev_needs_global_mutex(struct drm_device *dev)
> >    */
> >   struct drm_file *drm_file_alloc(struct drm_minor *minor)
> >   {
> > +	static atomic64_t ident = ATOMIC_INIT(0);
> >   	struct drm_device *dev = minor->dev;
> >   	struct drm_file *file;
> >   	int ret;
> > @@ -156,6 +157,8 @@ struct drm_file *drm_file_alloc(struct drm_minor *minor)
> >   	if (!file)
> >   		return ERR_PTR(-ENOMEM);
> > +	/* Get a unique identifier for fdinfo: */
> > +	file->client_id = atomic64_inc_return(&ident);
> >   	file->pid = get_pid(task_pid(current));
> >   	file->minor = minor;
> > @@ -868,6 +871,38 @@ void drm_send_event(struct drm_device *dev, struct drm_pending_event *e)
> >   }
> >   EXPORT_SYMBOL(drm_send_event);
> > +/**
> > + * drm_show_fdinfo - helper for drm file fops
> > + * @seq_file: output stream
> > + * @f: the device file instance
> > + *
> > + * Helper to implement fdinfo, for userspace to query usage stats, etc, of a
> > + * process using the GPU.  See also &drm_driver.show_fdinfo.
> > + *
> > + * For text output format description please see Documentation/gpu/drm-usage-stats.rst
> > + */
> > +void drm_show_fdinfo(struct seq_file *m, struct file *f)
> > +{
> > +	struct drm_file *file = f->private_data;
> > +	struct drm_device *dev = file->minor->dev;
> > +	struct drm_printer p = drm_seq_file_printer(m);
> > +
> > +	drm_printf(&p, "drm-driver:\t%s\n", dev->driver->name);
> > +	drm_printf(&p, "drm-client-id:\t%llu\n", file->client_id);
> > +
> > +	if (dev_is_pci(dev->dev)) {
> > +		struct pci_dev *pdev = to_pci_dev(dev->dev);
> > +
> > +		drm_printf(&p, "drm-pdev:\t%04x:%02x:%02x.%d\n",
> > +			   pci_domain_nr(pdev->bus), pdev->bus->number,
> > +			   PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
> > +	}
> > +
> > +	if (dev->driver->show_fdinfo)
> > +		dev->driver->show_fdinfo(&p, file);
> > +}
> > +EXPORT_SYMBOL(drm_show_fdinfo);
> > +
> >   /**
> >    * mock_drm_getfile - Create a new struct file for the drm device
> >    * @minor: drm minor to wrap (e.g. #drm_device.primary)
> > diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> > index 5b86bb7603e7..5edf2a13733b 100644
> > --- a/include/drm/drm_drv.h
> > +++ b/include/drm/drm_drv.h
> > @@ -401,6 +401,13 @@ struct drm_driver {
> >   			       struct drm_device *dev, uint32_t handle,
> >   			       uint64_t *offset);
> > +	/**
> > +	 * @show_fdinfo:
> > +	 *
> > +	 * Print device specific fdinfo.  See Documentation/gpu/drm-usage-stats.rst.
> > +	 */
> > +	void (*show_fdinfo)(struct drm_printer *p, struct drm_file *f);
> > +
> >   	/** @major: driver major number */
> >   	int major;
> >   	/** @minor: driver minor number */
> > diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
> > index 0d1f853092ab..6de6d0e9c634 100644
> > --- a/include/drm/drm_file.h
> > +++ b/include/drm/drm_file.h
> > @@ -258,6 +258,9 @@ struct drm_file {
> >   	/** @pid: Process that opened this file. */
> >   	struct pid *pid;
> > +	/** @client_id: A unique id for fdinfo */
> > +	u64 client_id;
> > +
> >   	/** @magic: Authentication magic, see @authenticated. */
> >   	drm_magic_t magic;
> > @@ -437,6 +440,7 @@ void drm_send_event(struct drm_device *dev, struct drm_pending_event *e);
> >   void drm_send_event_timestamp_locked(struct drm_device *dev,
> >   				     struct drm_pending_event *e,
> >   				     ktime_t timestamp);
> > +void drm_show_fdinfo(struct seq_file *m, struct file *f);
> >   struct file *mock_drm_getfile(struct drm_minor *minor, unsigned int flags);
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
