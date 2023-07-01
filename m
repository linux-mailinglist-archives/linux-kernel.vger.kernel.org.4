Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8730E744748
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 08:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjGAGv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 02:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjGAGvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 02:51:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5266E55A7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 23:45:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E1C760C85
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 06:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EC1C433C7;
        Sat,  1 Jul 2023 06:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688193903;
        bh=+VjO8L7CNRL1kWBXYJ2LUOmXcZ543o1WFIfIJyf4E94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dCledtXWs5vSc1zL+VXKhCk4dzqVxRNRbfB4B+ZOsIHpRAzSX+X3xiK9rEO64Vua6
         hYd8y+zZXB1/21Y94R0ZhZjfawdFXNQftx3ACksReShPFFH54iUYrqKcH6xJT1ImfT
         PIXwBgl1xLzPUH6yW1waK21v0UTxGjkF6bgfjg4edJy80FqzP55q6Am2x5KGKS2bM0
         0RKmPmYeK+OYp50CveY5Ey7zAamPWxNW0EVeuZqsHkfrkXt+nzfxlcAajH8ktiV1Bn
         eEu4Y1sbkd/IWlJE+vs3yl/lWJkUUaGArY2Ej/jkl5UhMYDrJIvKn5X5K/k21Rspk8
         yOkPs4nbdFoOg==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] pid: use struct_size_t() helper
Date:   Sat,  1 Jul 2023 08:44:44 +0200
Message-Id: <20230701-antrieb-rundbau-4b30efb507b2@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202306300950.2BE7567101@keescook>
References: 
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2058; i=brauner@kernel.org; h=from:subject:message-id; bh=+VjO8L7CNRL1kWBXYJ2LUOmXcZ543o1WFIfIJyf4E94=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTMPx0sLvgpXC2Omd3tzO0T+/eKWs0rUpXpzOlVe9U66ej+ pk8GHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPp2cTIMKtOlMeQ56WDmekPlu0am+ +U7ZRX50vIer12ZbD0kTr5Iob/+QnzGHY8tFq0fJPGDBVuFY0YE96yP/+4Ds58e2PTfevfXAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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

Before commit d67790ddf021 ("overflow: Add struct_size_t() helper") only
struct_size() existed, which expects a valid pointer instance containing
the flexible array.

However, when we determine the default struct pid allocation size for
the associated kmem cache of a pid namespace we need to take the nesting
depth of the pid namespace into account without an variable instance
necessarily being available.

In commit b69f0aeb0689 ("pid: Replace struct pid 1-element array with
flex-array") we used to handle this the old fashioned way and cast NULL
to a struct pid pointer type. However, we do apparently have a dedicated
struct_size_t() helper for exactly this case. So switch to that.

Suggested-by: Kees Cook <keescook@chromium.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/pid.c           | 2 +-
 kernel/pid_namespace.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index 8bce3aebc949..6a1d23a11026 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -657,7 +657,7 @@ void __init pid_idr_init(void)
 	idr_init(&init_pid_ns.idr);
 
 	init_pid_ns.pid_cachep = kmem_cache_create("pid",
-			struct_size((struct pid *)NULL, numbers, 1),
+			struct_size_t(struct pid, numbers, 1),
 			__alignof__(struct pid),
 			SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT,
 			NULL);
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 70a929784a5d..0bf44afe04dd 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -48,7 +48,7 @@ static struct kmem_cache *create_pid_cachep(unsigned int level)
 		return kc;
 
 	snprintf(name, sizeof(name), "pid_%u", level + 1);
-	len = struct_size((struct pid *)NULL, numbers, level + 1);
+	len = struct_size_t(struct pid, numbers, level + 1);
 	mutex_lock(&pid_caches_mutex);
 	/* Name collision forces to do allocation under mutex. */
 	if (!*pkc)

base-commit: a507db1d8fdc39802415e4d2ef6d1aecd67927fa
-- 
2.34.1

