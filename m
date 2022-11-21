Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6555B6323D5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiKUNg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiKUNgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:36:20 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C6CC2843
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:36:16 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 40524220C2;
        Mon, 21 Nov 2022 13:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669037775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dOP7gLTrtKFMqQ0Yy0qoL3B++G+/cztXu069nQpDp24=;
        b=Ij6zliOBjjUnbU16Xnxg6jUBLKF9cqsbynCwsSahhJGYS0PwiVTp3Cz33sFeWGk9GywJbD
        PbzeXoFWDRczYIT27bSoYXMon0+s29JGg49uZi37CAy65rN2WTBtA7YhCzR3d51JWnSuv3
        3sBfM2jxxrxcCiM+EbF1L3E0tGaMDL8=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E133D2C14B;
        Mon, 21 Nov 2022 13:36:14 +0000 (UTC)
Date:   Mon, 21 Nov 2022 14:36:14 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v6 11/40] printk: introduce console_list_lock
Message-ID: <Y3t+ztLCYj7uibD0@alley>
References: <20221116162152.193147-1-john.ogness@linutronix.de>
 <20221116162152.193147-12-john.ogness@linutronix.de>
 <87sficwokr.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sficwokr.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-11-21 12:16:12, John Ogness wrote:
> Currently there exist races in register_console(), where the types
> of registered consoles are checked (without holding the console_lock)
> and then after acquiring the console_lock, it is assumed that the list
> has not changed. Also, some code that performs console_unregister()
> make similar assumptions.
> 
> It might be possible to fix these races using the console_lock. But
> it would require a complex analysis of all console drivers to make
> sure that the console_lock is not taken in match() and setup()
> callbacks. And we really prefer to split up and reduce the
> responsibilities of console_lock rather than expand its complexity.
> Therefore, introduce a new console_list_lock to provide full
> synchronization for any console list changes.
> 
> In addition, also use console_list_lock for synchronization of
> console->flags updates. All flags are either static or modified only
> during the console registration. There are only two exceptions.
> 
> The first exception is CON_ENABLED, which is also modified by
> console_start()/console_stop(). Therefore, these functions must
> also take the console_list_lock.
> 
> The second exception is when the flags are modified by the console
> driver init code before the console is registered. These will be
> ignored because they are not visible to the rest of the system
> via the console_drivers list.
> 
> Note that one of the various responsibilities of the console_lock is
> also intended to provide console list and console->flags
> synchronization. Later changes will update call sites relying on the
> console_lock for these purposes. Once all call sites have been
> updated, the console_lock will be relieved of synchronizing
> console_list and console->flags updates.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> ---
>  Stephen reported [0] a build failure with linux-next. The problem was a
>  missing EXPORT of @lockdep_assert_console_list_lock_held for when
>  drivers are built as modules.
>  
>  [0] https://lore.kernel.org/lkml/20221121110041.1d2c635b@canb.auug.org.au

JFYI, the branch rework/console-list-lock in printk/linux.git has been
rebased using this version of the patch.

Thanks a lot for the fix.

Best Regards,
Petr
