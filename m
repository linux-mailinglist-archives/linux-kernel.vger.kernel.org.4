Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1658E601233
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 17:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiJQO7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiJQO6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:58:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B456B17B;
        Mon, 17 Oct 2022 07:55:55 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:54:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018468;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c/XzYaOPWztBN43khFHM7o1IlGuDSOdc1/FdMMHQif8=;
        b=OB6uStf5ukgr8OYmP1iKriHdbxMtAW6TdWmty31gsL9R9wFC1yCNsyXnJRn+jOK5/FFxmC
        0O3/cN4Oo+0UO/K5aepM8v8N5TucTTBLNdYQjaZbl4XiKsMkE3qoXeUh21sKjrHHkGp3Tj
        r4fp2SwXcB/5atFFLkiEVcao+kF46jiqsWbcaGCdbGm2WYt62L82yfxC44fao2b2b0TrFQ
        jbmOk2N/xrgGqCFYJh8CK1I9LG+qi8MjJtEdkfNYRBQUdihQ0q2YnZoNnMFDOmiEzpUqDN
        7wW9EM5qV8PZQ3m5R5EUwshPbSHm++HmdpQ6znsGZg+JQDjKxBB5aGvUE8Sl1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018468;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c/XzYaOPWztBN43khFHM7o1IlGuDSOdc1/FdMMHQif8=;
        b=maEUEcxBntQRp8Syhu11NZPAMyDfaGZt9WjLrOHqHb2T0kDWkWR/WitvgAP7eS3WTL8j0i
        kHuDPrefM4Q9OgDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/vdso: Ensure all kernel code is seen by objtool
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111143.512144110@infradead.org>
References: <20220915111143.512144110@infradead.org>
MIME-Version: 1.0
Message-ID: <166601846677.401.12171922617717906171.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     b26d66f8dace32c46ce58147002964ce8cdfde5f
Gitweb:        https://git.kernel.org/tip/b26d66f8dace32c46ce58147002964ce8cdfde5f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:10:45 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:40:57 +02:00

x86/vdso: Ensure all kernel code is seen by objtool

extable.c is kernel code and not part of the VDSO

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111143.512144110@infradead.org
---
 arch/x86/entry/vdso/Makefile | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 3e88b9d..3ef6110 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -33,11 +33,12 @@ vobjs32-y += vdso32/vclock_gettime.o
 vobjs-$(CONFIG_X86_SGX)	+= vsgx.o
 
 # files to link into kernel
-obj-y				+= vma.o extable.o
-KASAN_SANITIZE_vma.o		:= y
-UBSAN_SANITIZE_vma.o		:= y
-KCSAN_SANITIZE_vma.o		:= y
-OBJECT_FILES_NON_STANDARD_vma.o	:= n
+obj-y					+= vma.o extable.o
+KASAN_SANITIZE_vma.o			:= y
+UBSAN_SANITIZE_vma.o			:= y
+KCSAN_SANITIZE_vma.o			:= y
+OBJECT_FILES_NON_STANDARD_vma.o		:= n
+OBJECT_FILES_NON_STANDARD_extable.o	:= n
 
 # vDSO images to build
 vdso_img-$(VDSO64-y)		+= 64
