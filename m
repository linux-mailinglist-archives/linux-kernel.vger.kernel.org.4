Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D7E72A89C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 05:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjFJDEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 23:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFJDED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 23:04:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEE53AAC
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 20:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=mWqXrhtPz+A1dQHqM74gcGN+9URs9BL4g+g+v5pzTIM=; b=wSu6tglFSuo2JOa7P8aMS1Py+9
        f/y823Vvc0u9+MibscICf2Z2ilkfENMWi7/ZKOuDPM8q3syX7/FUVJBwf4a35ReQRxfasrDiJ9a7c
        S+SbWVaG5H5+HgKj0+yhGu350fWIDUyPlithj28nA02LznRGNF30BMNQPjvtL/TKAzVcCdIkpozNi
        NfJniKHfDEFtvG4Z1npjlyQ0B4qes7yr9JHHYkKk1GcknEE697UYkbmYC1QNjxxyXLBWxWKFNV7Ob
        yqXVQ/j07p/Lo/SfI9j8tkBhUx/+G3TOxWku1SfNCSUfLyaAdIy1Ou9HhM1Zr26bbmwy/rgG28m23
        Wakk/Crg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q7otD-00F2br-2E;
        Sat, 10 Jun 2023 03:03:43 +0000
Message-ID: <aa8fecb1-d5e7-c7c6-a8ad-789fc0627e57@infradead.org>
Date:   Fri, 9 Jun 2023 20:03:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 1/2] powerpc/legacy_serial: Handle SERIAL_8250_FSL=n
 build failures
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>, Liang He <windhl@126.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
References: <20230609133932.786117-1-u.kleine-koenig@pengutronix.de>
 <20230609133932.786117-2-u.kleine-koenig@pengutronix.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230609133932.786117-2-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/23 06:39, Uwe Kleine-König wrote:
> With SERIAL_8250=y and SERIAL_8250_FSL_CONSOLE=n the both
> IS_ENABLED(CONFIG_SERIAL_8250) and IS_REACHABLE(CONFIG_SERIAL_8250)
> evaluate to true and so fsl8250_handle_irq() is used. However this
> function is only available if CONFIG_SERIAL_8250_CONSOLE=y (and thus
> SERIAL_8250_FSL=y).
> 
> To prepare SERIAL_8250_FSL becoming tristate and being enabled in more
> cases, check for IS_REACHABLE(CONFIG_SERIAL_8250_FSL) before making use
> of fsl8250_handle_irq(). This check is correct with and without the
> change to make SERIAL_8250_FSL modular.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: 66eff0ef528b ("powerpc/legacy_serial: Warn about 8250 devices operated without active FSL workarounds")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  arch/powerpc/kernel/legacy_serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
> index fdbd85aafeb1..6ee65741dbd5 100644
> --- a/arch/powerpc/kernel/legacy_serial.c
> +++ b/arch/powerpc/kernel/legacy_serial.c
> @@ -510,7 +510,7 @@ static void __init fixup_port_irq(int index,
>  
>  	if (IS_ENABLED(CONFIG_SERIAL_8250) &&
>  	    of_device_is_compatible(np, "fsl,ns16550")) {
> -		if (IS_REACHABLE(CONFIG_SERIAL_8250)) {
> +		if (IS_REACHABLE(CONFIG_SERIAL_8250_FSL)) {
>  			port->handle_irq = fsl8250_handle_irq;
>  			port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
>  		} else {

-- 
~Randy
