Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22E369F00F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 09:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjBVIVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 03:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjBVIVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 03:21:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2DD34311
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 00:21:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D8B4B811D5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 08:20:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8063AC433EF;
        Wed, 22 Feb 2023 08:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677054058;
        bh=y4q2XaRTMmmPkHbUg0S8e9odPVHc6zadXkk5qQEzCbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J/TMoNls/A2eSxNgWp3MpvMJfZf/dQkTU9kBQr0gn0RQHN5goCM3BISNO6EbzIL/0
         HMbaWeA04gjk08vWpvPc6qtEbHMbpafC6BijbtrlBaf+sAhtivRTer0E0haDHYvxez
         6aHCNGdyAeh4HcjCBvP3pR8jgVWaXUHlHX92R8J0=
Date:   Wed, 22 Feb 2023 09:20:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hyunwoo Kim <imv4bel@gmail.com>,
        Harald Welte <laforge@gnumonks.org>,
        linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v3] char: pcmcia: cm4000_cs: Fix use-after-free in
 cm4000_fops
Message-ID: <Y/XQZieM6uFrQo8r@kroah.com>
References: <20220919040701.GA302806@ubuntu>
 <63030af8-5849-34b3-10e6-b6ce32c3a5bf@kernel.org>
 <c5b39544-a4fb-4796-a046-0b9be9853787@app.fastmail.com>
 <b9d36537-bc94-71e5-a967-cd4cec50baf2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9d36537-bc94-71e5-a967-cd4cec50baf2@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 08:53:22AM +0100, Jiri Slaby wrote:
> On 21. 02. 23, 13:43, Arnd Bergmann wrote:
> > On Tue, Feb 21, 2023, at 07:51, Jiri Slaby wrote:
> > > Ping -- what's the status of these?
> > > 
> > > Should we mark cm4000_cs, cm4040_cs, and scr24x_cs as BROKEN instead?
> > 
> > A few bug fixes ago, I think we had all agreed that the drivers can
> > just be removed immediately, without a grace period or going through
> > drivers/staging [1]. We just need someone to send the corresponding
> > patches.
> > 
> > While looking for those, I see that Dominik also asked the
> > broader question about PCMCIA drivers in general [2] (sorry
> > I missed that thread at the time), and Linus just merged my
> > boardfile removal patches that ended up dropping half of the
> > (arm32) soc or board specific socket back end drivers.
> > 
> > Among the options that Dominik proposed in that email, I would
> > prefer we go ahead with b) and remove most of the drivers that
> > have no known users. I think we can be more aggressive though,
> > as most of the drivers that are listed as 'some activity in
> > 2020/21/22' seem to only be done to fix the same issues that
> > were found in ISA or PCI drivers.
> 
> So let me start with removal of all (both + and -) listed[2]
> drivers/char/pcmcia/ drivers. That includes all three racy/buggy ones. And
> let's see what happens.

I will GLADLY take these removal patches, please, send them on!  :)

thanks,

greg k-h
