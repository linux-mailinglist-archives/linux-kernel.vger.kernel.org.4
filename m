Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB68694ECE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjBMSG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjBMSGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:06:53 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id E6DFBA5D1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:06:28 -0800 (PST)
Received: (qmail 916650 invoked by uid 1000); 13 Feb 2023 13:05:48 -0500
Date:   Mon, 13 Feb 2023 13:05:48 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Message-ID: <Y+p7/Ie5PqSMtIrc@rowland.harvard.edu>
References: <20230208080739.1649-1-hdanton@sina.com>
 <1ad499bb-0c53-7529-ff00-e4328823f6fa@I-love.SAKURA.ne.jp>
 <Y+O6toMmAKBSILMf@rowland.harvard.edu>
 <f79e93ef-cfe8-1373-7c36-15d046c0e3c5@I-love.SAKURA.ne.jp>
 <Y+RZ2RKVo9FNMgSe@rowland.harvard.edu>
 <52c7d509-ba9e-a121-60c9-138d7ff3f667@I-love.SAKURA.ne.jp>
 <Y+gLd78vChQERZ6A@rowland.harvard.edu>
 <Y+oHvi5f+tDMPR31@hirez.programming.kicks-ass.net>
 <Y+pi6pA0d22g7sCE@rowland.harvard.edu>
 <Y+p4vUqOE87WGwuD@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+p4vUqOE87WGwuD@kroah.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 06:51:57PM +0100, Greg Kroah-Hartman wrote:
> But back to the original issue here, why any of this?  What's wrong with
> what we have now?  I haven't seen real locking issues reported yet (only
> odd syzbot reports that didn't make any sense.)  Is this effort even
> worth it?

A large part of the reason those syzbot reports didn't make any sense 
was because they didn't include any lockdep information.  Making lockdep 
aware of device locking would make those reports a lot easier to 
understand and would help with fixing the bugs.  And it might even help 
with catching similar problems before they get merged into the kernel.

Will it be worthwhile in the end?  I have no idea.

Alan Stern
