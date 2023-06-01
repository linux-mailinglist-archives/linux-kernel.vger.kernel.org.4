Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE90719CF5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjFANIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjFANIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:08:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6458134
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 06:08:07 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351B76ot005631;
        Thu, 1 Jun 2023 13:07:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fQe9MehXV0ulPXCHX/rX7G2MaM1cOz0o68h7fshOjbo=;
 b=crvucs/Z8eopExN8l9OkmdiVejZTExmfwOGL5Cf2Ukvd6HNjJmxiUstNKLmtfR6XA7Km
 nIGLXGz5bk04j57Xvs9cHdDvS9ws4meqCRUGz6oNgynmu8lmumPuLcrY/PVtL1by7Two
 IqbFfQ3tsxTaIm/xGJM87T7IjQkGoIwYOB1KJO3ZaIO3G+/tI+o9LzgMxJ0JdFCVU39H
 xdlv/NPawYH3aSB4f8ixtt1IlZW5v8dkR/4yWDImgzv1bru4c0SDqWTFGP8ERkz6Wtvs
 yKgUqZdAhkadJp+pDYmRMHrA10s9VLLO7b/BRanPMm1iZ5xmBvOmTvIbXCD6iJ3uaQ2B dw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxqyd8qpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 13:07:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 351D7uXa001793
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jun 2023 13:07:56 GMT
Received: from [10.50.22.21] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 1 Jun 2023
 06:07:54 -0700
Message-ID: <230e45e8-8cd8-3668-bbfa-a95212b4cb99@quicinc.com>
Date:   Thu, 1 Jun 2023 18:37:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] mm: madvise: fix uneven accounting of psi
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     <akpm@linux-foundation.org>, <minchan@kernel.org>,
        <quic_pkondeti@quicinc.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
References: <1685531374-6091-1-git-send-email-quic_charante@quicinc.com>
 <20230531221955.GD102494@cmpxchg.org>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <20230531221955.GD102494@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NJkcenynQeXaDPvryPhOSJdjvvamnHaF
X-Proofpoint-GUID: NJkcenynQeXaDPvryPhOSJdjvvamnHaF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=773 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2306010115
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Johannes for taking a look at it..

On 6/1/2023 3:49 AM, Johannes Weiner wrote:
> On Wed, May 31, 2023 at 04:39:34PM +0530, Charan Teja Kalla wrote:
>> This patch is tested on Android, Snapdragon SoC with 8Gb RAM, 4GB swap
>> mounted on zram which has 2GB of backingdev. The test case involved
>> launching some memory hungry apps in an order and do the proactive
>> reclaim for the app that went to background using madvise(MADV_PAGEOUT).
>> We are seeing ~40% less total values of psi mem some and full when this
>> patch is combined with [1].
> Does that mean those pages are thrashing, but because you clear their
> workingset it isn't detected and reported via psi?
> 

Seems I didn't mention the usecase clearly and let me correct it. Say we
have the Android apps A, B, C, ... H and launching of these apps goes
like below.

1) Launch app A.
2) Launch app B.
3) Launch app C. At this time, we consider the memory used by app A is
no more in active use thus proactively reclaim them where we do issue
MADV_PAGEOUT on anon regions only thus these pages goes to swap mounted
on zram and subsequently into the backing dev attached to the zram.
4) Launch app D.. Proactively reclaim the anon regions of App B into
swap and through to backing dev.
5) Now make the app A to foreground. This can read the pages from the
swap + backing dev (because of the step 3)) that belongs to app A and
also proactively reclaim anon regions of app C.
6) Launch E --> proactive reclaim of app D to zram swap + backing dev.
7) Make App B to foreground --> Read memory of app B from swap +
backingdev and as well reclaim the anon regions of app A.
8) Like wise launches of apps F, C, G, D, H, E .....

If we look at steps 5, 7,..., we are just making the apps foreground
which folios (if were marked as workingset) can contribute to PSI events
through swap_readpage(). But in reality, these are not the real
workingset folios (I think it is safe to say this), because it is the
user who decided the reclaim of these pages by issuing the MADV_PAGEOUT
which he knows that these are not going to be needed in the near future
thus reclaim them.

I think the other way to look at the problem is the user can write a
simple application where he can do  MADV_PAGEOUT and read them back in a
loop. If at any point, folios user working on turns out to be a
workingset( he can just be probabilistic here), the PSI events will be
triggered though there may not be real memory pressure in the system.


> I don't rally get why silencing the thrashing is an improvement.
> 
Agree that we shouldn't be really silence the thrashing. My point is we
shouldn't be  considering the folios as thrashing If those were getting
reclaim by the user him self through MADV_PAGEOUT under the assumption
that __user knows they are not real working set__.  Please let me know
if I am not making sense here.

>> [1]https://lore.kernel.org/all/20220214214921.419687-1-hannes@cmpxchg.org/T/#u
>>
>> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
