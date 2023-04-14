Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23376E2625
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjDNOsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjDNOsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:48:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7007DB6;
        Fri, 14 Apr 2023 07:48:00 -0700 (PDT)
Date:   Fri, 14 Apr 2023 14:47:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681483676;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GyQpTxd1zzamu2vNd/KzheAQNFpYlN2xXq44JyXZpu8=;
        b=J0aPfTtYtSxRqUgLOTrmaSZ+6R3YfCVHmnciKqLgd7LAHuxEiTf6WiQYJnqyO9SrktS9yA
        VNpQsjwDw/rL+1iFecuNQHvMoVyCKUiJ6nRzbLAa1NKqfEqFalNPKZnw6XOORj7GIYR7VW
        iofkqE7A+vhLK6cYmfachkFAg8AHg8pi5IrvpScGXTxb0lsh6jEZraD14hLJcP/LKTHqBO
        qR5N3imPZ6GjmRJ4GJZsgrTrR9hsaA5M+Y1dwYV4Ej0hGyb5GjYTuQlA9vpqropz/8D7j+
        tAo6RraNciDIS3lt3T5SObruA7htb7N6ek4E0cCtgcDTXVw3ZaMAdSzscDhWxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681483676;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GyQpTxd1zzamu2vNd/KzheAQNFpYlN2xXq44JyXZpu8=;
        b=z2+X11UFvqvoFJYiosJrk0Rf5e7YLskr11TtumuApR05wf+7hXJR4TerBQTJNf055nWXHT
        T9GpqVkXRvp4weBA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Add stackleak instrumentation to uaccess
 safe list
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <42e9b487ef89e9b237fd5220ad1c7cf1a2ad7eb8.1681320562.git.jpoimboe@kernel.org>
References: <42e9b487ef89e9b237fd5220ad1c7cf1a2ad7eb8.1681320562.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168148367644.404.15894767923207222447.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     7f530fba1123edcad00d59e1a73019814935f0c1
Gitweb:        https://git.kernel.org/tip/7f530fba1123edcad00d59e1a73019814935f0c1
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 12 Apr 2023 10:29:35 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Apr 2023 16:08:27 +02:00

objtool: Add stackleak instrumentation to uaccess safe list

If a function has a large stack frame, the stackleak plugin adds a call
to stackleak_track_stack() after the prologue.

This function may be called in uaccess-enabled code.  Add it to the
uaccess safe list.

Fixes the following warning:

  vmlinux.o: warning: objtool: kasan_report+0x12: call to stackleak_track_stack() with UACCESS enabled

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/42e9b487ef89e9b237fd5220ad1c7cf1a2ad7eb8.1681320562.git.jpoimboe@kernel.org
---
 tools/objtool/check.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 9440b07..4c8ef81 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1279,6 +1279,8 @@ static const char *uaccess_safe_builtin[] = {
 	"__ubsan_handle_type_mismatch_v1",
 	"__ubsan_handle_shift_out_of_bounds",
 	"__ubsan_handle_load_invalid_value",
+	/* STACKLEAK */
+	"stackleak_track_stack",
 	/* misc */
 	"csum_partial_copy_generic",
 	"copy_mc_fragile",
