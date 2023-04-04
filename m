Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC1A6D587D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 08:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjDDGOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 02:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbjDDGOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 02:14:17 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA80A1FE1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 23:14:14 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230404061411epoutp0239cd9028c720bb87c5d48d5145e199a6~SpqfwgNF12900629006epoutp02i
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 06:14:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230404061411epoutp0239cd9028c720bb87c5d48d5145e199a6~SpqfwgNF12900629006epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680588851;
        bh=NDz3sevc3ifgOeukaV3v9gsrq3saq6INBsKFJVJQAXo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=hBLmjPB3OLhfxmHZDImLmBZTZ7Xd0Vxemgda8/5KFrk6rVlJMQskn4Z4B3NUU5z9w
         eWkKkxKVmHzFQsGk4qQHI/Obdo5lqp22/Ddq8f+Bhd3NfYNvj9emHETL5QjUuOvFNq
         qqRPlQus71yo6IY3N+YG7+wa8gY6oz/WOgty+tFw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230404061410epcas2p4c088f4bbdc5fb33fc184bd3e97ae0021~SpqewrRNA2302623026epcas2p4Y;
        Tue,  4 Apr 2023 06:14:10 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.102]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PrHXK4DGPz4x9QC; Tue,  4 Apr
        2023 06:14:09 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.90.27926.130CB246; Tue,  4 Apr 2023 15:14:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230404061409epcas2p2e97fff5459b405db0d5a206e2ad38f82~Spqd2cCCD3117631176epcas2p24;
        Tue,  4 Apr 2023 06:14:09 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230404061409epsmtrp12554d4ca421464b977dc4b9d337a47e5~Spqd1mJ0r0601006010epsmtrp1J;
        Tue,  4 Apr 2023 06:14:09 +0000 (GMT)
