Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074B961E778
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 00:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiKFXJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 18:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKFXJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 18:09:50 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592162AF2
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 15:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SzXHz6BQ7p/BBoHVMMGXu8wiir+6Qob62s2++cZUsT0=;
  b=My0zVbutBung+D4/PP31p1kMZaN1kFLt/K6IGKz7slsoRzMWyMIUeuDX
   ChWIml22obp/Kg/8LXnREQ6wDWKUzP18RSg4SLqeWDXuoWhsqZO1+PZOX
   qecP/to2oyuiRKYAZ5ZpoNKaw5tni+dKb+L9AOguDVHq5T3fY77sbRqWH
   E=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.96,143,1665439200"; 
   d="scan'208";a="76902581"
Received: from unknown (HELO hadrien) ([129.126.215.52])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 00:09:45 +0100
Date:   Mon, 7 Nov 2022 07:09:43 +0800 (+08)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH v5a 5/5] treewide: Convert del_timer*() to
 timer_shutdown*()
In-Reply-To: <CAHk-=wjYY9k7TzyJvWOPSPLL+jHkdogyWuOUyStfE5h1=0Qk0w@mail.gmail.com>
Message-ID: <3d43885-dc99-f2a-fbc9-1e8ccad39ed7@inria.fr>
References: <20221106054535.709068702@goodmis.org> <20221106054649.099333291@goodmis.org> <CAHk-=wiD3VWYqgO7JLqRCJvYHiO5RicGAERH1dWQ2pDqnXDy6g@mail.gmail.com> <20221106160956.2414d73f@rorschach.local.home>
 <CAHk-=wjYY9k7TzyJvWOPSPLL+jHkdogyWuOUyStfE5h1=0Qk0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 6 Nov 2022, Linus Torvalds wrote:

> On Sun, Nov 6, 2022 at 1:10 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> >   ... when strict
> >       when != ptr->timer.function = E;
>
> .. and I tried this with just 'ptr->timer', and it doesn't seem to
> make any difference, so apparently that NULL pointer initialization
> was the only case.

OK, good to know.

julia

>
> And then - like you and Guenter - I went through the patch manually to
> look for anything that looked odd, and didn't find anything.
>
> So yes, I'm happy with this. It looks like a very reasonable "let's
> handle the scripted trivial cases automatically", and then anything
> more complicated can be left for 6.2.
>
> And with that cocci script (and how to run it), people can see what
> the script was, and even run it themselves to verify, and that just
> makes me feel all warm and fuzzy about it.
>
>                  Linus
>
