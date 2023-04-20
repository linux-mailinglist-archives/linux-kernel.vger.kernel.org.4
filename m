Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACC26E8C98
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbjDTIWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbjDTIWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:22:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEB626B3;
        Thu, 20 Apr 2023 01:22:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90051645E6;
        Thu, 20 Apr 2023 08:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0590DC433D2;
        Thu, 20 Apr 2023 08:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681978947;
        bh=S6H5PDpbon+c+zJoAhcp+xf9q+yBVa0TMRe9t5rUVuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RSaIJl/4PHmkhfJoMtSl5CpTBcy/cZJuGad086SLCzEOg8G/jdfICrHPmzS+W6yfB
         wWdQWhlkG317bH19nQaG1MCodBqczMZeCgJoeWbnGh6QU0TSdXuSUO2HhzpSxFpNLj
         ULkkYU7cNemnI3HIg2OtoYgIwa/vpwu9/xH41LU0N29VAolyIJ3B3qTOkP8YQb7dy9
         EojsJUlOE2ND6wBXv8hFHbffAiEnhhH16wpQT4vQPYU9j9dONS0vnXjJDPPLNx9dlg
         PMKxNcrQMrUFHbPPq4oSN7Bi+lEBy/meI9REsEB539/TlKC+01BnYq6A/vnSHqHp00
         cq3q+SsMDCpDg==
Date:   Thu, 20 Apr 2023 09:22:22 +0100
From:   Lee Jones <lee@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz
Subject: Re: [RESEND] leds: Ensure hardware blinking turns off when requested
Message-ID: <20230420082222.GC9904@google.com>
References: <20230405165028.73579-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230405165028.73579-1-eajames@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Apr 2023, Eddie James wrote:

> If an LED is blinking through the hardware and the trigger is deactivated,
> the driver will set the brightness to 0 to disable blinking. However, if
> the LED driver doesn't support non-blocking operations, the request for
> setting brightness to 0 will get queued. Then if a user requests a new
> non-zero brightness before the request for 0 brightness is executed, the
> LED blinking will not get disabled since the brightness will simply be
> updated.
> Fix this by flushing the workqueue before updating the requested
> brightness.

You make a convincing argument for this.
 
> Fixes: 4d71a4a12b13 ("leds: Add support for setting brightness in a synchronous way")
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/leds/led-class.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
> index 9255bc11f99d..78a270300d30 100644
> --- a/drivers/leds/led-class.c
> +++ b/drivers/leds/led-class.c
> @@ -57,6 +57,8 @@ static ssize_t brightness_store(struct device *dev,
>  
>  	if (state == LED_OFF)
>  		led_trigger_remove(led_cdev);
> +	/* flush out any request to disable blinking */
> +	flush_work(&led_cdev->set_brightness_work);
>  	led_set_brightness(led_cdev, state);
>  	flush_work(&led_cdev->set_brightness_work);

Just to be clear, you want to flush the work before AND after setting
the brightness?

In the commit message, could you make it clear why simply moving this
flush won't work.

-- 
Lee Jones [李琼斯]
