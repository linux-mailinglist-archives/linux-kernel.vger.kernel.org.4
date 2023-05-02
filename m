Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94276F3DCE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 08:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbjEBGuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 02:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbjEBGul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 02:50:41 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664B24497
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 23:50:32 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230502065027epoutp0221e769016b7e7c641280a13721119757~bQOJ2U7Xw2219022190epoutp02b
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 06:50:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230502065027epoutp0221e769016b7e7c641280a13721119757~bQOJ2U7Xw2219022190epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683010227;
        bh=SKfZujidrsTqsYmF1eZVH0aLq7NMqVnKheBQjJ2VIT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jOvpUuFLrM7+fGPaobuPDVrjG+QIFxmHBL7Yx2TT2tuhk5Pu3gR5pZFl5z5Rf1RRD
         ZulRz7pfI0pN5Hn+SSwZ65iavFuou+hFtaUM7FIM6SgF1rjZa3doBAJDYSPIo0IDv4
         wrtLvhEpOATWEN3KTzkzhg8Xju2FA9E+sq66hQuI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230502065026epcas2p4d46573700cde0ba3673be225a1a0a5a3~bQOJhDFLB1117111171epcas2p4G;
        Tue,  2 May 2023 06:50:26 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.102]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Q9W1F6vpxz4x9QK; Tue,  2 May
        2023 06:50:25 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        F9.9B.08199.1B2B0546; Tue,  2 May 2023 15:50:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230502065025epcas2p11549db7400e6707c61bbb1cff1b22252~bQOIQqA191499014990epcas2p10;
        Tue,  2 May 2023 06:50:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230502065025epsmtrp237e89755b46524fb8662ca8adafd175e~bQOIP-WLO2944229442epsmtrp2N;
        Tue,  2 May 2023 06:50:25 +0000 (GMT)
X-AuditID: b6c32a47-c29ff70000002007-fe-6450b2b1d88d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        34.C8.27706.1B2B0546; Tue,  2 May 2023 15:50:25 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230502065025epsmtip1aed5ec98fa8945164cb1bf16b0809bfe~bQOIE3KSD1524115241epsmtip1m;
        Tue,  2 May 2023 06:50:25 +0000 (GMT)
