Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AA7741F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 07:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjF2FHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 01:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjF2FHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 01:07:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636E82728
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 22:07:39 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T40OfP012625;
        Thu, 29 Jun 2023 05:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=+OUbWglMT+o+9qp921cxDrlyIoh4BAKub1E1+7ruezE=;
 b=deoEn/BsHNKbJaY0MgoWbw6smVjqgCgjseFL4xgrRpE0rjjnUaExbArbqgot9a1aKBLk
 s2EplDZa5npHspl440T5ffq2e/E/S3MRv5yoOI5MWgpNyU7XBFLTyI/b2AvuNCpwLDx6
 Qb6n9Qf6Lh6rFQmzyjWZHyLuCKYM5D/0tggLFWERWOO54LGwoXinpk6Tth3m82NmEjt6
 81SQH5J5kw6J+9r4tdjTApHX+dzcMUVD3zm1CbSggF0Z3/pBVTI0q1OpQXMEH98mn8Gt
 n4eyQgPVe4bTh9gy2mAMnTZGk+YqFSC1+6XHSbJwQs7ZdKzi8wyMCcxREwpFIsjcCOAC Mg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgas2twwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 05:07:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35T57Ru7014877
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 05:07:28 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.7; Wed, 28 Jun 2023 22:07:24 -0700
Date:   Thu, 29 Jun 2023 10:37:20 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
CC:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        <akpm@linux-foundation.org>, <surenb@google.com>,
        <hannes@cmpxchg.org>, <minchan@kernel.org>,
        <quic_smanapra@quicinc.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] mm: madvise: fix uneven accounting of psi
Message-ID: <6e706e71-1594-4622-8f97-76ff08f2cdb3@quicinc.com>
References: <1687861992-8722-1-git-send-email-quic_charante@quicinc.com>
 <f72dc0b0-e848-4053-879d-5eccd4d00b52@quicinc.com>
 <65ce241e-8614-b669-cd20-b315c30bd794@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65ce241e-8614-b669-cd20-b315c30bd794@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: c9qSVPww3FN5C9dFZtcl_MhKepHFDkNl
X-Proofpoint-GUID: c9qSVPww3FN5C9dFZtcl_MhKepHFDkNl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 mlxlogscore=637 bulkscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290043
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 04:19:01PM +0530, Charan Teja Kalla wrote:
> Hi Pavan,
> 
> On 6/27/2023 7:26 PM, Pavan Kondeti wrote:
> >> A folio turns into a Workingset during:
> >> 1) shrink_active_list() placing the folio from active to inactive list.
> >> 2) When a workingset transition is happening during the folio refault.
> >>
> >> And when Workingset is set on a folio, PSI for memory can be accounted
> >> during a) That folio is being reclaimed and b) Refault of that folio.
> >>
> > Please help me understand why PSI for memory (I understood it as the 
> > time spent in psi_memstall_enter() to psi_memstall_leave()) would be
> > accounted in (a) i.e during reclaim. I understand that when a working
> > 
> > The (b) part is very clear.
> > 
> I meant to say, for usual reclaim, PSI is accounted on a folio for both
> reclaim and as well during the refault operation when Workingset is set
> on a folio i.e., both a) and b) cases above.
> 

Got it.

> >> This accounting of PSI for memory is not consistent in the cases where
> >> clients use madvise(COLD/PAGEOUT) to deactivate or proactively reclaim a
> >> folio:
> 
> Seems I need to be explicit here. How about the below?
> 
> This accounting of PSI for memory is not consistent for reclaim +
> refault operation between usual reclaim and madvise(COLD/PAGEOUT) which
> deactivate or proactively reclaim a folio:
> 

Looks good.

> lmk for any better rephrasing?
> >> a) A folio started at inactive and moved to active as part of accesses.
> >> Workingset is absent on the folio thus madvise(MADV_PAGEOUT) don't
> >> account such folios for PSI.
> >>
> >> b) When the same folio transition from inactive->active and then to
> >> inactive through shrink_active_list(). Workingset is set on the folio
> >> thus madvise(MADV_PAGEOUT) account such folios for PSI.
> >>
> >> c) When the same folio is part of active list directly as a result of
> >> folio refault and this was a workingset folio prior to eviction.
> >> Workingset is set on the folio thus both the operations of MADV_PAGEOUT
> >> and reclaim of the MADV_COLD operated folio account for PSI.
> >>
> >> d) madvise(MADV_COLD) transfers the folio from active list to inactive
> >> list. Such folios may not have the Workingset thus reclaim operation
> >> on such folio doesn't account for PSI.
> > This is not limited to madvise(PAGEOUT) right, anywhere an active page
> > is reclaimed we have the same problem. For ex: damon_pa_pageout() and
> > __alloc_contig_migrate_range()->reclaim_clean_pages_from_list().
> >> If that is the case, can we set mark a folio as a workingset when it is
> > activated? That way, we don't have make madvise() as a special case?
> I think marking the folio as a workingset when it sits on the active is
> not a correct thing. For the same example you mentioned, a simple CMA
> allocation will be dropping the clean pages instead of migration. PSI
> accounting on refault of those pages don't reveal anything to the user.
> 

Agreed. Thanks for the clarification.

> Where as in the madvise() cases, this PSI tells the user about the type
> of pages that he is working on.[1]
> 
> BTW, damon_pa_pageout() seems a valid case above. let me fix it in the
> next patch.

Looks good.

Thanks,
Pavan
