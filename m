Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D06774E900
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjGKIZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjGKIZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:25:18 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A975C2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 01:25:13 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230711082510epoutp035a91d963431e84251e1a805a4f3ebbb6~wwq1hyRLw1501115011epoutp03q
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:25:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230711082510epoutp035a91d963431e84251e1a805a4f3ebbb6~wwq1hyRLw1501115011epoutp03q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689063910;
        bh=+x3YgvcySm4e4OWhzCgiX503lxS9Tal1A2wn7/lnMtM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=AioBY9DPhNboTY4DImvuidDheOTLB0gsQSIvEecrpeQknmETriEcvh17yq5BAesKI
         DPVZ05r5de0gg2NR88uIYgJv9wq7A6xBkC03nShhyZFd+NcbJ3y56RNnEjAxTCC1i/
         oHII1++nONYMxmwNd0T2o1VlJp0T2jsartOsC4ns=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230711082509epcas2p2089503c1f234b156a89711d21ecf4415~wwq01jGLE0267302673epcas2p2l;
        Tue, 11 Jul 2023 08:25:09 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.92]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4R0YpD4Y5Qz4x9Ps; Tue, 11 Jul
        2023 08:25:08 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        A5.35.32393.4E11DA46; Tue, 11 Jul 2023 17:25:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230711082508epcas2p3088d488035e7e2910bf087d640e9c268~wwqznTvSd0591905919epcas2p3v;
        Tue, 11 Jul 2023 08:25:08 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230711082508epsmtrp15a884d0c37a11b08c3c3af853551c67e~wwqzmUZtC0611406114epsmtrp1L;
        Tue, 11 Jul 2023 08:25:08 +0000 (GMT)
X-AuditID: b6c32a48-87fff70000007e89-35-64ad11e4878e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        9F.4D.64355.3E11DA46; Tue, 11 Jul 2023 17:25:07 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230711082507epsmtip1ec149368577a49a67b0b31a5bb4ab76c~wwqzWUhre2887328873epsmtip1e;
        Tue, 11 Jul 2023 08:25:07 +0000 (GMT)
