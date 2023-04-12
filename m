Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95D76DEFF2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjDLI6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjDLI6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:58:12 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D19E40
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:57:54 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230412085727epoutp0300b6db32b6cb85f9b8db6df002db01e4~VJDVwtawZ2184521845epoutp03X
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 08:57:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230412085727epoutp0300b6db32b6cb85f9b8db6df002db01e4~VJDVwtawZ2184521845epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681289847;
        bh=QktOMJ5SidbJeG5GX8NFdAFfpLw3OPxQjf/utIO5YxU=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=f5Q0cBzaxDblTLtt3SPcefzrv3FQjGgdhYHVeqtOt9p1LMfNJoc7DrQQMafBvamXM
         UEfIAevkeYpMTL48BmGJY/eE0gxsRWuw7JMqiT4X5GKERGbQdcGTs3d98ukHtbJAqL
         3XKqKnBURRXeB3X/uoeYTf8ZzZATYHemW5cH3bs0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230412085727epcas1p194f55f11f3cbf930d7ab447d7ccf75c5~VJDVIzneL1847418474epcas1p12;
        Wed, 12 Apr 2023 08:57:27 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.250]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PxGn25ZYXz4x9Pt; Wed, 12 Apr
        2023 08:57:26 +0000 (GMT)
X-AuditID: b6c32a35-99fff7000001b6a3-66-643672762537
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.7C.46755.67276346; Wed, 12 Apr 2023 17:57:26 +0900 (KST)
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
In-Reply-To: <ZDZqYTSHBNGLq0zI@dhcp22.suse.cz>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230412085726epcms1p7d2bec2526e47bd10a3b6ea6a113c9cc3@epcms1p7>
Date:   Wed, 12 Apr 2023 17:57:26 +0900
X-CMS-MailID: 20230412085726epcms1p7d2bec2526e47bd10a3b6ea6a113c9cc3
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmgW5ZkVmKwdImHYs569ewWbw8pGmx
        8OFdZovVm3wtujfPZLToff+KyeLPiY1sFpd3zWGzuLfmP6vF/T4Hi1N3P7NbvFv/hc2Bx+Pw
        m/fMHnu/LWDx2DnrLrvHgk2lHps+TWL3uHNtD5vHiRm/WTz6tqxi9Fi/5SqLx+dNcgFcUdk2
        GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBHKymUJeaU
        AoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKzAr0ihNzi0vz0vXyUkusDA0MjEyBChOyM850
        f2Qu2MJd0TbtD2MDYyNnFyMnh4SAicT2vVNYuhi5OIQEdjBKvN0xh7GLkYODV0BQ4u8OYZAa
        YQF/iX0vQMKcQDVKEmd/XGGHiOtKNHWvZgGx2QS0Jd4vmMQKYosA1XRt3skGMpNZ4DKzROvV
        fWwQy3glZrQ/ZYGwpSW2L98KNpRTQE9i6+ElTBBxUYmbq9+yw9jvj81nhLBFJFrvnWWGsAUl
        HvzczQgz58/x51DziyWWdT6AmlMjseLcKqi4uUTD25VgNq+Ar8TEPUfAbmARUJVoe7gA7F8J
        AReJjy+0QMLMAvIS29/OYQYJMwtoSqzfpQ8xRVFi5++5jBAlfBLvvvawwnzVsPE3Ozb2jnlP
        oK5Rk2h59hWqXkbi779nrBMYlWYhAnoWksWzEBYvYGRexSiWWlCcm55abFhgCI/b5PzcTYzg
        5KtluoNx4tsPeocYmTgYDzFKcDArifD+cDFNEeJNSaysSi3Kjy8qzUktPsRoCvTxRGYp0eR8
        YPrPK4k3NLE0MDEzMrEwtjQ2UxLn/fJUO0VIID2xJDU7NbUgtQimj4mDU6qB6YluqIxuG5dZ
        3WvruI32PS/Sc+wXfjh1XKt76mFjfYUlMdJHo/5NPrH0ispBwW3LmdKv86qURDYUdetEPSr4
        eedjn83N+fW3nFi6UgK/hGyVrNpnyFl3QHLdSu0k/5jPv8Js+lc8SjoZx8+5MWJJSahr6ZKf
        CXkXLxw926DJb+N/Xv7JZdEmwy0cqzZ51ltO5JmYcoJNr8F2vvFZvc26IZr5lyQ8Ox5+8DHO
        qTaaNrnYecGx9cc6pjY8mLBK6fVOwQWXVAOP5s1W4bttelnpVdm5PQJc298sMDQtFFnUXi/f
        1Xabybr12qS79qkTZvhvnqmX35if+iHj9ck8VatGP/NL/XmPff7zVLtIV39RYinOSDTUYi4q
        TgQAVHfVm0cEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230410073304epcas1p4cf3079b096994d69472b7801bd530bc7
References: <ZDZqYTSHBNGLq0zI@dhcp22.suse.cz>
        <20230410073228.23043-1-jaewon31.kim@samsung.com>
        <CGME20230410073304epcas1p4cf3079b096994d69472b7801bd530bc7@epcms1p7>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Sorry for being late. I know there was some pre-existing discussion
>around that but I didn't have time to participate.
>
>On Mon 10-04-23 16:32:28, Jaewon Kim wrote:
>> @@ -350,6 +350,9 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
>>  	struct page *page, *tmp_page;
>>  	int i, ret = -ENOMEM;
>>  
>> +	if (len / PAGE_SIZE > totalram_pages())
>> +		return ERR_PTR(-ENOMEM);
>> +
>
>This is an antipattern imho. Check 7661809d493b ("mm: don't allow
>oversized kvmalloc() calls") how kvmalloc has dealt with a similar

Hello Thank you for the information.

I tried to search the macro of INT_MAX.

include/vdso/limits.h
#define INT_MAX         ((int)(~0U >> 1))

AFAIK the dma-buf system heap user can request that huge size more than 2GB. So
I think totalram_pages() is better than INT_MAX in this case.

>issue. totalram_pages doesn't really tell you anything about incorrect
>users. You might be on a low memory system where the request size is
>sane normally, it just doesn't fit into memory on that particular
>machine.

Sorry maybe I'm not fully understand what you meant. User may requested
a huge size like 3GB on 2GB ram device. But I think that should be rejected
because it is bigger than the device ram size.

Jaewon Kim

>
>
>>  	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
>>  	if (!buffer)
>>  		return ERR_PTR(-ENOMEM);
>> -- 
>> 2.17.1
>
>-- 
>Michal Hocko
>SUSE Labs
