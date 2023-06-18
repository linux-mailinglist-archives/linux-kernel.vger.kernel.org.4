Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3F4734906
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 00:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjFRWB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 18:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFRWB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 18:01:28 -0400
Received: from s.wrqvwxzv.outbound-mail.sendgrid.net (s.wrqvwxzv.outbound-mail.sendgrid.net [149.72.154.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96786C5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 15:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:mime-version:to:cc:content-transfer-encoding:
        content-type:cc:content-type:from:subject:to;
        s=s1; bh=kE3ug1FphWK8w4bAu88BIK2LQbxYxA5TL1gVPHRLq0s=;
        b=I18/eC+ZDPL1HZg9AUC1xf4aOdnDKuDMJNZrPnUxF/B8A44OdIN6YX9Y/GzODreQRsBJ
        q5fe/G5y0H+GJ9SIBrsnX87Gg79I/absjKEwql8LswxWeSJjREH0MtNEOMD3Z1DDOpMhKg
        D7xc4Au6vFseMsLWGbQhARkSavbLUlqRgqq+Hs0b2l0NLaXl9HtnkX9IYcnDNgvzX/2Max
        zhTbxBxVMx8vNt/Cl/SVszvlOsSocZVNqN4G/5wTxhEqULNbKkplpXQ02snOXMlK+R1/Az
        DVUs6Yf2kD5JX2LmIop7PApmABEePgUZcyB6VaWRLmGrIH0ZPweV5Z66/jQ9V1Ww==
Received: by filterdrecv-65f68489c8-zmlx4 with SMTP id filterdrecv-65f68489c8-zmlx4-1-648F7EB4-7C
        2023-06-18 22:01:25.078475909 +0000 UTC m=+3363925.214276436
Received: from bionic.localdomain (unknown)
        by geopod-ismtpd-5 (SG)
        with ESMTP
        id o9F54kvgToCDS4l4o5-IEA
        Sun, 18 Jun 2023 22:01:24.617 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v4 0/2] drm/rockchip: vop: Add NV15, NV20 and NV30 support
Date:   Sun, 18 Jun 2023 22:01:25 +0000 (UTC)
Message-Id: <20230618220122.3911297-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h2uRKfwUrnAuhEShj?=
 =?us-ascii?Q?yRo=2FdCt6XHj=2FoPJvO4UOauxEyTrAKiA2DU4+Gq+?=
 =?us-ascii?Q?lO9RCUbwfLMSCEL+PvsSkAWdCnDGx4lrxs0JTM6?=
 =?us-ascii?Q?JkRcC9bUwBS4FWuT=2F6RhbZ6rTH3uuLRFRwKJe5u?=
 =?us-ascii?Q?KGH1CVnPRaKR36iFzVgD6+RzZIvoU3a8jZos5l?=
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add support for displaying 10-bit 4:2:0 and 4:2:2 formats produced
by the Rockchip Video Decoder on RK322X, RK3288, RK3328, RK3368 and RK3399.
Also include 10-bit 4:4:4 support since VOP can support that also.

First patch adds new fourcc 10-bit YUV formats with 4:2:2/4:4:4 sub-sampling.
Second patch adds support for displaying the new fourcc formats.

These patches has been in use by LibreELEC and other distros for the
past 3+ years, hoping they can be merged this time around :-)

Changes in v4:
- Rework RK3328/RK3399 win0/1 data to not affect RK3368

Changes in v3:
- No changes, rebased on next-20230616
- R-B tags was collected

Changes in v2:
- Add NV30 format
- R-B tags was not collected due to NV30 changes

This series is also available at [1].

[1] https://github.com/Kwiboo/linux-rockchip/commits/next-20230616-vop-nv15

Jonas Karlman (2):
  drm/fourcc: Add NV20 and NV30 YUV formats
  drm/rockchip: vop: Add NV15, NV20 and NV30 support

 drivers/gpu/drm/drm_fourcc.c                |  8 +++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 29 +++++++++-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |  1 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 63 +++++++++++++++++----
 include/uapi/drm/drm_fourcc.h               |  2 +
 5 files changed, 91 insertions(+), 12 deletions(-)

-- 
2.40.1

