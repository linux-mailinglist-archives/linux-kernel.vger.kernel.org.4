Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0034672199A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 21:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjFDTxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 15:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjFDTxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 15:53:04 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6E8AD
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 12:53:03 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1685908381;
        bh=14k5IRSBsPcfhTrwNmGrvyqKxqPkVFc5q1QH6Bsjw10=;
        h=From:Date:Subject:To:Cc:From;
        b=fZfhqK7UpBi8ijxv3lzz8TWIGemA2KdaHjvgORIK72XQSzJGyxhspbAxJlgjz58E2
         EZDK2dGaVn/T6yPOJSiO67rddgdd3RDLszSXQVqq104Kvkkh49zG5DvQEp63gb9xlg
         4O+Brqgt5HA9m1NzchT8UFk+FckvHJ4T1apujDOA=
Date:   Sun, 04 Jun 2023 21:52:59 +0200
Subject: [PATCH] tools/nolibc: handle large return values from syscall()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230604-nolibc-syscall-ret-v1-1-779513fc915d@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAJvrfGQC/x2NQQrCQAwAv1JyNhBXLehXxMPuNmsDIZWNilL6d
 4PHGRhmBecu7HAZVuj8FpfFAva7Aeqc7c4oUzAkSgca6Yi2qJSK/vWaVbHzE0+JpsbnVsZCEGH
 Jzlh6tjpHai/VkI/OTT7/0/W2bT+acNCFeQAAAA==
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685908381; l=1406;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=14k5IRSBsPcfhTrwNmGrvyqKxqPkVFc5q1QH6Bsjw10=;
 b=6H9srcXbxHIkhPOAPzotuV59uRdIyh/bbhrfg/2N20U9Tbi9zwEeQK2XTEENEqXIA/DFQGSD9
 PEWqzwvqBoTCr+ZbPmt9+lMgxCVova8MJGblb8BiwN79VJa6LSRj/ty
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syscalls return values long values. Don't truncate to int.

Fixes: 33158bb86d46 ("tools/nolibc/unistd: add syscall()")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---

Just noticed this when responding at
https://lore.kernel.org/lkml/ea4e7442-7223-4211-ba29-70821e907888@t-8ch.de/

Feel free to squash this directly into the broken commit.
---
 tools/include/nolibc/unistd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/unistd.h b/tools/include/nolibc/unistd.h
index 6773e83c16a0..c20b2fbf065e 100644
--- a/tools/include/nolibc/unistd.h
+++ b/tools/include/nolibc/unistd.h
@@ -58,7 +58,7 @@ int tcsetpgrp(int fd, pid_t pid)
 
 #define _syscall(N, ...)                                                      \
 ({                                                                            \
-	int _ret = my_syscall##N(__VA_ARGS__);                                \
+	long _ret = my_syscall##N(__VA_ARGS__);                               \
 	if (_ret < 0) {                                                       \
 		SET_ERRNO(-_ret);                                             \
 		_ret = -1;                                                    \

---
base-commit: a76324560e0f8f916d89452dd6aec1104e97a3c6
change-id: 20230604-nolibc-syscall-ret-520dfe9fb6b0

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

