Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734E56E7343
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 08:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjDSG2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 02:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjDSG2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 02:28:18 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41257ABA
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 23:27:58 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230419062757epoutp02c25455c906c82274763c5c11404da29a~XQhzP529Q2618726187epoutp02Z
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 06:27:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230419062757epoutp02c25455c906c82274763c5c11404da29a~XQhzP529Q2618726187epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681885677;
        bh=zBQii4SsEZtzNvLXFRd+FOyaA7s8PZ1eCZ95L8Nnpsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MqxrFC4mu3D8OUVkVolOuf3EfE+y3ZRqSm0dZWJYMDqrKUDFkXwoovSAhqX6NxG0A
         Fp0SVIx5IiaBVuXaLSECffSK2LSb4JwTpyj/Rpschu0zB3cQqgXzdPhV1WsMochntm
         05wqvKGYiNmoMvSbPdi8q35A3vv2l4MHFXpCxty0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230419062756epcas2p4d4a9d2b4a40b21f122c508e269bc07d0~XQhySo0Hg2825128251epcas2p4R;
        Wed, 19 Apr 2023 06:27:56 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.68]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Q1W7H6ncRz4x9Pt; Wed, 19 Apr
        2023 06:27:55 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        59.79.10686.BE98F346; Wed, 19 Apr 2023 15:27:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230419062755epcas2p1bca14bbd5200ebe5241780d2d7ec1596~XQhxU57Zo1254712547epcas2p1E;
        Wed, 19 Apr 2023 06:27:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230419062755epsmtrp237eeea82f6a9201bccaf60ff17503d48~XQhxUF1lW0106901069epsmtrp2R;
        Wed, 19 Apr 2023 06:27:55 +0000 (GMT)
X-AuditID: b6c32a46-ed1f8700000029be-0e-643f89eb7f4f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CC.65.08279.BE98F346; Wed, 19 Apr 2023 15:27:55 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230419062755epsmtip23d3becbdee94c2272c6b2fb646350df1~XQhxJWMMz0489404894epsmtip2s;
        Wed, 19 Apr 2023 06:27:55 +0000 (GMT)
