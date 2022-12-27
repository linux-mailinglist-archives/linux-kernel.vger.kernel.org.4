Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C42C656AD6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 13:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiL0MQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 07:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbiL0MOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 07:14:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365F563FF;
        Tue, 27 Dec 2022 04:13:56 -0800 (PST)
Date:   Tue, 27 Dec 2022 12:13:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672143233;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hulIJpjMgo6pOe8FjgQRymuJwZUMCCYKSFHvu1/1r9s=;
        b=WJyri35SpY+6VrrUTSEbHH0xkbOZuOfXy8Kjw8BHu+XBiKcR1QePxGMRvBLeshfLkrvDVF
        s6Jn3lKXF6s/Bnus2PBXylzlI7Oot8S2GDFN8eRjP69q/yKMtbMQmPIQAKlq4sGk6wkGfI
        uonIOND3YW/UAiXPmgMFY7qCcKwUmw5C0CfY/1XogBK8F7BwJ5992tYQYRaMGK19vM8W1T
        My4HogM6o+ViKvDgjBE6bH1DBiDOGOoFADWDnAODBxS6F0kB4l8sWIM9ofFACGd8bIJVSy
        Flvsk9sVMoaUBmbmcOL9eeC2rc4ZfuEu7630DEfdpREEfVbFlONv1dTOy56eqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672143233;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hulIJpjMgo6pOe8FjgQRymuJwZUMCCYKSFHvu1/1r9s=;
        b=xoRZfHCSJyKy5ctgOrpsNzDVqqCbIVMkX5AsRuGZS6avlsyFda3HkJI6K6voa2x3kkxYc3
        PZRrcDye5Tf5aWBA==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] selftests/rseq: Fix: Fail thread registration when
 CONFIG_RSEQ=n
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221122203932.231377-2-mathieu.desnoyers@efficios.com>
References: <20221122203932.231377-2-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <167214323279.4906.12457162726827402464.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4842dadfc66f627083ec46c4e9a426e805c765f3
Gitweb:        https://git.kernel.org/tip/4842dadfc66f627083ec46c4e9a426e805c765f3
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Tue, 22 Nov 2022 15:39:03 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 27 Dec 2022 12:52:10 +01:00

selftests/rseq: Fix: Fail thread registration when CONFIG_RSEQ=n

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20221122203932.231377-2-mathieu.desnoyers@efficios.com
---
 tools/testing/selftests/rseq/rseq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 4177f95..376a73f 100644
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
