Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E0C68FD16
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 03:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjBIC0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 21:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjBIC0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 21:26:35 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 60A8123C7A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 18:26:34 -0800 (PST)
Received: (qmail 755478 invoked by uid 1000); 8 Feb 2023 21:26:33 -0500
Date:   Wed, 8 Feb 2023 21:26:33 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH] drivers/core: Replace lockdep_set_novalidate_class()
 with unique class keys
Message-ID: <Y+RZ2RKVo9FNMgSe@rowland.harvard.edu>
References: <Y98FLlr7jkiFlV0k@rowland.harvard.edu>
 <827177aa-bb64-87a9-e1af-dfe070744045@I-love.SAKURA.ne.jp>
 <Y+Egr4MmqlE6G+mr@rowland.harvard.edu>
 <a7d0e143-1e68-5531-5c2e-1f853d794bc0@I-love.SAKURA.ne.jp>
 <Y+KOeJlvQMYAaheZ@rowland.harvard.edu>
 <a67e24eb-b68f-2abc-50af-ae4c2d4cdd95@I-love.SAKURA.ne.jp>
 <20230208080739.1649-1-hdanton@sina.com>
 <1ad499bb-0c53-7529-ff00-e4328823f6fa@I-love.SAKURA.ne.jp>
 <Y+O6toMmAKBSILMf@rowland.harvard.edu>
 <f79e93ef-cfe8-1373-7c36-15d046c0e3c5@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f79e93ef-cfe8-1373-7c36-15d046c0e3c5@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 09:22:39AM +0900, Tetsuo Handa wrote:
> On 2023/02/09 0:07, Alan Stern wrote:
> > I'm happy to have people test this patch, but I do not want anybody 
> > think that it is ready to be merged into the kernel.
> 
> People (and build/test bots) won't test changes that are not proposed as
> a formal patch with Signed-off-by: tag. As far as I am aware, bot is not
> testing plain diff.

People _do_ test changes without a Signed-off-by: tag.  This happens 
with my patches all the time; I don't put Signed-off-by: on a patch 
until I think it is ready to be merged.  If you search through the email 
archives, you'll find examples where people deliberately put a 
"Not-yet-signed-off-by:" tag on a suggested patch.

Syzbot also tests patches without a Signed-off-by: tag.  Here's a recent 
example:

https://lore.kernel.org/linux-usb/Y9wh8dGK6oHSjJQl@rowland.harvard.edu/

> > What's the point of adding a new function that just calls the old 
> > function?  Why not simply rename the old function?
> 
> This makes the patch smaller and easier to apply the change. Of course,

How does it make the patch easier to apply?  With either the original 
version or yours, you apply the patch by doing

	patch -p1 <patchfile

(or a similar git command).  Same command, same amount of difficulty for 
both patches.

> I can update the patch if lockdep developers prefer rename over add.
> What I worry is that lockdep developers do not permit static_obj() being
> used by non-lockdep code.

I worry about that too, and I hoped that Peter Z. would comment on it. 
But if they don't want the function to be exported, they ought to be 
able to suggest an alternative.

Alan Stern
