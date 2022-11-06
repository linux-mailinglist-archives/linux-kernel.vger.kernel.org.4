Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A33361E1BE
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 11:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiKFKwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 05:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiKFKwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 05:52:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FB49FE7
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 02:52:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F284260C07
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 10:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63696C43470
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 10:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667731939;
        bh=zZXlka8XT0jQaPkciMFldTLZtAMw7JFqIJd9Pf545QE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y2V4328ZVop5zSPYMbnVBTVFNfHfFl+chIXZhpO3/zXuc77NPWVLdHRiTycGuYLy3
         OQbUBXlQWlcy4fOP0D5fVyCaK1MmlrXGd3P62LZtmNp8qrmfzslkYWTadXKvypzQHj
         nuFIGYLJxI3Zmgn+fkji9quyQVjcuXEjHVglP9ZZrIcbNXZqQkY22tMRB3HZzpmk+N
         ntw6n7OWV/T1t8nbGFYfzJJ3knROgXviZLu8JCdIFdPcA5MKh+0t6OQ4hf2D7Kb7lK
         ThJPmyQF4mRQFCzb2I2zJMaTGOGFh3RH04hlAYqJAWJJQPry4/lRvLo/ygZ19/8VyQ
         Cq6axWmp+BdzQ==
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-36cbcda2157so80326297b3.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 02:52:19 -0800 (PST)
X-Gm-Message-State: ACrzQf01T/8TSknhXNXVA8KCHRJva1Ab6KEdgYtmEFjUptavBO615g7m
        0zeyY6Y2TZTIZCQaBpEI0YvfN3Z7tDjnNJrg7vw=
X-Google-Smtp-Source: AMsMyM7whTmcg306z1pjEJrFbNEeVSy7uMLjOJgY0HfUfOsFdMfzjOY9hDUp6Y+85iouOs3uQS7VnQILBs8heSGodHE=
X-Received: by 2002:a81:9214:0:b0:36c:7b94:aa57 with SMTP id
 j20-20020a819214000000b0036c7b94aa57mr41538976ywg.221.1667731938334; Sun, 06
 Nov 2022 02:52:18 -0800 (PST)
MIME-Version: 1.0
References: <20221102203405.1797491-1-ogabbay@kernel.org> <20221102203405.1797491-3-ogabbay@kernel.org>
 <7654d9c0-c181-ae6b-96ee-349f20f24b18@quicinc.com>
In-Reply-To: <7654d9c0-c181-ae6b-96ee-349f20f24b18@quicinc.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Sun, 6 Nov 2022 12:51:51 +0200
X-Gmail-Original-Message-ID: <CAFCwf10SLEd3dKXYEhyX0E95b66Qfok2Rou=6tOE_j2LCpOc6A@mail.gmail.com>
Message-ID: <CAFCwf10SLEd3dKXYEhyX0E95b66Qfok2Rou=6tOE_j2LCpOc6A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/3] accel: add dedicated minor for accelerator devices
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 2, 2022 at 11:17 PM Jeffrey Hugo <quic_jhugo@quicinc.com> wrote:
>
> On 11/2/2022 2:34 PM, Oded Gabbay wrote:
> > @@ -24,16 +33,6 @@ static char *accel_devnode(struct device *dev, umode_t *mode)
> >
> >   static CLASS_ATTR_STRING(accel_version, 0444, "accel 1.0.0 20221018");
> >
> > -/**
> > - * accel_sysfs_init - initialize sysfs helpers
> > - *
> > - * This is used to create the ACCEL class, which is the implicit parent of any
> > - * other top-level ACCEL sysfs objects.
> > - *
> > - * You must call accel_sysfs_destroy() to release the allocated resources.
> > - *
> > - * Return: 0 on success, negative error code on failure.
> > - */
>
> Why are we removing this?
It should have been removed at the first patch, and will be fixed in v3.
I'm removing it as it is a static function. We don't document every
static function.
>
> >   static int accel_sysfs_init(void)
> >   {
> >       int err;
> > @@ -54,11 +53,6 @@ static int accel_sysfs_init(void)
> >       return 0;
> >   }
> >
> > -/**
> > - * accel_sysfs_destroy - destroys ACCEL class
> > - *
> > - * Destroy the ACCEL device class.
> > - */
>
> Again, why remove this?  Adding it in one patch than immediately
> removing it in the next patch seems wasteful.
Correct, will be removed from the first patch in the next version.
>
> >   static void accel_sysfs_destroy(void)
> >   {
> >       if (IS_ERR_OR_NULL(accel_class))
> > @@ -68,11 +62,185 @@ static void accel_sysfs_destroy(void)
> >       accel_class = NULL;
> >   }
> >
> > +static void accel_minor_release(struct drm_minor *minor)
> > +{
> > +     drm_dev_put(minor->dev);
> > +}
> > +
> > +/**
> > + * accel_open - open method for ACCEL file
> > + * @inode: device inode
> > + * @filp: file pointer.
> > + *
> > + * This function must be used by drivers as their &file_operations.open method.
>
> Feels like it would be helpful to have an accel version of
> DEFINE_DRM_GEM_FOPS() which helps accel drivers to get this right
Yeah, I also thought about it. I'll add it.
thanks,
oded
>
> > + * It looks up the correct ACCEL device and instantiates all the per-file
> > + * resources for it. It also calls the &drm_driver.open driver callback.
> > + *
> > + * Return: 0 on success or negative errno value on failure.
> > + */
> > +int accel_open(struct inode *inode, struct file *filp)
> > +{
> > +     struct drm_device *dev;
> > +     struct drm_minor *minor;
> > +     int retcode;
> > +
> > +     minor = accel_minor_acquire(iminor(inode));
> > +     if (IS_ERR(minor))
> > +             return PTR_ERR(minor);
> > +
> > +     dev = minor->dev;
> > +
> > +     atomic_fetch_inc(&dev->open_count);
> > +
> > +     /* share address_space across all char-devs of a single device */
> > +     filp->f_mapping = dev->anon_inode->i_mapping;
> > +
> > +     retcode = drm_open_helper(filp, minor);
> > +     if (retcode)
> > +             goto err_undo;
> > +
> > +     return 0;
> > +
> > +err_undo:
> > +     atomic_dec(&dev->open_count);
> > +     accel_minor_release(minor);
> > +     return retcode;
> > +}
> > +EXPORT_SYMBOL_GPL(accel_open);
