Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7161D700254
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 10:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239999AbjELIMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 04:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbjELIMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 04:12:23 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A62538F;
        Fri, 12 May 2023 01:12:21 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8Bxa+rj9F1k3g0IAA--.13603S3;
        Fri, 12 May 2023 16:12:19 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx08Tg9F1kpixXAA--.23647S3;
        Fri, 12 May 2023 16:12:17 +0800 (CST)
Subject: Re: [PATCH v9 2/2] spi: loongson: add bus driver for the loongson spi
 controller
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230426071045.20753-1-zhuyinbo@loongson.cn>
 <20230426071045.20753-3-zhuyinbo@loongson.cn> <ZFkPZhF8QqScXAmH@surfacebook>
 <ZFnOZptCM7JDFTQz@finisterre.sirena.org.uk>
 <CAHp75VcqQR0fFdkWG2QgXG0+SnKDs6_Zze6GMt+pHHEdE+8hkg@mail.gmail.com>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <f03977b9-884c-93a1-d1cf-81e6fcf51dfc@loongson.cn>
Date:   Fri, 12 May 2023 16:12:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcqQR0fFdkWG2QgXG0+SnKDs6_Zze6GMt+pHHEdE+8hkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx08Tg9F1kpixXAA--.23647S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxXry5Aw48XrW3XrWxAF4DCFg_yoW5Xw47pF
        4avw15KF1Sy34xZrn5Ar93WF1jvry3GFnrXFZFvr4Uta98Xw1Iq345WF1xCrWayF98ZF1r
        uFW8urWkGFn5uaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bxxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487
        Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l42xK82IY6x
        8ErcxFaVAv8VWrMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
        x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrw
        CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
        80aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzgAwDUUUU
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/10 下午3:03, Andy Shevchenko 写道:
> 
> _original_
> 
>         const char rdiv[12] = {0, 1, 4, 2, 3, 5, 6, 7, 8, 9, 10, 11};
> 
>                 div = DIV_ROUND_UP_ULL(loongson_spi->clk_rate, hz);
>                 if (div < 2)
>                         div = 2;
>                 if (div > 4096)
>                         div = 4096;
> 
>                 bit = fls(div) - 1;
>                 if ((1<<bit) == div)
>                         bit--;
>                 div_tmp = rdiv[bit];
> 
>                 loongson_spi->spcr = div_tmp & 3;
>                 loongson_spi->sper = (div_tmp >> 2) & 3;
> 
> _proposed_
> 
>         const char rdiv[12] = {0, 1, 4, 2, 3, 5, 6, 7, 8, 9, 10, 11};
> 
> // as far as I understood the above table
> 00 00  [0]  <= 2
> 00 01  [1]  <= 4
> 01 00  [2]  <= 8
> 00 10  [3]  <= 16
> 00 11  [4]  <= 32
> 01 01  [5]  <= 64
> 01 10  [6]  <= 128
> 01 11  [7]  <= 256
> 10 00  [8]  <= 512
> 10 01  [9]  <= 1024
> 10 10  [10]  <= 2048
> 10 11  [11]  <= 4096
> 
>                 div =
> clamp_val(DIV_ROUND_UP_ULL(loongson_spi->clk_rate, hz), 2, 4096);
>                 div_tmp = rdiv[fls(div - 1)];
> 
>                 loongson_spi->spcr = (div_tmp & GENMASK(1, 0)) >> 0;
>                 loongson_spi->sper = (div_tmp & GENMASK(3, 2)) >> 2;
> 
> But TBH I would expect the author to think about it more.


In previous code, if mode need to be updated but clk not to be updated
then the clk settting code will be also run.  so, I think it is better
to confiure clk and mode separately.

if (hz && loongson_spi->hz != hz) {
        div = clamp_val(DIV_ROUND_UP_ULL(loongson_spi->clk_rate, hz), 2,
                       4096);
        div_tmp = rdiv[fls(div - 1)];
        loongson_spi->spcr = (div_tmp & GENMASK(1, 0)) >> 0;
        loongson_spi->sper = (div_tmp & GENMASK(3, 2)) >> 2;
        val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG);
        loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG,
			(val & ~3) | loongson_spi->spcr);
        val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPER_REG);
        loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG,
                        (val & ~3) |loongson_spi->sper);
         loongson_spi->hz = hz;
}

if ((spi->mode ^ loongson_spi->mode) & SPI_MODE_X_MASK) {
        val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG);
        val &= ~(LOONGSON_SPI_SPCR_CPOL | LOONGSON_SPI_SPCR_CPHA);
        if (spi->mode & SPI_CPOL)
		val |= LOONGSON_SPI_SPCR_CPOL;
        if (spi->mode & SPI_CPHA)
		val |= LOONGSON_SPI_SPCR_CPHA;
        loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, val);
        loongson_spi->mode |= spi->mode;
}

> 
> Also the check can be modified to have less indented code:
> 
>         if (hz && loongson_spi->hz == hz)
>            return 0;
> 
>         if (!((spi->mode ^ loongson_spi->mode) & SPI_MODE_X_MASK))
>            return 0;

The setting register about clk and mode was the same SPCR register, so
only the clk and mode don't need to be updated in the same, then return 
0, so the code seems to be as follows. But setting clk and mode 
separately doesn't require follows judgement.

         if ((hz && loongson_spi->hz == hz) &&
             !((spi->mode ^ loongson_spi->mode) & SPI_MODE_X_MASK))
                 return 0;

Thanks.

> 
> 
> 

