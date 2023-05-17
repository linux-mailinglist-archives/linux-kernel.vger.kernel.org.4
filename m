Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F23E706890
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjEQMri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjEQMr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:47:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFA712C;
        Wed, 17 May 2023 05:47:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C05BD646CD;
        Wed, 17 May 2023 12:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB90FC433EF;
        Wed, 17 May 2023 12:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684327647;
        bh=NTct6PtjEtuPM5wlTLSiKa6Oz8nevVfIM3Gsc53yGng=;
        h=From:To:Cc:Subject:Date:From;
        b=NE2fqtYq5UrGRjgu9TsVFmF3Q0M2nt7uV0wRr//Fs9MOw+oFwH1in5Vtj+NEFRHO8
         Usx11UMUFfFJq6gLSiF4HVKCDHoU814M6SC6NFTVmQah+i/xFJki4Ohni3CJNlgiex
         ZJR78/8DCfipgYdoReKXPt+L3DCtV1v8ClacFS9/YgdQd92nT+w37T1lGwiK/eyUk1
         gf1MW9X1MvJ+qIRhE2Nc078U5PwcWGDVk6olMWi8+XvjSr/ZBmC4MABzfCR3SOkDBI
         NeqM1VvceE615MHVjXdzDvXMabe8bOV5hwLRFk5QjYMRF0Mbd+K73A1X56vCUEgDUP
         oXw2Te19MbvmQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: make ftrace_likely_update() declaration visible
Date:   Wed, 17 May 2023 14:47:12 +0200
Message-Id: <20230517124721.929540-1-arnd@kernel.org>
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

This function is only used when CONFIG_TRACE_BRANCH_PROFILING is
set, and the declaration is hidden behind this Kconfig symbol,
which causes a warning if disabled:

kernel/trace/trace_branch.c:205:6: error: no previous prototype for 'ftrace_likely_update' [-Werror=missing-prototypes]

Move the declaration out of the #ifdef to avoid the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/compiler.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 947a60b801db..d7779a18b24f 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -12,11 +12,10 @@
  * Note: DISABLE_BRANCH_PROFILING can be used by special lowlevel code
  * to disable branch tracing on a per file basis.
  */
-#if defined(CONFIG_TRACE_BRANCH_PROFILING) \
-    && !defined(DISABLE_BRANCH_PROFILING) && !defined(__CHECKER__)
 void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 			  int expect, int is_constant);
-
+#if defined(CONFIG_TRACE_BRANCH_PROFILING) \
+    && !defined(DISABLE_BRANCH_PROFILING) && !defined(__CHECKER__)
 #define likely_notrace(x)	__builtin_expect(!!(x), 1)
 #define unlikely_notrace(x)	__builtin_expect(!!(x), 0)
 
-- 
2.39.2

