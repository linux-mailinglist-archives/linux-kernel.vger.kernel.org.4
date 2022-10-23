Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7787C6093D5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 16:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiJWOPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 10:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiJWOPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 10:15:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E589D3679E;
        Sun, 23 Oct 2022 07:14:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5836560E9E;
        Sun, 23 Oct 2022 14:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26165C433D6;
        Sun, 23 Oct 2022 14:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666534498;
        bh=+mgpn2SQZFBbWY8pcXjmHFWINFP2Fcvzsq9oNLuAra8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FXOUmEynkar7+9suRiSaDGsqrhExcPCQWcuZ02F2lHV81lSij4D7owi8jPtGyOHbp
         S9Q0BgY1vqRXZbFpFshca54aKYyBj4qztWYLsrXyTFLb+29BSLkvmZUeXcaIQUx4l3
         bks/URcMQfo//SjcnYRemKgHWw78itiqP59mHRl8=
Date:   Sun, 23 Oct 2022 16:14:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Oded Gabbay <ogabbay@kernel.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
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
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC PATCH 0/3] new subsystem for compute accelerator devices
Message-ID: <Y1VMX9J44FJZp0dl@kroah.com>
References: <20221022214622.18042-1-ogabbay@kernel.org>
 <Y1VJieGgVv9BwaO3@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1VJieGgVv9BwaO3@debian.me>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 09:02:49PM +0700, Bagas Sanjaya wrote:
> On Sun, Oct 23, 2022 at 12:46:19AM +0300, Oded Gabbay wrote:
> > In the last couple of months we had a discussion [1] about creating a new
> > subsystem for compute accelerator devices in the kernel.
> > 
> > After an analysis that was done by DRM maintainers and myself, and following
> > a BOF session at the Linux Plumbers conference a few weeks ago [2], we
> > decided to create a new subsystem that will use the DRM subsystem's code and
> > functionality. i.e. the accel core code will be part of the DRM subsystem.
> > 
> > This will allow us to leverage the extensive DRM code-base and
> > collaborate with DRM developers that have experience with this type of
> > devices. In addition, new features that will be added for the accelerator
> > drivers can be of use to GPU drivers as well (e.g. RAS).
> > 
> > As agreed in the BOF session, the accelerator devices will be exposed to
> > user-space with a new, dedicated device char files and a dedicated major
> > number (261), to clearly separate them from graphic cards and the graphic
> > user-space s/w stack. Furthermore, the drivers will be located in a separate
> > place in the kernel tree (drivers/accel/).
> > 
> > This series of patches is the first step in this direction as it adds the
> > necessary infrastructure for accelerator devices to DRM. The new devices will
> > be exposed with the following convention:
> > 
> > device char files - /dev/accel/accel*
> > sysfs             - /sys/class/accel/accel*/
> > debugfs           - /sys/kernel/debug/accel/accel*/
> > 
> > I tried to reuse the existing DRM code as much as possible, while keeping it
> > readable and maintainable.
> > 
> > One thing that is missing from this series is defining a namespace for the
> > new accel subsystem, while I'll add in the next iteration of this patch-set,
> > after I will receive feedback from the community.
> > 
> > As for drivers, once this series will be accepted (after adding the namespace),
> > I will start working on migrating the habanalabs driver to the new accel
> > subsystem. I have talked about it with Dave and we agreed that it will be
> > a good start to simply move the driver as-is with minimal changes, and then
> > start working on the driver's individual features that will be either added
> > to the accel core code (with or without changes), or will be removed and
> > instead the driver will use existing DRM code.
> > 
> > In addition, I know of at least 3 or 4 drivers that were submitted for review
> > and are good candidates to be included in this new subsystem, instead of being
> > a drm render node driver or a misc driver.
> > 
> > [1] https://lkml.org/lkml/2022/7/31/83
> > [2] https://airlied.blogspot.com/2022/09/accelerators-bof-outcomes-summary.html
> > 
> 
> Since this is new subsystem, it should have its own git tree where you
> collected accelerator-related patches.

No, that is never a requirement, where did you get that idea?

> By convention, there should be
> "next" branch targeting for next kernel release and "fixes" branch for
> bugfixes pending for current release. Both branches should be included
> into linux-next. The names don't necessarily be that, though.

Again, no, that has never been a requirement.

> Also, it had been great if you write short, descriptive documentation
> about the subsystem (maintainers handbook).

Also no, this is fine, it's an RFC sent to all of the people involved in
the discussions about this new subsystem.  The changelog here is totally
sufficient.

Please do not confuse people and ask them to do things that are not
requirements, that's not helpful at all.

greg k-h
