Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560C868AB33
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 17:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbjBDQ15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 11:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjBDQ1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 11:27:55 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 56FD11EFDD
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 08:27:54 -0800 (PST)
Received: (qmail 599219 invoked by uid 1000); 4 Feb 2023 11:27:53 -0500
Date:   Sat, 4 Feb 2023 11:27:53 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: Converting dev->mutex into dev->spinlock ?
Message-ID: <Y96HiYcreb8jZIHi@rowland.harvard.edu>
References: <28a82f50-39d5-a45f-7c7a-57a66cec0741@I-love.SAKURA.ne.jp>
 <Y95h7Vop9t5Li0HD@kroah.com>
 <a236ab6b-d38c-3974-d4cb-5e92d0877abc@I-love.SAKURA.ne.jp>
 <Y957GSFVAQz8v3Xo@rowland.harvard.edu>
 <cf56ebc3-187a-6ee4-26bc-2d180272b5cf@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf56ebc3-187a-6ee4-26bc-2d180272b5cf@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2023 at 01:12:12AM +0900, Tetsuo Handa wrote:
> On 2023/02/05 0:34, Alan Stern wrote:
> >> A few of examples:
> >>
> >>   https://syzkaller.appspot.com/bug?extid=2d6ac90723742279e101
> > 
> > It's hard to figure out what's wrong from looking at the syzbot report.  
> > What makes you think it is connected with dev->mutex?
> > 
> > At first glance, it seems that the ath6kl driver is trying to flush a 
> > workqueue while holding a lock or mutex that is needed by one of the 
> > jobs in the workqueue.  That's obviously never going to work, no matter 
> > what sort of lockdep validation gets used.
> 
> That lock is exactly dev->mutex where lockdep validation is disabled.
> If lockdep validation on dev->mutex were not disabled, we can catch
> possibility of deadlock before khungtaskd reports real deadlock as hung.
> 
> Lockdep validation on dev->mutex being disabled is really annoying, and
> I want to make lockdep validation on dev->mutex enabled; that is the
> "drivers/core: Remove lockdep_set_novalidate_class() usage" patch.

> Even if it is always safe to acquire a child device's lock while holding
> the parent's lock, disabling lockdep checks completely on device's lock is
> not safe.

I understand the problem you want to solve, and I understand that it
can be frustrating.  However, I do not believe you will be able to
solve this problem.

Alan Stern
