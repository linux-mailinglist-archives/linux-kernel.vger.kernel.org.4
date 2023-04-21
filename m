Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326F06EA133
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 03:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjDUBrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 21:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjDUBrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 21:47:40 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538D746A4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 18:47:38 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230421014735epoutp011f7e381c69a0c2445b2935afaa86fe2c~Xz-lU5OUs0330103301epoutp01G
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:47:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230421014735epoutp011f7e381c69a0c2445b2935afaa86fe2c~Xz-lU5OUs0330103301epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1682041655;
        bh=cCyrDxiGndEUcSfg/w6e0yeLBQlNiTq5y+DlcxQS26w=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=cuE1q+8bOCBjqR9RqpAF2bZZqv7tebYfRYg2qNSmBjPWdCbRSYoQ0sVqWIPQ7ukGC
         MsERCcrZ5gY65BXXW7LNP3pfKAQS8ZyxrbtDApJ1NEKRpJdywZen/MMhrY+MHnMf4Z
         mgbmQDETD/w8ZinbqYuIkJX/tJ9BvyYroAp35qI0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230421014735epcas2p3487e881fd4a99147fb18396797915755~Xz-k3sgD30212302123epcas2p3N;
        Fri, 21 Apr 2023 01:47:35 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.97]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Q2cpt5fj9z4x9Q0; Fri, 21 Apr
        2023 01:47:34 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        18.D3.10686.63BE1446; Fri, 21 Apr 2023 10:47:34 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230421014734epcas2p2417b3b2c41589801924ae76aef92dbb2~Xz-kHy2Zm2869928699epcas2p2L;
        Fri, 21 Apr 2023 01:47:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230421014734epsmtrp293506ac03135b57fe7c766a71f974a34~Xz-kHEdzI1041910419epsmtrp2j;
        Fri, 21 Apr 2023 01:47:34 +0000 (GMT)
X-AuditID: b6c32a46-c81ff700000029be-83-6441eb36a7d0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        38.1E.08279.63BE1446; Fri, 21 Apr 2023 10:47:34 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230421014734epsmtip2370ec0f8b6e30d121996234a1f15f83f~Xz-j1tqFY1101211012epsmtip2W;
        Fri, 21 Apr 2023 01:47:34 +0000 (GMT)
