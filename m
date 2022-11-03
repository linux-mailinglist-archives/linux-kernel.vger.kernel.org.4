Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BBD6189B0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 21:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiKCUkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 16:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiKCUkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:40:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A2014028
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 13:40:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F88561FEF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 20:40:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A94C43140
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 20:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667508003;
        bh=8A5DvzoRi1Bdtzf7W7j/gUi5tTR9+uK5q+GZ6lGwTHw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p//QClwV8y/uM9tYtpafsZogTTKSps8F/sE/RMxFAIr6E/g3g2NV9ODqxF20ZGxoS
         2+cWai+HG9TB4/6+mTltMT/sqsOfTUnJ/70Ggfst/VOejaE/dDV/kY6+84mPs6dzrh
         n+ek8FglqHDqxoCH0vBSZr6tI+vDt/Opa+M7lc77czMC/EB2RToxa/apOP16+lDP8h
         UrgwWbHH6vU3Y3O0FHAKW8WPM4Kayb8or7a40LV3JB+qhjFCCmk2usNYJjbZfNxAg6
         hLHgwpnYqACOdSErgov7J0x/kucdiEeYETVQghR63NWSkQ5hXiKyAm7CN/pwVdwI8d
         QwPITuH02vjig==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-3704852322fso26714257b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 13:40:03 -0700 (PDT)
X-Gm-Message-State: ACrzQf3GNHyWbfSF7SGxBjsPRduz+c0PmqmfU8oYWfmTXjI9JX8Bo6Rk
        ej+XHVFyfVtRJzk61+Ga9510vBiCRnbmCsMf2v4=
X-Google-Smtp-Source: AMsMyM4AppiZ5yG16T5S+vyeWvltrJ1MSfPLEx0hdL7lvqNIogE+iO0w06PWxJbVlJpszmYBlqqEe+9J9E3yweYTw7w=
X-Received: by 2002:a81:c11:0:b0:36a:bcf0:6340 with SMTP id
 17-20020a810c11000000b0036abcf06340mr30285263ywm.467.1667508002734; Thu, 03
 Nov 2022 13:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <20221102203405.1797491-1-ogabbay@kernel.org> <20221102203405.1797491-2-ogabbay@kernel.org>
 <Y2MMCIe5wND2XPqE@kroah.com> <CAFCwf13uLj=P6u6FAcY8M5qAXoaBdb+Ha-TYj0j2FAZnFAPFYg@mail.gmail.com>
In-Reply-To: <CAFCwf13uLj=P6u6FAcY8M5qAXoaBdb+Ha-TYj0j2FAZnFAPFYg@mail.gmail.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Thu, 3 Nov 2022 22:39:36 +0200
X-Gmail-Original-Message-ID: <CAFCwf12yRUG4593ozJMEwaaJBKyWqXTTCjef9O_fzWdQBxVrtw@mail.gmail.com>
Message-ID: <CAFCwf12yRUG4593ozJMEwaaJBKyWqXTTCjef9O_fzWdQBxVrtw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] drivers/accel: define kconfig and register a
 new major
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
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
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        stanislaw.gruszka@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 3, 2022 at 3:31 PM Oded Gabbay <ogabbay@kernel.org> wrote:
>
> On Thu, Nov 3, 2022 at 2:31 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Nov 02, 2022 at 10:34:03PM +0200, Oded Gabbay wrote:
> > > --- /dev/null
> > > +++ b/drivers/accel/Kconfig
> > > @@ -0,0 +1,24 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +#
> > > +# Compute Acceleration device configuration
> > > +#
> > > +# This framework provides support for compute acceleration devices, such
> > > +# as, but not limited to, Machine-Learning and Deep-Learning acceleration
> > > +# devices
> > > +#
> > > +menuconfig ACCEL
> > > +     tristate "Compute Acceleration Framework"
> > > +     depends on DRM
> > > +     help
> > > +       Framework for device drivers of compute acceleration devices, such
> > > +       as, but not limited to, Machine-Learning and Deep-Learning
> > > +       acceleration devices.
> > > +       If you say Y here, you need to select the module that's right for
> > > +       your acceleration device from the list below.
> > > +       This framework is integrated with the DRM subsystem as compute
> > > +       accelerators and GPUs share a lot in common and can use almost the
> > > +       same infrastructure code.
> > > +       Having said that, acceleration devices will have a different
> > > +       major number than GPUs, and will be exposed to user-space using
> > > +       different device files, called accel/accel* (in /dev, sysfs
> > > +       and debugfs)
> >
> > Module name if "M" is chosen?
> Will add
So, unfortunately, the path of doing accel as a kernel module won't
work cleanly (Thanks stanislaw for pointing this out to me).
The reason is the circular dependency between drm and accel. drm calls
accel exported symbols during init and when devices are registering
(all the minor handling), and accel calls drm exported symbols because
I don't want to duplicate the entire drm core code.

I'll keep this menuconfig to provide the ability to disable this code
for people who think it is too "experimental". And in the future, when
drivers will join this subsystem, they will need this place for their
kconfig.

Thanks,
Oded
