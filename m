Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6B06DF6CA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjDLNRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjDLNRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:17:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55517EFF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CAdr1M8nPpuJPFB3/dtnTzkz9p8f+2c7kXX1GkcWOfU=; b=wUKiK3M+Gzgq8MT7MCpFYsAhik
        W48W39HSecLShkY6MwncdphTFteNLK2TFeX048LRudY0gQDzOHTlrDHb0wfK/RK12jsG4PMmiDRDj
        PnFG7vhVHnbNxaBAY2SJoTfeObeIc9bqJyP0Zf8dkRpFaY8UoJgDY4e9euBJZQ+7RXFjvuQNVOWSX
        2e6ttPDGsZiGwcF8HCJHa9GcX7XE1dUHReNUaze3tXCUdeMy5fSuoSShZJE+kXxkGukkZAEr5NO2O
        eWAboDs/ZpcruOYoKMP2UbkkDSMtEdNV415OkYSUZwvNpX1Q8v/PHDqzVUoYbMwK1le6JqzDBHlc/
        I6Qr0h2g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pmaJy-006tPP-Sa; Wed, 12 Apr 2023 13:15:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A103530030B;
        Wed, 12 Apr 2023 15:15:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8538125E5A38B; Wed, 12 Apr 2023 15:15:33 +0200 (CEST)
Date:   Wed, 12 Apr 2023 15:15:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>, keescook@chromium.org,
        dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com,
        tglx@linutronix.de, rostedt@goodmis.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86: make __get_wchan() use arch_stack_walk()
Message-ID: <20230412131533.GH628377@hirez.programming.kicks-ass.net>
References: <20230330081552.54178-1-zhengqi.arch@bytedance.com>
 <20230330081552.54178-3-zhengqi.arch@bytedance.com>
 <20230408050822.ezdbhc6j7zuvutrm@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230408050822.ezdbhc6j7zuvutrm@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 10:08:22PM -0700, Josh Poimboeuf wrote:
> On Thu, Mar 30, 2023 at 04:15:52PM +0800, Qi Zheng wrote:
> > Make __get_wchan() use arch_stack_walk() directly to
> > avoid open-coding of unwind logic.
> > 
> > Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Can we just have a shared version of __get_wchan() for all
> CONFIG_ARCH_STACKWALK arches?

Didn't I do that a while back ? I can't seem to actually find the
patch-set though :/
