Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604B360C6AC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 10:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiJYIkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 04:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiJYIkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 04:40:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B1333E02
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 01:40:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 195331F74A;
        Tue, 25 Oct 2022 08:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666687238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0fvfKX4zW0ea1QU1UhyN499kdzLJCK0LcIjY28CE2+g=;
        b=JogF0gqmtvMcCJ1EfisBNF/pR4anb/hP0BCY68OvOPdlf8p8muBqD/OvwarfT/JsqGvtVc
        YUXs93uLYDlX0wiKzoS84UVbbwtZT2qjCNC7U+K1ExP0iWtaXQT8OP3VNEHwqiZ5OB/TGo
        rN4QOsGK6oziPJvJVwAURB6xI1l+9n8=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 86A9F2C141;
        Tue, 25 Oct 2022 08:40:37 +0000 (UTC)
Date:   Tue, 25 Oct 2022 10:40:37 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jane Chu <jane.chu@oracle.com>, rostedt@goodmis.org,
        senozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        wangkefeng.wang@huawei.com, haakon.bugge@oracle.com,
        john.haxby@oracle.com
Subject: Re: [PATCH v3 1/1] vsprintf: protect kernel from panic due to
 non-canonical pointer dereference
Message-ID: <Y1ehBZOuF3AXeesh@alley>
References: <20221019194159.2923873-1-jane.chu@oracle.com>
 <Y1BfK6LpDJDlUYKp@smile.fi.intel.com>
 <Y1Fgk1iDnhL7VtAl@char.us.oracle.com>
 <Y1FxS30zVENd/1Ap@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1FxS30zVENd/1Ap@smile.fi.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-10-20 19:03:23, Andy Shevchenko wrote:
> On Thu, Oct 20, 2022 at 10:52:03AM -0400, Konrad Rzeszutek Wilk wrote:
> > On Wed, Oct 19, 2022 at 11:33:47PM +0300, Andy Shevchenko wrote:
> > > On Wed, Oct 19, 2022 at 01:41:59PM -0600, Jane Chu wrote:
> > > > Having stepped on a local kernel bug where reading sysfs has led to
> > > > out-of-bound pointer dereference by vsprintf() which led to GPF panic.
> > > > And the reason for GPF is that the OOB pointer was turned to a
> > > > non-canonical address such as 0x7665645f63616465.
> > > > 
> > > > vsprintf() already has this line of defense
> > > > 	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
> > > >                 return "(efault)";
> > > > Since a non-canonical pointer can be detected by kern_addr_valid()
> > > > on architectures that present VM holes as well as meaningful
> > > > implementation of kern_addr_valid() that detects the non-canonical
> > > > addresses, this patch adds a check on non-canonical string pointer by
> > > > kern_addr_valid() and "(efault)" to alert user that something
> > > > is wrong instead of unecessarily panic the server.
> > > > 
> > > > On the other hand, if the non-canonical string pointer is dereferenced
> > > > else where in the kernel, by virtue of being non-canonical, a crash
> > > > is expected to be immediate.
> > > 
> > > What if there is no other dereference except the one happened in printf()?
> > > 
> > > Just to point out here, that I formally NAKed this on the basis that NULL
> > > and error pointers are special, for the bogus pointers we need crash ASAP,
> > > no matter what the code issues it. I.o.w. printf() is not special for that
> > > kind of pointers (i.e. bogus pointers, but not special).
> > 
> > Hey Andy,
> > 
> > Do we want to have user space programs crash the kernel?
> > 
> > This patch leads to making the kernel more harden so that we do
> > not crash when there are bugs but continue on.
> 
> Fine, how to push a user to report a bug in the kernel if for them
> there is no bug?
> 
> OK, let's assume user recognizes this as a bug, what should they do in order
> to provide a better description of the bug, so developer can easily debug
> and fix it?

WARN() would provide similar information as panic() without actually
crashing the kernel.

> > Would we not want that experience for users ?
> 
> Yes, if it is a bug in the kernel we want to know it with all possible details.
> Hiding bugs is a way to nowhere.

I agree but we should always distinguish between fatal problems where
the system could hardly continue working and unexpected behavior that
is not critical.

Many error code paths handle unexpected situations. Some problems are
caused by users and some by bugs in the code. The kernel could always
refuse doing some operation rather than crash. People will report
it because it does not work. And there are non-destructive ways how
to show useful debugging information.

Best Regards,
Petr
