Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1476C679944
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 14:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbjAXN2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 08:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbjAXN2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:28:44 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE56303D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 05:28:43 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ODHYCj001568;
        Tue, 24 Jan 2023 13:28:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=c7ZGu7L3TDPmtexACBh0quDDeNE0C8KFgSr2Sbibx2E=;
 b=jFfZHa5f7Hc6w8CsGzaNlZD1aULcoWTjl9+G2dIpOU+6oVFmBtpsRzD7ghQp9YOki7Qc
 zIV1pW1keIcWqWLsFQ8hqzImZXDF2TrMXnNnrva7CkYVunGGgZGlwh8cT+zqDZ6fxh50
 WPFSRCuOOjGo8zi3QDf4/g2oGmPwqe3ffRc5w27Z2YuPAuwdr/DIDEVF3TEBAyexi0eE
 SglfEL8oCL+2gtLMbbmuisy+7Wp6JoZzlFWG+ii17NSHf2FeuceqYd7VvsH7R5cb7vp+
 EMMRUgo2MSCgBhM3hDrkygH09Qr0mn7qMr/7UETCEWW2450ewzXxOYFKsoTD+i4lzjHG BQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nag3080g8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 13:28:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30ODSHBZ010043
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 13:28:17 GMT
Received: from [10.214.20.211] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 24 Jan
 2023 05:28:12 -0800
Message-ID: <25765c7a-03bc-dfd3-4d21-804f966dcda9@quicinc.com>
Date:   Tue, 24 Jan 2023 18:58:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH RESEND V5,0/2]mm: shmem: support
 POSIX_FADV_[WILL|DONT]NEED for shmem files
Content-Language: en-US
To:     <akpm@linux-foundation.org>, <willy@infradead.org>,
        <markhemm@googlemail.com>, <hughd@google.com>,
        <rientjes@google.com>, <surenb@google.com>, <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        <noralf@tronnes.org>, Dan Carpenter <dan.carpenter@oracle.com>,
        <daniel.vetter@ffwll.ch>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <cover.1648706231.git.quic_charante@quicinc.com>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <cover.1648706231.git.quic_charante@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: m332iFt23GALSw8gUTUdqsQ00-OnqyFP
X-Proofpoint-GUID: m332iFt23GALSw8gUTUdqsQ00-OnqyFP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1011 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240122
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew and all,

I am trying to comeback and make another attempt to upstream this patch
by providing even more details:

We have the requirement similar to of GEM objects backed by shmem but to
reclaim those pages instantaneously when the user wants it.  And for
file reclaim, users can use POSIX_FADV_DONTNEED to reclaim the pages(as
per standard, the clean pages are dropped but the dirty pages writeback
is implementation defined).  And client uses the POSIX_FADV_WILLNEED
when he needs those pages back.

This requirement is implemented on the snapdragon chips for graphics
clients where buffers of which are allocated through shmem interface(not
mapped to the userspace) and reclaimed[1][2] through a function
implemented in downstream Android kernel. We know that shmem allocation
support is already implemented in the upstream but the instantaneous
reclaim of those pages(which fadvise() can be used for the file pages)
is missed in the upstream implementation. This patch aims to implement
the support of reclaiming the shmem pages through the shmem fadvise but
__currently we are unable to find any upstream users for this usecase
and may be that's why didn't get any active reviews on this patch__.

So this attempt is to equip the linux kernel with "fadvise support for
shmem page reclaim", which might be useful in the future.

If community sees there will be some real benefits with this patch set,
will port these against linux-next. Please provide your inputs.

[1]
https://git.codelinaro.org/clo/la/platform/vendor/qcom/opensource/graphics-kernel/-/blob/gfx-kernel.lnx.1.0.r3-rel/kgsl_reclaim.c#L289
[2]
https://android.googlesource.com/kernel/common/+/refs/heads/android12-5.10/mm/shmem.c#4310

Thanks,
Charan

On 3/31/2022 12:08 PM, Charan Teja Kalla wrote:
> From: Charan Teja Reddy <quic_charante@quicinc.com>
> 
> This patch aims to implement POSIX_FADV_WILLNEED and POSIX_FADV_DONTNEED
> advices to shmem files which can be helpful for the drivers who may want
> to manage the pages of shmem files on their own, like, that are created
> through shmem_file_setup[_with_mnt]().
> 
> Changes in V5:
>  -- Moved the 'endbyte' calculations to a header function for use by shmem_fadvise().
>  -- Addressed comments from suren.
>  -- No changes in resend. Retested on the latest tip.
> 
> Changes in V4:
>   -- Changed the code to use reclaim_pages() to writeout the shmem pages to swap and then reclaim.
>   -- Addressed comments from Mark Hemment and Matthew.
>   -- fadvise() on shmem file may even unmap a page.
>   -- https://patchwork.kernel.org/project/linux-mm/patch/1644572051-24091-1-git-send-email-quic_charante@quicinc.com/
> 
> Changes in V3:
>   -- Considered THP pages while doing FADVISE_[DONT|WILL]NEED, identified by Matthew.
>   -- xarray used properly, as identified by Matthew.
>   -- Excluded mapped pages as it requires unmapping and the man pages of fadvise don't talk about them.
>   -- RESEND: Fixed the compilation issue when CONFIG_TMPFS is not defined.
>   -- https://patchwork.kernel.org/project/linux-mm/patch/1641488717-13865-1-git-send-email-quic_charante@quicinc.com/
> 
> Changes in V2:
>   -- Rearranged the code to not to sleep with rcu_lock while using xas_() functionality.
>   -- Addressed the comments from Suren.
>   -- https://patchwork.kernel.org/project/linux-mm/patch/1638442253-1591-1-git-send-email-quic_charante@quicinc.com/
> 
> changes in V1:
>   -- Created the interface for fadvise(2) to work on shmem files.
>   -- https://patchwork.kernel.org/project/linux-mm/patch/1633701982-22302-1-git-send-email-charante@codeaurora.org/
> 
> Charan Teja Reddy (2):
>   mm: fadvise: move 'endbyte' calculations to helper function
>   mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED for shmem
> 
>  mm/fadvise.c  |  11 +-----
>  mm/internal.h |  21 ++++++++++
>  mm/shmem.c    | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 145 insertions(+), 10 deletions(-)
> 
