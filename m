Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280C86DFCA3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjDLRYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjDLRYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:24:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933FE1BE4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:24:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EDDB631A2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 17:24:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4965DC433A1;
        Wed, 12 Apr 2023 17:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681320254;
        bh=yZE3NaZNWGex7AsabXWKzco4PSx2Xxsuc1liFr6+lK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rFCA96UFwB7JCZC7odAG2lpfvCiX8M3sewQ1lShv0FAI3+MNVHqaX0W1BDBo8Kb7E
         0IpsEtpCXVH1vazJj1HTAN4sdg63WbLJVv4jTNRaaZMIujhZY4A3rEDLhbTWvPUGhK
         xMcFecgN+MkYpu7qjz9m5beWzFPIbCjZwdAy282+/v/c4ZM1IqjVptDsEuqj4/EfnX
         E/jfiWgXL3Mnaa30JRfcKvhM4GP//PgXaEktaB8nG8xmBhAFxXUsmhVpEsAoIlK1eY
         tJl4n9rb2EvZSCLauXSmGaf5j6+wH+9Y5s+YWICWGCsDQdsuLNHDdsHhrTO3hijVkf
         HmFIUWOZ5sDZA==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, frederic@kernel.org,
        paulmck@kernel.org, keescook@chromium.org
Subject: [PATCH 1/3] context_tracking: Fix KCSAN noinstr violation
Date:   Wed, 12 Apr 2023 10:24:06 -0700
Message-Id: <dc93f45abdec90c171108b4b590b7fff5790963c.1681320026.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681320026.git.jpoimboe@kernel.org>
References: <cover.1681320026.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With KCSAN enabled, even empty inline stubs can be out-of-lined.

Force the context_tracking_guest_exit() stub inline.

Fixes the following warnings:

  vmlinux.o: warning: objtool: vmx_vcpu_enter_exit+0x1be: call to context_tracking_guest_exit() leaves .noinstr.text section
  vmlinux.o: warning: objtool: svm_vcpu_enter_exit+0x85: call to context_tracking_guest_exit() leaves .noinstr.text section

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/context_tracking.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index d4afa8508a80..5ae3abd767b4 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -97,7 +97,7 @@ static inline int exception_enter(void) { return 0; }
 static inline void exception_exit(enum ctx_state prev_ctx) { }
 static inline int ct_state(void) { return -1; }
 static __always_inline bool context_tracking_guest_enter(void) { return false; }
-static inline void context_tracking_guest_exit(void) { }
+static __always_inline void context_tracking_guest_exit(void) { }
 #define CT_WARN_ON(cond) do { } while (0)
 #endif /* !CONFIG_CONTEXT_TRACKING_USER */
 
-- 
2.39.2

