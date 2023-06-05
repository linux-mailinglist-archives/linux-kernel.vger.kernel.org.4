Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CD87228C7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbjFEO17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbjFEO1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:27:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEA09B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 07:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685975229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VqvDjKPajBQJ0jhTbAvNmVVCOt81m2LxIym/sZ9cqd8=;
        b=Hd+vkI3+KLRTGdmsqfnoa+kNkXasHXHn4xsCV0+QxKEeR9a8yR4Hv7wk/fkWefhoM3bDMP
        fjc8KWtewJsE3jaIPB4yKSUKSehzcH/Hx7gL2N0SN343RWFp+Nkc8doxXs5lM0oVaWqdtg
        oRbp9FqXTiyuMoMQt0DbEBoeH46OxXk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-O_8wkhTTOjSn0hsnxZkI9w-1; Mon, 05 Jun 2023 10:27:08 -0400
X-MC-Unique: O_8wkhTTOjSn0hsnxZkI9w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC0D48030CD;
        Mon,  5 Jun 2023 14:27:05 +0000 (UTC)
Received: from mail.corp.redhat.com (unknown [10.45.225.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 04BE84A927E;
        Mon,  5 Jun 2023 14:27:03 +0000 (UTC)
Date:   Mon, 5 Jun 2023 16:27:01 +0200
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        Filipe =?utf-8?B?TGHDrW5z?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        Mark Lord <mlord@pobox.com>
Subject: Re: [PATCH] HID: logitech-hidpp: Handle timeout differently from busy
Message-ID: <7ko33em3pqdaeghkt6wumzks6fz2lzztmqyhyzvv3kisjovmvr@mojlmkmrqlml>
References: <20230531082428.21763-1-hadess@hadess.net>
 <nycvar.YFH.7.76.2305311606160.29760@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2306031440380.29760@cbobk.fhfr.pm>
 <15bb2507-a145-7f1b-8e84-58aeb02484b9@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15bb2507-a145-7f1b-8e84-58aeb02484b9@leemhuis.info>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Jun 05 2023, Linux regression tracking (Thorsten Leemhuis) wrote:
> 
> On 03.06.23 14:41, Jiri Kosina wrote:
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
> > [...]  
> >>
> >> I have applied this even before getting confirmation from the reporters in 
> >> bugzilla, as it's the right thing to do anyway.
> > 
> > Unfortunately it doesn't seem to cure the reported issue (while reverting 
> > 586e8fede79 does):
> 
> BTW, remind me again: was fixing this by reverting 586e8fede79 for now a
> option? I guess it's not, but if I'm wrong I wonder if that might at
> this point be the best way forward.

Could be. I don't think we thought at simply reverting it because it is
required for some new supoprted devices because they might differ
slightly from what we currently supported.

That being said, Bastien will be unavailable for at least a week AFAIU,
so maybe we should revert that patch.

> 
> > https://bugzilla.kernel.org/show_bug.cgi?id=217523#c2
> 
> FWIW, another comment showed up there:
> 
> ```
> > --- Comment #6 from vova7890 ---
> > Same problem. I researched this some time ago. I noticed that if I add a small
> > delay between commands to the dongle - everything goes fine. Repeated
> > request(586e8fede7953b1695b5ccc6112eff9b052e79ac) made the situation more
> > visible

I don't think I ever had to add any delays between commands. The USB
stack should be capable of forwarding the commands just fine. So unless
the receiver is of a different hardware (but same VID/PID) that might
expose a problem elsewhere (in the USB controller maybe???). Just a long
shot, but maybe getting the config of the impacted users and what are
the USB controllers/drivers they are using might gives us a better
understanding.

Cheers,
Benjamin

