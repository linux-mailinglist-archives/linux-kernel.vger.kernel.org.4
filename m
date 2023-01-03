Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694B665BD9F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjACKFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbjACKFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:05:42 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D962AC1;
        Tue,  3 Jan 2023 02:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1672740326; bh=mbJPsA4UDzDHjFi3vHuznbJvnwuV6TpmkKB2pWQH7KI=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=h5rr47Do9/K9HgrgcJReCWc2VQnHaWLaGQUJzyhtPrh+j4PiKlaJPcSwLnZnwK/8W
         oDE+/Y+tiPkhYz3twYLaTCTXaPn1p/ChbIcyhE+butNq/q/tyO0MZR8ZFsCVlfR8va
         MgIkYuyE5dlBTBg33qiaJz2m5ckV43g9LaKTsY7U=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue,  3 Jan 2023 11:05:26 +0100 (CET)
X-EA-Auth: NWGOiTN8/a9U6L2da4zFkljN32D3PAKpjqUOxmBnNMRIyLGwe7HRfPX9VWV1/c/hVHp+27ccTDNeG4gONjBSjqot74kdHD3V
Date:   Tue, 3 Jan 2023 15:35:15 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH v4 1/2] tty: serial: dz: convert atomic_* to refcount_*
 APIs for map_guard
Message-ID: <Y7P926/+N9IDKCyR@qemulion>
References: <cover.1671898144.git.drv@mailo.com>
 <d85c7441b96ce387d9010142efc3469d53b6aedc.1671898144.git.drv@mailo.com>
 <e42d5d19-7ed5-468b-98cc-13d0187dc555@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e42d5d19-7ed5-468b-98cc-13d0187dc555@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 09:59:52AM +0100, Jiri Slaby wrote:
> On 26. 12. 22, 7:21, Deepak R Varma wrote:
> > The refcount_* APIs are designed to address known issues with the
> > atomic_t APIs for reference counting. They provide following distinct
> > advantages
> >     - protect the reference counters from overflow/underflow
> >     - avoid use-after-free errors
> >     - provide improved memory ordering guarantee schemes
> >     - neater and safer.
>
> Really? (see below)
>
> > --- a/drivers/tty/serial/dz.c
> > +++ b/drivers/tty/serial/dz.c
> ...
> > @@ -687,23 +686,19 @@ static int dz_map_port(struct uart_port *uport)
> >   static int dz_request_port(struct uart_port *uport)
> >   {
> >   	struct dz_mux *mux = to_dport(uport)->mux;
> > -	int map_guard;
> >   	int ret;
> >
> > -	map_guard = atomic_add_return(1, &mux->map_guard);
> > -	if (map_guard == 1) {
> > -		if (!request_mem_region(uport->mapbase, dec_kn_slot_size,
> > -					"dz")) {
> > -			atomic_add(-1, &mux->map_guard);
> > -			printk(KERN_ERR
> > -			       "dz: Unable to reserve MMIO resource\n");
> > +	refcount_inc(&mux->map_guard);
> > +	if (refcount_read(&mux->map_guard) == 1) {
>
> This is now racy, right?

Hello Jiri,
Thank you for the feedback. You are correct. I have split a single instruction
in two (or more?) instructions potentially resulting in race conditions. I
looked through the refcount_* APIs but did not find a direct match.


Can you please comment if the the following variation will avoid race condition?

	if (!refcount_add_not_zero(1, &mux->map_guard)) {
		refcount_inc(&mux->map_guard);
		...
	}

Here, refcount_add_not_zero would return false if &mux->map_guard is already 0.
Which means, incrementing it by 1 would have met the earlier if evaluation.
Whereas, if &mux->map_guard is something other than 0, refcount_add_not_zero
will increment it by 1 and return true, in which case the if condition will
fail, similar to the previous if evaluation.

Hope that helps clarify my revised thought. Can you please let me know if this
revision looks safe?

Thank you,
./drv



>
> thanks,
> --
> js
> suse labs
>


