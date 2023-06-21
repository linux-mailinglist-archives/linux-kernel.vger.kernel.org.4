Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50231739288
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 00:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjFUWdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 18:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjFUWdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 18:33:18 -0400
Received: from s.wrqvtzvf.outbound-mail.sendgrid.net (s.wrqvtzvf.outbound-mail.sendgrid.net [149.72.126.143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9577173F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 15:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:mime-version:to:cc:content-transfer-encoding:
        content-type:cc:content-type:from:subject:to;
        s=s1; bh=Pv1U1EEqpR4gm7kxbWZCerK7wt2q95EyqJhSl+womJE=;
        b=FkXsUOsXaFkwZrliDf9C2YwjNTIUEVvciEnSKJ9DTDBt+k27cbXeShchjqIG62qoBEXH
        b0W+UdYOsXPSNmZl5/Pa8sDZfJN5aeForP98D+/3H6KELBuaDRZL2xHCv6G3oK6M/dQmyK
        AMXMyqWZr86H/epaKAB4V5YO6jAJtDnPWYeG4EX3ygxWvztz3IhdGcfbov+QuCNbGM+LFl
        lFhpBrEdkWwITScZKCVx/GAr3/k1aFutWnpGJzunVRusb7gmRM6uuMYpj8CKxUYbLSu4oG
        i8u8jJfV7em/W//1XTI598X82qwaAx4/LdMfQCu/XA2/mKmYkdUdxX1yww99Iarw==
Received: by filterdrecv-65f68489c8-b6w8z with SMTP id filterdrecv-65f68489c8-b6w8z-1-64937AAA-5C
        2023-06-21 22:33:15.071715387 +0000 UTC m=+3625023.840218965
Received: from bionic.localdomain (unknown)
        by geopod-ismtpd-0 (SG)
        with ESMTP
        id Vsg4Okx2QpydLWx1dvgG5Q
        Wed, 21 Jun 2023 22:33:14.503 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/5] drm/rockchip: Fix crtc duplicate state and crtc reset
 funcs
Date:   Wed, 21 Jun 2023 22:33:15 +0000 (UTC)
Message-ID: <20230621223311.2239547-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0hwAj6JtqDVdUtl=2Fsv?=
 =?us-ascii?Q?EfHTEBPZGZPV0oT8N0cvVyWZgOlphJJAE1JguJu?=
 =?us-ascii?Q?Hu+WRw0387JHRl7AW9o30oWLdB+uU37bxzHe3L1?=
 =?us-ascii?Q?tAYAhOs6OWJswLf1+CsvL1B7NBMxMnDq2zNxVzK?=
 =?us-ascii?Q?2K+k2+1NKGxTJKJlqtaAGk5uSkxAqzt3zWxvQ=2F?=
To:     Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Mark Yao <markyao0591@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes a reset of state in duplicate state crtc funcs for VOP
driver, a possible crash and ensure crtc reset helper is called in VOP2
driver.

Patch 1 use kmemdup instead of kzalloc to duplicate the crtc state.
Patch 2 change to use crtc and plane cleanup helpers directly.
Patch 3 adds a null guard for allocation failure.
Patch 4 adds a crash guard for empty crtc state.
Patch 5 adds a missing call to crtc reset helper.

This is the next part of an ongoing effort to upstream HDMI 2.0 support
used in LibreELEC for the past 3+ years.

Changes in v2:
- Handle possible allocation failure in crtc reset funcs
- Collect r-b tags

This series is also available at [1].

[1] https://github.com/Kwiboo/linux-rockchip/commits/next-20230621-duplicate-state

Jonas Karlman (5):
  drm/rockchip: vop: Fix reset of state in duplicate state crtc funcs
  drm/rockchip: vop: Use cleanup helper directly as destroy funcs
  drm/rockchip: vop: Fix call to crtc reset helper
  drm/rockchip: vop2: Don't crash for invalid duplicate_state
  drm/rockchip: vop2: Add missing call to crtc reset helper

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c  | 24 +++++-------
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 39 ++++++++++----------
 2 files changed, 28 insertions(+), 35 deletions(-)

-- 
2.41.0