From:   Jaewon Kim <jaewon02.kim@samsung.com>
To:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH v2 3/4] spi: s3c64xx: add sleep during transfer
Date:   Wed, 19 Apr 2023 15:06:38 +0900
Message-Id: <20230419060639.38853-4-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230419060639.38853-1-jaewon02.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHKsWRmVeSWpSXmKPExsWy7bCmqe7rTvsUg4dzDSwezNvGZrH4x3Mm
        i6kPn7BZXN6vbbGj4Qirxd7XW9ktNj2+xmpxedccNosZ5/cxWTR+vMnuwOVxfcknZo9NqzrZ
        PO5c28PmsXlJvUffllWMHp83yQWwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpa
        mCsp5CXmptoqufgE6Lpl5gAdpqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/Q
        K07MLS7NS9fLSy2xMjQwMDIFKkzIzljfs4ix4CV7RdvTyWwNjBvZuhg5OSQETCSWrGpi7mLk
        4hAS2MEoMW3TT0YI5xOjxN0NR5kgnG+MEic2fGOGaXn49xQLRGIvo8TCpwvZIJyPjBI3Tjex
        g1SxCWhLfF+/mBUkISKwmFFi798vYFuYBW4wSnS/2cwCUiUsYC/xZOdUoA4ODhYBVYmmPnmQ
        MK+ArcSuL7+h1slLrN5wAMzmFLCTWPjpGtg2CYF77BK3N65lAemVEHCRaFzhAFEvLPHq+BZ2
        CFtK4vO7vVCfZku0T//DCmFXSFzcMBsqbiwx61k7I8gYZgFNifW79CEmKkscuQV2JLMAn0TH
        4b/sEGFeiY42IYhGNYn7U89BDZGRmHRkJROE7SHxf9Y8aPhMZJT49m4ZywRGuVkICxYwMq5i
        FEstKM5NTy02KjCCx1hyfu4mRnDC03LbwTjl7Qe9Q4xMHIyHGCU4mJVEeM+4WqUI8aYkVlal
        FuXHF5XmpBYfYjQFhtxEZinR5Hxgys0riTc0sTQwMTMzNDcyNTBXEueVtj2ZLCSQnliSmp2a
        WpBaBNPHxMEp1cC03/piV3FrcFP3zZR7s+pW+Hrx8Kmve7Tvztv+3CcMT6Mqz5+84tj49dmO
        j4FPCu/wWTvsjGS7v+rHn89SO9wSNvhr3i9fc961JHr7I4fjP5mvXHp2gV3ltc4C0z/Mek5X
        Ar/sm1vI71JUHTtdX69XNun6W+O3bId9f1ZU3lSdu2T/5ikxizY76b49++Sp2qUoD+Xqn3te
        lUU0cO1Zasp3ZcIr6Ut8uyY/65epubZjccf7BZHHeBuWrvmkMzFNXOmZ4vsVW+umWgVfKM/2
        Ntm66cE8ySvS0gLnrWtSGDj/KibMW7NS1owhfmmGjewD+6kL/cu3Bp+4KmRzsL/H69kC7TeL
        9pgeT1yek6nPdWE+kxJLcUaioRZzUXEiAO8u0ucBBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsWy7bCSvO7rTvsUg7sX+SwezNvGZrH4x3Mm
        i6kPn7BZXN6vbbGj4Qirxd7XW9ktNj2+xmpxedccNosZ5/cxWTR+vMnuwOVxfcknZo9NqzrZ
        PO5c28PmsXlJvUffllWMHp83yQWwRXHZpKTmZJalFunbJXBlrO9ZxFjwkr2i7elktgbGjWxd
        jJwcEgImEg//nmLpYuTiEBLYzShxqq+NGSIhI7H8WR9UkbDE/ZYjrBBF7xkllrW1gSXYBLQl
        vq9fzApiiwgsZZS42S0FUsQscI9R4uWkb0wgCWEBe4knO6eydzFycLAIqEo09cmDhHkFbCV2
        ffkNtUxeYvWGA2A2p4CdxMJP18DmCwHV7J73ln0CI98CRoZVjJKpBcW56bnFhgWGeanlesWJ
        ucWleel6yfm5mxjBoamluYNx+6oPeocYmTgYDzFKcDArifCecbVKEeJNSaysSi3Kjy8qzUkt
        PsQozcGiJM57oetkvJBAemJJanZqakFqEUyWiYNTqoGJgUEssVXkV3vc98t8xsIWQl4nufnf
        MXdqd99qdEusj/zE95jzDk/DtsliKcFnTNasOdqgPivhUfrTc6K7Xukaq07cP1laOUVJf7/p
        4XMxN+pT2wwsdwTXemyrSZJMnF6lxL5konNkyP0zD/c7pwVP+5v15/4L2Wfd3tdLHzVFm7y9
        pbbXJ5hX07+kaZvLqegW7sK2AEUN24tHQ5lE1rx6KvK7uuVrU0z14UMxz/KYJ+zTe/bv7LTm
        Stuu5YnnDwTe6f9/f5Z/peRqWZ6YlQcMOIu/Hl356pp0t64V19dD6joPHPm9l54T234yUf/E
        OvtnNcHJXrOset6Ltzq/l13L+fiGxfsyZ0P/uLnGs5RYijMSDbWYi4oTAVVTr968AgAA
X-CMS-MailID: 20230419062755epcas2p1bca14bbd5200ebe5241780d2d7ec1596
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230419062755epcas2p1bca14bbd5200ebe5241780d2d7ec1596
References: <20230419060639.38853-1-jaewon02.kim@samsung.com>
        <CGME20230419062755epcas2p1bca14bbd5200ebe5241780d2d7ec1596@epcas2p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In polling mode, the status register is constantly read to check transfer
completion. It cause excessive CPU usage.
So, it calculates the SPI transfer time and made it sleep.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 886722fb40ea..cf3060b2639b 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -561,6 +561,14 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
 	u32 cpy_len;
 	u8 *buf;
 	int ms;
+	u32 tx_time;
+
+	/* sleep during signal transfer time */
+	status = readl(regs + S3C64XX_SPI_STATUS);
+	if (RX_FIFO_LVL(status, sdd) < xfer->len) {
+		tx_time = (xfer->len * 8 * 1000 * 1000) / sdd->cur_speed;
+		usleep_range(tx_time / 2, tx_time);
+	}
 
 	/* millisecs to xfer 'len' bytes @ 'cur_speed' */
 	ms = xfer->len * 8 * 1000 / sdd->cur_speed;
-- 
2.17.1

