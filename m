Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11322617DF3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbiKCNc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiKCNcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:32:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB70DF1A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:32:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5DB9B82798
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 13:32:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730ABC433D7
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 13:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667482333;
        bh=UoFLX0FinbIoJbNaDjFI2Coj6yGat/OIbklXhnthpyk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vKkeMd8j95YWAZVmGgdyI8W+j+0b2VEYEgLxGUvGubJ314BfNOvk4qui9T5wGcywK
         uyWRkcImlwrivJhO67RsQOD0Atj34wn+YM136ByI9Ot30YVeT2hZxvRVF+M6fn7457
         iibVbRTsnd17CpOZF7u0xDyHqn5ZQF2uQHHsuTTJk4s94+wtEHVs8uxqIOzuI1eepf
         3tNGwsXN5CPi2QHVdNDfaYoVv23+hoLs18i5cg14WIPB8HmbSc1jURIl9YxL3bwewo
         BXs0P39BCc7ee09cyJnAlbyRHyGiJEByRuAyyswTKfS8XnrRB2xpRW8+AWb3GYP4Z2
         UhEKlVrDx4kog==
Received: by mail-yb1-f170.google.com with SMTP id g127so2193223ybg.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 06:32:13 -0700 (PDT)
X-Gm-Message-State: ACrzQf026jE9ibipY/oakP1FQM7Q5/9ppiGd0in6MzPBfE/72L1AAh4f
        3gTH0KVqAIsF1ocelaArn/NuwDz4uXMHT8Ovqis=
X-Google-Smtp-Source: AMsMyM5bftAXtLLuov90T8bioufKoJDjG80R/SQTYWAHpH5Es5NQXy6d7SdXW3iWu1zfuRa0tBD2ngyDJnBqyHQGC3k=
X-Received: by 2002:a25:9102:0:b0:6cc:9093:c8bf with SMTP id
 v2-20020a259102000000b006cc9093c8bfmr23856507ybl.197.1667482332482; Thu, 03
 Nov 2022 06:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221102203405.1797491-1-ogabbay@kernel.org> <20221102203405.1797491-2-ogabbay@kernel.org>
 <Y2MMCIe5wND2XPqE@kroah.com>
In-Reply-To: <Y2MMCIe5wND2XPqE@kroah.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Thu, 3 Nov 2022 15:31:45 +0200
X-Gmail-Original-Message-ID: <CAFCwf13uLj=P6u6FAcY8M5qAXoaBdb+Ha-TYj0j2FAZnFAPFYg@mail.gmail.com>
Message-ID: <CAFCwf13uLj=P6u6FAcY8M5qAXoaBdb+Ha-TYj0j2FAZnFAPFYg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] drivers/accel: define kconfig and register a
 new major
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 3, 2022 at 2:31 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Nov 02, 2022 at 10:34:03PM +0200, Oded Gabbay wrote:
> > --- /dev/null
> > +++ b/drivers/accel/Kconfig
> > @@ -0,0 +1,24 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# Compute Acceleration device configuration
> > +#
> > +# This framework provides support for compute acceleration devices, such
> > +# as, but not limited to, Machine-Learning and Deep-Learning acceleration
> > +# devices
> > +#
> > +menuconfig ACCEL
> > +     tristate "Compute Acceleration Framework"
> > +     depends on DRM
> > +     help
> > +       Framework for device drivers of compute acceleration devices, such
> > +       as, but not limited to, Machine-Learning and Deep-Learning
> > +       acceleration devices.
> > +       If you say Y here, you need to select the module that's right for
> > +       your acceleration device from the list below.
> > +       This framework is integrated with the DRM subsystem as compute
> > +       accelerators and GPUs share a lot in common and can use almost the
> > +       same infrastructure code.
> > +       Having said that, acceleration devices will have a different
> > +       major number than GPUs, and will be exposed to user-space using
> > +       different device files, called accel/accel* (in /dev, sysfs
> > +       and debugfs)
>
> Module name if "M" is chosen?
Will add
>
>
> > +static char *accel_devnode(struct device *dev, umode_t *mode)
> > +{
> > +     return kasprintf(GFP_KERNEL, "accel/%s", dev_name(dev));
> > +}
> > +
> > +static CLASS_ATTR_STRING(accel_version, 0444, "accel 1.0.0 20221018");
>
> What is a version number doing here?
>
> Please no, I understand that DRM has this, but it really does not make
> sense for any in-kernel code.  And that's not how sysfs is supposed to
> work anyway (if a file is present, the value is documented, if the file
> is not present, the value is just not there, userspace has to handle
> it all.)
Actually I don't know if drm even uses that. I just copied it to be
identical to drm's sysfs, but
as accel doesn't have any history, I can remove it.
>
> > +
> > +/**
> > + * accel_sysfs_init - initialize sysfs helpers
> > + *
> > + * This is used to create the ACCEL class, which is the implicit parent of any
> > + * other top-level ACCEL sysfs objects.
> > + *
> > + * You must call accel_sysfs_destroy() to release the allocated resources.
> > + *
> > + * Return: 0 on success, negative error code on failure.
> > + */
> > +static int accel_sysfs_init(void)
> > +{
> > +     int err;
> > +
> > +     accel_class = class_create(THIS_MODULE, "accel");
> > +     if (IS_ERR(accel_class))
> > +             return PTR_ERR(accel_class);
> > +
> > +     err = class_create_file(accel_class, &class_attr_accel_version.attr);
>
> Hint, if you ever find yourself adding sysfs files "by hand" like this,
> you are doing something wrong.  The driver code should create them
> automatically for you by setting up default groups, _OR_ as in this
> case, you shouldn't be adding the file at all :)
ok, removed.

>
> > +static void accel_sysfs_destroy(void)
> > +{
> > +     if (IS_ERR_OR_NULL(accel_class))
> > +             return;
> > +     class_remove_file(accel_class, &class_attr_accel_version.attr);
>
> No need to manually destroy files when you remove a device.  But you
> will remove this file anyway for the next version of this patch, so it's
> not a big deal :)
:)
>
> > +     class_destroy(accel_class);
> > +     accel_class = NULL;
> > +}
> > +
> > +static int accel_stub_open(struct inode *inode, struct file *filp)
> > +{
> > +     DRM_DEBUG("Operation not supported");
>
> ftrace is wonderful, please use that and not hand-rolled custom "I am
> here!" type messages like this.
I'll just remove it as this line is being replaced anyway in the next patch.
Thanks,
Oded
>
> thanks,
>
> greg k-h
