Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC62A6A7B74
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 07:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCBGms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 01:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBGmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 01:42:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC983E0AB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 22:42:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6833B81197
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9163C433D2;
        Thu,  2 Mar 2023 06:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677739362;
        bh=8gN0qsoircXMNoS9GwNs8Pdl1PkvB3dO04eHur3SKo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a6eWueoOs055CMuYd2s0MhY5DLJcvG4o+Kn9lkpb33zridxI8o1X35LK+XwHMjvf7
         5loDzs+FkPGSpZk/2NsaNr5lCu2zuAoWdvttNI4CaqB5dNB0HhFLiBmRoBG6ana/Hw
         8H0n4j2gtV0uesTUtbjrOmXC3E2AhWvbB2Cts+uc=
Date:   Thu, 2 Mar 2023 07:42:39 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Cheng-Jui Wang =?utf-8?B?KOeOi+ato+edvyk=?= 
        <Cheng-Jui.Wang@mediatek.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "surenb@google.com" <surenb@google.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Bobule Chang =?utf-8?B?KOW8teW8mOe+qSk=?= 
        <bobule.chang@mediatek.com>,
        "fweisbec@gmail.com" <fweisbec@gmail.com>
Subject: Re: [BUG v6.0-rc2] lockdep splat on ct_kernel_enter()
Message-ID: <ZABFX8rkPwC2vm8/@kroah.com>
References: <20220822164404.57952727@gandalf.local.home>
 <833cecca4460ae3c371455cef75b40a1f3922758.camel@mediatek.com>
 <Y/9KjY48FoHIHJ44@kroah.com>
 <8fc10d148f3e0e04c89de03057726cc01c31b7f5.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8fc10d148f3e0e04c89de03057726cc01c31b7f5.camel@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 03:42:12AM +0000, Cheng-Jui Wang (王正睿) wrote:
> On Wed, 2023-03-01 at 13:52 +0100, gregkh@linuxfoundation.org wrote:
> > On Wed, Mar 01, 2023 at 12:37:29PM +0000, Cheng-Jui Wang (王正睿) wrote:
> > > On Mon, 2022-08-22 at 16:44 -0400, Steven Rostedt wrote:
> > > > My tests are failing because of this splat:
> > > > 
> > > > [   16.073659] ------------[ cut here ]------------
> > > > [   16.074407] bus: 'platform': add driver acpi-ged
> > > > [   16.074424] DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled())
> > > > [   16.074424] WARNING: CPU: 0 PID: 0 at
> > > > kernel/locking/lockdep.c:5506 check_flags+0x114/0x1d0
> > > > [   16.074424]  lock_is_held_type+0x6f/0x130
> > > > [   16.186284]  rcu_read_lock_sched_held+0x4a/0x90
> > > > [   16.186284]  trace_rcu_dyntick+0x3a/0xe0
> > > > [   16.186284]  ct_kernel_enter.constprop.0+0x66/0xa0
> > > > [   16.186284]  ct_idle_exit+0xd/0x30
> > > > [   16.186284]  cpuidle_enter_state+0x28a/0x310
> > > > [   16.186284]  cpuidle_enter+0x2e/0x50
> > > > [   16.186284]  do_idle+0x1ec/0x280
> > > 
> > > Our test in v6.1 stable is failing due to this splat too. The v6.1
> > > stable kernel still has this splat.
> > > 
> > > This splat can be fixed by Peter's patch 
> > > https://lore.kernel.org/all/20220608144516.808451191@infradead.org/
> > > , but the fix is part of a big patchset 
> > > https://lore.kernel.org/all/20220608142723.103523089@infradead.org/
> > > introduced in 6.2.
> > > 
> > > Could the fixes be backported to v6.1 stable?
> > 
> > What "fixes" exactly are you referring to?  
> a01353cf1896 ("cpuidle: Fix ct_idle_*() usage") and other patches it
> needs.
> 
> > Can you provide a series of
> > git commit ids that cleanly apply or better yet, and series of
> > patches
> > that you have backported and tested to ensure that they work
> > properly?
> Suren has backported part of the patchset to fix this particular issue
> in android14-6.1: 
> https://android-review.googlesource.com/c/kernel/common/+/2449203 to 
> https://android-review.googlesource.com/c/kernel/common/+/2449212. I
> have tested these patches and confirmed these can fix this splat.
> 
> Following are the commit ids of the above series of patches in Linus'
> tree:
> 5e26aa93391195a64871db5d96d7163f0062ca4f
> 8e9ab9e8da1eae61fdff35690d998eaf8cd527dc
> 5fca0d9f5d76664786ca6c09076341def165a677
> e038f7b8028a1d1bc8ac82351c71ea538f19a879
> b3f46658ce40a3467cda82f920dd9d5325ab0eaf
> 4d1be9e745382b41492b0cb9000829863db7133a
> 4ce40e9dbe83153f60d7e4ccd24a1eb4f8264f6a
> c3d42418dca53d6c498a48c408f7a45289593650
> 0c5ffc3d7b15978c6b184938cd6b8af06e436424
> a01353cf1896ea5b8a7bbc5e2b2d38feed8b7aaa

Please submit the full set of backported patches, with your
signed-off-by, to the stable@vger.kernel.org mailing list, and we will
be glad to review them there.

thanks,

greg k-h