X-AuditID: b6c32a46-a4bff70000006d16-0f-642bc0312f8f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        59.8A.31821.030CB246; Tue,  4 Apr 2023 15:14:09 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230404061408epsmtip1308de21da364f1ac17fa5df75212d9ca~Spqdn_adG3068830688epsmtip1J;
        Tue,  4 Apr 2023 06:14:08 +0000 (GMT)
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
Subject: [PATCH 0/3] spi: s3c64xx: improve SPI polling mode
Date:   Tue,  4 Apr 2023 15:00:08 +0900
Message-Id: <20230404060011.108561-1-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsWy7bCmqa7hAe0UgwkTpC0ezNvGZrH4x3Mm
        i6kPn7BZXN6vbTH/yDlWix0NR1gt9r7eym6x6fE1VovLu+awWcw4v4/JovHjTXaL1r1H2B14
        PK4v+cTssWlVJ5vHnWt72Dw2L6n36NuyitHj8ya5ALaobJuM1MSU1CKF1Lzk/JTMvHRbJe/g
        eOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoBOVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnF
        JbZKqQUpOQXmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZC7ZOZC14yF7xd91L5gbGmWxdjJwc
        EgImEoe2PGEHsYUEdjBKzHyr2cXIBWR/YpRonvaYDcL5zCjx4ckUFpiOP7cXsUF07GKUmPDQ
        FqLoI6PEtD1/wIrYBLQlvq9fzAqSEBE4yiixfedbMIdZ4BujxMKjc8DahQWsJa71tTGB2CwC
        qhLTe3+ygti8AnYSN3esYIVYJy+xesMBZpBmCYFb7BJvT2+FutxFYvKnbewQtrDEq+NboGwp
        iZf9bVB2tkT79D9QgyokLm6YDdVrLDHrWTtjFyMH0EWaEut36YOYEgLKEkdugT3ALMAn0XH4
        LztEmFeio00IolFN4v7Uc1BDZCQmHVnJBGF7SHz++JEREiixEh29vxgnMMrOQpi/gJFxFaNY
        akFxbnpqsVGBETySkvNzNzGCU52W2w7GKW8/6B1iZOJgPMQowcGsJMKr2qWVIsSbklhZlVqU
        H19UmpNafIjRFBhcE5mlRJPzgck2ryTe0MTSwMTMzNDcyNTAXEmcV9r2ZLKQQHpiSWp2ampB
        ahFMHxMHp1QDU/cJg+MRG2+d+TDjcfPtBLHrC6MtBHU3Nf1QDpnzIX/vqRbJPykfk57un5/S
        2bjwFEfFl9W/N55Lyb607fPmPe0SgnW/9ymoZ5g3H6upX2kbpFVtEHNgpqWz6fVbX/SkBcK9
        jJz+FTWvsYvTNF0rlrnhd+gj0w7XsP6g2QsrW05EyRoIbxf+HJu/sDBnrbjXz/siia8+f4uZ
        q3o6t/Go5bIfUz5kc67aWtSpN0/C9PhVmzzGNetW7NsYXdN9XlC/XGX59T7742cS5vjufWFx
        5fErzg/GcvOez5K4Oe3ExiPb0vMDdPkc8w4ZLb13fGJQ1vYlPOUeRU/Sr2/z+mCslhQS/WCr
        rhmfyJ57qZfrlJRYijMSDbWYi4oTAQ6BpAH+AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLLMWRmVeSWpSXmKPExsWy7bCSnK7hAe0Ug2PnmC0ezNvGZrH4x3Mm
        i6kPn7BZXN6vbTH/yDlWix0NR1gt9r7eym6x6fE1VovLu+awWcw4v4/JovHjTXaL1r1H2B14
        PK4v+cTssWlVJ5vHnWt72Dw2L6n36NuyitHj8ya5ALYoLpuU1JzMstQifbsErowFWyeyFjxk
        r/i77iVzA+NMti5GTg4JAROJP7cXAdlcHEICOxglutc2skAkZCSWP+uDKhKWuN9yhBWi6D2j
        xI4DZ8CK2AS0Jb6vXwyWEBE4ySjx+0wTE4jDLPCHUWLqkf9MIFXCAtYS1/rawGwWAVWJ6b0/
        WUFsXgE7iZs7VrBCrJCXWL3hAPMERp4FjAyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNz
        NzGCQ1BLawfjnlUf9A4xMnEwHmKU4GBWEuFV7dJKEeJNSaysSi3Kjy8qzUktPsQozcGiJM57
        oetkvJBAemJJanZqakFqEUyWiYNTqoEpvmjbssqy7CUby9faPhT2/lSyaRH32mzN2ZUrcsIU
        M72uNhm9dWb0eGzp/PZC+Y7VYXFzKo8wzXFffXjehgQt708z5D9xZyzY1Dnjex1vYOtbmexD
        two7DiYcOrRAd8WJ7GqJNTN1CpdWHv2Rc2VxT/IENcNpSw5rPnQJf7b4qRXTudkp+55Zn6xe
        +Oro0UVHDQ8949Tz3moR+umL7Wfl7oAC46jvwVHuP7+fujXtf8mj/NKVhq83/CvhZVl+K2vy
        mv5tu6L3Z+7f9GCF/78ZbJzXjhu8jfmw6efykMhVQlxrnvUa/DE99j2kcIL5rkvXDX4c/lSZ
        ue7c2YdyU4qjPARfffpRXab0Saeg7cMZzz1KLMUZiYZazEXFiQCsrSkOsAIAAA==
X-CMS-MailID: 20230404061409epcas2p2e97fff5459b405db0d5a206e2ad38f82
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230404061409epcas2p2e97fff5459b405db0d5a206e2ad38f82
References: <CGME20230404061409epcas2p2e97fff5459b405db0d5a206e2ad38f82@epcas2p2.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset improves polling mode of s3c64xx driver.

s3cx64xx driver was supporing polling mode using quirk for SOC without DMA.
However there are situations in which spi polling mode should be
supported in some environments. To solve this situation, polling mode
can be used selectively by using device-tree as well as quirk.

When using the existing polling mode, the CPU utilization goes up to
100% becuase it checks register too frequently. In order to improve this
problem, IRQ is used by using the FIFO Trigger Level function.

Jaewon Kim (3):
  spi: s3c64xx: support spi polling mode using devicetree
  spi: dt-bindings: samsung: add samsung,spi-polling property
  spi: s3c64xx: support interrupt based pio mode

 .../devicetree/bindings/spi/samsung,spi.yaml  |  6 ++
 drivers/spi/spi-s3c64xx.c                     | 77 ++++++++++++++++---
 include/linux/platform_data/spi-s3c64xx.h     |  1 +
 3 files changed, 72 insertions(+), 12 deletions(-)

-- 
2.17.1

