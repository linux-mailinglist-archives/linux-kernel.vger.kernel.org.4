Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0726D6291
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbjDDNRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbjDDNRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:17:44 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403DE3A8C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 06:17:34 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230404131730epoutp0304aa94619a15f73b56295669d640073f~SvcG-kfzx1805118051epoutp03I
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 13:17:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230404131730epoutp0304aa94619a15f73b56295669d640073f~SvcG-kfzx1805118051epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680614250;
        bh=8V/cf4AB6W2TOPp2IXcjoz3iFGfWOZyI4pCZ9f1vA0Q=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=M/qU3qQxQPH2EAALndUqpHT5wTeV6ytXGDVb8wgTt71qzsUz+2sBnjLl49hr/uacW
         vUU0Iq+4ga2noiz/3zxFXMpK67bI11BOmEhbpux2sWE0nVcdy3BDMCdj+FyvMkjKDl
         5ufzNbbQngkDzJFCJzizeU230ErmpfBtQG4PKYAQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230404131730epcas2p198c8d081fc648ec965d7a7d672b46b8c~SvcGjmoK00569605696epcas2p1v;
        Tue,  4 Apr 2023 13:17:30 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.101]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PrSwp06GBz4x9Pr; Tue,  4 Apr
        2023 13:17:30 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.0E.35469.9632C246; Tue,  4 Apr 2023 22:17:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230404131728epcas2p251e43101498d4ad7591a39ce710c60f7~SvcFMAHM91760917609epcas2p2_;
        Tue,  4 Apr 2023 13:17:28 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230404131728epsmtrp2d305f0f20011666aae5c5dc91d93df87~SvcFLQ5ge1061310613epsmtrp2P;
        Tue,  4 Apr 2023 13:17:28 +0000 (GMT)
X-AuditID: b6c32a48-9e7f970000008a8d-a7-642c23694ea4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        87.A1.31821.8632C246; Tue,  4 Apr 2023 22:17:28 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230404131728epsmtip2a5fa1f8661d6ab0f166df5b309dab779~SvcE59RG90687606876epsmtip2m;
        Tue,  4 Apr 2023 13:17:28 +0000 (GMT)
