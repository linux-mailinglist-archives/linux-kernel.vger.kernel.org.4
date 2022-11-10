Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184756242A8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiKJM6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiKJM6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:58:10 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E611B71F35
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 04:58:09 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 937261FAD3;
        Thu, 10 Nov 2022 12:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668085088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cvkRMglln4HBHPX98O0sRdjNj682jRwZGliLDUK9dqQ=;
        b=EtnfcATI9xCVDi+aTJrCuXHOgJCSLKRmd0qPgMS4MgpEzAN7e6LTugvbpISeS3oRQuClQb
        xiqKmZyIfBfvzv0J0l4TAjvbSiWI4kP8mFFPxHkWxLcLvFMidfc2Hr6xASAKtIySMkxiQl
        ySwSfL1f5XfHOR0C0O2shcOOaJwbFpU=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3CEA62C141;
        Thu, 10 Nov 2022 12:58:08 +0000 (UTC)
Date:   Thu, 10 Nov 2022 13:58:07 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v3 21/40] printk: introduce console_list_lock
Message-ID: <Y2z1X0V9Xir9oTO0@alley>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-22-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107141638.3790965-22-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-11-07 15:22:19, John Ogness wrote:
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

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
