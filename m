Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C5D6FE22D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjEJQMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjEJQMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:12:24 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590107AB7;
        Wed, 10 May 2023 09:12:22 -0700 (PDT)
Received: (Authenticated sender: jeanmichel.hautbois@yoseli.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 3A2D1240002;
        Wed, 10 May 2023 16:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
        t=1683735140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qRBN0rXPHTBOJEnZzYeNo08N92jJth7wPrVZ++XwQyU=;
        b=k0hQBqIWlhkN3L26v5YE4s4sLg/YYRCyhVrtO3PRbiYKMb11XHDZbFnMSHw2focR2Cw07o
        gcftAzF9ZqsOvQaaMuHC8FiL7PI2ylkm0DXYDgQ6SDAd6eZfnzMd6+4Uvgm8QEP5g7fCdx
        JIf5G3a5mE/ELpjWyG4WXEY8uNSNbq1TRwDPfS7iRsSlVXV1BEDi7ah2CenLbKg2FD1ZAH
        8jp3xb1beGjF9NT0aI4XyDMO/VBAW7H/TrhY1/ZrNJfgnVgesZKbfYTxjNIDoqsxrtA0f2
        Xe9B30HKKlNdSm6mFO5P/igOsEE/xntf6x8UsZgmEJxJMg0izPzs+CmZFV2GIw==
Message-ID: <0b3a257a-f1e5-ad86-4c69-93e038a33ce9@yoseli.org>
Date:   Wed, 10 May 2023 18:12:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, brgl@bgdev.pl,
        linus.walleij@linaro.org
From:   Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Subject: pca953x issue when driving a DSI bridge
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there !

I have a custom board, based on a i.MX8mm SoC which has a MIPI-DSI to 
eDP bridge (namely, a TI sn65dsi86). This bridge has a DSI enable pin, 
which is basically its reset pin, connected to my PCA9539 GPIO expander.

The issue is that this pin can't be sleeping, and it is tested in the 
gpiod_set_value() function.

Here is where it fails in my dmesg:
[   11.096512] ------------[ cut here ]------------
[   11.102443] WARNING: CPU: 0 PID: 212 at 
../../../../../work-shared/lcx-imx8mm-1gw-r1-hpp/kernel-source/drivers/gpio/gpiolib.c:3131 
gpiod_set_value+0x5c/0xcc
[   11.116454] Modules linked in: ti_sn65dsi86(+) caamalg_desc 
crypto_engine ecdh_generic ecc brcmutil rng_core smsc authenc libdes 
cp210x smsc95xx cfg80211 drm_dp_aux_bus rfkill drm_display_helper 
phy_fsl_imx8m_p
cie rtc_rv3028 spi_imx caam hantro_vpu error v4l2_vp9 v4l2_h264 
v4l2_mem2mem videobuf2_dma_contig videobuf2_memops videobuf2_v4l2 
governor_userspace rtc_snvs videobuf2_common videodev imx_sdma 
imx8m_ddrc fsl_imx8_
ddr_perf imx8mm_thermal pwm_imx27 mc etnaviv gpu_sched crct10dif_ce 
imx_cpufreq_dt display_connector drm_kms_helper drm fuse ipv6 overlay
[   11.165624] CPU: 0 PID: 212 Comm: systemd-udevd Not tainted 
6.1.22-hpp-1gw #1
[   11.172763] Hardware name: Onegateway motherboard i.MX8MM (w/ slice 
test) (DT)
[   11.179983] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[   11.186944] pc : gpiod_set_value+0x5c/0xcc
[   11.191046] lr : ti_sn65dsi86_resume+0x4c/0x94 [ti_sn65dsi86]
[   11.196807] sp : ffff80000add35c0
[   11.200119] x29: ffff80000add35c0 x28: 0000000000000000 x27: 
0000000000000000
[   11.207258] x26: ffff0000c08b6148 x25: 0000000000000001 x24: 
ffff80000815ce60
[   11.214398] x23: 0000000000000000 x22: ffff0000c08b6104 x21: 
0000000000000000
[   11.221538] x20: 0000000000000001 x19: ffff0000c08b8c00 x18: 
ffffffffffffffff
[   11.228678] x17: 2e726f74616c7567 x16: ffff800008665b04 x15: 
00000000000004fb
[   11.235820] x14: 0000000000000000 x13: 0000000000000001 x12: 
0000000000000000
[   11.242959] x11: 0000000000000003 x10: 0000000000000b40 x9 : 
ffff80000add3470
[   11.250101] x8 : ffff0000c1339b60 x7 : ffff0000c0f54a00 x6 : 
0000000000000000
[   11.257242] x5 : 00000000410fd030 x4 : 0000000000c0000e x3 : 
0000000000000000
[   11.264380] x2 : 0000000000000000 x1 : ffff0000c08b8100 x0 : 
0000000000000001
[   11.271523] Call trace:
[   11.273968]  gpiod_set_value+0x5c/0xcc
[   11.277722]  ti_sn65dsi86_resume+0x4c/0x94 [ti_sn65dsi86]
[   11.283131]  __rpm_callback+0x48/0x19c
[   11.286885]  rpm_callback+0x6c/0x80
[   11.290375]  rpm_resume+0x3b0/0x660
[   11.293864]  __pm_runtime_resume+0x4c/0x90
[   11.297960]  __device_attach+0x90/0x1e4
[   11.301797]  device_initial_probe+0x14/0x20
[   11.305980]  bus_probe_device+0x9c/0xa4
[   11.309817]  device_add+0x3d8/0x820
[   11.313308]  __auxiliary_device_add+0x40/0xa0
[   11.317668]  ti_sn65dsi86_add_aux_device.isra.0+0xb0/0xe0 [ti_sn65dsi86]
[   11.324381]  ti_sn65dsi86_probe+0x20c/0x2ec [ti_sn65dsi86]
[   11.329876]  i2c_device_probe+0x3b8/0x3f0
[   11.333889]  really_probe+0xc0/0x3dc
[   11.337466]  __driver_probe_device+0x7c/0x190
[   11.341822]  driver_probe_device+0x3c/0x110
[   11.346006]  __driver_attach+0xf4/0x200
[   11.349842]  bus_for_each_dev+0x70/0xd0
[   11.353678]  driver_attach+0x24/0x30
[   11.357254]  bus_add_driver+0x17c/0x240
[   11.361088]  driver_register+0x78/0x130
[   11.364927]  i2c_register_driver+0x48/0xf0
[   11.369022]  ti_sn65dsi86_init+0x34/0x1000 [ti_sn65dsi86]
[   11.374432]  do_one_initcall+0x50/0x1d0
[   11.378271]  do_init_module+0x48/0x1d0
[   11.382022]  load_module+0x18d8/0x1df0
[   11.385772]  __do_sys_finit_module+0xac/0x130
[   11.390129]  __arm64_sys_finit_module+0x20/0x30
[   11.394660]  invoke_syscall+0x48/0x114
[   11.398410]  el0_svc_common.constprop.0+0xd4/0xfc
[   11.403117]  do_el0_svc+0x30/0xd0
[   11.406432]  el0_svc+0x2c/0x84
[   11.409491]  el0t_64_sync_handler+0xbc/0x140
[   11.413762]  el0t_64_sync+0x18c/0x190
[   11.417426] ---[ end trace 0000000000000000 ]---

I suppose this is not a corner case and we may have other drivers and 
other boards connecting a GPIO which can sleep in a context where it 
should not ?

I would like to add one thing: on this board, the expander is routed in 
a way that makes it impossible to "sleep" as the reset is forced 
pulled-up and the power regulators are fixed and can't be stopped.

I don't know how to address this issue nicely and any thoughts is 
appreciated !

Thanks in advance !
JM
