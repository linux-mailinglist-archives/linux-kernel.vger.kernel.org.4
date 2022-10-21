Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB75606F56
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 07:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiJUFVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 01:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiJUFVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 01:21:19 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F181318A51D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 22:21:18 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29L5BQRQ022741;
        Fri, 21 Oct 2022 05:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=F1JU8DgZhdRviFNon2v1H+hd/T/JlQsTU4BcssEfx54=;
 b=ZFnEJtoBjKUoPXg4wrAmvlIht5KXC+5eSRwXShFMm65DmJ5rC7Ta6pQFbJgptZsVRqK3
 CN5ocqTJ9t1numdrmQ9+Yg433xnBPU6keEWc8/JL1unQBsvNBIkthtcL3UVyEv8Ehkpn
 H/CVqizg885wxSfK/co8xo1mj/6L+N0Xfas3EzuhvYeA6PyROSKejMSd24sTAPnnDN5T
 ZUfNIbIzpuaRyhIWiUkkPeCDLVEWRtf19bt7JdrJmjrIZGKIPUwwVJmQRyyPi0S40xDp
 +KoTODQdiZgtV6sn/580Gg3m0iYByoLd65FcgrezNbaGjwpKtmBg919IxiFRkd4B2BAi Sw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kbd8ah4ae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 05:21:08 +0000
Received: from pps.filterd (NASANPPMTA02.qualcomm.com [127.0.0.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 29L5Ic9s020508;
        Fri, 21 Oct 2022 05:21:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA02.qualcomm.com (PPS) with ESMTPS id 3kb04kqrd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 05:21:07 +0000
Received: from NASANPPMTA02.qualcomm.com (NASANPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29L5DQkC012821;
        Fri, 21 Oct 2022 05:21:07 GMT
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (PPS) with ESMTPS id 29L5L7SV023472
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 05:21:07 +0000
Received: from [10.239.133.73] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 20 Oct
 2022 22:21:05 -0700
Message-ID: <b6ea49a8-2ad2-1a80-a6f6-fe2d9b30f5b6@quicinc.com>
Date:   Fri, 21 Oct 2022 13:21:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] mm/page_isolation: fix clang deadcode warning
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Matthew Wilcox <willy@infradead.org>, <ziy@nvidia.com>,
        <david@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <mike.kravetz@oracle.com>,
        <opendmb@gmail.com>
References: <20221021030953.34925-1-quic_aiquny@quicinc.com>
 <Y1IPqhVpiehRBGNS@casper.infradead.org>
 <23081249-229b-b745-50f5-53e394b623c9@quicinc.com>
 <20221020211733.31b2ee4f81805186367304b0@linux-foundation.org>
From:   "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
In-Reply-To: <20221020211733.31b2ee4f81805186367304b0@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AxiXCeHQmjCNMrqtTVXzu_buFsTgkAGz
X-Proofpoint-GUID: AxiXCeHQmjCNMrqtTVXzu_buFsTgkAGz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_01,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=929 bulkscore=0
 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210210030
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/2022 12:17 PM, Andrew Morton wrote:
> On Fri, 21 Oct 2022 11:26:22 +0800 "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com> wrote:
> 
>>> Honestly, the cure is worse than the disease.  I'd rather not have a
>>> line that's this long.
>> I don't like this long either. While the current Deadcode warning is
>> also annoying for our clang tidy check.
>>
>> will the CONFIG check can be acceptable?
>> like:
>> 	#ifdef CONFIG_DEBUG_VM
>> or
>> 	if (IS_ENABLED(CONFIG_DEBUG_VM))
>>
>> Any good ideas?
> 
> Put a newline in there?
> 
> Although the shortly following lines are nearly as long...
> 
Thx for the suggestion. new patchset uploaded.

-- 
Thx and BRs,
Aiqun(Maria) Yu
