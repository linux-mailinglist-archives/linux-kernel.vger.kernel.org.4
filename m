Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875826D5882
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 08:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbjDDGOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 02:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbjDDGOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 02:14:19 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA70E1BDA
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 23:14:14 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230404061410epoutp04c6ea1d34911d6056a0d6e388c19aca5c~SpqfSwqIY1354113541epoutp04f
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 06:14:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230404061410epoutp04c6ea1d34911d6056a0d6e388c19aca5c~SpqfSwqIY1354113541epoutp04f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680588850;
        bh=tRJgGYYznByDL7mxJ7EIBQGu/rJwJAmPezNaOZCA0hQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nxHNvNS9DsaMtwCJyKqDlRcnR4mJgVGh7emH8yhv7T+CHN7Iem0UjKUFzBuku9Ndp
         A2PM6DoclJpQoEdihPQpVZeQpad5+nGoF+DGJmTJ896/haeNw1R7pWHDpijosxEPHA
         7OAnr4t/rtaxEHy6HkUc4e6Yn8XAOX9kYf8u76Vo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230404061410epcas2p418b9cdf6e8c3dd1f6f38677261c47e14~SpqetJYYQ2325623256epcas2p4U;
        Tue,  4 Apr 2023 06:14:10 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.97]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PrHXK53yvz4x9Pp; Tue,  4 Apr
        2023 06:14:09 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        15.26.35469.130CB246; Tue,  4 Apr 2023 15:14:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230404061409epcas2p36402f7a84406ba9d831dcff0ddd994e9~SpqeBcm4b0777207772epcas2p36;
        Tue,  4 Apr 2023 06:14:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230404061409epsmtrp2be2358e26a8209311c48482d7bd33ea3~SpqeAmGtQ2104021040epsmtrp2R;
        Tue,  4 Apr 2023 06:14:09 +0000 (GMT)
X-AuditID: b6c32a48-791ff70000008a8d-21-642bc03174b6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        90.CD.18071.130CB246; Tue,  4 Apr 2023 15:14:09 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230404061409epsmtip15e79fee3c5a715a623cbc8f82d9b8d4c~SpqdyxjUZ3067730677epsmtip1J;
        Tue,  4 Apr 2023 06:14:09 +0000 (GMT)
From:   Jaewon Kim <jaewon02.kim@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chanho Park <chanho61.park@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH 2/3] spi: dt-bindings: samsung: add samsung,spi-polling
 property
