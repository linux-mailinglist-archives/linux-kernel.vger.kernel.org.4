Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885D96E1521
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 21:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjDMTY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 15:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDMTY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 15:24:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EFF6A62
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 12:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IHc6XnCkNX2Kn8L3W9jTWAcrwTarHbGJNtz2K6OiM0A=; b=O9Qlz2F5rPuvsV4ey3fsUUchnh
        dJ1p9DcMrOOSfg3USY7OMeXQSEE0owsygytdTlgtPdhlUui8IdTkV2vlaq8As+w9zjaKR7fUzkP/v
        vpd5ZmsIJNO5r7FSeeYm5LQpMo6oVYx6+bnAUKijlG6rJaWvtcFGNeGF14bdj7JcyiZ9RPvoHRt4W
        v3vrAlbiy9OwGBY25DdaDIdmvPdxStkA3zajmNh1Kn6pNolAusGxQJKSPyAk6FYQSmjPiLbr5/8N3
        9rJaxN1B/Of9P2V8bTdJVDD4I7bAz3CH702ajBAyMHCMl0f5wPfrd2HiAeiohKkzeukj1FZt+ZXhN
        8b0U1tfw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pn2Yt-0085Bu-F1; Thu, 13 Apr 2023 19:24:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1343A3001E4;
        Thu, 13 Apr 2023 21:24:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E08F924C37001; Thu, 13 Apr 2023 21:24:49 +0200 (CEST)
Date:   Thu, 13 Apr 2023 21:24:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 3/3] objtool: Generate ORC data for __pfx code
Message-ID: <20230413192449.GQ4253@hirez.programming.kicks-ass.net>
References: <cover.1681331135.git.jpoimboe@kernel.org>
 <bc3344e51f3e87102f1301a0be0f72a7689ea4a4.1681331135.git.jpoimboe@kernel.org>
 <20230413112426.GM4253@hirez.programming.kicks-ass.net>
 <20230413152933.cxhmocvbdlucvizx@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413152933.cxhmocvbdlucvizx@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 08:29:33AM -0700, Josh Poimboeuf wrote:
> On Thu, Apr 13, 2023 at 01:24:26PM +0200, Peter Zijlstra wrote:
> > > +	if (!insn->cfi) {
> > > +		/*
> > > +		 * This can happen if stack validation isn't enabled or the
> > > +		 * function is annotated with STACK_FRAME_NON_STANDARD.
> > > +		 */
> > > +		return 0;
> > > +	}
> > > +
> > > +	/* Propagate insn->cfi to the prefix code */
> > > +	cfi = cfi_hash_find_or_add(insn->cfi);
> > > +	for (; prev != insn; prev = next_insn_same_sec(file, prev))
> > > +		prev->cfi = cfi;
> > > +
> > >  	return 0;
> > >  }
> > 
> > FWIW, this makes the whole thing hard rely on the prefix being single
> > byte NOPs -- which they are, but perhaps we should assert this?
> 
> Couldn't they be any stack-invariant instructions?

Hmm, I was thikning that since we don't know the size of the
instructions being written, we need CFI for all offsets. But perhaps,
since we do a left-match on IP, only one entry at the __pfx+0 location
would work?

