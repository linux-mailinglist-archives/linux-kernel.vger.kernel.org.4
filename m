Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419B96E7438
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 09:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjDSHnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 03:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjDSHma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:42:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C17DB472
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:42:29 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CFE891FD8A;
        Wed, 19 Apr 2023 07:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681890147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=UzVUs+NcKfpPnRkrILdkjoJFYTyn1Afn69dgHx+rH9U=;
        b=SZgPNF5LpNK1fCrO63cyU4bB2QrO7CqxFrHaLjLAfb0sZ8t+HFXn1Ic1ymsnyggIsxfWew
        1DSCfmhSS1GRNyaEFdmNtDJ3l1lbb05icTlFCZSYRhsUY2he+ozejj2iYMLFj2+u2bBNCG
        Ubn/e/TWdAZdLXH1c0fbyNSDLo6RaWw=
Received: from alley.suse.cz (unknown [10.100.201.202])
        by relay2.suse.de (Postfix) with ESMTP id 3A0ED2C141;
        Wed, 19 Apr 2023 07:42:27 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH] printk: Enough to disable preemption in printk deferred context
Date:   Wed, 19 Apr 2023 09:42:10 +0200
Message-Id: <20230419074210.17646-1-pmladek@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment above printk_deferred_enter()/exit() definition claims
that it can be used only when interrupts are disabled.

It was required by the original printk_safe_log_store() implementation.
The code provided lockless synchronization between a single writer and
a single reader. The interrupt and the normal context shared the same
buffer.

The commit 93d102f094be ("printk: remove safe buffers") removed
these temporary buffers. Instead, the messages are stored directly into
the new global lockless buffer which supports multiple parallel writers.

As a result, it is safe to interrupt one writer now. The preemption still
has to be disabled because the deferred context is CPU specific.

Fixes: 93d102f094be ("printk: remove safe buffers")
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/printk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 8ef499ab3c1e..915a321b491e 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -161,7 +161,7 @@ extern void __printk_safe_enter(void);
 extern void __printk_safe_exit(void);
 /*
  * The printk_deferred_enter/exit macros are available only as a hack for
- * some code paths that need to defer all printk console printing. Interrupts
+ * some code paths that need to defer all printk console printing. Preemption
  * must be disabled for the deferred duration.
  */
 #define printk_deferred_enter __printk_safe_enter
-- 
2.35.3

