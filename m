Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78306DF56D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjDLMfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjDLMfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:35:42 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF9D2D7F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:35:36 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230412123534epoutp0203def2377714c26dd2cc78e545734ea7~VMBx--SjE1216812168epoutp02E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:35:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230412123534epoutp0203def2377714c26dd2cc78e545734ea7~VMBx--SjE1216812168epoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681302934;
        bh=Z+G8NuR7nuAJkftYgY4n98lVUKDSJ+dDpuJiqKYdCcI=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=TII4Kdw+4+Uk3C/0DluT8BPFD1mpQgPMWa2n45t4cHdWMbUFWAaqvfAt1JM0EiUWQ
         5DZTNonm3JeLwq8WH+CywbqlTyHJZwoIdhecJ+NpP9WSO/TH3EB+Nm6idLjuO58qA6
         OTapEf7k2j8+HZwY9jLZ74ZkD2a81BYIx3FQOXIE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230412123534epcas1p4e07723bbfe8f6753fa31421261b5d7d1~VMBxa5Hw_1636716367epcas1p42;
        Wed, 12 Apr 2023 12:35:34 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.240]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PxMcj69Z7z4x9Pv; Wed, 12 Apr
        2023 12:35:33 +0000 (GMT)
X-AuditID: b6c32a39-5dbff7000000247b-bf-6436a5955552
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.5E.09339.595A6346; Wed, 12 Apr 2023 21:35:33 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v3] dma-buf/heaps: system_heap: avoid too much
 allocation
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     "jstultz@google.com" <jstultz@google.com>,
        "tjmercier@google.com" <tjmercier@google.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <ZDabMEUFE2N3dvxZ@dhcp22.suse.cz>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230412123532epcms1p23092e51df04b3fb4e18e90b324ebcaa4@epcms1p2>
Date:   Wed, 12 Apr 2023 21:35:32 +0900
X-CMS-MailID: 20230412123532epcms1p23092e51df04b3fb4e18e90b324ebcaa4
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKJsWRmVeSWpSXmKPExsWy7bCmnu7UpWYpBnv3a1vMWb+GzeLlIU2L
        hQ/vMlus3uRr0b15JqNF7/tXTBZ/Tmxks7i8aw6bxb01/1kt7vc5WJy6+5nd4t36L2wOPB6H
        37xn9tj7bQGLx85Zd9k9Fmwq9dj0aRK7x51re9g8Tsz4zeLRt2UVo8f6LVdZPD5vkgvgisq2
        yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAE6WkmhLDGn
        FCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFagV5yYW1yal66Xl1piZWhgYGQKVJiQnbHk
        wW22gs0cFS9fPGduYLzH1sXIySEhYCLR2HUJyObiEBLYwSix+etJpi5GDg5eAUGJvzuEQWqE
        Bfwl9r2YwwhiCwkoSZz9cYUdIq4r0dS9mgXEZhPQlni/YBIriC0CVNO1eSfYTGaBy8wSrVf3
        QS3jlZjR/pQFwpaW2L58K9hQTgE9idnbHjNBxEUlbq5+yw5jvz82nxHCFpFovXeWGcIWlHjw
        czcjzJw/x59DzS+WWNb5AGpOjcSKc6ug4uYSDW9Xgtm8Ar4S1/Z9BjuURUBVYm/LdKh6F4lp
        81eDzWQWkJfY/nYOMygcmAU0Jdbv0ocoUZTY+XsuVAmfxLuvPawwbzVs/M2Ojb1j3hOo8WoS
        Lc++QtXLSPz994x1AqPSLERIz0KyeBbC4gWMzKsYxVILinPTU4sNC0zhkZucn7uJEZx+tSx3
        ME5/+0HvECMTB+MhRgkOZiUR3h8upilCvCmJlVWpRfnxRaU5qcWHGE2BXp7ILCWanA/MAHkl
        8YYmlgYmZkYmFsaWxmZK4rxfnmqnCAmkJ5akZqemFqQWwfQxcXBKNTCtLRJWmpfdrHTv83uv
        z2+OX3dMeXl8m7bT1TtTWAwbwuPMzd9p/P90Y5F82QL5uT8PxXnwcT7UfLGuctvW4LbGpX2H
        /7z6LJ0r3HyHKWhvsaF+BofwHS9doycnF++LvrSmWfLGnIB1JZHqQpaGE0+vOnTg+RKHD377
        vivHy944Ffh2wscuqfNTVq791cEf1ZV2NWJrb/bUfwt2+CRuPa+eGN9XtcT3xlfnPV2aBQsm
        5a2ycDI6IGceVXFTfNevP3W2b9beOzpt7zSHtFP5YsqPfpzPPvPCPO1hVmjYm9CYuCmPa618
        JHlVOjgdg29xX1/f4sg4T3tvS17N1ZuhFxKcL0Qzc+7deOXCFs8/O73vKrEUZyQaajEXFScC
        AE1cRVVIBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230410073304epcas1p4cf3079b096994d69472b7801bd530bc7
References: <ZDabMEUFE2N3dvxZ@dhcp22.suse.cz>
        <ZDaP4/PYyb9tKGQi@dhcp22.suse.cz> <ZDZ4j7UdBt32j28J@dhcp22.suse.cz>
        <ZDZqYTSHBNGLq0zI@dhcp22.suse.cz>
        <20230410073228.23043-1-jaewon31.kim@samsung.com>
        <20230412085726epcms1p7d2bec2526e47bd10a3b6ea6a113c9cc3@epcms1p7>
        <20230412094440epcms1p445319579ead0d0576bb616ebb07501b4@epcms1p4>
        <20230412113759epcms1p8cb15b54e3a96c7616419cb030d16f804@epcms1p8>
        <CGME20230410073304epcas1p4cf3079b096994d69472b7801bd530bc7@epcms1p2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Wed 12-04-23 20:37:59, Jaewon Kim wrote:
>> Limiting dmabuf memory may be required. But I think there
>> is no nice and reasonable way so far.
>
>If that is really the way then the patch doesn't really add a big
>benefit. It doesn't really prevent OOMs (or panics due to OOM) as the
>allocator still allows to consume arbitrary amount of memory. The
>provided check is not able to tell between buggy and legit calls.
>-- 
>Michal Hocko
>SUSE Labs

Yes it could be. Though the buggy call is blocked by totalram_pages check,
mm may suffer memory shortage due to the huge memory consumption through
dma-buf system heap. We just hope Android LMKD or oomk kills the memory
hoggers prior to oom panic.

IMO if possible mm should be able to track the dma-buf size as stat in
mm_rss_stat for each process. Then oomk is able to know size through
get_mm_rss. Actually in mobile device environment, there is one more
this kind of allocator. That is graphics drivers. They also consumes
quite much memory and they may allocate as userspace wants.

Jaewon Kim
