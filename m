Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE43D6EA12E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 03:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbjDUBqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 21:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbjDUBqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 21:46:18 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AC13C34
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 18:46:16 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230421014612epoutp04546ff640e827228805fe75b1f9c248f6~Xz_X5ja7h0559305593epoutp04Z
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:46:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230421014612epoutp04546ff640e827228805fe75b1f9c248f6~Xz_X5ja7h0559305593epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1682041572;
        bh=sDfE152dq+m0G2WoSxOq/e24T2vvwaOy9VFq/rfmgj0=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=rCUg8lfIDLQzeBLHUJ0ME687pVAqcZdRoxoTibF2STaXUbu8jV3j9Jz455Fgq472S
         Gu48F3Eeoizff4wYcvxhtmK+8FE+pgAxlZeBzjwNUwWeRmx8IjZJlj4oQsuTuqRdcJ
         2e9jv52bfzeK61LJpbDb6LE2zBUY+9OJxcULfKp4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230421014611epcas2p1a28689311e00ab3ba51c6d126e621c07~Xz_XVeg8K2679226792epcas2p1u;
        Fri, 21 Apr 2023 01:46:11 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.101]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Q2cnH3hRYz4x9Q0; Fri, 21 Apr
        2023 01:46:11 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        A4.7B.09650.3EAE1446; Fri, 21 Apr 2023 10:46:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230421014611epcas2p2b935acf7c36c286b101a60d394b33118~Xz_WhFzph0793207932epcas2p2R;
        Fri, 21 Apr 2023 01:46:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230421014610epsmtrp28eede8faaf9272b6c83ebbe6ed94ce7c~Xz_WgVQQa0895608956epsmtrp2d;
        Fri, 21 Apr 2023 01:46:10 +0000 (GMT)
X-AuditID: b6c32a48-023fa700000025b2-0f-6441eae31e4b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.ED.08279.2EAE1446; Fri, 21 Apr 2023 10:46:10 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230421014610epsmtip105635b2845b0d48bab79c08251daed48~Xz_WRjztt1892618926epsmtip1R;
        Fri, 21 Apr 2023 01:46:10 +0000 (GMT)
Message-ID: <222f3879-1aea-6261-e23d-9669bbcbe25c@samsung.com>
Date:   Fri, 21 Apr 2023 10:43:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/4] spi: s3c64xx: changed to PIO mode if there is no
 DMA
To:     Andi Shyti <andi.shyti@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
Content-Language: en-US
From:   Jaewon Kim <jaewon02.kim@samsung.com>
In-Reply-To: <20230419154657.h2kp7ouddy6m7l4r@intel.intel>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmue7jV44pBjNPyVg8mLeNzeL+1w5G
        i8U/njNZTH34hM3i8n5ti72vt7JbbHp8jdXi8q45bBYzzu9jsmj8eJPdgcvj+pJPzB6bVnWy
        edy5tofNY/OSeo++LasYPT5vkgtgi8q2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0
        MFdSyEvMTbVVcvEJ0HXLzAE6TEmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6g
        V5yYW1yal66Xl1piZWhgYGQKVJiQnTH1yTOmgh7hikXzPzI2MP7j62Lk5JAQMJG4umEaSxcj
        F4eQwA5Gid1zlkA5nxglTi9eyw7hfGOU6NnTxAbT0nrzPRtEYi+jxNN7Z1ghnNeMEv+mP2AE
        qeIVsJOY+WsqK4jNIqAqsfL9Mqi4oMTJmU9YQGxRgWiJxfumgNnCAkESS/7dZwKxRQTUJF4v
        /sQEMpRZ4BKTxLbW/+wgCWYBcYlbT+aDFbEJaEt8X78YbAGngJVE76LPLBA18hLb385hBmmW
        EFjKIXG3fxE7xN0uEruntDJC2MISr45vgYpLSXx+txfqt2yJ9ul/WCHsComLG2ZDxY0lZj1r
        B+rlAFqgKbF+lz6IKSGgLHHkFtRaPomOw3/ZIcK8Eh1tQhCNahL3p56DGiIjMenISiYI20Pi
        Ssc25gmMirOQQmUWkidnIXlmFsLeBYwsqxjFUguKc9NTi40KTOCxnZyfu4kRnGi1PHYwzn77
        Qe8QIxMH4yFGCQ5mJRHeM65WKUK8KYmVValF+fFFpTmpxYcYTYFxM5FZSjQ5H5jq80riDU0s
        DUzMzAzNjUwNzJXEeT92KKcICaQnlqRmp6YWpBbB9DFxcEo1MFXdmCU49Wbh71eqz07WORjM
        uHd52/yzNya7l78OdJbLtfnUs+H02sqYxJXhL67LG/LI79YUNOANnua6PPvNeTHnhkVJmnM/
        fNgx+6DAq4rf5/VExXPtlpjdmJxxo39xw+r7k5LaHzjeOK4UkdvKHl6+9pG6xUNd9elK6T8O
        rXDkeRh0QmZCkNZfBX5GzoqrFYwzzsncYzp3Yvub/Vq8H2/Wl36e+q/zlWbPeofA8+9U56ve
        mrbL99vU0C1ckadXG3jXnUvRk5K+Irvz2mubxSvdGRqO77/r9YCtP6l1ch3PJ98LOTeqVv9l
        YF1y+sf3XctmKlw7GhEU9WT50ZCsOq7YZ+YT1rCrME85Yb1sUt9uJZbijERDLeai4kQAwTnn
        jT0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJTvfRK8cUg8fzLCwezNvGZnH/awej
        xeIfz5kspj58wmZxeb+2xd7XW9ktNj2+xmpxedccNosZ5/cxWTR+vMnuwOVxfcknZo9NqzrZ
        PO5c28PmsXlJvUffllWMHp83yQWwRXHZpKTmZJalFunbJXBlTH3yjKmgR7hi0fyPjA2M//i6
        GDk5JARMJFpvvmfrYuTiEBLYzSixYt1fVoiEjMTyZ31sELawxP2WI2BxIYGXjBI7NyWD2LwC
        dhIzf00Fi7MIqEqsfL+MESIuKHFy5hMWEFtUIFrixvJvTCC2sECQxJJ/98FsEQE1ideLPzGB
        LGYWuMIk8eRiDwvEFV8ZJTbf/A82iVlAXOLWk/lgHWwC2hLf1y8G28YpYCXRu+gzC0SNmUTX
        1i6oenmJ7W/nME9gFJqF5JBZSEbNQtIyC0nLAkaWVYySqQXFuem5xYYFhnmp5XrFibnFpXnp
        esn5uZsYwdGlpbmDcfuqD3qHGJk4GA8xSnAwK4nwutvYpQjxpiRWVqUW5ccXleakFh9ilOZg
        URLnvdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXANMHR422MrnSQtNXy4wFuFmIphUk1MxXddj59
        GMBzeRvr05YnO2IaLDfPjk5zuiR1O3aFsWdne9+UbHuO1ogFWS1ZIkn1Dzo7w2eE73j2mNn6
        Vu+ag8f1Cj8+mjX3yrbPWX2Gd3PSduRFBUz22ufKeY+7xHSvvN4lyYIHQtXeJxvzVTazSPln
        nj55pmG2lPKjVo3vk8t4baXjhNV4zOZNPb475Ynw556vrxpVrjOtlZUQZgnTmNxUvaX3wfyT
        UiKXX8173rbXxNIr0FLpQKyfeX7M5++Of0uOL30wb+Nsyx+TU+e357saySUI88j9Px+np2b5
        z21C9T8L06sTVR6sWFzP33BdxveJ6LGHC9OUWIozEg21mIuKEwFtRKbQHQMAAA==
