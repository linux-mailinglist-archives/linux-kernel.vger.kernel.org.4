Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713BC608CF9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiJVLtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiJVLsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:48:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA20B24F785
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 04:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=VsbQJE2gXZYIdS3+vUbgKcHjJGGPNYaddyEXb2iNKwA=; b=R/Cm2B1BOg/6TAQKIgkjPpWVyg
        aJqvcmGvaLHJIyjHUTTOC9NQOLfcdXPVFDNmrXjpOfj2HRuokxNbnDFv/xyauV8LYwlc6vtAvUbv8
        qVx3drzMG8oj3vR8aj3v3JuvhjtGCrH6x8DIszHxZibmaxQOjKYKhniIsmx8QKAyVh8T0SzLH+L3N
        YIuC8UEvEF+f63BUsupCIiDX3G/ZGcBdpuKPmYfTMyl6VsHmFXx3eesedrDyRlojc94tKwrIsNqOg
        7SCZNRhzklPUgvlZ2P4w8vhBw28FFxoMep0YjTvSE0ICbGaBrTrF7eV5JUiFFZy5fsqJBBxZu0Mu4
        AbqXXtlw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1omCzQ-00Dtgp-6K; Sat, 22 Oct 2022 11:48:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 397173006B1;
        Sat, 22 Oct 2022 13:48:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 241D428B8E50B; Sat, 22 Oct 2022 13:48:26 +0200 (CEST)
Message-ID: <20221022114424.645657294@infradead.org>
User-Agent: quilt/0.66
Date:   Sat, 22 Oct 2022 13:14:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, willy@infradead.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux-mm@kvack.org, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de, ubizjak@gmail.com
Subject: [PATCH 03/13] sh/mm: Make pmd_t similar to pte_t
References: <20221022111403.531902164@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like 64bit pte_t, have a low/high split in pmd_t.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/sh/include/asm/pgtable-3level.h |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/arch/sh/include/asm/pgtable-3level.h
+++ b/arch/sh/include/asm/pgtable-3level.h
@@ -28,9 +28,15 @@
 #define pmd_ERROR(e) \
 	printk("%s:%d: bad pmd %016llx.\n", __FILE__, __LINE__, pmd_val(e))
 
-typedef struct { unsigned long long pmd; } pmd_t;
+typedef struct {
+	struct {
+		unsigned long pmd_low;
+		unsigned long pmd_high;
+	};
+	unsigned long long pmd;
+} pmd_t;
 #define pmd_val(x)	((x).pmd)
-#define __pmd(x)	((pmd_t) { (x) } )
+#define __pmd(x)	((pmd_t) { .pmd = (x) } )
 
 static inline pmd_t *pud_pgtable(pud_t pud)
 {


