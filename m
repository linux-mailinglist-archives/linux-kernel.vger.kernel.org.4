Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B01737E74
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 11:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjFUIwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjFUIw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:52:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E58595
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZxzonGtfOib4bPz4vU4l7YCxSJ6y+1nTH4FRT1JSooU=; b=dJ1z5ZascKyFFx/kUKDQ2f4eIB
        NvyeXAQE8zMoi7rFIClyOlPkcXeS/jGBSe5xzH4T8Owk1N0W4N5OFjK6MBDtP8c5Fo1LisZmoJjSt
        BILykQgxFX9IOOHUNo9A+nGJ5k/m/nuB0kzu2Zfa3US7zPs/UIghVpKWLc48umyhLSrN7LDQqJj07
        I6tmHhHKBHzG5p8Cs1miYiYVeXhCM2sNOqzwWJaMiAyH9HZAgb42MwQRUefUz422NXzlFQ5gUvKDW
        9ggwBIa1LazU/FrDoXcXqpenU82mYO/SHjBtP5uskORHWCsw/S83R/O5QCbVRwnEMFttkAu7033tb
        xsXMtJ0A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qBtZb-00E9kA-35; Wed, 21 Jun 2023 08:52:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BF69D300137;
        Wed, 21 Jun 2023 10:52:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B020C20825AF7; Wed, 21 Jun 2023 10:52:17 +0200 (CEST)
Date:   Wed, 21 Jun 2023 10:52:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, alyssa.milburn@linux.intel.com,
        linux-kernel@vger.kernel.org, samitolvanen@google.com,
        jpoimboe@kernel.org, joao@overdrivepizza.com,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH 1/2] x86/cfi: Fix ret_from_fork indirect calls
Message-ID: <20230621085217.GI2046280@hirez.programming.kicks-ass.net>
References: <20230615193546.949657149@infradead.org>
 <20230615193722.127844423@infradead.org>
 <202306201455.AF16F617A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202306201455.AF16F617A@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 02:56:22PM -0700, Kees Cook wrote:
> On Thu, Jun 15, 2023 at 09:35:47PM +0200, Peter Zijlstra wrote:
> > The ret_from_fork stub does an indirect call to the kthread function,
> > but only knows about Retpolines. Instead of making the asm more
> > complicated, punt to C and let the compiler figure it out.
> > 
> > Specifically, this makes it a proper kCFI indirect call when needed (in
> > fact, it is nearly impossible to code a kCFI indirect call in asm).
> > 
> > This was the only callsite that was still calling func()+0 on regular
> > indirect functions.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> I worry this creates a calling gadget, but I don't think it really
> counts since it's just converting between two prototypes. Regardless:

Ah, since this will never be indirectly called, I should be able to
annotate this so it never can be. Let me see what I can get the compiler
to do.
