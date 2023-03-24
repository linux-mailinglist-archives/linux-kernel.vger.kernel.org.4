Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2F76C763E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 04:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjCXDcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 23:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCXDca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 23:32:30 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE03318AB9;
        Thu, 23 Mar 2023 20:32:28 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8Dxj83LGR1k3ZMQAA--.25223S3;
        Fri, 24 Mar 2023 11:32:27 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxLL7KGR1kFtwKAA--.4497S3;
        Fri, 24 Mar 2023 11:32:26 +0800 (CST)
Subject: Re: [PATCH v2 2/2] spi: loongson: add bus driver for the loongson spi
 controller
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230317082950.12738-1-zhuyinbo@loongson.cn>
 <20230317082950.12738-3-zhuyinbo@loongson.cn>
 <68b6034f-8305-4854-a4c9-962be988ade7@sirena.org.uk>
 <9b7aff76-eff4-3b82-d7af-a723fbf21a32@loongson.cn>
 <9917d619-1104-4040-bb6f-c564fcf72806@sirena.org.uk>
 <5c281b1a-b6a7-c62e-6247-5d82ebd5e0d6@loongson.cn>
 <f7811b40-80a3-4985-b92d-1df3e28a0935@sirena.org.uk>
 <2337f45f-c513-1b10-ccfc-766363c5fd02@loongson.cn>
 <75a40be0-8eaa-4c9b-87dc-382c2a2af439@sirena.org.uk>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <3a0417f2-9e2d-7464-64fe-31d10b168f21@loongson.cn>
Date:   Fri, 24 Mar 2023 11:32:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <75a40be0-8eaa-4c9b-87dc-382c2a2af439@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxLL7KGR1kFtwKAA--.4497S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvdXoW7JFyDuFyftw1fZr45GrWkCrg_yoW3Zrb_Cw
        4vqr1rZrWUJw4UJw1DGw1UZrnrJrWUKa4UAF45Ar40qw15XFn5Jrn8Gws3JFy7Cr4Iyr98
        Jr4rW3yfArW7JjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        27CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2
        IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84AC
        jcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM2
        8EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l
        57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCF04k20xvE74
        AGY7Cv6cx26rWl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
        0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMI
        IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
        Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07Uio7NUUUUU=
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/3/23 下午9:59, Mark Brown 写道:
> On Thu, Mar 23, 2023 at 08:46:19PM +0800, zhuyinbo wrote:
>
>> I think add following change and that issue what you said will can be
>> fixed,   in addition, the spin_lock
>> was also not needed.   Do you think so?
>> @@ -101,8 +101,10 @@ static int loongson_spi_setup(struct spi_device *spi)
>>          if (spi->chip_select >= spi->master->num_chipselect)
>>                  return -EINVAL;
>>
>> +       loongson_spi->hz = 0;
>> +       loongson_spi->mode &= SPI_NO_CS;
>> +
>>          spin_lock(&loongson_spi->lock);
>> -       loongson_spi_update_state(loongson_spi, spi, NULL);
> Looks plausible, yes - I'd need to see the full thing to verify.

okay, I will send v3.

