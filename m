Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94E86242AE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiKJM67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiKJM6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:58:45 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5219C70198
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 04:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=69SLcLIsDhF1CjVYnMtPLtLafQoTPWsbqqCXMi0foHc=; b=aao/1O515RcVd5zFc8nqYMfrBm
        vkQICFFzeHIiyP07SS06G1lP1QBXibO5T22nVRwTUeqb0smoTQpVVnm7jPQAtQpg9sP7bq6GV7eRk
        aJvID8I0FeRTadexQ77fpyV9sQ1Ct4Ch2QdU+WtwGwZtOTm6cE3jMA97f1vsLWpLbDXSRMJyuDVHW
        m0ifOp6g2hNYyBiza4dEgVWswZog3e0Bv6oKlSU87KGLp6dLIi5wDv9Np5Q7HpujZQeRvPx9gD7GR
        oYK5VfU4qVAgetSlXlsHUqx4VFCnBtoG6y9V212KuhNczE/KjGra5KPotuIerwHX/IRhCU8Dd+iWc
        eqXPBKMQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ot78X-00AHCe-A2; Thu, 10 Nov 2022 12:58:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CAC7B30041D;
        Thu, 10 Nov 2022 13:58:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A22C32B97261E; Thu, 10 Nov 2022 13:58:27 +0100 (CET)
Message-ID: <20221110125544.460677011@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 10 Nov 2022 13:52:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, dave.hansen@intel.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, oliver.sang@intel.com
Subject: [PATCH 1/4] x86/mm: Add a few comments
References: <20221110125253.240704966@infradead.org>
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

It's a shame to hide useful comments in Changelogs, add some to the
code.

Shamelessly stolen from commit:

  c40a56a7818c ("x86/mm/init: Remove freed kernel image areas from alias mapping")

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/pat/set_memory.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -219,6 +219,17 @@ within_inclusive(unsigned long addr, uns
 
 #ifdef CONFIG_X86_64
 
+/*
+ * The kernel image is mapped into two places in the virtual address space
+ * (addresses without KASLR, of course):
+ *
+ * 1. The kernel direct map (0xffff880000000000)
+ * 2. The "high kernel map" (0xffffffff81000000)
+ *
+ * We actually execute out of #2. If we get the address of a kernel symbol, it
+ * points to #2, but almost all physical-to-virtual translations point to #1.
+ */
+
 static inline unsigned long highmap_start_pfn(void)
 {
 	return __pa_symbol(_text) >> PAGE_SHIFT;
@@ -1626,6 +1637,9 @@ static int __change_page_attr(struct cpa
 
 static int __change_page_attr_set_clr(struct cpa_data *cpa, int checkalias);
 
+/*
+ * Check the directmap and "high kernel map" 'aliases'.
+ */
 static int cpa_process_alias(struct cpa_data *cpa)
 {
 	struct cpa_data alias_cpa;


