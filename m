Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAFA68325E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjAaQQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjAaQQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:16:43 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2275423F;
        Tue, 31 Jan 2023 08:16:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9ABF8CE1F35;
        Tue, 31 Jan 2023 16:16:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC94C433EF;
        Tue, 31 Jan 2023 16:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675181769;
        bh=ZwW0qCRKBchNeu3whdSe71nh1Tm4+42ATA3rao4qIss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RS6R3qrYeZcWAaCTaRf48V3oM37p/vsGDuq0FJRQTBDF5Sb2TcTV8VaFPV78Ybak1
         ImBiw+zpbM7O98zPwCWJLjqOVYJqnsUqroLt0itIxFAJ4dp6IS9+aMR9+aUmuqCnfk
         JLN+cW7hBtwSI0k0HQ6VoUWYigrE8Gs2XEHNWnzp9B3bFmDM4NdCV7B2gFY/h9NEUz
         oPLtxOQ6Mgjn2Ojtt74wtgmt6/GpajUBWnset6f11VozI7Oj7h/hBG7gRXxYNF08JZ
         opZjfYPjx5f5K3jCyRf7KMH0w/eRy2zMQIEGepkRR/Nen+uQttYJfnDr+r//ptmVTE
         WbTpaZQj4jPwg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v2 07/10] docs: tracing: Update fprobe documentation
Date:   Wed,  1 Feb 2023 01:16:06 +0900
Message-Id:  <167518176637.336834.8465585643188731637.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
In-Reply-To:  <167518170369.336834.15310137713178284219.stgit@mhiramat.roam.corp.google.com>
References:  <167518170369.336834.15310137713178284219.stgit@mhiramat.roam.corp.google.com>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Update fprobe.rst for
 - the private entry_data argument
 - the return value of the entry handler
 - the nr_rethook_node field.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Documentation/trace/fprobe.rst |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/trace/fprobe.rst b/Documentation/trace/fprobe.rst
index b64bec1ce144..40dd2fbce861 100644
--- a/Documentation/trace/fprobe.rst
+++ b/Documentation/trace/fprobe.rst
@@ -87,14 +87,16 @@ returns as same as unregister_ftrace_function().
 The fprobe entry/exit handler
 =============================
 
-The prototype of the entry/exit callback function is as follows:
+The prototype of the entry/exit callback function are as follows:
 
 .. code-block:: c
 
- void callback_func(struct fprobe *fp, unsigned long entry_ip, struct pt_regs *regs);
+ int entry_callback(struct fprobe *fp, unsigned long entry_ip, struct pt_regs *regs, void *entry_data);
 
-Note that both entry and exit callbacks have same ptototype. The @entry_ip is
-saved at function entry and passed to exit handler.
+ void exit_callback(struct fprobe *fp, unsigned long entry_ip, struct pt_regs *regs, void *entry_data);
+
+Note that the @entry_ip is saved at function entry and passed to exit handler.
+If the entry callback function returns !0, the corresponding exit callback will be cancelled.
 
 @fp
         This is the address of `fprobe` data structure related to this handler.
@@ -113,6 +115,12 @@ saved at function entry and passed to exit handler.
         to use @entry_ip. On the other hand, in the exit_handler, the instruction
         pointer of @regs is set to the currect return address.
 
+@entry_data
+        This is a local storage to share the data between entry and exit handlers.
+        This storage is NULL by default. If the user specify `exit_handler` field
+        and `entry_data_size` field when registering the fprobe, the storage is
+        allocated and passed to both `entry_handler` and `exit_handler`.
+
 Share the callbacks with kprobes
 ================================
 

