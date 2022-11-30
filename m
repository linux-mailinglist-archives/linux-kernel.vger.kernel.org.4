Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B06B63E597
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 00:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiK3Xhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 18:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiK3Xhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:37:40 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E5330558;
        Wed, 30 Nov 2022 15:37:21 -0800 (PST)
Date:   Thu, 1 Dec 2022 00:37:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1669851439;
        bh=gCjQ7v9MiSprJKAXVgQSc3QwycT+eoWtbLZH/ib/kuY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=psBRQAE+7XvBm97cEAeXI4A+z18YICLeLxtzacCWac3q9okGnsfzcr389b4NC3XCJ
         GFuc1YVLbI2PmPqxc/KUMvPo/u2PenmGyXfag3PQJa3fM6zbjXCqTbaRAiaEPObgn7
         PlefG2fEPty/Cj6Y24KmsJrtaPqUYLKoNRNJAI/I=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH v2 0/3] printk: introduce new macros pr_<level>_cont()
Message-ID: <d31b4a2b-fc6b-4084-9cac-ced83a37a8ad@t-8ch.de>
References: <20221125190948.2062-1-linux@weissschuh.net>
 <CAJZ5v0i8pm1vxQeQu4GJqvf=rinU9dO2gswsLseyEt3E2CgbtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0i8pm1vxQeQu4GJqvf=rinU9dO2gswsLseyEt3E2CgbtA@mail.gmail.com>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-30 18:57+0100, Rafael J. Wysocki wrote:
> On Fri, Nov 25, 2022 at 8:10 PM Thomas Weißschuh <linux@weissschuh.net> wrote:
>>
>> This series adds new printk wrapper macros pr_<level>_cont().
>> These create continuation messages with an explicit level.
>>
>> Explicit levels are useful when a continuation message is split from its main
>> message. Without the explicit level KERN_DEFAULT ("warn" by default) is used
>> which can lead to stray partial log messages when filtering by level.
>>
>> Also checkpatch is modified to recommend the new macros over plain pr_cont().
>>
>> Lastly the new macros are used in kernel/power/process.c as this file uses
>> continuation messages during system suspend-resume which creates a high
>> likelyhood of interspersed messages.
> 
> Well, if process.c is the only problematic piece of code in this
> respect, I'm not sure if adding the new infrastructure for its benefit
> alone is worth it, because it can very well do without pr_cont() at
> all.

In general all usages of pr_cont() are problematic.
Any continuation can be split from its main message, leading to misleved
continuations.
process.c is just the one that I noticed reliably hitting this problem on my
machine.

> Please see the patch below (compiled only, sorry for gmail-induced
> white space damage).  I'll submit it properly later if it works for
> everyone.

The patch looks fine to me and getting rid of usages of pr_cont() seems to be
the better aproach where it is possible.

Petr: do you still want me to submit the new macros even if it is not used
directly anymore?

> ---
>  kernel/power/process.c |   25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
> 
> Index: linux-pm/kernel/power/process.c
> ===================================================================
> --- linux-pm.orig/kernel/power/process.c
> +++ linux-pm/kernel/power/process.c
> @@ -27,6 +27,8 @@ unsigned int __read_mostly freeze_timeou
> 
>  static int try_to_freeze_tasks(bool user_only)
>  {
> +    const char *what = user_only ? "user space processes" :
> +                    "remaining freezable tasks";
>      struct task_struct *g, *p;
>      unsigned long end_time;
>      unsigned int todo;
> @@ -36,6 +38,8 @@ static int try_to_freeze_tasks(bool user
>      bool wakeup = false;
>      int sleep_usecs = USEC_PER_MSEC;
> 
> +    pr_info("Freezing %s\n", what);
> +
>      start = ktime_get_boottime();
> 
>      end_time = jiffies + msecs_to_jiffies(freeze_timeout_msecs);
> @@ -82,9 +86,8 @@ static int try_to_freeze_tasks(bool user
>      elapsed_msecs = ktime_to_ms(elapsed);
> 
>      if (todo) {
> -        pr_cont("\n");
> -        pr_err("Freezing of tasks %s after %d.%03d seconds "
> -               "(%d tasks refusing to freeze, wq_busy=%d):\n",
> +        pr_err("Freezing %s %s after %d.%03d seconds "
> +               "(%d tasks refusing to freeze, wq_busy=%d):\n", what,
>                 wakeup ? "aborted" : "failed",
>                 elapsed_msecs / 1000, elapsed_msecs % 1000,
>                 todo - wq_busy, wq_busy);
> @@ -101,8 +104,8 @@ static int try_to_freeze_tasks(bool user
>              read_unlock(&tasklist_lock);
>          }
>      } else {
> -        pr_cont("(elapsed %d.%03d seconds) ", elapsed_msecs / 1000,
> -            elapsed_msecs % 1000);
> +        pr_info("Freezing %s completed (elapsed %d.%03d seconds)\n",
> +            what, elapsed_msecs / 1000, elapsed_msecs % 1000);
>      }
> 
>      return todo ? -EBUSY : 0;
> @@ -130,14 +133,11 @@ int freeze_processes(void)
>          static_branch_inc(&freezer_active);
> 
>      pm_wakeup_clear(0);
> -    pr_info("Freezing user space processes ... ");
>      pm_freezing = true;
>      error = try_to_freeze_tasks(true);
> -    if (!error) {
> +    if (!error)
>          __usermodehelper_set_disable_depth(UMH_DISABLED);
> -        pr_cont("done.");
> -    }
> -    pr_cont("\n");
> +
>      BUG_ON(in_atomic());
> 
>      /*
> @@ -166,14 +166,9 @@ int freeze_kernel_threads(void)
>  {
>      int error;
> 
> -    pr_info("Freezing remaining freezable tasks ... ");
> -
>      pm_nosig_freezing = true;
>      error = try_to_freeze_tasks(false);
> -    if (!error)
> -        pr_cont("done.");
> 
> -    pr_cont("\n");
>      BUG_ON(in_atomic());
> 
>      if (error)
