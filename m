Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA974633841
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbiKVJXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbiKVJXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:23:17 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CD420F4E;
        Tue, 22 Nov 2022 01:23:15 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B95126602AC7;
        Tue, 22 Nov 2022 09:23:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669108994;
        bh=+mlBG/PJoJUc9mB4Fvqa/9O1jnPv1xX0SkB4mOqIHso=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oATMFKxm8m+2BgI44UwSDJAtyNhdFHigDVbG6Z/9SiyBYFGV3ZSsbTLtST5gWh4KS
         WJBQZWAGGa15Wiouudki0IYlWOUr+2EMIMnTehAUHfNbLwtF+sLHKydXIjqxCUz0AU
         LuMRfxHk7vmryAUL9TDH1bxQDN8kjiY3HKNWtUu4CjarTpgLJ2tq8+RycPBNTjCLuy
         PBnTp5ozH8QzSoabVMpb2uQqPng+rhyMbWe7oP8MxvyyQGyDwxugiijioK/ssdQRYx
         q8cLwz48saX8Ksw857B93cNidbMc2/zl9LtpiF5RnE1QzdeoCkggEj5A96UEpZx51M
         nfOBhknwD4Q5g==
Message-ID: <a176dc88-add7-7ce2-16c8-2bd7c6821399@collabora.com>
Date:   Tue, 22 Nov 2022 10:23:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v1 1/1] pinctrl: meditatek: Startup with the IRQs disabled
Content-Language: en-US
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ross Zwisler <zwisler@kernel.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
References: <20221122-mtk-pinctrl-v1-0-bedf5655a3d2@chromium.org>
 <20221122-mtk-pinctrl-v1-1-bedf5655a3d2@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221122-mtk-pinctrl-v1-1-bedf5655a3d2@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 22/11/22 00:38, Ricardo Ribalda ha scritto:
> If the system is restarted via kexec(), the peripherals do not start
> with a known state.
> 
> If the previous system had enabled an IRQs we will receive unexected
> IRQs that can lock the system.
> 
> [   28.109251] watchdog: BUG: soft lockup - CPU#0 stuck for 26s!
> [swapper/0:0]
> [   28.109263] Modules linked in:
> [   28.109273] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
> 5.15.79-14458-g4b9edf7b1ac6 #1 9f2e76613148af94acccd64c609a552fb4b4354b
> [   28.109284] Hardware name: Google Elm (DT)
> [   28.109290] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS
> 		BTYPE=--)
> [   28.109298] pc : __do_softirq+0xa0/0x388
> [   28.109309] lr : __do_softirq+0x70/0x388
> [   28.109316] sp : ffffffc008003ee0
> [   28.109321] x29: ffffffc008003f00 x28: 000000000000000a x27:
> 0000000000000080
> [   28.109334] x26: 0000000000000001 x25: ffffffefa7b350c0 x24:
> ffffffefa7b47480
> [   28.109346] x23: ffffffefa7b3d000 x22: 0000000000000000 x21:
> ffffffefa7b0fa40
> [   28.109358] x20: ffffffefa7b005b0 x19: ffffffefa7b47480 x18:
> 0000000000065b6b
> [   28.109370] x17: ffffffefa749c8b0 x16: 000000000000018c x15:
> 00000000000001b8
> [   28.109382] x14: 00000000000d3b6b x13: 0000000000000006 x12:
> 0000000000057e91
> [   28.109394] x11: 0000000000000000 x10: 0000000000000000 x9 :
> ffffffefa7b47480
> [   28.109406] x8 : 00000000000000e0 x7 : 000000000f424000 x6 :
> 0000000000000000
> [   28.109418] x5 : ffffffefa7dfaca0 x4 : ffffffefa7dfadf0 x3 :
> 000000000000000f
> [   28.109429] x2 : 0000000000000000 x1 : 0000000000000100 x0 :
> 0000000001ac65c5
> [   28.109441] Call trace:
> [   28.109447]  __do_softirq+0xa0/0x388
> [   28.109454]  irq_exit+0xc0/0xe0
> [   28.109464]  handle_domain_irq+0x68/0x90
> [   28.109473]  gic_handle_irq+0xac/0xf0
> [   28.109480]  call_on_irq_stack+0x28/0x50
> [   28.109488]  do_interrupt_handler+0x44/0x58
> [   28.109496]  el1_interrupt+0x30/0x58
> [   28.109506]  el1h_64_irq_handler+0x18/0x24
> [   28.109512]  el1h_64_irq+0x7c/0x80
> [   28.109519]  arch_local_irq_enable+0xc/0x18
> [   28.109529]  default_idle_call+0x40/0x140
> [   28.109539]  do_idle+0x108/0x290
> [   28.109547]  cpu_startup_entry+0x2c/0x30
> [   28.109554]  rest_init+0xe8/0xf8
> [   28.109562]  arch_call_rest_init+0x18/0x24
> [   28.109571]  start_kernel+0x338/0x42c
> [   28.109578]  __primary_switched+0xbc/0xc4
> [   28.109588] Kernel panic - not syncing: softlockup: hung tasks
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


