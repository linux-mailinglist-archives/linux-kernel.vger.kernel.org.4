Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA647129F6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244222AbjEZPxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237160AbjEZPxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:53:50 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84475F3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 08:53:48 -0700 (PDT)
Received: from nazgul.tnic (dynamic-002-247-249-230.2.247.pool.telefonica.de [2.247.249.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 60FEB1EC041F;
        Fri, 26 May 2023 17:53:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1685116426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pBm9om1gVlyiRiPA3dFftZ3tknsWP2R2Yor9M3SqwDA=;
        b=LRaY3JDZlGX5YW13A4BN9vAoKcbuhqcp0H9WQq8aDjrGG8NBtS6YhDZTI1EuhiO2uLERrJ
        GXDqsbjdM/Hol+CJ6eLr5UcrHxHr4Xkm0N1Xa9Zzz6l7W2bS/E221ufT4c83KWs84Z7CEo
        liQe8Zql9RBZHXnoUbrtclOusdFyA+I=
Date:   Fri, 26 May 2023 17:53:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/lib: Do not use local symbols with
 SYM_CODE_START_LOCAL()
Message-ID: <20230526155336.GAZHDWAFi1FRqq83TP@nazgul.local>
References: <20230525184244.2311-1-namit@vmware.com>
 <38e24fd4-9213-229d-9919-7ae3bfb113bb@intel.com>
 <24E47178-C177-425F-A8EF-CFFAE22597D4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <24E47178-C177-425F-A8EF-CFFAE22597D4@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 12:39:47PM -0700, Nadav Amit wrote:
> I do not think in this tradeoff not exposing local names worth
> preventing profilers (and their users) from understanding where a
> sample/trace is was taken. If for instance you look at a branch
> trace (e.g., using Intel PT) you want to see the symbol to which a
> branch goes to.

If those functions were written in C, you wouldn't see any
exception-handling symbols either. It is the fact that they're asm
and the exception labels are defined "out-of-line" so that you don't
have code duplication and thus are symbols outside of the respective
functions.

So you'd have to give a lot more detailed example where making those
symbols global, helps.

And if those symbols are going to be global, then they better have more
descriptive names as they're gonna be pretty much independent functions.
Something like __get_user_handle_exception() or so.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
