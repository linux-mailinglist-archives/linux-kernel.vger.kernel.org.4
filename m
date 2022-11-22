Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6050633FE4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 16:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbiKVPNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 10:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiKVPNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 10:13:46 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C598E248E0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 07:13:45 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oxUxx-0004aj-Cj; Tue, 22 Nov 2022 16:13:41 +0100
Message-ID: <075d8c0f-5448-73aa-bd3f-0d4e1216e87f@leemhuis.info>
Date:   Tue, 22 Nov 2022 16:13:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] ARM: at91: fix build for SAMA5D3 w/o L2 cache
Content-Language: en-US, de-DE
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <b7f8dacc-5e1f-0eb2-188e-3ad9a9f7613d@axentia.se>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <b7f8dacc-5e1f-0eb2-188e-3ad9a9f7613d@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1669130025;94552674;
X-HE-SMSGID: 1oxUxx-0004aj-Cj
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

On 12.11.22 16:40, Peter Rosin wrote:
> The L2 cache is present on the newer SAMA5D2 and SAMA5D4 families, but
> apparently not for the older SAMA5D3. At least not always.
> 
> Solves a build-time regression with the following symptom:
> 
> sama5.c:(.init.text+0x48): undefined reference to `outer_cache'
> 
> Fixes: 3b5a7ca7d252 ("ARM: at91: setup outer cache .write_sec() callback if needed")
> Signed-off-by: Peter Rosin <peda@axentia.se>

Clément Léger and Claudiu Beznea: what's up here? Is there a particular
reason why this patch did get any feedback from you by now? It's ten
days old and Peter already sent a kind of reminder a few days ago.

Reminder, ideally this regression should be fixed by now. For details
see the section "Prioritize work on fixing regressions"  in
Documentation/process/handling-regressions.rst (
https://docs.kernel.org/process/handling-regressions.html )

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

> ---
>  arch/arm/mach-at91/sama5.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Hi!
> 
> I'm not sure this is the correct solution? Maybe SAMA5D3 should bring
> in CONFIG_OUTER_CACHE unconditionally instead? But that seems like a
> bigger change, and not just a tweak of the regressing commit...
> 
> Cheers,
> Peter
> 
> diff --git a/arch/arm/mach-at91/sama5.c b/arch/arm/mach-at91/sama5.c
> index 67ed68fbe3a5..bf2b5c6a18c6 100644
> --- a/arch/arm/mach-at91/sama5.c
> +++ b/arch/arm/mach-at91/sama5.c
> @@ -26,7 +26,7 @@ static void sama5_l2c310_write_sec(unsigned long val, unsigned reg)
>  static void __init sama5_secure_cache_init(void)
>  {
>  	sam_secure_init();
> -	if (sam_linux_is_optee_available())
> +	if (IS_ENABLED(CONFIG_OUTER_CACHE) && sam_linux_is_optee_available())
>  		outer_cache.write_sec = sama5_l2c310_write_sec;
>  }
>  
