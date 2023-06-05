Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0D8722F8A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbjFETQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235365AbjFETQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:16:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E68D120;
        Mon,  5 Jun 2023 12:16:20 -0700 (PDT)
Date:   Mon, 05 Jun 2023 19:16:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685992578;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xp5ZrpVKkqVRxduNNdNRC5w/LcOkwOaKJ54Z44eyCTk=;
        b=ofq6BglyqVuKR8V85QYJ1knwkDr74U/21MYNw0BXKKncRco417ugmriHHwlLJ5n2MZe1xu
        xXfl14kilyBESNoUvdPDbwptQ2cXWIebY6FGl+JxOKU/vE6ahINJJGM79revPo9fbtrb2g
        /gnl1TL4Yn2T65cfDfVucUBB0XzThTC8DxqWm7g1XpaRspN+nY/WSJyjouBA/huQPQahnO
        3ckwpgW4FwGtfyBdPIYLyyfe3RShFHSyeewJX0iwjomU8N/ABr+qe5qjbOVIPjqN4gAiMx
        RhqonS1buPJzt+zwRrM5u0JnmvKbfpcobQMmZoGoJ8BWHd274v2UTIgd8y5bkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685992578;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xp5ZrpVKkqVRxduNNdNRC5w/LcOkwOaKJ54Z44eyCTk=;
        b=JS7vp8n7aoBRBvp0NlA8zp94uD5IL7obJ/7rgvYjA4zL27nV6n/Ef1rMtoNd3wBErOylFK
        eGp3hkMUrXrU7qBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] math64: Always inline u128 version of mul_u64_u64_shr()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230519102715.637420396@infradead.org>
References: <20230519102715.637420396@infradead.org>
MIME-Version: 1.0
Message-ID: <168599257757.404.12337040567990260583.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fc4a0db4149afcdae2527f0d8c376accca34adc9
Gitweb:        https://git.kernel.org/tip/fc4a0db4149afcdae2527f0d8c376accca34adc9
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 19 May 2023 12:21:05 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 21:11:06 +02:00

math64: Always inline u128 version of mul_u64_u64_shr()

In order to prevent the following complaint from happening, always
inline the u128 variant of mul_u64_u64_shr() -- which is what x86_64
will use.

  vmlinux.o: warning: objtool: read_hv_sched_clock_tsc+0x5a: call to mul_u64_u64_shr.constprop.0() leaves .noinstr.text section

It should compile into something like:

  asm("mul	%[mul];"
      "shrd	%rdx, %rax, %cl"
      : "+&a" (a)
      : "c" shift, [mul] "r" (mul)
      : "d");

Which is silly not to inline, but it happens.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>  # Hyper-V
Link: https://lore.kernel.org/r/20230519102715.637420396@infradead.org
---
 include/linux/math64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/math64.h b/include/linux/math64.h
index 8b9191a..bf74478 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -168,7 +168,7 @@ static __always_inline u64 mul_u64_u32_shr(u64 a, u32 mul, unsigned int shift)
 #endif /* mul_u64_u32_shr */
 
 #ifndef mul_u64_u64_shr
-static inline u64 mul_u64_u64_shr(u64 a, u64 mul, unsigned int shift)
+static __always_inline u64 mul_u64_u64_shr(u64 a, u64 mul, unsigned int shift)
 {
 	return (u64)(((unsigned __int128)a * mul) >> shift);
 }
