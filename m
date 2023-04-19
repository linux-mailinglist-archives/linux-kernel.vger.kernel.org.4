Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5400B6E7269
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 06:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjDSEtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 00:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjDSEs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 00:48:58 -0400
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A18358C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 21:48:57 -0700 (PDT)
Received: from localhost.localdomain (dynamic-acs-24-144-188-133.zoominternet.net [24.144.188.133])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4Q1Sx32wmTz4QRl;
        Wed, 19 Apr 2023 00:48:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1681879736; bh=Gmfd0VH07ebAbJo5N2MdbESb+FaZWQBUQcf1HmlmM8M=;
        h=From:To:Cc:Subject:Date;
        b=uzaf9emRxRU2ahzTOh4zJ0M8P5ra1LWvPArt+QGcZCyvVU/S8V6D8uJClq9pVdZPx
         y5yOeO7+JU5b1pdeihTS9TgzF0F6cPcUsYJ2bODEDAslOBAABAij1Ap6orpYlNIYMY
         sVYZhHRdx/uAzMEn5kWLIQ4pb21iebkDx0XmAhvU=
From:   Pierre Asselin <pa@panix.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Pierre Asselin <pa@panix.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] firmware/sysfb: Fix VESA format selection
Date:   Wed, 19 Apr 2023 00:48:34 -0400
Message-Id: <20230419044834.10816-1-pa@panix.com>
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
lfb_depth correctly for those modes.  Keep the computation but
set bits_per_pixel to lfb_depth if the latter is larger.

v2 fixes the warnings from a max3() macro with arguments of different
types;  split the bits_per_pixel assignment to avoid uglyfing the code
with too many typecasts.

Link: https://lore.kernel.org/r/4Psm6B6Lqkz1QXM@panix3.panix.com
Link: https://lore.kernel.org/r/20230412150225.3757223-1-javierm@redhat.com
Fixes: f35cd3fa7729 [firmware/sysfb: Fix EFI/VESA format selection]
Signed-off-by: Pierre Asselin <pa@panix.com>
---
 drivers/firmware/sysfb_simplefb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/sysfb_simplefb.c b/drivers/firmware/sysfb_simplefb.c
index 82c64cb9f531..358b792a8845 100644
--- a/drivers/firmware/sysfb_simplefb.c
+++ b/drivers/firmware/sysfb_simplefb.c
@@ -51,7 +51,8 @@ __init bool sysfb_parse_mode(const struct screen_info *si,
 	 *
 	 * It's not easily possible to fix this in struct screen_info,
 	 * as this could break UAPI. The best solution is to compute
-	 * bits_per_pixel here and ignore lfb_depth. In the loop below,
+	 * bits_per_pixel from the color bits, reserved bits and
+	 * reported lfb_depth, whichever is highest.  In the loop below,
 	 * ignore simplefb formats with alpha bits, as EFI and VESA
 	 * don't specify alpha channels.
 	 */
@@ -60,6 +61,7 @@ __init bool sysfb_parse_mode(const struct screen_info *si,
 					  si->green_size + si->green_pos,
 					  si->blue_size + si->blue_pos),
 				     si->rsvd_size + si->rsvd_pos);
+		bits_per_pixel= max(bits_per_pixel, (u32)si->lfb_depth);
 	} else {
 		bits_per_pixel = si->lfb_depth;
 	}

base-commit: 6a8f57ae2eb07ab39a6f0ccad60c760743051026
-- 
2.39.2

