Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9406E7895
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbjDSL0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjDSL0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:26:13 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E818B2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:26:11 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230419111554epoutp02ea5438fae7fe4fcbed5519ae101c972e~XUdOIqaAe2950029500epoutp02G
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 11:15:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230419111554epoutp02ea5438fae7fe4fcbed5519ae101c972e~XUdOIqaAe2950029500epoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681902954;
        bh=yaloNG5EirXhW5Hu5Qw6THKFTACwagq13j1G743WQ+0=;
        h=Date:From:Subject:To:Cc:In-Reply-To:References:From;
        b=W2pH1BqVXnGP3Ltkan5fOdy4VK7myM5Is3qknG9qNgH5N3Ob4h0rhEocKMG7RWbdb
         8zVSIx36x6aDetVQdV1JZwF1LKcGdxgXkOqFlW8NiZnoBInQlqDhsFVXsSuahG4YRz
         fiOzkRRCEA/puN5gYDodfnMcvBroet+7TY2h1280=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230419111554epcas2p21b8a661f77e9db1d6fef0a3617c42d1f~XUdNnaE811393013930epcas2p21;
        Wed, 19 Apr 2023 11:15:54 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.98]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Q1dWY6ljxz4x9Q1; Wed, 19 Apr
        2023 11:15:53 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.77.09938.96DCF346; Wed, 19 Apr 2023 20:15:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230419111553epcas2p34439437568e4ab428e9464f41889eb33~XUdMz0ss02936829368epcas2p3d;
        Wed, 19 Apr 2023 11:15:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230419111553epsmtrp134875555abe7eeebf81de1d54e9cd651~XUdMzJlL63115831158epsmtrp1X;
        Wed, 19 Apr 2023 11:15:53 +0000 (GMT)
X-AuditID: b6c32a47-ca5fd700000026d2-7d-643fcd695001
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A2.C5.08279.96DCF346; Wed, 19 Apr 2023 20:15:53 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230419111553epsmtip1eafc761df29a0f7540b6ae4a01dd22d0~XUdMh6wFx0303903039epsmtip13;
        Wed, 19 Apr 2023 11:15:53 +0000 (GMT)
