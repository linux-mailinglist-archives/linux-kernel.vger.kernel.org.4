Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9728961DF9C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 00:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiKEXJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 19:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiKEXJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 19:09:00 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F037ADFA1
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 16:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Q/9ET4cFbhuoGwYiqD90q6Plgelo9P0wikTUkhWPd5Q=;
  b=ZUv3wBA6MOwL3oYTgFkrEwH/15JI54vlLrMBN+jP78/zEOIwN8YEbUSq
   ZvGP4vmaFr0pTOL1azGnM6EUEWU7KZLN9UxsBlOmZZagiTF6dTUBbbleP
   I7q7IIssf1ArWR7zCr4MOkuO1W/YQS3ZD179XgCjenYuGMbJ9IZIzpF5s
   0=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.96,141,1665439200"; 
   d="scan'208";a="38035264"
Received: from unknown (HELO hadrien) ([129.126.215.52])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 00:08:51 +0100
Date:   Sun, 6 Nov 2022 07:08:48 +0800 (+08)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Steven Rostedt <rostedt@goodmis.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH v4a 00/38] timers: Use timer_shutdown*() before freeing
 timers
In-Reply-To: <20221105144303.3552bf85@rorschach.local.home>
Message-ID: <775ada-29f1-3b56-7deb-c1b8d958e2c@inria.fr>
References: <20221105060024.598488967@goodmis.org> <CAHk-=wi95dGkg7DiuOZ27gGW+mxJipn9ykB6LHB-HrbbLG6OMQ@mail.gmail.com> <20221105123642.596371c7@rorschach.local.home> <20221105140356.6a3da628@rorschach.local.home> <CAHk-=wjnASLkTdPd+wxto2RBQH+S9MUm4FrNPWvU87opFG5SKQ@mail.gmail.com>
 <20221105144303.3552bf85@rorschach.local.home>
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

> On Sat, 5 Nov 2022 11:28:33 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > On Sat, Nov 5, 2022 at 11:04 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > Here's the changes I made after running the script
> >
> > Please. No.
> >
> > What part of "I don't want extra crud" was I unclear on?
>
> The first one was a false change. That is, the script *did* catch it,
> when it should not have. So I reverted the change. The coccinelle
> documentation even states to look over the changes to see if there are
> false positives.
>
> The second change is that it frees three timers all for the same
> object. If you want, I could run the script 2 more times on the same
> file, and it will catch it then.
>
> Would you be happier if I just ran it three times on that file? I can do
> that, and it will produce the same result.

Various suggestions:

1.  On your ... put when strict and then on a separate line put when !=
ptr.  The when strict will get rid of the goto problem (usually a
desirable feature, but not here) and the when != ptr will be sure that ptr
is not used before the free.

2.  If you want to handle the initialization of the function field, then
you can duplicate the rule and add the removal of that assignment in the
first one.  This only seems worth it if it is a very common case.
Otherwise, I would agree with Linus and just take care of it by hand
later.

3. Running the rule three times seems to me like a reasonable choice.  Or
you could duplicate the rule three times.  But that would be more script
to read through.  If this is not a common case, though, you could probably
also fix the one up later by hand.

julia
