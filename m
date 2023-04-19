Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275EE6E7342
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 08:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjDSG2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 02:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjDSG2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 02:28:17 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DB67A99
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 23:27:58 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230419062756epoutp044c6f75cf7f989769e5dd04edc64a256f~XQhymR7dE1266012660epoutp04M
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 06:27:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230419062756epoutp044c6f75cf7f989769e5dd04edc64a256f~XQhymR7dE1266012660epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681885676;
        bh=SJljSJk+BMBPb/xhoTc9Ctr+o1SwRSTtNgez3xm6XqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jycHWtvIST3bnvW4CVUCpqNdDiYgXOlVdbB0tPUHILcHt1uhzSoW8q9jJ9Mme8VZc
         fZkeQ9kXgenJHVYGWuFCbSr4ZTXUiOa5LC07lYZnf6diE/uGAsRSVbXCeLDrX02QSH
         KKkD/LY3uh31PK/EWqy9L6EkeQEcTFwpKqnB7btk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230419062756epcas2p1732c93edbc4837a46c910d198313a988~XQhyPygOA0776907769epcas2p1E;
        Wed, 19 Apr 2023 06:27:56 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.92]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Q1W7H6sJPz4x9Q8; Wed, 19 Apr
        2023 06:27:55 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.C2.09961.BE98F346; Wed, 19 Apr 2023 15:27:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230419062755epcas2p1370c1ca60d88d6b114a7c7c1de3f15c0~XQhxNQgMp1254712547epcas2p1D;
        Wed, 19 Apr 2023 06:27:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230419062755epsmtrp16b19ddf937434c40320e1b50ed1e9587~XQhxMcZF62169721697epsmtrp1E;
        Wed, 19 Apr 2023 06:27:55 +0000 (GMT)
X-AuditID: b6c32a45-e13fa700000026e9-50-643f89eba21d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0C.65.08279.AE98F346; Wed, 19 Apr 2023 15:27:55 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230419062754epsmtip29dca3d187ac7f77ba5c31d8211f9c2a1~XQhw-k_mh0489404894epsmtip2r;
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
Subject: [PATCH v2 1/4] spi: s3c64xx: changed to PIO mode if there is no DMA
Date:   Wed, 19 Apr 2023 15:06:36 +0900
Message-Id: <20230419060639.38853-2-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230419060639.38853-1-jaewon02.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsWy7bCmue7rTvsUg3enTS0ezNvGZrH4x3Mm
        i6kPn7BZXN6vbbGj4Qirxd7XW9ktNj2+xmpxedccNosZ5/cxWTR+vMnuwOVxfcknZo9NqzrZ
        PO5c28PmsXlJvUffllWMHp83yQWwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpa
        mCsp5CXmptoqufgE6Lpl5gAdpqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/Q
        K07MLS7NS9fLSy2xMjQwMDIFKkzIzmg5fZG14DdfxYLf01gbGDfwdDFyckgImEh8WXSRuYuR
        i0NIYAejxNOGk6wgCSGBT0DO3iiIxDdGiS37+phgOpqXHWSDSOxllOhtOcQO4XxklHi46zs7
        SBWbgLbE9/WLWUESIgKLGSX2/v0CtoRZ4AajRPebzSwgVcICPhIf515iA7FZBFQlpqy/DLaD
        V8BW4nNvLyvEPnmJ1RsOMIPYnAJ2Egs/XQPbLSHwiF3izdMlLBBFLhInGrvYIGxhiVfHt7BD
        2FISL/vboOxsifbpf6CGVkhc3DAbqt5YYtazdsYuRg6g6zQl1u/SBzElBJQljtwCm84swCfR
        cfgvO0SYV6KjTQiiUU3i/tRzUENkJCYdWQkNIQ+JKx3boGE6kVHizuFP7BMY5WYhLFjAyLiK
        USy1oDg3PbXYqMAQHmXJ+bmbGMEpT8t1B+Pktx/0DjEycTAeYpTgYFYS4T3japUixJuSWFmV
        WpQfX1Sak1p8iNEUGHYTmaVEk/OBSTevJN7QxNLAxMzM0NzI1MBcSZxX2vZkspBAemJJanZq
        akFqEUwfEwenVANT6xFTh7UdYsGHjq+sqbJXn7296IhP603FyLZt8TduGS3wF2c7OF3qzKI1
        MzIeH83jcxFxZbsqcuVRC/8PhQ1KJZFiGwsE2pnOfLmxzXz6+qqcGYlnshqepErdvuuTmrie
        e/Ojv33vnjel7Z1q8O32QUXpjeeMKs7LXL3+tvu17fpiK7P+x0pxW9+sORCxY9u3Ze37zDgX
        h2UGPUgSnXmdW1jc58emzasFhF6bJ/1vEvB/P//X9mUapxivvXPcfHd2vjDrji2KPmf/57as
        2PjTo1PKxHWVfXSd6ob21/VPCyWi5Gq7mI/dT1/a4B0iwvHm/twH/BvFsj7bTync43rsl1Ww
        pH6z5To1/aaLYSXsSizFGYmGWsxFxYkAGsSYCAIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsWy7bCSvO7rTvsUg42vmSwezNvGZrH4x3Mm
        i6kPn7BZXN6vbbGj4Qirxd7XW9ktNj2+xmpxedccNosZ5/cxWTR+vMnuwOVxfcknZo9NqzrZ
        PO5c28PmsXlJvUffllWMHp83yQWwRXHZpKTmZJalFunbJXBltJy+yFrwm69iwe9prA2MG3i6
        GDk5JARMJJqXHWTrYuTiEBLYzSix4vdcFoiEjMTyZ31sELawxP2WI6wQRe8ZJVb9vMwMkmAT
        0Jb4vn4xK4gtIrCUUeJmtxRIEbPAPUaJl5O+MYEkhAV8JD7OvQQ2iUVAVWLK+stgcV4BW4nP
        vb2sEBvkJVZvOAA2lFPATmLhp2tg9UJANbvnvWWfwMi3gJFhFaNkakFxbnpusWGBYV5quV5x
        Ym5xaV66XnJ+7iZGcHBqae5g3L7qg94hRiYOxkOMEhzMSiK8Z1ytUoR4UxIrq1KL8uOLSnNS
        iw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgSjqTtKWlqWalw6wVmv6NZ1SnNxay
        f76Usu3/ot+T1r6wcN6QHz65//8d49vS0aclWhPNy9LdL6c9UpOMFVi/qi85gH3re3ehs7Fr
        /WSfyR97MqHwk6bplRdKJ9N0Ti/1MThqOok7amIcG7N2JofdNOFtzjkRyyrOH/5rcPr0uU6O
        LczPvj8Pevnhrn/bLfWgWT0rnX7/sTc0LLhrrST266ypTKHEDI8a5WOpLhyl+xx+7VaTqb+W
        nzlFlHOute2dglfsgmEzeppfZmf+6X1cEnhE48mEX2s/MxX7JX0yqtDK+vEwTKv8S+bG2To7
        F07eai8yicfcUpT30uyDjde/ztLgnWM8z/S95P2vP9/cUGIpzkg01GIuKk4EAEGOHZm9AgAA
