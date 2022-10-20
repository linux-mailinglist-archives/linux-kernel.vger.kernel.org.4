Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C3B6058E3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiJTHnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiJTHnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:43:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F743175785;
        Thu, 20 Oct 2022 00:43:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3DF4B8265F;
        Thu, 20 Oct 2022 07:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44184C433C1;
        Thu, 20 Oct 2022 07:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666251762;
        bh=xRdVE9aidjuImN/AuV60ZkxbXja2doJEERbOAXKZNRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IbrjTATvAI5DDOIzrV+B3jYVi019tIBwGxApFj9ewolUMaoHhqheBqZ+7Dgj2bp3d
         t9tKajcmMeu9z9qkmQ9nqsk4DRHGyhPNwRWENrDnUsPM75hroToM1/6UvKVd5fES3o
         w0ceeG1qALz8GEaD0r5Ga0sWcmUruwDMLb5E0Vkk=
Date:   Thu, 20 Oct 2022 09:42:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v2 22/38] serial: kgdboc: document console_lock
 usage
Message-ID: <Y1D770/QciPCy3ds@kroah.com>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-23-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-23-john.ogness@linutronix.de>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 05:01:44PM +0206, John Ogness wrote:
> kgdboc_earlycon_init() uses the console_lock to ensure that no consoles
> are unregistered until the kgdboc_earlycon is setup. This is necessary
> because the trapping of the exit() callback assumes that the exit()
> callback is not called before the trap is setup.
> 
> Explicitly document this non-typical console_lock usage.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  drivers/tty/serial/kgdboc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index e9d3f8c6e3dc..48000666789a 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -545,6 +545,14 @@ static int __init kgdboc_earlycon_init(char *opt)
>  	 * Look for a matching console, or if the name was left blank just
>  	 * pick the first one we find.
>  	 */
> +
> +	/*
> +	 * Hold the console_lock to guarantee that no consoles are
> +	 * unregistered until the kgdboc_earlycon setup is complete.
> +	 * Trapping the exit() callback relies on exit() not being
> +	 * called until the trap is setup. This also allows safe
> +	 * traversal of the console list.
> +	 */
>  	console_lock();
>  	for_each_console(con) {
>  		if (con->write && con->read &&
> -- 
> 2.30.2
>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
