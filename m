Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D5573B2CD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjFWIiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 04:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjFWIio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:38:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9111B4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 01:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687509481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ptejR8lbUvAso4nSZTEHuxuZqlk7XN4zpapla+ipUe8=;
        b=b2hrh6v5WFHkyGvuPNyh9sNqvaBROayd+QDMhkq7aQb2lvLRM6t6kvgTPodUOu1NuH0k62
        Wsm0JzBZGcQ+Myz8vUY5gtgotmJoXa0FvtsEBxiOxdfN+FsKfhoOi5UaBHJ13DKKrU2E5D
        Gs4KYmxen3IjxUG7R3npedw8hvLTz3o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-9IRqxVdFPPmco9PIfXr3bQ-1; Fri, 23 Jun 2023 04:37:53 -0400
X-MC-Unique: 9IRqxVdFPPmco9PIfXr3bQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D49978CC202;
        Fri, 23 Jun 2023 08:37:52 +0000 (UTC)
Received: from mail.corp.redhat.com (unknown [10.45.225.205])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4050740C6CD1;
        Fri, 23 Jun 2023 08:37:51 +0000 (UTC)
Date:   Fri, 23 Jun 2023 10:37:48 +0200
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Filipe =?utf-8?B?TGHDrW5z?= <lains@riseup.net>,
        Bastien Nocera <hadess@hadess.net>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-hidpp: rework one more time the retries
 attempts
Message-ID: <qbvmv3eexohswyagmllfh3xsxoftwa3wbmsdafmwak2bxlnlft@jz74dijlfxlz>
References: <20230621-logitech-fixes-v1-1-32e70933c0b0@redhat.com>
 <2023062156-trespass-pandemic-7f4f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023062156-trespass-pandemic-7f4f@gregkh>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Jun 21 2023, Greg KH wrote:
> 
> On Wed, Jun 21, 2023 at 11:42:30AM +0200, Benjamin Tissoires wrote:
> > Make the code looks less like Pascal.
> > 
> > Extract the internal code inside a helper function, fix the
> > initialization of the parameters used in the helper function
> > (`hidpp->answer_available` was not reset and `*response` wasn't too),
> > and use a `do {...} while();` loop.
> > 
> > Fixes: 586e8fede795 ("HID: logitech-hidpp: Retry commands when device is busy")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > ---
> > as requested by https://lore.kernel.org/all/CAHk-=wiMbF38KCNhPFiargenpSBoecSXTLQACKS2UMyo_Vu2ww@mail.gmail.com/
> > This is a rewrite of that particular piece of code.
> > ---
> >  drivers/hid/hid-logitech-hidpp.c | 102 +++++++++++++++++++++++----------------
> >  1 file changed, 61 insertions(+), 41 deletions(-)
> > 
> > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> > index dfe8e09a18de..3d1ffe199f08 100644
> > --- a/drivers/hid/hid-logitech-hidpp.c
> > +++ b/drivers/hid/hid-logitech-hidpp.c
> > @@ -275,21 +275,20 @@ static int __hidpp_send_report(struct hid_device *hdev,
> >  }
> >  
> >  /*
> > - * hidpp_send_message_sync() returns 0 in case of success, and something else
> > - * in case of a failure.
> > - * - If ' something else' is positive, that means that an error has been raised
> > - *   by the protocol itself.
> > - * - If ' something else' is negative, that means that we had a classic error
> > - *   (-ENOMEM, -EPIPE, etc...)
> > + * Effectively send the message to the device, waiting for its answer.
> > + *
> > + * Must be called with hidpp->send_mutex locked
> > + *
> > + * Same return protocol than hidpp_send_message_sync():
> > + * - success on 0
> > + * - negative error means transport error
> > + * - positive value means protocol error
> >   */
> > -static int hidpp_send_message_sync(struct hidpp_device *hidpp,
> > +static int __do_hidpp_send_message_sync(struct hidpp_device *hidpp,
> >  	struct hidpp_report *message,
> >  	struct hidpp_report *response)
> 
> __must_hold(&hidpp->send_mutex)  ?
> 

Good point. I'll add this in v2.

I'm still waiting for some feedback from the people who particpated in
the original BZ, but the new bug is harder to reproduce. Anyway, there
is no rush IMO.

Cheers,
Benjamin

