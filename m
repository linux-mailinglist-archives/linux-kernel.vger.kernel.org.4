Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75686E754A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjDSIdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjDSIdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:33:40 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74AA5FFB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:33:37 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230419083336epoutp03105d4e31f46dc62e8051780324782192~XSPgRppdx0417104171epoutp038
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 08:33:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230419083336epoutp03105d4e31f46dc62e8051780324782192~XSPgRppdx0417104171epoutp038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681893216;
        bh=XHsuNadn/iE+cawL88J/SImnpBIjMhhL21nKEUAkdKw=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=DH7uRPtjdVX/AivSySeK1cxSyw5mFnrPpCEwzR0sY0an+k8CfzrDaY4T546eHT2zZ
         nX0gM+hNPFCsO0gF1DTtCvc+79PfC4a4fyNhYqFWG2UjreLZ7uBfLnrOsem99yic0n
         4y03EwsK1J9WD1JkUQdPaIs1cFNToBjx+tKXdZ0o=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230419083335epcas2p3133e8d63f365867470d38694ee548943~XSPf4lDkH2053320533epcas2p3H;
        Wed, 19 Apr 2023 08:33:35 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.99]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Q1YwH2Tpdz4x9Q7; Wed, 19 Apr
        2023 08:33:35 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        07.BA.09650.F57AF346; Wed, 19 Apr 2023 17:33:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230419083334epcas2p14d892bba96a6df17cc32c703c4bd88cf~XSPfHb4zD0854008540epcas2p17;
        Wed, 19 Apr 2023 08:33:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230419083334epsmtrp2ec035a3e0fcd7ddb304f03a1fe73b89f~XSPfGp4Lc1076410764epsmtrp2U;
        Wed, 19 Apr 2023 08:33:34 +0000 (GMT)
X-AuditID: b6c32a48-5dcdca80000025b2-c0-643fa75f1f35
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5D.44.08279.E57AF346; Wed, 19 Apr 2023 17:33:34 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230419083334epsmtip1427e90ec286d845a0cffd3bb2ac6aa2c~XSPe55g2e0549305493epsmtip1F;
        Wed, 19 Apr 2023 08:33:34 +0000 (GMT)
