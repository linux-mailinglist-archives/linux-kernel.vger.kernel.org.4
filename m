Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C5F63D762
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 14:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiK3N7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 08:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiK3N7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 08:59:18 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B58B29815;
        Wed, 30 Nov 2022 05:59:17 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 283651F8D4;
        Wed, 30 Nov 2022 13:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669816756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BmWydEyxVCtO1F3KxVGX1dvHBxkV4Dnqpc/owJqFkOE=;
        b=fzTGWCena/BFQ2Eq38B1LD+fqh7nkLAlqycR5BkW4pQjnxHB/In1wZAF2Dt4lioNX0URY2
        JqTNokmchp/RHmF8o1DQsGN4f84+GHA+Oa+LQL2nvAU2ABh+3b2n7zCTY0Z7mI/7rmyKQO
        QOniOTv1QYfiaAvRq/1kEIGZ2Ke0agk=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B8F0E2C152;
        Wed, 30 Nov 2022 13:59:15 +0000 (UTC)
Date:   Wed, 30 Nov 2022 14:59:15 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Joe Perches <joe@perches.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH v2 1/3] printk: introduce new macros pr_<level>_cont()
Message-ID: <Y4dhs1G3mcX/YraJ@alley>
References: <20221125190948.2062-1-linux@weissschuh.net>
 <20221125190948.2062-2-linux@weissschuh.net>
 <1fb146231e1810b4c9923f384afa166e07e7f253.camel@perches.com>
 <cf45b62e-6248-42f3-807f-5df0954437e0@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf45b62e-6248-42f3-807f-5df0954437e0@t-8ch.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-11-25 21:33:40, Thomas Weißschuh wrote:
> On 2022-11-25 12:18-0800, Joe Perches wrote:
> > On Fri, 2022-11-25 at 20:09 +0100, Thomas Weißschuh wrote:
> >> These macros emit continuation messages with explicit levels.
> >> In case the continuation is logged separately from the original message
> >> it will retain its level instead of falling back to KERN_DEFAULT.
> >> 
> >> This remedies the issue that logs filtered by level contain stray
> >> continuation messages without context.
> >> 
> >> --- a/include/linux/printk.h
> >> +++ b/include/linux/printk.h
> >> @@ -701,6 +703,27 @@ do {									\
> >>  	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
> >>  #endif
> >>  
> >> +/*
> >> + * Print a continuation message with level. In case the continuation is split
> >> + * from the main message it preserves the level.
> >> + */
> >> +
> >> +#define pr_emerg_cont(fmt, ...)					\
> >> +	printk(KERN_EMERG KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
> > 
> > Aren't this rather backwards?
> > KERN_CONT KERN_<LEVEL> seems to make more sense to me.
> 
> If nobody else disagrees I'll do this for v3.

I slightly prefer the way how it is now. IMHO, it makes it easier
to check the related levels in /sys/kernel/debug/printk/index/vmlinux [*]:

<6> kernel/power/process.c:227 thaw_kernel_threads "Restarting kernel threads ... "
<6,c> kernel/power/process.c:218 thaw_processes "done.\n"
<6> kernel/power/process.c:197 thaw_processes "Restarting tasks ... "
<6,c> kernel/power/process.c:176 freeze_kernel_threads "\n"
<6,c> kernel/power/process.c:174 freeze_kernel_threads "done."
<6> kernel/power/process.c:169 freeze_kernel_threads "Freezing remaining freezable tasks ... "
<6,c> kernel/power/process.c:140 freeze_processes "\n"
<6,c> kernel/power/process.c:138 freeze_processes "done."
<6> kernel/power/process.c:133 freeze_processes "Freezing user space processes ... "
<6,c> kernel/power/process.c:105 try_to_freeze_tasks "(elapsed %d.%03d seconds) "

That said, I do not want to fight over it. It is hidden behind the
API. The only really visible place is the printk index.

[*] The index is available only when CONFIG_PRINTK_INDEX is enabled.

Best Regards,
Petr
