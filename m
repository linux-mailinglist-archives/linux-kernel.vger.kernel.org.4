Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4AE60D545
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 22:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiJYUL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 16:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbiJYULj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 16:11:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1127A745
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 13:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=vqWW09KISKCCkh6u5sz08Jb6XS7CEV1aGc6COZk9VFQ=; b=jI2MOKllzRXOLxYgNpNI5zP8AR
        6vVHJ9pMxNaFqfykRbCzkdDD5JoPCx8VxkPq3CsnbrS/Vi8rwS0u1F1+0egrRNW6rE9OY0T634rfo
        zPi8k7n/tsYogemzZhDQBc9/+IUcoDgaebRmNKbIbp3GooFmTyWswoXcfB03Ig0uI+GcaWW4bgAtj
        /2dfF8jHhHI48rkAOHWUA8mVvZ34zkXUCwzhRtUxAwhL6W64Aj6uzdGOgs7CZMnfmgIQVVRjxm2WZ
        cGX2XXJDq1EnEjaqPly5FCf9MVwiy1jNNNk8z1AwDJKIgHN4pwDCw7nRnJrjd7k+wFSIEB3Wcs9Xx
        cznA5bhQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onQGh-006OK6-T4; Tue, 25 Oct 2022 20:11:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ACCDA30035C;
        Tue, 25 Oct 2022 22:11:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 95F2F2C4502E8; Tue, 25 Oct 2022 22:11:22 +0200 (CEST)
Message-ID: <20221025201057.881703081@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 25 Oct 2022 22:06:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, rostedt@goodmis.org,
        dave.hansen@intel.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        keescook@chromium.org, seanjc@google.com
Subject: [PATCH 3/5] x86/mm: Initialize text poking earlier
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

Move poking_init() up a bunch; specifically move it right after
mm_init() which is right before ftrace_init().

This will allow simplifying ftrace text poking which currently has
a bunch of exceptions for early boot.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 init/main.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/init/main.c
+++ b/init/main.c
@@ -996,7 +996,7 @@ asmlinkage __visible void __init __no_sa
 	sort_main_extable();
 	trap_init();
 	mm_init();
-
+	poking_init();
 	ftrace_init();
 
 	/* trace_printk can be enabled here */
@@ -1135,7 +1135,6 @@ asmlinkage __visible void __init __no_sa
 	taskstats_init_early();
 	delayacct_init();
 
-	poking_init();
 	check_bugs();
 
 	acpi_subsystem_init();


