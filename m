Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE8861E1C3
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 11:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiKFK40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 05:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiKFK4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 05:56:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F31EC3B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 02:56:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFF3460BED
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 10:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6CBC433D6
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 10:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667732183;
        bh=P5+oK5y1DwgK+cZ5FV6rwH5/YDmYJLDEYA0g/u08A8E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aPwkX6c6CUAG++Y/NFl1aCaJL4kAldL8ZfDAbrBpQSHavM4g2AHZ1twp8lcCazMh5
         ZFUGOuL0JxDyfkIq/AqGxKaRtGC8ZwolOW8dS9l0pU2r7AFj/XVcdVHgsP8AI1NpmP
         sJdSEEnCiAd0bmoh1KYmrYaSn54czDN+caHmaD+azD9NDru+1STH/6mZAh5g6aDnwv
         5rDSMKCP7H6zHRU5rszvLWGbvjEcTVHVpBTh9R6Pr1zBCMAkjnLmS+EwXoAJ1rSSlz
         q/gQDcxwok8ldw9azBb7QkBJzfez2gpfi9dvATFaCpZ827L0Ic67vQW8FmYtjS7zkt
         I5y8fmeq57YcQ==
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-333a4a5d495so80429707b3.10
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 02:56:22 -0800 (PST)
X-Gm-Message-State: ACrzQf2HsIjtxUCAbNZZeut+TPhN7q/dzZALdALLI9f46mUzkkT4aw3Z
        lC8ya/rbkgQS6zCQZhDHRFc3oBQ9fZaaZueDC1c=
X-Google-Smtp-Source: AMsMyM6F5TjV3XEFGifBFFyTnxoEYOIx53CjGoI5BoOXmHjwgY51QZL2DiccNWXEsKvh28HauC6Coj1mObem968DBNQ=
X-Received: by 2002:a0d:f445:0:b0:345:89a2:9a8d with SMTP id
 d66-20020a0df445000000b0034589a29a8dmr41906097ywf.107.1667732182083; Sun, 06
 Nov 2022 02:56:22 -0800 (PST)
MIME-Version: 1.0
References: <20221102203405.1797491-1-ogabbay@kernel.org> <20221102203405.1797491-4-ogabbay@kernel.org>
 <b6faacac-46f2-7643-7796-b34840fc94f5@quicinc.com>
In-Reply-To: <b6faacac-46f2-7643-7796-b34840fc94f5@quicinc.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Sun, 6 Nov 2022 12:55:55 +0200
X-Gmail-Original-Message-ID: <CAFCwf11Fd6GZkmDi74TRVd2t3v7d0HTYSjLeEdM9UeK+fUofXw@mail.gmail.com>
Message-ID: <CAFCwf11Fd6GZkmDi74TRVd2t3v7d0HTYSjLeEdM9UeK+fUofXw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] drm: initialize accel framework
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

On Wed, Nov 2, 2022 at 11:30 PM Jeffrey Hugo <quic_jhugo@quicinc.com> wrote:
>
> On 11/2/2022 2:34 PM, Oded Gabbay wrote:
> > @@ -163,7 +174,11 @@ static int drm_minor_register(struct drm_device *dev, unsigned int type)
> >
> >       ret = drm_debugfs_init(minor, minor->index, drm_debugfs_root);
> >       if (ret) {
> > -             DRM_ERROR("DRM: Failed to initialize /sys/kernel/debug/dri.\n");
> > +             if (minor->type == DRM_MINOR_ACCEL)
> > +                     DRM_ERROR("DRM: Failed to initialize /sys/kernel/debug/accel.\n");
> > +             else
> > +                     DRM_ERROR("DRM: Failed to initialize /sys/kernel/debug/dri.\n");
> > +
> >               goto err_debugfs;
> >       }
> >
>
> This doesn't look right.  Don't you need to call drm_debugfs_init() with
> accel_debugfs_root for the case - minor->type == DRM_MINOR_ACCEL?
> Unless I fail to understand something, this will put all the accel
> devices under /sys/kernel/debug/dri
ofc, you are correct.
Will be fixed in v3.
Thanks,
Oded