X-CMS-MailID: 20230421014611epcas2p2b935acf7c36c286b101a60d394b33118
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230419062755epcas2p1370c1ca60d88d6b114a7c7c1de3f15c0
References: <20230419060639.38853-1-jaewon02.kim@samsung.com>
        <CGME20230419062755epcas2p1370c1ca60d88d6b114a7c7c1de3f15c0@epcas2p1.samsung.com>
        <20230419060639.38853-2-jaewon02.kim@samsung.com>
        <20230419154657.h2kp7ouddy6m7l4r@intel.intel>
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,


On 23. 4. 20. 00:46, Andi Shyti wrote:
> Hi Jaewon,
>
> On Wed, Apr 19, 2023 at 03:06:36PM +0900, Jaewon Kim wrote:
>> Polling mode supported with qurik if there was no DMA in the SOC.
> I think you want to say here that "Through quirks we choose to
> use polling mode whenever there is no DMA in the SoC".
>
>> However, there are cased where we cannot or do not want to use DMA.
> /cased/cases/
>
>> To support this case, if DMA is not set, it is switched to polling mode.
> You haven't really described what you are doing here... you could
> just write something like: "Use DTS properties to select wether
> to use polling or DMA mode."
>
> Side note, please use the imperative form when you want to
> describe what you have done to fix the issue.


Thanks for guide.

I will change description in v3.


>
>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>> ---
>>   drivers/spi/spi-s3c64xx.c                 | 8 ++++++--
>>   include/linux/platform_data/spi-s3c64xx.h | 1 +
>>   2 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> index 71d324ec9a70..273aa02322d9 100644
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -19,7 +19,6 @@
>>   #include <linux/platform_data/spi-s3c64xx.h>
>>   
>>   #define MAX_SPI_PORTS		12
>> -#define S3C64XX_SPI_QUIRK_POLL		(1 << 0)
>>   #define S3C64XX_SPI_QUIRK_CS_AUTO	(1 << 1)
>>   #define AUTOSUSPEND_TIMEOUT	2000
>>   
>> @@ -116,7 +115,7 @@
>>   #define S3C64XX_SPI_TRAILCNT		S3C64XX_SPI_MAX_TRAILCNT
>>   
>>   #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
>> -#define is_polling(x)	(x->port_conf->quirks & S3C64XX_SPI_QUIRK_POLL)
>> +#define is_polling(x)	(x->cntrlr_info->polling)
>>   
>>   #define RXBUSY    (1<<2)
>>   #define TXBUSY    (1<<3)
>> @@ -1067,6 +1066,11 @@ static struct s3c64xx_spi_info *s3c64xx_spi_parse_dt(struct device *dev)
>>   		sci->num_cs = temp;
>>   	}
>>   
>> +	if (!of_find_property(dev->of_node, "dmas", NULL)) {
>> +		dev_warn(dev, "cannot find DMA, changed to PIO mode\n");
>> +		sci->polling = 1;
> 	sci->polling = true;
>
> But it could be even better:
>
> 	sci->polling = !of_find_property(dev->of_node, "dmas", NULL));
>
> and you get rid of the dev_warn() that is not required.
>
> Andi


Okay, I will change 1 to 'true'..


Thanks

Jaewon Kim

