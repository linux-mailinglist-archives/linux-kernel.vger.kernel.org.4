Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7592774C920
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 01:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjGIXqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 19:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGIXqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 19:46:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E4210C
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 16:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=U4MfIrzJS8GjdX26B+pip67X45wUubmm5v3gJX/2N8M=; b=2LTAI9eMDFwd+iXa4PCbCOG7Kj
        CbUC9flkUQ788kF0WLahq1pCV/jGg+I/Tyf79keDgTgEjLp7nsWW2HDuPgCUGhSZMFaQ6N8tpNm7+
        RC05iWIG6WrSzFkA14hfeUwt28IQhV8OQQaWYHSRJgJ/yaPURpRNQ1iAl7OsX86f8hQfSx1gETGU7
        tFxdmvHC+2bcgq652593YWkNCx9r2czLAamM7IRE9gC2/joG60fP7VvPp979/GDA+baddSDaqeM+3
        SEi5EO5UabUBFA1aoDm28RctE7PemuLr6itBG9UOCabpnGafSeV7nR8ACu0kHnI3A26ejLLl5TjSP
        zA7gAxAw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qIe6R-009uOf-33;
        Sun, 09 Jul 2023 23:46:09 +0000
Message-ID: <b32ae8af-7950-c725-5632-6ec13420bf77@infradead.org>
Date:   Sun, 9 Jul 2023 16:46:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] init: Don't proxy console= to earlycon
Content-Language: en-US
To:     Raul E Rangel <rrangel@chromium.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     mario.limonciello@amd.com, kramasub@chromium.org,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Li Zhe <lizhe.67@bytedance.com>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Zhou jie <zhoujie@nfschina.com>
References: <20230707191721.1.Id08823b2f848237ae90ce5c5fa7e027e97c33ad3@changeid>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230707191721.1.Id08823b2f848237ae90ce5c5fa7e027e97c33ad3@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/7/23 18:17, Raul E Rangel wrote:
> Right now we are proxying the `console=XXX` command line args to the
> param_setup_earlycon. This is done because the following are
> equivalent:
> 
>     console=uart[8250],mmio,<addr>[,options]
>     earlycon=uart[8250],mmio,<addr>[,options]
> 
> In addition, when `earlycon=` or just `earlycon` is specified on the
> command line, we look at the SPCR table or the DT to extract the device
> options.
> 
> When `console=` is specified on the command line, it's intention is to
> disable the console. Right now since we are proxying the `console=`

How do you figure this (its intention is to disable the console)?

> flag to the earlycon handler, we enable the earlycon_acpi_spcr_enable
> variable when an SPCR table is present. This means that we
> inadvertently enable the earlycon.
> 
> This change makes it so we only proxy the console= command if it's
> value is not empty. This way we can correctly handle both cases.
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> ---
> 
>  init/main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/init/main.c b/init/main.c
> index aa21add5f7c54..f72bf644910c1 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -738,8 +738,7 @@ static int __init do_early_param(char *param, char *val,
>  	for (p = __setup_start; p < __setup_end; p++) {
>  		if ((p->early && parameq(param, p->str)) ||
>  		    (strcmp(param, "console") == 0 &&
> -		     strcmp(p->str, "earlycon") == 0)
> -		) {
> +		     strcmp(p->str, "earlycon") == 0 && val && val[0])) {
>  			if (p->setup_func(val) != 0)
>  				pr_warn("Malformed early option '%s'\n", param);
>  		}

-- 
~Randy
