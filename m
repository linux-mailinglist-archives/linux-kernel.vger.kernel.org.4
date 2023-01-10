Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215876656C7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjAKI7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 03:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236462AbjAKI6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:58:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD6E11C05
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 00:58:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C170161AF8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5BCC433EF;
        Wed, 11 Jan 2023 08:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673427492;
        bh=JPRSYFyEg5h2qZKN+L6vUHL8dBDH2z4OMH2CXAsIkI4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vx9LTGzKTSSRAnYVLCCG+mCfUkpNf2vRPjj0lSBah5lznIrnOKuZtQ7yLP3fMS6aI
         RysEXadKlFzf3q1xoRHvugyA5pTv7ip+AK1Eh7UtEYc0hjJF3vK7sbvPy/7gGlPEz0
         nfcpWqn36e1d2wNXXlC13AE8JpmYgk4XxFUcoN8Q=
Date:   Tue, 10 Jan 2023 19:09:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/2] driver core: bus.h: document bus notifiers better
Message-ID: <Y72px6jhwCC1TiQF@kroah.com>
References: <20230110145303.2087563-1-gregkh@linuxfoundation.org>
 <968101fe-2306-dbef-81f1-6b5864778b7a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <968101fe-2306-dbef-81f1-6b5864778b7a@infradead.org>
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 09:03:52AM -0800, Randy Dunlap wrote:
> Hi Greg,
> 
> On 1/10/23 06:53, Greg Kroah-Hartman wrote:
> > The bus notifier values are not documented all that well, so clean this
> > up and make a real enumerated type for them and document them much
> > better.  Also change the values from being in hex to just decimal as it
> > didn't make any sense to have them in hex.
> > 
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > v2: move the values to decimal from hex as pointed out by Rafael.
> > 
> >  include/linux/device/bus.h | 43 +++++++++++++++++++++++++-------------
> >  1 file changed, 29 insertions(+), 14 deletions(-)
> > 
> > diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> > index d529f644e92b..fbec1c7c34c0 100644
> > --- a/include/linux/device/bus.h
> > +++ b/include/linux/device/bus.h
> > @@ -257,21 +257,36 @@ extern int bus_register_notifier(struct bus_type *bus,
> >  extern int bus_unregister_notifier(struct bus_type *bus,
> >  				   struct notifier_block *nb);
> >  
> > -/* All 4 notifers below get called with the target struct device *
> > - * as an argument. Note that those functions are likely to be called
> > - * with the device lock held in the core, so be careful.
> 
> If you want this to be kernel-doc format with no warnings,
> (a) all of the " * BUS_NOTIFY_..." lines should be " * @BUS_NOTIFY_...";
> (b) all of the " * @BUS_NOTIFY_..." lines should be immediately after the
> second ("enum") line. (at [1])
> (c) In the heading "enum" line, s/: / - /, but that's just for consistency
> and to follow kernel-doc documented format; it seems that kernel-doc takes
> that separator either way.
> 
> The patch below (on top of this one) makes all of these changes.

Ah, thank you so much for that, I'll merge your changes into here, and
also drop the explicit values for the enums as that really does not
matter at all.

thanks,

greg k-h
