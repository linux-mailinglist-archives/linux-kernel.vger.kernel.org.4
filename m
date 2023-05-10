Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6816FDC9A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbjEJLXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235731AbjEJLXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:23:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8C910D;
        Wed, 10 May 2023 04:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QbzoChfNbmTPAWVYTeVTH2VekWVcJSNCB9AwQAbgzcA=; b=FgxufkvO0GetjfD6zrhAGQ8OT1
        KOYVMDTYuYoeCc25K0fCN/t0UcEn1LE+dP93KXRPDRmwXVOd7HkbsIl9LZMFh6tGqRC+M0c5o6Lw5
        Jg15V5qs4F5hDFKQQ6zjgFFaF95r2zGNUEdtI7nGL6FVy9PiYWJs1RsPA/KISDiikM2zXwiE2R10m
        s2OUSWm03W7jstFisa0+5qRKuuVzDtHnyw+PI2aXHVUeM5JOtztCZ9K6qQuyNQXw7rA/Zqb0Fgo6J
        cGvdFpYGpdTUriawNxVFJCxDK2dzEHWiYhMIT34iWbhVkgJPdgu4piKQxzQ/kSDaWENkeZ/dyxNwG
        C5CuKsbw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pwhuc-00GDJC-Pd; Wed, 10 May 2023 11:23:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9ECCD300023;
        Wed, 10 May 2023 13:23:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 65E3720B04BA9; Wed, 10 May 2023 13:23:11 +0200 (CEST)
Date:   Wed, 10 May 2023 13:23:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Youling Tang <tangyouling@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Zhangjin Wu <falcon@tinylab.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
Subject: Re: [PATCH v2] LoongArch: Add jump-label implementation
Message-ID: <20230510112311.GA2176161@hirez.programming.kicks-ass.net>
References: <1683710206-23905-1-git-send-email-tangyouling@loongson.cn>
 <20230510092723.GK4253@hirez.programming.kicks-ass.net>
 <15594820-0a95-94bb-132f-5008d31c041f@xen0n.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15594820-0a95-94bb-132f-5008d31c041f@xen0n.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 05:34:33PM +0800, WANG Xuerui wrote:
> Hi Peter,
> 
> My 2 cents:
> 
> On 2023/5/10 17:27, Peter Zijlstra wrote:
> > On Wed, May 10, 2023 at 05:16:46PM +0800, Youling Tang wrote:
> > > Add jump-label implementation based on the ARM64 version.
> > > 
> > > Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> > 
> > > <snip>
> > > 
> > > +	if (type == JUMP_LABEL_JMP)
> > > +		insn = larch_insn_gen_b(jump_entry_code(entry), jump_entry_target(entry));
> > > +	else
> > > +		insn = larch_insn_gen_nop();
> > > +
> > > +	larch_insn_patch_text(addr, insn);
> > > +}
> > 
> > This all implies Loongarch is fine with the nop<->b transition (much
> > like arm64 is), but I found no actual mention of what transitions are
> > valid for the architecture in your inst.c file -- perhaps you could put
> > a small comment there to elucidate the occasional reader that doesn't
> > have your arch manual memorized?
> 
> Do you mean by "valid transition" something like "what kind of
> self-modification is architecturally sound, taking ICache /
> micro-architecture behavior etc. into consideration"?

Yes that. There are definitely architectures that have limitations on
what instructions can be hot-patched in the face of concurrent execution
without jumping through too many hoops.



