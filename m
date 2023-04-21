Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B276EA218
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 05:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjDUDB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 23:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbjDUDBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 23:01:33 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895FB6A7C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 20:01:07 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230421025541epoutp010db2ed65b3038fea48d877196d31edb9~X07CqVz6Y0241602416epoutp01J
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:55:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230421025541epoutp010db2ed65b3038fea48d877196d31edb9~X07CqVz6Y0241602416epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1682045741;
        bh=gmRmW4hTEG/NaSgyx94GE0NJvkJijzgJH6axIRgmOlM=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=YlslFHEjyzlaVJ6bu2FOMvEEF5xs3iIur75jc1/cvcGr4i3GUMFvOS59FPFcr6xa2
         BLqmAPsFp76Jj2EGpnlXWksXBexj/EhkA2Bn14HtL2SQFa0hJqw2r0aHj2gUP8LPP6
         iYw2kahZ8WvKynmsMc5bfP1U+SPEuI/s7nhXV5vw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230421025540epcas2p18f11ea2a332301a0a8818fc0820ac76d~X07CFVOcd1901919019epcas2p1P;
        Fri, 21 Apr 2023 02:55:40 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.69]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Q2fKS4Zydz4x9Q1; Fri, 21 Apr
        2023 02:55:40 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.CC.09938.C2BF1446; Fri, 21 Apr 2023 11:55:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230421025539epcas2p1dfab9151ae85e99f06b26a6a6f16f059~X07BMf-9Z2676626766epcas2p1s;
        Fri, 21 Apr 2023 02:55:39 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230421025539epsmtrp276dcd1d3eee3658e845b590971fb62bd~X07BLt9Lf1763617636epsmtrp2n;
        Fri, 21 Apr 2023 02:55:39 +0000 (GMT)
X-AuditID: b6c32a47-ca5fd700000026d2-51-6441fb2c119d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F3.A1.08609.B2BF1446; Fri, 21 Apr 2023 11:55:39 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230421025539epsmtip23e461584995611f94637289c3e523786~X07A6hlsh1284112841epsmtip29;
        Fri, 21 Apr 2023 02:55:39 +0000 (GMT)
Message-ID: <874bb3d7-9b71-2ab0-9f0c-7f4066db50a4@samsung.com>
Date:   Fri, 21 Apr 2023 11:53:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.10.0
Subject: Re: [PATCH v2 3/4] spi: s3c64xx: add sleep during transfer
Content-Language: en-US
To:     Andi Shyti <andi.shyti@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>, Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
From:   Jaewon Kim <jaewon02.kim@samsung.com>
In-Reply-To: <20230419155617.gobedupbdmdaj4kz@intel.intel>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOJsWRmVeSWpSXmKPExsWy7bCmua7Ob8cUg5MTlCwezNvGZnH/awej
        xeIfz5kspj58wmZxeb+2xd7XW9ktNj2+xmpxedccNosZ5/cxWTR+vMnuwOVxfcknZo9NqzrZ
        PO5c28PmsXlJvUffllWMHp83yQWwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpa
        mCsp5CXmptoqufgE6Lpl5gAdpqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/Q
        K07MLS7NS9fLSy2xMjQwMDIFKkzIzlj6bjVbwVT+inUrtRsYP3J3MXJySAiYSCx/9I61i5GL
        Q0hgB6NE84k2ZgjnE6PE2+cH2CCcz4wS3w5+YYNpOXGzhwkisYtRYnVbPwtIQkjgNaNE4zNn
        EJtXwE7i2e9NjCA2i4CqxJVXH1kg4oISJ2c+AbNFBaIlFu+bAmYLCzhL7Lu1lB3EZhYQl7j1
        ZD4TiC0ioCbxevEnsGXMApeYJA7MagArYhPQlvi+fjEriM0pYCVx5f0rZohmeYntb+eA/SAh
        sJRDYu3k10BncwA5LhLH3gtCfCAs8er4FnYIW0ri87u9UJ9lS7RP/8MKYVdIXNwwGypuLDHr
        WTsjyBhmAU2J9bv0ISYqSxy5xQKxlU+i4/Bfdogwr0RHmxBEo5rE/annoIbISEw6spIJwvaQ
        +D9rHssERsVZSIEyC8nzs5D8Mgth7wJGllWMYqkFxbnpqcVGBcbwqE7Oz93ECE6xWu47GGe8
        /aB3iJGJg/EQowQHs5II7xlXqxQh3pTEyqrUovz4otKc1OJDjKbAqJnILCWanA9M8nkl8YYm
        lgYmZmaG5kamBuZK4rzStieThQTSE0tSs1NTC1KLYPqYODilGpgOqc2eeO7Fjhdvc+YwVEk/
        PFFx4fNqS6WDLGH7bocudG1+eGHKXGGZWMfSOUez+jh3fplWxzBr6v1kxtJl5376T/tYJ9xz
        5txigxs/UiJPvThYvCFswuYK2wKlkJhlSzys3Ry2GR+ZW9Xy8bJU0fTb/x1V/+yed/zbwrZP
        rKumcwp7VmxUXhXB2eQgtrMpJW7OcrdXp49ein51+AfQZ/9PXU1a+XTvP7Y9lUJPn+Ta1Mp/
        0vA+N3falWsqOXd9pxUf/BHDoutnt2Py9q13mFM6J5yZveWV5LaSlOll6d4CadoHja5lcgTJ
        TVdufTZxFfv/iR3arZPK6jot2ldfnnHKweB7gemXp48CS5mfvDn7QImlOCPRUIu5qDgRADQe
        +ao6BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42LZdlhJXlf7t2OKwfw/RhYP5m1js7j/tYPR
        YvGP50wWUx8+YbO4vF/bYu/rrewWmx5fY7W4vGsOm8WM8/uYLBo/3mR34PK4vuQTs8emVZ1s
        Hneu7WHz2Lyk3qNvyypGj8+b5ALYorhsUlJzMstSi/TtErgylr5bzVYwlb9i3UrtBsaP3F2M
        nBwSAiYSJ272MHUxcnEICexglLjXPosNIiEjsfxZH5QtLHG/5QgriC0k8JJRYs0GfRCbV8BO
        4tnvTYwgNouAqsSVVx9ZIOKCEidnPgGzRQWiJW4s/8YEYgsLOEvsu7WUHcRmFhCXuPVkPlhc
        REBN4vXiT2BHMAtcYpKYPmkbK8RF95gkHs86DLaZTUBb4vv6xWA2p4CVxJX3r5ghJplJdG3t
        YoSw5SW2v53DPIFRaBaSQ2YhWTgLScssJC0LGFlWMUqmFhTnpucWGxYY5aWW6xUn5haX5qXr
        JefnbmIEx5aW1g7GPas+6B1iZOJgPMQowcGsJMJ7xtUqRYg3JbGyKrUoP76oNCe1+BCjNAeL
        kjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQamHQ95HXKuxZr0VF1x6iuK2rD40oVp9/7vtrCW
        Pfnvvb537HXjzV/neRu+VGqfUKcc3nbuzi3+NPaJb5c2qleGpa+O8s+YZ5b9+9mEyvlhOlzB
        ClFJlw+dMt6wpa10z5TAvjP2E5mbT3zaVFwup/Z7Y+B2d7cF+y+unGYct5dBhOXp3DX3AiQD
        vspEHPWX+PXBYWqyZcjah6ys87/L+Ps5bWG4ffRUnp5i4b7cgKMnf11KPVt1qO9DS0LNuSr7
        tJzddqJZkSv0bz0Lm7m8h4+16UXpo7VBp/ecq2temrqy8O4lrsVVPccX8di9nlpvtser/OKy
        fT01d1hUHCf86vm09sLM59MKuRbLaoibqVt/VWIpzkg01GIuKk4EAOsnqI0cAwAA
