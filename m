Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79552731EB5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237663AbjFORKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237726AbjFORKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:10:49 -0400
Received: from s.wrqvtbkv.outbound-mail.sendgrid.net (s.wrqvtbkv.outbound-mail.sendgrid.net [149.72.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEEE268A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 10:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:mime-version:to:cc:content-transfer-encoding:
        content-type:cc:content-type:from:subject:to;
        s=s1; bh=/iMiHruchMZdH7EbKaXXVbEUNCDq8w9JXi9nEY/WsG0=;
        b=rO8/HnoE9YtWXVLmjXww+B4Qqmh2HHf+JnA+/rg1e9HzBFSKZgm2cRhwyyfazuNoVUPn
        lmPBmV28a01qMJEC2UaPnponVCxXOghiGItj+76wIWtPsVSTP8lT+CyzIaNa7LfN0obOnQ
        c5P6T5HViCabUuQQTnskaK/oVfH74EhBi5RUfzzEDu8LQUA9YrRP3ElfEyUijPZ/wW8u1U
        KC5W0RT+rlR5pK4OY6Mo30Q73x1IRAtIpq4gqTrqNYwy8Y4GSrRVgsNSvbSYMdLHI4UoNg
        Igc0NezKG+mcM0a3IFcbUFWcmBWgCKg3+ehe9bjaZWrsCzYJJzYJdTehv8HSteqQ==
Received: by filterdrecv-77869f68cc-l7kjz with SMTP id filterdrecv-77869f68cc-l7kjz-1-648B45F7-28
        2023-06-15 17:10:15.543950118 +0000 UTC m=+3087258.628411507
Received: from bionic.localdomain (unknown)
        by geopod-ismtpd-2 (SG)
        with ESMTP
        id nGTvoAPVSCO8vRsd_RsRfg
        Thu, 15 Jun 2023 17:10:15.220 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v4 0/6] Support more HDMI modes on RK3228/RK3328
Date:   Thu, 15 Jun 2023 17:10:15 +0000 (UTC)
Message-Id: <20230615171005.2251032-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h1XOkue=2FcxLltwil4?=
 =?us-ascii?Q?k2y4aiZwCJ7=2FvKmD3jebfAfZdtNcM7nB2rsB1rs?=
 =?us-ascii?Q?W2x6dmGJ+tvdv5r2Scmow9SIkrsu9+47Yx+0S0q?=
 =?us-ascii?Q?bPq+dH09IgJ4uBykHL6SJjed5=2F=2F=2FMox67SwypdX?=
 =?us-ascii?Q?4PEKGlxY6bY2ay6mCdBqEM2hoCt+eVwiVz4=2FUw?=
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Alex Bee <knaerzche@gmail.com>, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a revival of a 3+ year old series that never got picked up,
it contains fixes and adds support for more HDMI modes on RK3228/RK3328.

This v4 series contains the original v2/v3 patches targeting the inno
hdmi phy driver, the last patch that adds support for more HDMI modes
has been replaced with a new patch from Alex Bee.

Part of this has been reworked from vendor BSP 4.4 kernel commits.

Patch 1-5 fixes issues and shortcomings in the inno hdmi phy driver.

Patch 6 adds support for more pixel clock rates in order to support
common DMT modes in addition to CEA modes.

These patches has been in use by LibreELEC and other distros for the
past 3+ years, hoping they can be merged this time around :-)

Changes i v4:
- replace last patch

Changes in v3:
- split series
- drop drm and device tree changes

Changes in v2:
- collect acked-by tag
- drop the limit resolution width to 3840 patch

This series is also available at [1].

[1] https://github.com/Kwiboo/linux-rockchip/commits/next-20230615-inno-hdmi-phy

Regards,
Jonas

Alex Bee (1):
  phy/rockchip: inno-hdmi: add more supported pre-pll rates

Huicong Xu (1):
  phy/rockchip: inno-hdmi: force set_rate on power_on

Jonas Karlman (3):
  phy/rockchip: inno-hdmi: use correct vco_div_5 macro on rk3328
  phy/rockchip: inno-hdmi: remove unused no_c from rk3328 recalc_rate
  phy/rockchip: inno-hdmi: do not power on rk3328 post pll on reg write

Zheng Yang (1):
  phy/rockchip: inno-hdmi: round fractal pixclock in rk3328 recalc_rate

 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c | 234 +++++++++++++++---
 1 file changed, 198 insertions(+), 36 deletions(-)

-- 
2.40.1

