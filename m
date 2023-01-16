Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EE066C2BA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjAPOw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjAPOwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:52:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43522BF13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Mc6JE/lSqhoI08ZCOd1MO1vmLEzmsp/ETRSpv4hRS+8=; b=T1nrQTJttu/3Jnm9EJrYVDiMxC
        s34Y8QKh6Os9ywtC1Z1w2DiWPN6Xf9K5GkRtu6DtxWWsA8ej0VDBcu9iVcitzgXSTWCKMPsZsT/yv
        UyAjSANcObXIQvCe1J1cb2ZFm0PgpHHKh22ywjkdRZY49ET7hYiwVX9R/AkWzL156Ux4u1mcKbpW3
        wubPrTdQVa+IM+KQkoM2pcN0SQ8YrHNTvKlSQpXlxOMZ0Z7Y2ts9qxviLI1ZgAHkTz7oQ5Z95SZu9
        jTowvNgMdlt4jqLsw2QD7LpDyIe1S1Qwn8XSQdU41tuNFe9PXsjS6ESqii8W89Nd11lkxG5d+ERsF
        kQkbM/9A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHQcU-008oZF-RG; Mon, 16 Jan 2023 14:37:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 56162300C6F;
        Mon, 16 Jan 2023 15:37:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B9FA620EF0A23; Mon, 16 Jan 2023 15:37:38 +0100 (CET)
Message-ID: <20230116143645.829076358@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 16 Jan 2023 15:25:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, Joan Bruguera <joanbrugueram@gmail.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Jan Beulich <jbeulich@suse.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        Kees Cook <keescook@chromium.org>, mark.rutland@arm.com,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 5/7] x86/callthunk: No callthunk for restore_processor_state()
References: <20230116142533.905102512@infradead.org>
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

From: Joan Bruguera <joanbrugueram@gmail.com>

When resuming from suspend we don't have coherent CPU state, trying to
do callthunks here isn't going to work. Specifically GS isn't set yet.

Fixes: e81dc127ef69 ("x86/callthunks: Add call patching for call depth tracking")
Signed-off-by: Joan Bruguera <joanbrugueram@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230109040531.7888-1-joanbrugueram@gmail.com
---
 arch/x86/kernel/callthunks.c |    5 +++++
 arch/x86/power/cpu.c         |    3 +++
 2 files changed, 8 insertions(+)

--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -7,6 +7,7 @@
 #include <linux/memory.h>
 #include <linux/moduleloader.h>
 #include <linux/static_call.h>
+#include <linux/suspend.h>
 
 #include <asm/alternative.h>
 #include <asm/asm-offsets.h>
@@ -151,6 +152,10 @@ static bool skip_addr(void *dest)
 	    dest < (void*)hypercall_page + PAGE_SIZE)
 		return true;
 #endif
+#ifdef CONFIG_PM_SLEEP
+	if (dest == restore_processor_state)
+		return true;
+#endif
 	return false;
 }
 