X-CMS-MailID: 20230421025539epcas2p1dfab9151ae85e99f06b26a6a6f16f059
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230419062755epcas2p1bca14bbd5200ebe5241780d2d7ec1596
References: <20230419060639.38853-1-jaewon02.kim@samsung.com>
        <CGME20230419062755epcas2p1bca14bbd5200ebe5241780d2d7ec1596@epcas2p1.samsung.com>
        <20230419060639.38853-4-jaewon02.kim@samsung.com>
        <b91c6cfb-4fd2-1189-72fd-92b40d1b4743@linaro.org>
        <9d2e2bda-4213-35d0-55d7-827bad9b13a1@samsung.com>
        <20230419155617.gobedupbdmdaj4kz@intel.intel>
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


On 23. 4. 20. 00:56, Andi Shyti wrote:
> Hi Jaewon,
>
>>>> In polling mode, the status register is constantly read to check transfer
>>>> completion. It cause excessive CPU usage.
>>>> So, it calculates the SPI transfer time and made it sleep.
>>>>
>>>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>>>> ---
>>>>    drivers/spi/spi-s3c64xx.c | 8 ++++++++
>>>>    1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>>>> index 886722fb40ea..cf3060b2639b 100644
>>>> --- a/drivers/spi/spi-s3c64xx.c
>>>> +++ b/drivers/spi/spi-s3c64xx.c
>>>> @@ -561,6 +561,14 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
>>>>    	u32 cpy_len;
>>>>    	u8 *buf;
>>>>    	int ms;
>>>> +	u32 tx_time;
>>>> +
>>>> +	/* sleep during signal transfer time */
>>>> +	status = readl(regs + S3C64XX_SPI_STATUS);
>>>> +	if (RX_FIFO_LVL(status, sdd) < xfer->len) {
>>>> +		tx_time = (xfer->len * 8 * 1000 * 1000) / sdd->cur_speed;
>>>> +		usleep_range(tx_time / 2, tx_time);
>>>> +	}
>>> Did you actually check the delays introduced by it? Is it worth?
>> Yes, I already test it.
>>
>> Throughput was the same, CPU utilization decreased to 30~40% from 100%.
>>
>> Tested board is ExynosAutov9 SADK.
>>
>>
>>>>    
>>>>    	/* millisecs to xfer 'len' bytes @ 'cur_speed' */
>>>>    	ms = xfer->len * 8 * 1000 / sdd->cur_speed;
>>> You have now some code duplication so this could be combined.
> you could put the 'if' under the 'ms = ...' and just use ms
> without declaring any tx_time.
>
> Andi


The unit of 'tx_time' is 'us'.


tx_time = (xfer->len * 8 * 1000 * 1000) / sdd->cur_speed;

ms = xfer->len * 8 * 1000 / sdd->cur_speed;


I add tx_time to minimize existing code modifications.

If we are not using tx_time, we need to change ms to us and change the 
related code.


Thanks

Jaewon Kim


