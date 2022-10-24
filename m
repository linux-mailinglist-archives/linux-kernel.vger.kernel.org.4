Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B333B609B3D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiJXHYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiJXHYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:24:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151205C9F2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 00:24:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A65226103C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:24:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FC6C43148
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666596247;
        bh=oMp4bDmweM0zCRQHLAKdcIPSEe7hySM9WY0ly2HUhW0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FOHUHrXU0bSCZUrz8P+wq7MieRM/XVj6uCuOGtnmvw5euG2A9m8AA9JP4rrWpj/AS
         12fxLTdDMivX8I+OBOd2z8uTADBdgC/mmeQ1r5JRVKN7MCpKkWi9PFiN7rhLBRwZ3a
         hi06VhZqexpO1GhBGV/97oVBQPHxqmF/QdvfIUYuS0ybjO893vSdD6e5tBoel2aXF3
         NnTpaJsIzMoTVY4oQZRRgC0AVl5CI9FYc+5a8kCcDkxbLuLJwvkyRdJZMvguZRrJWW
         gKLZUiJOuDb4OGcEiZC9wt0iuhHWW3KxUyRPcXqea94NoVgH+kbMImrmvT3G0pG1mD
         n79UOcBDz4W0w==
Received: by mail-ed1-f54.google.com with SMTP id a67so27796801edf.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 00:24:07 -0700 (PDT)
X-Gm-Message-State: ACrzQf20FjBGu59tB/1iy8YlWNejXuv1ZaLO+VweeOI2d0LzJiIAhvuO
        KI/kkLvBRY6lxQjXCSDFNz/I0kTzHjt4vNfbTfo=
X-Google-Smtp-Source: AMsMyM4Z6rymPGvgTHgOsQf1d/yZ32NZ2glSwlHMcPQ3AwukVQi7Uhv315OjZE4oP6NxbcX3CqeJbJvUb9p4ikVehG0=
X-Received: by 2002:a05:6402:42c6:b0:45c:fc58:bd0f with SMTP id
 i6-20020a05640242c600b0045cfc58bd0fmr29969691edc.19.1666596245318; Mon, 24
 Oct 2022 00:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221022214622.18042-1-ogabbay@kernel.org> <20221022214622.18042-4-ogabbay@kernel.org>
 <Y1U2iBedfSzqTjer@kroah.com>
In-Reply-To: <Y1U2iBedfSzqTjer@kroah.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Mon, 24 Oct 2022 10:23:38 +0300
X-Gmail-Original-Message-ID: <CAFCwf126L5GZ52R7nayg8c-Avxpbv-rxAq+_q1OLw41jA5ow7A@mail.gmail.com>
Message-ID: <CAFCwf126L5GZ52R7nayg8c-Avxpbv-rxAq+_q1OLw41jA5ow7A@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] drm: add dedicated minor for accelerator devices
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

On Sun, Oct 23, 2022 at 3:41 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Oct 23, 2022 at 12:46:22AM +0300, Oded Gabbay wrote:
> > +/**
> > + * accel_open - open method for ACCEL file
> > + * @inode: device inode
> > + * @filp: file pointer.
> > + *
> > + * This function must be used by drivers as their &file_operations.open method.
> > + * It looks up the correct ACCEL device and instantiates all the per-file
> > + * resources for it. It also calls the &drm_driver.open driver callback.
> > + *
> > + * RETURNS:
> > + *
> > + * 0 on success or negative errno value on failure.
> > + */
> > +int accel_open(struct inode *inode, struct file *filp)
> > +{
> > +     struct drm_minor *minor;
> > +
> > +     minor = drm_minor_acquire(iminor(inode), true);
> > +     if (IS_ERR(minor))
> > +             return PTR_ERR(minor);
> > +
> > +     return __drm_open(inode, filp, minor);
> > +}
> > +EXPORT_SYMBOL(accel_open);
>
> EXPORT_SYMBOL_GPL() please.
>
> And again, this should probably to into drivers/accel/ not here.
Got it, will do.
Thanks,
Oded
>
> thanks,
>
> greg k-h