Message-ID: <abbf5608-dbe7-af39-e555-d76ffe65dea4@samsung.com>
Date:   Wed, 19 Apr 2023 20:13:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.10.0
From:   Jaewon Kim <jaewon02.kim@samsung.com>
Subject: Re: [PATCH v2 2/4] spi: s3c64xx: add cpu_relax in polling loop
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>, Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
Content-Language: en-US
In-Reply-To: <36f37a18-0022-0368-bf7c-ebdd724b1558@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmqW7mWfsUgwWtJhYP5m1js1j84zmT
        xdSHT9gsLu/Xttj7eiu7xabH11gtLu+aw2Yx4/w+JovGjzfZHTg9ri/5xOyxaVUnm8eda3vY
        PDYvqffo27KK0ePzJrkAtqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE
        3FRbJRefAF23zBygm5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BeYFesWJucWl
        eel6eaklVoYGBkamQIUJ2RkLX91mL/jLXXFj/iHWBsaznF2MnBwSAiYSL149Z+ti5OIQEtjB
        KLF+zQlWCOcTo0TTn31MEM43RomeW6dYYFq2nnnJApHYyyixZeUWRgjnNaPEnlkn2LsYOTh4
        BewkLixgBmlgEVCVuDp/PTuIzSsgKHFy5hOwQaIC0RKL900Bs9kEtCW+r1/MCmILC7hL7Lj6
        D2ymiMBiRom+x5/ADmQW2MgosblpKtgkZgFxiVtP5jOB2JxAyzrWXGGCiMtLbH87hxmkQUJg
        KYfE9KdrGCHudpG4sPopG4QtLPHq+BZ2CFtK4mV/G5SdLdE+/Q8rhF0hcXHDbKh6Y4lZz9oZ
        QT5jFtCUWL9LH8SUEFCWOHKLBWItn0TH4b/sEGFeiY42IYhGNYn7U89BDZGRmHRkJROE7SFx
        ZOYutgmMirOQgmUWksdmIXlmFsLeBYwsqxjFUguKc9NTi40KjOGxnZyfu4kRnF613Hcwznj7
        Qe8QIxMH4yFGCQ5mJRHeM65WKUK8KYmVValF+fFFpTmpxYcYTYGRM5FZSjQ5H5jg80riDU0s
        DUzMzAzNjUwNzJXEeaVtTyYLCaQnlqRmp6YWpBbB9DFxcEo1MCU+FZ2pce9McuOBsMQvL+y0
        y0TiD76eoftjU/9MS/6AQq8+58vNgmG7vloeLQps33fZ6ePRJblTeGepTHeOeCvvsHbB5DiB
        N9lr3HKnp7i2n2Atkpiy5VDBwlVbsittuG5M28q44Bfb69YPOvrHig7Znfr9hn3tEeWP5mvn
        7TBmZk5RfdG6v6LXM3YNY56u3N05SmF8Ub4xCU1r150RP/W76/d3DpuQv7+utfMtWsVye0Fq
        qPbrd/UcKv8lLhR8+xPiLiPRVbPsQOGzJPX1rnGWlimq+4SiZ3HpvpU9l3LgZv42/baCN+tf
        Luiwv1F7edkrhq1sazJXh5splre9S9vxq2aVGNurssehU5gyNiixFGckGmoxFxUnAgCRebcX
        OAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42LZdlhJTjfzrH2Kwc1N/BYP5m1js1j84zmT
        xdSHT9gsLu/Xttj7eiu7xabH11gtLu+aw2Yx4/w+JovGjzfZHTg9ri/5xOyxaVUnm8eda3vY
        PDYvqffo27KK0ePzJrkAtigum5TUnMyy1CJ9uwSujIWvbrMX/OWuuDH/EGsD41nOLkZODgkB
        E4mtZ16ydDFycQgJ7GaU+NU6gQUiISOx/FkfG4QtLHG/5QgrRNFLRon/B78CFXFw8ArYSVxY
        wAxSwyKgKnF1/np2EJtXQFDi5MwnYHNEBaIlbiz/xgRiswloS3xfv5gVxBYWcJfYcfUfI8hM
        EYHFjBIdl96ygzjMAhsZJVZeXw82VUjgJ6PEpslSIDazgLjErSfzwSZxAi3uWHOFCSJuJtG1
        tYsRwpaX2P52DvMERqFZSA6ZhaR9FpKWWUhaFjCyrGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L
        10vOz93ECI4pLc0djNtXfdA7xMjEwXiIUYKDWUmE193GLkWINyWxsiq1KD++qDQntfgQozQH
        i5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGJlvPZZfns54M2qPw+1X19ZcevRUc0qKTBOwN
        pvSf3PPMcl4ZC4Ppultf/+43slPNuv3i/ry1i4TT9PwLnDWzpe7fPC1xqWFG9LIjL08FP0zZ
        Y6FxY+FK84w3/8ydMtv8Z0aILRNz8tOZmPboSe/vzkd72EuMizsuSkx3Y647nPeoL2Tq9SMr
        3fOrrNO8D157syR38stX8tObs1qW7uzKFalfscPn/Vm/JzKVLB3/zhkf2F5+YMbL25lWzYfr
        li1RSbFfJqSqZCn+7VmIXf02dj++efmabd5H0yR5xRfkij5RFT6yVyWeL+zK12eZlpsZfnSw
        zpCfeet5VAPj9eq55xequH0L1ZpRf9xns9GpCCWW4oxEQy3mouJEADgrUgIYAwAA
X-CMS-MailID: 20230419111553epcas2p34439437568e4ab428e9464f41889eb33
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
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23. 4. 19. 17:14, Krzysztof Kozlowski wrote:
> On 19/04/2023 08:06, Jaewon Kim wrote:
>> Adds cpu_relax() to prevent long busy-wait.
> How cpu_relax prevents long waiting?

As I know, cpu_relax() can be converted to yield. This can prevent 
excessive use of the CPU in busy-loop.

I'll replace poor sentence like below in v3.

("Adds cpu_relax() to allow CPU relaxation in busy-loop")

>> There is busy-wait loop to check data transfer completion in polling mode.
>>
>> Signed-off-by: Jaewon Kim<jaewon02.kim@samsung.com>
>> ---
>>   drivers/spi/spi-s3c64xx.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> index 273aa02322d9..886722fb40ea 100644
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -568,6 +568,7 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
>>   
>>   	val = msecs_to_loops(ms);
>>   	do {
>> +		cpu_relax();
> Shouldn't this be just readl_poll_timeout()? Or the syntax would be too
> complicated?

I think we can replace this while() loop to readl_poll_timeout().

However, we should use 0 value as 'delay_us' parameter. Because delay 
can affect throughput.


My purpose is add relax to this busy-loop.

we cannot give relax if we change to readl_poll_timeout().


>>   		status = readl(regs + S3C64XX_SPI_STATUS);
>>   	} while (RX_FIFO_LVL(status, sdd) < xfer->len && --val);
>>   
> Best regards,
> Krzysztof
>
>
Thanks

Jaewon Kim

