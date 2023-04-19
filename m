Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F806E7FDB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 18:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjDSQo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 12:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjDSQoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 12:44:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D87BB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 09:44:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9825640DF
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 16:44:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00256C433D2;
        Wed, 19 Apr 2023 16:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681922693;
        bh=H0AAYLCGw3D1xIThJOvHWSbllE3+q0cBwJKUNOtqOik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rDK0T5Lk6twf+NjxuUroLIFf7NYvgHHpF1XMSq3Kga5ZoppzAe0sqQPTo5leiW8uT
         DFCrPR4BkzGFBg2DzBEkVRQh8ORkBe6yIBCMA1poR8nziYthdHpTjJ8h+7HSLfvtkb
         T1SXJOy4VRJOIw7XJ9rotkB/+Vi7DQDCtEPCkaRfvFwz/OtzBoPwVVSjuU1/Qv4Eb+
         wFXdOHxu3BWHEsB2vIRSB6O8b2p7Wmp5KirOO3Oz/4/543UDNWGhPNR0xwYto5Kw5E
         MM/KYzazCH9EO54GKstI44WaxoK9RrwDUBOHiEH/w8pz9I4KofQcN+6+rYpPlnJWmv
         yo7XeS+4HmUBA==
Date:   Wed, 19 Apr 2023 09:44:51 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/urgent for v6.3-rc7
Message-ID: <20230419164451.2vtnawrvbhajrb2g@treble>
References: <20230416122913.GCZDvqGVe9TPa5LPRm@fat_crate.local>
 <CAHk-=wjOZgMu2VYBHMt-yFvurAqWsxLG8wh59km=B245CXRKxA@mail.gmail.com>
 <20230417090412.GAZD0LjH5ZIaGUdoHH@fat_crate.local>
 <20230418012435.fhjxd6moaz6tmnep@treble>
 <20230419155900.GCZEAPxNiOUP31q+/H@fat_crate.local>
 <ed6bfa1a-7e82-8273-ee7f-0e8097397724@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ed6bfa1a-7e82-8273-ee7f-0e8097397724@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 06:03:53PM +0200, Juergen Gross wrote:
> > However, the only call site is in apic_intr_mode_init() which itself is
> > __init. So yeah, strictly speaking nothing wrong.
> > 
> > *IF* something calls it later, when __init is gone, then boom.
> > 
> > Dunno, maybe
> > 
> > a) track call sites too but maybe expensive and too much

That would indeed be a lot harder to do.

> > or
> > 
> > b) make those warnings debug messages in case someone wants to run objtool
> > in debug mode, feels really bored and wants to fix potential issues.

Possibly, though I suspect nobody's ever going to be that bored ;-)

> > Or someone has a better idea.
> > 
> > > Anyway, this is kind of experimental.  If any of these warnings don't
> > > turn out to be useful I could drop some or all them.
> > 
> > Right, I can certainly see potential and as said, since we're already
> > doing objtool massaging of object files, thought this should be pretty
> > easy to do. As you've shown. ;-)
> 
> What about splitting the function vectors into __init and non-init parts?
> 
> This would solve above problem automatically, as a non-init function couldn't
> deref the __init part of x86_platform.

Right, if we moved the __init parts of x86_platform out into a separate
struct x86_platform_init which is __initdata, that would solve this
particular issue rather cleanly.

Though, more generally, if we make the rule that non-init data can't
contain references to init data, that would be a much bigger patch set.

Which might end up being the reasonable thing to do, but before deciding
whether enforcing such a rule would be worth it, we might want to look
more deeply at the warnings to figure out what percentage of those (if
any) could be real bugs.

-- 
Josh
