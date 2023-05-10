Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FF36FD4F5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 06:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbjEJEIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 00:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbjEJEH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 00:07:57 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2702D54
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 21:07:54 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230510040749epoutp03171c00846a520cdbff537341e1caed2a~drKcJxMiK0529705297epoutp031
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 04:07:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230510040749epoutp03171c00846a520cdbff537341e1caed2a~drKcJxMiK0529705297epoutp031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683691669;
        bh=UumBYReH9u2V3iGM9ig8NQZ/6q2oZ2kA9hAqWn1Mpl4=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=NZjF4kpPQW1+ywBYjrtqdRLHrMq2QZMPsvy3xuk0Ulo2IHE86XMyy3Fq2UN4CKdp3
         KHCiogqICS+Tli4GDx5PaU97x0n8PqC8g+/60AQq84rk1/x++GlLy+6r26TtagEhUG
         40aTLkbjG5drEPCSSbBXMjETpBPZ8UVs/ZNPhItU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230510040748epcas2p18c8f826989ade5337058ad3a98356202~drKbwzH0k3235132351epcas2p1U;
        Wed, 10 May 2023 04:07:48 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.101]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4QGM1v6Q0Qz4x9Py; Wed, 10 May
        2023 04:07:47 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.3C.22936.3981B546; Wed, 10 May 2023 13:07:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230510040747epcas2p3de1b7fdbc5b4d63ee0c28545670d9ddd~drKanTGaO2542125421epcas2p34;
        Wed, 10 May 2023 04:07:47 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230510040747epsmtrp27152583174a4570a35bcc6ed0b5811b0~drKamjkeL2960929609epsmtrp2O;
        Wed, 10 May 2023 04:07:47 +0000 (GMT)
X-AuditID: b6c32a48-6d3fa70000005998-f7-645b1893fd66
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.A0.28392.3981B546; Wed, 10 May 2023 13:07:47 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230510040747epsmtip1d411c89f18fe471c1e30bf645ae34f6f~drKaVzS7u1624316243epsmtip1R;
        Wed, 10 May 2023 04:07:47 +0000 (GMT)
Message-ID: <0ef75bd7-e7e6-a806-2c3f-35c7312c391d@samsung.com>
Date:   Wed, 10 May 2023 13:05:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.10.0
Subject: Re: [PATCH v3 3/3] spi: s3c64xx: support interrupt based pio mode
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>,
        =?UTF-8?Q?=c5=81ukasz_Stelmach?= <l.stelmach@samsung.com>
