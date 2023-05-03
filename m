Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AAA6F5EFC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 21:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjECTOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 15:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjECTOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 15:14:05 -0400
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59D87690
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 12:14:04 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id a912b3f3-e9e6-11ed-b972-005056bdfda7;
        Wed, 03 May 2023 22:14:01 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Wed, 3 May 2023 22:14:00 +0300
To:     Xiaolei Wang <xiaolei.wang@windriver.com>
Cc:     aisheng.dong@nxp.com, festevam@gmail.com, shawnguo@kernel.org,
        ping.bai@nxp.com, kernel@pengutronix.de, linus.walleij@linaro.org,
        shenwei.wang@nxp.com, bartosz.golaszewski@linaro.org,
        peng.fan@nxp.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2][PATCH] pinctrl: freescale: Fix a memory out of bounds when
 num_configs is 1
Message-ID: <ZFKyeFQOuCaDOh1n@surfacebook>
References: <20230503012127.4157304-1-xiaolei.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503012127.4157304-1-xiaolei.wang@windriver.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, May 03, 2023 at 09:21:27AM +0800, Xiaolei Wang kirjoitti:
> The config passed in by pad wakeup is 1, When num_configs is 1,
> configs[1] should not be obtained, which will generate the
> following memory out-of-bounds situation:
> 
> BUG: KASAN: stack out of bounds in imx_pinconf_set_scu+0x9c/0x160
>   Read size 8 at address ffff8000104c7558 by task sh/664
>   CPU: 3 PID: 664 Communication: sh Tainted: G WC 6.1.20 #1
>      Hardware name: Freescale i.MX8QM MEK (DT)
>   Call trace:
>     dump_backtrace.part.0+0xe0/0xf0
>     show stack+0x18/0x30
>     dump_stack_lvl+0x64/0x80
>     print report +0x154/0x458
>     kasan_report+0xb8/0x100
>     __asan_load8+0x80/0xac
>     imx_pinconf_set_scu+0x9c/0x160
>     imx_pinconf_set+0x6c/0x214
>     pinconf_set_config+0x68/0x90
>     pinctrl_gpio_set_config+0x138/0x170
>     gpiochip_generic_config+0x44/0x60
>     mxc_gpio_set_pad_wakeup+0x100/0x140
>     mxc_gpio_noirq_suspend+0x50/0x74
>     pm_generic_suspend_noirq+0x4c/0x70
>     genpd_finish_suspend+0x174/0x260
>     genpd_suspend_noirq+0x14/0x20
>     dpm_run_callback.constprop.0+0x48/0xec
>     __device_suspend_noirq+0x1a8/0x370
>     dpm_noirq_suspend_devices+0x1cc/0x320
>     dpm_suspend_noirq+0x7c/0x11c
>     suspend_devices_and_enter+0x27c/0x760
>     pm_suspend+0x36c/0x3e0

I have already pointed out to the documentation in which you may find what to
do to make above better. 

> Fixes: f60c9eac54af ("gpio: mxc: enable pad wakeup on i.MX8x platforms")
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---

Where is the changelog?

-- 
With Best Regards,
Andy Shevchenko


