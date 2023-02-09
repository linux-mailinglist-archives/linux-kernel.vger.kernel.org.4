Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B287D690D93
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjBIPut convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Feb 2023 10:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjBIPup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:50:45 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF09F6A4D;
        Thu,  9 Feb 2023 07:50:31 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 67AD0100005;
        Thu,  9 Feb 2023 15:50:28 +0000 (UTC)
Message-ID: <8b5b5954dac10226b243df931ff7ce75df1e21e6.camel@hadess.net>
Subject: Re: [PATCH v2 2/3] HID: logitech-hidpp: Retry commands when device
 is busy
From:   Bastien Nocera <hadess@hadess.net>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Date:   Thu, 09 Feb 2023 16:50:27 +0100
In-Reply-To: <20230209145050.54ewn3zhjneium2h@mail.corp.redhat.com>
References: <20230206221256.129198-1-hadess@hadess.net>
         <20230206221256.129198-2-hadess@hadess.net>
         <20230209145050.54ewn3zhjneium2h@mail.corp.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-02-09 at 15:50 +0100, Benjamin Tissoires wrote:
> On Feb 06 2023, Bastien Nocera wrote:
> > Handle the busy error coming from the device or receiver. The
> > documentation says a busy error can be returned when:
> > "
> > Device (or receiver) cannot answer immediately to this request
> > for any reason i.e:
> > - already processing a request from the same or another SW
> > - pipe full
> > "
> > 
> > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > ---
> > 
> > Same as v1
> > 
> >  drivers/hid/hid-logitech-hidpp.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-
> > logitech-hidpp.c
> > index 1952d8d3b6b2..9e94026de437 100644
> > --- a/drivers/hid/hid-logitech-hidpp.c
> > +++ b/drivers/hid/hid-logitech-hidpp.c
> > @@ -295,6 +295,7 @@ static int hidpp_send_message_sync(struct
> > hidpp_device *hidpp,
> >          */
> >         *response = *message;
> >  
> > +retry:
> >         ret = __hidpp_send_report(hidpp->hid_dev, message);
> >  
> >         if (ret) {
> > @@ -321,6 +322,10 @@ static int hidpp_send_message_sync(struct
> > hidpp_device *hidpp,
> >                         response->report_id ==
> > REPORT_ID_HIDPP_VERY_LONG) &&
> >                         response->fap.feature_index ==
> > HIDPP20_ERROR) {
> >                 ret = response->fap.params[1];
> > +               if (ret == HIDPP20_ERROR_BUSY) {
> > +                       dbg_hid("%s:got busy hidpp 2.0 error %02X,
> > retrying\n", __func__, ret);
> > +                       goto retry;
> 
> I must confess, I blocked a little bit there to decide whether or not
> using goto here was OK.
> 
> But then I reliazed that there is no way to leave that function if
> the
> device is buggy and constantly sends back ERROR_BUSY. So I am not
> very
> found of the idea of having that got after all.
> 
> Would you mind respinning that patch with a bounded loop for the
> retries
> instead of using a goto? I'd like the driver to give up after a few
> retries if the device is not fair.

Done in v3.
