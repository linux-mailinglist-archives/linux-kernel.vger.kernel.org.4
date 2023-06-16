Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CF2733B81
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 23:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345400AbjFPV1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 17:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjFPV1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 17:27:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C7335A4;
        Fri, 16 Jun 2023 14:27:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CB4C608D5;
        Fri, 16 Jun 2023 21:27:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E39C433C8;
        Fri, 16 Jun 2023 21:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686950819;
        bh=D9es2nKp9Ev8bORerv5Q2SQnj714HqIyXls58J2lvbQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jm7Bwmdnq20NMlCIR1RNJcA+lc039tU4uv/z/zpq5pvwTo+sys8G3LYFWVK4ij5Uk
         9BlFlLSWoLotBJ3iI2LNYMnmjZ+0ib5Uy2WiET02sANALhAvkyDcNCu79hVoc2c3oF
         cLv7jaCef70LbMKiqgKwJBASZThDEeTNbEt/IIpJpSEPcRuFe5tIuiPRNq2FprmhFo
         wAQHASLo3WEcml1mzennCmg9bfsbnmiJl6uJgqQqgvWEQHIUp3yGpGFgqV8idb+b8B
         u+hU5sEEXvP0PkXq5Ki2v6uSujD8Y9upvGE9x/QIKqUlsUQjm/ZqffKpe1K0ISb7zk
         XKPlIX4nqlI8Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5D434CE0DD0; Fri, 16 Jun 2023 14:26:59 -0700 (PDT)
Date:   Fri, 16 Jun 2023 14:26:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rcu@vger.kernel.org, jonathanh@nvidia.com, wenst@chromium.org,
        angelogioacchino.delregno@collabora.com,
        rafael.j.wysocki@intel.com, mirq-linux@rere.qmqm.pl,
        dmitry.osipenko@collabora.com, sachinp@linux.ibm.com,
        qiang.zhang1211@gmail.com
Subject: Re: [GIT PULL] RCU regression fix for v6.4
Message-ID: <8c3ac35d-5056-4f4b-a8c4-ca625fa01b1f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <21bdc866-f9ae-4cda-a996-370bde183fd0@paulmck-laptop>
 <CAHk-=wiPA8d0z2K1huqP0jCKxfmjBG_VYnJtoADeQWsvWLv9UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiPA8d0z2K1huqP0jCKxfmjBG_VYnJtoADeQWsvWLv9UQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 11:50:31AM -0700, Linus Torvalds wrote:
> On Fri, 16 Jun 2023 at 09:34, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Yes, it would be nice to abstract this somehow in order to hide it in
> > SRCU, but I still don't see a good way of doing this.
> 
> Ehh - like we actually do spinlocks in general, perhaps?
> 
> Spinlocks always exist. On UP - with no spinlock debugging - it turns
> into a zero-sized data structure, and the spin lock/unlock operations
> are no-ops.
> 
> Why don't you just do the exact same thing with the "struct
> srcu_usage". For Tiny SRCU, just make it an empty struct, with an
> empty initializer.
> 
> IOW, don't "abstract it out". Abstract it IN. Make tiny-rcu still have
> it, just as a no-op.
> 
> Anyway, I've pulled your fix, but maybe the above would have been the
> cleaner solution?

Good point, thank you!  I will add the lock to Tiny SRCU, shooting for
the v6.6 merge window.

							Thanx, Paul
