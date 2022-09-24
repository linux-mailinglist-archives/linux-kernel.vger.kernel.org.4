Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5145E8B96
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 12:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbiIXKvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 06:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbiIXKvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 06:51:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880E4248DC;
        Sat, 24 Sep 2022 03:51:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D2D260C07;
        Sat, 24 Sep 2022 10:51:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57490C433C1;
        Sat, 24 Sep 2022 10:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664016708;
        bh=fJw46oiVDsrdRUBDbHBnpknkTEoz2vA2Oe6A+Tlnjhk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=atP3qtEXWF7U0jZKg8roHJOnr5mgJ+ewNB562GRr67Wd7dns9IN42+x2ZzETWkozY
         ZklGsW3HNtp5QuzmXHQiGeTK2iZ0ywknqm7O9ebdIr5K5JI8jn1YWRhmVu133XJwsB
         Njzkt2oCP27oE/PDsZemtuT18FFhY8Q78njbrbxgB141gVVoGUVt8lJPLzdviwuJ31
         BBflbYJ/sy6zJ4Mey/x4CR7uFn3drs3XD5byCtjtdk1ROJKNqVb/YDzAPKFH6auZOJ
         rZtW1MQKaA/ZgATf98wqD5jIl+wfyQLNN8Z//9QZlH3kX6a+iy25hnyxRM2YDXYQq5
         Isa9jSo1kn3IA==
Received: by pali.im (Postfix)
        id EDE888A2; Sat, 24 Sep 2022 12:51:45 +0200 (CEST)
Date:   Sat, 24 Sep 2022 12:51:45 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: armada_37xx_wdt: Fix .set_timeout callback
Message-ID: <20220924105145.spzn32xvz6mvyksi@pali>
References: <20220726085612.10672-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220726085612.10672-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PING?

On Tuesday 26 July 2022 10:56:12 Pali Rohár wrote:
> ioctl(WDIOC_SETTIMEOUT) calls .set_timeout and .ping callbacks and it is
> expected that it changes current watchdog timeout.
> 
> armada_37xx_wdt's .ping callback just reping counter 0 and does not touch
> counter 1 used for timeout. So it is needed to set counter 1 to the new
> value in .set_timeout callback to ensure ioctl(WDIOC_SETTIMEOUT)
> functionality. Fix it.
> 
> Fixes: 54e3d9b518c8 ("watchdog: Add support for Armada 37xx CPU watchdog")
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  drivers/watchdog/armada_37xx_wdt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/watchdog/armada_37xx_wdt.c b/drivers/watchdog/armada_37xx_wdt.c
> index 1635f421ef2c..b84cba94b135 100644
> --- a/drivers/watchdog/armada_37xx_wdt.c
> +++ b/drivers/watchdog/armada_37xx_wdt.c
> @@ -179,6 +179,8 @@ static int armada_37xx_wdt_set_timeout(struct watchdog_device *wdt,
>  	dev->timeout = (u64)dev->clk_rate * timeout;
>  	do_div(dev->timeout, CNTR_CTRL_PRESCALE_MIN);
>  
> +	set_counter_value(dev, CNTR_ID_WDOG, dev->timeout);
> +
>  	return 0;
>  }
>  
> -- 
> 2.20.1
> 
