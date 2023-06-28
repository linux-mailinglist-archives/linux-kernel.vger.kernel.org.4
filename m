Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36EB740F37
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjF1KtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:49:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131]:53768 "EHLO
        mx0b-0031df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230128AbjF1KtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:49:19 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SAcAFx013623;
        Wed, 28 Jun 2023 10:49:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ob6btjFSuorpXhAULR64dCoUJky5COL+1vkFRVIp60k=;
 b=k39ewVsjxftSNiqLjE+GUnZ+zR1ggIw/vL+D9hS+mIkhWl9tSRueMOfeV30mAs02tXET
 3O36b6jri0f7r55Eoi35w7qhbXnqNZIYO7GJ7E+FHrt5tY3TUb4cHcDCRITdWJPxQaFq
 wGpz7xwPL96ESgcccjcoUfg2XiI8sy0BEMNQgv9e0+3nO99Y2/+qzAkugQkMAhFM8vw+
 vA2Wqy94pA9UEy2XPUOiTIn3A21DGcn191MR8TJnx/2VOPL47ci9KZJ3XXq53oYe83m+
 zw45v+74j4w4gTpVqdOf6R3bYAacmejQCjxq/7NeOloH9qJtscDx46aEFvmiwyjuFRFX ag== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rg9pb174c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 10:49:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35SAn7wH021484
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 10:49:08 GMT
Received: from [10.214.66.119] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Wed, 28 Jun
 2023 03:49:04 -0700
Message-ID: <65ce241e-8614-b669-cd20-b315c30bd794@quicinc.com>
Date:   Wed, 28 Jun 2023 16:19:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V2] mm: madvise: fix uneven accounting of psi
Content-Language: en-US
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     <akpm@linux-foundation.org>, <surenb@google.com>,
        <hannes@cmpxchg.org>, <minchan@kernel.org>,
        <quic_smanapra@quicinc.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <1687861992-8722-1-git-send-email-quic_charante@quicinc.com>
 <f72dc0b0-e848-4053-879d-5eccd4d00b52@quicinc.com>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <f72dc0b0-e848-4053-879d-5eccd4d00b52@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7x2JTTw-XtGP98JK4zzSAnneisrtiQ1e
X-Proofpoint-ORIG-GUID: 7x2JTTw-XtGP98JK4zzSAnneisrtiQ1e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 mlxlogscore=588 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306280094
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavan,

On 6/27/2023 7:26 PM, Pavan Kondeti wrote:
>> A folio turns into a Workingset during:
>> 1) shrink_active_list() placing the folio from active to inactive list.
>> 2) When a workingset transition is happening during the folio refault.
>>
>> And when Workingset is set on a folio, PSI for memory can be accounted
>> during a) That folio is being reclaimed and b) Refault of that folio.
>>
> Please help me understand why PSI for memory (I understood it as the 
> time spent in psi_memstall_enter() to psi_memstall_leave()) would be
> accounted in (a) i.e during reclaim. I understand that when a working
> 
> The (b) part is very clear.
> 
I meant to say, for usual reclaim, PSI is accounted on a folio for both
reclaim and as well during the refault operation when Workingset is set
on a folio i.e., both a) and b) cases above.

>> This accounting of PSI for memory is not consistent in the cases where
>> clients use madvise(COLD/PAGEOUT) to deactivate or proactively reclaim a
>> folio:

Seems I need to be explicit here. How about the below?

This accounting of PSI for memory is not consistent for reclaim +
refault operation between usual reclaim and madvise(COLD/PAGEOUT) which
deactivate or proactively reclaim a folio:

lmk for any better rephrasing?
>> a) A folio started at inactive and moved to active as part of accesses.
>> Workingset is absent on the folio thus madvise(MADV_PAGEOUT) don't
>> account such folios for PSI.
>>
>> b) When the same folio transition from inactive->active and then to
>> inactive through shrink_active_list(). Workingset is set on the folio
>> thus madvise(MADV_PAGEOUT) account such folios for PSI.
>>
>> c) When the same folio is part of active list directly as a result of
>> folio refault and this was a workingset folio prior to eviction.
>> Workingset is set on the folio thus both the operations of MADV_PAGEOUT
>> and reclaim of the MADV_COLD operated folio account for PSI.
>>
>> d) madvise(MADV_COLD) transfers the folio from active list to inactive
>> list. Such folios may not have the Workingset thus reclaim operation
>> on such folio doesn't account for PSI.
> This is not limited to madvise(PAGEOUT) right, anywhere an active page
> is reclaimed we have the same problem. For ex: damon_pa_pageout() and
> __alloc_contig_migrate_range()->reclaim_clean_pages_from_list().
>> If that is the case, can we set mark a folio as a workingset when it is
> activated? That way, we don't have make madvise() as a special case?
I think marking the folio as a workingset when it sits on the active is
not a correct thing. For the same example you mentioned, a simple CMA
allocation will be dropping the clean pages instead of migration. PSI
accounting on refault of those pages don't reveal anything to the user.

Where as in the madvise() cases, this PSI tells the user about the type
of pages that he is working on.[1]

BTW, damon_pa_pageout() seems a valid case above. let me fix it in the
next patch.

[1]https://lore.kernel.org/all/20230605180013.GD221380@cmpxchg.org/