Message-ID: <e01900f0-e5ac-d2f9-9e1b-c5cc35d21713@samsung.com>
Date:   Tue, 4 Apr 2023 22:15:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.9.0
Subject: Re: [PATCH 3/3] spi: s3c64xx: support interrupt based pio mode
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chanho Park <chanho61.park@samsung.com>
From:   Jaewon Kim <jaewon02.kim@samsung.com>
In-Reply-To: <61a67466-3467-4f71-bc27-d660e37c08ac@sirena.org.uk>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLJsWRmVeSWpSXmKPExsWy7bCmhW6msk6KwfOrxhYP5m1js1j84zmT
        xdSHT9gsLu/Xtph/5Byrxd7XW9ktNj2+xmpxedccNosZ5/cxWTR+vMlu0br3CLsDt8f1JZ+Y
        PTat6mTzuHNtD5vH5iX1Hn1bVjF6fN4kF8AWlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pm
        YKhraGlhrqSQl5ibaqvk4hOg65aZA3SdkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUg
        JafAvECvODG3uDQvXS8vtcTK0MDAyBSoMCE743C/VMEutoplj1+xNDC2s3YxcnJICJhIzNwz
        Hcjm4hAS2MEoMXfie0YI5xOjxLt7b5lAqoQEPjNK3HihC9OxbdU5FoiiXYwSr+58gHJeM0q0
        rexgBKniFbCTOL9rKjOIzSKgItH3tB0qLihxcuYTFhBbVCBKou/2JrA7hAXcJXat+g9Wzywg
        LnHryXywzSICyhJXv+8FW8As8JFJ4tbMSWAJNgFtie/rF4M1cwo4SqyY3MIC0Swvsf3tHGaQ
        BgmBpRwSH+a9ZIK420Wi/cU3KFtY4tXxLewQtpTE53d72SDsbIn26X+gIVMhcXHDbKi4scSs
        ZyAfcAAt0JRYv0sfxJQAOu7ILai1fBIdh/+yQ4R5JTrahCAa1STuTz0HNURGYtKRlVAHeEj8
        mfiaeQKj4iykUJmF5PtZSJ6ZhbB3ASPLKkax1ILi3PTUYqMCE3hcJ+fnbmIEp1stjx2Ms99+
        0DvEyMTBeIhRgoNZSYRXtUsrRYg3JbGyKrUoP76oNCe1+BCjKTBuJjJLiSbnAxN+Xkm8oYml
        gYmZmaG5kamBuZI478cO5RQhgfTEktTs1NSC1CKYPiYOTqkGJgOfd3zuK099cVz/T5XnNs+7
        pnnf103Jzve4uWZhYqpp1IvkAynbFfI3e1l3asXnT03bKPH57Ca26/Y39E4oFPBsO321YvNC
        nf1+Z6Y1mHCujTfzr5au8Sz2uXz9i1u+79n+68pfXt7oWGn+/O072eK/eRvaJz5jqtH6HiFk
        yaidFtqRmPL89O4im+Wh7Pfkot6Emb5znG3UnMmrX/d99eJo54fuj778X3co8YTiUeNdHzKC
        Nsy5W31o9tFaxqIZW+3imGqDbTm9/7j/Kl5Q9fBAhPdVJo4TS16JOEx9O0/hsOaUv987SyZM
        1f2+8I/vZGfJNAnX2fKJut2hG1bJMtw91plYonx40SUj7dvO05RYijMSDbWYi4oTAZqiHNZA
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LZdlhJXjdDWSfFYF2bvsWDedvYLBb/eM5k
        MfXhEzaLy/u1LeYfOcdqsff1VnaLTY+vsVpc3jWHzWLG+X1MFo0fb7JbtO49wu7A7XF9ySdm
        j02rOtk87lzbw+axeUm9R9+WVYwenzfJBbBFcdmkpOZklqUW6dslcGUc7pcq2MVWsezxK5YG
        xnbWLkZODgkBE4ltq86xdDFycQgJ7GCUaFt2gRkiISOx/FkfG4QtLHG/5QgrRNFLRonepTNZ
        QBK8AnYS53dNBWtgEVCR6HvazggRF5Q4OfMJWI2oQJTE5wMt7CC2sIC7xK5V/8HqmQXEJW49
        mc8EYosIKEtc/b6XBSL+kUli0gRxiGX/GCVubvkIdiqbgLbE9/WLwWxOAUeJFZNboBrMJLq2
        djFC2PIS29/OYZ7AKDQLyR2zkOybhaRlFpKWBYwsqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS
        9ZLzczcxgqNMS2sH455VH/QOMTJxMB5ilOBgVhLhVe3SShHiTUmsrEotyo8vKs1JLT7EKM3B
        oiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qBKfzy9tr84C+LN5p7qDSl3shP+9ne8L7zqm2m
        tayprNTyZLttX4L28M72E5+5cfvdYMNyCR8FBqunQTzPa2NTw45uDjuUpF8m0Be0b/OX26te
        qb1fFKX7iInvqs5x2eWnDTXZlbbtWun/SXvCoktvQ8ytl+o+byh/NperVPLO0X3d7Hdc5+w7
        c/6A0i7B6Avv7J8b2Z2c9OTaV+O2Cr7v86Qap6vk+X19GRysm1Jxc6KTnczZlAcC+R4y3L9e
        SD+anO026ej8kL8LrxesuzVNPnGPUN75lMygexxeP3rjVj/ceui88HuhV8US4uo3vn1aFGeT
        r37EtGNp36Uf5/8XLZaYEVX2TFS6Rzvq+YV4DSWW4oxEQy3mouJEAIV+6achAwAA
X-CMS-MailID: 20230404131728epcas2p251e43101498d4ad7591a39ce710c60f7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230404061409epcas2p2b12a9cac014907e3930795cb67cb6040
References: <20230404060011.108561-1-jaewon02.kim@samsung.com>
        <CGME20230404061409epcas2p2b12a9cac014907e3930795cb67cb6040@epcas2p2.samsung.com>
        <20230404060011.108561-4-jaewon02.kim@samsung.com>
        <61a67466-3467-4f71-bc27-d660e37c08ac@sirena.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,


On 23. 4. 4. 21:58, Mark Brown wrote:
> On Tue, Apr 04, 2023 at 03:00:11PM +0900, Jaewon Kim wrote:
>
>> This patch adds IRQ based PIO mode instead of cpu polling.
>> By using the FIFO trigger level, interrupts are received.
>> CPU consumption is reduced in PIO mode because registers are not
>> constantly checked.
> Is there some lower limit where it's still worth using polling, for
> example for just one or two bytes like a register address?  Taking an
> interrupt isn't free...


I did not considers lower limit.
According to your review, interrupt seems to be called too often.
However, It can't prevent the CPU utilization going to 100% during spi 
transmission.
We will give more consideration and deliver a better solution to the 
next patch version.


Thanks

Jaewon Kim


