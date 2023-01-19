Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305D0674401
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjASVKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjASVJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:09:29 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202D2A1010;
        Thu, 19 Jan 2023 13:02:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7C9C6CE25B1;
        Thu, 19 Jan 2023 21:02:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F97C433F0;
        Thu, 19 Jan 2023 21:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674162165;
        bh=Gl+Z25/Z/2UsEtuRKbFkcBEiWO+If4DwRr3vxCyOQNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ub1SDnk2kwxWunkh+eJXGbifSHZ2fNMd9GrSFrsjepV7ErDo4pp9WzqkJhNcKW0jM
         QfKHsmHnnDwO7avjf9WZLShAspoOqWSY335WaR6JRqq4REnBuJ01LoxauEceqzOcej
         o67J4+AccHWF+g51KnyJ9Z6IZZ+i6BZq60AmO4Y5lJkizFeags2gApN1R+ogPq3vfV
         0MGKdwyAb67KwPvt2lX2lGEWXrPbY6IDVKl0kqg5yUvcMnCsNfUH9vp4bWjK0OFGBQ
         bx8L/l8V+C8sH823lgC/Jw3cuhU3Xsnu1G5tV8w/siWI9UnK6jCcmzM3vDypQM0BD7
         MLUh78Ttm+Mmw==
Date:   Thu, 19 Jan 2023 21:02:40 +0000
From:   Lee Jones <lee@kernel.org>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4] leds: simatic-ipc-leds-gpio: make sure we have the
 GPIO providing driver
Message-ID: <Y8mv8PzL1UsP9gNh@google.com>
References: <20221007153323.1326-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221007153323.1326-1-henning.schild@siemens.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Oct 2022, Henning Schild wrote:

> If we register a "leds-gpio" platform device for GPIO pins that do not
> exist we get a -EPROBE_DEFER and the probe will be tried again later.
> If there is no driver to provide that pin we will poll forever and also
> create a lot of log messages.
> 
> So check if that GPIO driver is configured, if so it will come up
> eventually. If not, we exit our probe function early and do not even
> bother registering the "leds-gpio". This method was chosen over "Kconfig
> depends" since this way we can add support for more devices and GPIO
> backends more easily without "depends":ing on all GPIO backends.
> 
> Fixes: a6c80bec3c93 ("leds: simatic-ipc-leds-gpio: Add GPIO version of Siemens driver")
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  drivers/leds/simple/simatic-ipc-leds-gpio.c | 2 ++
>  1 file changed, 2 insertions(+)

FYI: I'm going to try my best not to take another one like this.

Please try to improve the whole situation for you next submission.

Applied, thanks.

-- 
Lee Jones [李琼斯]
