Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDBA6A2FEB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 15:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjBZOTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 09:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjBZOTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 09:19:17 -0500
Received: from forward105j.mail.yandex.net (forward105j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBCB976F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 06:19:16 -0800 (PST)
Received: from iva2-656890eaceb5.qloud-c.yandex.net (iva2-656890eaceb5.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:6902:0:640:6568:90ea])
        by forward105j.mail.yandex.net (Yandex) with ESMTP id E15C54EC884D;
        Sun, 26 Feb 2023 17:11:14 +0300 (MSK)
Received: by iva2-656890eaceb5.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id tATvDFdaca61-J9iv9dTu;
        Sun, 26 Feb 2023 17:11:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lach.pw; s=mail; t=1677420673;
        bh=tAhynSMDZaX+iE0zy9k7GywiZkOsJcg+z8IRMMvTpoY=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=TR1CW72vBYYFefZkrQMYOD+4ie7UrqgZUN7ogmOXv2lTkyg7MNIhcqr5SQ3d5LUAg
         JMbaDFI29RSQ7d4BFUoqQYEIjrJ8cVobYe3F4KRLGmHI06RsVAkkAHemJeNq+UMMRg
         kgoQowo48Otam6wrTvxWqqayZJBvwuK9JHdmdaAI=
Authentication-Results: iva2-656890eaceb5.qloud-c.yandex.net; dkim=pass header.i=@lach.pw
From:   Yaroslav Bolyukin <iam@lach.pw>
To:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@intel.com>,
        Yaroslav Bolyukin <iam@lach.pw>
Subject: [PATCH v3] drm/edid DSC pass-through timing support
Date:   Sun, 26 Feb 2023 15:10:49 +0100
Message-Id: <20230226141051.21767-1-iam@lach.pw>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VESA DisplayID spec allows the device to force its DSC bits per pixel
value.

For example, the HTC Vive Pro 2 VR headset uses this value in
high-resolution modes (3680x1836@90-120, 4896x2448@90-120), and when the
kernel doesn't respect this parameter, the garbage is displayed on HMD
instead.

I am unaware of any other hardware using this value; however, multiple
users have tested this patch on the Vive Pro 2, and it is known to work and
not break anything else.

Regarding driver support - I have looked at amdgpu and Nvidia's
open-gpu-kernel-modules, and both seem to have some indication for this
value; however, in Linux, it is unused in both. 

Amdgpu integration was trivial, so I implemented it in the second patch;
other kernel drivers still need the support of this value, and I don't have
the necessary hardware to implement and test the handling of this value on
them.

BR,
Yaroslav

Yaroslav Bolyukin (2):
  drm/edid: parse DRM VESA dsc bpp target
  drm/amd: use fixed dsc bits-per-pixel from edid

 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  2 +
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  2 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  3 ++
 drivers/gpu/drm/drm_edid.c                    | 42 ++++++++++++-------
 include/drm/drm_connector.h                   |  6 +++
 include/drm/drm_displayid.h                   |  4 ++
 6 files changed, 45 insertions(+), 14 deletions(-)


base-commit: a48bba98380cb0b43dcd01d276c7efc282e3c33f
--
2.39.1
