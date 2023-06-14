Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBD5730218
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245009AbjFNOgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236343AbjFNOf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:35:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAABC195
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=88ZKgCe2//v5jmKae4EuHHnmVgU2x6s/oducDio9McM=; b=VrhpZbueTpAwrvJGMU003DGQRZ
        mdpH8af1Idf+HjZeHMMzdlZMyVJ5mnE0IjiK11Ao9rDgknd7MnQhZlxYsPh+yAT+JBFr5F7rH4vj/
        fIrusPPfEHm1CnV4cpbnskrDJNcVHI3T5nGOgpFmxxNzRAk56ZwPlTkh67Sn6e9Z61nVtar7YKJlA
        D/5A0IxGOec+pHz7QcvzMoHyBnS0rlaooOWFJg3WuIRW9WiUudyrWFdWdXKlkPs1rgVKZe6WpHH+c
        qu4jXDDoQ1X+iYKh8E0nhLfOq8ARUB68QoF5C5UQfaPACPEDGkwJjgQ5KP8lCJvzrevVsJx7veQiU
        aOn4FMPQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9RbE-006QUv-KZ; Wed, 14 Jun 2023 14:35:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1B2F0300188;
        Wed, 14 Jun 2023 16:35:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 018C827F86ACC; Wed, 14 Jun 2023 16:35:50 +0200 (CEST)
Date:   Wed, 14 Jun 2023 16:35:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH] x86/alternative: PAUSE is not a NOP
Message-ID: <20230614143550.GL1639749@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: x86/alternative: PAUSE is not a NOP
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed Jun 14 16:31:35 CEST 2023

While chasing ghosts, I did notice that optimize_nops() was replacing
'REP NOP' aka 'PAUSE' with NOP2. This is clearly not right.

Fixes: 6c480f222128 ("x86/alternative: Rewrite optimize_nops() some")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/linux-next/20230524130104.GR83892@hirez.programming.kicks-ass.net/
---
 arch/x86/kernel/alternative.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -169,9 +169,12 @@ void text_poke_early(void *addr, const v
  */
 static bool insn_is_nop(struct insn *insn)
 {
-	if (insn->opcode.bytes[0] == 0x90)
+	/* Anything NOP, but no REP NOP */
+	if (insn->opcode.bytes[0] == 0x90 &&
+	    (!insn->prefixes.nbytes || insn->prefixes.bytes[0] != 0xF3))
 		return true;
 
+	/* NOPL */
 	if (insn->opcode.bytes[0] == 0x0F && insn->opcode.bytes[1] == 0x1F)
 		return true;
 
