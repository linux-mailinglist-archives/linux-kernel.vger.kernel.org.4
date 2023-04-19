Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCFB6E733B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 08:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjDSG2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 02:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjDSG2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 02:28:16 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C249F76AB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 23:27:58 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230419062756epoutp04601f12614328adae5dc51a85f3ec0abb~XQhyRi6XB1322213222epoutp04z
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 06:27:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230419062756epoutp04601f12614328adae5dc51a85f3ec0abb~XQhyRi6XB1322213222epoutp04z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681885676;
        bh=Zz2fXoPYH2Rn3Zva7blHYTNJEnyfvGkirJElZNBYSb4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=cgD9XolMXBpcltEkDUehQOgW95hGrQdBpftoAL4UUtuIPOhIo9JWbruCo/x5cmzvZ
         4xlSNUX7DflEXUASdZ5WQaFbAdHWpc7GoW7BL2GlTBWmK7LIaaEYrKzM1wWwvpkkKO
         yMGKusYs9MRV0NSM7LXrkyjBNU5RlZ/538Ikb+jc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230419062755epcas2p22790a323aac8b3409c357121bbd8d5b4~XQhx7kcrp0810808108epcas2p2w;
        Wed, 19 Apr 2023 06:27:55 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.91]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Q1W7H47Gkz4x9QC; Wed, 19 Apr
        2023 06:27:55 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        6D.89.09938.BE98F346; Wed, 19 Apr 2023 15:27:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230419062755epcas2p4c3c7c1e0d58e964f6e884f75ae120d91~XQhxHFb6Z2825128251epcas2p4O;
        Wed, 19 Apr 2023 06:27:55 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230419062755epsmtrp23e5beae0425cbd39d45e5c172491eff2~XQhxFuotX0106901069epsmtrp2P;
        Wed, 19 Apr 2023 06:27:55 +0000 (GMT)
