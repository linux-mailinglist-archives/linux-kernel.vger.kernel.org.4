Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8802D61E013
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 04:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiKFDFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 23:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKFDFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 23:05:21 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9551056C
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 20:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ripiz7bquHA2oeLd16o4nKtQ6i8/6mTwp8aDeJG4/NQ=;
  b=IpB0KYZF0D6SosB0CDleU4eiWgeHZ+23yZvVRVgkAxFPwSFQVRujHzrJ
   ddrmxVt9Gg3epIJLulMpw2WuMUr81faR590sA9Dqtd/xDMZ+chsGPC4bD
   cyel2JWbsLCO0b5npswMcQHnvsmImPxWC5KbkcOog19uqSOGlm23udsiE
   E=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.96,141,1665439200"; 
   d="scan'208";a="38549807"
Received: from unknown (HELO hadrien) ([129.126.215.52])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 04:05:16 +0100
Date:   Sun, 6 Nov 2022 11:05:14 +0800 (+08)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Steven Rostedt <rostedt@goodmis.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4a 00/38] timers: Use timer_shutdown*() before freeing
 timers
In-Reply-To: <20221105203634.7e0b2e8e@rorschach.local.home>
Message-ID: <b52c207c-e7bf-af2e-61d9-116c9e76af86@inria.fr>
References: <20221105060024.598488967@goodmis.org> <CAHk-=wi95dGkg7DiuOZ27gGW+mxJipn9ykB6LHB-HrbbLG6OMQ@mail.gmail.com> <20221105123642.596371c7@rorschach.local.home> <20221105140356.6a3da628@rorschach.local.home> <CAHk-=wjnASLkTdPd+wxto2RBQH+S9MUm4FrNPWvU87opFG5SKQ@mail.gmail.com>
 <20221105144303.3552bf85@rorschach.local.home> <775ada-29f1-3b56-7deb-c1b8d958e2c@inria.fr> <20221105203634.7e0b2e8e@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 5 Nov 2022, Steven Rostedt wrote:

> On Sun, 6 Nov 2022 07:08:48 +0800 (+08)
> Julia Lawall <julia.lawall@inria.fr> wrote:
>
> > Various suggestions:
> >
> > 1.  On your ... put when strict and then on a separate line put when !=
> > ptr.  The when strict will get rid of the goto problem (usually a
> > desirable feature, but not here) and the when != ptr will be sure that ptr
> > is not used before the free.
>
> You mean ptr->timer.function? because it's allowed to be touched. Only
> this case is weird (and I believe I covered it).
>
> Not sure what you mean by "put when strict" I added:
>
>  ... when strict
>
> Thinking that's what you meant (examples would be easier to understand,
> than descriptions). And it didn't cover the return case. Does it only
> cover gotos?
>
>   See drivers/net/wireless/intel/iwlwifi/mvm/sta.c for the false positive case:
>
> 	del_timer_sync(&baid_data->session_timer);
> [..]

But there is a kfree_rcu(baid_data, rcu_head); right below.  So it looks
fine?

julia

>         return 0;
>
> out_free:
>         kfree(baid_data);
>         return ret;
> }
>
> That "return 0" should make the match fail.
>
> >
> > 2.  If you want to handle the initialization of the function field, then
> > you can duplicate the rule and add the removal of that assignment in the
> > first one.  This only seems worth it if it is a very common case.
> > Otherwise, I would agree with Linus and just take care of it by hand
> > later.
>
> No, Linus wants the script to not touch the initialization case. That
> is, currently, the script does the conversion (which also initializes
> it), and the timer.function = NULL is just redundant.
>
> What Linus wanted, was my script to do nothing in this case. But I
> figured this part out.
>
> >
> > 3. Running the rule three times seems to me like a reasonable choice.  Or
> > you could duplicate the rule three times.  But that would be more script
> > to read through.  If this is not a common case, though, you could probably
> > also fix the one up later by hand.
>
> Yeah, that's fine.
>
> I'm just looking for how to avoid the goto / return case.
>
> -- Steve
>
