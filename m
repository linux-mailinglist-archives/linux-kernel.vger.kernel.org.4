Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DE161F3D9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiKGNBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiKGNBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:01:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9981C411
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 05:01:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AA7160F74
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 13:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7370C4314B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 13:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667826095;
        bh=lUkKGeRcTh9+9SDsnCQSKtY+GaKD9H0OWbszG978hiQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SVxy/PgMR6ttMpoY8TuKjEl1F7Wh/dW3/1R3mvAXjSle9/pwK7CWgZceEEIYkjtng
         uIFAd6OjoNOZXyFCbG1NTYQ3fjv46lrHoHYCISQTLs9vFcuepGn4dfCYomhxq8FgJZ
         KZFSbY33tPPTHNQhRse2bB7mhWup1TXgd9/DiOxnewHpUw+cFnQKFhulgiOBPANSO6
         b/RgpA3v+YeiGog7fVcwOsStRl5CUC4ojMEHprUDnbdDvGGQFfRIoAWtXqJhhGOM8U
         BBegn3HBid0jGqa7QiV/13jFUJ5Mm+5MKsOXtmma1igJtUn9Sfev2hVWz26Q9Txopl
         IAzRe/hUQ+BAg==
Received: by mail-yb1-f182.google.com with SMTP id 131so9092545ybl.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 05:01:35 -0800 (PST)
X-Gm-Message-State: ACrzQf2bGD6XP8W7fa9Vzczl/RqXjkZY4jRhrrgBDVSw8MqkwzVlR3PY
        IzWijuqN/oXvPnNK/J/oxNgXFZzflh1Q7f6FUpo=
X-Google-Smtp-Source: AMsMyM6kMAOKhCxiBtqGjN9Ku/e1kNsQnBUMowcJSFo2vUMahevwCtyGkyXu3Db6AdnKTs3gy17trTjMwVNHjuL7Sk0=
X-Received: by 2002:a25:1e89:0:b0:6bf:9e55:5cb4 with SMTP id
 e131-20020a251e89000000b006bf9e555cb4mr49430658ybe.642.1667826094690; Mon, 07
 Nov 2022 05:01:34 -0800 (PST)
MIME-Version: 1.0
References: <20221102203405.1797491-1-ogabbay@kernel.org> <20221102203405.1797491-2-ogabbay@kernel.org>
 <Y2MMCIe5wND2XPqE@kroah.com> <CAFCwf13uLj=P6u6FAcY8M5qAXoaBdb+Ha-TYj0j2FAZnFAPFYg@mail.gmail.com>
 <CAFCwf12yRUG4593ozJMEwaaJBKyWqXTTCjef9O_fzWdQBxVrtw@mail.gmail.com> <Y2kAcCu4z2LUMN7u@nvidia.com>
In-Reply-To: <Y2kAcCu4z2LUMN7u@nvidia.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Mon, 7 Nov 2022 15:01:08 +0200
X-Gmail-Original-Message-ID: <CAFCwf10K-dTu455QfOK8i6thismY-FUN2Rws830EGiqOcGWFgA@mail.gmail.com>
Message-ID: <CAFCwf10K-dTu455QfOK8i6thismY-FUN2Rws830EGiqOcGWFgA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] drivers/accel: define kconfig and register a
 new major
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
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
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        stanislaw.gruszka@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022 at 2:56 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Thu, Nov 03, 2022 at 10:39:36PM +0200, Oded Gabbay wrote:
> > On Thu, Nov 3, 2022 at 3:31 PM Oded Gabbay <ogabbay@kernel.org> wrote:
> > >
> > > On Thu, Nov 3, 2022 at 2:31 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Wed, Nov 02, 2022 at 10:34:03PM +0200, Oded Gabbay wrote:
> > > > > --- /dev/null
> > > > > +++ b/drivers/accel/Kconfig
> > > > > @@ -0,0 +1,24 @@
> > > > > +# SPDX-License-Identifier: GPL-2.0-only
> > > > > +#
> > > > > +# Compute Acceleration device configuration
> > > > > +#
> > > > > +# This framework provides support for compute acceleration devices, such
> > > > > +# as, but not limited to, Machine-Learning and Deep-Learning acceleration
> > > > > +# devices
> > > > > +#
> > > > > +menuconfig ACCEL
> > > > > +     tristate "Compute Acceleration Framework"
> > > > > +     depends on DRM
> > > > > +     help
> > > > > +       Framework for device drivers of compute acceleration devices, such
> > > > > +       as, but not limited to, Machine-Learning and Deep-Learning
> > > > > +       acceleration devices.
> > > > > +       If you say Y here, you need to select the module that's right for
> > > > > +       your acceleration device from the list below.
> > > > > +       This framework is integrated with the DRM subsystem as compute
> > > > > +       accelerators and GPUs share a lot in common and can use almost the
> > > > > +       same infrastructure code.
> > > > > +       Having said that, acceleration devices will have a different
> > > > > +       major number than GPUs, and will be exposed to user-space using
> > > > > +       different device files, called accel/accel* (in /dev, sysfs
> > > > > +       and debugfs)
> > > >
> > > > Module name if "M" is chosen?
> > > Will add
> > So, unfortunately, the path of doing accel as a kernel module won't
> > work cleanly (Thanks stanislaw for pointing this out to me).
> > The reason is the circular dependency between drm and accel. drm calls
> > accel exported symbols during init and when devices are registering
> > (all the minor handling), and accel calls drm exported symbols because
> > I don't want to duplicate the entire drm core code.
>
> I really don't think this is the right way to integrate with
> DRM. Accel should be a layer over top of DRM, not have these wakky
> co-dependencies.
>
> The fact you are running into stuff like this already smells really
> bad.
>
> Jason
I don't agree with your statement that it should be "a layer over top of DRM".
Anything on top of DRM is a device driver.
Accel is not a device driver, it is a new type of drm minor / drm driver.

Please look at v3 of the patch-set. There I abandoned the idea of
having accel as a separate module and instead it is part of drm.ko, as
it should be because it is just a new drm minor.

The only alternative imo to that is to abandon the idea of reusing
drm, and just make an independant accel core code.

Oded
