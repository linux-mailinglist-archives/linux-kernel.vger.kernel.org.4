Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6684870689F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjEQMuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjEQMu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:50:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB22A420B
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 05:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 492D063BDD
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C615EC433D2;
        Wed, 17 May 2023 12:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684327815;
        bh=cZTa+EdyC7wAzjN7QLIW3MFkYJG8EOdGt2pse/e8KnI=;
        h=From:To:Cc:Subject:Date:From;
        b=kgv6Eg1a2Vjgc9bueVja0JGMb6FY78SxRyecT5LDmnibFOtRpBKCZvH0NlA8xm+1l
         uumOV+xN/mG+mtKY6AalL/oskrNATd+wVsEvIYXpRfWQMjcGGPDWsL1f4MQc+A+2MG
         11AzfrWypzL3WX0WrCu5lri0wMFS4GODxX5L4H7qLYJS29FxlEC+rAHBzplnMae6ox
         PQyyybaU2s+Ubh6KINOOYk2pZMjIMIv6BUiE+E2B4uX7hfBFpk0GvXWJCzoAVnymQt
         jm8K5m009M55+Uk44RbwXIWWhxdr7lygjYU64pc0VqJXOWw1tZthecE6Ka/7cZ3SXu
         G2RCzSHH22bAw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] gcov: add prototypes for internal functions
Date:   Wed, 17 May 2023 14:50:07 +0200
Message-Id: <20230517125011.930274-1-arnd@kernel.org>
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

gcov uses global functions that are called from generated code,
but these have no prototype in a header, which causes a W=1
build warning:

kernel/gcov/gcc_base.c:12:6: error: no previous prototype for '__gcov_init' [-Werror=missing-prototypes]
kernel/gcov/gcc_base.c:40:6: error: no previous prototype for '__gcov_flush' [-Werror=missing-prototypes]
kernel/gcov/gcc_base.c:46:6: error: no previous prototype for '__gcov_merge_add' [-Werror=missing-prototypes]
kernel/gcov/gcc_base.c:52:6: error: no previous prototype for '__gcov_merge_single' [-Werror=missing-prototypes]

Add prototypes for all of these to an internal header.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/gcov/gcov.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/kernel/gcov/gcov.h b/kernel/gcov/gcov.h
index 912b8ea01d33..6df99772406c 100644
--- a/kernel/gcov/gcov.h
+++ b/kernel/gcov/gcov.h
@@ -82,4 +82,34 @@ extern const struct gcov_link gcov_link[];
 extern int gcov_events_enabled;
 extern struct mutex gcov_lock;
 
+void __gcov_init(struct gcov_info *info);
+void __gcov_flush(void);
+void __gcov_merge_add(gcov_type *counters, unsigned int n_counters);
+void __gcov_merge_single(gcov_type *counters, unsigned int n_counters);
+void __gcov_merge_delta(gcov_type *counters, unsigned int n_counters);
+void __gcov_merge_ior(gcov_type *counters, unsigned int n_counters);
+void __gcov_merge_time_profile(gcov_type *counters, unsigned int n_counters);
+void __gcov_merge_icall_topn(gcov_type *counters, unsigned int n_counters);
+void __gcov_exit(void);
+
+size_t convert_to_gcda(char *buffer, struct gcov_info *info);
+void gcov_info_add(struct gcov_info *dst, struct gcov_info *src);
+struct gcov_info *gcov_info_dup(struct gcov_info *info);
+const char *gcov_info_filename(struct gcov_info *info);
+void gcov_info_free(struct gcov_info *info);
+int gcov_info_is_compatible(struct gcov_info *info1, struct gcov_info *info2);
+void gcov_info_link(struct gcov_info *info);
+struct gcov_info *gcov_info_next(struct gcov_info *info);
+void gcov_info_reset(struct gcov_info *info);
+void gcov_info_unlink(struct gcov_info *prev, struct gcov_info *info);
+unsigned int gcov_info_version(struct gcov_info *info);
+bool gcov_info_within_module(struct gcov_info *info, struct module *mod);
+void llvm_gcda_emit_arcs(u32 num_counters, u64 *counters);
+void llvm_gcda_emit_function(u32 ident, u32 func_checksum, u32 cfg_checksum);
+void llvm_gcda_end_file(void);
+void llvm_gcda_start_file(const char *orig_filename, u32 version, u32 checksum);
+void llvm_gcda_summary_info(void);
+typedef void (*llvm_gcov_callback)(void);
+void llvm_gcov_init(llvm_gcov_callback writeout, llvm_gcov_callback flush);
+
 #endif /* GCOV_H */
-- 
2.39.2

