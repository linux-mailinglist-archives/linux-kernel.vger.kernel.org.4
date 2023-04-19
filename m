Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4719F6E7695
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjDSJnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbjDSJnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:43:37 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BD71728
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 02:43:34 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230419094331epoutp011dfb0217f939c9a4f8772a180bcab55f~XTMj9wW0J0351603516epoutp01X
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 09:43:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230419094331epoutp011dfb0217f939c9a4f8772a180bcab55f~XTMj9wW0J0351603516epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681897412;
        bh=0kO6mZexP7v1yQRKLBpRg3Wv/Zx4ilaho2niMqHkyn4=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=nQTx83TEan1H8heT4hoGGngeXVvavomFqMKXmhplfP06BIIpUPTFNHt6kZUTVvAoc
         ZB2R7YZhY3SzmN5TiPJU7vtjAnoBjVLfAvdtvxbMnnSA7Y70y386FAaZKia6l9BBnh
         5JBH9ejl1J1Fc98YleHpx2uvKYECmRjjetYLoKWU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230419094331epcas2p1b73f3a8e6fcbf21380cdd49a91ff8505~XTMjiHUGl0080400804epcas2p1V;
        Wed, 19 Apr 2023 09:43:31 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.89]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Q1bSz1Rdhz4x9Pr; Wed, 19 Apr
        2023 09:43:31 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.4E.09650.3C7BF346; Wed, 19 Apr 2023 18:43:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230419094330epcas2p495358693c341dc79d18d7d392c435207~XTMis7jSg3121831218epcas2p4p;
        Wed, 19 Apr 2023 09:43:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230419094330epsmtrp1362e24c6829feee4b8ce638438ccaa4b~XTMir8c970910709107epsmtrp13;
        Wed, 19 Apr 2023 09:43:30 +0000 (GMT)
X-AuditID: b6c32a48-023fa700000025b2-eb-643fb7c3505b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.EE.08279.2C7BF346; Wed, 19 Apr 2023 18:43:30 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230419094330epsmtip10d93a423f325a85b94af2a0671bceed6~XTMieK3Ts1321013210epsmtip1w;
        Wed, 19 Apr 2023 09:43:30 +0000 (GMT)
