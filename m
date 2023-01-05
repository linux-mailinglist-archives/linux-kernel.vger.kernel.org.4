Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B4565F007
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbjAEPZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbjAEPZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:25:36 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08825C938
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 07:25:14 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 634A7246F7;
        Thu,  5 Jan 2023 15:24:56 +0000 (UTC)
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1D87B2C149;
        Thu,  5 Jan 2023 15:24:56 +0000 (UTC)
Date:   Thu, 5 Jan 2023 16:24:55 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 5/8] printk: introduce
 printk_get_next_message() and printk_message
Message-ID: <Y7brx08wN+TE/YLN@alley>
References: <20230105103735.880956-1-john.ogness@linutronix.de>
 <20230105103735.880956-6-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105103735.880956-6-john.ogness@linutronix.de>
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
        none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [0.00 / 50.00]
X-Spam-Score: 0.00
X-Rspamd-Queue-Id: 634A7246F7
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-01-05 11:43:32, John Ogness wrote:
> Code for performing the console output is intermixed with code that
> is formatting the output for that console. Introduce a new helper
> function printk_get_next_message() to handle the reading and
> formatting of the printk text. The helper does not require any
> locking so that in the future it can be used for other printing
> contexts as well.
> 
> This also introduces a new struct printk_message to wrap the struct
> printk_buffers, adding metadata about its contents. This allows
> users of printk_get_next_message() to receive all relevant
> information about the message that was read and formatted.
> 
> Why is struct printk_message a wrapper struct?
> 
> It is intentional that a wrapper struct is introduced instead of
> adding the metadata directly to struct printk_buffers. The upcoming
> atomic consoles support multiple printing contexts per CPU. This
> means that while a CPU is formatting a message, it can be
> interrupted and the interrupting context may also format a (possibly
> different) message. Since the printk buffers are rather large,
> there will only be one struct printk_buffers per CPU and it must be
> shared by the possible contexts of that CPU.
> 
> If the metadata was part of struct printk_buffers, interrupting
> contexts would clobber the metadata being prepared by the
> interrupted context. This could be handled by robustifying the
> message formatting functions to cope with metadata unexpectedly
> changing. However, this would require significant amounts of extra
> data copying, also adding significant complexity to the code.
> 
> Instead, the metadata can live on the stack of the formatting
> context and the message formatting functions do not need to be
> concerned about the metadata changing underneath them.
> 
> Note that the message formatting functions can handle unexpected
> text buffer changes. So it is perfectly OK if a shared text buffer
> is clobbered by an interrupting context. The atomic console
> implementation will recognize the interruption and avoid printing
> the (probably garbage) text buffer.

Great description!

> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
