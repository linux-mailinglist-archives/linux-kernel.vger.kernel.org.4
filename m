Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9755565BB71
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 08:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjACHv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 02:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjACHu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 02:50:59 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D11DF09
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 23:50:58 -0800 (PST)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230103075056epoutp02cd15461210d13badb3eb8ba625f124f5~2vR-h44H02769227692epoutp02D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 07:50:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230103075056epoutp02cd15461210d13badb3eb8ba625f124f5~2vR-h44H02769227692epoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672732256;
        bh=UN+4QdP10C7vIuKX4Eh8/LWwOKBNyBebpbBsufTIiuk=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=OFk5vCvKGA3aePJKpFFuUDQEPGmWjbAtc7tx+XOCQRXK+a4q18DaLN3Hykr8DRIBw
         lEYxJ4/+XZE5Ya8tjfqtCrNkKjJ9RMRHIx1m/wNCDF9GqOkbVyQJa0jQrA21vOv+XO
         R/yPw9z4t/0aOj4r/DKlJrGBcxAJ+eqRlmVNM7gY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230103075055epcas1p400c80b8ca07cf14cdfbb4b392bd4e78c~2vR-HOCkB0794907949epcas1p4G;
        Tue,  3 Jan 2023 07:50:55 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.249]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NmPzz3770z4x9Px; Tue,  3 Jan
        2023 07:50:55 +0000 (GMT)
X-AuditID: b6c32a39-7eb28a800001a220-8f-63b3de5f1002
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        D3.E5.41504.F5ED3B36; Tue,  3 Jan 2023 16:50:55 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH] page_alloc: avoid the negative free for meminfo
 available
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <Y7PaxPV3Ln7AXVSc@lucifer>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230103075054epcms1p308aa577d10429a2e0e6167de510be6b6@epcms1p3>
Date:   Tue, 03 Jan 2023 16:50:54 +0900
X-CMS-MailID: 20230103075054epcms1p308aa577d10429a2e0e6167de510be6b6
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKJsWRmVeSWpSXmKPExsWy7bCmvm78vc3JBjuvC1rMWb+GzeLlIU2L
        1Zt8Lbo3z2S06H3/isni8q45bBb31vxntbjzbR67xetvy5gdOD0Ov3nP7LFz1l12j02rOtk8
        Nn2axO5xYsZvFo++LasYPT5vkgtgj8q2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0
        MFdSyEvMTbVVcvEJ0HXLzAE6TEmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFag
        V5yYW1yal66Xl1piZWhgYGQKVJiQnbFleQtLwTOeik89i5gaGOdzdTFycEgImEhMPhfRxcjF
        ISSwg1Fiw/f7TCBxXgFBib87hLsYOTmEBQIk1v+8xw5iCwkoSZz9cYUdIq4r0dS9mgXEZhPQ
        lni/YBIrSKuIgIbEixtWICOZBbYwSVw+uocNpEZCgFdiRvtTFghbWmL78q2MIDangLrE75lH
        oWpEJW6ufssOY78/Np8RwhaRaL13lhnCFpR48HM3VFxK4lz3cSaIVyIkXuxRhwjnSLzfOYcV
        wjaXeLahhR3iK1+J//s8QcIsAqoSh/5egproItE3/yDYZcwC8hLb385hBilnFtCUWL9LH6JE
        UWLn77mMMI80bPzNjs5mFuCTePe1hxUmvmPeEyYIW02i5dlXqLiMxN9/z1gnMCrNQgTzLCSL
        ZyEsXsDIvIpRLLWgODc9tdiwwBQescn5uZsYwelTy3IH4/S3H/QOMTJxMB5ilOBgVhLhnfRi
        U7IQb0piZVVqUX58UWlOavEhRlOglycyS4km5wMTeF5JvKGJpYGJmZGJhbGlsZmSOK9NxLpk
        IYH0xJLU7NTUgtQimD4mDk6pBqbw7hVvroefTmg4sOxoBlv2ReMrv/VPfdn0LvrpxAWvJs1a
        f+biwhU1tbG3Flvw7v5xPymwkOvvxuCe3itdqw2/Gkwzyz37pXN+5+mOtl8rpszzsXnjfGFy
        yNTXTc3Tjuw03MyTtSbBPplNUnGmvt0DJU0fuUeTGFs3hL96+s18ScZ2Xg2t4o13cyPMg/c+
        WvD1TeNFVcaFV6JCPsx13rawUS2g/fm3yas9XBny394o2tV9zPLqgde3d65tXZUZvSzlv3q7
        /uJyiae8y24XRO3K/r3muKpF3ZU21bW/Xn1aKW/BL6h/3miG2t4DX1a0MbpypMsvO/6XZ7tS
        3jy2KJ6fC0I8zqxkZsxNeqAoIRwWqcRSnJFoqMVcVJwIAEZ/ai8oBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230103072834epcas1p3441ef50a6cc26ac48d184f1244b76a0e
References: <Y7PaxPV3Ln7AXVSc@lucifer>
        <20230103072807.19578-1-jaewon31.kim@samsung.com>
        <CGME20230103072834epcas1p3441ef50a6cc26ac48d184f1244b76a0e@epcms1p3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>--------- Original Message ---------
>Sender : Lorenzo Stoakes?<lstoakes@gmail.com>
>Date : 2023-01-03 16:35 (GMT+9)
>Title : Re: [PATCH] page_alloc: avoid the negative free for meminfo available
>?
>On Tue, Jan 03, 2023 at 04:28:07PM +0900, Jaewon Kim wrote:
>> The totalreserve_pages could be higher than the free because of
>> watermark high or watermark boost. Handle this situation and fix it to 0
>> free size.
>>
>> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
>> ---
>> ?mm/page_alloc.c | 2 ++
>> ?1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 218b28ee49ed..e510ae83d5f3 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -5948,6 +5948,8 @@ long si_mem_available(void)
>> ? ? ? ? ? * without causing swapping or OOM.
>> ? ? ? ? ? */
>> ? ? ? ? ?available = global_zone_page_state(NR_FREE_PAGES) - totalreserve_pages;
>> + ? ? ? ?if (available < 0)
>> + ? ? ? ? ? ? ? ?available = 0;
>>
>> ? ? ? ? ?/*
>> ? ? ? ? ? * Not all the page cache can be freed, otherwise the system will
>> --
>> 2.17.1
>>
>
>We already reset to zero at the end of the function, wouldn't resetting to zero
>here potentially skew the result?
>

Hello

I did not mean the negative of the final available, we should account the actual size
by removing some improper portion of it. The free should be not negative in that perspective.
If negative, other parts like pagecache an reclailable would be decreased.

Actually pagecache and reclaimable are caculated with min, so I think reseting to zero
at the end the function is not necessary.

br
