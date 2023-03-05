Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1022A6AB164
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 17:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjCEQgk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 5 Mar 2023 11:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCEQgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 11:36:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016C313521
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 08:36:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1294060B06
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 16:36:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47268C433EF;
        Sun,  5 Mar 2023 16:36:34 +0000 (UTC)
Date:   Sun, 5 Mar 2023 11:36:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Wei Wang <wvw@google.com>,
        Midas Chien <midaschieh@google.com>,
        "Chunhui Li (=?UTF-8?B?5p2O5pil6L6J?=)" <chunhui.li@mediatek.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tony Luck <tony.luck@intel.com>, kernel-team@android.com
Subject: Re: [PATCH v2] pstore: Revert pmsg_lock back to a normal mutex
Message-ID: <20230305113632.26de0a4d@gandalf.local.home>
In-Reply-To: <20230304031029.3037914-1-jstultz@google.com>
References: <20230302062741.483079-1-jstultz@google.com>
        <20230304031029.3037914-1-jstultz@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  4 Mar 2023 03:10:29 +0000
John Stultz <jstultz@google.com> wrote:

> This reverts commit 76d62f24db07f22ccf9bc18ca793c27d4ebef721.
> 
> So while priority inversion on the pmsg_lock is an occasional
> problem that an rt_mutex would help with, in uses where logging
> is writing to pmsg heavily from multiple threads, the pmsg_lock
> can be heavily contended.
> 
> Normal mutexes can do adaptive spinning, which keeps the
> contention overhead fairly low maybe adding on the order of 10s
> of us delay waiting, but the slowpath w/ rt_mutexes makes the
> blocked tasks sleep & wake. This makes matters worse when there
> is heavy contentention, as it just allows additional threads to
> run and line up to try to take the lock.

That is incorrect. rt_mutexes have pretty much the same adaptive spinning
as normal mutexes. So that is *not* the reason for the difference in
performance, and should not be stated so in this change log.

The difference between rt_mutex and normal mutex, is that the rt_mutex will
trigger priority inheritance. Perhaps on high contention, that makes a
difference. But do not state it's because rt_mutex does not have adaptive
spinning, because it most definitely does.

-- Steve


> 
> It devolves to a worse case senerio where the lock acquisition
> and scheduling overhead dominates, and each thread is waiting on
> the order of ~ms to do ~us of work.
> 
> Obviously, having tons of threads all contending on a single
> lock for logging is non-optimal, so the proper fix is probably
> reworking pstore pmsg to have per-cpu buffers so we don't have
> contention.
> 
> But in the short term, lets revert the change to the rt_mutex
> and go back to normal mutexes to avoid a potentially major
> performance regression.
> 
> Cc: Wei Wang <wvw@google.com>
> Cc: Midas Chien<midaschieh@google.com>
> Cc: "Chunhui Li (李春辉)" <chunhui.li@mediatek.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Anton Vorontsov <anton@enomsg.org>
> Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: kernel-team@android.com
> Fixes: 76d62f24db07 ("pstore: Switch pmsg_lock to an rt_mutex to avoid priority inversion")
> Reported-by: "Chunhui Li (李春辉)" <chunhui.li@mediatek.com>
> Tested-by: Chunhui Li <chunhui.li@mediatek.com>
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
> I know Steven is working on a fix to address the rtmutex not
> spinning, but as the earlier version of it didn't resolve the
> issue for Chunhui Li, I wanted to resend this out again w/
> Tested-by tags, so it is ready to go if needed. I am looking
> to get a local reproducer so I can help validate Steven's
> efforts.
> 
> v2:
> * Fix quoting around Chunhui Li's email name (so they are actually
>   cc'ed)
> * Added tested by tag
> ---
>  fs/pstore/pmsg.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/pstore/pmsg.c b/fs/pstore/pmsg.c
> index ab82e5f05346..b31c9c72d90b 100644
> --- a/fs/pstore/pmsg.c
> +++ b/fs/pstore/pmsg.c
> @@ -7,10 +7,9 @@
>  #include <linux/device.h>
>  #include <linux/fs.h>
>  #include <linux/uaccess.h>
> -#include <linux/rtmutex.h>
>  #include "internal.h"
>  
> -static DEFINE_RT_MUTEX(pmsg_lock);
> +static DEFINE_MUTEX(pmsg_lock);
>  
>  static ssize_t write_pmsg(struct file *file, const char __user *buf,
>  			  size_t count, loff_t *ppos)
> @@ -29,9 +28,9 @@ static ssize_t write_pmsg(struct file *file, const char __user *buf,
>  	if (!access_ok(buf, count))
>  		return -EFAULT;
>  
> -	rt_mutex_lock(&pmsg_lock);
> +	mutex_lock(&pmsg_lock);
>  	ret = psinfo->write_user(&record, buf);
> -	rt_mutex_unlock(&pmsg_lock);
> +	mutex_unlock(&pmsg_lock);
>  	return ret ? ret : count;
>  }
>  

