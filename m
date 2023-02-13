Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FAB694E6F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 18:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjBMRwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 12:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjBMRwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 12:52:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C126B1204C;
        Mon, 13 Feb 2023 09:52:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E31D61206;
        Mon, 13 Feb 2023 17:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C7FC433D2;
        Mon, 13 Feb 2023 17:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676310720;
        bh=/X8t7IxQWvz/WM9ChlU9fkrA6SZdHMydEhoidJ2sUsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zHSxg3AY4koyQb8XgZOt1/alqFoYn8lgHImJuQMCVREVkC0G0auEnn2rcuVukuwq4
         u08jKy2cEau8PtHtEVa594MZxam7XPpT7RZqpjiAZEWMabibVLYKFO50vtFNTJbxSM
         Q8BDBo4xiZ0MRR5TShqGXMWK08fUwvoTr44H3+fU=
Date:   Mon, 13 Feb 2023 18:51:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller <syzkaller@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH RFC] drivers/core: Replace lockdep_set_novalidate_class()
 with unique class keys
Message-ID: <Y+p4vUqOE87WGwuD@kroah.com>
References: <a67e24eb-b68f-2abc-50af-ae4c2d4cdd95@I-love.SAKURA.ne.jp>
 <20230208080739.1649-1-hdanton@sina.com>
 <1ad499bb-0c53-7529-ff00-e4328823f6fa@I-love.SAKURA.ne.jp>
 <Y+O6toMmAKBSILMf@rowland.harvard.edu>
 <f79e93ef-cfe8-1373-7c36-15d046c0e3c5@I-love.SAKURA.ne.jp>
 <Y+RZ2RKVo9FNMgSe@rowland.harvard.edu>
 <52c7d509-ba9e-a121-60c9-138d7ff3f667@I-love.SAKURA.ne.jp>
 <Y+gLd78vChQERZ6A@rowland.harvard.edu>
 <Y+oHvi5f+tDMPR31@hirez.programming.kicks-ass.net>
 <Y+pi6pA0d22g7sCE@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+pi6pA0d22g7sCE@rowland.harvard.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 11:18:50AM -0500, Alan Stern wrote:
> On Mon, Feb 13, 2023 at 10:49:50AM +0100, Peter Zijlstra wrote:
> > My main worry when adding a ton of classes like this is the
> > combinatorics (dynamic classes make this more trivial, but it's entirely
> > possible with just static classes too).
> > 
> > As an example, we used to have a static class per cpu runqueue, now,
> > given migration takes two runqueue locks (per locking rules in cpu
> > order -- source and dest runqueue etc..) we got O(n^2) combinations of
> > class orderings, which lead to a giant graph, which led to both
> > performance and memory usage issues.
> 
> Having a new class for each device would add a lot of classes.  Just how 
> badly this would affect lockdep's performance is hard to predict.  
> Testing seems like the best way to find out.

We support systems with 50000+ devices today, so one class per device
might be messy.

But back to the original issue here, why any of this?  What's wrong with
what we have now?  I haven't seen real locking issues reported yet (only
odd syzbot reports that didn't make any sense.)  Is this effort even
worth it?

thanks,

greg k-h
