Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DEB617DE8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiKCN3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiKCN3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:29:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1E3647C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:29:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D99CAB827CF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 13:29:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFB3C43148
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 13:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667482150;
        bh=NBTXHeZbzlXiMhENl3g2+LKNqylGo+gAobQsaKkbE6o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hf28Sjru9tT+WFULq34ld1yEfOMfG+duNWqZGGI9uZ9bVKalnd8IPC7NPcr5XgiiZ
         V49Wcga0W2LprvcL/DQU29KMZs4qWCC3H5Hc+9enQNTEkqxjBev4bo7D4IZmzbHbQZ
         BOlxXgWv4y9cT41eqnC+QPwRtVfujMsckVkXGXWlxTzqpls10wyKj9ZnsmD4PnZwaX
         OGW8OIsESGmfypG2+OfZKK+tV3BejccjRnhGiqc/3aVe7VCP3sr7HsJTlCya1hb3d2
         CKf3xh4kWQk1GDuSFWjmn6kI61WevQ4bNrc9SHhytCttNNJUtAYYJb66T0gN8kIsC9
         FS+EyNGGTUz7A==
Received: by mail-yb1-f175.google.com with SMTP id j2so2199309ybb.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 06:29:10 -0700 (PDT)
X-Gm-Message-State: ACrzQf0Ok9OZJCpooJyb3G4UzkLbv00HJhzKYYnPv7B8IdNBb6mhZjwV
        /aEaON4cNn+15BVDS9UthDL3dduCz7Pm2+kBzUg=
X-Google-Smtp-Source: AMsMyM6/bmKCjDBSeXX5Wnu8eHuoV1vSAbE8aoKVY6aJCJ8f/rScgQ+XT+AOSqaZsYyIilSJ4nQDxM8sFCx+mllMZyQ=
X-Received: by 2002:a25:a4e4:0:b0:6cb:d9ba:b0b0 with SMTP id
 g91-20020a25a4e4000000b006cbd9bab0b0mr16767304ybi.68.1667482149440; Thu, 03
 Nov 2022 06:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221102203405.1797491-1-ogabbay@kernel.org> <20221102203405.1797491-2-ogabbay@kernel.org>
 <5979d266-e864-cc1c-fe2b-2c81f5223076@quicinc.com>
In-Reply-To: <5979d266-e864-cc1c-fe2b-2c81f5223076@quicinc.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Thu, 3 Nov 2022 15:28:43 +0200
X-Gmail-Original-Message-ID: <CAFCwf12J272cd+PzBagceocQoYLMPia9_1GobSkxwApM5+W1xA@mail.gmail.com>
Message-ID: <CAFCwf12J272cd+PzBagceocQoYLMPia9_1GobSkxwApM5+W1xA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] drivers/accel: define kconfig and register a
 new major
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
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 2, 2022 at 11:04 PM Jeffrey Hugo <quic_jhugo@quicinc.com> wrote:
>
> On 11/2/2022 2:34 PM, Oded Gabbay wrote:
> > diff --git a/drivers/accel/accel_drv.c b/drivers/accel/accel_drv.c
> > new file mode 100644
> > index 000000000000..6132765ea054
> > --- /dev/null
> > +++ b/drivers/accel/accel_drv.c
> > @@ -0,0 +1,112 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Copyright 2022 HabanaLabs, Ltd.
> > + * All Rights Reserved.
> > + *
> > + */
> > +
> > +#include <linux/module.h>
>
> Alphebetical order?
ok
>
> > +#include <linux/debugfs.h>
> > +#include <linux/device.h>
> > +
> > +#include <drm/drm_accel.h>
> > +#include <drm/drm_ioctl.h>
> > +#include <drm/drm_print.h>
> > +
> > +static struct dentry *accel_debugfs_root;
> > +struct class *accel_class;
>
> Static?
>
yes, thx.
