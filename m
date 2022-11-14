Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90CB627CA3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiKNLo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236634AbiKNLo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:44:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB09F59C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:44:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E980B80E6C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A04BC433C1;
        Mon, 14 Nov 2022 11:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426255;
        bh=b5Apr9ljbPWXptKX2Y7oDbgatIEtz07LMj4Vds3jeiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pQCj9Bl/KCEzOwGmBs7/yB++JsW34aqew8j6gYUQ5Kt736lR1XZqCE8OHv/HBtIqm
         +Hylb+ZnLUG8vo+93hauKmemG/BIuRN9R8oG15YbQ6Y0tW7gQbwKVr4ch0Ps6rC+WS
         6N6tqZBRzgDyQEZ+DQMlBam1XDYzFf0h2RrfputJVlpXjFsVsPau0r7kJL158UCmeE
         2OJ0Iz0OWPYpfKqqnErjLr1tOfG5a9hlIcDGpwUpmN7YLxuwVYH1/X+oYuXda40NWF
         DK50WjQLbBBP3Wl9U5Sn1fNthDyc1ptIdhp79x2liWt9Tr5DCqZ501qDHuPRPDSi2G
         uNg9OxmKfTRtQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <andi@firstfloor.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 09/46] static_call, lto: Mark static_call_return0() as __visible
Date:   Mon, 14 Nov 2022 12:43:07 +0100
Message-Id: <20221114114344.18650-10-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114114344.18650-1-jirislaby@kernel.org>
References: <20221114114344.18650-1-jirislaby@kernel.org>
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

From: Andi Kleen <andi@firstfloor.org>

Symbols referenced from assembler (either directly or e.f. from
DEFINE_STATIC_KEY()) need to be global and visible in gcc LTO because
they could end up in a different object file than the assembler. This
can lead to linker errors without this patch.

So mark static_call_return0() as __visible.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Andi Kleen <andi@firstfloor.org>
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 kernel/static_call.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/static_call.c b/kernel/static_call.c
index e9c3e69f3837..9197fe86d8bd 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/static_call.h>
 
-long __static_call_return0(void)
+__visible long __static_call_return0(void)
 {
 	return 0;
 }
-- 
2.38.1

