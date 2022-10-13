Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2355FDCB6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 16:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiJMO6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 10:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJMO6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 10:58:14 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270F5EC533;
        Thu, 13 Oct 2022 07:58:12 -0700 (PDT)
Date:   Thu, 13 Oct 2022 14:57:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=noorman.info;
        s=protonmail3; t=1665673089; x=1665932289;
        bh=9cETEA+VKqHpvTyYHC/Zk4or8vtEB0P2Vm4JNqsdPH0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=dnND8bahBYa1JGB2eQX9QGQFC8NiuLf4nQddMDraNn24uSlKPreE+Pz84o1Cj7CQ/
         r1FFU7bN640Ea4j9xiSanJ7v3TMetORDIg06Z0grPJJnG32I859f2zeAim2w617kOD
         PAgmQWJ7NVbGm2UvRDJoXFtPZTWRTMCUakmnufpcXrC+EGPbbcGo6nbxXNS/ciGeRL
         iM54S5PhQXHU+sgP4rzRuTgSfj8DlduwoToUcsv0xQa+YlQGgr7AxL6jdkpGPfEWYl
         GsQ5L0wZsA2vjvNTYj5vZgE3qC5IOvcPKxpWAr7zXu+alex8n4E7xZOfVPAXYxk6NG
         Ysb5tsspmOeug==
To:     Jeff LaBundy <jeff@labundy.com>
From:   Job Noorman <job@noorman.info>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Luca Weiss <luca@z3ntu.xyz>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v2 2/3] Input: add driver for Himax hx83112b touchscreen devices
Message-ID: <CNKVTNMGW8B6.2H4V2JKJ6Q3CO@ancom>
In-Reply-To: <Y0d5MNtieyJSaidq@nixie71>
References: <20221012202341.295351-1-job@noorman.info> <20221012202341.295351-3-job@noorman.info> <Y0d5MNtieyJSaidq@nixie71>
Feedback-ID: 14439221:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

Thanks for the extensive review!

I've addressed most of your comments. I will reply below to the ones I
have not yet addressed, or have questions about. You can consider the
comments I don't reply to as addressed in the next version.

On Thu Oct 13, 2022 at 4:34 AM CEST, Jeff LaBundy wrote:
> That being said, use of dev_err_probe() is generally frowned upon in
> the input subsystem and I tend to agree. The argument against it is
> that resources that may not be ready in time should be responsible for
> the housekeeping done in dev_err_probe() rather than every possible
> consumer doing so through every possible error path.
>
> I only mention this because you will likely be asked to change even
> the "valid" calls to dev_err_probe().

I have removed all uses of dev_err_probe(). I followed the approach I
saw in other drivers of only calling dev_err() when the error is not
-EPROBE_DEFER, and calling it unconditionally when this is not a
possible error. However, while I _think_ I managed to figure out for
which functions this can never be returned (based mostly on the Goodix
driver), I wouldn't mind if somebody could double-check this :)

> > +static bool himax_event_point_is_valid(const struct himax_event_point =
*point)
> > +{
> > +=09return himax_event_point_get_x(point) !=3D 0xffff &&
> > +=09       himax_event_point_get_y(point) !=3D 0xffff;
> > +}
>
> How about U16_MAX?

This feels strange to me because conceptually, I don't want to know if
these values are equal to the maximum u16 value, I want to know if they
are invalid coordinates. It's incidental that invalid values correspond
to U16_MAX.

I created a #define HIMAX_INVALID_COORD for this. Would you agree with
this approach?

> > +static irqreturn_t himax_irq_handler(int irq, void *dev_id)
> > +{
> > +=09struct himax_ts_data *ts =3D dev_id;
> > +
> > +=09himax_handle_input(ts);
>
> Is it accurate to assume that the act of reading the event status
> register(s) is what acknowledges the interrupt and de-asserts the
> interrupt pin?

I assume so but without datasheets this is impossible to know for sure
unfortunately. However, since this is the only interaction with the
device during an IRQ, I cannot imagine what else could cause the
de-assert.

> If so, I think it is safer to define himax_handle_input() with an
> integer return type, then return IRQ_NONE upon failure. If the I2C
> adapter goes south such that reads are never initiated and the pin
> is stuck low causing an interrupt storm, the handler would get cut
> off quickly.

Done! Two questions:
- Do you think it's necessary to return IRQ_NONE on a checksum failure?
- If I understand correctly, this means that once an error occurs, the
  driver becomes unusable. Would it make sense to try to reset the
  device after an error?

> Just for my own understanding, _when_ does the pin get de-asserted?
> Is it early in the I2C read, or after the stop condition? In case
> of the latter, consider a delay to prevent the interrupt from being
> immediately triggered once more after the handler has returned, but
> the pin hasn't quite returned to a logic-high level.

I don't know the answer to this question unfortunately. The downstream
driver doesn't seem to have any delay after reading the registers
though.

> > +=09error =3D himax_setup_gpio(ts);
> > +=09if (error)
> > +=09=09return error;
> > +
> > +=09himax_reset(ts);
>
> It looks like we're expecting an I2C read to occur directly after reset
> is de-asserted. Understanding that no datasheet is available to specify
> how much time the device takes to exit reset, does the downstream driver
> at least include some delay?

The downstream driver has a 20ms delay between asserting and
de-asserting, but not _after_ de-asserting. I have copied this behavior.

Here's the funny thing: the I2C read you're talking about (to read the
product id) happens _before_ the reset in the downstream driver and that
also seems to work...

So I'm not sure what to do here. It does feel safer to add an additional
delay so shall we just do that?

Kind regards,
Job

