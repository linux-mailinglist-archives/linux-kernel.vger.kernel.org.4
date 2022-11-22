Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3389763487A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbiKVUkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbiKVUju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:39:50 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546DE716E3;
        Tue, 22 Nov 2022 12:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1669149584;
        bh=ow2wHboTcwRtSOUGXRGJ9ltX+L8eM9I6Nfqms25JGf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KzuJsJ+A54gpO+PRhoOUBboRSMMY965HVnq4OsxK2ZSH3HZusxjhQKnlhyKG16O6u
         N7/OlbG9xcJxngNN+hWkRaxKOt1TaN1wAk0jpTwztZpAI38yGfb3rBXo4QSOzlnGMR
         NK2brKziL4hZHD89/pc9swAvvdL5oDuuT8oY8k7ZyiD1HNqCi3VKfDVIibSM8vmKJk
         tD9knFgwE8z8RlLSOmUnkAHHv79ZjgV5OL462dHNdgSXm7Ois+Di29YGIpOJ2Jjbp8
         3aa5jysMcKJ1VP93M0e8kuJ8a30vephtFwoXQ8thLaKWpp2eRFDDHb9K3TpLurkvut
         3OSTDuq9ule5g==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NGx2S4KSZzXDS;
        Tue, 22 Nov 2022 15:39:44 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 01/30] selftests/rseq: Fix: Fail thread registration when CONFIG_RSEQ=n
Date:   Tue, 22 Nov 2022 15:39:03 -0500
Message-Id: <20221122203932.231377-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
References: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When linking the selftests against a libc which does not handle rseq
registration (before 2.35),  rseq thread registration silently succeed
even with CONFIG_RSEQ=n because it erroneously thinks that libc is
handling rseq registration.

This is caused by setting the rseq ownership flag only after the
rseq_available() check. It should rather be set before the
rseq_available() check.

Set the rseq_size to 0 (error value) immediately after the
rseq_available() check fails rather than in the thread registration
functions.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/rseq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 4177f9507bbe..376a73f1ac41 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -119,9 +119,11 @@ void rseq_init(void)
 		rseq_flags = *libc_rseq_flags_p;
 		return;
 	}
-	if (!rseq_available())
-		return;
 	rseq_ownership = 1;
+	if (!rseq_available()) {
+		rseq_size = 0;
+		return;
+	}
 	rseq_offset = (void *)&__rseq_abi - rseq_thread_pointer();
 	rseq_size = sizeof(struct rseq_abi);
 	rseq_flags = 0;
-- 
2.25.1

