Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0426B2291
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjCILTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjCILSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:18:21 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573885F6C1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 03:15:15 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 073E020083;
        Thu,  9 Mar 2023 11:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678360514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GXu/B/wubAD/UJpg6CCmzSIJ5/XY3lC6gFJ34HYf5o0=;
        b=eThplLKXDFi4Y0fWfjIniVCvorsLMVfxvGwegjT5vF9ALvtukOPWtO1vRAMmbF+m2bQKDj
        NRD49hlxQ6fyYOMArs0W0fyVf7wKXAE7FyAT48bS3XgevO+8BsWq+4ZxpO716qZ0ccR1MK
        foeovgpfL60jbrRx8Zg8xVOIbAqryNM=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E5DE92C15A;
        Thu,  9 Mar 2023 11:15:09 +0000 (UTC)
Date:   Thu, 9 Mar 2023 12:15:12 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-6.4] printk: Unregister boot consoles on register of
 1st real console
Message-ID: <ZAm/wMIYOOkjL/Mf@alley>
References: <13e4bdf7677924c689a70d0b7ad970a3255a8d41.1677213245.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13e4bdf7677924c689a70d0b7ad970a3255a8d41.1677213245.git.lukas@wunner.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-02-24 05:40:33, Lukas Wunner wrote:
> The code comment preceding register_console() claims that:
> 
>    "There are two types of consoles - bootconsoles (early_printk) and
>     "real" consoles (everything which is not a bootconsole) which are
>     handled differently. [...]
>     As soon as a "real" console is registered, all bootconsoles
>     will be unregistered automatically."
> 
> But that's not what the code does:  The code unregisters bootconsoles
> only when the *preferred* console registers, i.e. the last one on the
> command line.

Yes

> If that console's driver never registers (e.g. because
> it is disabled in the kernel config), bootconsoles stay around
> indefinitely.

They are actually unregistered by a late_initcall, see
printk_late_init().

> Should the command line contain both a bootconsole as
> well as a real console on the same serial port, all messages are logged
> twice once the real console registers.
> 
> Moreover, the log buffer is replayed once the real console registers
> even though the messages were already emitted by the bootconsole.

Yes, the messages might get duplicated until the printk_late_init()
is called. And the log might get replayed even though it was already
printed on the boot console.

> Amend the code to be congruent with the above-quoted code comment and
> thereby avoid these issues.

I am afraid that we could not change the behavior. It would cause
the opposite problem. It might might remove the boot consoles too early
and some messages might be missing on the corresponding console.
Also the log might get replayed on the "preferred" console.
People would see this as regression.

The only acceptable solution would be to do the right thing.
I mean to match the corresponding boot and real consoles.
Then we could remove the boot console exactly when it is replaced
by the real one. It would prevent any duplicated or lost messages.

In the meantime, we could only fix the comment so that it describes
the current behavior.

Best Regards,
Petr

Best Regards,
Petr
