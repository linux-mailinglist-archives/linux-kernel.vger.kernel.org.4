Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A215FC955
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 18:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiJLQaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 12:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJLQ3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 12:29:44 -0400
X-Greylist: delayed 2404 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Oct 2022 09:29:37 PDT
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AB3DFF;
        Wed, 12 Oct 2022 09:29:37 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1oidz2-000187-AD; Wed, 12 Oct 2022 17:49:24 +0200
Date:   Wed, 12 Oct 2022 17:49:24 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: imx: Add missing .thaw_noirq hook
Message-ID: <20221012154924.x4rjav563efhsnep@viti.kaiser.cx>
References: <20221012121353.2346280-1-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012121353.2346280-1-shawn.guo@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Shawn Guo (shawn.guo@linaro.org):

> The following warning is seen with non-console UART instance when
> system hibernates.

> [   37.371969] ------------[ cut here ]------------
> [   37.376599] uart3_root_clk already disabled
> [   37.380810] WARNING: CPU: 0 PID: 296 at drivers/clk/clk.c:952 clk_core_disable+0xa4/0xb0
> ...
> [   37.506986] Call trace:
> [   37.509432]  clk_core_disable+0xa4/0xb0
> [   37.513270]  clk_disable+0x34/0x50
> [   37.516672]  imx_uart_thaw+0x38/0x5c
> [   37.520250]  platform_pm_thaw+0x30/0x6c
> [   37.524089]  dpm_run_callback.constprop.0+0x3c/0xd4
> [   37.528972]  device_resume+0x7c/0x160
> [   37.532633]  dpm_resume+0xe8/0x230
> [   37.536036]  hibernation_snapshot+0x288/0x430
> [   37.540397]  hibernate+0x10c/0x2e0
> [   37.543798]  state_store+0xc4/0xd0
> [   37.547203]  kobj_attr_store+0x1c/0x30
> [   37.550953]  sysfs_kf_write+0x48/0x60
> [   37.554619]  kernfs_fop_write_iter+0x118/0x1ac
> [   37.559063]  new_sync_write+0xe8/0x184
> [   37.562812]  vfs_write+0x230/0x290
> [   37.566214]  ksys_write+0x68/0xf4
> [   37.569529]  __arm64_sys_write+0x20/0x2c
> [   37.573452]  invoke_syscall.constprop.0+0x50/0xf0
> [   37.578156]  do_el0_svc+0x11c/0x150
> [   37.581648]  el0_svc+0x30/0x140
> [   37.584792]  el0t_64_sync_handler+0xe8/0xf0
> [   37.588976]  el0t_64_sync+0x1a0/0x1a4
> [   37.592639] ---[ end trace 56e22eec54676d75 ]---

> On hibernating, pm core calls into related hooks in sequence like:

>     .freeze
>     .freeze_noirq
>     .thaw_noirq
>     .thaw

> With .thaw_noirq hook being absent, the clock will be disabled in a
> unbalanced call which results the warning above.

>     imx_uart_freeze()
>         clk_prepare_enable()
>     imx_uart_suspend_noirq()
>         clk_disable()
>     imx_uart_thaw
>         clk_disable_unprepare()

> Adding the missing .thaw_noirq hook as imx_uart_resume_noirq() will have
> the call sequence corrected as below and thus fix the warning.

>     imx_uart_freeze()
>         clk_prepare_enable()
>     imx_uart_suspend_noirq()
>         clk_disable()
>     imx_uart_resume_noirq()
>         clk_enable()
>     imx_uart_thaw
>         clk_disable_unprepare()

> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/tty/serial/imx.c | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 590a25369531..e5163c2c4169 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -2603,6 +2603,7 @@ static const struct dev_pm_ops imx_uart_pm_ops = {
>  	.suspend_noirq = imx_uart_suspend_noirq,
>  	.resume_noirq = imx_uart_resume_noirq,
>  	.freeze_noirq = imx_uart_suspend_noirq,
> +	.thaw_noirq = imx_uart_resume_noirq,
>  	.restore_noirq = imx_uart_resume_noirq,
>  	.suspend = imx_uart_suspend,
>  	.resume = imx_uart_resume,
> -- 
> 2.25.1

Reviewed-by: Martin Kaiser <martin@kaiser.cx>

Thanks,

   Martin
