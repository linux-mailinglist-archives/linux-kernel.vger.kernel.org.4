Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089D56937EC
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 16:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjBLPXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 10:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjBLPXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 10:23:46 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id A979072A5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 07:23:45 -0800 (PST)
Received: (qmail 880348 invoked by uid 1000); 12 Feb 2023 10:23:44 -0500
Date:   Sun, 12 Feb 2023 10:23:44 -0500
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
Message-ID: <Y+kEgDLSRwdODRdD@rowland.harvard.edu>
References: <Y+RZ2RKVo9FNMgSe@rowland.harvard.edu>
 <52c7d509-ba9e-a121-60c9-138d7ff3f667@I-love.SAKURA.ne.jp>
 <Y+gLd78vChQERZ6A@rowland.harvard.edu>
 <CAHk-=whXYzkOJZo0xpyYfrhWQg1M7j0OeCojTJ84CN4q9sqb2Q@mail.gmail.com>
 <109c3cc0-2c13-7452-4548-d0155c1aba10@gmail.com>
 <Y+gjuqJ5RFxwLmht@moria.home.lan>
 <Y+hRurRwm//1+IcK@rowland.harvard.edu>
 <Y+hTEtCKPuO0zGIt@moria.home.lan>
 <Y+hW74TAVzCpSv7c@rowland.harvard.edu>
 <Y+hYn6uzIUBaxDdV@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+hYn6uzIUBaxDdV@moria.home.lan>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 10:10:23PM -0500, Kent Overstreet wrote:
> So IMO the more correct way to do this would be to change
> device_initialize() to __device_initialize(), have it take a
> lock_class_key as a parameter, and then use __mutex_init() instead of
> mutex_init().

Yes, maybe.  The increase in code size might outweigh the space saved.

> But let's think about this more. Will there ever be situations where
> lock ordering is dependent on what hardware is plugged into what, or
> what hardware is plugged in first?

Device lock ordering is always dependent on what hardware is plugged 
into what.  However, I'm not aware of any situations where, given two 
different kinds of hardware, either one could be plugged into the other.
Such things may exist but I can't think of any examples.

On the other hand, there are obvious cases where two pieces of the 
_same_ kind of hardware can be plugged together in either order.  USB 
hubs are a good example.

Consider the possibility that a driver might want to lock all of a 
device's children at once.  (I don't know if this ever happens, but it 
might.)  Provided it acquires the parent device's lock first, this is 
utterly safe no matter what order the children are locked in.  Try 
telling that to lockdep!  In the end, we'd probably have to enforce a 
single fixed ordering.

Alan Stern
