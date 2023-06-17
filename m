Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7B3733DEE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 06:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjFQEKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 00:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFQEKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 00:10:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F067B3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 21:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=aBPG/1s8UFTtWCYq3+C+Ner90XZt71tgP7YOAinQcyc=; b=a21tWsBFH4ruU+tZeR4vNB2qsc
        tb/ZKwVhElnZNLbSy6/24ht28PpmIP4HvsKHRaA9cThGZB9+j7Ni6jHEeqRQ64wuRtYHCWsF0WJt2
        KazNfCtw0ExX46AWS85Vwo3DS9l2ojI/2bFlOxBogXl4K2rIuqVHWki/lDoMhdenDi3FSQy2scu9z
        gaR2BdJY9JA41hSD6lvRr6aKoPsvsKg0i5TcfFjWhkjBTNtTlPWb5X3wOY5XhemlBK0Hgjo7Q3EF1
        d1rIVhj3nXGFNtf9HuHroCKIY1W9iOCI8+h9uP73CN6D8SOOuxu+gXGRuQCVj/iCAgu8eWX+XiDte
        dIOD/LIg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qANGi-002fPF-1b;
        Sat, 17 Jun 2023 04:10:32 +0000
Message-ID: <44b75227-adbe-831c-1955-8e4ae4a03c9f@infradead.org>
Date:   Fri, 16 Jun 2023 21:10:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/4] ASoC: max98388: fix unused function warnings
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Ryan Lee <ryans.lee@analog.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20230616090156.2347850-1-arnd@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230616090156.2347850-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/23 02:00, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The PM functions are never referenced when CONFIG_PM_SLEEP is
> disabled:
> 
> sound/soc/codecs/max98388.c:854:12: error: unused function 'max98388_suspend' [-Werror,-Wunused-function]
> static int max98388_suspend(struct device *dev)
>            ^
> sound/soc/codecs/max98388.c:864:12: error: unused function 'max98388_resume' [-Werror,-Wunused-function]
> static int max98388_resume(struct device *dev)
> 
> Fix this by using the modern SYSTEM_SLEEP_PM_OPS() macro in place of
> the deprecated SET_SYSTEM_SLEEP_PM_OPS() version, and use pm_sleep_ptr()
> to hide the entire structure as well.
> 
> On a related note, the of_match_ptr() and ACPI_PTR() macros have the same
> problem and would cause the device id table to be unused when the driver
> is built-in and the respective subsystems are disabled. This does not
> cause warnings unless -Wunused-const-variable is passed to the compiler,
> but it's better to just not use the macros at all here.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  sound/soc/codecs/max98388.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/codecs/max98388.c b/sound/soc/codecs/max98388.c
> index 8062a71150074..3d03c4bac6c55 100644
> --- a/sound/soc/codecs/max98388.c
> +++ b/sound/soc/codecs/max98388.c
> @@ -873,7 +873,7 @@ static int max98388_resume(struct device *dev)
>  }
>  
>  static const struct dev_pm_ops max98388_pm = {
> -	SET_SYSTEM_SLEEP_PM_OPS(max98388_suspend, max98388_resume)
> +	SYSTEM_SLEEP_PM_OPS(max98388_suspend, max98388_resume)
>  };
>  
>  static const struct regmap_config max98388_regmap = {
> @@ -998,9 +998,9 @@ MODULE_DEVICE_TABLE(acpi, max98388_acpi_match);
>  static struct i2c_driver max98388_i2c_driver = {
>  	.driver = {
>  		.name = "max98388",
> -		.of_match_table = of_match_ptr(max98388_of_match),
> -		.acpi_match_table = ACPI_PTR(max98388_acpi_match),
> -		.pm = &max98388_pm,
> +		.of_match_table = max98388_of_match,
> +		.acpi_match_table = max98388_acpi_match,
> +		.pm = pm_sleep_ptr(&max98388_pm),
>  	},
>  	.probe = max98388_i2c_probe,
>  	.id_table = max98388_i2c_id,

-- 
~Randy
