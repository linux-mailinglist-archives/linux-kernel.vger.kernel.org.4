Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEE2617F09
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbiKCOND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiKCOMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:12:49 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A87E12D25
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 07:12:42 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221103141240euoutp016c58532301181c0cd8e61d403f924254~kGI4qPuyJ2369623696euoutp01b
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 14:12:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221103141240euoutp016c58532301181c0cd8e61d403f924254~kGI4qPuyJ2369623696euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667484760;
        bh=ikLgX5+rC6etpCFPJGJZsqRLbkT4hXzogxYFAeG3eE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GxIlWX3o2pwr3Um5Mpb7mSuABrl94qylelYbiTvo/yfExwvIinGkADnzyiTW+x5qY
         5UJ3VeLLlQKuYyGR1c6B2Lpmn0gH6+jh3DNAokUp6YjWww62ADPgxJY1PEduqJNhTz
         HWB6wJ9QERmi9pONtTfa9Hn1ttevRoWhhWU8tm1E=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221103141240eucas1p1214a82150536870f5d1392a3e326cc3b~kGI4O4Q_X1074310743eucas1p1X;
        Thu,  3 Nov 2022 14:12:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 9C.EB.29727.85CC3636; Thu,  3
        Nov 2022 14:12:40 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20221103141239eucas1p167f44609369010a20293d5123214426d~kGI3lHwri2591525915eucas1p1L;
        Thu,  3 Nov 2022 14:12:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221103141239eusmtrp24f5d9beb1b97a2911cbd2c4e6abc37cc~kGI3hJchK2293622936eusmtrp2c;
        Thu,  3 Nov 2022 14:12:39 +0000 (GMT)
X-AuditID: cbfec7f2-205ff7000001741f-f8-6363cc585153
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 11.ED.10862.75CC3636; Thu,  3
        Nov 2022 14:12:39 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221103141238eusmtip2b65d8b299762ab3b9d2cc75c389d6a6d~kGI2387YI1617316173eusmtip2T;
        Thu,  3 Nov 2022 14:12:38 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Stefan Agner <stefan@agner.ch>,
        Johan Hovold <johan@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH 2/2] of: export of_device_add()
