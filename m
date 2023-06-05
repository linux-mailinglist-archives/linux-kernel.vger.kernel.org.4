Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2817228B3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbjFEOVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbjFEOVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:21:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD399C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 07:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685974839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gqpkXp8U+cKSUgRdK1ANg0TMjc87TbEFrUC0Wy67524=;
        b=KgPRFx9EdRK2XOdlYbjrfmU4kt6XxDm1kmGseNd/GVEaQEiYqX/P3B4dCeQZ9vL6uCgfaO
        sOMjGKg1EbVmeqAFGpV/lg98p8SpQqAPbnwXDQYDveNIFclHg8WvgHllIcsrfjoIDoyqqv
        gZ84+iQuc159/eMjJSMsXaapzCPvD4U=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-70-6RP4HyK-PuiLqhXNeBlvBQ-1; Mon, 05 Jun 2023 10:20:36 -0400
X-MC-Unique: 6RP4HyK-PuiLqhXNeBlvBQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 832E838025FE;
        Mon,  5 Jun 2023 14:20:35 +0000 (UTC)
Received: from mail.corp.redhat.com (unknown [10.45.225.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 739E01121315;
        Mon,  5 Jun 2023 14:20:33 +0000 (UTC)
Date:   Mon, 5 Jun 2023 16:20:30 +0200
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Mark Lord <mlord@pobox.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        Filipe =?utf-8?B?TGHDrW5z?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: [PATCH] HID: logitech-hidpp: Handle timeout differently from busy
Message-ID: <jafrw2wirzegnf7v2pcm52sao5yc4futa7ok4ccmywigj3y2c4@pep4b3ebus7s>
References: <20230531082428.21763-1-hadess@hadess.net>
 <nycvar.YFH.7.76.2305311606160.29760@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2306031440380.29760@cbobk.fhfr.pm>
 <ccae168a-4be0-f085-8d8e-03bfbd71ac8f@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccae168a-4be0-f085-8d8e-03bfbd71ac8f@pobox.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Jun 03 2023, Mark Lord wrote:
> 
> On 2023-06-03 08:41 AM, Jiri Kosina wrote:
> > On Wed, 31 May 2023, Jiri Kosina wrote:
> > 
> >>> If an attempt at contacting a receiver or a device fails because the
> >>> receiver or device never responds, don't restart the communication, only
> >>> restart it if the receiver or device answers that it's busy, as originally
> >>> intended.
> >>>
> >>> This was the behaviour on communication timeout before commit 586e8fede795
> >>> ("HID: logitech-hidpp: Retry commands when device is busy").
> >>>
> >>> This fixes some overly long waits in a critical path on boot, when
> >>> checking whether the device is connected by getting its HID++ version.
> >>>
> >>> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> >>> Suggested-by: Mark Lord <mlord@pobox.com>
> >>> Fixes: 586e8fede795 ("HID: logitech-hidpp: Retry commands when device is busy")
> >>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217412
> >>> ---
> >>>  drivers/hid/hid-logitech-hidpp.c | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> >>> index 0fcfd85fea0f..2246044b1639 100644
> >>> --- a/drivers/hid/hid-logitech-hidpp.c
> >>> +++ b/drivers/hid/hid-logitech-hidpp.c
> >>> @@ -314,6 +314,7 @@ static int hidpp_send_message_sync(struct hidpp_device *hidpp,
> >>>  			dbg_hid("%s:timeout waiting for response\n", __func__);
> >>>  			memset(response, 0, sizeof(struct hidpp_report));
> >>>  			ret = -ETIMEDOUT;
> >>> +			goto exit;
> >>>  		}
> >>>  
> >>
> >> I have applied this even before getting confirmation from the reporters in 
> >> bugzilla, as it's the right thing to do anyway.
> > 
> > Unfortunately it doesn't seem to cure the reported issue (while reverting 
> > 586e8fede79 does): https://bugzilla.kernel.org/show_bug.cgi?id=217523#c2
> 
> I wonder if this code could be re-worked to not even do this (waiting)
> from the _probe() function?  It ought to be able to throw it on a workqueue
> or something, rather than stalling system boot for a minimum of 5-seconds
> (or much longer as as-is).

That's an option, but the fact that I can not replicate locally with the
exact same hardware seems to indicate that we would just be papering
over the issue.

Here, I admittely have the USB receiver running through USB-C ports, and
the communication never fails and I get immediate bring ups of the
devices. Which means I am not hitting that path.

The hidpp driver should have everything ready to delay the init in a
workqueue, but the impacted users would still get a delay when they plug
in the device (which is better than stalling the boot, I agree).

Cheers,
Benjamin

