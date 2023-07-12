Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048D0750240
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjGLJAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjGLJAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:00:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C613E2D54;
        Wed, 12 Jul 2023 01:58:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2252616E6;
        Wed, 12 Jul 2023 08:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E9CC433C7;
        Wed, 12 Jul 2023 08:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689152314;
        bh=AqrrOdfRU9om9M6vSXjzTWkrWbITMkMN92jg5DFdzNQ=;
        h=From:To:Cc:Subject:Date:From;
        b=njg59PeEhMaEX1bV5nYHs+2dHLWFyI9dohNyNc9Kdboe+OmTveat/7dkoXi1tYv6N
         G04pvSnCjW6Fmvmn+zZwHCza+tEENGmiMevGFksowUoCDZmnC35u1SJctBElQJyYVF
         UlqfKDzyiNOLeclaqkfjOEGw08zQa91FPqmY5d/2GxMdgBdI2Ez6iJ7i+HeX89gkBL
         8WZvzjFmR25e+9F+OFE857VzsRt9s6UVMHwsxwYul3ioP9S+GkVfIqB2t4GA8nJmI0
         rBLPPNsymsbtK5h7lYj/F8jdBcoaJKwHfSaxWelZe4r4b+Df0NaitHxPYz8o90ch2n
         whw5pkoMFnulA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH] tty: make check_tty_count() void
Date:   Wed, 12 Jul 2023 10:58:30 +0200
Message-ID: <20230712085830.4908-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
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

The return value is unused, so drop it.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_io.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 3959efc717aa..e23e416aae93 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -270,7 +270,7 @@ static int tty_paranoia_check(struct tty_struct *tty, struct inode *inode,
 }
 
 /* Caller must hold tty_lock */
-static int check_tty_count(struct tty_struct *tty, const char *routine)
+static void check_tty_count(struct tty_struct *tty, const char *routine)
 {
 #ifdef CHECK_TTY_COUNT
 	struct list_head *p;
@@ -290,10 +290,8 @@ static int check_tty_count(struct tty_struct *tty, const char *routine)
 	if (tty->count != (count + kopen_count)) {
 		tty_warn(tty, "%s: tty->count(%d) != (#fd's(%d) + #kopen's(%d))\n",
 			 routine, tty->count, count, kopen_count);
-		return (count + kopen_count);
 	}
 #endif
-	return 0;
 }
 
 /**
-- 
2.41.0

