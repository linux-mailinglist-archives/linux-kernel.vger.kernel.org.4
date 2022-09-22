Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B722B5E6699
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiIVPPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbiIVPPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:15:20 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 451429B86D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:15:18 -0700 (PDT)
Received: (qmail 262011 invoked by uid 1000); 22 Sep 2022 11:15:17 -0400
Date:   Thu, 22 Sep 2022 11:15:17 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Ray Chi <raychi@google.com>, mchehab+huawei@kernel.org,
        albertccwang@google.com, badhri@google.com, pumahsu@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [Patch v3] usb: core: stop USB enumeration if too many retries
Message-ID: <Yyx8BbxM97FeNwJ7@rowland.harvard.edu>
References: <20220908104019.3080989-1-raychi@google.com>
 <YyxP2/GLgyp5Cq66@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyxP2/GLgyp5Cq66@kroah.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry I forgot about this patch.

On Thu, Sep 22, 2022 at 02:06:51PM +0200, Greg KH wrote:
> On Thu, Sep 08, 2022 at 06:40:19PM +0800, Ray Chi wrote:
> > When a broken USB accessory connects to a USB host, usbcore might
> > keep doing enumeration retries. If the host has a watchdog mechanism,
> > the kernel panic will happen on the host.
> > 
> > The patch provide a attribute to limit the numbers of retries and
> > timeout lengths.
> 
> This is per-port, right?  Please say that here.

Also, the patch does not limit any timeout lengths -- just the number of 
retries.  Maybe you want to make it limit the timeouts also.

> > In addition, it also adds a function to stop the
> > port initialization and ignore events on the port if the broken
> > accessory is still connected.
> 
> So this should be 2 patches?  Remember, only do one logical thing per
> patch please.

The "adding a function" part is unimportant; we can see the function 
simply by reading the patch.  The main points here, which you have not 
explained clearly, are:

    1.	If a port is marked with the quick_init attribute, unsuccessful 
	connection attempts will fail quickly.

    2.	Once a quick_init port has failed to initialize, it will ignore
	all future connections until the quick_init attribute is turned
	off.

> > Signed-off-by: Ray Chi <raychi@google.com>
> > ---
> > Changes since v2:
> >  - replace the quirk with the attribute
> >  - Document the attribute
> >  - modify hub_port_stop_enumerate() position in port_event()
> >  - modify the changelog
> > 
> > Changes since v1:
> >  - remove usb_hub_set_port_power()
> >  - add a variable ignore_connect into struct port_dev
> >  - modify hub_port_stop_enumerate() and set ignore_connect in
> >    this function
> >  - avoid calling hub_port_connect_change() in port_event()
> > ---
> >  Documentation/ABI/testing/sysfs-bus-usb |  9 ++++++
> >  drivers/usb/core/hub.c                  | 39 +++++++++++++++++++++++++
> >  drivers/usb/core/hub.h                  |  4 +++
> >  drivers/usb/core/port.c                 | 23 +++++++++++++++
> >  4 files changed, 75 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
> > index 568103d3376e..d44c8aaef929 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-usb
> > +++ b/Documentation/ABI/testing/sysfs-bus-usb
> > @@ -264,6 +264,15 @@ Description:
> >  		attached to the port will not be detected, initialized,
> >  		or enumerated.
> >  
> > +What:		/sys/bus/usb/devices/.../<hub_interface>/port<X>/quick_init
> > +Date:		Sep 2022
> > +Contact:	Ray Chi <raychi@google.com>
> > +Description:
> > +		Some USB hosts have some watchdog mechanisms so that the device
> > +		may enter ramdump if it takes a long time during port initialization.
> > +		This attribute limits the numbers of retries and timeout lengths once
> > +		an initialization of the port meets failures.
> 
> The text here is very odd, maybe it's just a translation issue.  A port
> can not "meet" a failure.  And this really has nothing to do with any
> watchdog, it's just a "we want to fail broken devices quickly instead of
> giving them lots of time to connect" type of issue, right?
> 
> And we already have different init schemes, "quick" is an odd way to
> phrase this, but I can't think of anything else at the moment.

"fail-fast" gives the idea better, but it's more awkward.

