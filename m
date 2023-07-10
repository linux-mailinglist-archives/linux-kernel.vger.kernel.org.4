Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4154974D01A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjGJIiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjGJIhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:37:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC6DC3;
        Mon, 10 Jul 2023 01:37:52 -0700 (PDT)
Date:   Mon, 10 Jul 2023 08:37:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688978271;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ilamyJDbICYtSDb02PIB2zgJt9yweTD8M1ng84MwQtQ=;
        b=yvC0+IPHasmDZAPNA/tb0hmOSfp/3yyOH4FFI8TPzUkrkomA6ew0odlx8y9qf6aZzPnjUR
        xdRHtaE/YuldyorlD5vcipUXK/FcsdKy4YNW/mqJpSeVvg3ibcXvU/V9dEorv5t3B0CRU4
        BIUokeaIxmBcEHjgKepNpYYmSxAPONrqrNwTfhKqA9YAE2g8MaqlPUvacqL5IlDkXetfdd
        qBuYTmh/B4cBJQx4CX0tTJ7hKrnyy78f9xdvSwNifipK0CONopMDBdkBqKZAnuM9Dz9mkM
        XlNdhvvpvELX5OnigvsU3l3NB96ERbFwduEDQSoSTkbtbuWzLPOOjhHOfFqiWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688978271;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ilamyJDbICYtSDb02PIB2zgJt9yweTD8M1ng84MwQtQ=;
        b=AtiqU7oQOKOd+xFWe3ucgcLxmVux0idjwNTHPEyjZhlikqzfphk/giRBlHB0g0zH0zqrFf
        847qAlusQXOm4hDg==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/ring_buffer: Use local_try_cmpxchg in
 __perf_output_begin
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230708090048.63046-2-ubizjak@gmail.com>
References: <20230708090048.63046-2-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <168897827031.404.10627731369793852895.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     1af61adb3a23192023fec1733bd4c8500f53e546
Gitweb:        https://git.kernel.org/tip/1af61adb3a23192023fec1733bd4c8500f53e546
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Sat, 08 Jul 2023 11:00:37 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 10 Jul 2023 09:52:36 +02:00

perf/ring_buffer: Use local_try_cmpxchg in __perf_output_begin

Use local_try_cmpxchg instead of local_cmpxchg (*ptr, old, new) == old
in __perf_output_begin.  x86 CMPXCHG instruction returns success in ZF
flag, so this change saves a compare after cmpxchg (and related move
instruction in front of cmpxchg).

Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg
fails. There is no need to re-read the value in the loop.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230708090048.63046-2-ubizjak@gmail.com
---
 kernel/events/ring_buffer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index a0433f3..fb1e180 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -191,9 +191,10 @@ __perf_output_begin(struct perf_output_handle *handle,
 
 	perf_output_get_handle(handle);
 
+	offset = local_read(&rb->head);
 	do {
+		head = offset;
 		tail = READ_ONCE(rb->user_page->data_tail);
-		offset = head = local_read(&rb->head);
 		if (!rb->overwrite) {
 			if (unlikely(!ring_buffer_has_space(head, tail,
 							    perf_data_size(rb),
@@ -217,7 +218,7 @@ __perf_output_begin(struct perf_output_handle *handle,
 			head += size;
 		else
 			head -= size;
-	} while (local_cmpxchg(&rb->head, offset, head) != offset);
+	} while (!local_try_cmpxchg(&rb->head, &offset, head));
 
 	if (backward) {
 		offset = head;
