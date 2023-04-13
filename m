Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF43B6E108E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjDMPD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjDMPD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:03:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041187280
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:03:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9458E63D2A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 15:03:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B818AC433EF;
        Thu, 13 Apr 2023 15:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681398204;
        bh=QPUkqPgRKaIjDDW1YwhxzO3PAAr+2+moV8zN1iwvllg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HQAGJwNO0w5KlMuOrcjxHZuk9mA+AC5HCk4bI+Wt3JgMDYhj4PCe53meaSNxTDoHL
         p6FuEJk+v6BbCdPaCNEJpuJqw1FcelOfIT9B9e2+uykXHOmjXTJhs+K5jTxNII9kQ2
         rGSlipknR4nnkahyMMh1+5WijYS/8YGVuQP8peFnFldXFEdVjFKganVbBGmehvCrIj
         mNqAKCVP7MJ7l492562p4cFrUZFl9dp/Bn9yte1grKye/mJMkxCMQ4W20Si3rMOXYN
         5pbKAQWXTaYF7C46umjhFQQ74lOvFmMuZ7KL6dVRKxME1QBJPQ5BxmBO7vYLZAcIov
         UIXK9SgsUy6uw==
Date:   Thu, 13 Apr 2023 08:03:21 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2 3/9] objtool: Limit unreachable warnings to once per
 function
Message-ID: <20230413150321.6hd4m3vlnonom3qo@treble>
References: <cover.1681325924.git.jpoimboe@kernel.org>
 <81ed0b8e5218ac6ecae49af901bf5e0fb3687cef.1681325924.git.jpoimboe@kernel.org>
 <20230413080112.GF4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230413080112.GF4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 10:01:12AM +0200, Peter Zijlstra wrote:
> On Wed, Apr 12, 2023 at 12:03:18PM -0700, Josh Poimboeuf wrote:
> 
> > diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/objtool/warn.h
> > index b1c920dc9516..4ef9b278e5fd 100644
> > --- a/tools/objtool/include/objtool/warn.h
> > +++ b/tools/objtool/include/objtool/warn.h
> > @@ -55,7 +55,10 @@ static inline char *offstr(struct section *sec, unsigned long offset)
> >  
> >  #define WARN_INSN(insn, format, ...)					\
> >  ({									\
> > -	WARN_FUNC(format, insn->sec, insn->offset,  ##__VA_ARGS__);	\
> > +	if (!insn->sym || !insn->sym->warned)				\
> > +		WARN_FUNC(format, insn->sec, insn->offset, ##__VA_ARGS__);\
> > +	if (insn->sym)							\
> > +		insn->sym->warned = 1;					\
> >  })
> 
> Do we want to write that like:
> 
> #define WARN_INSN(insn, format, ...)					\
> ({									\
> 	struct instruction *_insn = (insn);				\
> 	if (!_insn->sym || !_insn->sym->warned)				\
> 		WARN_FUNC(format, _insn->sec, _insn->offset, ##__VA_ARGS__);\
> 	if (_insn->sym)							\
> 		_insn->sym->warned = 1;					\
> })
> 
> instead ?

Yes indeed.

-- 
Josh
