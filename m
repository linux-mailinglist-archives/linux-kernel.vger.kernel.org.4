Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4096941E4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjBMJuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjBMJuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:50:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FD41706;
        Mon, 13 Feb 2023 01:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IycSik+U8gNIigtHBg2/UqmURotUIu2bkaSQXZkjcgE=; b=Dw4vssxu+XOw9RNk+ekhVuCYvl
        mD3Hj1Elk1tL0/4THXB8PMAtruNxA5hVmFgosNTtJlMkptEXgLeHX1OWu/vc6DLYbBJ7Z9y/6Olnq
        IJBUCIPfKtYnSnEXOj12HdwPz3+Z23foW30PhpoTkE4iW7f4kg88yP6HIOmpcZ8XLtO/2GaC3G8fO
        3oV9MMbNdXQKw2j6mxbSAFos5vS+9XS8p+amLBaRixt96JX1JM+tKZQEsKBkVeRCKw5qPExb7DHM5
        72sg1UU1/lJwSTPHOCDE7h5/T9LfeheKLU/katPBWXN0W6KHB8wVj4454NAPu3MwF/H4MomD2CKW/
        LSCNzW8g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRVT5-005ct9-Mv; Mon, 13 Feb 2023 09:49:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 29CD930012F;
        Mon, 13 Feb 2023 10:49:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 115E520C6EEA1; Mon, 13 Feb 2023 10:49:51 +0100 (CET)
Date:   Mon, 13 Feb 2023 10:49:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alan Stern <stern@rowland.harvard.edu>
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
Message-ID: <Y+oHvi5f+tDMPR31@hirez.programming.kicks-ass.net>
References: <a7d0e143-1e68-5531-5c2e-1f853d794bc0@I-love.SAKURA.ne.jp>
 <Y+KOeJlvQMYAaheZ@rowland.harvard.edu>
 <a67e24eb-b68f-2abc-50af-ae4c2d4cdd95@I-love.SAKURA.ne.jp>
 <20230208080739.1649-1-hdanton@sina.com>
 <1ad499bb-0c53-7529-ff00-e4328823f6fa@I-love.SAKURA.ne.jp>
 <Y+O6toMmAKBSILMf@rowland.harvard.edu>
 <f79e93ef-cfe8-1373-7c36-15d046c0e3c5@I-love.SAKURA.ne.jp>
 <Y+RZ2RKVo9FNMgSe@rowland.harvard.edu>
 <52c7d509-ba9e-a121-60c9-138d7ff3f667@I-love.SAKURA.ne.jp>
 <Y+gLd78vChQERZ6A@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+gLd78vChQERZ6A@rowland.harvard.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 04:41:11PM -0500, Alan Stern wrote:
> Lockdep is blind to the dev->mutex field of struct device, owing to
> the fact that these mutexes are assigned to lockdep's "novalidate"
> class.  Commit 1704f47b50b5 ("lockdep: Add novalidate class for
> dev->mutex conversion") did this because the hierarchical nature of
> the device tree makes it impossible in practice to determine whether
> acquiring one of these mutexes is safe or might lead to a deadlock.
> 
> Unfortunately, this means that lockdep is unable to help diagnose real
> deadlocks involving these mutexes when they occur in testing [1] [2]
> or in actual use, or to detect bad locking patterns that might lead to
> a deadlock.  We would like to obtain as much of lockdep's benefits as
> possible without generating a flood of false positives -- which is
> what happens if one naively removes these mutexes from the
> "novalidate" class.
> 
> Accordingly, as a middle ground the mutex in each non-static struct
> device will be placed in its own unique locking class.  This approach
> gives up some of lockdep's advantages (for example, all devices having
> a particular bus_type or device_type might reasonably be put into the
> same locking class), but it should at least allow us to gain the
> benefit of some of lockdep's capabilities.
> 
> Link: https://syzkaller.appspot.com/bug?extid=2d6ac90723742279e101 [1]
> Link: https://syzkaller.appspot.com/bug?extid=2e39bc6569d281acbcfb [2]
> Link: https://lore.kernel.org/all/28a82f50-39d5-a45f-7c7a-57a66cec0741@I-love.SAKURA.ne.jp/
> Suggested-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Boqun Feng <boqun.feng@gmail.com>

My main worry when adding a ton of classes like this is the
combinatorics (dynamic classes make this more trivial, but it's entirely
possible with just static classes too).

As an example, we used to have a static class per cpu runqueue, now,
given migration takes two runqueue locks (per locking rules in cpu
order -- source and dest runqueue etc..) we got O(n^2) combinations of
class orderings, which lead to a giant graph, which led to both
performance and memory usage issues.

From this was born the subclass, which reduced the whole thing to a
static ordering of runqueue-1 goes inside runqueue-0.

Similar combinatoric issues have cropped up in other places from time to
time, typically solved by using a different annotation.

Now, given the whole device thing is more or less a tree, hierarchical
locking should limit that, the only worry is that sibling locking while
holding parent thing. If siblings are of different classes, things will
both complain and create combinatorics again.


