Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B894E6E2A7F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 21:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjDNTKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 15:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjDNTKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 15:10:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5626B45E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 12:10:40 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EJ1qBC005954;
        Fri, 14 Apr 2023 19:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UNe3B2DRPlpiQBM7MT6ze0rZg1VfylbK5urVwiDLjD8=;
 b=aoRu/tV/oeYPLz1E2HUeZVZfF2iRv2LN+pDbjrxOb9hl1pIp5+nPwtYSKAtMW56TuvFE
 p2XHhz8oiwLB35qgFtWs9ZnIf9tMVTQZeT/AZv5JZu24oUGttZVCKKVitWhmPrZD7DxE
 xyNOxR6nXzCllIvy5mh0mK0W6n+pm4kOspl0Ew8uk8RM++KgIkInFaI3bsLBNv460n+9
 /98cpJLDCemqqQKyva1DFMriJ9V/UkoHHT/lBU/PgeSo7jtid+TGW68y0sE5Rb8VYeic
 Oz4j7zeUh7Awg5UaeBgESsil42SThAT5OPQnouJX3BpVYu+k5iFIBSIf9EM8xqqmp1PF 9A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3py1kx1hs2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 19:10:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33EJAQTZ031515
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 19:10:26 GMT
Received: from [10.216.16.3] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 14 Apr
 2023 12:10:22 -0700
Message-ID: <0853b4b0-770f-f742-95bc-eb74a1859138@quicinc.com>
Date:   Sat, 15 Apr 2023 00:40:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V7 0/2] mm: shmem: support POSIX_FADV_[WILL|DONT]NEED for
 shmem files
Content-Language: en-US
To:     Frank van der Linden <fvdl@google.com>
CC:     <akpm@linux-foundation.org>, <hughd@google.com>,
        <willy@infradead.org>, <markhemm@googlemail.com>,
        <rientjes@google.com>, <surenb@google.com>, <shakeelb@google.com>,
        <quic_pkondeti@quicinc.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <cover.1676378702.git.quic_charante@quicinc.com>
 <CAPTztWYgRORXKp83Spm3DX8qJsi1rw5s=WbPcjUYfOxFXxRAwg@mail.gmail.com>
 <CAPTztWadceJtPUrSab1Tj2WV=uAhLo+CrxqyeSQ8rLn0FtM_zA@mail.gmail.com>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <CAPTztWadceJtPUrSab1Tj2WV=uAhLo+CrxqyeSQ8rLn0FtM_zA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6irWvQUSKZKeJgaEOgnacy9j4a8avZEw
X-Proofpoint-GUID: 6irWvQUSKZKeJgaEOgnacy9j4a8avZEw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_11,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=506 spamscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140169
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Frank!!

On 4/14/2023 11:14 PM, Frank van der Linden wrote:
>> I didn't see this patch before, so I looked a bit at the history. At
>> some point, in v3, dealing with mapped pages for DONTNEED was left
>> out, they are now skipped. Unfortunately, that makes this patch no
>> longer usable for a case that we have: restoring the (approximate)
>> swap state of a tmpfs file. This involves walking a potentially large
>> number of regions, and explicitly pushing them out to swap. This can
>> be used to e.g. restore the state VM memory that is backed by a tmpfs
>> file, avoiding memory usage by cold VM pages after resume.
>>

This is an interesting use case and I feel this really supports this
patchset. IIUC, supporting the reclaim of mapped file pages through
fadvise() helps this usecase where you can avoid traversing the large
number of vma regions as you can directly issue the fadvise() on the
shmem file 'fd' and it takes care. Am I correct?

> Hmm, actually, looking at it a bit more, there are several issues
> here. One is that with fadvise, you can't be sure if you are the only
> one dealing with the page in a mapped way(with madvise, if mapcount ==
> 1, that mean's it's just you, but you don't know that for fadvise, so
> that makes correctly dealing with mapped pages harder).
> 
Sorry, Why not for fadvise()? I can still attempt only if the page is
mapped and its mapcount == 1, but then we already have madvise() for
such pages and why not we simply use it.

> Also, the madvise loop issue can probably also be dealt with via io_uring.
> 
> So, I think we can deal with the use case I mentioned in a different
> way, that is mostly unrelated to this patchset, so basically:
> disregard my previous email.
Sure! If this patch looks good for you, Reviewed/Ack tags can help me..

Thanks,
Charan
