Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A9A7282B0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237353AbjFHOZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237112AbjFHOZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:25:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056112D59;
        Thu,  8 Jun 2023 07:25:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E30B64E2A;
        Thu,  8 Jun 2023 14:24:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32260C433D2;
        Thu,  8 Jun 2023 14:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686234295;
        bh=W7P3iG4O3YjGApyRwNtiWKX5Kq+VmGX8uTvW8Ums99c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ntFv6gYKlgbdRwOlDg1ZciYIhnPhN2Yth0zSMBh1rlXZK4/QWKEvGYg1VqYJU7Q7Y
         7kPowQgOC8uSdSuIVTPw8oBH0M1YSfJjTwNZPmE3GP7hQP++wMeo+yIOFshXSfOxWM
         kmEdw4koner4TpL3XNp9u65JUDy2+93IeydEtbqQ6qHjVK+wsFMWA8O6UX3h4NtYdx
         NHVPrlm87C9dMQoa0JsB8wSfS0xHgoDuGdYQKSt4dq7x2V5PMg5WMimbx42hWDuqHX
         ibVrSlp+cCQLo4yDl8Ecy3T+AR9+MhywHQsT3hKNrWQiJ0Gz/6hniiRPANFG6WcLxk
         Fh0DE3EZ2xB+Q==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-um@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v7 11/11] linux/export.h: rename 'sec' argument to 'license'
Date:   Thu,  8 Jun 2023 23:24:28 +0900
Message-Id: <20230608142428.256985-12-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230608142428.256985-1-masahiroy@kernel.org>
References: <20230608142428.256985-1-masahiroy@kernel.org>
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

Now, EXPORT_SYMBOL() is populated in two stages. In the first stage,
all of EXPORT_SYMBOL/EXPORT_SYMBOL_GPL go into the same section,
.export_symbol.

'sec' does not make sense any more. Rename it to 'license'.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v7:
 - New patch

 include/linux/export.h | 8 ++++----
 include/linux/pm.h     | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/export.h b/include/linux/export.h
index fed2e5717461..b411fdb88720 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -46,11 +46,11 @@ extern struct module __this_module;
  * be reused in other execution contexts such as the UEFI stub or the
  * decompressor.
  */
-#define __EXPORT_SYMBOL(sym, sec, ns)
+#define __EXPORT_SYMBOL(sym, license, ns)
 
 #elif defined(__GENKSYMS__)
 
-#define __EXPORT_SYMBOL(sym, sec, ns)	__GENKSYMS_EXPORT_SYMBOL(sym)
+#define __EXPORT_SYMBOL(sym, license, ns)	__GENKSYMS_EXPORT_SYMBOL(sym)
 
 #elif defined(__ASSEMBLY__)
 
@@ -67,9 +67,9 @@ extern struct module __this_module;
 #endif /* CONFIG_MODULES */
 
 #ifdef DEFAULT_SYMBOL_NAMESPACE
-#define _EXPORT_SYMBOL(sym, sec)	__EXPORT_SYMBOL(sym, sec, __stringify(DEFAULT_SYMBOL_NAMESPACE))
+#define _EXPORT_SYMBOL(sym, license)	__EXPORT_SYMBOL(sym, license, __stringify(DEFAULT_SYMBOL_NAMESPACE))
 #else
-#define _EXPORT_SYMBOL(sym, sec)	__EXPORT_SYMBOL(sym, sec, "")
+#define _EXPORT_SYMBOL(sym, license)	__EXPORT_SYMBOL(sym, license, "")
 #endif
 
 #define EXPORT_SYMBOL(sym)		_EXPORT_SYMBOL(sym,)
diff --git a/include/linux/pm.h b/include/linux/pm.h
index aabb6bd8f89e..1810d776e84a 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -375,14 +375,14 @@ const struct dev_pm_ops name = { \
 }
 
 #ifdef CONFIG_PM
-#define _EXPORT_DEV_PM_OPS(name, sec, ns)				\
+#define _EXPORT_DEV_PM_OPS(name, license, ns)				\
 	const struct dev_pm_ops name;					\
-	__EXPORT_SYMBOL(name, sec, ns);					\
+	__EXPORT_SYMBOL(name, license, ns);				\
 	const struct dev_pm_ops name
 #define EXPORT_PM_FN_GPL(name)		EXPORT_SYMBOL_GPL(name)
 #define EXPORT_PM_FN_NS_GPL(name, ns)	EXPORT_SYMBOL_NS_GPL(name, ns)
 #else
-#define _EXPORT_DEV_PM_OPS(name, sec, ns)				\
+#define _EXPORT_DEV_PM_OPS(name, license, ns)				\
 	static __maybe_unused const struct dev_pm_ops __static_##name
 #define EXPORT_PM_FN_GPL(name)
 #define EXPORT_PM_FN_NS_GPL(name, ns)
-- 
2.39.2