Content-Language: en-US
From:   Jaewon Kim <jaewon02.kim@samsung.com>
In-Reply-To: <d8fa2d7b-6604-1fad-6b0b-19d7e551a1d2@samsung.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJJsWRmVeSWpSXmKPExsWy7bCmqe5kiegUgykfDC0ezNvGZrH4x3Mm
        i6kPn7BZXN6vbbH39VZ2i5uHVjBabHp8jdXi8q45bBYzzu9jsmj8eJPdYu2Ru+wO3B7Xl3xi
        9ti0qpPN4861PWwem5fUe/RtWcXo8XmTXABbVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZ
        gaGuoaWFuZJCXmJuqq2Si0+ArltmDtB1SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSC
        lJwC8wK94sTc4tK8dL281BIrQwMDI1OgwoTsjN3z3zMV/BevODQnr4HxnnAXIyeHhICJxK+3
        C1hBbCGBHYwSk46UdTFyAdmfGCUOrj7BBpH4zCixd54fTMPSw+eZIOK7GCWWXfKAaHjNKLH0
        YyMzSIJXwE5i0eO/jCA2i4CqxPV7f9gh4oISJ2c+YQGxRQWiJRbvmwJmCwt4SfzZ3QQ2VETg
        AqPE8wYzEJtZ4B2jRMcSKQhbXOLWk/lgNWwC2hLf1y8Gu5pTwF7iwc1b7BA18hLNW2czgxwk
        IbCFQ2LxryPMEFe7SFxZf4IFwhaWeHV8CzuELSXx+d1eNgg7W6J9+h9WCLtC4uKG2VBxY4lZ
        z9qBnuEAWqApsX6XPogpIaAsceQWC8RaPomOw3/ZIcK8Eh1tQhCNahL3p56DGiIDDNqVTBAl
        HhJT9pVOYFSchRQms5D8OAvJL7MQ1i5gZFnFKJZaUJybnlpsVGACj+fk/NxNjOA0q+Wxg3H2
        2w96hxiZOBgPMUpwMCuJ8HqHRqUI8aYkVlalFuXHF5XmpBYfYjQFxsxEZinR5Hxgos8riTc0
        sTQwMTMzNDcyNTBXEuf92KGcIiSQnliSmp2aWpBaBNPHxMEp1cAUpt9bsqoumm/bxWb/PweW
        lW5TLc1NY/DQXJTps31D2tazTb+zZxaWHLsrzbhc9x/r/VdO5z/eXSZgee/ptIZlO3u3PN64
        Q2fy/KKwkG3GD01W5srudml1WpokVFClvjf7S1QFw/7k7yE1gqsvpt9SeKHqs/DakZ7HnZ+5
        /2f4qy61DPpV1yyul7Frn/ybjsvijulHCm/cEMlfl7DugdLJ1YySsjFrdCdPifaz3ByaGRjh
        9kn5wYozMareNzali7w7elZnbm3eNcb+p1vsDLw+pV100a5nnqyTxcD6evXDY00nN9/ZUn52
        TYbZnnOT/hT9YHlnaL1cIsQm9Ez59vq9H6Z7qm9zy2Tb9Knut1KgEktxRqKhFnNRcSIAF5bj
        gDwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSnO5kiegUgz8nRC0ezNvGZrH4x3Mm
        i6kPn7BZXN6vbbH39VZ2i5uHVjBabHp8jdXi8q45bBYzzu9jsmj8eJPdYu2Ru+wO3B7Xl3xi
        9ti0qpPN4861PWwem5fUe/RtWcXo8XmTXABbFJdNSmpOZllqkb5dAlfG7vnvmQr+i1ccmpPX
        wHhPuIuRk0NCwERi6eHzTF2MXBxCAjsYJZq7nrFAJGQklj/rY4OwhSXutxxhhSh6ySix7fFL
        ZpAEr4CdxKLHfxlBbBYBVYnr9/6wQ8QFJU7OfAI2SFQgWuLG8m9MILawgJfEn91NYNtEBC4x
        SpzZeAfMYRZ4xyhxa90yNogVfxglXv99BtbCLCAucevJfDCbTUBb4vv6xawgNqeAvcSDm7fY
        IWrMJLq2djFC2PISzVtnM09gFJqF5JJZSEbNQtIyC0nLAkaWVYySqQXFuem5xYYFRnmp5XrF
        ibnFpXnpesn5uZsYwZGmpbWDcc+qD3qHGJk4GA8xSnAwK4nweodGpQjxpiRWVqUW5ccXleak
        Fh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXAdObzwZjQadGf3+rLPM30kPuov+1o
        p9Uv2ZK3ZhUVobvZv7F+23hHpejF4cLHOSyP0q6xXqtc9eF5+8eDL76IybP2H+Ob0dMm8j1+
        jeV7ked6Eqlsr/b9rWjnFd160mVCDWN/i8/BnCUfE6YrSP8ULP9+pX2xGPefpDCpvWGz9/2L
        3nFKbWmI+6kL+nsvv33PvTvWdK/0olqdswqqZVfFJrD/tHrydtaH4jvpHO8+HOH/qpYypV/c
        +9u8X6senP1+Opat97C2bXbVQ8ujL98+lfnuvWkOh33Dv2vqtvOfiXBJXD+RUpzubWwSfvmS
        kfHkjOuLGdLetT+V+XFoG/PvHqebnrHz88QWLOPZ3Xxs5lMlluKMREMt5qLiRACLl5ZjIwMA
        AA==
