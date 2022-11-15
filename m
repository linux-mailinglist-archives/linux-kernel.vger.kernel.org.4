Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D95629F5B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbiKOQnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238703AbiKOQnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:43:41 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3A313CCA;
        Tue, 15 Nov 2022 08:43:39 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3A56D1F8D7;
        Tue, 15 Nov 2022 16:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668530618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fp5QcrHVvziCUNf95TE2tiPSkunTivk9nv+QjUBLUYc=;
        b=DuI+pBPW9cPLeFgTUc8qq6JcnB8YMbdXCCKmj/VkmKXQEOJiQGxHQifk91b5K7HbP6jtNB
        Uq1ybCS4qBXvhOllYVSMaq0J07cfltsC0Xy0eGgPgZiviaLmrHSQvSQ/keV2DA/qXrahAH
        498ArqD0N8Ee/uLQ/20i067xlnBI0bE=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F37422C142;
        Tue, 15 Nov 2022 16:43:37 +0000 (UTC)
Date:   Tue, 15 Nov 2022 17:43:37 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH printk v4 39/39] tty: serial: sh-sci: use setup()
 callback for early console
Message-ID: <Y3PBuWL/3qihQJxj@alley>
References: <20221114162932.141883-1-john.ogness@linutronix.de>
 <20221114162932.141883-40-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114162932.141883-40-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-11-14 17:35:32, John Ogness wrote:
> When setting up the early console, the setup() callback of the
> regular console is used. It is called manually before registering
> the early console instead of providing a setup() callback for the
> early console. This is probably because the early setup needs a
> different @options during the early stage.
> 
> The issue here is that the setup() callback is called without the
> console_list_lock held and functions such as uart_set_options()
> expect that.
> 
> Rather than manually calling the setup() function before registering,
> provide an early console setup() callback that will use the different
> early options. This ensures that the error checking, ordering, and
> locking context when setting up the early console are correct.
> 
> Since this early console can only be registered via the earlyprintk=
> parameter, the @options argument of the setup() callback will always
> be NULL. Rather than simply ignoring the argument, add a WARN_ON()
> to get our attention in case the setup() callback semantics should
> change in the future.
> 
> Note that technically the current implementation works because it is
> only used in early boot. And since the early console setup is
> performed before registering, it cannot race with anything and thus
> does not need any locking. However, longterm maintenance is easier
> when drivers rely on the subsystem API rather than manually
> implementing steps that could cause breakage in the future.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
