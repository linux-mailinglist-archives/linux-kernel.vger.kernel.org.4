Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3B1663F25
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 12:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjAJLQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 06:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbjAJLPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 06:15:53 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2DC1401D
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 03:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=LE4aoLbLilXnZV5T992f4wACX7I/Nfap/jSdsHEVTyA=; b=EHa5TH8PV0WlrdxsvCA1d0mUch
        L1TyiuJlthwlNT79BsPtO/+5wiI5GvlTHBOFfo8h8/tgYGxJO+RipKRZbpGhkkpExvuNjFTr3GQat
        Z3am1FMzHfTBh6Vfl2uePihVv2cDJmKzSpnIr/G3un6GEz7lax7URU0O4YVVF1FULZ3H8DNu1oGt0
        YbCkzY1Qas1Kwi65MLv+1+wAr+5QROUAJJ9ZZUMP8/9P1+BCatJ7mZa8xDlXq8ZUImvkjmLlO/LqW
        hCByYNY8h3ieuZtvABIl4j++RZNRmYek3bUitZg0q+tYkLyFnCpSvA17jrgE+yjT5Tux4AHjdDg7u
        x6mwh9xg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pFCbN-0036xL-2l;
        Tue, 10 Jan 2023 11:15:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 761E0300033;
        Tue, 10 Jan 2023 12:15:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 519EB2C539AFD; Tue, 10 Jan 2023 12:15:40 +0100 (CET)
Date:   Tue, 10 Jan 2023 12:15:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: x86/boot: Avoid using Intel mnemonics in AT&T syntax asm
Message-ID: <Y71I3Ex2pvIxMpsP@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


With 'GNU assembler (GNU Binutils for Debian) 2.39.90.20221231' the
build now reports:

  arch/x86/realmode/rm/../../boot/bioscall.S: Assembler messages:
  arch/x86/realmode/rm/../../boot/bioscall.S:35: Warning: found `movsd'; assuming `movsl' was meant
  arch/x86/realmode/rm/../../boot/bioscall.S:70: Warning: found `movsd'; assuming `movsl' was meant

  arch/x86/boot/bioscall.S: Assembler messages:
  arch/x86/boot/bioscall.S:35: Warning: found `movsd'; assuming `movsl' was meant
  arch/x86/boot/bioscall.S:70: Warning: found `movsd'; assuming `movsl' was meant

Which is due to:

  PR gas/29525

  Note that with the dropped CMPSD and MOVSD Intel Syntax string insn
  templates taking operands, mixed IsString/non-IsString template groups
  (with memory operands) cannot occur anymore. With that
  maybe_adjust_templates() becomes unnecessary (and is hence being
  removed).

More details: https://sourceware.org/bugzilla/show_bug.cgi?id=29525

Fixes: 7a734e7dd93b ("x86, setup: "glove box" BIOS calls -- infrastructure")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/boot/bioscall.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/boot/bioscall.S
+++ b/arch/x86/boot/bioscall.S
@@ -32,7 +32,7 @@
 	movw	%dx, %si
 	movw	%sp, %di
 	movw	$11, %cx
-	rep; movsd
+	rep; movsl
 
 	/* Pop full state from the stack */
 	popal
@@ -67,7 +67,7 @@
 	jz	4f
 	movw	%sp, %si
 	movw	$11, %cx
-	rep; movsd
+	rep; movsl
 4:	addw	$44, %sp
 
 	/* Restore state and return */
