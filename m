Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817B7627CB1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235900AbiKNLps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236666AbiKNLpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:45:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F055222BA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:44:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD35E61029
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10ED3C433D7;
        Mon, 14 Nov 2022 11:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426281;
        bh=Vpg6dWTArUNw6H1lp7TcQixC3uvVmofgAH+VJ8M/i8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q0s1lYPlaouNk03bC26jwsoY4uhDQn4c/yiJljQW+qknmxh2wfkw8UMc4xzmdLbwb
         8EK/BGDTUVjnZgsMyONGcULwuWqCX3z31MbWTfr51XDNW9qiS3m8STiTX5QB16N2E/
         vGQ3IL2EqJ1dc3MJ6AVlp6V/yqwWHyZCn/hTlDsL+x1v9O9ZO6RGXaD6SUr8lX5cwH
         Qoy/f7mfPdppxhBeD0rz6ra4XwgbgfkzkVaAatAIY7IUdoMD5hruELQaEXTVWdoTQN
         fC8SpRDcxbqjzrelOgX31DQsloDxNfNW+OWanKD/bo0A1q3yV72l6aAXPdpjh+L4bL
         JKJd/i3tYjV5Q==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>, Martin Liska <mliska@suse.cz>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 19/46] export, lto: Mark __kstrtab* in EXPORT_SYMBOL() as global and __visible
Date:   Mon, 14 Nov 2022 12:43:17 +0100
Message-Id: <20221114114344.18650-20-jirislaby@kernel.org>
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

From: Andi Kleen <ak@linux.intel.com>

Symbols referenced from assembler (either directly or e.f. from
DEFINE_STATIC_KEY()) need to be global and visible in gcc LTO because
they could end up in a different object file than the assembler. This
can lead to linker errors without this patch.

So mark __kstrtab_*[] and __kstrtabns_*[] symbols as global and
__visible.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/export.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/export.h b/include/linux/export.h
index 3f31ced0d977..3cb5f85327da 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -85,11 +85,13 @@ struct kernel_symbol {
  */
 #define ___EXPORT_SYMBOL(sym, sec, ns)						\
 	extern typeof(sym) sym;							\
-	extern const char __kstrtab_##sym[];					\
-	extern const char __kstrtabns_##sym[];					\
+	extern const char __visible __kstrtab_##sym[];				\
+	extern const char __visible __kstrtabns_##sym[];			\
 	asm("	.section \"__ksymtab_strings\",\"aMS\",%progbits,1	\n"	\
+	    "	.globl __kstrtab_" #sym "				\n"	\
 	    "__kstrtab_" #sym ":					\n"	\
 	    "	.asciz 	\"" #sym "\"					\n"	\
+	    "	.globl __kstrtabns_" #sym "				\n"	\
 	    "__kstrtabns_" #sym ":					\n"	\
 	    "	.asciz 	\"" ns "\"					\n"	\
 	    "	.previous						\n");	\
-- 
2.38.1

