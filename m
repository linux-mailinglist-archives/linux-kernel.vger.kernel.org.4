Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07D473A399
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjFVOu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjFVOug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:50:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A891710
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=FI1Ilf3TB6X2/hXhpNF04O2UYw1z64psa92hXMDi+uU=; b=P9y0b72/KnuWV4rOI284V4niL6
        bwMBr6txDcKTZfI2iEfHs2xGzc/eWJhA03uX85c+n4Sb3ygdtxh8QExp0RxlQWMU3nN2/c7E6uHxN
        0cAxuLq/lVGkHYAfET2O28dvzeaBT0DCD81LWUCzsKOrZ74nu8pXX5duHV5Z/kPxiuWpWgMeGcpkR
        qyPHy47E7o92Ur/nuv4xbRwe8CKPNBfiKe58MOg3+FjTG7c6on+cMT0MVSSrK4KtsOqqlzTj6oCk2
        CpZP4Gy9bIwXpX9Wn9vM0leOnIODoXcP15tNloD2H9pvJEoEMrxo5N1ky7wGY9WfED8XDWAtxW8AM
        onUcA9jw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qCLdh-00FgfA-Rv; Thu, 22 Jun 2023 14:50:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2C40D300338;
        Thu, 22 Jun 2023 16:50:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 15905209D8B39; Thu, 22 Jun 2023 16:50:24 +0200 (CEST)
Message-ID: <20230622144321.360957723@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 22 Jun 2023 16:42:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, alyssa.milburn@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        samitolvanen@google.com, keescook@chromium.org,
        jpoimboe@kernel.org, joao@overdrivepizza.com, brgerst@gmail.com
Subject: [PATCH v2 1/6] x86/cfi: Extend {JMP,CAKK}_NOSPEC comment
References: <20230622144218.860926475@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of kCFI these helpers are no longer equivalent
to C indirect calls and should be used with care.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/nospec-branch.h |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -234,6 +234,10 @@
  * JMP_NOSPEC and CALL_NOSPEC macros can be used instead of a simple
  * indirect jmp/call which may be susceptible to the Spectre variant 2
  * attack.
+ *
+ * NOTE: these do not take kCFI into account and are thus not comparable to C
+ * indirect calls, take care when using. The target of these should be an ENDBR
+ * instruction irrespective of kCFI.
  */
 .macro JMP_NOSPEC reg:req
 #ifdef CONFIG_RETPOLINE


