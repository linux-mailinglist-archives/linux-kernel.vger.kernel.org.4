Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C925694C49
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjBMQTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjBMQSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:18:55 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 457F51A657
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:18:51 -0800 (PST)
Received: (qmail 912402 invoked by uid 1000); 13 Feb 2023 11:18:50 -0500
Date:   Mon, 13 Feb 2023 11:18:50 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller <syzkaller@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH RFC] drivers/core: Replace lockdep_set_novalidate_class()
 with unique class keys
Message-ID: <Y+pi6pA0d22g7sCE@rowland.harvard.edu>
References: <Y+KOeJlvQMYAaheZ@rowland.harvard.edu>
 <a67e24eb-b68f-2abc-50af-ae4c2d4cdd95@I-love.SAKURA.ne.jp>
 <20230208080739.1649-1-hdanton@sina.com>
 <1ad499bb-0c53-7529-ff00-e4328823f6fa@I-love.SAKURA.ne.jp>
 <Y+O6toMmAKBSILMf@rowland.harvard.edu>
 <f79e93ef-cfe8-1373-7c36-15d046c0e3c5@I-love.SAKURA.ne.jp>
 <Y+RZ2RKVo9FNMgSe@rowland.harvard.edu>
 <52c7d509-ba9e-a121-60c9-138d7ff3f667@I-love.SAKURA.ne.jp>
 <Y+gLd78vChQERZ6A@rowland.harvard.edu>
 <Y+oHvi5f+tDMPR31@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+oHvi5f+tDMPR31@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 10:49:50AM +0100, Peter Zijlstra wrote:
> My main worry when adding a ton of classes like this is the
> combinatorics (dynamic classes make this more trivial, but it's entirely
> possible with just static classes too).
> 
> As an example, we used to have a static class per cpu runqueue, now,
> given migration takes two runqueue locks (per locking rules in cpu
> order -- source and dest runqueue etc..) we got O(n^2) combinations of
> class orderings, which lead to a giant graph, which led to both
> performance and memory usage issues.

Having a new class for each device would add a lot of classes.  Just how 
badly this would affect lockdep's performance is hard to predict.  
Testing seems like the best way to find out.

> From this was born the subclass, which reduced the whole thing to a
> static ordering of runqueue-1 goes inside runqueue-0.
> 
> Similar combinatoric issues have cropped up in other places from time to
> time, typically solved by using a different annotation.
> 
> Now, given the whole device thing is more or less a tree, hierarchical
> locking should limit that, the only worry is that sibling locking while
> holding parent thing. If siblings are of different classes, things will
> both complain and create combinatorics again.

Actually, I expect the sibling ordering thing won't come up very often.  
If it does occur somewhere, there's an excellent chance it can be fixed 
by hand (always locking the children in the same order).

I'm worried more about other things.  Suppose do we manage somehow to 
tell lockdep about locks belonging to a logical tree structure.  How 
can this be incorporated into the checking algorithm?

Here's an example.  Let A be a parent device and B its child, and let X 
be some other type of lock entirely (not a device lock).  Suppose at 
some point in the distant past, a first thread locked B and then X -- 
both locks long since released.  Now suppose a second thread locks A and 
then X (presumably valid, right?).  What should happen if this thread 
tries to lock B?

This ought to give rise to a violation: B->X and X->B.  But would this 
not be checked, under the rule that holding A's lock makes it okay to 
take B's lock?

For that matter, what if the second thread had locked X and then A.  
Should that be allowed?  Even though it doesn't directly contradict 
B->X?

Here's a more complicated example, taken from the USB subsystem.  Each 
usb_device structure representing a hub has some number of children 
usb_device structures (for the USB devices plugged into the hub), as 
well as a bunch of child usb_port device structures (representing the 
hub's own downstream ports, which the other USB devices are plugged 
into).

In theory the child usb_device should really be a direct child of the 
usb_port it's plugged into, but for historical reasons the two are 
siblings instead.

So now we have a rule that you cannot lock a usb_device if you're 
holding the lock of the usb_port that it's plugged into.  (Yes, this is 
logically backwards.)  How could we get lockdep to check this?

The only approach I can think of is something I suggested earlier in 
this discussion: Create lockdep classes for bus_types or device_types 
rather than for individual devices.  (usb_device and usb_port have 
different device_types.)  But I don't know how to combine this with the 
tree-structured approach.

Alan Stern