Date:   Thu,  3 Nov 2022 15:12:33 +0100
Message-Id: <20221103141233.20179-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221103141233.20179-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7djP87oRZ5KTDXov8VnMP3KO1WLmm/9s
        Fs2L17NZNN3oYbXY+3oru8XlXXPYLGac38dksWhZK7PF2iN32S1a9x5ht9i8rp3dYtWCA+wO
        PB6Lv99j9tg56y67x6ZVnWwed67tYfPYP3cNu0ffllWMHlv2f2b0+LxJLoAjissmJTUnsyy1
        SN8ugStjzfb/zAXHWCt235zE1MB4naWLkZNDQsBE4s2DNYxdjFwcQgIrGCWuXZ0L5XxhlHj/
        vYMFwvnMKHFhwxFmmJZLMx9CJZYzSsx+9YQdruXqsr3sIFVsAoYSXW+72EBsEYEaiZ0XN7OB
        FDELXGGSmDOpnwkkISygL/H+9F9GEJtFQFVi78wtYDavgK3Evj1LodbJS6zecADI5uDgFLCT
        eNvNBDJHQuAKh0TTghdQNS4S676/hPpIWOLV8S3sELaMxP+d86Ea2hklFvy+D+VMYJRoeH6L
        EaLKWuLOuV9sIBuYBTQl1u/Shwg7Spz9C7KNA8jmk7jxVhAkzAxkTto2nRkizCvR0SYEUa0m
        Mev4Ori1By9cgjrNQ2L+gilskACayCjRfeYtywRG+VkIyxYwMq5iFE8tLc5NTy02zEst1ytO
        zC0uzUvXS87P3cQITDyn/x3/tINx7quPeocYmTgYDzFKcDArifB+2pacLMSbklhZlVqUH19U
        mpNafIhRmoNFSZyXbYZWspBAemJJanZqakFqEUyWiYNTqoGp8IHyU0tHh8QLch1hGu8dvuZy
        NGxVv31HV3j7q6Jq7xPfC8+LsGp/ZTlcJhLjE743aYsXW59Bmmvashu7eo+oZC1dMDnA7M0D
        poNioYrHjW+Yt+ffidr74JHtlVa7Ip0Ned+/NU122bvu8G/Rc+svXfmSmKSYevnTydtKse8f
        e2xlLrX8x1NXv8I//I4p35HmU0/DJ3BwPfM3/hf740DY6m035wva+m099J+t7uJsGdFzvtM8
        Xh2MXO6poSr5Lie8brnO+7tz70/blbh6Mf9jTbVHsYvdvklW7N4b0TI7NPrxInNRlT8sL2I+
        ZOyTehzwNDCLI3kPl0T959rlEYVuay76Wux4ub0qr0IyvcJViaU4I9FQi7moOBEAWvI9yKsD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsVy+t/xe7rhZ5KTDc60qlnMP3KO1WLmm/9s
        Fs2L17NZNN3oYbXY+3oru8XlXXPYLGac38dksWhZK7PF2iN32S1a9x5ht9i8rp3dYtWCA+wO
        PB6Lv99j9tg56y67x6ZVnWwed67tYfPYP3cNu0ffllWMHlv2f2b0+LxJLoAjSs+mKL+0JFUh
        I7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9jzfb/zAXHWCt235zE
        1MB4naWLkZNDQsBE4tLMh2C2kMBSRom+lRwQcRmJk9MaWCFsYYk/17rYuhi5gGo+MUocn3qC
        DSTBJmAo0fUWIiEi0MAosWPyXyYQh1ngBpPEhLl9YFXCAvoS70//ZQSxWQRUJfbO3AJm8wrY
        Suzbs5QZYoW8xOoNB4BsDg5OATuJt91MIKYQUMm1ndETGPkWMDKsYhRJLS3OTc8tNtIrTswt
        Ls1L10vOz93ECIyBbcd+btnBuPLVR71DjEwcjIcYJTiYlUR4P21LThbiTUmsrEotyo8vKs1J
        LT7EaAp0xURmKdHkfGAU5pXEG5oZmBqamFkamFqaGSuJ83oWdCQKCaQnlqRmp6YWpBbB9DFx
        cEo1MC3U/WTBbOP/Skf2i1s5y9ub17Jkt34693QVZ0PiUen93r+LTRuv5z1mit/ix3h2CsPD
        9weN7wjPmJA16a7z5K/cDz/sbNplv0idTa1+br6hbt4ZAc6w5yzfa3sW+0q2x8/RqvD0dtbg
        9Xu2qu/2dr/G7jw9f/uQJU7nC9eG/dBKuh3WxMnqfNybxzTupsMy4SeRcQv186e1PLlv7DZL
        W+2XUoOglWOcnsF14UUv7BI3LDj/7ZpF+KrMD3zdC+VVUua9n+NhWf8iIZJn0+QFClcC7t0X
        vVxQuDzsE/uOGyvjJxtcPh/qxtZ+d8+MJ9881rB+uOc3ie/K0da8p9tXLjXbvfCU7cXHNyZt
        /Bn6dKYSS3FGoqEWc1FxIgANDhUICgMAAA==
X-CMS-MailID: 20221103141239eucas1p167f44609369010a20293d5123214426d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20221103141239eucas1p167f44609369010a20293d5123214426d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221103141239eucas1p167f44609369010a20293d5123214426d
References: <20221103141233.20179-1-m.szyprowski@samsung.com>
        <CGME20221103141239eucas1p167f44609369010a20293d5123214426d@eucas1p1.samsung.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export of_device_add() function to let DWC3 driver (Exynos variant) to
instantiate DWC3 core device from the respective child OF-node with a
custom, addtional properties added.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/of/device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 8cefe5a7d04e..bc60c9b6863c 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -52,6 +52,7 @@ int of_device_add(struct platform_device *ofdev)
 
 	return device_add(&ofdev->dev);
 }
+EXPORT_SYMBOL(of_device_add);
 
 static void
 of_dma_set_restricted_buffer(struct device *dev, struct device_node *np)
-- 
2.17.1

