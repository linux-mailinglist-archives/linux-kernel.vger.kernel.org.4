Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6766F696298
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBNLmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBNLmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:42:07 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EF42068B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:42:06 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D06EF1F383;
        Tue, 14 Feb 2023 11:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676374924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fUeGf6y5tf2KsuLMak22k+k24KUuAb9SQgUxv43Mdwc=;
        b=hTgKoLtMn1WEz7RJ32zme/BnvJ+Ux68vY4Si9TGBg6PaogO8Fpn2fZyEDg3eIUcGIRSaPm
        HwAj6fQXxtCDh9fm0X2kcnmUTD8iMEqXfDDPYsthQoeIygeY5vXGBwiXLdPDgGlIHnEhUY
        9UEAcL9pPsSVL4Z7MyCDoXVBL85ZZpg=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 673672C141;
        Tue, 14 Feb 2023 11:42:04 +0000 (UTC)
Date:   Tue, 14 Feb 2023 12:42:00 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc:     jirislaby@kernel.org, senozhatsky@chromium.org,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/1] kernel: Match preferred console first.
Message-ID: <Y+tziG0Uo5ey+Ocy@alley>
References: <20230213113912.1237943-1-rkanwal@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213113912.1237943-1-rkanwal@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-02-13 11:39:12, Rajnesh Kanwal wrote:
> For cases where the driver registers the console with the index set to -1
> the `try_enable_preferred_console()` doesn't work as expected for multiple
> hvc consoles.
> 
> For example with `CONFIG_HVC_RISCV_SBI` and `CONFIG_VIRTIO_CONSOLE` enabled
> and cmdline set to "console=hvc0 console=hvc1" where hvc0 being RISCV_SBI
> and hvc1 being VIRTIO_CONSOLE (the preferred one as per the preferred
> selection logic in `__add_preferred_console`). hvc1 never gets enabled as hvc0
> matches first with the driver name "hvc" and index set to -1.
> 
> Here is the hvc console structure from hvc_console.c L217.
> static struct console hvc_console = {
>         .name           = "hvc",
>         .write          = hvc_console_print,
>         .device         = hvc_console_device,
>         .setup          = hvc_console_setup,
>         .flags          = CON_PRINTBUFFER,
>         .index          = -1,
> };
> 
> The expected flow is that hvc1 should take precedence but given hvc console has
> the index set to -1, the current logic will try to assign the first console that
> matches, which is hvc0 and return. Never touching other possible consoles.
> 
> This change makes sure the preferred console is checked first and then iterate
> the remaining list.
> 
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>

Unfortunately, we could not do this. We have already been there, see
the commit dac8bbbae1d0ccba96402 ("Revert "printk: fix double printing
with earlycon") for more details.

It is sad. The patch would make perfect sense. But we could not take
it because people would report regressions.

I am afraid that we could only better document the existing behavior.

Proposed patch:

--- a/Documentation/admin-guide/serial-console.rst
+++ b/Documentation/admin-guide/serial-console.rst
@@ -33,8 +33,11 @@ The format of this option is::
 			9600n8. The maximum baudrate is 115200.
 
 You can specify multiple console= options on the kernel command line.
-Output will appear on all of them. The last device will be used when
-you open ``/dev/console``. So, for example::
+
+The behavior is well defined when each device type is mentioned
+only once. In this case, the output will appear on all requested
+consoles. And the last device will be used when you open
+``/dev/console``. So, for example::
 
 	console=ttyS1,9600 console=tty0
 
@@ -42,7 +45,29 @@ defines that opening ``/dev/console`` will get you the current foreground
 virtual console, and kernel messages will appear on both the VGA
 console and the 2nd serial port (ttyS1 or COM2) at 9600 baud.
 
-Note that you can only define one console per device type (serial, video).
+The behavior is more complicated when a device type is defined more
+times. In this case, there are the following two rules:
+
+1. The output will appear only on the first device of each defined type.
+
+2. ``/dev/console`` will be associated with the first registered device
+   when the last defined device is ignored because of the 1st rule.
+
+The result might be surprising. For example, the following two command
+lines have the same result:
+
+	console=ttyS1,9600 console=tty0 console=tty1
+	console=tty0 console=ttyS1,9600 console=tty1
+
+The kernel messages are printed only on ``tty0`` and ``ttyS1``. And
+``/dev/console`` gets associated with ``tty0``. It is because kernel
+tries to register graphical consoles before serial ones. It does it
+because of the default behavior when no console device is specified,
+see below.
+
+Note that the last ``console=tty1`` parameter still makes a difference.
+The kernel command line is used also by systemd. It would use the last
+defined ``tty1`` as the login console.
 
 If no console device is specified, the first device found capable of
 acting as a system console will be used. At this time, the system


Best Regards,
Petr
