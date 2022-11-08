Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF196218C7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbiKHPuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbiKHPuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:50:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430A120BFC;
        Tue,  8 Nov 2022 07:50:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 057FBB81B4F;
        Tue,  8 Nov 2022 15:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6819CC433D6;
        Tue,  8 Nov 2022 15:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667922619;
        bh=ZwW0qCRKBchNeu3whdSe71nh1Tm4+42ATA3rao4qIss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qZM6OR4Y6Aqyo0+pNKeQSN6ge0SinOEsVZPWkr9UbGKgpet+lrD9PcSMptsHZqtIl
         vZvT2XTI4UbpvlMMGO3VA9E10Am+ksSUT5uY0J7u2WT1P4BGFTFCXmhLUcECSTTvdf
         w0LJPqXvFgnMRagRg51V6qD+OnK0uxA41g4K5jBblsJBxFTp8Zi4x1UvI34sgztBBh
         B5iqXIuDhuO6qSE1OV3Jap3vuJPbbJy5jOo3RUUic/1x3S3h4WHWRXtqe6zZglekEd
         y126OPYUB8CqyUsMgxRBManfAEI+4wg1hFMdl0CyL2/G4Nrx6jb5c23hQ6YFN5wQ4r
         M4r3DPjQ3FOjw==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [RFC PATCH 7/9] docs: tracing: Update fprobe documentation
Date:   Wed,  9 Nov 2022 00:50:16 +0900
Message-Id: <166792261641.919356.4627265153244048545.stgit@devnote3>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <166792255429.919356.14116090269057513181.stgit@devnote3>
References: <166792255429.919356.14116090269057513181.stgit@devnote3>
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
 

