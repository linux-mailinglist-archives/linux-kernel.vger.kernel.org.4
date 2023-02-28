Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EEB6A5464
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjB1Ico (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjB1Icm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:32:42 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1176D234C5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:32:39 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pWvPa-0006QL-4q; Tue, 28 Feb 2023 09:32:38 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pWvPZ-00057z-Sh; Tue, 28 Feb 2023 09:32:37 +0100
Date:   Tue, 28 Feb 2023 09:32:37 +0100
From:   Sascha Hauer <sha@pengutronix.de>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: About regulator error events
Message-ID: <20230228083237.GN32097@pengutronix.de>
References: <20230227130542.GM32097@pengutronix.de>
 <Y/yt8nzVuO4sUg3v@sirena.org.uk>
 <CANhJrGMRoR5BfoTswmF8RtLbBd1RxQ77o_W4bNyAgEqZSzdU7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANhJrGMRoR5BfoTswmF8RtLbBd1RxQ77o_W4bNyAgEqZSzdU7A@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 06:19:19PM +0200, Matti Vaittinen wrote:
> ma 27. helmik. 2023 klo 15.19 Mark Brown (broonie@kernel.org) kirjoitti:
> >
> > On Mon, Feb 27, 2023 at 02:05:42PM +0100, Sascha Hauer wrote:
> > > I have a board here which has some current limited power switches on it
> > > and I wonder if I can do something reasonable with the error interrupt
> > > pins these switches have.
> >
> > Just noticed that Matti (who's been doing a bunch of work here) wasn't
> > CCed so adding him.
> 
> Thanks. I just hoped I had more to say...
> 
> 
> > > The devices do not have a communication channel, instead they only have
> > > an enable pin and an error interrupt pin. See
> > > https://www.diodes.com/assets/Datasheets/AP22652_53_52A_53A.pdf for a
> > > datasheet.  The devices come in two variants, one goes into current
> > > limiting mode in case of overcurrent and the other variant switches off
> > > until it gets re-enabled again.
> > >
> > > At first sight it seemed logical to me to wire up the error interrupt
> > > pins to REGULATOR_EVENT_OVER_CURRENT events. That was easy to do, but
> > > now the question is: What can a regulator consumer do with these events?
> 
> This is a question I have asked too.
> 
> I was asked to create a driver for a ROHM BD9576 PMIC - which has the
> usual configurable over-current, over-voltage, under-voltage and
> over-temperature protection limits. (Well, the temperature limit is
> fixed). This means that when limits are exceeded - the PMIC shuts down
> the power outputs by hardware.
> 
> What was new is that the BD9576 also had configurable warning-level
> limits (stricter than the protection limits) - and when these were
> exceeded only a 'warning IRQ' was issued. This setup was requested
> from ROHM by a customer - and the information I received was the
> customer had a use-case where they wanted to do 'mitigation actions'
> before things get more severely off. Unfortunately, I never received
> the information about these 'mitigation actions' when I tried to ask
> what those could be. I am under impression that either out HW
> colleagues did not know the customer use-case in details, or that this
> information was 'top secret' (which seems to be the case pretty often
> :( )
> 
> > > The strategy I had in mind was to disable the regulator, enable it again
> > > to see if the errors persists and if it does, permanently disable the
> > > device.  Disabling the regulator only works though when there's only one
> > > consumer.
> 
> If it is obvious that disabling the regulator is required for
> preventing the damage, then it might be justified to use the
> regulator_force_disable()? Now, the question when this is obvious is
> hard. I think it is the board designer who should be evaluating this -
> and as such, I would say that the information about the severity of
> error should come from hardware properties - eg. from device-tree.
> Now, I am not really sure but I have a feeling that ideally the
> regulator driver (provider, not the consumer) should have this
> information about the severity level in device-tree and select the use
> of notifier flag based on this. If an ERROR level event is emitted, it
> should mean the hardware has really failed and forced disable could be
> justified. If a WARNING level event is sent, then the handling should
> be more graceful - probably done by some very system specific driver.
> 
> My problem here is that I don't have the visibility or understanding
> regarding current use of those events. Not sure if all the hell would
> break loose if the regulators are forcibly shut down. By the very
> least I would expect such a consumer handling to be disabled by
> default - either via configs or via some runtime enable/disable
> mechanism.
> 
>  With multiple consumers only the enable count decreases, but
> > > the regulator itself stays enabled. This means implementing such a
> > > policy at the consumer side is not generally possible. Implementing a
> > > policy in the regulator core seems awkward as well, as a good strategy
> > > likely differs between different consumers.
> > >
> > > A first good step might be to notify the user somehow. While we can get
> > > the overcurrent status of a regulator from
> > > /sys/class/regulator/*/over_current there doesn't seem to be any way to
> > > get a regulator event in userspace, right?  Would patches changing that
> > > be welcomed?
> > >
> > > There doesn't seem to be much prior art for handling regulator error
> > > events in the kernel. It would be great to get some input what others do
> > > in this situation, or to get some ideas what they would do if they had
> > > the time to do so ;)
> 
> I did submit a talk proposal about these regulator notifications to
> ELCE next summer. I don't really have much to say - but I do hope that
> I could gain some insight exactly to the question: "[where / how]
> these notifications [are / could be] used?" With a lot of luck the
> talk proposal gets accepted - and with a bit of luck people in the
> audience know more than I do ;)
> 
> I think it was qcom-labibb-regulator.c which does try to disable the
> failing regulators and then call BUG_ON() if even that fails. Back
> when I did implement the regulator irq_helper, I did decide to try
> supporting similar logic for drivers which explicitly request failures
> to handle these protection IRQs to be treated as fatal errors - except
> that instead of calling BUG_ON() (which to my understanding does not
> necessarily lead to reset on all configs) - I try to run the poweroff.
> This, however, is probably not a good generic solution.
> 
> I am all for adding notification sending to user-space. Still, I am
> not against a kernel-level protection either - that can be used in
> cases where user-space or user-space handling is not available / to be
> trusted for a reason or other. What should be known then in-kernel is
> whether the handling should be left to user-space (or other consumers)
> - or if the kernel driver should take some protective action(s).
> 
> Yep, I know this was not much - sorry :( As I said, I do lack the
> insight to real-world use cases...

At least in my case I can tell something about the real-world use case.

One of the current limiting switches supplies VBUS to a USB port on the
board. The USB core already has an idea of over current handling. In
theory we could wire up the over current event to the XHCI driver. In
practice this doesn't seem to be that simple. Over current is normally
read from a register bit in the XHCI controller. We would have to route
the over current event from the DWC3 device tree binding through the
DWC3 driver to the XHCI driver, short circuit the over current register
bit and use the regulator information instead. While doable this sounds
like a lot of work for just a special case.

The other current limiting switch supplies the +5v output of a HDMI
connector. Hell won't break loose in case of an over current event, it
mainly only indicates that a broken cable is connected. In an ideal
world the user would be notified about the over current and everything
could go back to normal once the broken cable has been replaced with a
working one.  regulator_force_disable() wouldn't be needed in my case as
the switch automatically turns off anyway when an over current is
detected.

Right now a regulator consumer doesn't know how the regulator behaves in
case of an over current event. Does it turn off or does it go into
current limiting mode? The consumer also doesn't know if it is
exlusively using the regulator or if there are other consumers. Even if
it had that information it would likely become quite a mess when each
regulator consumer spread around hundreds of drivers get their own over
current handling. With that I think over current events can only
sensibly be handled in the regulator core, maybe with some help of
device tree properties.

I take from this discussion that it's at least a good idea to send
user space notifications when something goes wrong with the regulators.

Sascha



-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
