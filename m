Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8B06E7340
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 08:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjDSG2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 02:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjDSG2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 02:28:17 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F8265AB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 23:27:58 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230419062756epoutp032ff1dff336245f63368ad1e5fae297ed~XQhy2j5WR1183111831epoutp03b
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 06:27:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230419062756epoutp032ff1dff336245f63368ad1e5fae297ed~XQhy2j5WR1183111831epoutp03b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681885676;
        bh=ObxsSdFs5WAZmJuj7FAlx5qDmt4YK3vF0QVFupjZfVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sc2jvlC7tADiI79yZ+c6ZmOWPdgqYRpnS2snzVpwArhlcHGgAhW9DWc2lL0+hS/wN
         gM4n4aBZrYSlTAM+4tFAh/KNxI6sYfQeu0xbZxuKq8qSleFC8fMOwPf0O+nrEdmd+h
         K6Jiljp+U6JGb5qazlaLkZBUUVsl2ItybK+vlWYo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230419062756epcas2p370909a87da2f81f7461caa8c89808af4~XQhyXBwTY0412704127epcas2p3g;
        Wed, 19 Apr 2023 06:27:56 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.88]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Q1W7J0YsQz4x9Q8; Wed, 19 Apr
        2023 06:27:56 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        84.C2.09961.BE98F346; Wed, 19 Apr 2023 15:27:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230419062755epcas2p43a646bbae5f01e3120331407ad873318~XQhxQbeOd2842728427epcas2p4Q;
        Wed, 19 Apr 2023 06:27:55 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230419062755epsmtrp177357b9586a7d9848c0d786aabf99ca1~XQhxPur2P2169721697epsmtrp1F;
        Wed, 19 Apr 2023 06:27:55 +0000 (GMT)
X-AuditID: b6c32a45-e13fa700000026e9-54-643f89ebed4f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        41.71.08609.BE98F346; Wed, 19 Apr 2023 15:27:55 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230419062755epsmtip2b08d471e899b00fb8fd358f6a2225488~XQhxDWS_G0394003940epsmtip2W;
        Wed, 19 Apr 2023 06:27:54 +0000 (GMT)
