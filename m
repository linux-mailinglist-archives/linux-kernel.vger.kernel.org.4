Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8F270D3F8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbjEWG2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjEWG2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:28:13 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6514F139
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 23:28:09 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230523062805epoutp01ceadaec37af62f730195995d962fcb0c~hsdoeAvcW2532825328epoutp01Q
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 06:28:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230523062805epoutp01ceadaec37af62f730195995d962fcb0c~hsdoeAvcW2532825328epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684823286;
        bh=cR5tXXN+QkMQaMg9/Au1EJSSPjswQSxXF8zOF6/3i0A=;
        h=From:To:Cc:Subject:Date:References:From;
        b=a7/k1BTqvYxASMkcg/KFWxMY7Hfa629inwzdyUAxUu6+cX/9dUht1ar5wk3KnfYL3
         46jyKWOuLrslmwH7ObDuODVOOV2aZlES9G0FYQl1DnjqqHt02aQWbUDpDImUPCr1hS
         8wEWhbkost2Gi6uklfXeo+dUmX3f7+dGSaGLMEdM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230523062805epcas2p448c1d1877a21429290438be105b14c28~hsdoArM8k2700227002epcas2p4G;
        Tue, 23 May 2023 06:28:05 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.101]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4QQPWm5m8Bz4x9Q1; Tue, 23 May
        2023 06:28:04 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        68.01.11450.4FC5C646; Tue, 23 May 2023 15:28:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230523062804epcas2p3ef5af461aac27abb52cf891bf0a7c9fb~hsdm7M-Io0207802078epcas2p3k;
        Tue, 23 May 2023 06:28:04 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230523062804epsmtrp1300f23c279b3450570c7185a5fe84ab9~hsdm6OP220622306223epsmtrp1l;
        Tue, 23 May 2023 06:28:04 +0000 (GMT)
X-AuditID: b6c32a45-1dbff70000022cba-5d-646c5cf4296f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CB.3F.28392.4FC5C646; Tue, 23 May 2023 15:28:04 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230523062804epsmtip11289c3a06ace5ce00f9285333928a9d5~hsdmpAWbt1521615216epsmtip1l;
        Tue, 23 May 2023 06:28:04 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, kwangwon.min@samsung.com,
        junwoo80.lee@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [PATCH v1 0/3] change UIC command handling
