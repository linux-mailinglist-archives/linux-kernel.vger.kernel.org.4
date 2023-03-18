Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9336BFBB8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 18:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjCRRDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 13:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjCRRDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 13:03:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A78AD09;
        Sat, 18 Mar 2023 10:02:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D990560C66;
        Sat, 18 Mar 2023 17:02:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F06C433EF;
        Sat, 18 Mar 2023 17:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679158978;
        bh=KHxVED5nH5P6SboF+WiSO3Dj8OBU4RTm7QZPLYx58EY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MDB6f0EqzpyonZ7mOJd+vW+3vjs8PNWbTePOCYJkNbEBnCAL4Sx+244cYFXS+re+m
         eJQgJUbn6yAqyAOk0OV9Ve7tEX7oZWx9eVIkxb1FoGPtfWGUKM8hNxC+pyq6zkjeOV
         5BGkQE3xiUMdOcHC5nsk4pHQV9UQAzYdwC8vkMG7yIrBnVqc4XqUrolUx+D3PQHCOF
         NeENLULOngs7QXS5nDljb7vSOLQmDyN8IcIqsYd4XTrfWJ5RJtMxXE9rLSXUVy/txZ
         rPnxSQFQ8s4GtXJYQguth9IAYqFPpQvCS8QU+OKYR3/id1QB1LAAgNhXtp3oe/KpVw
         6l6WUrU7ACc2A==
Date:   Sat, 18 Mar 2023 17:17:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] iio: light: Add gain-time-scale helpers
Message-ID: <20230318171751.75911d26@jic23-huawei>
In-Reply-To: <d2986a9e-c516-ea6d-8f94-5cd4723312bd@fi.rohmeurope.com>
References: <cover.1678093787.git.mazziesaccount@gmail.com>
        <a4cb9a34ca027867ac014ffe93ca7e8245ce263f.1678093787.git.mazziesaccount@gmail.com>
        <ZAXiKfRbsXpHhwAJ@smile.fi.intel.com>
        <20230312165100.45de0c9b@jic23-huawei>
        <bad05e06-3b37-b435-bfac-962aef36cc97@gmail.com>
        <ZA8ho4YfhBkSMFxS@smile.fi.intel.com>
        <d2986a9e-c516-ea6d-8f94-5cd4723312bd@fi.rohmeurope.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2023 06:19:35 +0000
"Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com> wrote:

> On 3/13/23 15:14, Andy Shevchenko wrote:
> > On Mon, Mar 13, 2023 at 02:56:59PM +0200, Matti Vaittinen wrote:  
> >> On 3/12/23 18:51, Jonathan Cameron wrote:  
> >>> On Mon, 6 Mar 2023 14:52:57 +0200
> >>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:  
> >>>> On Mon, Mar 06, 2023 at 11:17:15AM +0200, Matti Vaittinen wrote:  
> > 
> > ...
> >   
> >>>>> +EXPORT_SYMBOL_NS_GPL(iio_gts_total_gain_to_scale, IIO_GTS_HELPER);  
> >>>>
> >>>> I would say _HELPER part is too much, but fine with me.  
> >>>
> >>> Hmm. I think I like the HELPER bit as separates it from being a driver.
> >>> Of course I might change my mind after a few sleeps.  
> >>
> >> Ever considered a career as a politician? ;) (No offense intended - and feel
> >> free to change your mind on this. I don't expect this to be done tomorrow)  
> > 
> > It will be a one liner in the provider if you use DEFAULT_SYMBOL_NAMESPACE
> > definition.  
> 
> Oh. I didn't know about DEFAULT_SYMBOL_NAMESPACE - or if I did, I had 
> forgot it. My memory has never been great and seems to be getting worse 
> all the time...

> 
> I don't know what to think of this define though. I can imagine that 
> someone who is not familiar with it could be very confused as to why the 
> symbols are not found even though EXPORT_SYMBOL or EXPORT_SYMBOL_GPL are 
> used. OTOH, I think I once saw an error about symbols being in a 
> namespace (when trying to use one without the namespace). This should 
> probably just be a good enough hint for finding out what's going on.
> 
> Luckily, I think all the exports in this case were oneliners even with 
> the namespace explicitly spelled. Well, I think that for one or two 
> exports the semicolon did slip to col 81 or 82 - but I am not sure if 
> fixing this weighs more than the clarity of explicitly showing the 
> namespace in export.
> 
> Well, I guess I can go with either of these ways - do you have a strong 
> opinion on using the DEFAULT_SYMBOL_NAMESPACE?
> 

If it's in the C file, then I can cope with doing it this way.
Don't do it in the compiler options though.  That got ripped out of CXL
because it was considered a bad idea to hide the namespace away like that.

Personally I prefer the namespace of the symbols explicit in each export
as they are easy to find that way.


> 
> Yours,
> 	--Matti
> 

