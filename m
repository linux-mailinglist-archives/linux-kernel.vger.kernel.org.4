Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADA774D43B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 13:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjGJLHW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jul 2023 07:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjGJLHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 07:07:11 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3584C10C8;
        Mon, 10 Jul 2023 04:06:31 -0700 (PDT)
Received: from i53875a50.versanet.de ([83.135.90.80] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qIoi8-0000CZ-7Z; Mon, 10 Jul 2023 13:05:44 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Yangtao Li <frank.li@vivo.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/21] thermal/drivers/rockchip: convert to use
 devm_request*_irq_probe()
Date:   Mon, 10 Jul 2023 13:05:42 +0200
Message-ID: <2114204.OBFZWjSADL@phil>
In-Reply-To: <20230710095926.15614-12-frank.li@vivo.com>
References: <20230710095926.15614-1-frank.li@vivo.com>
 <20230710095926.15614-12-frank.li@vivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 10. Juli 2023, 11:59:16 CEST schrieb Yangtao Li:
> There are more than 700 calls to devm_request_threaded_irq method and
> more than 1000 calls to devm_request_irq method. Most drivers only
> request one interrupt resource, and these error messages are basically
> the same. If error messages are printed everywhere, more than 2000 lines
> of code can be saved by removing the msg in the driver.
> 
> And tglx point out that:
> 
>   If we actually look at the call sites of
>   devm_request_threaded_irq() then the vast majority of them print more or
>   less lousy error messages. A quick grep/sed/awk/sort/uniq revealed
> 
>      519 messages total (there are probably more)
> 
>      352 unique messages
> 
>      323 unique messages after lower casing
> 
>          Those 323 are mostly just variants of the same patterns with
>          slight modifications in formatting and information provided.
> 
>      186 of these messages do not deliver any useful information,
>          e.g. "no irq", "
> 
>      The most useful one of all is: "could request wakeup irq: %d"
> 
>   So there is certainly an argument to be made that this particular
>   function should print a well formatted and informative error message.
> 
>   It's not a general allocator like kmalloc(). It's specialized and in the
>   vast majority of cases failing to request the interrupt causes the
>   device probe to fail. So having proper and consistent information why
>   the device cannot be used _is_ useful.
> 
> So convert to use devm_request*_irq_probe() API, which ensure that all
> error handling branches print error information.
> 
> In this way, when this function fails, the upper-layer functions can
> directly return an error code without missing debugging information.
> Otherwise, the error message will be printed redundantly or missing.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Cc: AngeloGioacchino Del Regno  <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Acked-by: Heiko Stuebner <heiko@sntech.de>


