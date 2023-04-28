Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7E36F1BF2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 17:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjD1PwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 11:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345900AbjD1PwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 11:52:17 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F2D2129
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 08:52:15 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1682697131;
        bh=yA2p+JNjmFfGlYa0wIdrC8Z5YlWh5St1B631YdUOEJc=;
        h=From:Date:Subject:To:Cc:From;
        b=NpAXjKrKzJnetymlNBJ8g1xKFOazMwZ5dCBSH/bIsdnew7Gsb+ATyUvK/MEtCDdMZ
         zhAfxk9hAIDQD5aBVY16Sgmhh928kGPhcLjlArKiafKXjr/EIrW58LMpsWUEM5FYnL
         S/5omzMXOkTrtUpA4Wkit47fNpI2AkCKJy8v3H2M=
Date:   Fri, 28 Apr 2023 17:52:11 +0200
Subject: [PATCH] tools/nolibc: remove LINUX_REBOOT_ constants
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230428-nolibc-reboot-v1-1-0bca02d20ba6@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAKrrS2QC/x2N0QrCMAwAf2Xk2UBXZU5/RXxoumwLlFTSKcLYv
 xt8vIPjdmhswg3u3Q7GH2lS1aE/dZDXpAujTM4QQzyHSxxRaxHKaEy1bnjtbzxQGKYxZPCGUmM
 kS5pXr/RdisuX8Szf/+TxPI4fLSlCDXQAAAA=
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682697131; l=1245;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=yA2p+JNjmFfGlYa0wIdrC8Z5YlWh5St1B631YdUOEJc=;
 b=Gt3010UUPuT/YnL934/uirUuPbLuQv6XVi9Uuo9WkN92QI0hTMYYBnBVoopDcjfStpXvAB1OM
 g3s0Zj3DtCsDx6eGfbFeC/548m7RnuvlXJe0z5PflsOL8NxR5JH31QF
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same constants and some more have been exposed to userspace via
linux/reboot.h for a long time.

To avoid conflicts and trim down nolibc a bit drop the custom
definitions.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/types.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index aedd7d9e3f64..15b0baffd336 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -86,14 +86,6 @@
 #define SEEK_CUR       1
 #define SEEK_END       2
 
-/* cmd for reboot() */
-#define LINUX_REBOOT_MAGIC1         0xfee1dead
-#define LINUX_REBOOT_MAGIC2         0x28121969
-#define LINUX_REBOOT_CMD_HALT       0xcdef0123
-#define LINUX_REBOOT_CMD_POWER_OFF  0x4321fedc
-#define LINUX_REBOOT_CMD_RESTART    0x01234567
-#define LINUX_REBOOT_CMD_SW_SUSPEND 0xd000fce2
-
 /* Macros used on waitpid()'s return status */
 #define WEXITSTATUS(status) (((status) & 0xff00) >> 8)
 #define WIFEXITED(status)   (((status) & 0x7f) == 0)

---
base-commit: 33afd4b76393627477e878b3b195d606e585d816
change-id: 20230428-nolibc-reboot-719e6b06d80c

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

