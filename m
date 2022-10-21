Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5CC606E4E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 05:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiJUD0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 23:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiJUD0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 23:26:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366651EA557
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 20:26:42 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29L3O57M022345;
        Fri, 21 Oct 2022 03:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=f3AP5kqyIwg0Bv2zrCocVKvk3NIrgaKA+HTSGhNavN0=;
 b=H5JjmPTH4bqA1lKTsNgu06G2vD2toCwuFUQdyP6lDfj3BJyFIUFksOnvQr7WDzF/veph
 7I9unrMnvl0/yQl+EnV2UxJi3v5xBIys5nqlynajY52PjixChubdC8gcblhX1SLsusqk
 kwrDltkOpeTcK7PA55OcnYVZPva0PvDZp6iB27iH5NvLk9k9iR07dBimrCWBdRZIWUbf
 C1XNUo4bNaIe9IseLAbpuE8i3z0SZbxKmF3JElRNZbz4knPmfM66hVaxTaDiFFv4f8H1
 zhivWeeVq/xCuKlcn6H29fH2O4n83ZTk98FsinNvwYwb8Xy8Lkay1V6OejrdymouqLVr rg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kak1c48nj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 03:26:29 +0000
Received: from pps.filterd (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 29L3QS35007486;
        Fri, 21 Oct 2022 03:26:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTPS id 3kbk4004b4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 03:26:28 +0000
Received: from NASANPPMTA04.qualcomm.com (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29L3QSkt007480;
        Fri, 21 Oct 2022 03:26:28 GMT
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTPS id 29L3QSnw007478
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 03:26:28 +0000
Received: from [10.239.133.73] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 20 Oct
 2022 20:26:26 -0700
Message-ID: <23081249-229b-b745-50f5-53e394b623c9@quicinc.com>
Date:   Fri, 21 Oct 2022 11:26:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] mm/page_isolation: fix clang deadcode warning
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <ziy@nvidia.com>, <david@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <mike.kravetz@oracle.com>, <opendmb@gmail.com>
References: <20221021030953.34925-1-quic_aiquny@quicinc.com>
 <Y1IPqhVpiehRBGNS@casper.infradead.org>
From:   "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
In-Reply-To: <Y1IPqhVpiehRBGNS@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: y-L6IDjjMTL25isIJZjQS4pvsxeUkVZ3
X-Proofpoint-ORIG-GUID: y-L6IDjjMTL25isIJZjQS4pvsxeUkVZ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_13,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=776 priorityscore=1501 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210210018
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/2022 11:19 AM, Matthew Wilcox wrote:
> On Fri, Oct 21, 2022 at 11:09:53AM +0800, Maria Yu wrote:
>> When !CONFIG_VM_BUG_ON, there is warning of
>> clang-analyzer-deadcode.DeadStores:
>> Value stored to 'mt' during its initialization
>> is never read.
> 
> Honestly, the cure is worse than the disease.  I'd rather not have a
> line that's this long.
I don't like this long either. While the current Deadcode warning is 
also annoying for our clang tidy check.

will the CONFIG check can be acceptable?
like:
	#ifdef CONFIG_DEBUG_VM
or
	if (IS_ENABLED(CONFIG_DEBUG_VM))

Any good ideas?

> >> -		int mt = get_pageblock_migratetype(pfn_to_page(isolate_pageblock));
>> -
>> -		VM_BUG_ON(!is_migrate_isolate(mt));
>> +		VM_BUG_ON(!is_migrate_isolate(get_pageblock_migratetype(pfn_to_page(isolate_pageblock))));


-- 
Thx and BRs,
Aiqun(Maria) Yu
