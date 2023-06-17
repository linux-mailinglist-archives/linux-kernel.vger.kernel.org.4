Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43393733DED
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 06:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjFQEI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 00:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFQEIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 00:08:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D135B3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 21:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=XjJTLM4M+2wpRQQRg7YsbZBRenTGvXDmTPhLi9n3Shc=; b=xNfRb8qDJ7cHQoKaUzsHjv1gZx
        S8w0p0SzP6AjkncxnMZ6xmecGrqsEeU8rUkmwXBj71ykL4syYeQSI5UuLKcEQP39HwmZ02QEGkT9Z
        lvup2S4DMmVhrF+Hrzz19UJUlHdKF3OO6WghnxmTtgXEm20VPww5rnGFmX5ZQuqmam96GpLSqtD/4
        0gsflKfdhlHFsyfxDNTFX/dikBIt5TY2c/M/J6TqEZqJEb3RyTv0JMx+4EJswtTAv7s+Juyc9yATa
        GBOsQ0s9PlFTHDwIczur2hof6i8wz2ea0MTsLaUdVK1ixwNm5F/92O2RgwESElXy85WxaHNvC8rFS
        G5B3kRdw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qANES-002fHE-1e;
        Sat, 17 Jun 2023 04:08:12 +0000
Message-ID: <bda1dd91-c0d0-dc24-bd8f-246a163f0fc7@infradead.org>
Date:   Fri, 16 Jun 2023 21:08:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/4] ASoC: loongson: fix unused PM function warning
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Yingkun Meng <mengyingkun@loongson.cn>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20230616090156.2347850-1-arnd@kernel.org>
 <20230616090156.2347850-2-arnd@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230616090156.2347850-2-arnd@kernel.org>
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
> Build testing without CONFIG_PM_SLEEP causes a warning:
> 
> sound/soc/loongson/loongson_i2s.c:246:12: error: unused function 'i2s_suspend' [-Werror,-Wunused-function]
> sound/soc/loongson/loongson_i2s.c:255:12: error: unused function 'i2s_resume' [-Werror,-Wunused-function]
> 
> Use the modern SYSTEM_SLEEP_PM_OPS() instead of the old one to avoid this.
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
> index 35d34568be79e..f73b6d6f16c23 100644
> --- a/sound/soc/loongson/loongson_i2s.c
> +++ b/sound/soc/loongson/loongson_i2s.c
> @@ -265,5 +265,5 @@ static int i2s_resume(struct device *dev)
>  }
>  
>  const struct dev_pm_ops loongson_i2s_pm = {
> -	SET_SYSTEM_SLEEP_PM_OPS(i2s_suspend, i2s_resume)
> +	SYSTEM_SLEEP_PM_OPS(i2s_suspend, i2s_resume)
>  };

-- 
~Randy
