Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9D76EA138
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 03:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjDUBsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 21:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbjDUBsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 21:48:17 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3ED35B98
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 18:48:13 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230421014811epoutp0296095263d880826df114a1fcdcfc6948~X0AHAsiv62048620486epoutp02T
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:48:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230421014811epoutp0296095263d880826df114a1fcdcfc6948~X0AHAsiv62048620486epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1682041691;
        bh=1OOFri94d52LXG4EPLKy/KBumjQNxs+eAWlUBgJRS9M=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=tgQfe1bOanVa+63VEkFJfeSNUgg3OhLHhidO6E90PRGETXUS9pvcx5Zd3MJo4UrM9
         JwdWT88NMneoUAewFccb6knCWLBW3fhy8R7DSQGnQF1gve501eDJlCIz+PrV+ALr/u
         9nCnUhAspuzY82l6hsSF0v/E07kHWB42oACphTd8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230421014811epcas2p4066b33d63886b6820c0e3137738bd8fe~X0AGou-je0308503085epcas2p4-;
        Fri, 21 Apr 2023 01:48:11 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.91]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Q2cqb0TPHz4x9Q3; Fri, 21 Apr
        2023 01:48:11 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        68.71.09961.A5BE1446; Fri, 21 Apr 2023 10:48:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230421014810epcas2p1712c2740eac5eaa34006237858dfd8e5~X0AF8NWBO0538305383epcas2p1-;
        Fri, 21 Apr 2023 01:48:10 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230421014810epsmtrp1b1fe22dbfaaea3338813eb5a9fee3d52~X0AF7Y34h1216812168epsmtrp1v;
        Fri, 21 Apr 2023 01:48:10 +0000 (GMT)
X-AuditID: b6c32a45-bb5ff700000026e9-fd-6441eb5a9116
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C0.EA.08609.A5BE1446; Fri, 21 Apr 2023 10:48:10 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230421014810epsmtip175cfaddfaea55304c37787c52014b006~X0AFpyRCk2749627496epsmtip1L;
        Fri, 21 Apr 2023 01:48:10 +0000 (GMT)
Message-ID: <87c2a0e1-fb3a-7b0a-c87a-ac792357ef26@samsung.com>
Date:   Fri, 21 Apr 2023 10:45:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/4] spi: s3c64xx: add cpu_relax in polling loop
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>, Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
From:   Jaewon Kim <jaewon02.kim@samsung.com>
In-Reply-To: <01d22e48-40f0-b1dd-aa00-cf484c4364ee@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmmW7Ua8cUg78nrS0ezNvGZrH4x3Mm
        i6kPn7BZXN6vbbH39VZ2i02Pr7FaXN41h81ixvl9TBaNH2+yO3B6XF/yidlj06pONo871/aw
        eWxeUu/Rt2UVo8fnTXIBbFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJ
        uam2Si4+AbpumTlANykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL
        89L18lJLrAwNDIxMgQoTsjNuv13HWrCOr+Js2w7WBsZz3F2MnBwSAiYSp7ZfZO9i5OIQEtjB
        KHFq5wlmCOcTo8TJGbsYIZzPjBJTd7YxwbT8eTyTDSKxi1Fiya6jUFWvGSW2v7/NAlLFK2An
        cfnHZUYQm0VAVeLXu92sEHFBiZMzn4DViApESyzeNwXMFhZwl9hx9R9YPbOAuMStJ/OZQIaK
        CCxmlOh7/AlsHbPARkaJzU1T2UGq2AS0Jb6vXww2lRNo281385ghuuUltr+dA/aFhMBcDolr
        y2YzQhzuInH9YAM7hC0s8er4FihbSuJlfxuUnS3RPv0PK4RdIXFxw2w2CNtYYtazdqA5HEAL
        NCXW79IHMSUElCWO3GKBWMsn0XH4LztEmFeio00IolFN4v7Uc1BDZCQmHVkJDUUPiSMzd7FN
        YFSchRQss5C8PwvJM7MQ9i5gZFnFKJZaUJybnlpsVGAIj+7k/NxNjOAEq+W6g3Hy2w96hxiZ
        OBgPMUpwMCuJ8J5xtUoR4k1JrKxKLcqPLyrNSS0+xGgKjJyJzFKiyfnAFJ9XEm9oYmlgYmZm
        aG5kamCuJM4rbXsyWUggPbEkNTs1tSC1CKaPiYNTqoEpcqHzr40379dtTu8Mn7j0ziP7zS5X
        lpoEMTtunrVeYLXTmdrSTZU6e9z9qk592DMrqe703suFHzY8+VV56/kzXTWtlQejr7RZ+Llf
        PaxU0save313TORicTnhNYZ5bF6eGStzMxot3qxeaFIp5/tte4RQYPcM5tcrLhtnWP5Z+Prg
        ijM2knJTqx7c3H60PO/iVLNm7nlHSu+dmfFKoOT7Bxl+3tcpbLfPC7QprlWVW3VVkzFrx7Fo
        7YfRscVRVXf+XHF5VD6VaSdPutfueuPpSta6HQ/jqoSb5rvH8u3tPvHAqP6EoM0PM4OpHXvZ
        Cwz9VZnnzr1yOawya9LHY69i4/bohInaVYnb7T2/se2/EktxRqKhFnNRcSIAKEYrQTkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LZdlhJTjfqtWOKwd27chYP5m1js1j84zmT
        xdSHT9gsLu/Xttj7eiu7xabH11gtLu+aw2Yx4/w+JovGjzfZHTg9ri/5xOyxaVUnm8eda3vY
        PDYvqffo27KK0ePzJrkAtigum5TUnMyy1CJ9uwSujNtv17EWrOOrONu2g7WB8Rx3FyMnh4SA
        icSfxzPZuhi5OIQEdjBKPJ/VwgSRkJFY/qyPDcIWlrjfcoQVouglo8T0r1NYQRK8AnYSl39c
        ZgSxWQRUJX692w0VF5Q4OfMJC4gtKhAtcWP5N7ChwgLuEjuu/gOrZxYQl7j1ZD4TyFARgcWM
        Eh2X3rKDOMwCGxklVl5fzwyx7hGTxONJN8HGsgloS3xfvxjM5gRaffPdPGaIUWYSXVu7oMbK
        S2x/O4d5AqPQLCSXzEKycRaSlllIWhYwsqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/d
        xAiOKy2tHYx7Vn3QO8TIxMF4iFGCg1lJhPeMq1WKEG9KYmVValF+fFFpTmrxIUZpDhYlcd4L
        XSfjhQTSE0tSs1NTC1KLYLJMHJxSDUxJRytPni+bzTX7aVLOnt3qAp9nPjE/xDxpfaZlyo/+
        6Z7XDvqdemP9mlnba3Gyou+mvTFbUz3LTycVpHxSeKR+fFLUlNDiNJsF0tvPL8/gsloh1Tq1
        da/R2WfMYXZCeQcucCy49j42wSu0RcH+umqjbXmIEYcvlwff/2w+uSXvJWT6nm/e+3nFqsiz
        S4r6p0ouC1+qwzbhkd3y7jIFnrKZu3ddaDDiaHsiyHlHN+1C0ul45+Dsh8yvyrjrToauPLNL
        ffL5FAujKsFdd3Itj2aIyD13OZLxTCTg9TFrkarQK9FzuzIt69kmT5u/4kfzdp+XcZsveage
        u5ptzrI53bn1cXBhV4Kae7hFR8KSCiWW4oxEQy3mouJEALwSynwaAwAA
