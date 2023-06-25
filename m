Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C05173CF5E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 10:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjFYIaJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 25 Jun 2023 04:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjFYIaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 04:30:05 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF91D3;
        Sun, 25 Jun 2023 01:30:03 -0700 (PDT)
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 544BA20002;
        Sun, 25 Jun 2023 08:30:00 +0000 (UTC)
Message-ID: <31ce32e018a9fa410e9e1f3e5900621b16a56091.camel@hadess.net>
Subject: Re: [PATCH] HID: logitech-hidpp: rework one more time the retries
 attempts
From:   Bastien Nocera <hadess@hadess.net>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date:   Sun, 25 Jun 2023 10:29:59 +0200
In-Reply-To: <qbvmv3eexohswyagmllfh3xsxoftwa3wbmsdafmwak2bxlnlft@jz74dijlfxlz>
References: <20230621-logitech-fixes-v1-1-32e70933c0b0@redhat.com>
         <2023062156-trespass-pandemic-7f4f@gregkh>
         <qbvmv3eexohswyagmllfh3xsxoftwa3wbmsdafmwak2bxlnlft@jz74dijlfxlz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-06-23 at 10:37 +0200, Benjamin Tissoires wrote:
> 
> On Jun 21 2023, Greg KH wrote:
> > 
> > On Wed, Jun 21, 2023 at 11:42:30AM +0200, Benjamin Tissoires wrote:
> > > Make the code looks less like Pascal.
> > > 
> > > Extract the internal code inside a helper function, fix the
> > > initialization of the parameters used in the helper function
> > > (`hidpp->answer_available` was not reset and `*response` wasn't
> > > too),
> > > and use a `do {...} while();` loop.
> > > 
> > > Fixes: 586e8fede795 ("HID: logitech-hidpp: Retry commands when
> > > device is busy")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > ---
> > > as requested by
> > > https://lore.kernel.org/all/CAHk-=wiMbF38KCNhPFiargenpSBoecSXTLQACKS2UMyo_Vu2ww@mail.gmail.com/
> > > This is a rewrite of that particular piece of code.
> > > ---
> > >  drivers/hid/hid-logitech-hidpp.c | 102 +++++++++++++++++++++++--
> > > --------------
> > >  1 file changed, 61 insertions(+), 41 deletions(-)
> > > 
> > > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-
> > > logitech-hidpp.c
> > > index dfe8e09a18de..3d1ffe199f08 100644
> > > --- a/drivers/hid/hid-logitech-hidpp.c
> > > +++ b/drivers/hid/hid-logitech-hidpp.c
> > > @@ -275,21 +275,20 @@ static int __hidpp_send_report(struct
> > > hid_device *hdev,
> > >  }
> > >  
> > >  /*
> > > - * hidpp_send_message_sync() returns 0 in case of success, and
> > > something else
> > > - * in case of a failure.
> > > - * - If ' something else' is positive, that means that an error
> > > has been raised
> > > - *   by the protocol itself.
> > > - * - If ' something else' is negative, that means that we had a
> > > classic error
> > > - *   (-ENOMEM, -EPIPE, etc...)
> > > + * Effectively send the message to the device, waiting for its
> > > answer.
> > > + *
> > > + * Must be called with hidpp->send_mutex locked
> > > + *
> > > + * Same return protocol than hidpp_send_message_sync():
> > > + * - success on 0
> > > + * - negative error means transport error
> > > + * - positive value means protocol error
> > >   */
> > > -static int hidpp_send_message_sync(struct hidpp_device *hidpp,
> > > +static int __do_hidpp_send_message_sync(struct hidpp_device
> > > *hidpp,
> > >         struct hidpp_report *message,
> > >         struct hidpp_report *response)
> > 
> > __must_hold(&hidpp->send_mutex)  ?
> > 
> 
> Good point. I'll add this in v2.
> 
> I'm still waiting for some feedback from the people who particpated
> in
> the original BZ, but the new bug is harder to reproduce. Anyway,
> there
> is no rush IMO.

The problem is only ever going to show up in very limited circumstances
after the logic fix was applied.

You need a hardware problem (such as the controller being too busy to
answer) to trigger the problems fixed by this patch. I don't see a way
to reliably reproduce it unless you inject that hardware error.
