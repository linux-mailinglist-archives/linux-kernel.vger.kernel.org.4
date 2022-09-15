Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6439B5B99FF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiIOLoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiIOLlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:41:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A037D1C3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=6xIMyXngTvaZTcz5zEWS3IkhPHWVQF/6vMw/4Le/NHI=; b=edWSwaadhzaUULZ/sQ925c2L7M
        tNTMc4BcsvRqqTnXtgtUdl93BbsC/PAKyPjBgi02KhEZ7F0WATc7wMboO2SJDGckg8Dl5SxzioLN5
        cmQIN2IjDZW8S2SCvUuLcAiWOQFGloaNlYnMSKRvWRCQQj2Hz0vxeTW1U2+hhqB+A5T9Y44aspyAY
        NPoKa6/ch2lQGQqJV0aMgGWsnCveLAZEeah5uMJQQOhTQxgz6tTX5pFDhdvHPIkUfP3ql/xXZqrWL
        qaoUvCG0B6htNfrUzfEtu6KrEiTz/PVUDI8td5A39OzMv2+U3H9en6ovoISw9gkclKw9pELDCB4PC
        wVdQmvvA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYnDZ-00Caaj-2T; Thu, 15 Sep 2022 11:39:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B5525300DBD;
        Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E6C0929AADBE7; Thu, 15 Sep 2022 13:39:38 +0200 (CEST)
Message-ID: <20220915111143.512144110@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Sep 2022 13:10:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH v3 06/59] x86/vdso: Ensure all kernel code is seen by objtool
References: <20220915111039.092790446@infradead.org>
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

From: Thomas Gleixner <tglx@linutronix.de>

extable.c is kernel code and not part of the VDSO

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/vdso/Makefile |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -30,11 +30,12 @@ vobjs32-y += vdso32/vclock_gettime.o
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


