Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0ABB694FA3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjBMSq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjBMSq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:46:27 -0500
X-Greylist: delayed 156087 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Feb 2023 10:46:18 PST
Received: from out-80.mta1.migadu.com (out-80.mta1.migadu.com [IPv6:2001:41d0:203:375::50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E881E1D0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:46:18 -0800 (PST)
Date:   Mon, 13 Feb 2023 13:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676313975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YioAr6XjueHplzus2lFvpvi8p2nekmVJOeyTQCK8hnU=;
        b=is/Pm32wjeb+az5eM7cNbDFrk7BI9ydUnFRxt1jFUczcDf30rVGI+Q9fKcZ0RRo6c4z6Cr
        lfqWphTk2GQmMTePbSQYvjrU0foEeVux1clHEa3pgBndccmPHDWoC7ReRstSF8AVU98ar3
        Be4PBOUSrlxp9AQk1/IDHqHarvZzLuw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Coly Li <colyli@suse.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller <syzkaller@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH RFC] drivers/core: Replace lockdep_set_novalidate_class()
 with unique class keys
Message-ID: <Y+qFc7Q2NfXERwYT@moria.home.lan>
References: <Y+gLd78vChQERZ6A@rowland.harvard.edu>
 <CAHk-=whXYzkOJZo0xpyYfrhWQg1M7j0OeCojTJ84CN4q9sqb2Q@mail.gmail.com>
 <109c3cc0-2c13-7452-4548-d0155c1aba10@gmail.com>
 <Y+gjuqJ5RFxwLmht@moria.home.lan>
 <Y+hRurRwm//1+IcK@rowland.harvard.edu>
 <Y+hTEtCKPuO0zGIt@moria.home.lan>
 <Y+hW74TAVzCpSv7c@rowland.harvard.edu>
 <Y+hYn6uzIUBaxDdV@moria.home.lan>
 <Y+kEgDLSRwdODRdD@rowland.harvard.edu>
 <Y+oBveWO2z6xdTW/@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+oBveWO2z6xdTW/@hirez.programming.kicks-ass.net>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 10:24:13AM +0100, Peter Zijlstra wrote:
> On Sun, Feb 12, 2023 at 10:23:44AM -0500, Alan Stern wrote:
> > Provided it acquires the parent device's lock first, this is 
> > utterly safe no matter what order the children are locked in.  Try 
> > telling that to lockdep! 
> 
> mutex_lock_next_lock(child->lock, parent->lock) is there to express this
> exact pattern, it allows taking multiple child->lock class locks (in any
> order) provided parent->lock is held.

Perhaps I'm stupid, but I've never understood how subclasses - or this -
are supposed to work.

Locks don't get a fixed subclass, so what's to prevent some code from
going

/* thread 1: */
mutex_lock(&a->lock);
mutex_lock_nested(&b->lock, 1);

/* thread 2: */
mutex_lock(&b->lock);
mutex_lock_nested(&a->lock, 1);

I don't see how they can be used to check that we're obeying a lock
ordering?