Date:   Tue, 23 May 2023 15:19:07 +0900
Message-Id: <cover.1684822284.git.kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42LZdljTTPdLTE6KQe8rDYuTT9awWTyYt43N
        4uXPq2wWBx92slhM+/CT2WL14gcsFotubGOy2PW3mcli642dLBY3txxlsbi8aw6bRff1HWwW
        y4//Y7LounuD0WLpv7csDvwel694eyze85LJY8KiA4we39d3sHl8fHqLxaNvyypGj8+b5Dza
        D3QzBXBEZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXm
        AB2vpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwL9ArTswtLs1L18tLLbEyNDAw
        MgUqTMjO2HlvMmvBF9aKvkuT2RsYG1m7GDk5JARMJBYvOMPYxcjFISSwg1Hiev9NZgjnE6PE
        zOu7oZzPjBLTPh0BcjjAWk6eNYGI72KU+PtnHgvIKCGBH4wSHZONQGw2AU2JpzenMoHYIgI3
        mCSe9IuC2MwC6hK7JpwAiwsLGEu8eDEBbCaLgKrEuSVyIGFeAQuJNWcvsUBcJydx81wn2A0S
        Ao0cElfXXWeDSLhI/Oq8CVUkLPHq+BZ2CFtK4mV/GzvEndkSexaKQYQrJBZPewtVbiwx61k7
        I0gJM9CZ63fpQ1QrSxy5xQJxJJ9Ex+G/UEN4JTrahCAalSV+TZrMCGFLSsy8eQdqp4fEhclN
        TCDlQgKxEstO209glJ2FMH4BI+MqRrHUguLc9NRiowJDePwk5+duYgQnRS3XHYyT337QO8TI
        xMF4iFGCg1lJhPdEeXaKEG9KYmVValF+fFFpTmrxIUZTYFhNZJYSTc4HpuW8knhDE0sDEzMz
        Q3MjUwNzJXFeaduTyUIC6YklqdmpqQWpRTB9TBycUg1MUqxRxm7CNZsf/1+82WhDhsp+15yH
        S1cZ6fX/U2SfFig5ydFLStvgYlj2jZNH+iYuLKz6s+TTuo8fdxxa+sVtVxcrK6v1hL/PH5cK
        nJ/5mufvmwOVtzcE2y7nCnrroP7d/fUrJ53ZR6wf22T82aHVp+mruC2G8+5lKc3uclXhbdHi
        0h7qvcz+Whx+Hg7Hjp/79+QHf+ChZYGhKod99YJNHyhH8EyPvRObbXNLeGHolIK5ZS+DXZar
        aL5ZE5e5U+a2Y0zmjUSXrJr1TZuapaddm7M4SPOlZZnOBWOno6pOF85eXiG78n7zKaujB3rZ
        /70r2roupmUtV9j19Uom629N3/rqq42IXefi7XqM4Ub8SizFGYmGWsxFxYkAwFRQ+xMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCLMWRmVeSWpSXmKPExsWy7bCSnO6XmJwUg33HuS1OPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZovVix+wWCy6sY3JYtffZiaLrTd2sljc3HKUxeLyrjlsFt3Xd7BZ
        LD/+j8mi6+4NRoul/96yOPB7XL7i7bF4z0smjwmLDjB6fF/fwebx8ektFo++LasYPT5vkvNo
        P9DNFMARxWWTkpqTWZZapG+XwJWx895k1oIvrBV9lyazNzA2snYxcnBICJhInDxr0sXIxSEk
        sINRYkv/VMYuRk6guKTEiZ3PoWxhifstR1ghir4xSky6tJ8JJMEmoCnx9OZUJpCEiMArJom5
        /0+BdTALqEvsmnACrEhYwFjixYsJzCDbWARUJc4tkQMJ8wpYSKw5e4kFYoGcxM1zncwTGHkW
        MDKsYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIDlgtrR2Me1Z90DvEyMTBeIhRgoNZ
        SYT3RHl2ihBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1M
        e9coHdnI8KvmakXvM86/ap7hIWanFDbYvFDqf63t6qFz8uUDP4EjDj6u/88s+LAyS0uM74Th
        RGWm2IParldXO5WtXsA6Y1nZnradh45tuOu8juV4vLf4c/3WqAAO7de64Rs6wvym9XakSd6R
        PyFySu6T6ak7zhEh++7fjOkp/XjLKNj++on75S4CTBtso5sd2R1qebIVHRQz18zPt12WaBEb
        2pJ4m+/Cgefm8x7sy/uWm/ykyPxiTJb8H/NjE6/frprtxNpcwu08S3Gn/elbM2+nK13iEQzJ
        Z35c6LSmRl7uVtjuL/viPXL8WxcYc5sfeBubuuxxJtuLTZOZmHXrLdbsj7ngzFG8TeV6dKIS
        S3FGoqEWc1FxIgBCVcCFxwIAAA==
X-CMS-MailID: 20230523062804epcas2p3ef5af461aac27abb52cf891bf0a7c9fb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230523062804epcas2p3ef5af461aac27abb52cf891bf0a7c9fb
References: <CGME20230523062804epcas2p3ef5af461aac27abb52cf891bf0a7c9fb@epcas2p3.samsung.com>
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

There are two issues on UIC command handling related to auto hibern8.
https://lore.kernel.org/linux-scsi/1684208012-114324-1-git-send-email-kwmad.kim@samsung.com/
https://lore.kernel.org/linux-scsi/1684209152-115304-1-git-send-email-kwmad.kim@samsung.com/

Now I combine the two things into this thread.
And one thing added to make part of submitting a UIC command apart
from the critical section w/ host_lock.

Kiwoong Kim (3):
  ufs: make __ufshcd_send_uic_cmd not wrapped by host_lock
  ufs: poll HCS.UCRDY before issuing a UIC command
  ufs: poll pmc until another pa request is completed

 drivers/ufs/core/ufshcd.c | 109 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 77 insertions(+), 32 deletions(-)

-- 
2.7.4