X-CMS-MailID: 20230419062755epcas2p1370c1ca60d88d6b114a7c7c1de3f15c0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230419062755epcas2p1370c1ca60d88d6b114a7c7c1de3f15c0
References: <20230419060639.38853-1-jaewon02.kim@samsung.com>
        <CGME20230419062755epcas2p1370c1ca60d88d6b114a7c7c1de3f15c0@epcas2p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Polling mode supported with qurik if there was no DMA in the SOC.
However, there are cased where we cannot or do not want to use DMA.
To support this case, if DMA is not set, it is switched to polling mode.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 drivers/spi/spi-s3c64xx.c                 | 8 ++++++--
 include/linux/platform_data/spi-s3c64xx.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 71d324ec9a70..273aa02322d9 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -19,7 +19,6 @@
 #include <linux/platform_data/spi-s3c64xx.h>
 
 #define MAX_SPI_PORTS		12
-#define S3C64XX_SPI_QUIRK_POLL		(1 << 0)
 #define S3C64XX_SPI_QUIRK_CS_AUTO	(1 << 1)
 #define AUTOSUSPEND_TIMEOUT	2000
 
@@ -116,7 +115,7 @@
 #define S3C64XX_SPI_TRAILCNT		S3C64XX_SPI_MAX_TRAILCNT
 
 #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
-#define is_polling(x)	(x->port_conf->quirks & S3C64XX_SPI_QUIRK_POLL)
+#define is_polling(x)	(x->cntrlr_info->polling)
 
 #define RXBUSY    (1<<2)
 #define TXBUSY    (1<<3)
@@ -1067,6 +1066,11 @@ static struct s3c64xx_spi_info *s3c64xx_spi_parse_dt(struct device *dev)
 		sci->num_cs = temp;
 	}
 
+	if (!of_find_property(dev->of_node, "dmas", NULL)) {
+		dev_warn(dev, "cannot find DMA, changed to PIO mode\n");
+		sci->polling = 1;
+	}
+
 	sci->no_cs = of_property_read_bool(dev->of_node, "no-cs-readback");
 
 	return sci;
diff --git a/include/linux/platform_data/spi-s3c64xx.h b/include/linux/platform_data/spi-s3c64xx.h
index 5df1ace6d2c9..cb7b8ddc899f 100644
--- a/include/linux/platform_data/spi-s3c64xx.h
+++ b/include/linux/platform_data/spi-s3c64xx.h
@@ -35,6 +35,7 @@ struct s3c64xx_spi_info {
 	int src_clk_nr;
 	int num_cs;
 	bool no_cs;
+	bool polling;
 	int (*cfg_gpio)(void);
 };
 
-- 
2.17.1

