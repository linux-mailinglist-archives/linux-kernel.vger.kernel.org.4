Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DECD642C34
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbiLEPpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbiLEPpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:45:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9756FC758;
        Mon,  5 Dec 2022 07:45:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F80A6116A;
        Mon,  5 Dec 2022 15:45:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F673C433D6;
        Mon,  5 Dec 2022 15:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670255109;
        bh=mwQrZYazPo/zTGa6o9BUoETFozZTAUE0m8JOQrpeE+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GMhyQZx+aq4MP/W+8pZ145QY+JTwdQjFGaWd+NOrVR3wyPu44IwwndGNOrXt+RuM3
         lzkuFTKdOcd0NqBATvTikpIuBBV1gTt4Kz/1J4FlJSjAZyJvQvV2lSUgLHy+XqNwix
         rTnWtOMgycMYlc2NYyqpFp69eaUVblG5mK610thc=
Date:   Mon, 5 Dec 2022 16:45:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Allen Webb <allenwebb@google.com>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 2/5] drivers: Add bus_for_each for iterating over the
 subsystems
Message-ID: <Y44SA2sY44mQ58OM@kroah.com>
References: <20221202224540.1446952-1-allenwebb@google.com>
 <20221202224744.1447448-1-allenwebb@google.com>
 <20221202224744.1447448-2-allenwebb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202224744.1447448-2-allenwebb@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 04:47:41PM -0600, Allen Webb wrote:
> In order to print the match-id-based modaliases it must be possible to
> reach the match id tables of each driver. With this function it becomes
> possible to iterate over each subsystem which can be paired with
> iterating over each driver.
> 
> Signed-off-by: Allen Webb <allenwebb@google.com>
> ---
>  drivers/base/bus.c         | 42 ++++++++++++++++++++++++++++++++++++++
>  include/linux/device/bus.h |  1 +
>  2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index 7ca47e5b3c1f4..4e0c5925545e5 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -178,6 +178,48 @@ static const struct kset_uevent_ops bus_uevent_ops = {
>  
>  static struct kset *bus_kset;
>  
> +/**
> + * bus_for_each - bus iterator.
> + * @start: bus to start iterating from.
> + * @data: data for the callback.
> + * @fn: function to be called for each device.
> + *
> + * Iterate over list of buses, and call @fn for each,
> + * passing it @data. If @start is not NULL, we use that bus to
> + * begin iterating from.


Where is there a list of all busses in the system?  This feels very odd.
A bus can list all devices on it, but busses have no relationship to
each other at all and are independent.

So to iterate over all busses in the system feels very wrong, and again,
a layering violation as that would allow non-dependant busses to poke
around in other busses.  Not something you want to do at all.

I guess I don't understand why this is needed, so some justification is
required.

thanks,

greg k-h