From:   Jaewon Kim <jaewon02.kim@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH v3 2/3] spi: s3c64xx: add sleep during transfer
Date:   Tue,  2 May 2023 15:28:12 +0900
Message-Id: <20230502062813.112434-3-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230502062813.112434-1-jaewon02.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsWy7bCmue7GTQEpBuemG1s8mLeNzWLxj+dM
        FlMfPmGzuLxf22JHwxFWi72vt7JbbHp8jdXi8q45bBYzzu9jsmj8eJPdgcvj+pJPzB6bVnWy
        edy5tofNY/OSeo++LasYPT5vkgtgi8q2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0
        MFdSyEvMTbVVcvEJ0HXLzAE6TEmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6g
        V5yYW1yal66Xl1piZWhgYGQKVJiQnfH1cWzBQ66Kd0cXszYw3uPoYuTkkBAwkTj99zxzFyMX
        h5DADkaJ3Y93QTmfGCWO/OlkgXC+MUo0zHvGCNMy/9tJRojEXkaJGasboZyPjBLLbneDVbEJ
        aEt8X7+YFSQhIrCYUWLB1Z3sIA6zwA1Gie43m1lAqoQF7CWO3z4FZrMIqEqsvXqBCcTmFbCT
        WH1zNxPEPnmJ1RsOMIPYnED195pawKZKCNxjl7jR9xrqKBeJ849eskHYwhKvjm9hh7ClJD6/
        2wsVz5Zon/6HFcKukLi4YTZU3Fhi1rN2oDkcQNdpSqzfpQ9iSggoSxy5BXYaswCfRMfhv+wQ
        YV6JjjYhiEY1iftTz0ENkZGYdGQl1MUeEr8uzIAG3SRGiSUv1zBOYJSbhbBgASPjKkax1ILi
        3PTUYqMCY3iUJefnbmIEpzwt9x2MM95+0DvEyMTBeIhRgoNZSYT3Q6FfihBvSmJlVWpRfnxR
        aU5q8SFGU2DYTWSWEk3OBybdvJJ4QxNLAxMzM0NzI1MDcyVxXmnbk8lCAumJJanZqakFqUUw
        fUwcnFINTNU9Saf/b1zL1dH5pHKyiPWeGfHvNxndeDRxx9YNCcEXtS54LVP/6voilJtXqqVE
        /yiHSiD7+aQSq0SpI3G7DDP9zdq3/9J72CdxQVsl6kIPx7sKJ47JC46F77l1TXXu1e8+PG8u
        vXm9dr/5wlvcDHtb13r5rWTew+IQcMhkich8yWt/Lp1QyNs+i+nZu8D3b+f6t7LWXJTdft9l
        yrzcM/6ffRzX33hgIFijKHLoi8C3NNeN9h7q2dM0rt9YVNI8NyHvozTntpJNTqdjWdfmas/3
        r8+TydRY0FJ48/f+z6fNrSeGdLpyrrGXnWNjKS4rrqpXz2Js6nms48Tu7ld5EtME7vzcl3cu
        dtfGCYcbOpRYijMSDbWYi4oTAdSSxpgCBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsWy7bCSnO7GTQEpBn9eilo8mLeNzWLxj+dM
        FlMfPmGzuLxf22JHwxFWi72vt7JbbHp8jdXi8q45bBYzzu9jsmj8eJPdgcvj+pJPzB6bVnWy
        edy5tofNY/OSeo++LasYPT5vkgtgi+KySUnNySxLLdK3S+DK+Po4tuAhV8W7o4tZGxjvcXQx
        cnJICJhIzP92khHEFhLYzSix7HgpRFxGYvmzPjYIW1jifssRVoia94wSt2Yog9hsAtoS39cv
        BopzcYgILGWUeLznMQuIwyxwj1Hi5aRvTCBVwgL2Esdvn2IBsVkEVCXWXr0AFucVsJNYfXM3
        E8QGeYnVGw4wg9icQPX3mlqgttlJXOn9yjqBkW8BI8MqRsnUguLc9NxiwwLDvNRyveLE3OLS
        vHS95PzcTYzgwNTS3MG4fdUHvUOMTByMhxglOJiVRHg/FPqlCPGmJFZWpRblxxeV5qQWH2KU
        5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cBUcVa10fXQJFaB/98DVeuyp68tW7VIT26m
        a4Tj/sZLcWFG7ju8DhaKut+xYP8+f7rg6+vZZ068eXPTIP30+7B0WcYmm508tx4n3Sg9+3vJ
        v7OL1LjnnHgzfxKjjtK9sMxFlWudptzdsaRY+gGPaJzMR5UwnYW3pFdsmJNW/s7u6R8ppfO6
        kQUBR9sEtdsPVIk9/huwuCU05kjEPL2inkdVFk2PA7oXLxNS99J7npIS9+iRh4lwjP3ZxuIj
        K4pFRN90ernmiR8+PE+4ZsJenfQt738dvRkixf5a7JTRLo50ryKGjA2nzzuq28yq1FWft/+x
        pqfP0XeGD72Ddll07/+qvYjN0Fc+SFWmkq1KeoYSS3FGoqEWc1FxIgDX9jshuwIAAA==
X-CMS-MailID: 20230502065025epcas2p11549db7400e6707c61bbb1cff1b22252
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230502065025epcas2p11549db7400e6707c61bbb1cff1b22252
References: <20230502062813.112434-1-jaewon02.kim@samsung.com>
        <CGME20230502065025epcas2p11549db7400e6707c61bbb1cff1b22252@epcas2p1.samsung.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In polling mode, the status register is continuously read to check data
transfer completion. It can cause excessive CPU usage.
To reduce this, we can calculate the transfer time and put the sleep during
transfer.

When test on ExynosAuto9 SADK board, throughput remained the same, but
100% CPU utilization decreased to 40%.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 66ac94022a1b..2a8304678df9 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -561,11 +561,18 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
 	u32 cpy_len;
 	u8 *buf;
 	int ms;
+	unsigned long time_us;
 
-	/* millisecs to xfer 'len' bytes @ 'cur_speed' */
-	ms = xfer->len * 8 * 1000 / sdd->cur_speed;
+	/* microsecs to xfer 'len' bytes @ 'cur_speed' */
+	time_us = (xfer->len * 8 * 1000 * 1000) / sdd->cur_speed;
+	ms = (time_us / 1000);
 	ms += 10; /* some tolerance */
 
+	/* sleep during signal transfer time */
+	status = readl(regs + S3C64XX_SPI_STATUS);
+	if (RX_FIFO_LVL(status, sdd) < xfer->len)
+		usleep_range(time_us / 2, time_us);
+
 	val = msecs_to_loops(ms);
 	do {
 		status = readl(regs + S3C64XX_SPI_STATUS);
-- 
2.17.1

