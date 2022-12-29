Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3489658B69
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 11:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbiL2KOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 05:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiL2KMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 05:12:18 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3A913F6A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:04:13 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221229100410epoutp03f3cd77ce5537d36b227152249c949d7d~1O35nSLnZ0063000630epoutp03P
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:04:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221229100410epoutp03f3cd77ce5537d36b227152249c949d7d~1O35nSLnZ0063000630epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672308250;
        bh=DtPVu8p7sdBj9CQdfQCk6CJxEwkdoavAEbDxm2QfmWk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=D5xpVKToAmVcbCosRYMcsCkWTfItKIIKU5k/q1QX1NDWWyimlbVLK4GVaEzqPfrQr
         4EiXFE+O3sW9aOwUm3nlmnAN715E8pBmKEip9QUNc+OwLAIYMxLU7qY1H27DD4Qkxf
         rthEc6b91MdvvoTRJ16BXqEBsGgYRZFRTnuNvDHE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20221229100410epcas2p4e739cf8aa0ff82af4fb8ff98f0eccf89~1O35HVMo73162931629epcas2p4J;
        Thu, 29 Dec 2022 10:04:10 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.100]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NjPB15yYKz4x9Pq; Thu, 29 Dec
        2022 10:04:09 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        53.55.61831.9166DA36; Thu, 29 Dec 2022 19:04:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20221229100409epcas2p123de28f73dfb4d7429d0e15e41bb13a7~1O34MDlHF1798217982epcas2p11;
        Thu, 29 Dec 2022 10:04:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221229100409epsmtrp21e560dddf159e642eb14e6249086df26~1O34LFmDl1682316823epsmtrp24;
        Thu, 29 Dec 2022 10:04:09 +0000 (GMT)
X-AuditID: b6c32a47-619ff7000000f187-8f-63ad6619e131
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        83.1F.02211.9166DA36; Thu, 29 Dec 2022 19:04:09 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221229100408epsmtip23a7a42850ad83e5c2e471e96b6b7a43f~1O338961l2157121571epsmtip2X;
        Thu, 29 Dec 2022 10:04:08 +0000 (GMT)
From:   Daehwan Jung <dh10.jung@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
        sc.suh@samsung.com, taehyun.cho@samsung.com,
        jh0801.jung@samsung.com, eomji.oh@samsung.com,
        Daehwan Jung <dh10.jung@samsung.com>
