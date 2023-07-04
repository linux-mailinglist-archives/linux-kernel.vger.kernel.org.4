Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C04A74775E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 19:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjGDRBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 13:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjGDRBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 13:01:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F28F1AC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 10:01:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0133E61302
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 17:01:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32EC8C433C8;
        Tue,  4 Jul 2023 17:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688490106;
        bh=LOPLcvVLj/Mftos4Uc1ZlZP/j0YoMDFVMwE2qCTIVdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MV0V21XdkSVDK9kPGElVc5TfmbcDSdv3PxcpocLnqh4MF8MFHqIjhSa5kz3369wAn
         4JzzzOoFV82MLOQoF/n8IEwP+UmxcgwBIE0aHkxFwt69nwrzazleFhc9i93BCcoMkV
         snQ94m4mwbae/Ir9+n7KuzYSu0PdQ4jZl4Jcug6X+vnjsJVkvWeoU8y2jx6tOLe6o9
         Rql6GprOfN5W8EdXWfdqo8T/ZxmA7AHXnFH64wu9evLb0Eo7TDjqtOfQ1SLXZ2qu8G
         SyejXEBpjvhTCB+q+rM7vrAvgnukm12w/2CHCdLtXp18QwxZ1VsHYak8qrN1CynDWd
         cwsYwPwUucLfw==
Date:   Tue, 4 Jul 2023 10:01:44 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+6cf44e127903fdf9d929@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] WARNING in __gup_longterm_locked
Message-ID: <20230704170144.GB1851@sol.localdomain>
References: <000000000000b73abf05ffa60902@google.com>
 <20230704092451.72974b7a62ae08d48c077e10@linux-foundation.org>
 <CAHk-=whzthQy42SzYb1Bs_6tGyss5=SoiOppSE6onjUWDwA=aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whzthQy42SzYb1Bs_6tGyss5=SoiOppSE6onjUWDwA=aw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 09:39:48AM -0700, Linus Torvalds wrote:
> On Tue, 4 Jul 2023 at 09:24, Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > Thanks.  This is the temporary warning which was added by Linus's
> > a425ac5365f6cb3cc4 ("gup: add warning if some caller would seem to want
> > stack expansion").
> 
> Yes, and the randomizer system calls aren't very interesting for that warning.
> 
> I don't have any good idea for how to distinguish "this is a
> randomizer that is just doing crazy things by its very nature and is
> passing in nonsensical system call arguments" from "this is a real
> application that is doing crazy things that we will sadly have to try
> to be backwards compatible with".
> 
> And at the same time, I _really_ don't want that warning to then
> perhaps hide some *other* more real warning from the test automation.
> 
> End result: I'd love for that warning to trigger on real applications
> (including ones run by any cloud test infrastructure, although I doubt
> that infrastructure necessarily runs very interesting loads), but not
> on things like syzbot and trinity that just randomize system calls.
> 
> Does anybody have any ideas how to tell them apart? Maybe syzbot
> already sets some flag for this purpose that I just haven't thought
> of?
> 

syzkaller just makes system calls.

Unless you want to do the crazy thing of checking if current->comm begins with
"syz", I don't think there is a way to distinguish.

In the past there's been some discussion of adding a kconfig option like
CONFIG_FUZZ_TESTING that would be expected to be enabled in order to run a
kernel fuzzer, and changing behavior in certain cases based on that.  Changing
behavior in production vs. test is problematic, though...

- Eric