From:   Jaewon Kim <jaewon02.kim@samsung.com>
To:     Andi Shyti <andi.shyti@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH] spi: s3c64xx: clear loopback bit after loopback test
Date:   Tue, 11 Jul 2023 17:20:20 +0900
Message-Id: <20230711082020.138165-1-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsWy7bCmme4TwbUpBo8nK1k8mLeNzeL+1w5G
        i6kPn7BZXN6vbbGj4Qirxd7XW9ktNj2+xmpxedccNosZ5/cxWTR+vMnuwOWxaVUnm8eda3vY
        PDYvqffo27KK0ePzJrkA1qhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE
        3FRbJRefAF23zBygm5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BeYFesWJucWl
        eel6eaklVoYGBkamQIUJ2Rkft8oU3GermLDwO2MD4y3WLkZODgkBE4l1M7YwdTFycQgJ7GCU
        +HKrmxXC+cQosfHaZhY459OuF0wwLfMnbIVK7GSUmNr0hhnC+cgo8Xbjf2aQKjYBbYnv6xeD
        zRIRWMEose3CB7AWZoEbjBLdb0AGc3IIC7hKPJzdDzaXRUBV4u66XqBuDg5eATuJl9erIdbJ
        S6zecIAZwt7FLrH0qi+E7SLRtmofG4QtLPHq+BZ2CFtK4mV/G5SdLdE+/Q/UpxUSFzfMhqo3
        lpj1rJ0RZBWzgKbE+l36IKaEgLLEkVtghzEL8El0HP7LDhHmlehoE4JoVJO4P/Uc1BAZiUlH
        VkLDxEOia2ETWFxIIFZi5aEzjBMYZWchzF/AyLiKUSy1oDg3PbXYqMAEHkfJ+bmbGMGpTMtj
        B+Pstx/0DjEycTAeYpTgYFYS4S04uCpFiDclsbIqtSg/vqg0J7X4EKMpMLAmMkuJJucDk2le
        SbyhiaWBiZmZobmRqYG5kjjvvda5KUIC6YklqdmpqQWpRTB9TBycUg1MFl4nZl/NW/i57Ofk
        63LlMjkv/Pa8+rjUrPp3VMi1H3VqK1vsXz4r95kob177Ma5FJn/xy6xrKgz5Qnppy551a3TJ
        TiloXmrXaruO2f5H2HP1vPKrs9pFZ+eIWah3eyd8dvL9kefFmKjwbNef9v0nY3YoJb6sesZj
        y8p8J/Thm1V6TMncT1vaVf+u3S395voC54Sk6ZrLHRIOhMS81b5u/tjPm7XpuZqC2mVfrumt
        9cKi9fYbI52FJK/cjPW+9aatzap275zjRUc620S27ldPVlSblGN5pLR090FL5w1X1uXwvnCz
        On+z2tHU582NhXO/ma49aODGlHjg6ssNKstPPXnjHZzfxdIsc3PW11AlluKMREMt5qLiRACH
        eIi77gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnluLIzCtJLcpLzFFi42LZdlhJTveJ4NoUgy4jiwfztrFZ3P/awWgx
        9eETNovL+7UtdjQcYbXY+3oru8Wmx9dYLS7vmsNmMeP8PiaLxo832R24PDat6mTzuHNtD5vH
        5iX1Hn1bVjF6fN4kF8AaxWWTkpqTWZZapG+XwJXxcatMwX22igkLvzM2MN5i7WLk5JAQMJGY
        P2ErSxcjF4eQwHZGiU27jkAlZCSWP+tjg7CFJe63gMRBit4zStxqfsEMkmAT0Jb4vn4xWEJE
        YBVQ9/IzjCAOs8A9RomXk74xgVQJC7hKPJzdD2azCKhK3F3XC9TNwcErYCfx8no1xAZ5idUb
        DjBPYORZwMiwilE0taA4Nz03ucBQrzgxt7g0L10vOT93EyM4rLSCdjAuW/9X7xAjEwfjIUYJ
        DmYlEd6Cg6tShHhTEiurUovy44tKc1KLDzFKc7AoifMq53SmCAmkJ5akZqemFqQWwWSZODil
        Gpg6nnP31VhtNxeO+6Nzr2WRkz77l+wZfVOzm12+nc+998V6U+X39uyMYw+2HRT+oVufus7l
        17vEjbt2HHiV9mmfx0w2qQubJRwTXYLTpq3wkPrKy3bwpcfOyo+PzFZHub1oDOC5fprBd9kD
        nol2P0/WtjDX/OkM098+c5tAQ/l+49MLnk/m5bBNDI6zzH0ovevc94bEiati67LN7SJebN9h
        mXnI9R3LyRKBqp36db0h2Ud/OVq8O8VvtPLLq6rcmpYTfwT7Jnfb6d7ynP1L+8Xj4KDwRTsP
        P7BqSzy1v4nlV+a902/7/nw3WDL9jZHDtDO/VUx3LnyZGR6o2vDq/2PxaSFVdZbdMipOgisC
        WKyUWIozEg21mIuKEwFt2bCemgIAAA==
X-CMS-MailID: 20230711082508epcas2p3088d488035e7e2910bf087d640e9c268
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230711082508epcas2p3088d488035e7e2910bf087d640e9c268
References: <CGME20230711082508epcas2p3088d488035e7e2910bf087d640e9c268@epcas2p3.samsung.com>
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

When SPI loopback transfer is performed, S3C64XX_SPI_MODE_SELF_LOOPBACK
bit still remained. It works as loopback even if the next transfer is
not spi loopback mode.
If not SPI_LOOP, needs to clear S3C64XX_SPI_MODE_SELF_LOOPBACK bit.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index fd55697144cc..b6c2659a66ca 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -684,6 +684,8 @@ static int s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 
 	if ((sdd->cur_mode & SPI_LOOP) && sdd->port_conf->has_loopback)
 		val |= S3C64XX_SPI_MODE_SELF_LOOPBACK;
+	else
+		val &= ~S3C64XX_SPI_MODE_SELF_LOOPBACK;
 
 	writel(val, regs + S3C64XX_SPI_MODE_CFG);
 
-- 
2.17.1

