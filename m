Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562A3733DF5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 06:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjFQEVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 00:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFQEVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 00:21:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1688CE4F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 21:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=iVbL06ecvTbKJLIW9R0V3emDT+EiFhX0womXFV5J6Qk=; b=XlCFgO/IgjShb1qecHAHHOAup8
        qDju1SLo3IbvU8gcFhB7gTeTZtAdD4SoNW9BCRjGPBHXlQPqlQpKGlXoxpqwSoW9bxgZbkiGyhgEj
        KVK6jYraANXMzCAzR1oEf1fxbhRpxeQMZIFcj0HzAmNR+DwsRxNR0etR0LXeLkkfZBjZ2GShDPPmk
        yPEC0uXng1E1IpSqYas6+7/Izyo8k9tWXRzvkyRI+fBRJvLV9MimUj1MNPEGdtUXM76WM3PORiPb8
        +qxIcnLa6X7FUsFbdPLT/QNIz/YhEvd6P3Pe+HGNm74XlJRq/JcJQ6+LAP1q05llni8YsdSNNRTfT
        Pp6rIOGA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qANR7-002gKb-17;
        Sat, 17 Jun 2023 04:21:17 +0000
Message-ID: <87367afc-102e-d6cc-e51e-74170a08b2cc@infradead.org>
Date:   Fri, 16 Jun 2023 21:21:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 3/4] ASoC: loongson: add PCI dependency
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Yingkun Meng <mengyingkun@loongson.cn>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20230616090156.2347850-1-arnd@kernel.org>
 <20230616090156.2347850-3-arnd@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230616090156.2347850-3-arnd@kernel.org>
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
> The new driver fails to build when PCI is disabled:
> 
> WARNING: unmet direct dependencies detected for SND_SOC_LOONGSON_I2S_PCI
>   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && (LOONGARCH || COMPILE_TEST [=y]) && PCI [=n]
>   Selected by [y]:
>   - SND_SOC_LOONGSON_CARD [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && (LOONGARCH || COMPILE_TEST [=y])
> sound/soc/loongson/loongson_i2s_pci.c:167:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
> module_pci_driver(loongson_i2s_driver);
> 
> Add the appropriate Kconfig dependency.
> 
> Fixes: d24028606e764 ("ASoC: loongson: Add Loongson ASoC Sound Card Support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  sound/soc/loongson/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/loongson/Kconfig b/sound/soc/loongson/Kconfig
> index c175f9de19a85..b8d7e2bade246 100644
> --- a/sound/soc/loongson/Kconfig
> +++ b/sound/soc/loongson/Kconfig
> @@ -16,6 +16,7 @@ config SND_SOC_LOONGSON_I2S_PCI
>  config SND_SOC_LOONGSON_CARD
>  	tristate "Loongson Sound Card Driver"
>  	select SND_SOC_LOONGSON_I2S_PCI
> +	depends on PCI
>  	help
>  	  Say Y or M if you want to add support for SoC audio using
>  	  loongson I2S controller.

-- 
~Randy
