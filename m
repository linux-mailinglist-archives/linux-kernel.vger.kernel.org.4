Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF296FDD66
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 14:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236883AbjEJMDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 08:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236902AbjEJMC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 08:02:57 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F647294
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 05:02:49 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230510120247epoutp03b5f23ecf03cbf7e0529ba15021db4171~dxpJBtciH1545715457epoutp03U
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 12:02:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230510120247epoutp03b5f23ecf03cbf7e0529ba15021db4171~dxpJBtciH1545715457epoutp03U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683720167;
        bh=CUGfWQVDfEC5k+8Md6XQtTpXOoA0eMh5vCwgvW3SvH4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=jMHwSxvvVzXHgHokGsxbYndBTYjpqM/7OWwHepahN6vJcbxEsrtP4FXx7IgYxMvqQ
         6XwJSs94CokQA9nMnTQjoXyNJQralN/ZMXMTMUP+XoQQvxuHEZo/MuZrObvV44QO8o
         A+Dy8CSw97rKyFAG+OWh4cUd/xRfaMS2FoCOS1Fo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230510120246epcas2p4f486084a95e25e9c4420fec4a731afc1~dxpIkwJIw2560325603epcas2p4S;
        Wed, 10 May 2023 12:02:46 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.69]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QGYYx6TnFz4x9Pt; Wed, 10 May
        2023 12:02:45 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        52.B5.03265.5E78B546; Wed, 10 May 2023 21:02:45 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230510120245epcas2p2cea91a04ef2fd46f0fa9f22f73c5b2eb~dxpHRMzzk2509125091epcas2p2w;
        Wed, 10 May 2023 12:02:45 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230510120245epsmtrp24ed9483bc2edd0df4238447044360c22~dxpHQbcbS1651316513epsmtrp2I;
        Wed, 10 May 2023 12:02:45 +0000 (GMT)
X-AuditID: b6c32a45-465ff70000020cc1-26-645b87e557d4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        EB.60.28392.5E78B546; Wed, 10 May 2023 21:02:45 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230510120244epsmtip2d935ed4f6fafad2cd53b1cd23dccc6cd~dxpG_IGYa2649226492epsmtip2a;
        Wed, 10 May 2023 12:02:44 +0000 (GMT)
