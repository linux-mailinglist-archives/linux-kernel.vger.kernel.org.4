Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8B3667828
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239975AbjALOx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239922AbjALOwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:52:50 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382FA61478
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=T4GElGxaw5tEx2Lk6kKh2cwaswlijZP7pkxV7zD03yo=; b=dWjbmZzwf1WthR8TZ23ii1la+e
        yq8CeiWkZUYxPcP3zDoAdsjLQyUEFEwNBnojffsrWtXWwvZrVG3BvxUWfoXFoIemIzZBR3dchks7+
        30N+pLzv0Pq6fFF2X2CREioQEU6u9ZSI0QUhXVxyjoBTLRnevuU+BOKb90OE9rtHZxNFKkdIcFvCY
        0iBTtIbHpzJidWwd/VU+wg+DB3e1nBkUqzz+681wC9mH4sjUCyB8tmW0qAnc1AaOtsfRWMMqx6gco
        h5cNcMDHwQrxlAKs+W9Qc14+/gh6t51ElNBLBGLZWjnaQvksAwmhxVjKsZ7qqyNZZupTDL6qmnpHt
        IQaqbR8A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pFyjS-0040tD-11;
        Thu, 12 Jan 2023 14:39:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EC89A300C6F;
        Thu, 12 Jan 2023 15:39:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BAAF42CC8C6A1; Thu, 12 Jan 2023 15:39:12 +0100 (CET)
Message-ID: <20230112143825.704223863@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 12 Jan 2023 15:31:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, Joan Bruguera <joanbrugueram@gmail.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Jan Beulich <jbeulich@suse.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        Kees Cook <keescook@chromium.org>, mark.rutland@arm.com
Subject: [RFC][PATCH 3/6] x86/callthunk: No callthunk for restore_processor_state()
References: <20230112143141.645645775@infradead.org>
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
 


