Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3ACE7464EE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 23:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjGCVfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 17:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGCVfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 17:35:45 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35ED1A7
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 14:35:44 -0700 (PDT)
Received: from localhost (88-113-24-87.elisa-laajakaista.fi [88.113.24.87])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 8f925d03-19e9-11ee-b3cf-005056bd6ce9;
        Tue, 04 Jul 2023 00:35:42 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Tue, 4 Jul 2023 00:35:42 +0300
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
        linus.walleij@linaro.org, npliashechnikov@gmail.com,
        nmschulte@gmail.com, friedrich.vock@gmx.de, dridri85@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] pinctrl: amd: Use amd_pinconf_set() for all config
 options
Message-ID: <ZKM_Ltif-L59Jo34@surfacebook>
References: <20230630194716.6497-1-mario.limonciello@amd.com>
 <20230630194716.6497-5-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630194716.6497-5-mario.limonciello@amd.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Jun 30, 2023 at 02:47:16PM -0500, Mario Limonciello kirjoitti:
> On ASUS TUF A16 it is reported that the ITE5570 ACPI device connected to
> GPIO 7 is causing an interrupt storm.  This issue doesn't happen on
> Windows.
> 
> Comparing the GPIO register configuration between Windows and Linux
> bit 20 has been configured as a pull up on Windows, but not on Linux.
> Checking GPIO declaration from the firmware it is clear it *should* have
> been a pull up on Linux as well.
> 
> ```
>                     GpioInt (Level, ActiveLow, Exclusive, PullUp, 0x0000,
>                         "\\_SB.GPIO", 0x00, ResourceConsumer, ,
>                         )
>                         {   // Pin list
>                             0x0007
>                         }

I beleive we do not need so many heading spaces in the above

> ```
> 
> On Linux amd_gpio_set_config() is currently only used for programming
> the debounce. Actually the GPIO core calls it with all the arguments
> that are supported by a GPIO, pinctrl-amd just responds `-ENOTSUPP`.
> 
> To solve this issue expand amd_gpio_set_config() to support the other
> arguments amd_pinconf_set() supports, namely `PIN_CONFIG_BIAS_PULL_DOWN`,
> `PIN_CONFIG_BIAS_PULL_UP`, and `PIN_CONFIG_DRIVE_STRENGTH`.

...

> Fixes: 2956b5d94a76b ("pinctrl / gpio: Introduce .set_config() callback for GPIO chips")

Can you group fixes at the beginning of the series? 

-- 
With Best Regards,
Andy Shevchenko


