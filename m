Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F33F63906A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 20:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiKYTyA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Nov 2022 14:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKYTx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 14:53:59 -0500
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0398B45A03
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 11:53:57 -0800 (PST)
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id 060BDC0A50;
        Fri, 25 Nov 2022 19:53:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id DE61F60013;
        Fri, 25 Nov 2022 19:53:52 +0000 (UTC)
Message-ID: <f4631f7bf0e1fe7b018ea24cb89aede7829581d2.camel@perches.com>
Subject: Re: [PATCH v2 3/3] power: process: use explicit levels for printk
 continuations
From:   Joe Perches <joe@perches.com>
To:     Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 25 Nov 2022 11:53:49 -0800
In-Reply-To: <20221125190948.2062-4-linux@weissschuh.net>
References: <20221125190948.2062-1-linux@weissschuh.net>
         <20221125190948.2062-4-linux@weissschuh.net>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Stat-Signature: f8ui8jy95g9mn1bsc6oyscfzb5tx637o
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: DE61F60013
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18HCohEpzJ2JMwVne5Qiy/X+ULGtNKt0DI=
X-HE-Tag: 1669406032-894572
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-11-25 at 20:09 +0100, Thomas Weiﬂschuh wrote:
> Many of the printk messages emitted during suspend and resume are
> emitted in fragments using pr_cont()/KERN_CONT.
> 
> As during suspend and resume a lot of operations are happing in the
> kernel the chances are high that the fragments are interspersed with
> unrelated messages.
> 
> In this case if no explicit level is specified for the fragments the
> standard level is applied, which by default is KERN_WARNING.
> 
> If the user is only observing KERN_WARNING and *not* KERN_INFO messages
> they will see incomplete message fragments.
> 
> By specifing the correct printk level also with the continuations this
> mismatch can be avoided.
> Also it reduces the amount of false-positive KERN_WARNING messages.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  kernel/power/process.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/power/process.c b/kernel/power/process.c
[]
> @@ -82,7 +82,7 @@ static int try_to_freeze_tasks(bool user_only)
>  	elapsed_msecs = ktime_to_ms(elapsed);
>  
>  	if (todo) {
> -		pr_cont("\n");
> +		pr_info_cont("\n");

I think this isn't needed because of the immediately following pr_err.

>  		pr_err("Freezing of tasks %s after %d.%03d seconds "
>  		       "(%d tasks refusing to freeze, wq_busy=%d):\n",
>  		       wakeup ? "aborted" : "failed",

