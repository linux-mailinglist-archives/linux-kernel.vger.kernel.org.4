Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0023660CE61
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbiJYOHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbiJYOGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:06:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E908020994
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=REfMQ1RdEpVyUzySzj9Bkqd8DQjBeT8TAjFpXQlnMsk=; b=PgTusGgFb3PRGNv+C1ESjNjxd7
        8QUGiuVEVzq11SGEnBgqCGkBo5wRC+NzwM9K/qtQoRMzV99JbqIodseifqnL2xvVNevW0ZRtucpCU
        u+ypS1Rnta4emYzHktmZw8VyfQH3vUEpg9jD3feSOCSZ9ZmmyjXJB8iwvpPOgdZSRD27qdjv7XeHU
        dQJOMG1a8lD9kLvGvxkP5Y5oSVYHDVT7xos8IjACkeY2ozPHXAKWAlfzHc0IhZaQjPS2Z4PAnx57G
        2zkEBNaZXZk3KDbOBO5hVLVao3TKK8FEeJ0AZM54+z8FHnIchDUtWK+wC1/nmCtN+1xCg3ES3uxf1
        vk5xG1fA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onKVU-00GJZz-UY; Tue, 25 Oct 2022 14:02:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9DD1F300656;
        Tue, 25 Oct 2022 16:02:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 886CF2C356CB6; Tue, 25 Oct 2022 16:02:11 +0200 (CEST)
Date:   Tue, 25 Oct 2022 16:02:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, x86@kernel.org,
        willy@infradead.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de, ubizjak@gmail.com
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
Message-ID: <Y1fsYwshJ93FT21r@hirez.programming.kicks-ass.net>
References: <20221022111403.531902164@infradead.org>
 <20221022114424.515572025@infradead.org>
 <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com>
 <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net>
 <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 09:58:07PM +0200, Jann Horn wrote:

> Unless I'm completely misunderstanding what's going on here, the whole
> "remove_table" thing only happens when you "remove a table", meaning
> you free an entire *pagetable*. Just zapping PTEs doesn't trigger that
> logic.

Aah; yes true. OTOH even it that were not so, I think it would still be
broken because the current code relies on the TLB flush to have
completed, whereas the RCU scheme is effectively async and can be
considered pending until the callback runs.

Hurmph... easiest fix is probably to dis-allow kvm_flush_tlb_multi()
for i386-pae builds.

Something like so... nobody in his right mind should care about i386-pae
virt performance much.

---
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 95fb85bea111..cbfb84e88251 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -473,6 +473,12 @@ static DEFINE_PER_CPU(cpumask_var_t, __pv_cpu_mask);
 
 static bool pv_tlb_flush_supported(void)
 {
+	/*
+	 * i386-PAE split loads are incompatible with optimized TLB flushes.
+	 */
+	if (IS_ENABLED(CONFIG_GUP_GET_PTE_LOW_HIGH))
+		return false;
+
 	return (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH) &&
 		!kvm_para_has_hint(KVM_HINTS_REALTIME) &&
 		kvm_para_has_feature(KVM_FEATURE_STEAL_TIME) &&
