Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657C172ADD7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 19:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjFJRmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 13:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjFJRmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 13:42:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7553594;
        Sat, 10 Jun 2023 10:42:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D678A60B07;
        Sat, 10 Jun 2023 17:42:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA234C433EF;
        Sat, 10 Jun 2023 17:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686418964;
        bh=PahXCgyPj76KySfEBE99L6HcX3V7pO0Pti25w6elUbg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GAijoixuha5UwXmNzveDG/CArdpP5R3fMR4KZqIHapHWVoalTSdR7ynG7SjFszTGU
         Tuhw6LFmFSuH+byUFgLEMIh5D1QLlsdp4AOrjqj/Mr33xdoRzhH5XK/V0+fo7Od0xz
         xdjn0Lg5zBqamZKNwiTpOpB5zUPgL132+Se9iGJpkGOlce+ZNBB6RslUxE1lFvFRfS
         FQCjcsG0NSndD9SFcph0M+NvyVxCTsxRo03e0Dk14fm+fAfrX8u9OEf3uudDq0/zps
         K0zeNDpovJBDLn9+eedXInW2+Fas2J9EVIB+uQJqb44LIfYXA5IiHLxjv4rMZaWX6K
         HQEEx5nHkfcnw==
Date:   Sat, 10 Jun 2023 18:59:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     andy.shevchenko@gmail.com
Cc:     George Stark <gnstark@sberdevices.ru>, lars@metafoo.de,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        andriy.shevchenko@linux.intel.com, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@sberdevices.ru
Subject: Re: [PATCH v3] meson saradc: fix clock divider mask length
Message-ID: <20230610185918.7c85b66e@jic23-huawei>
In-Reply-To: <ZH-4qsNcLGiQFiSE@surfacebook>
References: <20230606165357.42417-1-gnstark@sberdevices.ru>
        <ZH-4qsNcLGiQFiSE@surfacebook>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2023 01:52:26 +0300
andy.shevchenko@gmail.com wrote:

> Tue, Jun 06, 2023 at 07:53:57PM +0300, George Stark kirjoitti:
> > According to datasheets of supported meson SOCs length of ADC_CLK_DIV  
> 
> the datasheets
> 
> > field is 6 bits long. Although all supported SOCs have the register  
> 
> 6-bit
> 
> > with that field documented later SOCs use external clock rather than
> > ADC internal clock so this patch affects only meson8 family (S8* SOCs)  
> 
> s/SOC/SoC/g, and mind the grammar period at the end.
> 
> I believe Jonathan can fix when applying this, no need to resend unless
> he asks for it.
> 
Indeed - done and applied to the fixes-togreg branch of iio.git + marked it
for stable inclusion.

Thanks,

Jonathan

> FWIW,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> > Fixes: 3adbf3427330 ("iio: adc: add a driver for the SAR ADC found in Amlogic Meson SoCs")
> > Signed-off-by: George Stark <GNStark@sberdevices.ru>
> > ---
> > Changelog:
> > 
> > v1 -> v2:
> >     * Update commit message
> > v2 -> v3:
> >     * Update commit message
> > ---
> >  drivers/iio/adc/meson_saradc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> > index 85b6826cc10c..b93ff42b8c19 100644
> > --- a/drivers/iio/adc/meson_saradc.c
> > +++ b/drivers/iio/adc/meson_saradc.c
> > @@ -72,7 +72,7 @@
> >  	#define MESON_SAR_ADC_REG3_PANEL_DETECT_COUNT_MASK	GENMASK(20, 18)
> >  	#define MESON_SAR_ADC_REG3_PANEL_DETECT_FILTER_TB_MASK	GENMASK(17, 16)
> >  	#define MESON_SAR_ADC_REG3_ADC_CLK_DIV_SHIFT		10
> > -	#define MESON_SAR_ADC_REG3_ADC_CLK_DIV_WIDTH		5
> > +	#define MESON_SAR_ADC_REG3_ADC_CLK_DIV_WIDTH		6
> >  	#define MESON_SAR_ADC_REG3_BLOCK_DLY_SEL_MASK		GENMASK(9, 8)
> >  	#define MESON_SAR_ADC_REG3_BLOCK_DLY_MASK		GENMASK(7, 0)
> >  
> > -- 
> > 2.38.4
> >   
> 

