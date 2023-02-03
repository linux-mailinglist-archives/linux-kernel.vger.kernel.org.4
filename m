Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B1F689176
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 09:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjBCIBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 03:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbjBCIAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 03:00:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE691B31E;
        Thu,  2 Feb 2023 23:59:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69FA2B829BC;
        Fri,  3 Feb 2023 07:59:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B5AC433EF;
        Fri,  3 Feb 2023 07:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675411191;
        bh=GIfd5Axxji05btj1jW/bAPwo1tTtiuLMvZrf+hYfgns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V0MhVO4eCR3vBClDNhz/FzIL/b+9ek5Jo37I9QGM8y88ttCvUQLoHfsuLqaXiDM5T
         hXmZUZAAyAkclxYhSvTg/hnZaATS89wcPXor1MTEAMAL0Xp8tou99ZWaTTqI/H+i5O
         4Lz75cbmmJNafD9J/w1QI0cDdVpMMtCK8Iww1gHWHsFPSZ/PfRZGbyXop8eQd7odTc
         AhGU/Y7R+lrQv3XgEyFN5KHmcKuzsYmSnpRogH6dU8ITzYwpNZB31P1SpNJBHPNYXv
         b5ri8KHgyukAajThr2DzlgpgoD+fmz/jBK1Pa0gWSuSenKcv2BUDQCHN8dys49vwff
         PukG9Gr2XFpAw==
Date:   Fri, 3 Feb 2023 07:59:46 +0000
From:   Lee Jones <lee@kernel.org>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: simatic-ipc-leds-gpio: do not run into endless
 EPROBE_DEFER loop
Message-ID: <Y9y+8nOU4yt/uPD5@google.com>
References: <20230125181711.30844-1-henning.schild@siemens.com>
 <20230202204730.7ee24c01@md1za8fc.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230202204730.7ee24c01@md1za8fc.ad001.siemens.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Feb 2023, Henning Schild wrote:

> Am Wed, 25 Jan 2023 19:17:11 +0100
> schrieb Henning Schild <henning.schild@siemens.com>:
> 
> > Should the driver providing our GPIOs not be available we used to
> > return -EPORBE_DEFER out of the probe function and cause a
> > potentially endless loop that also printed a lot to the kernel log.
> > 
> > ...
> > leds-gpio leds-gpio: cannot find GPIO chip igpio-f7188x-2, deferring
> > leds-gpio leds-gpio: Skipping unavailable LED gpio 0 (red:status-1)
> > ...
> > 
> > The "leds-gpio" just ignores all entries and would never try again
> > even if the GPIOs show up later. But our extra two GPIOs could cause
> > that loop, in which we would even register/unregister "leds-gpio" and
> > cause all the printing.
> > 
> > If any of those two extra GPIOs is not there, return with -ENODEV
> > instead of -EPROBE_DEFER.
> 
> This is a really bad idea. The real fix for the future will be to
> write individual drivers which clearly describe their dep chains.
> 
> This patch should not be merged.

Dropped.

-- 
Lee Jones [李琼斯]