> > +
> >  What:		/sys/bus/usb/devices/.../power/usb2_lpm_l1_timeout
> >  Date:		May 2013
> >  Contact:	Mathias Nyman <mathias.nyman@linux.intel.com>
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index d4b1e70d1498..f22caa133274 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -3081,6 +3081,29 @@ static int hub_port_reset(struct usb_hub *hub, int port1,
> >  	return status;
> >  }
> >  
> > +/* Check whether a hub would stop enumeration or ignore events on the port. */
> 
> Based on what?  Retries?  Time of day?  Phase of moon?  :)
> 
> > +static bool hub_port_stop_enumerate(struct usb_hub *hub, int port1, int retries)
> > +{
> > +	struct usb_port *port_dev = hub->ports[port1 - 1];
> > +
> > +	if (port_dev->quick_init) {
> > +		if (port_dev->ignore_connect)
> > +			return true;
> > +
> > +		/*
> > +		 * Since some normal devices will be timeout in the first attempt,
> > +		 * set the condition to half of the retries
> > +		 */
> > +		if (retries < (PORT_INIT_TRIES - 1) / 2)
> > +			return false;

This is not a good test.  You shouldn't rely on PORT_INIT_TRIES having 
any particular value or being used in any particular way.  You should 
just something like:

		/*
		 * We want unsuccessful attempts to fail quickly.
		 * Therefore allow three tries but no more.
		 */
		if (retries < 3)

> > +
> > +		port_dev->ignore_connect = true;
> > +	} else
> > +		port_dev->ignore_connect = false;
> 
> So this function modifies a port_dev value, AND returns it to the
> caller?  Why not document that somewhere?  Why do both?
> 
> And if quick_init is false then it always set ignore_connect to false
> and returns false always?

As mentioned above, the goal is to limit the number of retries if 
quick_init is set and prevent all connection attempts once one has 
failed, without changing anything if quick_init is not set.

> 
> > +
> > +	return port_dev->ignore_connect;
> > +}
> > +
> >  /* Check if a port is power on */
> >  int usb_port_is_power_on(struct usb_hub *hub, unsigned int portstatus)
> >  {
> > @@ -4855,6 +4878,11 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
> >  					buf->bMaxPacketSize0;
> >  			kfree(buf);
> >  
> > +			if (r < 0 && port_dev->quick_init) {
> > +				retval = r;
> > +				goto fail;

I still think you should test hub_port_stop_enumeration() here.  It 
doesn't make sense that you allow a few retries for other types of 
errors but not for this one.

Alan Stern

> > +			}
> > +
> >  			retval = hub_port_reset(hub, port1, udev, delay, false);
> >  			if (retval < 0)		/* error or disconnect */
> >  				goto fail;
> > @@ -5387,6 +5415,9 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
> >  		if ((status == -ENOTCONN) || (status == -ENOTSUPP))
> >  			break;
> >  
> > +		if (hub_port_stop_enumerate(hub, port1, i))
> > +			break;
> > +
> >  		/* When halfway through our retry count, power-cycle the port */
> >  		if (i == (PORT_INIT_TRIES - 1) / 2) {
> >  			dev_info(&port_dev->dev, "attempt power cycle\n");
> > @@ -5614,6 +5645,9 @@ static void port_event(struct usb_hub *hub, int port1)
> >  	if (!pm_runtime_active(&port_dev->dev))
> >  		return;
> >  
> > +	if (hub_port_stop_enumerate(hub, port1, 0))
> > +		return;
> > +
> >  	if (hub_handle_remote_wakeup(hub, port1, portstatus, portchange))
> >  		connect_change = 1;
> >  
> > @@ -5934,6 +5968,9 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
> >  		ret = hub_port_init(parent_hub, udev, port1, i);
> >  		if (ret >= 0 || ret == -ENOTCONN || ret == -ENODEV)
> >  			break;
> > +
> > +		if (hub_port_stop_enumerate(parent_hub, port1, i))
> > +			goto stop_enumerate;
> >  	}
> >  	mutex_unlock(hcd->address0_mutex);
> >  
> > @@ -6022,6 +6059,8 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
> >  	udev->bos = bos;
> >  	return 0;
> >  
> > +stop_enumerate:
> > +	mutex_unlock(hcd->address0_mutex);
> >  re_enumerate:
> >  	usb_release_bos_descriptor(udev);
> >  	udev->bos = bos;
> > diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
> > index b2925856b4cb..57995ec3af58 100644
> > --- a/drivers/usb/core/hub.h
> > +++ b/drivers/usb/core/hub.h
> > @@ -90,6 +90,8 @@ struct usb_hub {
> >   * @is_superspeed cache super-speed status
> >   * @usb3_lpm_u1_permit: whether USB3 U1 LPM is permitted.
> >   * @usb3_lpm_u2_permit: whether USB3 U2 LPM is permitted.
> > + * @ignore_connect: ignore the connection or not.
> 
> Which connection?  Any future connection?  Or the one that is currently
> connected?
> 
> > + * @quick_init: limit the numbers of retries for port initialization
> 
> Limit it to what?
> 
> >   */
> >  struct usb_port {
> >  	struct usb_device *child;
> > @@ -103,6 +105,8 @@ struct usb_port {
> >  	u32 over_current_count;
> >  	u8 portnum;
> >  	u32 quirks;
> > +	bool ignore_connect;
> > +	bool quick_init;
> 
> Why are these bool, when:
> 
> >  	unsigned int is_superspeed:1;
> >  	unsigned int usb3_lpm_u1_permit:1;
> >  	unsigned int usb3_lpm_u2_permit:1;
> 
> Those are all bits?
> 
> Be consistent please.
> 
> thanks,
> 
> greg k-h
