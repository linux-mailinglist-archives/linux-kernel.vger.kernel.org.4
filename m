Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35C9624903
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiKJSEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbiKJSEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:04:06 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7684345ED7;
        Thu, 10 Nov 2022 10:03:50 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 218392292B;
        Thu, 10 Nov 2022 18:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668103429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yUxxNFRyrBakLyHUCOSvHWfBsY0UPGKUqsopoVuSD1g=;
        b=qzFyp8E//kCUil5Kimk240zLxzo/MAIyT6Z5L/g7vmLkf7GhcukYXuTVM/QuhVsdB8Rm5N
        CJnjGMJl5yH3H9ShX2YjGZcmYeBWKoZOAJh91m6LOjm3xtcU2itWXOYppZCf7eiEWYmrK+
        7T3lXw+mHMzXHy2rKhPO26J7LHw/NOc=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B0FF72C141;
        Thu, 10 Nov 2022 18:03:47 +0000 (UTC)
Date:   Thu, 10 Nov 2022 19:03:47 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v3 37/40] tty: serial: kgdboc: synchronize
 tty_find_polling_driver() and register_console()
Message-ID: <Y209A4xlsRiBMz6+@alley>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-38-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107141638.3790965-38-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-11-07 15:22:35, John Ogness wrote:
> Calling tty_find_polling_driver() can lead to uart_set_options() being
> called (via the poll_init() callback of tty_operations) to configure the
> uart. But uart_set_options() can also be called by register_console()
> (via the setup() callback of console).
> 
> Take the console_list_lock to synchronize against register_console() and
> also use it for console list traversal. This also ensures the console list
> cannot change until the polling console has been chosen.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Huh, this is a maze of related calls. At least for me. But the change
seems to be correct.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
