Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B6D61E60C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 22:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiKFVCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 16:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiKFVCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 16:02:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940CCFADD
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 13:02:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4198AB80D17
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 21:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE5DC433D7;
        Sun,  6 Nov 2022 21:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667768553;
        bh=EXvwdhWEYV7UJ2h0xFwZgcbB4zy2TYFGbCvTW03tHYU=;
        h=From:To:Cc:Subject:Date:From;
        b=GprBHDGEFAa8bq7NcFH9F6bzocK/wwk4LpOUsP86Ft/pnzakOV/s7rhPdDIb4LvoB
         b6bMd37UQcYM80/6j6/hEp82DmnwLbT5qI0ba8NmhZGbm91FwwElyzR8BTsFQZwknL
         DJVjSPfYJSSlRtjvvz5INLEKCXy/W6Twpl3tCl1p/kmKLXLZFeV+VgU4+nepV7EbPW
         b3orOmpSRCucQ+nwO6glQMSnMKY5UA35GQb9DdH6P72CxJGNhedkAqo+SrnL0VSxL1
         4HUoyZs6G2FkbB59ucvGgI4gtwsMuZmxyz1tvjtVLSWAvSWV6QnYnT8AvjajVhIz2W
         +jnxmIcA88duA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [RFC PATCH v3 0/3] new subsystem for compute accelerator devices
Date:   Sun,  6 Nov 2022 23:02:22 +0200
Message-Id: <20221106210225.2065371-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the third version of the RFC following the comments given on the
second version, but more importantly, following testing done by the VPU
driver people and myself. We found out that there is a circular dependency
between DRM and accel. DRM calls accel exported symbols during init and when
accel devices are registering (all the minor handling), then accel calls DRM
exported symbols. Therefore, if the two components are compiled as modules,
there is a circular dependency.

To overcome this, I have decided to compile the accel core code as part of
the DRM kernel module (drm.ko). IMO, this is inline with the spirit of the
design choice to have accel reuse the DRM core code and avoid code
duplication.

Another important change is that I have reverted back to use IDR for minor
handling instead of xarray. This is because I have found that xarray doesn't
handle well the scenario where you allocate a NULL entry and then exchange it
with a real pointer. It appears xarray still considers that entry a "zero"
entry. This is unfortunate because DRM works that way (first allocates a NULL
entry and then replaces the entry with a real pointer).

I decided to revert to IDR because I don't want to hold up these patches,
as many people are blocked until the support for accel is merged. The xarray
issue should be fixed as a separate patch by either fixing the xarray code or
changing how DRM + ACCEL do minor id handling.

The patches are in the following repo:
https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/accel.git/log/?h=accel_v3

As in v2, The HEAD of that branch is a commit adding a dummy driver that
registers an accel device using the new framework. This can be served
as a simple reference. I have checked inserting and removing the dummy driver,
and opening and closing /dev/accel/accel0 and nothing got broken :)

v1 cover letter:
https://lkml.org/lkml/2022/10/22/544

v2 cover letter:
https://lore.kernel.org/lkml/20221102203405.1797491-1-ogabbay@kernel.org/T/

Thanks,
Oded.

Oded Gabbay (3):
  drivers/accel: define kconfig and register a new major
  accel: add dedicated minor for accelerator devices
  drm: initialize accel framework

 Documentation/admin-guide/devices.txt |   5 +
 MAINTAINERS                           |   8 +
 drivers/Kconfig                       |   2 +
 drivers/accel/Kconfig                 |  24 ++
 drivers/accel/drm_accel.c             | 322 ++++++++++++++++++++++++++
 drivers/gpu/drm/Makefile              |   1 +
 drivers/gpu/drm/drm_drv.c             | 102 +++++---
 drivers/gpu/drm/drm_file.c            |   2 +-
 drivers/gpu/drm/drm_sysfs.c           |  24 +-
 include/drm/drm_accel.h               |  97 ++++++++
 include/drm/drm_device.h              |   3 +
 include/drm/drm_drv.h                 |   8 +
 include/drm/drm_file.h                |  21 +-
 13 files changed, 582 insertions(+), 37 deletions(-)
 create mode 100644 drivers/accel/Kconfig
 create mode 100644 drivers/accel/drm_accel.c
 create mode 100644 include/drm/drm_accel.h

--
2.25.1

