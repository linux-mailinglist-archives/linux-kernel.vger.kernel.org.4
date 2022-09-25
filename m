Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63325E947D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 18:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbiIYQwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 12:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbiIYQw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 12:52:29 -0400
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DF8F2CE36
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 09:52:25 -0700 (PDT)
Received: by cae.in-ulm.de (Postfix, from userid 1000)
        id 072E81402B4; Sun, 25 Sep 2022 18:52:23 +0200 (CEST)
Date:   Sun, 25 Sep 2022 18:52:22 +0200
From:   "Christian A. Ehrhardt" <lk@c--e.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        syzbot <syzbot+8bee3285b9e190f1509e@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH] kernfs: fix UAF race condition in __kernfs_remove()
Message-ID: <YzCHRhNmB/mOo6hS@cae.in-ulm.de>
References: <000000000000646c9605e714ec6e@google.com>
 <7f489b14-2fdc-3d91-c87e-6a802bd8592d@I-love.SAKURA.ne.jp>
 <YzBT+hJ/fmp75j1P@kroah.com>
 <83be5776-4038-90d5-f202-9a6e97b6d551@I-love.SAKURA.ne.jp>
 <YzBaYHqldB39zD17@kroah.com>
 <e37e3b18-401e-f319-9006-2e2a09111c74@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e37e3b18-401e-f319-9006-2e2a09111c74@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Sun, Sep 25, 2022 at 10:52:56PM +0900, Tetsuo Handa wrote:
> On 2022/09/25 22:40, Greg Kroah-Hartman wrote:
> > On Sun, Sep 25, 2022 at 10:20:27PM +0900, Tetsuo Handa wrote:
> >> On 2022/09/25 22:13, Greg Kroah-Hartman wrote:
> >>> Isn't this already handled by:
> >>> 	https://lore.kernel.org/r/20220913121723.691454-1-lk@c--e.de
> >>>
> >>> that will show up in the next linux-next tree.
> >>
> >> Oh, I didn't know that patch.
> >>
> >> But is that patch complete, for there are three __kernfs_remove() callers?
> >>
> > 
> > syzbot seems to think it works :)
> 
> syzbot's reproducer tested only kernfs_remove_by_name_ns() case.
> I'm not sure whether e.g. __kernfs_remove() from kernfs_remove() is safe.

I had an older version of the patch that was rejected by Tejun Heo
on the grounds that external kernfs_remove callers must hold a reference
on their own or the race can happen even befor kernfs_remoe takes the
lock.

See  https://lore.kernel.org/all/20220907200811.654034-1-lk@c--e.de/
for the details. I did convince myself that other callers of
kernfs_remove() have other means to ensure that there are no parallel
removes for the same node.

IMHO the kernfs interface's use of ref-counts is slightly unintuitive
but I think it is safe, now.

     regards   Christian

