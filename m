Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D8A63CC9F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 01:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbiK3Arj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 19:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiK3Arg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 19:47:36 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A1E0CCA;
        Tue, 29 Nov 2022 16:47:33 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 30 Nov 2022 09:47:32 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 9D8162058B4F;
        Wed, 30 Nov 2022 09:47:32 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 30 Nov 2022 09:47:32 +0900
Received: from [10.212.156.209] (unknown [10.212.156.209])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id D118AA8559;
        Wed, 30 Nov 2022 09:47:31 +0900 (JST)
Message-ID: <6c423f87-1187-b2d6-8b70-c8cd709f3ea0@socionext.com>
Date:   Wed, 30 Nov 2022 09:47:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 2/2] spi: Add Socionext F_OSPI SPI flash controller
 driver
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221124003351.7792-1-hayashi.kunihiko@socionext.com>
 <20221124003351.7792-3-hayashi.kunihiko@socionext.com>
 <CAMuHMdVH+amC83uMBpsCebaHd2EWp1EO59JNcgRTncbNGNNRsQ@mail.gmail.com>
Content-Language: en-US
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <CAMuHMdVH+amC83uMBpsCebaHd2EWp1EO59JNcgRTncbNGNNRsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 2022/11/30 1:49, Geert Uytterhoeven wrote:
> Hi Hayashi-san,
> 
> On Thu, Nov 24, 2022 at 1:36 AM Kunihiko Hayashi
> <hayashi.kunihiko@socionext.com> wrote:
>> Introduce Socionext F_OSPI controller driver. This controller is used to
>> communicate with slave devices such as SPI Flash memories. It supports
>> 4 slave devices and up to 8-bit wide bus, but supports master mode only.
>>
>> This driver uses spi-mem framework for SPI flash memory access, and
>> can only operate indirect access mode and single data rate mode.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> 
> Thanks for your patch, which is now commit 1b74dd64c8612619
> ("spi: Add Socionext F_OSPI SPI flash controller driver") in
> spi/for-next.

Thank you for your work.

>> --- a/drivers/spi/Kconfig
>> +++ b/drivers/spi/Kconfig
>> @@ -906,6 +906,15 @@ config SPI_SLAVE_MT27XX
>>            say Y or M here.If you are not sure, say N.
>>            SPI slave drivers for Mediatek MT27XX series ARM SoCs.
>>
>> +config SPI_SN_F_OSPI
>> +       tristate "Socionext F_OSPI SPI flash controller"
>> +       depends on OF && HAS_IOMEM
>> +       depends on SPI_MEM
> 
> On which systems is this hardware block found?
> Perhaps this should depend on ARCH_UNIPHIER || COMPILE_TEST?

This IP doesn't depend on ARCH_UNIPHIER, so I expect that it can be widely
applied not only to ARCH_UNIPHIER.

If COMPILE_TEST is required, the dependency is like SPI_CADENCE_XSPI:
         depends on (OF || COMPILE_TEST) && HAS_IOMEM

Thank you,

---
Best Regards
Kunihiko Hayashi
