Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A67A5F2342
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 14:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJBM5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 08:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiJBM5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 08:57:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1103A171;
        Sun,  2 Oct 2022 05:57:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F6CA60DC7;
        Sun,  2 Oct 2022 12:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3ECC433D6;
        Sun,  2 Oct 2022 12:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664715449;
        bh=BQllilL0yrIT5aIzEu6OlhUSxbKarggUU1u0rqNEHMQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TAZsZARA94yrhtHob/xw/7LheieXyFsGn/E56RsdPrls5wW4Dx8c5/vh3m6t+seNt
         xTVU23pkxkaHH9J7aqOxOsSYw3Ew5ce9WyaCedCdamCyW9Dgv6PwRlJr9xZLmLd+dw
         ZZ3BzF+dA2V5uB1/wf2Pge3ulT8fyjbVMYHptG5rI+VK6GSXVySqVL0gXyFAhSInSs
         FisRAlHBbMMH4euuw5DeYeB0S7eIE8h/4TFEKM5h4i/Ff1Rg+gO1bsOYXevf7UY/l8
         M/UsGFIuJYJV2BPRJ4lhp2C2IOIxESuV6FgWWiujbD4YqQqQrL0xXkV9vMbKcxsW57
         3xiJ4ToUBGLtA==
Date:   Sun, 2 Oct 2022 13:57:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: adc: twl4030-madc: add missing of.h include
Message-ID: <20221002135744.770ae2fb@jic23-huawei>
In-Reply-To: <Yzi7sBI+kEHrJjHz@google.com>
References: <20220927154611.3330871-1-dmitry.torokhov@gmail.com>
        <20220927154611.3330871-3-dmitry.torokhov@gmail.com>
        <YzMisM73yj/APB86@smile.fi.intel.com>
        <20221001180705.7002796a@jic23-huawei>
        <Yzi7sBI+kEHrJjHz@google.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Sat, 1 Oct 2022 15:14:08 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Sat, Oct 01, 2022 at 06:07:05PM +0100, Jonathan Cameron wrote:
> > On Tue, 27 Sep 2022 19:20:00 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >   
> > > On Tue, Sep 27, 2022 at 08:46:11AM -0700, Dmitry Torokhov wrote:  
> > > > The driver is using of_device_id/of_match_ptr() and therefore needs
> > > > to include of.h header. We used to get this definition indirectly via
> > > > inclusion of matrix_keypad.h from twl.h, but we are cleaning up
> > > > matrix_keypad.h from unnecessary includes.    
> > > 
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> > Applied to the togreg branch of iio.git and pushed out as testing for
> > 0-day to take a look.
> > 
> > Note that this is 6.2 material now - if that's an issue for the matrix_keypad.h
> > cleanup then feel free to take it via the input tree with
> > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > but shout in reply to this so I know to drop it from the iio tree.  
> 
> OK, it is not urgent, but I do not want to lose matrix keypad changes...
> 
> How about I'll wait to see where the rest of the patches end, and if
> they end up in 6.1 I'll queue twl4030-madc.c through my tree together
> with the header change?
> 
> Thanks.
> 
Ok. I'll drop it for now - let me know if I should pick it up once everything
settles down.

Jonathan

