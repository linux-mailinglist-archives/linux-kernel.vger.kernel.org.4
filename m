Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2917C71F681
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 01:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjFAXVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 19:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjFAXVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 19:21:37 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id BE839184
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 16:21:34 -0700 (PDT)
Received: (qmail 20719 invoked by uid 1000); 1 Jun 2023 19:21:33 -0400
Date:   Thu, 1 Jun 2023 19:21:33 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Roy Luo <royluo@google.com>
Cc:     raychi@google.com, badhri@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Bastien Nocera <hadess@hadess.net>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Douglas Anderson <dianders@chromium.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v1] usb: core: add sysfs entry for usb device state
Message-ID: <4f049d62-d103-4491-9c7e-16c7cf94eac1@rowland.harvard.edu>
References: <20230601230456.2234972-1-royluo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601230456.2234972-1-royluo@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 11:04:56PM +0000, Roy Luo wrote:
> Expose usb device state to userland as the information is useful in
> detecting non-compliant setups and diagnosing enumeration failures.
> For example:
> - End-to-end signal integrity issues: the device would fail port reset
>   repeatedly and thus be stuck in POWERED state.
> - Charge-only cables (missing D+/D- lines): the device would never enter
>   POWERED state as the HC would not see any pullup.
> 
> What's the status quo?
> We do have error logs such as "Cannot enable. Maybe the USB cable is bad?"
> to flag potential setup issues, but there's no good way to expose them to
> userspace.
> 
> Why add a sysfs entry in struct usb_port instead of struct usb_device?
> The struct usb_device is not device_add() to the system until it's in
> ADDRESS state hence we would miss the first two states. The struct
> usb_port is a better place to keep the information because its life
> cycle is longer than the struct usb_device that is attached to the port.
> 
> Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Roy Luo <royluo@google.com>
> ---

> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 97a0f8faea6e..35d94288726b 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -2018,6 +2018,23 @@ bool usb_device_is_owned(struct usb_device *udev)
>  	return !!hub->ports[udev->portnum - 1]->port_owner;
>  }
>  
> +static void update_port_device_state(struct usb_device *udev)
> +{
> +	struct usb_port *port_dev = NULL;
> +	struct usb_hub *hub = NULL;
> +	struct kernfs_node *state_node = NULL;
> +
> +	if (udev->parent) {
> +		hub = usb_hub_to_struct_hub(udev->parent);
> +		port_dev = hub->ports[udev->portnum - 1];
> +		WRITE_ONCE(port_dev->state, udev->state);
> +		state_node = sysfs_get_dirent(port_dev->dev.kobj.sd, "state");
> +		if (state_node) {
> +			sysfs_notify_dirent(state_node);
> +		}
> +	}
> +}

I didn't notice the "= NULL" initializers before.  You might want to 
remove them, since they are completely unnecessary.

Alan Stern