Message-ID: <9d2e2bda-4213-35d0-55d7-827bad9b13a1@samsung.com>
Date:   Wed, 19 Apr 2023 18:41:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.10.0
Subject: Re: [PATCH v2 3/4] spi: s3c64xx: add sleep during transfer
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>, Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
From:   Jaewon Kim <jaewon02.kim@samsung.com>
In-Reply-To: <b91c6cfb-4fd2-1189-72fd-92b40d1b4743@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmme7h7fYpBvP+cFg8mLeNzWLxj+dM
        FlMfPmGzuLxf22Lv663sFpseX2O1uLxrDpvFjPP7mCwaP95kd+D0uL7kE7PHplWdbB53ru1h
        89i8pN6jb8sqRo/Pm+QC2KKybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPIS
        c1NtlVx8AnTdMnOAblJSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgX6BUn5haX
        5qXr5aWWWBkaGBiZAhUmZGcsvm9Z8Iy7Ytk+1QbGtZxdjJwcEgImEhc+HmfqYuTiEBLYwShx
        p/c/lPOJUeL8k+2MEM43Rok169+zwbR0rV7NDpHYyyjxcVoDVNVrRok3K/pYQKp4BewkOg7+
        AbNZBFQlWh6vYoOIC0qcnPkELC4qEC2xeN8UMFtYwFli362l7CA2s4C4xK0n88HuEBFYzCjR
        9/gTG4jDLLCRUWJz01SwKjYBbYnv6xezgticQNuWzLnGBtEtL7H97RxmkAYJgYUcEj8Oz2KB
        ONxF4svSPqgnhCVeHd/CDmFLSbzsb4OysyXap/9hhbArJC5umA1Vbywx61k70J8cQAs0Jdbv
        0gcxJQSUJY7cYoFYyyfRcfgvO0SYV6KjTQiiUU3i/tRzUENkJCYdWckEYXtI/J81j2UCo+Is
        pGCZheT9WUiemYWwdwEjyypGsdSC4tz01GKjAhN4ZCfn525iBCdXLY8djLPfftA7xMjEwXiI
        UYKDWUmE94yrVYoQb0piZVVqUX58UWlOavEhRlNg5ExklhJNzgem97ySeEMTSwMTMzNDcyNT
        A3Mlcd6PHcopQgLpiSWp2ampBalFMH1MHJxSDUz7b69pXvGe/dPh07n9sjpXPyZvkfBtLiq5
        k7bAOuvmqvDTQTZxdeKT3W2jtT4ErV69OFwwxZh9veUWOYZ4jYvfGT203Xef+uCo+uuFx0+1
        hymKDbLdPc/72Mvvvf/K/rvuGS+vzRkdbsfc8zEz7+gsFw5xtQp9Jn6hxW7+M8Zd7488+jdN
        dY1J/NXlTu09XS2PQmJ38Dmnx4UUvQsu1H/4eeJq+2+cfKdiUp9sOyau+LXtcm67yk3ndU/Z
        5nRF6fgFbpZd7Mia3N+4Ifqr+nmXguJLrifLvZbNDeHXrPu2afXdus3su2s33YgIn8JjyyzT
        J7ZzhW73hWM+Qn7L1nM/NBW3q1ZYvcuz2/5dvRJLcUaioRZzUXEiAOqLIiA3BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42LZdlhJTvfQdvsUg7efFSwezNvGZrH4x3Mm
        i6kPn7BZXN6vbbH39VZ2i02Pr7FaXN41h81ixvl9TBaNH2+yO3B6XF/yidlj06pONo871/aw
        eWxeUu/Rt2UVo8fnTXIBbFFcNimpOZllqUX6dglcGYvvWxY8465Ytk+1gXEtZxcjJ4eEgIlE
        1+rV7F2MXBxCArsZJfr6H7JAJGQklj/rY4OwhSXutxxhhSh6ySgx4+YlZpAEr4CdRMfBP2AN
        LAKqEi2PV7FBxAUlTs58AhYXFYiWuLH8GxOILSzgLLHv1lJ2EJtZQFzi1pP5TCBDRQQWM0p0
        XHoLdgazwEZGiZXX1zNDrPvJKPH5xGWwUWwC2hLf1y9mBbE5gVYvmXONDWKUmUTX1i5GCFte
        YvvbOcwTGIVmIblkFpKNs5C0zELSsoCRZRWjZGpBcW56brFhgWFearlecWJucWleul5yfu4m
        RnBMaWnuYNy+6oPeIUYmDsZDjBIczEoivGdcrVKEeFMSK6tSi/Lji0pzUosPMUpzsCiJ817o
        OhkvJJCeWJKanZpakFoEk2Xi4JRqYDp9+OdF4aXv6jYa9KU+jgowYYtZYV68WCsx4tn3BJFD
        TX9iTXVcPWXPTa32ufTqofL/cmH/vXv8Hu695Hl81wrflM1PghyDs/Z8nrNzb9492+Urcx9I
        LXM7HrmrrPOIyoysHWGha5pfnAwU28e5vKV4a+OVSzMCs4+8lK53tDTqlDupusWoMd6PXTBY
        VrFPjHmS2h75rjtvnvm/Klrevz1PcmKBuNFxqRt9PuqztRbK1Kv3xm4/ve38+3VyQjVc+xfd
        l1tdJH6yf+XRDtZHF5v2aSWF/Uh52fm97Fn3vE/1PwOMLV7+cfENObGs/eaJU5WJ31SrjpSn
        u5+oq42bMu8i5xLOuo6d8Q5rs3dnyCuxFGckGmoxFxUnAgDT3qPwGAMAAA==
X-CMS-MailID: 20230419094330epcas2p495358693c341dc79d18d7d392c435207
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
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23. 4. 19. 17:19, Krzysztof Kozlowski wrote:
> On 19/04/2023 08:06, Jaewon Kim wrote:
>> In polling mode, the status register is constantly read to check transfer
>> completion. It cause excessive CPU usage.
>> So, it calculates the SPI transfer time and made it sleep.
>>
>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>> ---
>>   drivers/spi/spi-s3c64xx.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> index 886722fb40ea..cf3060b2639b 100644
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -561,6 +561,14 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
>>   	u32 cpy_len;
>>   	u8 *buf;
>>   	int ms;
>> +	u32 tx_time;
>> +
>> +	/* sleep during signal transfer time */
>> +	status = readl(regs + S3C64XX_SPI_STATUS);
>> +	if (RX_FIFO_LVL(status, sdd) < xfer->len) {
>> +		tx_time = (xfer->len * 8 * 1000 * 1000) / sdd->cur_speed;
>> +		usleep_range(tx_time / 2, tx_time);
>> +	}
> Did you actually check the delays introduced by it? Is it worth?

Yes, I already test it.

Throughput was the same, CPU utilization decreased to 30~40% from 100%.

Tested board is ExynosAutov9 SADK.


>
>>   
>>   	/* millisecs to xfer 'len' bytes @ 'cur_speed' */
>>   	ms = xfer->len * 8 * 1000 / sdd->cur_speed;
> You have now some code duplication so this could be combined.
>
> Best regards,
> Krzysztof
>
>
Thanks

Jaewon Kim

