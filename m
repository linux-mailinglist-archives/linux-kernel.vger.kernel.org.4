Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E179734456
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 00:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjFQWXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 18:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFQWXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 18:23:13 -0400
Received: from s.wrqvtzvf.outbound-mail.sendgrid.net (s.wrqvtzvf.outbound-mail.sendgrid.net [149.72.126.143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C2810E0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 15:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:mime-version:to:cc:content-transfer-encoding:
        content-type:cc:content-type:from:subject:to;
        s=s1; bh=3au+Er0OutWjHdL5XNw2ghh/+x9dzcZ5yBxaNAzWCcs=;
        b=Zx6HGT9dW2hdc3fiEyLevza+BIk+osm+szaxPTPjwaWqUEyqNYsWOvAadD3ZpW5es6OT
        G7B/SXlLVa7hlWcFT9I75ei1/2IbjjncwgGk3t5hemCw9fkqb1fHaNn2zKvWd/ZdgxUaGe
        c02AUi72UYORPq0c4KjntfXHM0Xa2bMDadN936xTUWj0ayFzFcEQrOKZPVUDUeu281XLpn
        kEVOXfP2JiZnqiCkFIU8ToJ2bbL6LqbKw5Je7nj6iL5C4zTbpiF/WfRTygUTbqAfhvNLWZ
        gz9OC3Smbr5lV9YDXAfqiNSBQxrNvdddwc0qJUzN+eNGopZaTeOj9M/yJOxEgTUw==
Received: by filterdrecv-66949dbc98-4lpsw with SMTP id filterdrecv-66949dbc98-4lpsw-1-648E324E-8
        2023-06-17 22:23:10.893674033 +0000 UTC m=+3278604.170816701
Received: from bionic.localdomain (unknown)
        by geopod-ismtpd-1 (SG)
        with ESMTP
        id UU_EZyFMTgSb0INFqVrbVQ
        Sat, 17 Jun 2023 22:23:10.470 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 0/2] drm/rockchip: vop: Add NV15, NV20 and NV30 support
Date:   Sat, 17 Jun 2023 22:23:11 +0000 (UTC)
Message-Id: <20230617222307.3145714-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0hwz2osmywJU4M0tj7?=
 =?us-ascii?Q?uo2KBjgsske2Ia2ljLgAD00R1w8G2DQk=2FmiOEYJ?=
 =?us-ascii?Q?caybrQsIV3sbFEXe69l57US9Vi5TwOjTVJVusSy?=
 =?us-ascii?Q?vjDeT2VZ8etFV3nFQ7HEPALJVXKReJCGtHB1WjW?=
 =?us-ascii?Q?pZ+6SKOIYN932JYAJ=2FBErcDBWQWVsaBjdY8RVd?=
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
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a revival of a 3 year old series that never got picked up, see [1].

This series add support for displaying 10-bit 4:2:0 and 4:2:2 formats produced
by the Rockchip Video Decoder on RK322X, RK3288, RK3328, RK3368 and RK3399.
Also include 10-bit 4:4:4 support since VOP can support that also.

First patch adds new fourcc 10-bit YUV formats with 4:2:2/4:4:4 sub-sampling.
Second patch adds support for displaying the new fourcc formats.

These patches has been in use by LibreELEC and other distros for the
past 3+ years, hoping they can be merged this time around :-)

Changes in v3:
- No changes, rebased on next-20230616
- R-B tags was collected

Changes in v2:
- Add NV30 format
- R-B tags was not collected due to NV30 changes

This series is also available at [2].

[1] https://lore.kernel.org/all/20200706223009.1200-1-jonas@kwiboo.se/
[2] https://github.com/Kwiboo/linux-rockchip/commits/next-20230616-vop-nv15

Jonas Karlman (2):
  drm/fourcc: Add NV20 and NV30 YUV formats
  drm/rockchip: vop: Add NV15, NV20 and NV30 support

 drivers/gpu/drm/drm_fourcc.c                |  8 ++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 29 +++++++++++++++++--
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |  1 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 32 +++++++++++++++++----
 include/uapi/drm/drm_fourcc.h               |  2 ++
 5 files changed, 64 insertions(+), 8 deletions(-)

-- 
2.40.1

