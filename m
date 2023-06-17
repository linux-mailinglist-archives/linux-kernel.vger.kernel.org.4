Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1B1733DEC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 06:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjFQEHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 00:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjFQEG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 00:06:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35170B3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 21:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Xc8SGiacXIIcceBTgiX4PD/KvWxsk0L8WaZj35J7Ce8=; b=TCi1P+N+9nRjJGIQD2ds9w3y81
        Z3cdSlXp2Ba0z2eiyYeGfjbJiWXGqADpEnWyVM/cGctV9eL2OzEjL5V953Bxi6r87Y8DpCe0eQYTu
        NeFcMgI9zzBzuaHKLwLjnN5r42Bdcq7lk/5/KB8uOKhMnuSU+MSXo9jkkJ+RbLa9I0+4ksXJvKa0b
        UED7pFM6q1ztzEgwcQPqDR6dxMfj6dJP9nXuwwpBgKo2Hu8FMcKqpJPwlXOnJqqtnUjj6+MNA7jgO
        l8DT/Jlyzirh8ilW2llTjKU2OGCwLPMxrjyZBPNdoMYg/8NT2Og39hlufspo0gtH4sJvM1qMUeWvM
        rgvyIPMA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qANCw-002f8f-15;
        Sat, 17 Jun 2023 04:06:38 +0000
Message-ID: <48ddb551-496f-f4e7-96dc-30f250f97438@infradead.org>
Date:   Fri, 16 Jun 2023 21:06:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 4/4] ASoC: loongson: fix compile testing on 32-bit
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Yingkun Meng <mengyingkun@loongson.cn>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20230616090156.2347850-1-arnd@kernel.org>
 <20230616090156.2347850-4-arnd@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230616090156.2347850-4-arnd@kernel.org>
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
> DIV_ROUND_CLOSEST() does not work on 64-bit variables when building for
> a 32-bit target:
> 
> ld.lld: error: undefined symbol: __udivdi3
>>>> referenced by loongson_i2s.c
>>>>               sound/soc/loongson/loongson_i2s.o:(loongson_i2s_hw_params) in archive vmlinux.a
> 
> Use DIV_ROUND_CLOSEST_ULL() instead.
> 
> Fixes: d24028606e764 ("ASoC: loongson: Add Loongson ASoC Sound Card Support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  sound/soc/loongson/loongson_i2s.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/loongson/loongson_i2s.c b/sound/soc/loongson/loongson_i2s.c
> index f73b6d6f16c23..b919f0fe83615 100644
> --- a/sound/soc/loongson/loongson_i2s.c
> +++ b/sound/soc/loongson/loongson_i2s.c
> @@ -89,7 +89,7 @@ static int loongson_i2s_hw_params(struct snd_pcm_substream *substream,
>  		bclk_ratio = DIV_ROUND_CLOSEST(sysclk,
>  					       (bits * chans * fs * 2)) - 1;
>  		mclk_ratio = clk_rate / sysclk;
> -		mclk_ratio_frac = DIV_ROUND_CLOSEST(((u64)clk_rate << 16),
> +		mclk_ratio_frac = DIV_ROUND_CLOSEST_ULL(((u64)clk_rate << 16),
>  						    sysclk) - (mclk_ratio << 16);
>  
>  		regmap_read(i2s->regmap, LS_I2S_CFG, &val);

-- 
~Randy
