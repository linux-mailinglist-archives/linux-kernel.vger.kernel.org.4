Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C0D69583D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 06:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjBNFNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 00:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjBNFNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 00:13:09 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1C5613525
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 21:12:32 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id A6F4992009C; Tue, 14 Feb 2023 06:12:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 9A5CE92009B;
        Tue, 14 Feb 2023 05:12:29 +0000 (GMT)
Date:   Tue, 14 Feb 2023 05:12:29 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86: Use `get_random_u8' for kernel stack offset
 randomization
In-Reply-To: <874jrptmk9.ffs@tglx>
Message-ID: <alpine.DEB.2.21.2302140456360.6368@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2301302011150.55843@angie.orcam.me.uk> <874jrptmk9.ffs@tglx>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2023, Thomas Gleixner wrote:

> On Mon, Jan 30 2023 at 21:30, Maciej W. Rozycki wrote:
> >
> > Therefore switch to our generic entropy source and use `get_random_u8' 
> > instead, which according to Jason A. Donenfeld is supposed to be fast 
> > enough:
> >
> > "Generally it's very very fast, as most cases wind up being only a
> > memcpy -- in this case, a single byte copy. So by and large it should
> > be suitable. It's fast enough now that most networking things are able
> > to use it. And lots of other places where you'd want really high
> > performance. So I'd expect it's okay to use here too. And if it is too
> > slow, we should figure out how to make it faster. But I don't suspect
> > it'll be too slow."
> 
> Please provide numbers on contemporary hardware.

 Jason, is this something you could help me with to back up your claim?  

 My access to modern x86 gear is limited and I just don't have anything I 
can randomly fiddle with (I guess an Intel Core 2 Duo T5600 processor back 
from 2008 doesn't count as "contemporary", does it?).

> Up to that point, it's easy enough to just disable that randomization on
> 32bit.

 I think for 32-bit we could just go with `get_random_u8' unconditionally, 
but if you'd rather I disabled the feature altogether such as in v1 or v2, 
then I'm happy to resubmit whichever version seems the best, or make yet a 
different one.  Please mind the security implications of RDTSC raised in 
the discussion though.  Thanks for your feedback.

  Maciej
