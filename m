Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1528748460
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjGEMsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 08:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjGEMsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:48:03 -0400
X-Greylist: delayed 338 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 05 Jul 2023 05:48:02 PDT
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8686210F2
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 05:48:02 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4Qwznn5sDyz1sCmg;
        Wed,  5 Jul 2023 14:42:19 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
        by mail.m-online.net (Postfix) with ESMTP id 4Qwznl3pqnz1qqlS;
        Wed,  5 Jul 2023 14:42:19 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id pJuIkn5i2kHi; Wed,  5 Jul 2023 14:42:18 +0200 (CEST)
X-Auth-Info: Ht0IrB5uAPOK6IPKJOEcKqEev/bYMzar3ekJLEIIQToE4+G9hIJnp0rewOimfn4Y
Received: from hawking (unknown [81.95.8.244])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed,  5 Jul 2023 14:42:18 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Minjie Du <duminjie@vivo.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-m68k@lists.linux-m68k.org (open list:M68K ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list),
        opensource.kernel@vivo.com
Subject: Re: [PATCH v1] m68k: apollo: Remove a duplicate assignment in
 dn_timer_int
In-Reply-To: <20230705121307.17204-1-duminjie@vivo.com> (Minjie Du's message
        of "Wed, 5 Jul 2023 20:13:07 +0800")
References: <20230705121307.17204-1-duminjie@vivo.com>
X-Yow:  Are you mentally here at Pizza Hut??
Date:   Wed, 05 Jul 2023 14:42:18 +0200
Message-ID: <mvm4jmisf6d.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 05 2023, Minjie Du wrote:

> Delete a duplicate statement from this function implementation.
>
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>  arch/m68k/apollo/config.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/m68k/apollo/config.c b/arch/m68k/apollo/config.c
> index 42a8b8e2b..5645d2018 100644
> --- a/arch/m68k/apollo/config.c
> +++ b/arch/m68k/apollo/config.c
> @@ -173,7 +173,6 @@ irqreturn_t dn_timer_int(int irq, void *dev_id)
>  	legacy_timer_tick(1);
>  	timer_heartbeat();
>  
> -	x = *(volatile unsigned char *)(apollo_timer + 3);
>  	x = *(volatile unsigned char *)(apollo_timer + 5);

They are not the same: 3 != 5.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