From:   Jaewon Kim <jaewon02.kim@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH] spi: s3c64xx: Disable IRQ mode when using DMA
Date:   Wed, 10 May 2023 20:39:42 +0900
Message-Id: <20230510113942.89994-1-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7bCmue7T9ugUg0/HjC0ezNvGZrH4x3Mm
        i6kPn7BZXN6vbbGj4Qirxd7XW9ktNj2+xmpxedccNosZ5/cxWTR+vMlusfbIXXYHbo/rSz4x
        e2xa1cnmcefaHjaPzUvqPfq2rGL0+LxJLoAtKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTM
        wFDX0NLCXEkhLzE31VbJxSdA1y0zB+g6JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpB
        Sk6BeYFecWJucWleul5eaomVoYGBkSlQYUJ2xrbumYwFCzgqNv/8xtTA+Jqti5GTQ0LARKKh
        eQV7FyMXh5DADkaJR3vnsUI4nxglfi9aygbhfGaUmHJvNSNMy8/JK1kgEruAEhtaoZyPjBJ9
        TzazgFSxCWhLfF+/GGyWiMBiRokFV3eCbWEWaGeSOHd5GStIlbCAncSLdYeBbA4OFgFVif1b
        rEHCvAK2Eq87DjFDrJOXWL3hADNIr4TAJXaJuR87WSASLhLXJ39jhbCFJV4d38IOYUtJfH63
        F+q9bIn26X+gaiokLm6YDRU3lpj1rJ0RZC+zgKbE+l36IKaEgLLEkVtg05kF+CQ6Dv9lhwjz
        SnS0CUE0qkncn3oOaoiMxKQjK5kgbA+JL5sug9lCArESZ9dcZpzAKDsLYf4CRsZVjGKpBcW5
        6anFRgWG8FhKzs/dxAhOcVquOxgnv/2gd4iRiYPxEKMEB7OSCK93aFSKEG9KYmVValF+fFFp
        TmrxIUZTYGhNZJYSTc4HJtm8knhDE0sDEzMzQ3MjUwNzJXFeaduTyUIC6YklqdmpqQWpRTB9
        TBycUg1Mqbmr2NlC+J9xmE0v49Jf1TLbdNqHEwVzd8amVXvJpiybp9EZdDPqhpLTVv95XDm8
        j2ImhG+7NOvGYme3kFC7aMkzeV4v375Zvk2q3tGUTU0w4K3AnZvG2dLL1M9U391+QWpLn9iO
        afwBB7RsjFdsLSw853A674u9tbzmIZui3/v2nL7xOu64fN781/v33RdPSNhb6/WL8QKzZMik
        5xL/J/n9ahT3Fy5w+681cfHLeP7VH7vSzYX5n9/+rnb4/6dGF/4/hSbau63nzDFY+yR0t7bm
        hxW56d/0b0efLRG7reXz6GttkOHSR6dyJr5JzDiszbAhLSNp7fHZX7bPPaT/8FrEnO+u/xnZ
        rlQ+qPqnrcRSnJFoqMVcVJwIAAL2PG76AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGLMWRmVeSWpSXmKPExsWy7bCSvO7T9ugUg8kd7BYP5m1js1j84zmT
        xdSHT9gsLu/XttjRcITVYu/rrewWmx5fY7W4vGsOm8WM8/uYLBo/3mS3WHvkLrsDt8f1JZ+Y
        PTat6mTzuHNtD5vH5iX1Hn1bVjF6fN4kF8AWxWWTkpqTWZZapG+XwJWxrXsmY8ECjorNP78x
        NTC+Zuti5OSQEDCR+Dl5JUsXIxeHkMAORolL8+YwQSRkJJY/64MqEpa433KEFaLoPaPE2l+3
        WEASbALaEt/XLwZLiAgsZZR4vOcxWIJZoJdJYt4mcxBbWMBO4sW6w0BFHBwsAqoS+7dYg4R5
        BWwlXnccYoZYIC+xesMB5gmMPAsYGVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgQH
        nZbWDsY9qz7oHWJk4mA8xCjBwawkwusdGpUixJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4
        IYH0xJLU7NTUgtQimCwTB6dUA1Mzq1KNYk+Xb8qsxzZ1YisYPnycefGdiMb5dTnfZpTunc4/
        27nlduX2rwcUb7geVHXvu9n6+/uRF+EXv4Zv7lF7nlHPKbeq51nNkmO9m5L/7LuztDvjG3d9
        wtV58nsT2XLDP+lZLGN4uHc/77M5URrRMxOXxaXcXckRMO+wfURwe0dIi3ejboXqiZuPxO38
        cp7+FDzhbmf8TvLKJxWLy8/Mlh1SaX+usGvWKssPn3OnbbyS3bpvkpylQLS/4QnBs63m87q+
        fKpdt4uNd1e4RPzzsnh7bf2z13Ynp1xJ8/ytVMj6V/Vu7955d5+r569K4Lmh+quh69znJ48M
        p822PHj0xPIvZpuLz5zc6uM014dNiaU4I9FQi7moOBEAa/YXj6kCAAA=
X-CMS-MailID: 20230510120245epcas2p2cea91a04ef2fd46f0fa9f22f73c5b2eb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230510120245epcas2p2cea91a04ef2fd46f0fa9f22f73c5b2eb
References: <CGME20230510120245epcas2p2cea91a04ef2fd46f0fa9f22f73c5b2eb@epcas2p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing the problem of enabling DMA mode and IRQ mode at the same time.
In this case, a value of more than 6bits is written to RDY_LVL, it can
cause an invasion of other registers, potentially leading to SPI
transfer failure.

Fixes: 1ee806718d5e ("spi: s3c64xx: support interrupt based pio mode")
Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 238db29fc93b..c6a8a6434140 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -782,7 +782,7 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 
 	do {
 		/* transfer size is greater than 32, change to IRQ mode */
-		if (xfer->len > S3C64XX_SPI_POLLING_SIZE)
+		if (!use_dma && xfer->len > S3C64XX_SPI_POLLING_SIZE)
 			use_irq = true;
 
 		if (use_irq) {
-- 
2.17.1

