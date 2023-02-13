Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3297694B05
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjBMPZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjBMPZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:25:13 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id BBF6A9018
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:25:11 -0800 (PST)
Received: (qmail 909736 invoked by uid 1000); 13 Feb 2023 10:25:10 -0500
Date:   Mon, 13 Feb 2023 10:25:10 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Coly Li <colyli@suse.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller <syzkaller@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH RFC] drivers/core: Replace lockdep_set_novalidate_class()
 with unique class keys
Message-ID: <Y+pWVksggbe3MT1f@rowland.harvard.edu>
References: <Y+hRurRwm//1+IcK@rowland.harvard.edu>
 <Y+hTEtCKPuO0zGIt@moria.home.lan>
 <Y+hW74TAVzCpSv7c@rowland.harvard.edu>
 <Y+hYn6uzIUBaxDdV@moria.home.lan>
 <Y+kEgDLSRwdODRdD@rowland.harvard.edu>
 <Y+k6ehYLWa0cmbvb@moria.home.lan>
 <Y+lJxCLpwMGuq0sP@rowland.harvard.edu>
 <Y+lROV3Ii+WbmZCh@moria.home.lan>
 <Y+mRFUws3dOpU8qS@rowland.harvard.edu>
 <Y+memjO1BxrVF20h@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+memjO1BxrVF20h@moria.home.lan>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2023 at 09:21:14PM -0500, Kent Overstreet wrote:
> On Sun, Feb 12, 2023 at 08:23:34PM -0500, Alan Stern wrote:
> > I really don't think that's a good idea here.  When you've got a bus 
> > containing multiple devices, typically all those device structures are 
> > created by the same line of code.  So knowing the source code location 
> > won't tell you _which_ device structure is involved in the locking 
> > cycle or what driver it's using.
> 
> Yeah, I was thinking about this more and realized it'd be insufficient.
> 
> > By contrast, knowing the device name 
> > would.
> > 
> > Furthermore, to the extent that the device's name identifies what kind 
> > of device it is, the name would tell you what where the structure was 
> > created and which driver it is using.
> 
> OTOH, with the device name, it seems like you'll additionally need the
> full device topology to be able to do anything with lockdep splats, no?

Not necessarily.  Knowing the name already tells you something about 
where the device fits into the full tree.  And if necessary, you can 
probably glean the necessary information from the kernel log.

Besides, you often don't need the full device topology.  For instance, 
if the problem is that a driver is flushing a work queue while holding a 
lock needed by an item on the queue, mostly you just need to know what 
driver and where the flush occurs -- and that information is already 
provided by lockdep.

> What if we just added a way to set a comparison function for a lockdep
> class? I'm looking at the lockdep code now, and I think I could do that
> for you.

I don't know what a lockdep class comparison function does (or would 
do).  Nor how having one would help.

Alan Stern
