Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A035B71FA50
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 08:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbjFBGq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 02:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjFBGqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 02:46:54 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EAB6EB;
        Thu,  1 Jun 2023 23:46:54 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 6478A8111;
        Fri,  2 Jun 2023 06:46:53 +0000 (UTC)
Date:   Fri, 2 Jun 2023 09:46:52 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: core: Fix error handling for
 serial_core_ctrl_device_add()
Message-ID: <20230602064652.GF14287@atomide.com>
References: <20230602064104.41508-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602064104.41508-1-tony@atomide.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [230602 06:41]:
> Checking for NULL is not enough as serial_base_ctrl_add() uses ERR_PTR().
> 
> Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/tty/serial/serial_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3342,7 +3342,7 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
>  	ctrl_dev = serial_core_ctrl_find(drv, port->dev, port->ctrl_id);
>  	if (!ctrl_dev) {
>  		new_ctrl_dev = serial_core_ctrl_device_add(port);
> -		if (!new_ctrl_dev) {
> +		if (IS_ERR_OR_NULL(new_ctrl_dev)) {
>  			ret = -ENODEV;
>  			goto err_unlock;
>  		}

Hmm actually we should also change to use ret = PTR_ERR(new_ctrl_dev) here
instead of translating all the errors to -ENODEV. Will send out v2 version.

Regards,

Tony
