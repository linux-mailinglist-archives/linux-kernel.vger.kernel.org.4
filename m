Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CB56296CA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiKOLJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238361AbiKOLJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:09:09 -0500
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B4927DD7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:08:04 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 338922004F;
        Tue, 15 Nov 2022 12:08:02 +0100 (CET)
Date:   Tue, 15 Nov 2022 12:08:00 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Brian Masney <bmasney@redhat.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, psodagud@quicinc.com,
        quic_shazhuss@quicinc.com, quic_ppareek@quicinc.com,
        ahalaney@redhat.com, echanude@redhat.com,
        nicolas.dechesne@linaro.org
Subject: Re: [PATCH RFC] gpiolib: ensure that fwnode is properly set
Message-ID: <20221115110800.35gl3j43lmbxm3jb@SoMainline.org>
References: <20221114202943.2389489-1-bmasney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114202943.2389489-1-bmasney@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-14 15:29:43, Brian Masney wrote:
> Note that this is a RFC patch and not meant to be merged. I looked into
> a problem with linux-next-20221110 on the Qualcomm SA8540P automotive
> board (sc8280xp) where the UFS host controller would fail to probe due
> to repeated probe deferrals when trying to get reset-gpios via
> devm_gpiod_get_optional().
> 
> of_get_named_gpiod_flags() returns -EPROBE_DEFER, which is caused by
> of_gpiochip_match_node_and_xlate() returning 0 since the of_xlate function
> pointer is not set for the qcom,sc8280xp-tlmm pinctrl driver. The
> pinctrl driver doesn't define one, so of_gpiochip_add() should
> automatically setup of_gpio_simple_xlate() on it's behalf. This doesn't
> happen since the fwnode member on the struct gpiochip is set to null
> when of_gpiochip_add() is called. Let's work around this by ensuring
> that it's set if available.
> 
> Note that this broke sometime within the last few weeks within
> linux-next and I haven't bisected this. I'm posting this in the hopes
> that someone may know offhand which patch(es) may have broken this.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>

Thanks, this fixes the following abort I'm observing on multiple
Qualcomm platforms (sdm630, Sony Nile, and msm8956, Sony Loire):

    [    0.391439] Internal error: synchronous external abort: 0000000096000210 [#1] PREEMPT SMP
    [    0.391526] Modules linked in:
    [    0.398678] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 6.1.0-rc5-next-20221114-07647-gb3ed2836a8f7 #38
    [    0.401642] Hardware name: Sony Xperia XA2 Ultra (DT)
    [    0.410879] pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
    [    0.415957] pc : msm_gpio_get_direction+0x40/0x80
    [    0.422680] lr : msm_gpio_get_direction+0x18/0x80
    [    0.427544] sp : ffff80000805b750
    [    0.432270] x29: ffff80000805b750 x28: ffff739180b48c00 x27: ffff739180b50180
    [    0.435537] x26: 0000000000000008 x25: 0000000000000002 x24: ffffdcf976192e98
    [    0.442695] x23: ffff739180b31890 x22: 0000000000000000 x21: ffff739180b48c08
    [    0.449814] x20: ffffdcf975ff4148 x19: 0000000000000008 x18: 0000000000000000
    [    0.456891] x17: 64656c62616e655f x16: 7469647561206465 x15: 0000000000000002
    [    0.464049] x14: 0000000000000001 x13: 006c7274636e6970 x12: 2e30303030303133
    [    0.471166] x11: ffffdcf9760c98d8 x10: 000000000042c70 x9 : 0000000000000004
    [    0.478243] x8 : 0101010101010101 x7 : 0073656d616e2d65 x6 : 0911040aadece9ee
    [    0.485405] x5 : 6e696c2d0a041109 x4 : 0000000000000180 x3 : 0000000000008000
    [    0.492483] x2 : 0000000000000000 x1 : ffffdcf975628db0 x0 : ffff800008808000
    [    0.499642] Call trace:
    [    0.506703]  msm_gpio_get_direction+0x40/0x80
    [    0.509008]  gpiochip_add_data_with_key+0x638/0xed0
    [    0.513481]  msm_pinctrl_probe+0x430/0x580
    [    0.518168]  sdm660_pinctrl_probe+0x18/0x30
    [    0.522376]  platform_probe+0x68/0xc0
    [    0.526413]  really_probe+0xc0/0x3dc
    [    0.530234]  __driver_probe_device+0x7c/0x190
    [    0.533922]  driver_probe_device+0x3c/0x110
    [    0.538132]  __device_attach_driver+0xbc/0x160
    [    0.542168]  bus_for_each_drv+0x7c/0xd4
    [    0.546637]  __device_attach+0x9c/0x1c0
    [    0.550370]  device_initial_probe+0x14/0x20
    [    0.554231]  bus_probe_device+0x9c/0xa4
    [    0.558358]  device_add+0x3ac/0x8b0
    [    0.562175]  of_device_add+0x54/0x64
    [    0.565689]  of_platform_device_create_pdata+0x90/0x124
    [    0.569470]  of_platform_bus_create+0x18c/0x510
    [    0.574416]  of_platform_bus_create+0x1ec/0x510
    [    0.578971]  of_platform_populate+0x60/0x150
    [    0.583445]  of_platform_default_populate_init+0xe4/0x104
    [    0.588002]  do_one_initcall+0x64/0x1dc
    [    0.593253]  kernel_init_freeable+0x1b8/0x220
    [    0.596900]  kernel_init+0x24/0x130
    [    0.601453]  ret_from_fork+0x10/0x20
    [    0.604715] Code: d37d0442 8b020000 f941b400 8b030000 (b9400000)
    [    0.608583] ---[ end trace 0000000000000000 ]---
    [    0.619572] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

This wasn't an issue on -next 20221109.

Tested-by: Marijn Suijten <marijn.suijten@somainline.org>

> ---
>  drivers/gpio/gpiolib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 11fb7ec883e9..8bec66008869 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -678,7 +678,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>  	 * Assign fwnode depending on the result of the previous calls,
>  	 * if none of them succeed, assign it to the parent's one.
>  	 */
> -	gdev->dev.fwnode = dev_fwnode(&gdev->dev) ?: fwnode;
> +	gc->fwnode = gdev->dev.fwnode = dev_fwnode(&gdev->dev) ?: fwnode;
>  
>  	gdev->id = ida_alloc(&gpio_ida, GFP_KERNEL);
>  	if (gdev->id < 0) {
> -- 
> 2.38.1
> 
