Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A0F609B3B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiJXHXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiJXHXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:23:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE605C9C4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 00:23:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09AF76101E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E31C43149
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666596218;
        bh=+tGECJw0KWuji/MrGRLX10JD3/o6ij3Z0NBM4iKiq+I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NpuE3gaAeXsUvwGw4jso1bFBffavqwZ81byZqVDENFhV6+SBomHw4x6ZMp/3Faew3
         9yXQ0rRSJaTdIpUlCTc2xNdoqsCbDBzzBE8XMk4We+UBB60KGiSYVT1ZNKmGM9ev49
         MxpQZG/Gd5HQNUSzQfLuGNmBdBy+vah/r+IaJbCnOdTa7bWrlU1hb2Emz7hG1YYigX
         goaol77VLNeQ/xlTrlzRyApamzQH1sYNl8+sLzvpMPfDFpt5gVe+WPbQOafQLwiHfy
         g7BjTt8bwBHXcqx7s8woq+9PddSYB3ou/NChnzOhF2xr3BTvQANvkr2AK5/pfAPEZk
         8Gq43QF7mcBoA==
Received: by mail-ed1-f46.google.com with SMTP id m16so27722594edc.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 00:23:38 -0700 (PDT)
X-Gm-Message-State: ACrzQf3RJ9g2OoXbXGyW1W0rUVq1h2dvEDNz3EE9+fwqac7hvyS9f5ds
        qJEkCZPGHtoseEz1Y2Pf6RVpOcSkjnzwsgms5OM=
X-Google-Smtp-Source: AMsMyM6DGYlSCvCdIa2Qv3nNMB+zrgeJbC4qks//K4OI933BXcTDRbe+Fc8B1FKqMjlvT6oj4QYACx3SPlbcSlXM3Iw=
X-Received: by 2002:a17:906:8a52:b0:78d:b6db:149d with SMTP id
 gx18-20020a1709068a5200b0078db6db149dmr26144824ejc.733.1666596216553; Mon, 24
 Oct 2022 00:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <20221022214622.18042-1-ogabbay@kernel.org> <20221022214622.18042-3-ogabbay@kernel.org>
 <Y1U2K+fAnGbYug/+@kroah.com>
In-Reply-To: <Y1U2K+fAnGbYug/+@kroah.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Mon, 24 Oct 2022 10:23:10 +0300
X-Gmail-Original-Message-ID: <CAFCwf11PxtcRZegVBxYfJQFpYO0AipobJXWWp4ch+7mMKRLuKg@mail.gmail.com>
Message-ID: <CAFCwf11PxtcRZegVBxYfJQFpYO0AipobJXWWp4ch+7mMKRLuKg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] drm: define new accel major and register it
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
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 3:40 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Oct 23, 2022 at 12:46:21AM +0300, Oded Gabbay wrote:
> > The accelerator devices will be exposed to the user space with a new,
> > dedicated major number - 261.
> >
> > The drm core registers the new major number as a char device and create
> > corresponding sysfs and debugfs root entries, same as for the drm major.
> >
> > In case CONFIG_ACCEL is not selected, this code is not compiled in.
> >
> > Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
> > ---
> >  Documentation/admin-guide/devices.txt |  5 +++
> >  drivers/gpu/drm/drm_drv.c             | 45 +++++++++++++++++++++++
> >  drivers/gpu/drm/drm_internal.h        |  3 ++
> >  drivers/gpu/drm/drm_sysfs.c           | 52 +++++++++++++++++++++++++++
> >  include/drm/drm_ioctl.h               |  1 +
> >  5 files changed, 106 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
> > index 9764d6edb189..06c525e01ea5 100644
> > --- a/Documentation/admin-guide/devices.txt
> > +++ b/Documentation/admin-guide/devices.txt
> > @@ -3080,6 +3080,11 @@
> >                 ...
> >                 255 = /dev/osd255     256th OSD Device
> >
> > + 261 char    Compute Acceleration Devices
> > +               0 = /dev/accel/accel0 First acceleration device
> > +               1 = /dev/accel/accel1 Second acceleration device
> > +                 ...
> > +
> >   384-511 char        RESERVED FOR DYNAMIC ASSIGNMENT
> >               Character devices that request a dynamic allocation of major
> >               number will take numbers starting from 511 and downward,
> > diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> > index 8214a0b1ab7f..b58ffb1433d6 100644
> > --- a/drivers/gpu/drm/drm_drv.c
> > +++ b/drivers/gpu/drm/drm_drv.c
> > @@ -67,6 +67,10 @@ static bool drm_core_init_complete;
> >
> >  static struct dentry *drm_debugfs_root;
> >
> > +#ifdef CONFIG_ACCEL
> > +static struct dentry *accel_debugfs_root;
> > +#endif
> > +
> >  DEFINE_STATIC_SRCU(drm_unplug_srcu);
> >
> >  /*
> > @@ -1031,9 +1035,19 @@ static const struct file_operations drm_stub_fops = {
> >       .llseek = noop_llseek,
> >  };
> >
> > +static void accel_core_exit(void)
> > +{
> > +#ifdef CONFIG_ACCEL
> > +     unregister_chrdev(ACCEL_MAJOR, "accel");
> > +     debugfs_remove(accel_debugfs_root);
> > +     accel_sysfs_destroy();
> > +#endif
> > +}
>
> Why is all of this in drm_drv.c?
>
> Why not put it in drm/accel/accel.c or something like that?  Then put
> the proper stuff into a .h file and then you have no #ifdef in the .c
> files.
I thought about that, adding an accel.c in drivers/accel/ and putting
this code there.
Eventually I thought that for two functions it's not worth it, but I
guess that in addition to the reason you gave, one can argue that
there will probably be more code in that file anyway, so why not open
it now.
I'll change this if no one else thinks otherwise.
Oded

>
> Keeping #ifdef out of C files is key, please do not do things like you
> have here.  Especially as it ends up with this kind of mess:
>
> > +static int __init accel_core_init(void)
> > +{
> > +#ifdef CONFIG_ACCEL
> > +     int ret;
> > +
> > +     ret = accel_sysfs_init();
> > +     if (ret < 0) {
> > +             DRM_ERROR("Cannot create ACCEL class: %d\n", ret);
> > +             goto error;
> > +     }
> > +
> > +     accel_debugfs_root = debugfs_create_dir("accel", NULL);
> > +
> > +     ret = register_chrdev(ACCEL_MAJOR, "accel", &drm_stub_fops);
> > +     if (ret < 0)
> > +             goto error;
> > +
> > +error:
> > +     /* Any cleanup will be done in drm_core_exit() that will call
> > +      * to accel_core_exit()
> > +      */
> > +     return ret;
> > +#else
> > +     return 0;
> > +#endif
> > +}
>
>
> That's just a mess.
>
> thanks,
>
> greg k-h
