Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662696E5387
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 23:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjDQVAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 17:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjDQU7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 16:59:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47854D319
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 13:57:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D682762A71
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 20:56:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0F9C4339B;
        Mon, 17 Apr 2023 20:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681765019;
        bh=GsJ+PxyTSnYDGmLARig0264/+VJ67ApwAzYJ119+iSo=;
        h=From:To:Cc:Subject:Date:From;
        b=nNatzqFHmOQ057sTK5UQ0wFqiCQjllH8w0mjnxyxRPlfJsHBhuPXHefHqjInEH4AF
         nulbc2rGyqnAWGzjW6V0YKevxeCLXOL8eAXvgSNhRb+ukhcMvfqKY1urg0P2VRvXWg
         3hxjk0TJmgcsKe++pVJcahc2qD9SjKYg2jhlP5UGERc8J3BodkS2nHWW9YKCAMKsdU
         nj6Z486FHooltVb23ucWjyx4fcaOFIl0c6m6X0u7FI4sP5lYW+cIbC/uFhbhkM1k1N
         lyN4WUD9hNmoI/z2V2LQnnlAuMuMII3zGoxtafcFjdpbESky0FBzIz/httvFFSFlaX
         2U9g4u1Uci3Cg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mtdchar: mark bits of ioctl handler noinline
Date:   Mon, 17 Apr 2023 22:56:50 +0200
Message-Id: <20230417205654.1982368-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The addition of the mtdchar_read_ioctl() function caused the stack usage
of mtdchar_ioctl() to grow beyond the warning limit on 32-bit architectures
with gcc-13:

drivers/mtd/mtdchar.c: In function 'mtdchar_ioctl':
drivers/mtd/mtdchar.c:1229:1: error: the frame size of 1488 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

Mark both the read and write portions as noinline_for_stack to ensure
they don't get inlined and use separate stack slots to reduce the
maximum usage, both in the mtdchar_ioctl() and combined with any
of its callees.

Fixes: 095bb6e44eb1 ("mtdchar: add MEMREAD ioctl")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mtd/mtdchar.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index 01f1c6792df9..8dc4f5c493fc 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -590,8 +590,8 @@ static void adjust_oob_length(struct mtd_info *mtd, uint64_t start,
 			    (end_page - start_page + 1) * oob_per_page);
 }
 
-static int mtdchar_write_ioctl(struct mtd_info *mtd,
-		struct mtd_write_req __user *argp)
+static noinline_for_stack int
+mtdchar_write_ioctl(struct mtd_info *mtd, struct mtd_write_req __user *argp)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
 	struct mtd_write_req req;
@@ -688,8 +688,8 @@ static int mtdchar_write_ioctl(struct mtd_info *mtd,
 	return ret;
 }
 
-static int mtdchar_read_ioctl(struct mtd_info *mtd,
-		struct mtd_read_req __user *argp)
+static noinline_for_stack int
+mtdchar_read_ioctl(struct mtd_info *mtd, struct mtd_read_req __user *argp)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
 	struct mtd_read_req req;
-- 
2.39.2

