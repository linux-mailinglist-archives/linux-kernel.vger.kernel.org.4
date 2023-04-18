Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B126E6C23
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 20:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbjDRSew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 14:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjDRSev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:34:51 -0400
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEBC59FE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 11:34:50 -0700 (PDT)
Received: from localhost.localdomain (dynamic-acs-24-144-188-133.zoominternet.net [24.144.188.133])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4Q1CJS0Dh5z3vh7;
        Tue, 18 Apr 2023 14:34:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1681842888; bh=HVoOAOXiW8FIexKIWfy7EdgUgQ8uzlULpDO2G8mraJI=;
        h=From:To:Cc:Subject:Date;
        b=ZYCWUMKCkO+hDrx6755Jtj/I8kTXaA8G5kNO5NjR/stDlUW0YIteInSz3MPoq5Q1T
         zNe6UIXNKeOph1Bolao0DCHHtzFkjp2l6SPCh856BaLFpfNGzbMc5L1QmAe1nNkMqe
         ZdO9peT/rKUnE2Nkg8zmZLWkZj/KuB2yXEcewlc4=
From:   Pierre Asselin <pa@panix.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Pierre Asselin <pa@panix.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] firmware/sysfb: Fix VESA format selection
Date:   Tue, 18 Apr 2023 14:33:25 -0400
Message-Id: <20230418183325.2327-1-pa@panix.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some legacy BIOSes report no reserved bits in their 32-bit rgb mode,
breaking the calculation of bits_per_pixel in commit f35cd3fa7729
[firmware/sysfb: Fix EFI/VESA format selection].  However they report
lfb_depth correctly for those modes.  Recompute bits_per_pixel from the
color and reserved bit numbers and positions, but also from lfb_depth,
keeping the larger result.

Link: https://lore.kernel.org/r/4Psm6B6Lqkz1QXM@panix3.panix.com
Link: https://lore.kernel.org/r/20230412150225.3757223-1-javierm@redhat.com
Fixes: f35cd3fa7729 [firmware/sysfb: Fix EFI/VESA format selection]
Signed-off-by: Pierre Asselin <pa@panix.com>
---
 drivers/firmware/sysfb_simplefb.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/sysfb_simplefb.c b/drivers/firmware/sysfb_simplefb.c
index 82c64cb9f531..05dc25a524c8 100644
--- a/drivers/firmware/sysfb_simplefb.c
+++ b/drivers/firmware/sysfb_simplefb.c
@@ -51,15 +51,17 @@ __init bool sysfb_parse_mode(const struct screen_info *si,
 	 *
 	 * It's not easily possible to fix this in struct screen_info,
 	 * as this could break UAPI. The best solution is to compute
-	 * bits_per_pixel here and ignore lfb_depth. In the loop below,
+	 * bits_per_pixel from the color bits, reserved bits and
+	 * reported lfb_depth, whichever is highest.  In the loop below,
 	 * ignore simplefb formats with alpha bits, as EFI and VESA
 	 * don't specify alpha channels.
 	 */
 	if (si->lfb_depth > 8) {
-		bits_per_pixel = max(max3(si->red_size + si->red_pos,
+		bits_per_pixel = max3(max3(si->red_size + si->red_pos,
 					  si->green_size + si->green_pos,
 					  si->blue_size + si->blue_pos),
-				     si->rsvd_size + si->rsvd_pos);
+				     si->rsvd_size + si->rsvd_pos,
+				     si->lfb_depth);
 	} else {
 		bits_per_pixel = si->lfb_depth;
 	}
-- 
2.39.2