X-CMS-MailID: 20230510040747epcas2p3de1b7fdbc5b4d63ee0c28545670d9ddd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230502065025epcas2p34507ffad60b32e091ff0efeced9bc12f
References: <20230502062813.112434-1-jaewon02.kim@samsung.com>
        <CGME20230502065025epcas2p34507ffad60b32e091ff0efeced9bc12f@epcas2p3.samsung.com>
        <20230502062813.112434-4-jaewon02.kim@samsung.com>
        <d8fa2d7b-6604-1fad-6b0b-19d7e551a1d2@samsung.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marek


On 23. 5. 9. 22:03, Marek Szyprowski wrote:
> On 02.05.2023 08:28, Jaewon Kim wrote:
>> Support interrupt based pio mode to optimize cpu usage.
>> When transmitting data size is larget than 32 bytes, operates with
>> interrupt based pio mode.
>>
>> By using the FIFORDY INT, an interrupt can be triggered when
>> the desired size of data has been received. Using this, we can support
>> interrupt based pio mode.
>>
>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> This patch landed recently in linux-next as commit 1ee806718d5e ("spi:
> s3c64xx: support interrupt based pio mode"). Unfortunately it breaks
> ethernet chip operation on Exynos3250 based Artik5 Development board. I
> see the flood of the following messages:
>
> [   36.097739] ax88796c spi0.0: I/O Error: rx-1 tx-0 rx-f tx-p len-496
> dma-1 res-(-5)
> [   36.100877] ax88796c spi0.0: RX residue: 248
> [   36.101383] ax88796c spi0.0: SPI transfer failed: -5
> [   36.101939] spi_master spi0: failed to transfer one message from queue
> [   36.102439] ax88796c spi0.0: axspi_read_rxq() failed: ret = -5
> [   36.107830] s3c64xx-spi 13920000.spi: Failed to get RX DMA channel
> [   36.148875] ax88796c spi0.0: I/O Error: rx-0 tx-1 rx-p tx-f len-4
> dma-0 res-(-5)
> [   36.149517] ax88796c spi0.0: SPI transfer failed: -5
> [   36.150053] spi_master spi0: failed to transfer one message from queue
> [   36.150562] ax88796c spi0.0: axspi_read_reg() failed: ret = -5
> [   36.152175] s3c64xx-spi 13920000.spi: Failed to get RX DMA channel
> [   36.191651] ax88796c spi0.0: I/O Error: rx-0 tx-1 rx-p tx-f len-4
> dma-0 res-(-5)
> [   36.192268] ax88796c spi0.0: SPI transfer failed: -5
>
> ...
>
> I didn't analyze the details, but imho it looks like some kind of
> mishandling of the corner case or switching between PIO and DMA mode. I
> will check the details later.
>
>
> Best regards


Thanks for testing the various cases.

The problem occurred when DMA mode and IRQ mode were enabled at the same 
time.


In the above case, BUS_WIDTH register invaded.

Because, target length 496 were written to RX_RDY_LVL, but it exceeded 
6-bits.

Could you test with below code??? If the problem is solved, I will send 
a fix patch as soon as possible.

-----------------------------

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 238db29fc93b..a72e11e965c3 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -782,7 +782,7 @@ static int s3c64xx_spi_transfer_one(struct 
spi_master *master,

         do {
                 /* transfer size is greater than 32, change to IRQ mode */
-               if (xfer->len > S3C64XX_SPI_POLLING_SIZE)
+               if (!use_dma && (xfer->len > S3C64XX_SPI_POLLING_SIZE))
                         use_irq = true;

                 if (use_irq) {

-----------------------------


Best regards

Jaewon Kim

