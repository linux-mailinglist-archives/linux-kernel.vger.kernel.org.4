Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0737775014D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjGLIWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbjGLIWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:22:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154BD211E;
        Wed, 12 Jul 2023 01:18:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC40A61701;
        Wed, 12 Jul 2023 08:18:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C91AC43391;
        Wed, 12 Jul 2023 08:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689149905;
        bh=vMEJDNVDcU7o0hEOegJraWVY9ugVX7jsjZoDifkGRBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bA7paH+8flZaPCa+S46P1vL4ijSi3gCylPSNvdK9owUCAdmIW8Ex4tkdDUVMI2d8Q
         OqPd8fU9Pa4A9VY/lDxU05KZGx3gCqDkHlocSc8rvrapT+G/jYYdGLTyiNtzqKtquq
         AIhlyq90idWR3zC32bXj7bIYAFqYCYKQsOXjjIWfYlQskXegHLL1QRplbLM+XbFm4m
         YGkzIP1iz8c4mmbhFIxci0MjMhZx4+iscNbMwxnnQbiv0fQ9jExKG60w6slvQ0v5Fz
         fC8y7GDQsOFTm0Hu1OQoz0MUuWsLuD+Z6u5Vtu6Ec5hoQNowYQaSlmKLZH494XAOLA
         E7fG11gVmfQCg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 03/10] tty: sysrq: switch the rest of keys to u8
Date:   Wed, 12 Jul 2023 10:18:04 +0200
Message-ID: <20230712081811.29004-4-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712081811.29004-1-jirislaby@kernel.org>
References: <20230712081811.29004-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Propagate u8 more from the bottom to the interface, so that sysrq
callers (usually drivers) see that u8 is expected.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/sysrq.c   | 16 ++++++++--------
 include/linux/sysrq.h | 16 ++++++++--------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 1271a82c0887..ccf429ba348e 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -530,7 +530,7 @@ static const struct sysrq_key_op *sysrq_key_table[62] = {
 };
 
 /* key2index calculation, -1 on invalid index */
-static int sysrq_key_table_key2index(int key)
+static int sysrq_key_table_key2index(u8 key)
 {
 	int retval;
 
@@ -548,7 +548,7 @@ static int sysrq_key_table_key2index(int key)
 /*
  * get and put functions for the table, exposed to modules.
  */
-static const struct sysrq_key_op *__sysrq_get_key_op(int key)
+static const struct sysrq_key_op *__sysrq_get_key_op(u8 key)
 {
 	const struct sysrq_key_op *op_p = NULL;
 	int i;
@@ -560,7 +560,7 @@ static const struct sysrq_key_op *__sysrq_get_key_op(int key)
 	return op_p;
 }
 
-static void __sysrq_put_key_op(int key, const struct sysrq_key_op *op_p)
+static void __sysrq_put_key_op(u8 key, const struct sysrq_key_op *op_p)
 {
 	int i = sysrq_key_table_key2index(key);
 
@@ -568,7 +568,7 @@ static void __sysrq_put_key_op(int key, const struct sysrq_key_op *op_p)
 		sysrq_key_table[i] = op_p;
 }
 
-void __handle_sysrq(int key, bool check_mask)
+void __handle_sysrq(u8 key, bool check_mask)
 {
 	const struct sysrq_key_op *op_p;
 	int orig_log_level;
@@ -627,7 +627,7 @@ void __handle_sysrq(int key, bool check_mask)
 	suppress_printk = orig_suppress_printk;
 }
 
-void handle_sysrq(int key)
+void handle_sysrq(u8 key)
 {
 	if (sysrq_on())
 		__handle_sysrq(key, true);
@@ -1111,7 +1111,7 @@ int sysrq_toggle_support(int enable_mask)
 }
 EXPORT_SYMBOL_GPL(sysrq_toggle_support);
 
-static int __sysrq_swap_key_ops(int key, const struct sysrq_key_op *insert_op_p,
+static int __sysrq_swap_key_ops(u8 key, const struct sysrq_key_op *insert_op_p,
 				const struct sysrq_key_op *remove_op_p)
 {
 	int retval;
@@ -1135,13 +1135,13 @@ static int __sysrq_swap_key_ops(int key, const struct sysrq_key_op *insert_op_p,
 	return retval;
 }
 
-int register_sysrq_key(int key, const struct sysrq_key_op *op_p)
+int register_sysrq_key(u8 key, const struct sysrq_key_op *op_p)
 {
 	return __sysrq_swap_key_ops(key, op_p, NULL);
 }
 EXPORT_SYMBOL(register_sysrq_key);
 
-int unregister_sysrq_key(int key, const struct sysrq_key_op *op_p)
+int unregister_sysrq_key(u8 key, const struct sysrq_key_op *op_p)
 {
 	return __sysrq_swap_key_ops(key, NULL, op_p);
 }
diff --git a/include/linux/sysrq.h b/include/linux/sysrq.h
index bb8d07814b0e..bdca467ebb77 100644
--- a/include/linux/sysrq.h
+++ b/include/linux/sysrq.h
@@ -43,10 +43,10 @@ struct sysrq_key_op {
  * are available -- else NULL's).
  */
 
-void handle_sysrq(int key);
-void __handle_sysrq(int key, bool check_mask);
-int register_sysrq_key(int key, const struct sysrq_key_op *op);
-int unregister_sysrq_key(int key, const struct sysrq_key_op *op);
+void handle_sysrq(u8 key);
+void __handle_sysrq(u8 key, bool check_mask);
+int register_sysrq_key(u8 key, const struct sysrq_key_op *op);
+int unregister_sysrq_key(u8 key, const struct sysrq_key_op *op);
 extern const struct sysrq_key_op *__sysrq_reboot_op;
 
 int sysrq_toggle_support(int enable_mask);
@@ -54,20 +54,20 @@ int sysrq_mask(void);
 
 #else
 
-static inline void handle_sysrq(int key)
+static inline void handle_sysrq(u8 key)
 {
 }
 
-static inline void __handle_sysrq(int key, bool check_mask)
+static inline void __handle_sysrq(u8 key, bool check_mask)
 {
 }
 
-static inline int register_sysrq_key(int key, const struct sysrq_key_op *op)
+static inline int register_sysrq_key(u8 key, const struct sysrq_key_op *op)
 {
 	return -EINVAL;
 }
 
-static inline int unregister_sysrq_key(int key, const struct sysrq_key_op *op)
+static inline int unregister_sysrq_key(u8 key, const struct sysrq_key_op *op)
 {
 	return -EINVAL;
 }
-- 
2.41.0

