Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E3462006B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbiKGVJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbiKGVId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:08:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC93317E4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 13:06:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D979B816AD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 21:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B4EC4314A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 21:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667855161;
        bh=FG+7gA3fo0nBgnUWGCQeGAlAZyW5OFNCbT+NPx+534Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JpohgfVyAR1+t0eosNFa2GRGTW/ULZtWnPLB9HZ4ROca8k1vdcW+0N4uupbl8pN+P
         1KDlG8cXBHfnTDBO0UoenwooMLqZ2jDiV/NQ5KYFbDAHxhdxfpS8BPcQl051fNy9sr
         Y7E9ROyXt/Pa4Vf7DzZf+7/T0MpN4JDqIIA3nuB689+ruPgF+fo+aQhxpLQNaYatFt
         m18e4l6EK0EMaBjtjYPCi22HUvSR0t8tCagZEMNn9U9xckoKmZj/8JkUOmT9ShOZRp
         aEGlH8ZuPpsgYlXzxoHgWRc2gSxgp7ivgguIFw8bayynJO6G5MG/WvnKvaCmhz+mwc
         xhcVROd4Kua2g==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-36ad4cf9132so116425397b3.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 13:06:01 -0800 (PST)
X-Gm-Message-State: ACrzQf2B5H+vX2Si4KsNjRJ0KGLC9cHFOagm6j+JJSrBzEqZTWywB96c
        JYfILg6wvUeVXTs6DoLVZq4qY3SY2aI+wO4T4eA=
X-Google-Smtp-Source: AMsMyM79s61mlOpK+aqg4QRkCgNPCYjUWTxYdxewoPhDlxrrkRVd1ChmX/dKJmqMS/UXAOUP9xQYEnEByOuJRijTw0k=
X-Received: by 2002:a0d:f445:0:b0:345:89a2:9a8d with SMTP id
 d66-20020a0df445000000b0034589a29a8dmr49016100ywf.107.1667855160878; Mon, 07
 Nov 2022 13:06:00 -0800 (PST)
MIME-Version: 1.0
References: <20221106210225.2065371-1-ogabbay@kernel.org> <20221106210225.2065371-2-ogabbay@kernel.org>
 <5fe8e8c0-d28b-3666-e437-10fa0c591ed8@quicinc.com>
In-Reply-To: <5fe8e8c0-d28b-3666-e437-10fa0c591ed8@quicinc.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Mon, 7 Nov 2022 23:05:34 +0200
X-Gmail-Original-Message-ID: <CAFCwf10iNhi7=O_c==0dzyiMVSL05R8bJQ1HPJJo04bwz86e=w@mail.gmail.com>
Message-ID: <CAFCwf10iNhi7=O_c==0dzyiMVSL05R8bJQ1HPJJo04bwz86e=w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/3] drivers/accel: define kconfig and register a
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
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022 at 6:12 PM Jeffrey Hugo <quic_jhugo@quicinc.com> wrote:
>
> On 11/6/2022 2:02 PM, Oded Gabbay wrote:
> > +int __init accel_core_init(void)
> > +{
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
> > +     ret = register_chrdev(ACCEL_MAJOR, "accel", &accel_stub_fops);
> > +     if (ret < 0)
> > +             goto error;
>
> We are not jumping over anything here.  Seems like this whole if block
> could just be removed.
correct, will be fixed.
>
> > +
> > +error:
> > +     /* Any cleanup will be done in drm_core_exit() that will call
> > +      * to accel_core_exit()
> > +      */
>
> This doesn't look like the standard multi-line comment style.  Are we
> going to say that the accel subsystem follows net and differs from the
> kernel standard?
I'll change it to the kernel standard.
Thx,
Oded
>
> > +     return ret;
> > +}