Date:   Tue,  4 Apr 2023 15:00:10 +0900
Message-Id: <20230404060011.108561-3-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230404060011.108561-1-jaewon02.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGKsWRmVeSWpSXmKPExsWy7bCmua7hAe0Ugxdn1S0ezNvGZrH4x3Mm
        i6kPn7BZXN6vbTH/yDlWix0NR1gt9r7eym6x6fE1VovLu+awWcw4v4/JovHjTXaL1r1H2B14
        PK4v+cTssWlVJ5vHnWt72Dw2L6n36NuyitHj8ya5ALaobJuM1MSU1CKF1Lzk/JTMvHRbJe/g
        eOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoBOVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnF
        JbZKqQUpOQXmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZHefOsBRcYavY1D2DqYHxIGsXIyeH
        hICJxJ9lX5i6GLk4hAR2MEp8+biEEcL5xCjRfncZK4TzjVHi8/ljjDAt55d8hKrayyhx+e4z
        KOcjo8SUCT9YQKrYBLQlvq9fDNYuInCUUWL7zrdgDjPIrIVH57B1MXJwCAsESdxdHAjSwCKg
        KrHi/HUmkDCvgJ3EjqX+ENvkJVZvOMAMYnMK2Et8bb/BAhH/yS7xeUE2hO0i8a+3AyouLPHq
        +BZ2CFtK4vO7vWwQdrZE+/Q/UE9XSFzcMBsqbiwx61k7I8haZgFNifW79EFMCQFliSO3wCYy
        C/BJdBz+yw4R5pXoaBOCaFSTuD/1HNQQGYlJR1YyQZR4SCw6kQUJkEmMEi+erWSdwCg3C2H+
        AkbGVYxiqQXFuempxUYFJvD4Ss7P3cQIToBaHjsYZ7/9oHeIkYmD8RCjBAezkgivapdWihBv
        SmJlVWpRfnxRaU5q8SFGU2DATWSWEk3OB6bgvJJ4QxNLAxMzM0NzI1MDcyVx3o8dyilCAumJ
        JanZqakFqUUwfUwcnFINTAfr+Pg19W6qFiysYG5LmeMsx+nMHbKfZ49cVcHZp2mHpiXYbWj8
        lzbV52fit2R+98kyt149VNMSuhDirjc58JzZBm+9pxveuC5yUD8mXHdjoqzM07JdspW3mYVN
        3RKTv7N6BHK+2MK6bt2iu+d5N7XpieUGbWmcb1URO8tt0sw/Bh9rvWstJzUEqvuW5rJpsNe5
        r5Xg3OzwNVRrZ6SGSfP5XN0tJtduM8hy7i/+b9mjzHxMQL9TOfyH8JfZzoems4qL797+6US1
        zcbaDQJvbl+7a7OVc9+zFdIbsh+z93VE83JYnLkeHLdF+NhClzMh+ScvfVTf+WoKv+nS5l28
        Jsu8fs5R3Hf01NW1qZfklViKMxINtZiLihMBc7ogDgkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMLMWRmVeSWpSXmKPExsWy7bCSnK7hAe0Ugynn+SwezNvGZrH4x3Mm
        i6kPn7BZXN6vbTH/yDlWix0NR1gt9r7eym6x6fE1VovLu+awWcw4v4/JovHjTXaL1r1H2B14
        PK4v+cTssWlVJ5vHnWt72Dw2L6n36NuyitHj8ya5ALYoLpuU1JzMstQifbsEroyOc2dYCq6w
        VWzqnsHUwHiQtYuRk0NCwETi/JKPjF2MXBxCArsZJX4t38IEkZCRWP6sjw3CFpa433IErEFI
        4D2jxISXYSA2m4C2xPf1i1lBmkUETjJK/D7TxATiMAv8YZSYeuQ/2CRhgQCJ62uWsYPYLAKq
        EivOXweKc3DwCthJ7FjqD7FAXmL1hgPMIDangL3E1/YbLBDL7CR+/9vBPIGRbwEjwypGydSC
        4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjOBw1dLcwbh91Qe9Q4xMHIyHGCU4mJVEeFW7tFKE
        eFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYPITMD35zLPk
        qp/12+Q9EUqa1geePjaffWLRnNJaBs0NFe8fMJ3QievaG2IYn8229wLzU/2UHV/XSV9W1dM+
        dSd7Qsv1rJ/tn7zeXm5rvPC8PlpzQubbTv1XE8JZlVsnXFvpmSXTVSWwPPXU/775pT6TJ4lu
        OvX2KePZm/sXsrs9Ubwtvfrvak5xrzsHUs65zO/x+Z3IK7j8gH0EA5swW5H8/xyBDbFJ6vU7
        L1o8mbWaf+7u5SmpCQvq5WZULZUqnnhmsv+nreuteJo+8hoKPtcW1+bZdKBi/zfxnpBHVU02
        55zZfhxScomY/vEr38kY4X0LIsz/N7Fy7fVZn8o/43nnpsJ9VxY/qzJf7xP2PEeJpTgj0VCL
        uag4EQAfy0aqxgIAAA==
X-CMS-MailID: 20230404061409epcas2p36402f7a84406ba9d831dcff0ddd994e9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230404061409epcas2p36402f7a84406ba9d831dcff0ddd994e9
References: <20230404060011.108561-1-jaewon02.kim@samsung.com>
        <CGME20230404061409epcas2p36402f7a84406ba9d831dcff0ddd994e9@epcas2p3.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds "samsung,spi-polling" property.
It is method to check data trans by polling when DMA is not used.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 Documentation/devicetree/bindings/spi/samsung,spi.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
index e0a465d70b0a..b4942fe160f2 100644
--- a/Documentation/devicetree/bindings/spi/samsung,spi.yaml
+++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
@@ -69,6 +69,12 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     default: 0
 
+  samsung,spi-polling:
+    description:
+      Polling SPI data without DMA transfer.
+    type: boolean
+    default: 0
+
   reg:
     maxItems: 1
 
-- 
2.17.1

