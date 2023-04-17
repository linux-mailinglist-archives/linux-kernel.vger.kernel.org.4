Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DC36E4323
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 11:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjDQJE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 05:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDQJEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 05:04:20 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E05170D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 02:04:19 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BD03E1EC0338;
        Mon, 17 Apr 2023 11:04:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681722257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rWzkI3qQG/NuXcS/YM+xYmwtbGykjkEqCxWHFmCGjwE=;
        b=gf7h+BtdQuRjQ2+8BYQBbPYzPG1x5I7T84Mu0TiqtOtwME/3YeeXOWVSHVkU92oUfrjigD
        zbJ4jeK87GDVxL4U9w2PtKzKTBdyWcAnJ2Pb1nno1QbGCyrAwd8XpyCUTG3Er0gsNrWG5L
        cd1a+pfjzRajmqguQ5QXy9oZEa16GW8=
Date:   Mon, 17 Apr 2023 11:04:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/urgent for v6.3-rc7
Message-ID: <20230417090412.GAZD0LjH5ZIaGUdoHH@fat_crate.local>
References: <20230416122913.GCZDvqGVe9TPa5LPRm@fat_crate.local>
 <CAHk-=wjOZgMu2VYBHMt-yFvurAqWsxLG8wh59km=B245CXRKxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjOZgMu2VYBHMt-yFvurAqWsxLG8wh59km=B245CXRKxA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023 at 10:33:19AM -0700, Linus Torvalds wrote:
> On Sun, Apr 16, 2023 at 5:29 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > - Drop __init annotation from two rtc functions which get called after
> >   boot is done, in order to prevent a crash
> 
> .. ahh, and our automation to catch these things didn't find it,
> because they are only accessed from x86_wallclock_init(), which is
> also __init.
> 
> So it all looked superficially good, except for the "oh, we saved them
> into a data structure that _isn't_ init".
> 
> It would require automation much smarter than the one we have to catch
> that kind of thing.

Looking at

objdump -D arch/x86/kernel/x86_init.o

output, all the info is there in order to check whether a function ptr from
a .init section gets assigned to .data section structure.

Question is whether this is worth to put into objtool. From all the
objtool code I've seen flying by in recent years, we should pretty much
have everything needed so it should relatively easy to do.

But lemme add Josh and Peter...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
