Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E806466C2B5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjAPOwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjAPOwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:52:12 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241DD2BF0E
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=w9+PAdJk73UH2Fl3uPAAs4wgk5kyO76VlH+ufUk/PX4=; b=OB3RdkQh/z8SFHj5199h+5XxCG
        thtkjKdk+ckbxf7Iellx2ZelkT1vO3AvWAgAjOiq8fzpCJwR6AC2SkmBx8R0Lr5PfqM/r3BVOSesf
        iNTTF8J0Dh6dYSuq81Aos7ogKJWM8VOUSyQK3UNQsqCLKlLOI0+qQzX7Hru0M/PxVUOf8M3fiPwcL
        XUNEPBzCO1X90Eazd5t/tUXX6nnvwXa2NznHU7elGvs2Vf9jjgratRjuPAlLu2YOjbhnfusCUjccb
        9glOoHYAYwuO41FGkPxDyw2EqP509qne4J5wYOpjcjdfHCeOJ6BFrHWxncvKtAlQKHBLhyYXy8uSD
        vFlY2FHg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pHQc8-005csz-1j;
        Mon, 16 Jan 2023 14:37:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 56FD1300C9D;
        Mon, 16 Jan 2023 15:37:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C252D20EF0A28; Mon, 16 Jan 2023 15:37:38 +0100 (CET)
Message-ID: <20230116143645.948125465@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 16 Jan 2023 15:25:40 +0100
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
Subject: [PATCH v2 7/7] PM / hibernate: Add minimal noinstr annotations
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

When resuming there must not be any code between swsusp_arch_suspend()
and restore_processor_state() since the CPU state is ill defined at
this point in time.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/power/hibernate.c |   30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -280,6 +280,32 @@ __weak int arch_resume_nosmt(void)
 	return 0;
 }
 
+static noinstr int suspend_and_restore(void)
+{
+	int error;
+
+	/*
+	 * Strictly speaking swsusp_arch_suspend() should be noinstr too but it
+	 * is typically written in asm, as such, assume it is good and shut up
+	 * the validator.
+	 */
+	instrumentation_begin();
+	error = swsusp_arch_suspend();
+	instrumentation_end();
+
+	/*
+	 * Architecture resume code 'returns' from the swsusp_arch_suspend()
+	 * call and resumes execution here with some very dodgy machine state.
+	 *
+	 * Compiler instrumentation between these two calls (or in
+	 * restore_processor_state() for that matter) will make life *very*
+	 * interesting indeed.
+	 */
+	restore_processor_state();
+
+	return error;
+}
+
 /**
  * create_image - Create a hibernation image.
  * @platform_mode: Whether or not to use the platform driver.
@@ -323,9 +349,7 @@ static int create_image(int platform_mod
 	in_suspend = 1;
 	save_processor_state();
 	trace_suspend_resume(TPS("machine_suspend"), PM_EVENT_HIBERNATE, true);
-	error = swsusp_arch_suspend();
-	/* Restore control flow magically appears here */
-	restore_processor_state();
+	error = suspend_and_restore();
 	trace_suspend_resume(TPS("machine_suspend"), PM_EVENT_HIBERNATE, false);
 	if (error)
 		pr_err("Error %d creating image\n", error);


