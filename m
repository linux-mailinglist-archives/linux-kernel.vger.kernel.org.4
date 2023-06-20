Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F927363CB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 08:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjFTGrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 02:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjFTGrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 02:47:48 -0400
Received: from s.wrqvtzvf.outbound-mail.sendgrid.net (s.wrqvtzvf.outbound-mail.sendgrid.net [149.72.126.143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B151704
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 23:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:mime-version:to:cc:content-transfer-encoding:
        content-type:cc:content-type:from:subject:to;
        s=s1; bh=/OiFg9zrUL7FLkxH5IitcBTJNO1C0qlvkkDfhUrYB7E=;
        b=OSZ64m+wuJFPFHqsz+9OOHnUMY4g9X4S6PuFLitLVqb3QIK47vi/CVlp/2/Ip6BRgW7S
        rfF4R+6I83EwBwvit78rji+e0k0wojC2PqiBNEASIcvT32oOdLlA75q0t43Wh6CF5FxycN
        s/jY6zDsS3q29oaNqqm4cQAxn2tnV2eNNSuWoPnBUUkm7jMiSo+5rPX17EwGFlDvHKrsOH
        Iwm+aA4z10w0VaBrb8mRPWTpmWiy2chcmI6oQ/nBUI0H/CAk+WzdXJIMwfd1ZaCd0Y9gf0
        Q07Q1ObxtXy+5zT7Szu5tsBTL04cvGOAIGqedaH5Go2antUvLrSHQP0I41jzpqAQ==
Received: by filterdrecv-8684c58db7-wf85l with SMTP id filterdrecv-8684c58db7-wf85l-1-64914B87-1
        2023-06-20 06:47:35.167912827 +0000 UTC m=+3481761.974497447
Received: from bionic.localdomain (unknown)
        by geopod-ismtpd-5 (SG)
        with ESMTP
        id PBMypHKAT3KFA1SgmOnoHA
        Tue, 20 Jun 2023 06:47:34.794 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/4] drm/rockchip: Fix crtc duplicate state and crtc reset
 funcs
Date:   Tue, 20 Jun 2023 06:47:35 +0000 (UTC)
Message-ID: <20230620064732.1525594-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0hyjMKERdf95KMPdLE?=
 =?us-ascii?Q?AIYz=2F9=2FCZufW1gBVLLc0p++89OiAC6+VYSCZLnn?=
 =?us-ascii?Q?0MwskFyyqsX3ZLfdoaTVik4Smb7c9wfYrBsfOSb?=
 =?us-ascii?Q?wU8e+Pz8SXbfZDXlq5iZfsnute6jP1K=2Fku0BQcL?=
 =?us-ascii?Q?lUMCvPjnhTWyx+I3VutkZXQt8Qxrh8z+dlVaCg?=
To:     Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Mark Yao <markyao0591@gmail.com>,
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
Patch 3 adds a crash guard for empty crtc state.
Patch 4 adds a missing call to crtc reset helper.

This is the next part of an ongoing effort to upstream HDMI 2.0 support
used in LibreELEC for the past 3+ years.

This series is also available at [1].

[1] https://github.com/Kwiboo/linux-rockchip/commits/next-20230619-duplicate-state

Jonas Karlman (4):
  drm/rockchip: vop: Fix crtc duplicate state
  drm/rockchip: vop: User cleanup helpers directly as destroy ops
  drm/rockchip: vop2: Don't crash for invalid duplicate_state
  drm/rockchip: vop2: Add missing call to crtc reset helper

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c  | 19 +++--------
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 36 +++++++++-----------
 2 files changed, 21 insertions(+), 34 deletions(-)

-- 
2.41.0

