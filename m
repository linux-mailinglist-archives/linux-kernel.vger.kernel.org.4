Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8204061E020
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 04:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiKFDQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 23:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKFDQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 23:16:10 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7217E60FF
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 20:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LEn8xfEmsqrxAEaiNlmZfeu2qHv0CsByUUJAbRlRDws=;
  b=iwjvNRiMsyNJQ8kwXWiwuayJfeOVXtdWGPDo9Vw7LBB+0w+g3yBgeSBo
   1807THi11lH5FSglXtAass4xzrp8c3M8+nQ7kgBAmTGnOWmU+9mrc0Q7O
   VkX1pFSoz2g4Q13O5+v7pxd3K5GAeZtXKUU56TjumY2vmLi6f3E8ZytYQ
   c=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.96,141,1665439200"; 
   d="scan'208";a="38577881"
Received: from unknown (HELO hadrien) ([129.126.215.52])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 04:16:02 +0100
Date:   Sun, 6 Nov 2022 11:15:59 +0800 (+08)
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
In-Reply-To: <20221105231241.7513fc33@rorschach.local.home>
Message-ID: <d1fded51-afee-70d8-9e15-9bfeba8b57c@inria.fr>
References: <20221105060024.598488967@goodmis.org> <CAHk-=wi95dGkg7DiuOZ27gGW+mxJipn9ykB6LHB-HrbbLG6OMQ@mail.gmail.com> <20221105123642.596371c7@rorschach.local.home> <20221105140356.6a3da628@rorschach.local.home> <CAHk-=wjnASLkTdPd+wxto2RBQH+S9MUm4FrNPWvU87opFG5SKQ@mail.gmail.com>
 <20221105144303.3552bf85@rorschach.local.home> <775ada-29f1-3b56-7deb-c1b8d958e2c@inria.fr> <20221105203634.7e0b2e8e@rorschach.local.home> <b52c207c-e7bf-af2e-61d9-116c9e76af86@inria.fr> <20221105231241.7513fc33@rorschach.local.home>
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

> On Sun, 6 Nov 2022 11:05:14 +0800 (+08)
> Julia Lawall <julia.lawall@inria.fr> wrote:
>
> > > Thinking that's what you meant (examples would be easier to understand,
> > > than descriptions). And it didn't cover the return case. Does it only
> > > cover gotos?
> > >
> > >   See drivers/net/wireless/intel/iwlwifi/mvm/sta.c for the false positive case:
> > >
> > > 	del_timer_sync(&baid_data->session_timer);
> > > [..]
> >
> > But there is a kfree_rcu(baid_data, rcu_head); right below.  So it looks
> > fine?
>
> D'oh! I think you are correct. I didn't trust the script and it appears
> that it was correct all along. The free was hidden in between the code
> and I only noticed the kfree() in the error path. I thought that was a
> bug in the script. :-/
>
> I guess there were no false positives then. To be sure, I'll write a
> script to find all that have a return or goto in between and see what
> it comes up with.
>
> I guess my original patch doesn't need any changes from the script.
> I'll look more.

You could also consider expression ptr; rather than identifier ptr; if ptr
can be eg x->y.  But if you have akready found all the calls with the
current script, then no need to be more general.

julia
