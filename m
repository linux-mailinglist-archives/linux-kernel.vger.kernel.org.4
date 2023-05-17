Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FF77068A2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjEQMvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjEQMvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:51:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E6D2105
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 05:51:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28ABE6431F
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30382C4339B;
        Wed, 17 May 2023 12:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684327868;
        bh=1hYD+2nOr4lSILHlOSxMQfqRPpj2EABz1oW+pkrU7yQ=;
        h=From:To:Cc:Subject:Date:From;
        b=YNmsxNL4zCP/oZdspQAe6lbNBur/gYw4Z+xh/RSowP7/ofx3wK1XxNwKm+W4FbjNg
         /Z4ObSC5o/abMPcOtN4wr5Aia70oV158jceOUhA7GGpUNvJqahudtjDDtdoL1U8Y+G
         rOkWCFTkbZwvJlV5srXm2bHRFy43Go6g3PLl2bZ16mktmq9R6uUItTj+icghXju+gO
         uqgVa4BeGHU4y4WAXnHFeDigKZLtpsQ5xCNOJGv9CX1oSdHeiEvr1Pd4tjiXpbisip
         K0YUdCHNzJri/4I5AZlt7f6yNSqfXPLnpuGvo67hYVClxd55Bi8/+chzc0SCYE45+/
         dw6SbHr/E3NCQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     kasan-dev@googlegroups.com
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Fangrui Song <maskray@google.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] ubsan: add prototypes for internal functions
Date:   Wed, 17 May 2023 14:50:34 +0200
Message-Id: <20230517125102.930491-1-arnd@kernel.org>
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

Most of the functions in ubsan that are only called from generated
code don't have a prototype, which W=1 builds warn about:

lib/ubsan.c:226:6: error: no previous prototype for '__ubsan_handle_divrem_overflow' [-Werror=missing-prototypes]
lib/ubsan.c:307:6: error: no previous prototype for '__ubsan_handle_type_mismatch' [-Werror=missing-prototypes]
lib/ubsan.c:321:6: error: no previous prototype for '__ubsan_handle_type_mismatch_v1' [-Werror=missing-prototypes]
lib/ubsan.c:335:6: error: no previous prototype for '__ubsan_handle_out_of_bounds' [-Werror=missing-prototypes]
lib/ubsan.c:352:6: error: no previous prototype for '__ubsan_handle_shift_out_of_bounds' [-Werror=missing-prototypes]
lib/ubsan.c:394:6: error: no previous prototype for '__ubsan_handle_builtin_unreachable' [-Werror=missing-prototypes]
lib/ubsan.c:404:6: error: no previous prototype for '__ubsan_handle_load_invalid_value' [-Werror=missing-prototypes]

Add prototypes for all of these to lib/ubsan.h, and remove the
one that was already present in ubsan.c.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/ubsan.c |  3 ---
 lib/ubsan.h | 11 +++++++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/lib/ubsan.c b/lib/ubsan.c
index e2cc4a799312..3f90810f9f42 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -423,9 +423,6 @@ void __ubsan_handle_load_invalid_value(void *_data, void *val)
 }
 EXPORT_SYMBOL(__ubsan_handle_load_invalid_value);
 
-void __ubsan_handle_alignment_assumption(void *_data, unsigned long ptr,
-					 unsigned long align,
-					 unsigned long offset);
 void __ubsan_handle_alignment_assumption(void *_data, unsigned long ptr,
 					 unsigned long align,
 					 unsigned long offset)
diff --git a/lib/ubsan.h b/lib/ubsan.h
index cc5cb94895a6..5d99ab81913b 100644
--- a/lib/ubsan.h
+++ b/lib/ubsan.h
@@ -124,4 +124,15 @@ typedef s64 s_max;
 typedef u64 u_max;
 #endif
 
+void __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs);
+void __ubsan_handle_type_mismatch(struct type_mismatch_data *data, void *ptr);
+void __ubsan_handle_type_mismatch_v1(void *_data, void *ptr);
+void __ubsan_handle_out_of_bounds(void *_data, void *index);
+void __ubsan_handle_shift_out_of_bounds(void *_data, void *lhs, void *rhs);
+void __ubsan_handle_builtin_unreachable(void *_data);
+void __ubsan_handle_load_invalid_value(void *_data, void *val);
+void __ubsan_handle_alignment_assumption(void *_data, unsigned long ptr,
+					 unsigned long align,
+					 unsigned long offset);
+
 #endif
-- 
2.39.2

