Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119776A6C9C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 13:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjCAMwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 07:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjCAMwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 07:52:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629CA136EC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 04:52:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12250B8102B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 12:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457AAC433D2;
        Wed,  1 Mar 2023 12:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677675151;
        bh=WudUEJq2ZszYKZV54H6wJnTcLpTaVs+KCR1T9gkklBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PvY2Cf2hWjz5TNdgybNFsEg60NDrlqn1OVLoMaomBtxy139LWxUV14pk8rDbX5Hzl
         4ju+pX+r8zwf3wx1uOG+HxhjVJQ2sOz9v5vDNlPjp6jLzwS2Dx60h7QMney30xzO49
         KvtgUlr+Z1Nq3BZYAqhOzgNjdv7jGDwCDDIMRqfs=
Date:   Wed, 1 Mar 2023 13:52:29 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Cheng-Jui Wang =?utf-8?B?KOeOi+ato+edvyk=?= 
        <Cheng-Jui.Wang@mediatek.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "surenb@google.com" <surenb@google.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        Bobule Chang =?utf-8?B?KOW8teW8mOe+qSk=?= 
        <bobule.chang@mediatek.com>,
        "fweisbec@gmail.com" <fweisbec@gmail.com>
Subject: Re: [BUG v6.0-rc2] lockdep splat on ct_kernel_enter()
Message-ID: <Y/9KjY48FoHIHJ44@kroah.com>
References: <20220822164404.57952727@gandalf.local.home>
 <833cecca4460ae3c371455cef75b40a1f3922758.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <833cecca4460ae3c371455cef75b40a1f3922758.camel@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 12:37:29PM +0000, Cheng-Jui Wang (王正睿) wrote:
> On Mon, 2022-08-22 at 16:44 -0400, Steven Rostedt wrote:
> > My tests are failing because of this splat:
> > 
> > [   16.073659] ------------[ cut here ]------------
> > [   16.074407] bus: 'platform': add driver acpi-ged
> > [   16.074424] DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled())
> > [   16.074424] WARNING: CPU: 0 PID: 0 at
> > kernel/locking/lockdep.c:5506 check_flags+0x114/0x1d0
> 
> > [   16.074424]  lock_is_held_type+0x6f/0x130
> > [   16.186284]  rcu_read_lock_sched_held+0x4a/0x90
> > [   16.186284]  trace_rcu_dyntick+0x3a/0xe0
> > [   16.186284]  ct_kernel_enter.constprop.0+0x66/0xa0
> > [   16.186284]  ct_idle_exit+0xd/0x30
> > [   16.186284]  cpuidle_enter_state+0x28a/0x310
> > [   16.186284]  cpuidle_enter+0x2e/0x50
> > [   16.186284]  do_idle+0x1ec/0x280
> 
> Our test in v6.1 stable is failing due to this splat too. The v6.1
> stable kernel still has this splat.
> 
> This splat can be fixed by Peter's patch 
> https://lore.kernel.org/all/20220608144516.808451191@infradead.org/
> , but the fix is part of a big patchset 
> https://lore.kernel.org/all/20220608142723.103523089@infradead.org/
> introduced in 6.2.
> 
> Could the fixes be backported to v6.1 stable?

What "fixes" exactly are you referring to?  Can you provide a series of
git commit ids that cleanly apply or better yet, and series of patches
that you have backported and tested to ensure that they work properly?

thanks,

greg k-h