X-CMS-MailID: 20230421014810epcas2p1712c2740eac5eaa34006237858dfd8e5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230419062755epcas2p43a646bbae5f01e3120331407ad873318
References: <20230419060639.38853-1-jaewon02.kim@samsung.com>
        <CGME20230419062755epcas2p43a646bbae5f01e3120331407ad873318@epcas2p4.samsung.com>
        <20230419060639.38853-3-jaewon02.kim@samsung.com>
        <36f37a18-0022-0368-bf7c-ebdd724b1558@linaro.org>
        <abbf5608-dbe7-af39-e555-d76ffe65dea4@samsung.com>
        <01d22e48-40f0-b1dd-aa00-cf484c4364ee@linaro.org>
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23. 4. 21. 00:39, Krzysztof Kozlowski wrote:
> On 19/04/2023 13:13, Jaewon Kim wrote:
>> On 23. 4. 19. 17:14, Krzysztof Kozlowski wrote:
>>> On 19/04/2023 08:06, Jaewon Kim wrote:
>>>> Adds cpu_relax() to prevent long busy-wait.
>>> How cpu_relax prevents long waiting?
>> As I know, cpu_relax() can be converted to yield. This can prevent
>> excessive use of the CPU in busy-loop.
> That's ok, you just wrote that it will prevent long waiting, so I assume
> it will shorten the wait time.
>
>> I'll replace poor sentence like below in v3.
>>
>> ("Adds cpu_relax() to allow CPU relaxation in busy-loop")
>>
>>>> There is busy-wait loop to check data transfer completion in polling mode.
>>>>
>>>> Signed-off-by: Jaewon Kim<jaewon02.kim@samsung.com>
>>>> ---
>>>>    drivers/spi/spi-s3c64xx.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>>>> index 273aa02322d9..886722fb40ea 100644
>>>> --- a/drivers/spi/spi-s3c64xx.c
>>>> +++ b/drivers/spi/spi-s3c64xx.c
>>>> @@ -568,6 +568,7 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
>>>>    
>>>>    	val = msecs_to_loops(ms);
>>>>    	do {
>>>> +		cpu_relax();
>>> Shouldn't this be just readl_poll_timeout()? Or the syntax would be too
>>> complicated?
>> I think we can replace this while() loop to readl_poll_timeout().
>>
>> However, we should use 0 value as 'delay_us' parameter. Because delay
>> can affect throughput.
>>
>>
>> My purpose is add relax to this busy-loop.
>>
>> we cannot give relax if we change to readl_poll_timeout().
> readl_poll_timeout() will know to do the best. You do not need to add
> cpu_relax there.
Okay, I will change it to readl_poll_timeout()
>
> Best regards,
> Krzysztof
>
>

Thanks

Jaewon Kim

