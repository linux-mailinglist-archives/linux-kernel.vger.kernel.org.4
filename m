Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A7E6F32B2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 17:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjEAPRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 11:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjEAPQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 11:16:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586501BF;
        Mon,  1 May 2023 08:16:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC82760FD3;
        Mon,  1 May 2023 15:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9BFC433D2;
        Mon,  1 May 2023 15:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682954217;
        bh=LpECftVE9KrT4n55028aVO+n106qL95yHFBeSc9ipKw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CcTq7vns4wZeaAlzjrEY3dJq/98UkrxA49S7Mdg00g2ED6V/3VxENuIsCiZzKBwnQ
         +mOgIqQpYMBn5kFeqA2haveJsqWByuOqTgC2Sie/THhlXIQPmWbJESpf8VL08GQVsh
         BNwcGRaznz0cYJuHD322iP6H+e5SI59NN9NS00Gha5rgBetkfkLl25BoZMBW0KG9Li
         16Hfiii4jCSLaLnDNTvfm3qt0ZWgy2DtENjR1Z/VmL1QwnB/W14Z55aE8msqLPN3GT
         QsjV0GfYSGExx4pjsLntnpVL2QkRQ4vuXwJHP8WOI/t0On5wTfj9tjYhZbWSc3BXf1
         cJml4KrRKkI/A==
Date:   Mon, 1 May 2023 16:32:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] iio: light: ROHM BU27008 color sensor
Message-ID: <20230501163242.62b5bc97@jic23-huawei>
In-Reply-To: <91494388-9d2e-6cd6-9731-aea18271260b@fi.rohmeurope.com>
References: <cover.1682067567.git.mazziesaccount@gmail.com>
        <28ace0e26267df5618fbd23625425292391ad7f0.1682067567.git.mazziesaccount@gmail.com>
        <20230423135706.008206da@jic23-huawei>
        <91494388-9d2e-6cd6-9731-aea18271260b@fi.rohmeurope.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2023 06:21:23 +0000
"Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com> wrote:

> On 4/23/23 15:57, Jonathan Cameron wrote:
> > On Fri, 21 Apr 2023 12:39:36 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> The ROHM BU27008 is a sensor with 5 photodiodes (red, green, blue, clear
> >> and IR) with four configurable channels. Red and green being always
> >> available and two out of the rest three (blue, clear, IR) can be
> >> selected to be simultaneously measured. Typical application is adjusting
> >> LCD backlight of TVs, mobile phones and tablet PCs.
> >>
> >> Add initial support for the ROHM BU27008 color sensor.
> >>   - raw_read() of RGB and clear channels
> >>   - triggered buffer w/ DRDY interrtupt
> >>
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>  
> > 
> > Hi Matti,
> > 
> > Biggest issue in here is some confusion over data packing when some channels
> > are enabled.  The driver must pack the channels that are enabled (seen
> > from active_scan_mask) according to general IIO rules.  So naturally aligned
> > buffers.  Thus for this device it should always be packed into
> > 
> > struct scan {
> > 	__le16 chans[4];
> > 	s64 ts __aligned(8); /*it's aligned anyway but better not to make reviewers think ;) */
> > };
> > 
> > Even though there are 5 possible channels.  If one in the middle isnt' enabled (e.g. blue)
> > then clear and IR shift to lower words. of the buffer.  
> 
> Ah, right. So I had misunderstood how the buffer works. I thought the 
> scan_mask was only used to disallow unsupported channel-enabling 
> configurations. If I understand your statement correctly, the scan_mask 
> is used to determine the 'place of data' in the buffer when certain 
> configuration is used. (I'll check this from the code but if the IIO 
> handles data as I now think - that's cool! It should indeed simplify the 
> buffer in driver side!).

'Place' is a little confusing (English is imprecise sometimes).  Order
is perhaps more precise.

Place can mean same as order - as in 1st place in a race, but it can
also mean a specific location such as a place at a table where only
some seats are full.

The handling for this came about as part of the multiple consumer
support for SoC ADCs but it was also useful for ripping out a whole
load of driver specific handling that did similar repacking and letting
the generic code handle repacking data.  It is fairly optimal and
does things like larger memcpys if there are a set of channels
that need moving, and cleanly makes it a noop if there is nothing
to do at all.  All those tricks came IIRC from individual drivers
that had previously been doing this magic.

Jonathan



