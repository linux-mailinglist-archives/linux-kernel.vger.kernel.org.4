Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578A870AECF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 18:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjEUQGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 12:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjEUQFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 12:05:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E92E40;
        Sun, 21 May 2023 09:05:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0091D6176E;
        Sun, 21 May 2023 16:05:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0700DC4339B;
        Sun, 21 May 2023 16:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684685134;
        bh=Kep8Iw8VgQxgpYvfyniHHN0kmqkyl1ojVYpvdIK/Gqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bdsxo0Bnw0VsHYH2A6RveJVq545eSK9UN1ptiHxy3Olr2UVrZOeL7GE8eshxkxXw8
         GuTK84yMkhgrgLPArlwIKohU2AY10Bg26A6+jAW009prjL5jNl6irkffuTwXIo8baR
         n40yFR7n6qvHgdJ1izX+FxPWLYM5h9RjCp3vQtFSd1tFYoPSXqwvCN76vAZFZe8lH5
         q6X8LWeMEreOU/ldpCKcsA0IqAZ1XAadqSmrQ4++aXn7ljs485xu+wUeszcPPZCxpA
         o8JnB1AfzenNyxFXHBDt1mAUf7nC7VIlK5Z+TSKRFDBgln4GtbcARyJJH3xqY+xNSk
         W0HaGJxEvUGSA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v6 11/20] ia64,export.h: replace EXPORT_DATA_SYMBOL* with EXPORT_SYMBOL*
Date:   Mon, 22 May 2023 01:04:16 +0900
Message-Id: <20230521160426.1881124-12-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230521160426.1881124-1-masahiroy@kernel.org>
References: <20230521160426.1881124-1-masahiroy@kernel.org>
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

With the previous refactoring, you can always use EXPORT_SYMBOL*.

Replace two instances in ia64, then remove EXPORT_DATA_SYMBOL*.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/ia64/kernel/head.S      | 2 +-
 arch/ia64/kernel/ivt.S       | 2 +-
 include/asm-generic/export.h | 3 ---
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/ia64/kernel/head.S b/arch/ia64/kernel/head.S
index f22469f1c1fc..c096500590e9 100644
--- a/arch/ia64/kernel/head.S
+++ b/arch/ia64/kernel/head.S
@@ -170,7 +170,7 @@ RestRR:											\
 	__PAGE_ALIGNED_DATA
 
 	.global empty_zero_page
-EXPORT_DATA_SYMBOL_GPL(empty_zero_page)
+EXPORT_SYMBOL_GPL(empty_zero_page)
 empty_zero_page:
 	.skip PAGE_SIZE
 
diff --git a/arch/ia64/kernel/ivt.S b/arch/ia64/kernel/ivt.S
index d6d4229b28db..7a418e324d30 100644
--- a/arch/ia64/kernel/ivt.S
+++ b/arch/ia64/kernel/ivt.S
@@ -87,7 +87,7 @@
 
 	.align 32768	// align on 32KB boundary
 	.global ia64_ivt
-	EXPORT_DATA_SYMBOL(ia64_ivt)
+	EXPORT_SYMBOL(ia64_ivt)
 ia64_ivt:
 /////////////////////////////////////////////////////////////////////////////////////////
 // 0x0000 Entry 0 (size 64 bundles) VHPT Translation (8,20,47)
diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index 0ae9f38a904c..570cd4da7210 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -8,7 +8,4 @@
  */
 #include <linux/export.h>
 
-#define EXPORT_DATA_SYMBOL(name)	EXPORT_SYMBOL(name)
-#define EXPORT_DATA_SYMBOL_GPL(name)	EXPORT_SYMBOL_GPL(name)
-
 #endif
-- 
2.39.2

