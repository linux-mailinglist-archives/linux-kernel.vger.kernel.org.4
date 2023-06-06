Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1287246F5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238463AbjFFOzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238293AbjFFOyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:54:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7721126
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:54:43 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356Di4Fv006096;
        Tue, 6 Jun 2023 14:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=A/le5QaJ2HXc6uYzrLXXDNR+EfT5m6CcKSMIX/TDeno=;
 b=m50DKcXKRhhv0s/gXINyoXC6c67ZVDUWC+1HmXWSBYSvwkLLstLHFdQeoXQthJE/1+/X
 GPbuiTdEVna07LVhKYdLUbzEhtMvBTK+FNJt5OIu9GD2aB7MxZ4wY9lVPZYnPFbqboJs
 5gpFIpIfrmBoIsv39sC127cKgh5B/rk5m7w8M2wTMXl9FSiP4WqhDHQ5B7zV09RPg1Qe
 kwm+qhFRUB1iNdYnKpqpvwdYluJTiVKqwnErvVDcct1H/YZ6mjPdtOLGS2QGKT9KYOHs
 RrVkx/az098npEecgQA8HG4PP8zIFI2J1Kfr23bm0/5j3qm02FcQBURnd730HfoQvVf+ PQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r20m8rvmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 14:54:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 356EsXlm025065
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Jun 2023 14:54:33 GMT
Received: from [10.216.38.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 6 Jun 2023
 07:54:31 -0700
Message-ID: <f3f15b6a-8618-f755-f21c-4193c502e65c@quicinc.com>
Date:   Tue, 6 Jun 2023 20:23:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] mm: madvise: fix uneven accounting of psi
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     <akpm@linux-foundation.org>, <minchan@kernel.org>,
        <quic_pkondeti@quicinc.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
References: <1685531374-6091-1-git-send-email-quic_charante@quicinc.com>
 <20230531221955.GD102494@cmpxchg.org>
 <230e45e8-8cd8-3668-bbfa-a95212b4cb99@quicinc.com>
 <20230605180013.GD221380@cmpxchg.org>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <20230605180013.GD221380@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mpn9XIbRJ6sUrgOSa-x2MjJjRP_Ga5kp
X-Proofpoint-ORIG-GUID: mpn9XIbRJ6sUrgOSa-x2MjJjRP_Ga5kp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_10,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxlogscore=370 clxscore=1011 bulkscore=0 lowpriorityscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306060126
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Johannes for the detailed review comments...

On 6/5/2023 11:30 PM, Johannes Weiner wrote:
>> Agree that we shouldn't be really silence the thrashing. My point is we
>> shouldn't be  considering the folios as thrashing If those were getting
>> reclaim by the user him self through MADV_PAGEOUT under the assumption
>> that __user knows they are not real working set__.  Please let me know
>> if I am not making sense here.
> I'm not sure I agree with this. I think it misses the point of what
> the madvise is actually for.
> 
> The workingset is defined based on access frequency and available
> memory. Thrashing is defined as having to read pages back shortly
> after their eviction.
> 
> MADV_PAGEOUT is for the application to inform the kernel that it's
> done accessing the pages, so that the kernel can accelerate their
> eviction over other pages that may still be in use. This is ultimately
> meant to REDUCE reclaim and paging.
> 
> However, in this case, the MADVISE_PAGEOUT evicts pages that are
> reused after and then refault. It INCREASED reclaim and paging.
> 
I agree here...
> Surely that's a problem? And the system would have behaved better
> without the madvise() in the first place?
> 
Yes, the system behavior could be much better without this PAGEOUT
operation...
> In fact, I would argue that the pressure spike is a great signal for
> detecting overzealous madvising. If you're redefining the workingset
> from access frequency to "whatever the user is saying", that will take
> away an important mechanism to detect advise bugs and unnecessary IO.
currently wanted to do the PAGEOUT operation but what information lacks
is if I am really operating on the workingset pages. Had the client
knows that he is operating on the workingset pages, he could have backed
off from madvising.

I now note that I shouldn't be defining the workingset from "whatever
user is saying". But then, IMO, there should be a way from the kernel to
the user that his madvise operation is being performed on the workingset
pages.

One way the user can do is monitoring the PSI events while PAGEOUT is
being performed and he may exclude those VMA's from next time.

Alternatively kernel itself can support it may be through like
MADV_PAGEOUT_INACTIVE which doesn't pageout the Workingset pages.

Please let me know your opinion about this interface.

This has the usecase on android where it just assumes that 2nd
background app will most likely to be not used in the future thus
reclaim those app pages. It works well for most of the times but such
assumption will go wrong with the usecase I had mentioned.

--Thanks.
