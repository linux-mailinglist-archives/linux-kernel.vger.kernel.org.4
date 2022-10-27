Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E56F60F49A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 12:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbiJ0KLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 06:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbiJ0KLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 06:11:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907749258D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 03:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RSiId3jjBgeoKRnUI7xiWVzvEKeENy32D6nZl+srEBw=; b=i+4G1DvfbTqQkTpJb17qoZhNrt
        cpshJ65wV49aEKiTGEX61wM/z/3+dRD1E1GGn99rl+C6IlszI6bJ7mAQ5XNB2ieYYSM4wzhqpqcOK
        4+9eyO8KlhpK30xNGj/n2hQkkVrWwYzhs5WdZvjdt+70D7sAShAk4WH3j3DBJMH3+OIfkNd2GVXrY
        O/mTxpjHIfxi5LEmvaRUMgElH7kDuaqx91++WPptzKUn44eWoresoapoYQ/T1+tFS4iI8Tk7auAe3
        9KC1l4a2dK+0rhsZsd3rtl1QAiCZXQCOyApwBAfOtcfxHsCCy0tm4tY3b2Vfgi/bDsn+zSpDa6HKH
        VblEFESw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onzrL-00078H-S7; Thu, 27 Oct 2022 10:11:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2E95930045D;
        Thu, 27 Oct 2022 12:11:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 130962C4504B8; Thu, 27 Oct 2022 12:11:30 +0200 (CEST)
Date:   Thu, 27 Oct 2022 12:11:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/4] x86/ibt: Implement FineIBT
Message-ID: <Y1pZUQtrSET7DTXy@hirez.programming.kicks-ass.net>
References: <20221027092812.185993858@infradead.org>
 <20221027092842.634714496@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027092842.634714496@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 11:28:14AM +0200, Peter Zijlstra wrote:
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -256,6 +256,7 @@ objtool-args-$(CONFIG_HAVE_JUMP_LABEL_HA
>  objtool-args-$(CONFIG_HAVE_NOINSTR_HACK)		+= --hacks=noinstr
>  objtool-args-$(CONFIG_CALL_DEPTH_TRACKING)		+= --hacks=skylake
>  objtool-args-$(CONFIG_X86_KERNEL_IBT)			+= --ibt
> +objtool-args-$(CONFIG_FINEIBT)                          += --cfi
>  objtool-args-$(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL)	+= --mcount
>  objtool-args-$(CONFIG_UNWINDER_ORC)			+= --orc
>  objtool-args-$(CONFIG_RETPOLINE)			+= --retpoline

I seem to have lost a refresh; consider that whitespace fail fixed.
