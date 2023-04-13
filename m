Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B84A6E1532
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 21:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjDMTay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 15:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjDMTaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 15:30:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BBDA2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 12:30:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14E9E64146
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 19:30:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A586C433EF;
        Thu, 13 Apr 2023 19:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681414250;
        bh=ZZFjlEgIY/hx+ul9r9hWiMI+vv8tmmlI+RQGXZaCscE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B234JK3jfbNQPCuedfgMF4nJnvJs60NyIfc6Nm7+w3MbVIl4sp8jCSj995VO2PDVU
         6iu/2E89G0Qo9NomvB3JKoLhlfjtbzUMduBznJ3+0KVCPIX+aEm+5PJjb3HlEIjhYJ
         twcQ3Tu1scASNgyWDMO/wNVwfMQd9ODOo+pprstPJaD4RwBXIurW2QrGPerqmnlTpD
         lPn20Mm3W0lWz1pLVj5t1VnMxWG4TnA7D54EkK5DswcM+DhZakMhi3k0vT7sfp57vR
         agwkX17AA+uGoJhDPE/ysfudl7PTqxu47jQEZbfpT9H7Ys1GmtxhEbwgIsFU0kiw5U
         UibPBASil03qw==
Date:   Thu, 13 Apr 2023 12:30:48 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 3/3] objtool: Generate ORC data for __pfx code
Message-ID: <20230413193048.biwxfseynqyc4qkx@treble>
References: <cover.1681331135.git.jpoimboe@kernel.org>
 <bc3344e51f3e87102f1301a0be0f72a7689ea4a4.1681331135.git.jpoimboe@kernel.org>
 <20230413112426.GM4253@hirez.programming.kicks-ass.net>
 <20230413152933.cxhmocvbdlucvizx@treble>
 <20230413192449.GQ4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230413192449.GQ4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 09:24:49PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 13, 2023 at 08:29:33AM -0700, Josh Poimboeuf wrote:
> > On Thu, Apr 13, 2023 at 01:24:26PM +0200, Peter Zijlstra wrote:
> > > > +	if (!insn->cfi) {
> > > > +		/*
> > > > +		 * This can happen if stack validation isn't enabled or the
> > > > +		 * function is annotated with STACK_FRAME_NON_STANDARD.
> > > > +		 */
> > > > +		return 0;
> > > > +	}
> > > > +
> > > > +	/* Propagate insn->cfi to the prefix code */
> > > > +	cfi = cfi_hash_find_or_add(insn->cfi);
> > > > +	for (; prev != insn; prev = next_insn_same_sec(file, prev))
> > > > +		prev->cfi = cfi;
> > > > +
> > > >  	return 0;
> > > >  }
> > > 
> > > FWIW, this makes the whole thing hard rely on the prefix being single
> > > byte NOPs -- which they are, but perhaps we should assert this?
> > 
> > Couldn't they be any stack-invariant instructions?
> 
> Hmm, I was thikning that since we don't know the size of the
> instructions being written, we need CFI for all offsets. But perhaps,
> since we do a left-match on IP, only one entry at the __pfx+0 location
> would work?

Right, while in objtool (almost) every insn has insn->cfi, the actual
ORC entries only get created at the boundaries of change.

-- 
Josh
