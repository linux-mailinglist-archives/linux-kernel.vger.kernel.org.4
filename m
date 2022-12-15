Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62B664DE9F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiLOQ3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiLOQ2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:28:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A4313D2D;
        Thu, 15 Dec 2022 08:28:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DA6A61E58;
        Thu, 15 Dec 2022 16:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9524AC433D2;
        Thu, 15 Dec 2022 16:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671121688;
        bh=Ftx0VJqQ/+fSyw2rH/KASxALEE3T+b2McIeIvddmZzA=;
        h=From:To:Cc:Subject:Date:From;
        b=e0XBV1r0zWcJu0n2d4qSajU11xPT3DE71JiEWFEu4b/m4lw3lld4W/tWSp7TgqTx0
         EKHDZ4+qVSIVTVW+CSt5NXSK75KIuRoHK84h+EARII30o2IpXn4OC4OV+vNPEfNP/j
         F5QWLQcwyymCwiPIoonCw5ZWUUiiiLPeiXeMpG9yYXbK9JWLtKfGnVk6LE2BLVIDSZ
         rY82j+5PzzxWt7YR2dICth28bJXNhtsyO7DIo1BfGZStwWH2WZnVabADCwyiqRDx1Q
         vpG2w9ZRlj2BiS+Z+kVGvM7f2pG0sXtF/G/hc2PLj5JGavJy7juUTNEypuIxXnND7M
         nCsEA3U2/B7pw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     reiserfs-devel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] reiserfs: avoid objtool warning after panic
Date:   Thu, 15 Dec 2022 17:27:53 +0100
Message-Id: <20221215162759.3883282-1-arnd@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Calling reiserfs_panic() leaves the calling function in an
undefined state that objtool complains about, because of the
__noreturn attribute:

fs/reiserfs/do_balan.o: warning: objtool: balance_leaf+0x109fb: stack state mismatch: cfa1=4+576 cfa2=4+584
fs/reiserfs/ibalance.o: warning: objtool: balance_internal+0x6099: stack state mismatch: cfa1=4+512 cfa2=4+536
fs/reiserfs/ibalance.o: warning: objtool: internal_insert_key+0xa1c: stack state mismatch: cfa1=4+224 cfa2=4+216

Avoid that by removing the attribute, at the possible cost of
a few extra cycles. Mark the panic and error functions as __cold
instead to at least give the compiler a hint that this is not
the fast path.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/reiserfs/reiserfs.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
index 3aa928ec527a..1c22f48235c2 100644
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -3185,12 +3185,11 @@ int fix_nodes(int n_op_mode, struct tree_balance *tb,
 void unfix_nodes(struct tree_balance *);
 
 /* prints.c */
-void __reiserfs_panic(struct super_block *s, const char *id,
-		      const char *function, const char *fmt, ...)
-    __attribute__ ((noreturn));
+void __cold __reiserfs_panic(struct super_block *s, const char *id,
+		      const char *function, const char *fmt, ...);
 #define reiserfs_panic(s, id, fmt, args...) \
 	__reiserfs_panic(s, id, __func__, fmt, ##args)
-void __reiserfs_error(struct super_block *s, const char *id,
+void __cold __reiserfs_error(struct super_block *s, const char *id,
 		      const char *function, const char *fmt, ...);
 #define reiserfs_error(s, id, fmt, args...) \
 	 __reiserfs_error(s, id, __func__, fmt, ##args)
-- 
2.35.1

