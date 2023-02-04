Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8108468AAF9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 16:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjBDPlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 10:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjBDPlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 10:41:08 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 74A942CC5A
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 07:40:53 -0800 (PST)
Received: (qmail 598048 invoked by uid 1000); 4 Feb 2023 10:40:52 -0500
Date:   Sat, 4 Feb 2023 10:40:52 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: Converting dev->mutex into dev->spinlock ?
Message-ID: <Y958hOvtqq7Uiu0G@rowland.harvard.edu>
References: <28a82f50-39d5-a45f-7c7a-57a66cec0741@I-love.SAKURA.ne.jp>
 <Y951z0Au9MlP1GxX@rowland.harvard.edu>
 <e89ad942-cab6-fad1-1cc2-98885d829ea7@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e89ad942-cab6-fad1-1cc2-98885d829ea7@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2023 at 12:30:07AM +0900, Tetsuo Handa wrote:
> On 2023/02/05 0:12, Alan Stern wrote:
> >>  it would solve many deadlocks in driver code if you can update
> > 
> > What deadlocks?  If there are so many deadlocks floating around in 
> > driver code, why haven't we heard about them before now?
> 
> Since dev->mutex is hidden from lockdep checks, nobody can see lockdep warnings.
> syzbot is reporting real deadlocks without lockdep warnings, for the fundamental
> problem you mentioned in https://lkml.kernel.org/r/Pine.LNX.4.44L0.0804171117450.18040-100000@iolanthe.rowland.org
> is remaining. I'm suggesting you that now is time to address this fundamental problem.

Maybe so.  But the place to address it is inside lockdep, not in the 
driver core.

> >> (by e.g. replacing dev->mutex with dev->spinlock and dev->atomic_flags).
> >> But I'm not familiar enough to propose such change...
> > 
> > Such a change cannot be made.  Consider this: Driver callbacks often
> > need to sleep.  But when a thread holds a spinlock, it is not allowed to 
> > sleep.  Therefore driver callbacks must not be invoked while a spinlock 
> > is held.
> 
> What I'm suggesting is "Do not call driver callbacks with dev->mutex held,
> by rewriting driver core code".

That cannot be done.  The only possible solution is to teach lockdep how 
to handle recursive locking structures.

Alan Stern
