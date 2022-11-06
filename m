Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE2361E1C1
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 11:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiKFKyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 05:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiKFKyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 05:54:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D684D11F
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 02:54:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3BD47B80B34
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 10:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4E1C43146
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 10:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667732073;
        bh=DGWITShguY2YvDwT2F/Zt1p4K6E4TZdBWjm0qvd7Y5c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jtg3YNva6eR97+CKcl2lU4MZakiRXGxBnD8cqRXo2jA3ubAsAokvwHJHoxI5Q6ckr
         xxgWcqTnT2MSmSpKhhnM7EKt7eWZqlmB13PGa+bqTL9e4zpY7LhNdqJnH4/Dvztq3R
         TeO+JbCAD6DB2mFqDuIOtIyngVklXLzX060KDMUSD3e+C44DBRwUpT4fWcl1duQTQY
         p/G64KpiN/F4dB/+x4j6CO36Ktj7p1x+trI7fHQlmuJ8owjfoOOpQmPemOPIe6Q4Zy
         MvqyIq95aIK9M+RIPI3yxaQEu1bRUJ+OS4usLPCA4imQctMwY9xe4Y+fzYU9HAZv6u
         aRRddZEuTgt5A==
Received: by mail-yb1-f178.google.com with SMTP id 63so10569128ybq.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 02:54:33 -0800 (PST)
X-Gm-Message-State: ACrzQf0j4RdNI+j2xrqzCYUoolvGZjqyhj2x09ur/fSgEqG0jRVok3F9
        BUNBtqERIoxayP6FTLhJDs1vVheCtXVst0dlK4g=
X-Google-Smtp-Source: AMsMyM4FcFut+LU4VdTnrVzBfv6cltrpShWVNbuucVGQUt4hr2pnnb6JqFc2yeeMG3KRDMdP48BI892EZF4vx48UqWM=
X-Received: by 2002:a25:1e89:0:b0:6bf:9e55:5cb4 with SMTP id
 e131-20020a251e89000000b006bf9e555cb4mr44196756ybe.642.1667732072872; Sun, 06
 Nov 2022 02:54:32 -0800 (PST)
MIME-Version: 1.0
References: <20221102203405.1797491-1-ogabbay@kernel.org> <CGME20221102203430epcas1p380845d7a6ebc38ab1f41acf8c48a4480@epcas1p3.samsung.com>
 <20221102203405.1797491-3-ogabbay@kernel.org> <20221103142554.6310a60f0f6dad1a59fa7644@samsung.com>
In-Reply-To: <20221103142554.6310a60f0f6dad1a59fa7644@samsung.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Sun, 6 Nov 2022 12:54:06 +0200
X-Gmail-Original-Message-ID: <CAFCwf124PAis_PJjswUdGbpRJ=SGsPpAOQbjuRzvfM7VZyS8Dg@mail.gmail.com>
Message-ID: <CAFCwf124PAis_PJjswUdGbpRJ=SGsPpAOQbjuRzvfM7VZyS8Dg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/3] accel: add dedicated minor for accelerator devices
To:     Jiho Chu <jiho.chu@samsung.com>
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
        Daniel Stone <daniel@fooishbar.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
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

On Thu, Nov 3, 2022 at 7:26 AM Jiho Chu <jiho.chu@samsung.com> wrote:
>
> On Wed,  2 Nov 2022 22:34:04 +0200
> Oded Gabbay <ogabbay@kernel.org> wrote:
>
> > +/**
> > + * accel_open - open method for ACCEL file
> > + * @inode: device inode
> > + * @filp: file pointer.
> > + *
> > + * This function must be used by drivers as their &file_operations.open method.
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
>
> Hi,
> It needs to consider drm_global_mutex to access open_count.
> please check doxy of open_count.
Now that I'm changing the code back to be part of drm.ko, I can return
all the code that is in drm_copy which I removed for this to compile.

>
>
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
> > +
> >  static int accel_stub_open(struct inode *inode, struct file *filp)
> >  {
> > -     DRM_DEBUG("Operation not supported");
> > +     const struct file_operations *new_fops;
> > +     struct drm_minor *minor;
> > +     int err;
> > +
> > +     DRM_DEBUG("\n");
>
> It seems useless.
Correct, I removed it in v3.
Thanks,
Oded
>
> Thanks.
> Jiho Chu