Message-ID: <e29c3c88-e487-75da-662b-6720a1ef1dc6@samsung.com>
Date:   Wed, 19 Apr 2023 17:31:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/4] spi: s3c64xx: changed to PIO mode if there is no
 DMA
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>, Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
From:   Jaewon Kim <jaewon02.kim@samsung.com>
In-Reply-To: <41ebe41f-d773-7cc3-dcad-8574c858645e@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7bCmmW78cvsUgz8XBC0ezNvGZrH4x3Mm
        i6kPn7BZXN6vbbH39VZ2i02Pr7FaXN41h81ixvl9TBaNH2+yO3B6XF/yidlj06pONo871/aw
        eWxeUu/Rt2UVo8fnTXIBbFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJ
        uam2Si4+AbpumTlANykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL
        89L18lJLrAwNDIxMgQoTsjM2bXjPXtAuUHFw8lbGBsYbPF2MnBwSAiYSH+90MoHYQgI7GCV6
        b4p3MXIB2Z8YJf7vmMwO4XxjlPg3fyc7TMflKzfYIBJ7GSUWbZnCCuG8ZpSYe2IW0CwODl4B
        O4lnJ6RBGlgEVCUmHn/AAmLzCghKnJz5BMwWFYiWWLxvCpgtLBAkseTffbAzmAXEJW49mc8E
        MlNEYDGjRN/jT2DbmAU2MkpsbpoKdgabgLbE9/WLWUGWcQItu3IiBqJZXmL72znMIPUSAks5
        JHqm9bFBnO0i0d7zDsoWlnh1fAvUO1ISn9/thYpnS7RP/8MKYVdIXNwwGypuLDHrWTsjyC5m
        AU2J9bv0QUwJAWWJI7dYINbySXQc/ssOEeaV6GgTgmhUk7g/9RzUEBmJSUdWMkHYHhJXOrYx
        T2BUnIUUKrOQfD8LyTOzEPYuYGRZxSiWWlCcm55abFRgAo/r5PzcTYzg1KrlsYNx9tsPeocY
        mTgYDzFKcDArifCecbVKEeJNSaysSi3Kjy8qzUktPsRoCoybicxSosn5wOSeVxJvaGJpYGJm
        ZmhuZGpgriTO+7FDOUVIID2xJDU7NbUgtQimj4mDU6qByb4zy2/lCuEEGbXVfyZNf+uzM0/2
        1Ou382on+rseVcxVXMseMFlG5NzsoKQonqt/FCZm+4TlPzs83ZN/y4kPxt/YZWrP7L577d6D
        tb+vXXwo/f4/Z4KJb3HWX5FnrtKSe5Pfcjzt5rqwunV9pt7Heo3bF3PqM1NaxRwNU/Zrnjtm
        smPDzZD5EwqDDgY2N6gVHfm7cMG0reueb7jz117Oer/JjefWAht/1v7wMfQ1MZFVEf31quqp
        nd221Vpis5iWcLa+nd7RyxTOxqNe6fxiE1/LM7ezMaIq2+wj1Fae4zxyaOauwLl3eRR1+dZx
        8quy994o3Motws36ymGxSVxayEV55aUv5cQ8Fy+Yx9dhoMRSnJFoqMVcVJwIAPFIeLA2BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJTjduuX2Kwf9mI4sH87axWSz+8ZzJ
        YurDJ2wWl/drW+x9vZXdYtPja6wWl3fNYbOYcX4fk0Xjx5vsDpwe15d8YvbYtKqTzePOtT1s
        HpuX1Hv0bVnF6PF5k1wAWxSXTUpqTmZZapG+XQJXxqYN79kL2gUqDk7eytjAeIOni5GTQ0LA
        ROLylRtsXYxcHEICuxkl7m6+xQSRkJFY/qyPDcIWlrjfcoQVouglo8SE9d0sXYwcHLwCdhLP
        TkiD1LAIqEpMPP6ABcTmFRCUODnzCZgtKhAtcWP5N7CZwgJBEkv+3QezmQXEJW49mc8EMlNE
        YDGjRMelt+wgDrPARkaJldfXM4NUCQn8ZJSYdT8IxGYT0Jb4vn4xK8hiTqDFV07EQAwyk+ja
        2sUIYctLbH87h3kCo9AsJHfMQrJvFpKWWUhaFjCyrGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L
        10vOz93ECI4oLc0djNtXfdA7xMjEwXiIUYKDWUmE94yrVYoQb0piZVVqUX58UWlOavEhRmkO
        FiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTM7HLV4LNP8ISzzxlb/jVmb8O4UpRnJTT+Ra
        h4bwb/ows+C/m2TbMw6+tbND1LYs0rxi36/mu+63m3a6wIrqT+Lv+U5u49iZ5Z1q138p+hWD
        TnDHmhbJsrjYf5d/v7p8Iit8furz4zarih7uNpn4ep69bbesfseK6uPbP13hm/oyKrqGt3Kv
        xNz6pIUZRc28n2Sc5pwo+2Jsd9dC94upZ69Y+/I2ee/Dkt3Ms+e2pH2s6NoRu69PZqbUT/fo
        VXMfczT8ERdnetDOkbN4o7GSwqozJm7nzAu97U2PHirpyXBePGuBFMf/FJmwpd55yZ0nppas
        bstYmjJrgfVEtW2sb1qZlKv9o/beNg3ylrJQYinOSDTUYi4qTgQAxa0jGxcDAAA=
X-CMS-MailID: 20230419083334epcas2p14d892bba96a6df17cc32c703c4bd88cf
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
        <41ebe41f-d773-7cc3-dcad-8574c858645e@linaro.org>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23. 4. 19. 17:03, Krzysztof Kozlowski wrote:
> On 19/04/2023 08:06, Jaewon Kim wrote:
>> Polling mode supported with qurik if there was no DMA in the SOC.
> typo: quirk
> You missed verb in your first part of sentence. I don't understand it.

Sorry, I change this sentence like below.

Polling mode supported as a quirk for SOCs without DMA.

>
>> However, there are cased where we cannot or do not want to use DMA.
>> To support this case, if DMA is not set, it is switched to polling mode.
>>
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
> You said it is desired option, so should not be a warning. I would make
> it debug at most.
>
Okay, I will change dev_warn() to dev_dbg().


>> +		sci->polling = 1;
>
>
> Best regards,
> Krzysztof
>
>

Thanks

Jaewon Kim

