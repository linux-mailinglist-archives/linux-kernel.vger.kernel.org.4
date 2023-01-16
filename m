Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B0D66BE7C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjAPNA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjAPNAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:00:04 -0500
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF63F23C7A
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
        :Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=H5f0dObctcGnzYNS5KGN/jNVSS1kTkd181waoSAxSvw=; b=cgD4zmVP2OoYP4MI8wq+2clHDR
        /xVnmWPbgeK2ENXb7L0ewyg/2KAn04BUUKB1Kie+aggKj7G+hx0C/3B9RVdNxP2sqYWs5Q4Tg87YL
        qtuI0u7w3lDAkOd41A58hHptWK9l0238ICFoAiiblR2uSpxoAUggt87KA2W1HRFdDjb3Thd/zcWoy
        lQ0PjYMNUYOW1OdB0AG1s9yp1j78jI01B8AiIHr713TBc9jezlh403X5S+G30r/kxI2iq1h8vH27c
        7z1cWQAJZgI9L8+mNj2cbnFMeknE+pDzGYUS4QFsNM4Mp/GjA0DYiAK0GmqodKq6tEnez+hAXmAQ4
        tKzt2pzQ==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <anuradha@debian.org>)
        id 1pHP3W-008y6z-Gw; Mon, 16 Jan 2023 12:57:43 +0000
From:   Anuradha Weeraman <anuradha@debian.org>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     anuradha@debian.org
Subject: [PATCH] kernel/printk/printk.c: Fix W=1 kernel-doc warning
Date:   Mon, 16 Jan 2023 18:26:34 +0530
Message-Id: <20230116125635.374567-1-anuradha@debian.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=864; i=anuradha@debian.org; h=from:subject; bh=eT+JGkevGZaq8nqTmUmG8ZRflCJK93WPK/lWTjr5uew=; b=owEBbQKS/ZANAwAKAWNttaHZGGD9AcsmYgBjxUl9we/wsCMfDQYEDxhTCNKMn2GDX39a3+Td7RUd 9C8XKd6JAjMEAAEKAB0WIQT1a48U4BTN710Ef8FjbbWh2Rhg/QUCY8VJfQAKCRBjbbWh2Rhg/dA+D/ wOl1vch2Hejk50p0T5laT5I9P8Ji7DhERD3Sb8Q5lRqdN3RqlLFe76u75iwA1KJe23R4gQcaQNGVJg Uj+Gy2wFWKBbq3tgz46CJu+4VM+kMwxwhvwUcnSm9jRG1T0xm1IorAz0lRANzgUeOK/VIMenMSj26n zQgHFXTjjXPFH8G9Xb/CzBIDNlcJqSxIMI3luh5v0l88cuQm74dzsg7ZXRdAYOAWQ6b9M3RwNFwzjd fWG8Xw2kqbgx4d4zUhjMimUL1p+onLcffP3Un9RwM5s5Eg+EKZOA9GNOqBjRiJ7RNL2uWLStrDVVm0 czdis0aSRUthCyedgDjg568G2QfJzZPnxB09Qe8XchdiG7f9b3gtH9qAA5fN99hkBXkJPKiMeqUfNp g7Sw+Un5jtJkSTZ0A/IDvLCPvcDXer0/7ELmNoX0uHDE4tGnlflMAMSQG9QdfrxbcU4Det6HSJWGEy GTyNVQYqLWTGpyMvBslwiSGEE6q431XGPMyLMYk+47ZWcRfWS+JFOyIZ2YlApiCQeB3xEr4vmeWaiF cuK55385DbGNwJAM/GRd25DLe7RzJ+4mMtSfhwzHr1YT4TleJY+/P2mXWHkPffIwlcHpuprxf0c+YU hp4w3ZYsfxkTav1NMcCHnpy0Btpc2nLaDqlx1QaTyfAvo1ulrj6iv2K9FvKw==
X-Developer-Key: i=anuradha@debian.org; a=openpgp; fpr=F56B8F14E014CDEF5D047FC1636DB5A1D91860FD
Content-Transfer-Encoding: 8bit
X-Debian-User: anuradha
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 kernel-doc warning:

kernel/printk/printk.c:
 - Include function parameter in console_lock_spinning_disable_and_check()

Signed-off-by: Anuradha Weeraman <anuradha@debian.org>
---
 kernel/printk/printk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 7decf1e9c486..557eba131210 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1891,6 +1891,7 @@ static void console_lock_spinning_enable(void)
 /**
  * console_lock_spinning_disable_and_check - mark end of code where another
  *	thread was able to busy wait and check if there is a waiter
+ * @cookie: cookie returned from console_srcu_read_lock()
  *
  * This is called at the end of the section where spinning is allowed.
  * It has two functions. First, it is a signal that it is no longer
-- 
2.39.0

