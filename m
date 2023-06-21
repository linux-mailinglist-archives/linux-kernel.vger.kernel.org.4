Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0214B7381CF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjFUKQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjFUKQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:16:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE48110F0;
        Wed, 21 Jun 2023 03:16:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E875C614FD;
        Wed, 21 Jun 2023 10:16:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAD9C433C0;
        Wed, 21 Jun 2023 10:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687342582;
        bh=zHSBUMeolRXKfp/Yo8BVUgIz5T+GFyJ1SF9F8vHu5rs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kUYS/39wW7sKEek9iEIIAK6FKAd6KmceDePeyBw/4UMyJ4lZiqtFejDQl8pxKiI0+
         G4dXkys30iWiJA5kwxqr0g8zFF877MdTsLWMKxDvOSmAQiWLQSZauO068wwSO7ZFYq
         bRT2gwy0zFsD1Z2yW1TDStKZYGLSJocvQdYwsC8zVLHLzvbg7NaPmLhy8Lg01Z3wbA
         Rxb/Iki/3Cg4t/RZKn1ZK0fgR02O/ZXhaFO3A/bnfkLdoSsGxik7SqWyDyRJP1j/82
         82ZRXEr27Z/GSAYObiQMu/7SgszTwTYeRKdM/PatpBPO7HxQE5YhNTrvPpBls505En
         zn29bQsuQkV0w==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 5/6] tty_audit: make tty pointers in exposed functions const
Date:   Wed, 21 Jun 2023 12:16:10 +0200
Message-ID: <20230621101611.10580-6-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621101611.10580-1-jirislaby@kernel.org>
References: <20230621101611.10580-1-jirislaby@kernel.org>
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

Both tty_audit_add_data() and tty_audit_tiocsti() need only to read from
the tty struct, so make the tty parameters of them both const. This
aids the compiler a bit.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty.h       | 11 ++++++-----
 drivers/tty/tty_audit.c |  5 +++--
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/tty.h b/drivers/tty/tty.h
index 1e0d80e98d26..89769a1f1f97 100644
--- a/drivers/tty/tty.h
+++ b/drivers/tty/tty.h
@@ -99,14 +99,15 @@ extern int tty_ldisc_autoload;
 
 /* tty_audit.c */
 #ifdef CONFIG_AUDIT
-void tty_audit_add_data(struct tty_struct *tty, const void *data, size_t size);
-void tty_audit_tiocsti(struct tty_struct *tty, char ch);
+void tty_audit_add_data(const struct tty_struct *tty, const void *data,
+			size_t size);
+void tty_audit_tiocsti(const struct tty_struct *tty, char ch);
 #else
-static inline void tty_audit_add_data(struct tty_struct *tty, const void *data,
-				      size_t size)
+static inline void tty_audit_add_data(const struct tty_struct *tty,
+				      const void *data, size_t size)
 {
 }
-static inline void tty_audit_tiocsti(struct tty_struct *tty, char ch)
+static inline void tty_audit_tiocsti(const struct tty_struct *tty, char ch)
 {
 }
 #endif
diff --git a/drivers/tty/tty_audit.c b/drivers/tty/tty_audit.c
index 6cf8b63368ee..5cbe28ac1763 100644
--- a/drivers/tty/tty_audit.c
+++ b/drivers/tty/tty_audit.c
@@ -134,7 +134,7 @@ void tty_audit_fork(struct signal_struct *sig)
 /*
  *	tty_audit_tiocsti	-	Log TIOCSTI
  */
-void tty_audit_tiocsti(struct tty_struct *tty, char ch)
+void tty_audit_tiocsti(const struct tty_struct *tty, char ch)
 {
 	dev_t dev;
 
@@ -199,7 +199,8 @@ static struct tty_audit_buf *tty_audit_buf_get(void)
  *
  *	Audit @data of @size from @tty, if necessary.
  */
-void tty_audit_add_data(struct tty_struct *tty, const void *data, size_t size)
+void tty_audit_add_data(const struct tty_struct *tty, const void *data,
+			size_t size)
 {
 	struct tty_audit_buf *buf;
 	unsigned int audit_tty;
-- 
2.41.0

