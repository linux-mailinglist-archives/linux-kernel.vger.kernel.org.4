Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210B564D508
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 02:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiLOB2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 20:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLOB2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 20:28:21 -0500
X-Greylist: delayed 373 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 14 Dec 2022 17:28:18 PST
Received: from mx.techtum.dev (unknown [51.15.50.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDD253EF7;
        Wed, 14 Dec 2022 17:28:18 -0800 (PST)
Received: from noop.highnet.com (ptr134.highnet.com [31.216.14.134])
        by mx.techtum.dev (Postfix) with ESMTPSA id C8F341F3A1;
        Thu, 15 Dec 2022 01:22:02 +0000 (UTC)
From:   "Haris M. Bhatti" <kernel@techtum.dev>
To:     gregkh@linuxfoundation.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Haris M. Bhatti" <kernel@techtum.dev>
Subject: [PATCH] drivers: staging: fbtft: Replace usage of udelay
Date:   Thu, 15 Dec 2022 01:37:46 +0000
Message-Id: <20221215013746.270404-1-kernel@techtum.dev>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.8 required=5.0 tests=BAYES_05,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,PDS_RDNS_DYNAMIC_FP,RCVD_IN_SBL_CSS,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch highlighted that use of udelay should be replaced by
usleep_range.
---
 drivers/staging/fbtft/fb_ra8875.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb_ra8875.c
index 398bdbf53c9a..75cf3bb18414 100644
--- a/drivers/staging/fbtft/fb_ra8875.c
+++ b/drivers/staging/fbtft/fb_ra8875.c
@@ -217,7 +217,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 	}
 	len--;
 
-	udelay(100);
+	usleep_range(100, 101);
 
 	if (len) {
 		buf = (u8 *)par->buf;
@@ -238,7 +238,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 
 	/* restore user spi-speed */
 	par->fbtftops.write = fbtft_write_spi;
-	udelay(100);
+	usleep_range(100, 101);
 }
 
 static int write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
-- 
2.38.1

