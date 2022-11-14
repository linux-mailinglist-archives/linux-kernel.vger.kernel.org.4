Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDF9628190
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236931AbiKNNpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236936AbiKNNp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:45:28 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EBE24093;
        Mon, 14 Nov 2022 05:45:23 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5B59120008;
        Mon, 14 Nov 2022 13:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668433522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nBxrJD3dpbkrLcoAw5xCCnCqviVBPHnrjEWuuoLd3BU=;
        b=hw9KJ9KNhTmqXCktmrZuCnSkd2kMHj5VtXLZ5Y4racFgEEFNIob97XyiMOZX/H8RZmawJW
        wX8Ea+JW1xIrKQqYXTuTfOKYU7mRzZodLO3rxoP+9JK/MkBXLBHsQOT+q4lmcQ6JKghRqi
        4IPovdZdbnV9qPbd0guWhXYxM2rWvB4=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2EF272C142;
        Mon, 14 Nov 2022 13:45:21 +0000 (UTC)
Date:   Mon, 14 Nov 2022 14:45:21 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Do not delay boot when printing log to serial console during
 startup?
Message-ID: <Y3JGcQyuW+ydwkYE@alley>
References: <c87cc376-3b0d-8fda-7fc1-555c930faaf1@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c87cc376-3b0d-8fda-7fc1-555c930faaf1@molgen.mpg.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding John into Cc. He is working on introducing printk kthreads that
might allow to handle consoles asynchronously.

On Tue 2022-10-11 11:03:39, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> We boot our systems generally with the serial console enabled
> `console=ttyS0,115200n8`, and noticed that initializing the console takes at
> least one second.
> 
>     $ dmesg | grep -e 'DMI:' -e 'printk: console'
>     [    0.000000] DMI: Dell Inc. PowerEdge R7525/05Y13N, BIOS 2.7.3
> 03/30/2022
>     [    2.691432] printk: console [tty0] enabled
>     [    5.414384] printk: console [ttyS0] enabled
> 
>     $ dmesg | grep -e 'DMI:' -e 'printk:'
>     [    0.000000] DMI: Dell Inc. Precision Tower 3620/0MWYPT, BIOS 2.22.0
> 07/13/2022
>     [    0.146953] printk: console [tty0] enabled
>     [    1.374382] printk: console [ttyS0] enabled
> 
>     $ dmesg | grep -e 'DMI:' -e 'printk: console'
>     [    0.000000] DMI: Dell Inc. PowerEdge R7425/08V001, BIOS 1.6.7
> 10/29/2018
>     [    1.589543] printk: console [tty0] enabled
>     [    3.057770] printk: console [ttyS0] enabled
> 
>     $ dmesg | grep -e 'DMI:' -e 'printk: console'
>     [    0.000000] DMI: HPE ProLiant DL385 Gen10 Plus/ProLiant DL385 Gen10
> Plus, BIOS A42 12/03/2021
>     [    5.171202] printk: console [tty0] enabled
>     [    8.066602] printk: console [ttyS0] enabled
> 
> `initcall_debug` shows:
> 
>     [    0.190491] calling  univ8250_console_init+0x0/0x2b @ 0
>     [    1.488645] printk: console [ttyS0] enabled
>     [    1.492945] initcall univ8250_console_init+0x0/0x2b returned 0 after
> 0 usecs
> 
> (Note, that the “after time” by initcall does not match the timestamp at the
> beginning.)

The message "printk: console [ttyS0] enabled" is printed almost at the
end of register_console(). It happens after all previously printed
messages reach the console.

It might take a long time to show all messages on slow serial consoles.


> So it looks to me like, that the already recorded messages are printed out
> over the serial console first, before it continues. The documentation of
> `register_console()` in `kernel/printk/printk.c` confirms that:
> >
> >  * The console driver calls this routine during kernel initialization
> >  * to register the console printing procedure with printk() and to
> >  * print any messages that were printed by the kernel before the
> >  * console driver was initialized.

Most people want to see all messages. Any previous warning or error might
the reason why the system crashed later.

If you want faster boot, you might consider using "quiet" or
loglevel=<some low number> on the kernel command line. It will
show only the most important messages on the console.


> Is there an option to enable the serial console but send the messages to it
> asynchronously so it does not hold up the boot?

We have been trying to get this into upstream for years. It is not
that easy. Asynchronous handling increases the risk that a console
will not show the last important messages when things go wrong.

Anyway, we are still trying. One puzzle of this effort is just
being reviewed in this thread,
https://lore.kernel.org/r/20221107141638.3790965-1-john.ogness@linutronix.de

Best Regards,
Petr
