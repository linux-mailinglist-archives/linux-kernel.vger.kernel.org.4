Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D51D69AFC1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 16:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjBQPsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 10:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjBQPs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:48:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119416242B;
        Fri, 17 Feb 2023 07:48:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A08CB61C41;
        Fri, 17 Feb 2023 15:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D12C433EF;
        Fri, 17 Feb 2023 15:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676648902;
        bh=PiaP3F/e2OCvqSO0RZPWsvSFE4YpRMF5iNcvchHbYt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ig4EOfqo+2A/r0I4abeOkS7p9W4F7iqioRJ5HfPZc/m4DkkvmQADwkeMoN0UiuUQ+
         SQr60sf+4h9nTcRnbLLktVzbvFcPmPNrQFVcyByU80xno9riXj8Z9V9Hj53j8c72OH
         qbuD/ERPh2ZV0HRxAPm8TU/KhS8JMFq7gIew11wI=
Date:   Fri, 17 Feb 2023 16:48:19 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Angelo Compagnucci <angelo@amarulasolutions.com>
Cc:     Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] misc: servo-pwm: driver for controlling servo
 motors via PWM
Message-ID: <Y++hw3QTma3BGpwB@kroah.com>
References: <20230217145731.3018148-1-angelo@amarulasolutions.com>
 <Y++e6IMusukWJNw2@kroah.com>
 <CA+_SqVYMZ7MErNr-HrbHj-=Q-5u1PizHQ_6TFkTOxB5=E8+9Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+_SqVYMZ7MErNr-HrbHj-=Q-5u1PizHQ_6TFkTOxB5=E8+9Dg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 04:39:01PM +0100, Angelo Compagnucci wrote:
> On Fri, Feb 17, 2023 at 4:36 PM Greg Kroah-Hartman <
> gregkh@linuxfoundation.org> wrote:
> 
> > On Fri, Feb 17, 2023 at 03:57:28PM +0100, Angelo Compagnucci wrote:
> > > This patch adds a simple driver to control servo motor position via
> > > PWM signal.
> > > The driver allows to set the angle from userspace, while min/max
> > > positions duty cycle and the motor degrees aperture are defined in
> > > the dts.
> > >
> > > Signed-off-by: Angelo Compagnucci <angelo@amarulasolutions.com>
> > > ---
> > >  MAINTAINERS              |   6 ++
> > >  drivers/misc/Kconfig     |  11 +++
> > >  drivers/misc/Makefile    |   1 +
> > >  drivers/misc/servo-pwm.c | 149 +++++++++++++++++++++++++++++++++++++++
> >
> > You add sysfs files but do not document them in Documentation/ABI/ which
> > is required.  Please do so in your next version of this patch.
> >
> 
> https://patchwork.ozlabs.org/project/linux-pwm/patch/20230217145731.3018148-2-angelo@amarulasolutions.com/
> 
> This patch [2/3] should do what you're asking.

Why was I only cc:ed on this one patch?

confused,

greg k-h
