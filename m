Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDA26F6E8A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 17:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjEDPDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 11:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjEDPDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 11:03:06 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6B140F5
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 08:02:50 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id baf915f5-ea8c-11ed-b3cf-005056bd6ce9;
        Thu, 04 May 2023 18:02:47 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Thu, 4 May 2023 18:02:47 +0300
To:     Xiaolei Wang <xiaolei.wang@windriver.com>
Cc:     aisheng.dong@nxp.com, festevam@gmail.com, shawnguo@kernel.org,
        ping.bai@nxp.com, kernel@pengutronix.de, linus.walleij@linaro.org,
        shenwei.wang@nxp.com, peng.fan@nxp.com,
        bartosz.golaszewski@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] pinctrl: freescale: Fix a memory out of bounds
 when num_configs is 1
Message-ID: <ZFPJFwYLHtR6C5nf@surfacebook>
References: <20230504003330.1075531-1-xiaolei.wang@windriver.com>
 <20230504003330.1075531-2-xiaolei.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504003330.1075531-2-xiaolei.wang@windriver.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, May 04, 2023 at 08:33:30AM +0800, Xiaolei Wang kirjoitti:

...

The link to the documentation I have added into reply to your v1 was about
backtraces in the commit messages. For a single patch there is no need to have
a cover letter.

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

This is too long backtrace. The documentation tells you to shrink it to the
important lines only, which in this case something like less than 10 and not
17. Hence, remove _at least_ 8 lines from the backtrace.

Codewise the proposed change is good, though.

-- 
With Best Regards,
Andy Shevchenko


