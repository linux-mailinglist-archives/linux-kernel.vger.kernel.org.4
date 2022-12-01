Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318DF63EDE4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiLAKdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiLAKdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:33:21 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9403731DD6;
        Thu,  1 Dec 2022 02:32:52 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D57E321B1C;
        Thu,  1 Dec 2022 10:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669890769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y2yuajcyNF+KtJPwi+UUylTPzDzWLHsw1+1hqHwfGNw=;
        b=ckALftw8qzsnAkNw5MgvyuuU71o9wQpiLuaktpcS+hJt/efqDV1ds8P8Tttvd1NFm6/kiL
        XuDOtSg6uhg/rn9/9CxHXtsmTb4Er7kJyC1/3XQQMSmhkK3zXT/HRya14/g+4uv905YHRn
        eb3PDwSYIQHjWCUWJe5z67aunsI+Ngw=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 691432C141;
        Thu,  1 Dec 2022 10:32:49 +0000 (UTC)
Date:   Thu, 1 Dec 2022 11:32:46 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH v2 0/3] printk: introduce new macros pr_<level>_cont()
Message-ID: <Y4iCzsAeEgaBZ4o4@alley>
References: <20221125190948.2062-1-linux@weissschuh.net>
 <CAJZ5v0i8pm1vxQeQu4GJqvf=rinU9dO2gswsLseyEt3E2CgbtA@mail.gmail.com>
 <d31b4a2b-fc6b-4084-9cac-ced83a37a8ad@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d31b4a2b-fc6b-4084-9cac-ced83a37a8ad@t-8ch.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-12-01 00:37:15, Thomas Weiﬂschuh wrote:
> On 2022-11-30 18:57+0100, Rafael J. Wysocki wrote:
> > On Fri, Nov 25, 2022 at 8:10 PM Thomas Weiﬂschuh <linux@weissschuh.net> wrote:
> >>
> >> This series adds new printk wrapper macros pr_<level>_cont().
> >> These create continuation messages with an explicit level.
> >>
> >> Explicit levels are useful when a continuation message is split from its main
> >> message. Without the explicit level KERN_DEFAULT ("warn" by default) is used
> >> which can lead to stray partial log messages when filtering by level.
> >>
> >> Also checkpatch is modified to recommend the new macros over plain pr_cont().
> >>
> >> Lastly the new macros are used in kernel/power/process.c as this file uses
> >> continuation messages during system suspend-resume which creates a high
> >> likelyhood of interspersed messages.
> > 
> > Well, if process.c is the only problematic piece of code in this
> > respect, I'm not sure if adding the new infrastructure for its benefit
> > alone is worth it, because it can very well do without pr_cont() at
> > all.
> 
> In general all usages of pr_cont() are problematic.
> Any continuation can be split from its main message, leading to misleved
> continuations.

In most cases this happens "only" when a message from another CPU
or interrupt context is printed in parallel.

> process.c is just the one that I noticed reliably hitting this problem on my
> machine.

The situation in process.c was even worse. The error message was
printed in the middle of the to-be-continued message. As a result,
the loglevel of the pr_cont() part was always (reliably) broken
when the error message was printed.


> > Please see the patch below (compiled only, sorry for gmail-induced
> > white space damage).  I'll submit it properly later if it works for
> > everyone.
> 
> The patch looks fine to me and getting rid of usages of pr_cont() seems to be
> the better aproach where it is possible.

I agree. It is always better to avoid pr_cont() when possible.

> Petr: do you still want me to submit the new macros even if it is not used
> directly anymore?

Good question. In general, new API should not be added if there is
no user. So, I would prefer to do not add the API if the problem
will be fixed without it.

Best Regards,
Petr
