Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1853C60D543
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 22:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbiJYULs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 16:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiJYULj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 16:11:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F8A7A526
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 13:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=GQNMbODNLjgV6RJ0RGaO6u1ANw+MYd4DzgUTsmQMz8s=; b=tqi8rwcEyiK/lR7ccOEZObJwlg
        f6M0lfg4SINlmLYHQ179fgI9rnETIlOsHXQ/KEfxI1lqKrlvBYZkceL1bYoTeYndxrWRIQ+SMpqyd
        hlyrYdkx25pKDVpdz7dXhd/x8BsLqvMj4IkciQYunLQVFLpETxPFaB4cyYnZWubl611BWxh9t2mPW
        1M2zCQmC9SNK8Rqih6OjY3d46m6Uv58sj/3feY1nJ/yynLV7MPty9Bx2tcUc1sQ6mJ+EhZQB0Bg1p
        e8C0wbIZJeUmlY8YuB9V2CB5xusmSK/3C8HKvIyLm5cFUb4IDQKR7wVJTK6LmtR5I9+TUf0++cylJ
        jpv4vLLw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onQGm-00GWF9-Ud; Tue, 25 Oct 2022 20:11:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1020A300474;
        Tue, 25 Oct 2022 22:11:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9E7722C4502EA; Tue, 25 Oct 2022 22:11:22 +0200 (CEST)
Message-ID: <20221025201058.011279208@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 25 Oct 2022 22:07:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, rostedt@goodmis.org,
        dave.hansen@intel.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        keescook@chromium.org, seanjc@google.com
Subject: [PATCH 5/5] x86/mm: Do verify W^X at boot up
References: <20221025200656.951281799@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Straight up revert of commit:

  a970174d7a10 ("x86/mm: Do not verify W^X at boot up")

now that the root cause has been fixed.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/pat/set_memory.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -587,10 +587,6 @@ static inline pgprot_t verify_rwx(pgprot
 {
 	unsigned long end;
 
-	/* Kernel text is rw at boot up */
-	if (system_state == SYSTEM_BOOTING)
-		return new;
-
 	/*
 	 * 32-bit has some unfixable W+X issues, like EFI code
 	 * and writeable data being in the same page.  Disable