From:   Jaewon Kim <jaewon02.kim@samsung.com>
To:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH v2 2/4] spi: s3c64xx: add cpu_relax in polling loop
Date:   Wed, 19 Apr 2023 15:06:37 +0900
Message-Id: <20230419060639.38853-3-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230419060639.38853-1-jaewon02.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHKsWRmVeSWpSXmKPExsWy7bCmme7rTvsUgx/95hYP5m1js1j84zmT
        xdSHT9gsLu/XttjRcITVYu/rrewWmx5fY7W4vGsOm8WM8/uYLBo/3mR34PK4vuQTs8emVZ1s
        Hneu7WHz2Lyk3qNvyypGj8+b5ALYorJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0t
        zJUU8hJzU22VXHwCdN0yc4AOU1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBfo
        FSfmFpfmpevlpZZYGRoYGJkCFSZkZ7T8+cRUsIu14tPSc0wNjEdZuhg5OSQETCQ+rDjH3MXI
        xSEksINRYs3GD4wQzidGiSvLrzBBOJ8ZJVq+nmKEafnR3AJmCwnsYpS4+N4Kougjo8ScM0dY
        QRJsAtoS39cvZgVJiAgsZpTY+/cL2BJmgRuMEt1vNgNt5+AQFnCWOHMDrIFFQFWicfsysKm8
        ArYSs4/dYYXYJi+xesMBZhCbU8BOYuGna2wgcyQEXrJLHJ7/jxmiyEVizbWjUOcJS7w6voUd
        wpaSeNnfBmVnS7RP/wM1tELi4obZbBC2scSsZ+2MIPcwC2hKrN+lD2JKCChLHLkFDiNmAT6J
        jsN/2SHCvBIdbUIQjWoS96eegxoiIzHpyEomCNtD4sjMXWyQMJnIKPH3wjfmCYxysxAWLGBk
        XMUollpQnJueWmxUYAiPseT83E2M4ISn5bqDcfLbD3qHGJk4GA8xSnAwK4nwnnG1ShHiTUms
        rEotyo8vKs1JLT7EaAoMu4nMUqLJ+cCUm1cSb2hiaWBiZmZobmRqYK4kzittezJZSCA9sSQ1
        OzW1ILUIpo+Jg1OqgWmj0Hv9g5IL2Q7am9Ve2VNYvjnzrPSupoeHOdqnzAiLFtbXkjBjuLRg
        dkxtoaa0eMj10k2VGj9+tjms3iHMwfq649TtjC+TTK4evynwNi5wX4vXwzwWAXe7Ck99vnf3
        3poIfXn45H/zjYTaycczZ8yfkFd39CmfmsieSy43TzrdLJHXCn8bvGH2zKgdyzYvUCphu1/U
        fGnVqyvPBd+8DrEpV3qd5519jfta8fFegf89+w13+j06ITydTc4s6Ja3681+mZXb/81UlBOw
        W33h4Izo1vV+ac9OJyfqzJHY0nJrttyupZ+D0t63belyN1D7z5F7pHXlMWHJVoegiOQkXuOT
        bqfPbXjMP7E/OOhkAIsSS3FGoqEWc1FxIgBDKjD/AQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsWy7bCSvO7rTvsUg+dtnBYP5m1js1j84zmT
        xdSHT9gsLu/XttjRcITVYu/rrewWmx5fY7W4vGsOm8WM8/uYLBo/3mR34PK4vuQTs8emVZ1s
        Hneu7WHz2Lyk3qNvyypGj8+b5ALYorhsUlJzMstSi/TtErgyWv58YirYxVrxaek5pgbGoyxd
        jJwcEgImEj+aWxi7GLk4hAR2MErcm3uSHSIhI7H8WR8bhC0scb/lCCtE0XtGiWPPv4MVsQlo
        S3xfv5gVxBYRWMoocbNbCqSIWeAeo8TLSd+Yuhg5OIQFnCXO3ACrYRFQlWjcvowRxOYVsJWY
        fewOK8QCeYnVGw4wg9icAnYSCz9dA1ssBFSze95b9gmMfAsYGVYxSqYWFOem5xYbFhjlpZbr
        FSfmFpfmpesl5+duYgSHppbWDsY9qz7oHWJk4mA8xCjBwawkwnvG1SpFiDclsbIqtSg/vqg0
        J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBqZOjsLiGv0T90OLv2o5JnotP+lh
        xCnOnf9wT3+zb2+41NziGs4b8Sw+HBP4fM5+Tt13rT7D4Uzf9MVPXs4R+j5Z4BjnnftWHTab
        5wUruPLOuP1l04S6H9dCWD+6LGVXExabLDJn0fH3t26ffLL24SZZn9SQa5fmS583Whcx5c4h
        Awam0oiEsnzjB0yhzMyLLjG3TH1o/JOFucJ+4jTW93Vqmzm4fA7LpTv99nx39uLh5TZznR4m
        WmWeu/CPW0T9X9ymn1U//69vyhIvC5i5+6lNjkRHW9rJbZ/9S2S3CZb/Wbvjxtz6HL6AvACZ
        4w1LTJe/qf6/wUpo87r38+/WGVx92RRwOzXk04miRK/a0GYlluKMREMt5qLiRAA82Q5OvAIA
        AA==
X-CMS-MailID: 20230419062755epcas2p43a646bbae5f01e3120331407ad873318
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230419062755epcas2p43a646bbae5f01e3120331407ad873318
References: <20230419060639.38853-1-jaewon02.kim@samsung.com>
        <CGME20230419062755epcas2p43a646bbae5f01e3120331407ad873318@epcas2p4.samsung.com>
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

Adds cpu_relax() to prevent long busy-wait.
There is busy-wait loop to check data transfer completion in polling mode.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 273aa02322d9..886722fb40ea 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -568,6 +568,7 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
 
 	val = msecs_to_loops(ms);
 	do {
+		cpu_relax();
 		status = readl(regs + S3C64XX_SPI_STATUS);
 	} while (RX_FIFO_LVL(status, sdd) < xfer->len && --val);
 
-- 
2.17.1

