Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4472364A862
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 21:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbiLLUGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 15:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbiLLUGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:06:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCE3178AB;
        Mon, 12 Dec 2022 12:06:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61405611FB;
        Mon, 12 Dec 2022 20:06:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBCFC433EF;
        Mon, 12 Dec 2022 20:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670875578;
        bh=X5xmfWRTmgqPRq7JxHELTB+1YzEZLrNIUjkjESAieLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hjhQE9tSqE1qG14JX44LeNEEuvaTD1RKr5NzuJgBYdyUc5X5zx/nevMdch4cMHqla
         aET/T9m9eKSjPgNnLkPHHRf3GoAQKdpx0xmBPT+1mu/v66c/rn9/76lMesQddph8TV
         ODoeJUeeRFXXLdiksvfnZivLkbRw9O9MrYuk14fhCE1zlelcjPgNMee/2ti9TcqcJW
         Xi6JgrXtj8RJF73XhawyUPXap8Us/RLe/BPFcre5Dhu7g8VZ26du8pE44KPMW6XJ+r
         Lvp0UNErnPuJ3+lFMl0I3/DAAJMZkslbHbweunIJE4sBZ2xfQhTDwyayALW84Pe52r
         v6AwKjJzVO0dA==
Date:   Mon, 12 Dec 2022 13:06:16 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Nicolas Schier <nicolas@fjasle.eu>,
        Sami Tolvanen <samitolvanen@google.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Steffen Klassert <steffen.klassert@secunet.com>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 1/2] padata: Mark padata_work_init() as __ref
Message-ID: <Y5eJuBWoCJ+q++IM@dev-arch.thelio-3990X>
References: <20221207191657.2852229-1-nathan@kernel.org>
 <20221207191657.2852229-2-nathan@kernel.org>
 <CAK7LNARoxqSzjpM0twcssMkf9X_PppzqtUo_opq=CX+zixma8g@mail.gmail.com>
 <Y5dfPgNF8E2EpNCM@dev-arch.thelio-3990X>
 <20221212192157.plxiyyinfhieyzbt@parnassus.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212192157.plxiyyinfhieyzbt@parnassus.localdomain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 02:21:57PM -0500, Daniel Jordan wrote:
> On Mon, Dec 12, 2022 at 10:05:02AM -0700, Nathan Chancellor wrote:
> > On Mon, Dec 12, 2022 at 10:07:24PM +0900, Masahiro Yamada wrote:
> > > I am not sure if the compiler should do this level of optimization
> > > because kernel/padata.c does not seem to be a special case.
> > > Perhaps, we might be hit with more cases that need __ref annotation,
> > > which is only required by LTO.
> > 
> > That's possible. I did only see this once instance in all my builds but
> > allmodconfig + ThinLTO might not be too interesting of a case,
> > since the sanitizers will be enabled, which makes optimization more
> > difficult. I could try to enable ThinLTO with some distribution
> > configurations to see if there are any more instances that crop up.
> 
> Yes, if there were many more instances of this problem it might be worth
> thinking about an LTO-specific solution to fix it closer to the source.

Ack, I will wire up some build tests to see if this optimization occurs
frequently enough to warrant a wider fix.

> > > One note is that, we could discard padata_work_init()
> > > because (1) and (3) are both annotated as __init.
> > > So, another way of fixing is
> > >    static __always_inline void padata_work_init(...)
> > > because the compiler would determine padata_work_init()
> > > would be small enough if the caller and callee belonged to
> > > the same section.
> > > 
> > > I do not have a strong opinion.
> 
> I'm right there with you.  :-)
> 
> > > Honestly, I do not know what the best approach would be to fix this.
> 
> Either approach works, either can include an explanatory comment.
> __ref seems more targeted to the problem at hand.

Right, I suspect __ref is the right way to go for this particular issue.
I will add a comment regardless.

> > > If we go with the __ref annotation, I can pick this, but
> > > at least can you add some comments?
> > > 
> > > 
> > > include/linux/init.h says:
> > > "optimally document why the __ref is needed and why it's OK"
> > > 
> > > 
> > > I think this is the case that needs some comments
> > > because LTO optimization looks too tricky to me.
> > 
> > Sure thing, I will send a v3 either Tuesday or Wednesday with an updated
> > commit message and code comment if we end up going this route.
> 
> A nitpick, but as long as you're respinning, if we stay with this
> approach, could you put __ref just before the function name?  init.h
> says "The markers follow same syntax rules as __init / __initdata" and
> for those it says "You should add __init immediately before the function
> name" though there are plenty of places in the tree that don't do this.

Sure thing!

Cheers,
Nathan