Message-ID: <812a93ad-af21-5b34-8199-1ccaae325ce5@samsung.com>
Date:   Fri, 21 Apr 2023 10:45:09 +0900
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
In-Reply-To: <087ba4df-7575-acce-309a-efb5115a987d@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmua7Za8cUg5dXNCwezNvGZrH4x3Mm
        i6kPn7BZXN6vbbH39VZ2i02Pr7FaXN41h81ixvl9TBaNH2+yO3B6XF/yidlj06pONo871/aw
        eWxeUu/Rt2UVo8fnTXIBbFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJ
        uam2Si4+AbpumTlANykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL
        89L18lJLrAwNDIxMgQoTsjN+PL/AVrCIvaK3ez1LA+Mt1i5GDg4JAROJ81cluxg5OYQEdjBK
        bDqh1cXIBWR/YpS4cG4yE4TzjVFi7/cfrCBVIA3b9/9jg0jsZZR4evUfI4TzmlFi/qPd7CBV
        vAJ2EhubfrKB2CwCqhJ/j21ihIgLSpyc+YQFxBYViJZYvG8KmC0sECSx5N99JhCbWUBc4taT
        +WCrRQQWM0r0Pf4Eto5ZYCOjxOamqWAb2AS0Jb6vXwx2EyfQtm2X7rJBdMtLbH87hxmkQUJg
        LofE6blf2CEOd5G41LSOBcIWlnh1fAtUXEri87u9bBB2tkT79D9Qj1ZIXNwwGypuLDHrWTsj
        KMSYBTQl1u/ShwSessSRWywQa/kkOg7/ZYcI80p0tAlBNKpJ3J96DmqIjMSkIyuZIGwPiSsd
        25gnMCrOQgqWWUjen4XkmVkIexcwsqxiFEstKM5NTy02KjCCR3Zyfu4mRnBy1XLbwTjl7Qe9
        Q4xMHIyHGCU4mJVEeM+4WqUI8aYkVlalFuXHF5XmpBYfYjQFRs5EZinR5Hxges8riTc0sTQw
        MTMzNDcyNTBXEueVtj2ZLCSQnliSmp2aWpBaBNPHxMEp1cC0Tzj3c95L18Uy2WwuLVN0ZzK/
        iXpS4xwy6/DXWfxfXu29x+T30npHxdmQ1/YT1MzKmo3Pnehvmnvki9iVc1acjyauD38Rom3z
        4/iHfzLFS/V/Sx898OX7w3Pay4wCH546+qZvic1H9/qIP/YvI/hbxXa1qRh/lrj5m2eV8uev
        G9jayj9+b/yyXFFm48d1WTNWngqp4y6aKyCbLZPJP/vTBL7Jpf3LOP79Xhdi0rR3S6Zy49J/
        JdwNFUozRQzmp9au7pXzd7Y60NW4M8c1Km/tbdc3ag1BEZJFgvtTWreqTSrddTs21emV6M62
        pUa9Nw59FlDqXSL/XGe6YWCjRfa66aU/ZMztsrRZdt+x1GlRYinOSDTUYi4qTgQAw5XDJjcE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LZdlhJXtfstWOKwfdtPBYP5m1js1j84zmT
        xdSHT9gsLu/Xttj7eiu7xabH11gtLu+aw2Yx4/w+JovGjzfZHTg9ri/5xOyxaVUnm8eda3vY
        PDYvqffo27KK0ePzJrkAtigum5TUnMyy1CJ9uwSujB/PL7AVLGKv6O1ez9LAeIu1i5GTQ0LA
        RGL7/n9sXYxcHEICuxklznY2sEEkZCSWP+uDsoUl7rccYYUoeskoceP8E7AEr4CdxMamn2A2
        i4CqxN9jmxgh4oISJ2c+YQGxRQWiJW4s/8YEYgsLBEks+XcfzGYWEJe49WQ+E8hQEYHFjBId
        l96ygzjMAhsZJVZeX88Mse4no0T3iVlgY9kEtCW+r18Mdjgn0Optl+6yQYwyk+ja2sUIYctL
        bH87h3kCo9AsJJfMQrJxFpKWWUhaFjCyrGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93E
        CI4rLc0djNtXfdA7xMjEwXiIUYKDWUmE193GLkWINyWxsiq1KD++qDQntfgQozQHi5I474Wu
        k/FCAumJJanZqakFqUUwWSYOTqkGJmmHLCOjbx+sij51Xvu95N+bX+kKedW8tsxp++wL9RO6
        mR9m7sk2L+62UOU7zbFrv7oa0x5J/jv/NwhrxB3Mbp2vM6fM4dGB0I5gy4uXjCevFzl+X87M
        7v9z3fiaTYbRCS/Kp8YleUknz5/duDJ1u93ZT4cObTW8kBtnNS9xp39pzzLJkzdq3l1inMP3
        YFlGe+jv73UOW/e9LZEVn5PLqXNrz+wL2hHnQv5xpDQe+8p1/0luX8CUYCmFb2It22ZtuxYb
        cd51X8HVo3Znue+x6rzUMT/7MCDygojPHi6VxMSOIommM5I7J/vdutLdLhvEU/Bt3g422RWK
        +0Re1e/a7J5seP7r6tmPhHYtLb5pocRSnJFoqMVcVJwIAACqr4QaAwAA
X-CMS-MailID: 20230421014734epcas2p2417b3b2c41589801924ae76aef92dbb2
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
        <087ba4df-7575-acce-309a-efb5115a987d@linaro.org>
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23. 4. 21. 00:40, Krzysztof Kozlowski wrote:
> On 19/04/2023 08:06, Jaewon Kim wrote:
>> Polling mode supported with qurik if there was no DMA in the SOC.
>> However, there are cased where we cannot or do not want to use DMA.
>> To support this case, if DMA is not set, it is switched to polling mode.
>>
> (...)
>
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
> of_property_present()

I will change it to of_property_present().


>
> Best regards,
> Krzysztof
>
>
Thanks

Jaewon Kim

