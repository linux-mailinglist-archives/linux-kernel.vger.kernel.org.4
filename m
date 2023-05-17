Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2772B7068AD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjEQMyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjEQMya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:54:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799FC3A96
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 05:54:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15B926149F
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:54:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506A2C433D2;
        Wed, 17 May 2023 12:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684328068;
        bh=nc29UDrIzO0K1XrrlSRT98qfuvFbPBoKCvdXYVf6s80=;
        h=From:To:Cc:Subject:Date:From;
        b=nkomx8kuTnEAGcwqhXaP550kiR6KMRbHeWoYuNBp8tXXIzslqThf+dLOXAVc467X8
         GpB1Chozz6vx8UMHKoWPeDVbWIFgrJFAHhfMsjmcr9izjE04oGKMffP9dDlEcuEO9y
         QusgbvrUgOLy7I7tIvVcegzvp1gBO6VZ8SXJUS291HlKQSAJobess2Np9fLFrKLoC+
         7VMERVDpqW8I55FPQDuQSaA09a0RL/EEjuT0DCKCUeFO/419R09dGaZ4jr8qBBT2mh
         YPucdwE7RHotyr28PlvMZ7jnwvFL7TrzkcTgN9dRPX6xSySIUzFjeLvIosRotnQdy1
         cI6/myrhgvMCA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Douglas Anderson <dianders@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kdb: include header in signal handling code
Date:   Wed, 17 May 2023 14:54:09 +0200
Message-Id: <20230517125423.930967-1-arnd@kernel.org>
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

kdb_send_sig() is defined in the signal code and called from kdb,
but the declaration is part of the kdb internal code.
Include this from signal.c as well to avoid the warning:

kernel/signal.c:4789:6: error: no previous prototype for 'kdb_send_sig' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/signal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index 8f6330f0e9ca..d38df14f71ac 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -4780,6 +4780,8 @@ void __init signals_init(void)
 
 #ifdef CONFIG_KGDB_KDB
 #include <linux/kdb.h>
+#include "debug/kdb/kdb_private.h"
+
 /*
  * kdb_send_sig - Allows kdb to send signals without exposing
  * signal internals.  This function checks if the required locks are
-- 
2.39.2

