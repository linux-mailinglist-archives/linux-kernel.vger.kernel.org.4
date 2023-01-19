Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA620674B4E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjATEvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjATEu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:50:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFBBBFF40
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 20:43:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F31C0B8270A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 19:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52963C433F0;
        Thu, 19 Jan 2023 19:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674155894;
        bh=4gNZacUVu7Qe2Z2/07/8mXyL5AH7AsaHEp2psjaXZUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z3pFPo2iBQ2puU/Wzg/SlUhsvygxszIrdglZCdyOZGM5ZJF3JjDJ3Y5oPAd6gcGjf
         OpvZa1H3tq/LTua4sr8EhBg3/E06G7WPm1m0/BrZ07wveUy6rEvQ04z5SGUT02jNQT
         QGki7K+IWMbGSFIUsxo/RNpA9IWDlyJdMNYvv1io=
Date:   Thu, 19 Jan 2023 20:18:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com, Andi Kleen <ak@linux.intel.com>,
        Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 1/6] virtio console: Harden multiport against invalid
 host input
Message-ID: <Y8mXdFms3CzPnW+6@kroah.com>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-2-alexander.shishkin@linux.intel.com>
 <Y8lfHKz08EVeNa5o@kroah.com>
 <87fsc6qrvx.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsc6qrvx.fsf@ubik.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 08:52:02PM +0200, Alexander Shishkin wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > On Thu, Jan 19, 2023 at 03:57:16PM +0200, Alexander Shishkin wrote:
> >> From: Andi Kleen <ak@linux.intel.com>
> >> 
> >> --- a/drivers/char/virtio_console.c
> >> +++ b/drivers/char/virtio_console.c
> >> @@ -1843,6 +1843,9 @@ static int init_vqs(struct ports_device *portdev)
> >>  	int err;
> >>  
> >>  	nr_ports = portdev->max_nr_ports;
> >> +	if (use_multiport(portdev) && nr_ports < 1)
> >> +		return -EINVAL;
> >> +
> >>  	nr_queues = use_multiport(portdev) ? (nr_ports + 1) * 2 : 2;
> >>  
> >>  	vqs = kmalloc_array(nr_queues, sizeof(struct virtqueue *), GFP_KERNEL);
> >> -- 
> >> 2.39.0
> >> 
> >
> > Why did I only get a small subset of these patches?
> 
> I did what get_maintainer told me. Would you like to be CC'd on the
> whole thing?

If you only cc: me on a portion of the series, I guess you only want me
to apply a portion of it?  if so, why is it a longer series?

> > And why is the whole thread not on lore.kernel.org?
> 
> That is a mystery, some wires got crossed between my smtp and vger. I
> bounced the series to lkml just now and at least some of it seems to
> have landed on lore.
> 
> > And the term "hardening" is marketing fluff.   Just say, "properly parse
> > input" or something like that, as what you are doing is fixing
> > assumptions about the data here, not causing anything to be more (or
> > less) secure.
> >
> > But, this still feels wrong.  Why is this happening here, in init_vqs()
> > and not in the calling function that already did a bunch of validation
> > of the ports and the like?  Are those checks not enough?  if not, fix it
> > there, don't spread it out all over the place...
> 
> Good point! And there happens to already be 28962ec595d70 that takes
> care of exactly this case. I totally missed it.

So this series is not needed?  Or just this one?

greg k-h
