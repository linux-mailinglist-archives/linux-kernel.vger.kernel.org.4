Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D39706893
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjEQMsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjEQMsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:48:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FF95580
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 05:48:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0452E64675
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD3AC433EF;
        Wed, 17 May 2023 12:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684327687;
        bh=4HY0Ym8gMukTRRYv/O34wSKiu5KYThcxaes5f1ODcQA=;
        h=From:To:Cc:Subject:Date:From;
        b=RV1B+/gave4YwzwHMlfheMuunRRiS6UUzx2WS5YDa5RX/UWlgJLu5gmqjAdex83fL
         hDZgf1Z1sS3rGN0dXt81apAxQ+gJzm2DXYSIsmSx++SZKw42V4rxQNVpwhcBspDqCv
         7795yRXTwkVvYUlrHgoxG5RbGaeBHrajveeJXdUlESFMl/1LEnNlZLDltY+cE/tiEc
         spRcf/Dzz3YsCbMjj95LW1NVsuHTL2UieW1Ne19EBJUGQEz76NVBnSGj4E5pCOQ7lp
         MLx59IcdstIn7q9jP51g823DhcnuftpdkTZHgFP+SZORyt/b/3EHWWEbmtBJ7Tg5lv
         87vlZgEl8dPAg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] kdb: include kdb_private.h for function prototypes
Date:   Wed, 17 May 2023 14:47:53 +0200
Message-Id: <20230517124802.929751-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The kdb_kbd_cleanup_state() is called from another file through
the kdb_private.h file, but that is not included before the
definition, causing a W=1 warning:

kernel/debug/kdb/kdb_keyboard.c:198:6: error: no previous prototype for 'kdb_kbd_cleanup_state' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/debug/kdb/kdb_keyboard.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/debug/kdb/kdb_keyboard.c b/kernel/debug/kdb/kdb_keyboard.c
index f87c750d3eb3..3c2987f46f6e 100644
--- a/kernel/debug/kdb/kdb_keyboard.c
+++ b/kernel/debug/kdb/kdb_keyboard.c
@@ -13,6 +13,8 @@
 #include <linux/ctype.h>
 #include <linux/io.h>
 
+#include "kdb_private.h"
+
 /* Keyboard Controller Registers on normal PCs. */
 
 #define KBD_STATUS_REG		0x64	/* Status register (R) */
-- 
2.39.2