X-AuditID: b6c32a47-ca5fd700000026d2-80-643f89eb3ca7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        90.71.08609.AE98F346; Wed, 19 Apr 2023 15:27:54 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230419062754epsmtip28c0708de49b9264767aff73757c29aa1~XQhw5KhSs0529605296epsmtip2T;
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
Subject: [PATCH v2 0/4] Improves polling mode of s3c64xx driver
Date:   Wed, 19 Apr 2023 15:06:35 +0900
Message-Id: <20230419060639.38853-1-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7bCmhe7rTvsUg5MT5C0ezNvGZrH4x3Mm
        i6kPn7BZXN6vbbGj4Qirxd7XW9ktNj2+xmpxedccNosZ5/cxWTR+vMnuwOVxfcknZo9NqzrZ
        PO5c28PmsXlJvUffllWMHp83yQWwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpa
        mCsp5CXmptoqufgE6Lpl5gAdpqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/Q
        K07MLS7NS9fLSy2xMjQwMDIFKkzIzth9/ARzQR9bxYIF19gaGG+xdDFyckgImEj83vKWtYuR
        i0NIYAejxILH01kgnE+MEt/PnWOCcD4zSpz4+YoVpmXT3olQLbsYJR4d2MoM4XxklDi28zFY
        FZuAtsT39YvBqkQEFjNK7P37BayKWeAGo0T3m81g64UF7CW+TtvBDmKzCKhKLPi9HSzOK2Ar
        sej4Zah98hKrNxwAa5YQOMYucW0RzCEuEu2XzrJD2MISr45vgbKlJD6/28sGYWdLtE//A1Vf
        IXFxw2youLHErGftjF2MHEAXaUqs36UPYkoIKEscgYQMswCfRMfhv+wQYV6JjjYhiEY1iftT
        z0ENkZGYdGQlE0SJh8SrzVUgYSGBWIn1d/qZJjDKzkIYv4CRcRWjWGpBcW56arFRgTE8lpLz
        czcxghOblvsOxhlvP+gdYmTiYDzEKMHBrCTCe8bVKkWINyWxsiq1KD++qDQntfgQoykwtCYy
        S4km5wNTa15JvKGJpYGJmZmhuZGpgbmSOK+07clkIYH0xJLU7NTUgtQimD4mDk6pBiaVdSJ7
        gluu/lznM/mEnm+I1iaDKJNaWauAtSv4wriLPDU2b6l4eeJI94pfcxzNtW46Max6JFtxxtm1
        7XfWt6yiZZs43+j7nD2w6PjqQsn+N2LPl660qS6+day8aH3UmfJFb68GWjjbCuYGStwS/BBw
        nmmah8hP98TDgmElMWdiw4WmX+Vxu5/0Z++9NZ0WnIEqAbb3xHWSj11/I/hhj8UFLhdJkaNx
        OZtVG3jnWfR8Mdu5VvHeG71Dl4J+xNwQ4q37mvJGR82jxszMXGDNq5mq/PM5vh1pSjnrKrKi
        vZX9+lzGSUndt8KM1BYH8qy5zHf8RMOdeYEpSvqbnuZWXbi3irdkb21V3uaWLlUOQSWW4oxE
        Qy3mouJEAI0rf6f1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprELMWRmVeSWpSXmKPExsWy7bCSvO6rTvsUg3OvrS0ezNvGZrH4x3Mm
        i6kPn7BZXN6vbbGj4Qirxd7XW9ktNj2+xmpxedccNosZ5/cxWTR+vMnuwOVxfcknZo9NqzrZ
        PO5c28PmsXlJvUffllWMHp83yQWwRXHZpKTmZJalFunbJXBl7D5+grmgj61iwYJrbA2Mt1i6
        GDk5JARMJDbtncjaxcjFISSwg1Fi+63trBAJGYnlz/rYIGxhifstR6CK3jNKrHo/iRkkwSag
        LfF9/WKwBhGBpYwSN7ulQIqYBe4xSryc9I0JJCEsYC/xddoOdhCbRUBVYsHv7WCreQVsJRYd
        vwy1TV5i9YYDzBMYeRYwMqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAgONi2tHYx7
        Vn3QO8TIxMF4iFGCg1lJhPeMq1WKEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tS
        s1NTC1KLYLJMHJxSDUxS7Z+fP+bIexUkdGzr5KpHQh2ZL/KP9aW/dl+i0us8bVJW+n/feRva
        oy5N2XmTtfrAFzGN1+rVcxcYrJ+aWDHV4l7D0/eRbBIPFA+59/3T6dx5L+pTkufEIzPOd77m
        PDbtBHf/HuXQppzgj8bGRm4cvIkbfOtj5WVVZLLerNVMrNB+nfBgh3H1B7+MrscyOcJh+n8L
        mlJOT5hltkH97V4Hlr0/2VsqebgV2Q++Nr27X0iyNFXYRrt74+Jw/o/F/RZrTm5y/elysum5
        152sjeUpJvbCIqffaG7vceV9f38uc+TXSb/jXgS8OpBuLSPzqkbJXvtukabkxxV/6x7/Ku/Q
        2Kfp8+H3Gwlv5mXJyUosxRmJhlrMRcWJANNi3FylAgAA
X-CMS-MailID: 20230419062755epcas2p4c3c7c1e0d58e964f6e884f75ae120d91
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230419062755epcas2p4c3c7c1e0d58e964f6e884f75ae120d91
References: <CGME20230419062755epcas2p4c3c7c1e0d58e964f6e884f75ae120d91@epcas2p4.samsung.com>
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

1.
s3cx64xx driver was supporting polling mode using quirk for SOC without DMA.
However, in order to use PIO mode as an optional rather than a quirk, when DMA
is not described, spi operates with pio mode rather than probe fail.

2.
Fixed the problem of high CPU usage in PIO mode.

3. 
If the transfer data size is larger than 32-bit, IRQ base PIO mode used.


Jaewon Kim (4):
  spi: s3c64xx: changed to PIO mode if there is no DMA
  spi: s3c64xx: add cpu_relax in polling loop
  spi: s3c64xx: add sleep during transfer
  spi: s3c64xx: support interrupt based pio mode

 drivers/spi/spi-s3c64xx.c                 | 85 ++++++++++++++++++++---
 include/linux/platform_data/spi-s3c64xx.h |  1 +
 2 files changed, 76 insertions(+), 10 deletions(-)

-- 
2.17.1