Subject: [RFC PATCH v2 0/3] support Samsung Exynos xHCI Controller
Date:   Thu, 29 Dec 2022 18:57:43 +0900
Message-Id: <1672307866-25839-1-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmua5k2tpkg2+TdS2OtT1ht5h/5Byr
        xZ0F05gsTi1fyGTRvHg9m8Xdhz9YLPpePGS2uLxrDpvFomWtzBbNm6awWrTuPcJu0XX3BqPF
        pIOiFqsWHGB34PNYvOclk8emVZ1sHneu7WHz2D93DbtH35ZVjB5b9n9m9Pi8SS6APSrbJiM1
        MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoZCWFssScUqBQ
        QGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgXmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsatno3M
        Beu4Khq7J7I0ML5i72Lk5JAQMJF4t34XkM3FISSwg1HiVet3RgjnE6PEjtPHWSGcb4wSq3ZO
        Z4Vped/QwQSR2Mso8WfpFCaQhJDAD0aJrmWmXYwcHGwCWhLfF4JNEhHoYpLYducrC4jDLHCE
        SWLjjFOMIEXCAk4Sd076gvSyCKhK/Nq+mw3E5hVwlXj/6BkjxDI5iZvnOplBeiUEvrJLLO/b
        xgSRcJH4eOcBVJGwxKvjW6AekpL4/G4vG4SdLXH9WzcLhF0hsWIvjG0sMetZO9gNzAKaEut3
        6YOYEgLKEkdugVUwC/BJdBz+yw4R5pXoaBOCaFSWmH55AjQYJCUOvj7HDGF7SMy49p8VEgqx
        EpMX9LNPYJSdhTB/ASPjKkax1ILi3PTUYqMCY3gcJefnbmIEJ0It9x2MM95+0DvEyMTBeIhR
        goNZSYRX4+zqZCHelMTKqtSi/Pii0pzU4kOMpsDgmsgsJZqcD0zFeSXxhiaWBiZmZobmRqYG
        5krivEFb5ycLCaQnlqRmp6YWpBbB9DFxcEo1MFXJxns/mvqf84umzgOpwqa73tOXbAo2iJ0Q
        1eSbpjv/b5Gk/dPNBbXTz/MtK1bkWxXraDBla2/y74NxK6SUUleLdO155fOzs+rs08f/blXn
        sPFobk09coj/4k8TpWfhKVNVvn92vbjmjkwTS++SRZe+8l6u7+n5/uJC27eXq34UdlXJOPp5
        nyk8YfJopXh89pdjaUoVs9bE8O31Ot6tObfR/+DE8oPnQrfXfajp/xqsLujw3zzYYr2MfmC6
        fP8XHv0ykQfZBfMT6g5ncTnn1Qvwfeu61RTrq3zBOraRedVDRgPhWdvX8f/0vbTksAd7p7dV
        lmxW9+LF045L1jVkty2xKHC+v2UNgyiH0MkbSizFGYmGWsxFxYkAP6kcAA0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsWy7bCSvK5k2tpkg0XbWSyOtT1ht5h/5Byr
        xZ0F05gsTi1fyGTRvHg9m8Xdhz9YLPpePGS2uLxrDpvFomWtzBbNm6awWrTuPcJu0XX3BqPF
        pIOiFqsWHGB34PNYvOclk8emVZ1sHneu7WHz2D93DbtH35ZVjB5b9n9m9Pi8SS6APYrLJiU1
        J7MstUjfLoEr41bPRuaCdVwVjd0TWRoYX7F3MXJySAiYSLxv6GDqYuTiEBLYzSix/s4FFoiE
        pMTSuTegioQl7rccYYUo+sYocbK5gbmLkYODTUBL4vtCRpC4iEAPk8TCKVvZQBxmgVNMEreO
        v2ICKRIWcJK4c9IXZBCLgKrEr+272UBsXgFXifePnjFCLJCTuHmuk3kCI88CRoZVjJKpBcW5
        6bnFhgWGeanlesWJucWleel6yfm5mxjB4amluYNx+6oPeocYmTgYDzFKcDArifBqnF2dLMSb
        klhZlVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAPT+czt9Zblb0UY
        foe/uhNh1ny4w+jXpZXT5M0nNVrefbD8UcQWq0UHzLaob/Q6z8B359bb51dWvvq5y41NI068
        KU7b/5KgiJUcz8yPH6efnSgk7e/cseLr5MPr8wUvKScdEJwcm7TrWYP2NV6vurK9lyIcndgO
        Jz4xsJgQ1niieCLXblZeMYlKbufZqk1fGCyeXfATiZ62bYED89vz66672O7LX/ai8H5e27kJ
        O1f8adM3CevcPmct08vEPxMZJRQCj9x/FPNRK+LLyR8ucd0CXqv4e3YpBtqGxVS732cM3SPS
        3vFo/u5bj1dudfnWoLgpe+MXS/G8r9uX+6n+FfiVePv38a1r/qfst7+9dMdVLSWW4oxEQy3m
        ouJEAMhm1wS+AgAA
X-CMS-MailID: 20221229100409epcas2p123de28f73dfb4d7429d0e15e41bb13a7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221229100409epcas2p123de28f73dfb4d7429d0e15e41bb13a7
References: <CGME20221229100409epcas2p123de28f73dfb4d7429d0e15e41bb13a7@epcas2p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is to support xHCI Controller on Samsung Exynos SOCs.
Thanks for all reviews on v1 and have tried to modify it well.
I again added "RFC" because I haven't solved below problem when checking dt bindings.

usb@4a000000: #size-cells:0:0: 0 was expected
Documentation/devicetree/bindings/usb/snps,dwc3.yaml

Changes in v2 :
- Rename subject of cover letter
    ([RFC,v1,0/2] add xhci-exynos to support Samsung Exynos SOC)
- Add Exynos compatible in xhci platform driver instead making new platform driver.
- Make xhci platform driver as child of dwc3 with DT schema.
- Override roothub ops for xhci platform driver.

Daehwan Jung (3):
  usb: support Samsung Exynos xHCI Controller
  dt-bindings: usb: generic-xhci: add Samsung Exynos compatible
  dt-bindings: usb: snps,dwc3: add generic-xhci as child

 .../devicetree/bindings/usb/generic-xhci.yaml |  2 +
 .../devicetree/bindings/usb/snps,dwc3.yaml    | 29 +++++++++
 drivers/usb/dwc3/drd.c                        |  7 +++
 drivers/usb/dwc3/host.c                       | 33 +++++++++-
 drivers/usb/host/xhci-plat.c                  | 60 ++++++++++++++++++-
 drivers/usb/host/xhci.c                       |  4 ++
 drivers/usb/host/xhci.h                       |  5 ++
 7 files changed, 137 insertions(+), 3 deletions(-)

-- 
2.31.1

