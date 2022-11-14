Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6CA628A6E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237622AbiKNU3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236756AbiKNU3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:29:34 -0500
X-Greylist: delayed 80 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Nov 2022 12:29:32 PST
Received: from one.firstfloor.org (one.firstfloor.org [193.170.194.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360E032C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:29:32 -0800 (PST)
Received: by one.firstfloor.org (Postfix, from userid 503)
        id BC24287762; Mon, 14 Nov 2022 21:29:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1668457770;
        bh=Kt8/WDdkL9ESEnpGDjl/yyFjVmr0lYuznqdumt5bCf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h8NYVeKDVCHh0JLjbH1nVn6UKY4wo8RDA0FaLjRzAPh6KqQndVk4kitaazaQw/F6u
         AYP5ZcvhuXWCBdLnpYOsiKBhj+YaKlWk5ymHXCZwCpyHD3TSbwrc4D/uXUUp1r7ulL
         zPygjnk9JctiwifdfvMxU1I/YDZ4u8TFpoVCEt+U=
Date:   Mon, 14 Nov 2022 12:29:30 -0800
From:   Andi Kleen <andi@firstfloor.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 10/46] static_call, lto: Mark func_a() as __visible_on_lto
Message-ID: <20221114202930.w6mzwpiii6xlhqkm@two.firstfloor.org>
References: <20221114114344.18650-1-jirislaby@kernel.org>
 <20221114114344.18650-11-jirislaby@kernel.org>
 <Y3JkqDBR0zgaTyPn@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3JkqDBR0zgaTyPn@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 04:54:16PM +0100, Peter Zijlstra wrote:
> On Mon, Nov 14, 2022 at 12:43:08PM +0100, Jiri Slaby (SUSE) wrote:
> 
> > -static int func_a(int x)
> > +__visible_on_lto int sc_func_a(int x)
> 
> >  } static_call_data [] __initdata = {
> >        { NULL,   2, 3 },
> >        { func_b, 2, 4 },
> > -      { func_a, 2, 3 }
> > +      { sc_func_a, 2, 3 }
> >  };
> 
> I must say I really hate this. Also, with address taken, it still
> eliminiates it?

It doesn't eliminate it, but makes it static, which causes the label to
change, so the assembler reference breaks.

-Andi
