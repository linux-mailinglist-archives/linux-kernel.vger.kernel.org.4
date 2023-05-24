Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB8570FD48
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 19:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbjEXRzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 13:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjEXRzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 13:55:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFB5B6;
        Wed, 24 May 2023 10:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6T9TB36mAiDcErcLZAZRBQib3bTTYAdiNi7xQ6cd2Yw=; b=dmktSR3kFQTbKea19MR412DQze
        XLAwguRSQB5aDSh+HYVtUCdGHwro0XMJYlzSL+zcrKbuaAE3DDR9EJOB0VSg+SKGlVEdeQlrhm6s5
        VHZS7MvFYx6RVO+1Qnq0xuxltxj9rv+iBvR7DO9aqTRGVoFokykeJW8goTjQO+9zKpAzcFtwEr+YF
        opM38Q3sAbTxgsbhD/V5A8TTnUJdBBYBYH8M4ht/hGes4ParBVQzV3G1UArhuDeMq0f9byIYwM2yN
        JNSPFiNaGzFjskbBbwYCLhZ+qR5pwxECZ9+6UUSe4I2Cm4uVsijKTVSoZRTf1lTZ8cxpKKfMKbEaF
        ik/Vl7vQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q1shC-00BPta-38; Wed, 24 May 2023 17:54:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 180C830013F;
        Wed, 24 May 2023 19:54:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CEC39242F81B8; Wed, 24 May 2023 19:54:42 +0200 (CEST)
Date:   Wed, 24 May 2023 19:54:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, LTP List <ltp@lists.linux.it>,
        lkft-triage@lists.linaro.org, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: qemu-x86_64 compat: LTP: controllers: RIP: 0010:__alloc_pages
Message-ID: <20230524175442.GO4253@hirez.programming.kicks-ass.net>
References: <CA+G9fYvVZ9WF-2zfrYeo3xnWNra0QGxLzei+b4yANZwEvr5CYw@mail.gmail.com>
 <20230524140744.GK4253@hirez.programming.kicks-ass.net>
 <CA+G9fYsP1XN31sWMtPsaXzRtiAvHsn+A2cFZS2s6+muE_Qh61Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsP1XN31sWMtPsaXzRtiAvHsn+A2cFZS2s6+muE_Qh61Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 09:39:50PM +0530, Naresh Kamboju wrote:
> FYI,
> These are running in AWS cloud as qemu-i386 and qemu-x86_64.

Are these hosted on x86 and using KVM or are they hosted on Graviton and
using TCG x86 ?

Supposedly TCG x86 is known 'funny' and if that's what you're using it
would be very good to confirm the problem on x86 hardware.
