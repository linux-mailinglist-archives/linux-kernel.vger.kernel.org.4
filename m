Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53999628953
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbiKNT3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbiKNT3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:29:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4255D20F66;
        Mon, 14 Nov 2022 11:29:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2BF6613EA;
        Mon, 14 Nov 2022 19:29:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FC8C43470;
        Mon, 14 Nov 2022 19:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668454181;
        bh=7gDJJ7UtURCtpGUPxQT2lSB4H0lh3qa/bxjfMajltOo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D6QdqWUzROR+yvuHACC6wdqq9feKbVHR+SQfEc/8HLszF532JSVdCCsE5EYNBiSwk
         nmotoHZm/Qc07H2/yhTgplTNbAH+qsslxVybUxWhiRllTiuRrZpHEMBM36UY8g9pBa
         mncQT6QDY6kuMUYTGwNXZqUFt7BiciiCBX0JH8/1Wloa/qvZYAHxP0GUWu/MNtHtfh
         PTZfRlxd3Y5+p6s1P9WnQbWn3q/S0hfi2MH4a3iY3AE83tnblffmklHosmuHc1fe7R
         Y+duGYbhmVusGkNThbH/vjdsrr4nIhyAnssuazfoEA2On4RA2VderhjKFoqGHzVmHl
         jdzBVHZaHGv+g==
Date:   Mon, 14 Nov 2022 19:41:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] iio: addac: ad74413r: add support for reset-gpio
Message-ID: <20221114194157.1d03588a@jic23-huawei>
In-Reply-To: <ccb148b2-c669-0317-e2b5-c59e595e4299@rasmusvillemoes.dk>
References: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
        <20221111143921.742194-6-linux@rasmusvillemoes.dk>
        <20221112170705.7efe1673@jic23-huawei>
        <ccb148b2-c669-0317-e2b5-c59e595e4299@rasmusvillemoes.dk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Mon, 14 Nov 2022 09:37:59 +0100
Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> On 12/11/2022 18.07, Jonathan Cameron wrote:
> > On Fri, 11 Nov 2022 15:39:21 +0100
> > Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> >   
> >> We have a board where the reset pin of the ad74412 is connected to a
> >> gpio, but also pulled low by default. Hence to get the chip out of
> >> reset, the driver needs to know about that gpio and set it high before
> >> attempting to communicate with it.  
> > 
> > I'm a little confused on polarity here.  The pin is a !reset so
> > we need to drive it low briefly to trigger a reset.
> > I'm guessing for your board the pin is set to active low? (an example
> > in the dt would have made that clearer) Hence the pulse
> > in here to 1 is actually briefly driving it low before restoring to high?  
> 
> Yes. I actually thought that was pretty standard. I do indeed have
> something like
> 
>   reset-gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
> 
> in my .dts, so setting the gpio value to 1 (logically asserting its
> function) will end up driving the signal low, and setting it to 0
> (de-asserting reset) will set the signal high. I will add that line to
> the example in the binding.
> 
> > For a pin documented as !reset that seems backwards   
> 
> Well, it depends on where the knowledge of the pin being active low
> belongs. In this case, the driver itself handles the gpio so it could be
> done both ways.
> 
> But if, for example, the iio framework would handle an optional
> reset-gpio for each device, it couldn't possibly know whether to set it
> to 1 or 0 for a given device, it could only set it logic 1 to assert
> reset and then rely on DT gpio descriptor to include the active low/high
> info.
> 
> Also, see the "The active low and open drain semantics" section in
> Documentation/driver-api/gpio/consumer.rst.

Throw in an example in the dt-binding and I'm fine with this as it
stands.

Jonathan

> 
> Rasmus
> 

