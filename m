Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0FF711315
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241200AbjEYSDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240639AbjEYSDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:03:11 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id C122CE70
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 11:02:57 -0700 (PDT)
Received: (qmail 260359 invoked by uid 1000); 25 May 2023 14:02:56 -0400
Date:   Thu, 25 May 2023 14:02:56 -0400
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
Subject: Re: [RFC PATCH v1] usb: core: add sysfs entry for usb device state
Message-ID: <408575c0-2967-4cdb-92c7-1b2845038d20@rowland.harvard.edu>
References: <20230525173818.219633-1-royluo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525173818.219633-1-royluo@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 05:38:18PM +0000, Roy Luo wrote:
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
> Signed-off-by: Roy Luo <royluo@google.com>
> ---

> diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
> index e23833562e4f..110143568c77 100644
> --- a/drivers/usb/core/hub.h
> +++ b/drivers/usb/core/hub.h
> @@ -84,8 +84,10 @@ struct usb_hub {
>   * @peer: related usb2 and usb3 ports (share the same connector)
>   * @req: default pm qos request for hubs without port power control
>   * @connect_type: port's connect type
> + * @state: device state of the usb device attached to the port

This member is essentially a duplicate of the .child member of the 
usb_port structure.  That is, it points to the .state member of the 
child device instead of to the child device itself, but this is pretty 
much the same thing.  You could replace *(port_dev->state) with 
port_dev->child->state.

> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> index 06a8f1f84f6f..7f3430170115 100644
> --- a/drivers/usb/core/port.c
> +++ b/drivers/usb/core/port.c
> @@ -160,6 +160,19 @@ static ssize_t connect_type_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(connect_type);
>  
> +static ssize_t state_show(struct device *dev,
> +			  struct device_attribute *attr, char *buf)
> +{
> +	struct usb_port *port_dev = to_usb_port(dev);
> +	enum usb_device_state state = USB_STATE_NOTATTACHED;
> +
> +	if (port_dev->state)
> +		state = *port_dev->state;
> +
> +	return sprintf(buf, "%s\n",  usb_state_string(state));

This races with device addition and removal (and with device state 
changes).  To prevent these races, you have to hold the 
device_state_lock spinlock while accessing the child device and its 
state.

Unfortunately that spinlock is private to hub.c, so you will have to 
make it public before you can use it here.

Alan Stern
