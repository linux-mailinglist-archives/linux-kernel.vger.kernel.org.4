Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305246DC773
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 15:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjDJNws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 09:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjDJNwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 09:52:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50E749ED
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 06:52:45 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33AAW4tr003065;
        Mon, 10 Apr 2023 13:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LV+H2q/aKt1vPhFe9/snJkWsks6f2YrY0QhTskhacO8=;
 b=ZQABern0eDac+M0yGkPXTczJBKQLHKKdNfChVymFjIiYBqWzpHOSdWyM3tHlmLGfZ8H3
 ZKGIOUVcMsaq3WOt3rO7/+qgDx6mOixsswRLmRrAmaNWQulfLOIaRE46WbvC+KH7Bawg
 gbMlU+rXapRyo8woknZLFofA7oGUDhlWcSBidL92CaZ5nuyMg4RIpQ0NaEgOEt+b9Lgm
 NHa807JKSvgzjH+9gfwe2071CTgt2hlF7iRP84Lilrgt9lB/XhXPuT//QJi0lah2rnFW
 W2HYfkzubofyiuOcSf8LXxF3aOSjFljXIVlKwxGeDrP0j45S0X3tsDPjHJcleeIWSMZ5 AA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pu0nek3br-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 13:52:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33ADqTcS004226
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 13:52:29 GMT
Received: from [10.216.51.131] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 10 Apr
 2023 06:52:25 -0700
Message-ID: <8ba3f700-19a6-e7fd-c51f-cd277ff7a439@quicinc.com>
Date:   Mon, 10 Apr 2023 19:22:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V7 2/2] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED
 for shmem
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>
CC:     <akpm@linux-foundation.org>, <hughd@google.com>,
        <willy@infradead.org>, <markhemm@googlemail.com>,
        <rientjes@google.com>, <surenb@google.com>, <shakeelb@google.com>,
        <quic_pkondeti@quicinc.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <cover.1676378702.git.quic_charante@quicinc.com>
 <631e42b6dffdcc4b4b24f5be715c37f78bf903db.1676378702.git.quic_charante@quicinc.com>
 <ZC9ZYAp8a46dILdO@google.com>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <ZC9ZYAp8a46dILdO@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GsKZKU1VOCfmneiis8sHCcPuJC0Rq_Rk
X-Proofpoint-ORIG-GUID: GsKZKU1VOCfmneiis8sHCcPuJC0Rq_Rk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_09,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 clxscore=1011
 malwarescore=0 suspectscore=0 priorityscore=1501 adultscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304100117
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Minchan for the review!!

On 4/7/2023 5:14 AM, Minchan Kim wrote:
> On Tue, Feb 14, 2023 at 06:21:50PM +0530, Charan Teja Kalla wrote:
>> Currently fadvise(2) is supported only for the files that doesn't
>> associated with noop_backing_dev_info thus for the files, like shmem,
>> fadvise results into NOP. But then there is file_operations->fadvise()
>> that lets the file systems to implement their own fadvise
>> implementation. Use this support to implement some of the POSIX_FADV_XXX
>> functionality for shmem files.
>>
>> This patch aims to implement POSIX_FADV_WILLNEED and POSIX_FADV_DONTNEED
>> advices to shmem files which can be helpful for the clients who may want
>> to manage the shmem pages of the files that are created through
>> shmem_file_setup[_with_mnt](). One usecase is implemented on the
>> Snapdragon SoC's running Android where the graphics client is allocating
>> lot of shmem pages per process and pinning them. When this process is
>> put to background, the instantaneous reclaim is performed on those shmem
>> pages using the logic implemented downstream[3][4]. With this patch, the
>> client can now issue the fadvise calls on the shmem files that does the
>> instantaneous reclaim which can aid the use cases like mentioned above.
>>
>> This usecase lead to ~2% reduction in average launch latencies of the
>> apps and 10% in total number of kills by the low memory killer running
>> on Android.
>>
>> Some questions asked while reviewing this patch:
>> Q) Can the same thing be achieved with FD mapped to user and use
>> madvise?
>> A) All drivers are not mapping all the shmem fd's to user space and want
>> to manage them with in the kernel. Ex: shmem memory can be mapped to the
>> other subsystems and they fill in the data and then give it to other
>> subsystem for further processing, where, the user mapping is not at all
>> required.  A simple example, memory that is given for gpu subsystem
>> which can be filled directly and give to display subsystem. And the
>> respective drivers know well about when to keep that memory in ram or
>> swap based on may be a user activity.
>>
>> Q) Should we add the documentation section in Manual pages?
>> A) The man[1] pages for the fadvise() whatever says is also applicable
>> for shmem files. so couldn't feel it correct to add specific to shmem
>> files separately.
>>
>> Q) The proposed semantics of POSIX_FADV_DONTNEED is actually similar to
>> MADV_PAGEOUT and different from MADV_DONTNEED. This is a user facing API
>> and this difference will cause confusion?
>> A) man pages [2] says that "POSIX_FADV_DONTNEED attempts to free cached
>> pages associated with the specified region." This means on issuing this
>> FADV, it is expected to free the file cache pages. And it is
>> implementation defined If the dirty pages may be attempted to writeback.
>> And the unwritten dirty pages will not be freed. So, FADV_DONTNEED also
>> covers the semantics of MADV_PAGEOUT for file pages and there is no
>> purpose of PAGEOUT for file pages.
>>
>> [1] https://linux.die.net/man/2/fadvise
>> [2] https://man7.org/linux/man-pages/man2/posix_fadvise.2.html
>> [3] https://git.codelinaro.org/clo/la/platform/vendor/qcom/opensource/graphics-kernel/-/blob/gfx-kernel.lnx.1.0.r3-rel/kgsl_reclaim.c#L289
>> [4] https://android.googlesource.com/kernel/common/+/refs/heads/android12-5.10/mm/shmem.c#4310
>>
>> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
> 
> I am not familar with why the shmem has noop_backing_dev_info
> but the below code to reclaim shmem pages and POXIS_FADV_DONTNEED
> semantic looks correct for me.
> 
Thanks!!
> Only nit is the description covers mostly DONTNEED case but not
> WILLNEED case.Okay. How about adding the below to the end of the 2nd paragraph of the
commit message:
Application that does require the reclaimed pages, say when the app put
to foreground, can issue the POSIX_FADV_WILLNEED to bring back them from
the swap area. Alternatively the drivers can also use
shmem_read_mapping_page_gfp() to bring back the reclaimed shmem pages.

@Andrew: I am not sure If this update to commit message requires respin
of the patchset. Please let me know If it required so.

Thanks,
Charan
