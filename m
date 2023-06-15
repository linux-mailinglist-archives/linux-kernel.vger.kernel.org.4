Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32F1732071
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 21:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjFOTkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 15:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjFOTko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 15:40:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41ECA2955
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 12:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ym0/qSrr9k4NI40YZWDsTfZmTHUyTZ8iXhRuPCudfu4=; b=hCwkhN7MAl0+BrkxMgLt4T3t6L
        N/HSnfSpb4uleWMY5ij3EwwufNrgvP6F2JwaVc08lOBvh3zWzFqsy/EsdO44mVf9Xyt70mNdqfgyA
        TOVQD3X/Ef6SdknZ6fxKMBym7YlWOe8YyqzJFNpkbshh70/IxFbtAI684RanG65rFZJ9IRyzdq5QH
        Yfm6wnLGGD2HAqjIfMksE9MU3dL1e9oyeUqebN4VuONTqP2DShidjNMF4LZU1Ev19aOqDmsPWBUOl
        mJj//WGJhVUek1KxuU04b2Q9IyXsWZamiqsMpo3FZ5Z27h2JtdqDw3ugARHxa0y3Yj5sjKqSyV4nh
        uHf41P1Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9spY-0080rw-JN; Thu, 15 Jun 2023 19:40:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 09938300269;
        Thu, 15 Jun 2023 21:40:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E32BC245F1E4C; Thu, 15 Jun 2023 21:40:26 +0200 (CEST)
Message-ID: <20230615193546.949657149@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Jun 2023 21:35:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, alyssa.milburn@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        samitolvanen@google.com, keescook@chromium.org,
        jpoimboe@kernel.org, joao@overdrivepizza.com,
        tim.c.chen@linux.intel.com
Subject: [PATCH 0/2] x86/cfi: Fix FineIBT
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Alyssa reported a FineIBT issue; these patches sort that.

Basically the morale of the story is that CALL_NOSPEC and JMP_NOSPEC are
suspect and likely not what you want. The remaining users are:

arch/x86/crypto/crc32c-pcl-intel-asm_64.S:	JMP_NOSPEC bufp

This is broken on anything IBT afaict.

arch/x86/include/asm/mshyperv.h:			     CALL_NOSPEC
arch/x86/include/asm/mshyperv.h:	__asm__ __volatile__(CALL_NOSPEC
arch/x86/include/asm/mshyperv.h:		__asm__ __volatile__(CALL_NOSPEC
arch/x86/include/asm/mshyperv.h:		__asm__ __volatile__ (CALL_NOSPEC
arch/x86/include/asm/mshyperv.h:				     CALL_NOSPEC
arch/x86/include/asm/mshyperv.h:		__asm__ __volatile__ (CALL_NOSPEC
arch/x86/include/asm/xen/hypercall.h:	asm volatile(CALL_NOSPEC

These are hypercalls and supposedly the targets are having ENDBR on.

arch/x86/kernel/ftrace_64.S:	CALL_NOSPEC r8

The thing is !DYNAMIC_FTRACE only, which we can fix with a Kconfig
dependency I suppose.

arch/x86/kvm/emulate.c:	asm("push %[flags]; popf; " CALL_NOSPEC
arch/x86/kvm/emulate.c:	asm("push %[flags]; popf; " CALL_NOSPEC " ; pushf; pop %[flags]\n"

calls into the magic fastop stuff and should be ok, those have explicit
ENDBR + IBT_NOSEAL() annotations.

arch/x86/kvm/vmx/vmenter.S:	VMX_DO_EVENT_IRQOFF CALL_NOSPEC _ASM_ARG1

calls the IDT vectors manually, so should be ok (gross, but not broken
from this pov).

arch/x86/platform/efi/efi_stub_64.S:	CALL_NOSPEC rdi

effectively a nocfi call, so should be ok.

