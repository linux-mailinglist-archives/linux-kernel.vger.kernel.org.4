Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D44A73FD49
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 15:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjF0N4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 09:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjF0N4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 09:56:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E01E74
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:56:45 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35RD0aax005898;
        Tue, 27 Jun 2023 13:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=4S2U3hsLDipgOOGGVwmjrTLzrZZ9eXd9cKZq+iimHYM=;
 b=DKQj5gvJJT0ZLNqzSuO+54SwWWtKZelyhYtKMyy52nOKHV7gUe89puLweLbv+mdX7LI+
 1wjD9zMPDdaVU0Bntgqz+/a+T0UaTrjJljfMxQprCUM04XXGis805zGb5/qjIHPnWnS2
 x2qZJUHq1eRz8nWQUg2jfChudIsMKy9fosWfCrfzzlv3T33XY++qTX74WmZ4Cr1MvV1Z
 lmkdaZ5Ol0q7H5avDIfYHSSQbyODS/CQmsEJmhq8JaHH4dL7/saFnCBbE5qjUCtqCRf/
 qcfdzvgWHdHv1AQmFvIPA+ZR+lzOWghAFFq/l+I3qnQ53epTQo2JB/qZANlu0tczzIQP TQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rfuhj8qkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 13:56:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35RDuXmA017991
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 13:56:33 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 27 Jun 2023 06:56:29 -0700
Date:   Tue, 27 Jun 2023 19:26:24 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
CC:     <akpm@linux-foundation.org>, <surenb@google.com>,
        <hannes@cmpxchg.org>, <minchan@kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_smanapra@quicinc.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] mm: madvise: fix uneven accounting of psi
Message-ID: <f72dc0b0-e848-4053-879d-5eccd4d00b52@quicinc.com>
References: <1687861992-8722-1-git-send-email-quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1687861992-8722-1-git-send-email-quic_charante@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sLP3apRvmAXLgRyIILXz4HttgIauD-BR
X-Proofpoint-ORIG-GUID: sLP3apRvmAXLgRyIILXz4HttgIauD-BR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_09,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270129
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 04:03:12PM +0530, Charan Teja Kalla wrote:
> A folio turns into a Workingset during:
> 1) shrink_active_list() placing the folio from active to inactive list.
> 2) When a workingset transition is happening during the folio refault.
> 
> And when Workingset is set on a folio, PSI for memory can be accounted
> during a) That folio is being reclaimed and b) Refault of that folio.
> 

Please help me understand why PSI for memory (I understood it as the 
time spent in psi_memstall_enter() to psi_memstall_leave()) would be
accounted in (a) i.e during reclaim. I understand that when a working

The (b) part is very clear.

> This accounting of PSI for memory is not consistent in the cases where
> clients use madvise(COLD/PAGEOUT) to deactivate or proactively reclaim a
> folio:
> a) A folio started at inactive and moved to active as part of accesses.
> Workingset is absent on the folio thus madvise(MADV_PAGEOUT) don't
> account such folios for PSI.
> 
> b) When the same folio transition from inactive->active and then to
> inactive through shrink_active_list(). Workingset is set on the folio
> thus madvise(MADV_PAGEOUT) account such folios for PSI.
> 
> c) When the same folio is part of active list directly as a result of
> folio refault and this was a workingset folio prior to eviction.
> Workingset is set on the folio thus both the operations of MADV_PAGEOUT
> and reclaim of the MADV_COLD operated folio account for PSI.
> 
> d) madvise(MADV_COLD) transfers the folio from active list to inactive
> list. Such folios may not have the Workingset thus reclaim operation
> on such folio doesn't account for PSI.
> 
> As said above, the MADV_PAGEOUT on a folio is accounts for memory PSI in
> b) and c) but not in a). Reclaim of a folio on which MADV_COLD is
> performed accounts memory PSI in c) but not in d) which is an
> inconsistent behaviour. Make this PSI accounting always consistent by
> turning a folio into a workingset one whenever it is leaving the active
> list. Also, accounting of PSI on a folio whenever it leaves the
> active list as part of the MADV_COLD/PAGEOUT operation helps the users
> whether they are operating on proper folios[1].

I understood the problem from V1 discussions. But the references to 
"madvise account such folios for PSI" is confusing. Why would madvise(PAGEOUT)
be accounting anything related to PSI. I get that madvise() is messing
up PSI accuracy indirectly..

> 
> [1] https://lore.kernel.org/all/20230605180013.GD221380@cmpxchg.org/
> 
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Reported-by: Sai Manobhiram Manapragada <quic_smanapra@quicinc.com>
> Reported-by: Pavan Kondeti <quic_pkondeti@quicinc.com>
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
> ---
> V2: Made changes as per the comments from Johannes/Suren.
> 
> V1: https://lore.kernel.org/all/1685531374-6091-1-git-send-email-quic_charante@quicinc.com/
> 
>  mm/madvise.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index d9e7b42..76fb31f 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -413,6 +413,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  
>  		folio_clear_referenced(folio);
>  		folio_test_clear_young(folio);
> +		folio_set_workingset(folio);
>  		if (pageout) {
>  			if (folio_isolate_lru(folio)) {
>  				if (folio_test_unevictable(folio))
> @@ -512,6 +513,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  		 */
>  		folio_clear_referenced(folio);
>  		folio_test_clear_young(folio);
> +		folio_set_workingset(folio);
>  		if (pageout) {
>  			if (folio_isolate_lru(folio)) {
>  				if (folio_test_unevictable(folio))
> -- 
> 2.7.4
> 

This is not limited to madvise(PAGEOUT) right, anywhere an active page
is reclaimed we have the same problem. For ex: damon_pa_pageout() and
__alloc_contig_migrate_range()->reclaim_clean_pages_from_list().

If that is the case, can we set mark a folio as a workingset when it is
activated? That way, we don't have make madvise() as a special case?

Thanks,
Pavan
