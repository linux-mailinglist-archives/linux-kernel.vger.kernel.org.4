Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4647081AD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 14:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjERMqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 08:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjERMqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 08:46:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E806C9
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 05:46:52 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34ICQfbU021905;
        Thu, 18 May 2023 12:46:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7B0Wi+x/9/t51/d3MOElUht9OWrjqjL8o0y56mjT0L0=;
 b=Arxzreo1KltSETP2xl7mXtDAkKYiGSErf3XT3A273itHeqtD7dnBb6jOiGoYbkmZ+hkJ
 lpqhD8507QmLPPR2F+fplB9mMxW596Q67dh5Wd5nP2BRADHhsUQf7wYtNFLO1P4+EERt
 wVGutobO95mpVmFd4x0hQd+KhC9H63ce9pMi2DH4voK1OSeBm3cAshNI/Q0KHXrnzcEF
 4S0xwYb/oKbgpgVXjRlqBh+c5ZcCMPVzbTbeYNSBq/MpojCWx+UpVgjNk6AZ0A+XgIy1
 hY3iCDKD9J1v+XOZ6MJQORTefzg5hc37mC0Vgtbhp1XqO4XkF+NmVYMWytRQzwctozIw Dg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qn8d2hapa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 12:46:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34ICkdXF024419
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 12:46:39 GMT
Received: from [10.216.38.166] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 18 May
 2023 05:46:29 -0700
Message-ID: <e8e85d7d-edf1-7a8b-8cfe-9976dd9cfb0b@quicinc.com>
Date:   Thu, 18 May 2023 18:16:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V7 2/2] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED
 for shmem
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>
CC:     <akpm@linux-foundation.org>, <willy@infradead.org>,
        <markhemm@googlemail.com>, <rientjes@google.com>,
        <surenb@google.com>, <shakeelb@google.com>, <fvdl@google.com>,
        <quic_pkondeti@quicinc.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <cover.1676378702.git.quic_charante@quicinc.com>
 <631e42b6dffdcc4b4b24f5be715c37f78bf903db.1676378702.git.quic_charante@quicinc.com>
 <2d56e1dd-68b5-c99e-522f-f8dadf6ad69e@google.com>
 <eeeba374-9247-96fd-c9f5-8cba8761f1b9@quicinc.com>
 <aa4352d8-a549-32e5-874f-1cfee2a5b3e@google.com>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <aa4352d8-a549-32e5-874f-1cfee2a5b3e@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wfrWaWblBL9eRR0HJ4EnJFi6l0XjIFcE
X-Proofpoint-GUID: wfrWaWblBL9eRR0HJ4EnJFi6l0XjIFcE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_09,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 mlxlogscore=551 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180101
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh, Thanks for the time and comments on this patch.

On 5/17/2023 5:02 PM, Hugh Dickins wrote:
>> Sure, will include those range calculations for shmem pages too.
> Oh, I forgot this issue, you would have liked me to look at V8 by now,
> to see whether I agree with your resolution there.  Sorry, no, I've
> not been able to divert my concentration to it yet.
> 
> And it's quite likely that I shall disagree, because I've a history of
> disagreeing even with myself on such range widening/narrowing issues -
> reconciling conflicting precedents is difficult :(
> 
If you can at least help by commenting which part of the patch you
disagree with, I can try hard to convince you there:) .

>> Please let me know if I'm missing something where I should be counting
>> these as NR_ISOLATED.
> Please grep for NR_ISOLATED, to see where and how they get manipulated
> already, and follow the existing examples.  The case that sticks in my
> mind is in mm/mempolicy.c, where the migrate_pages() syscall can build
> up a gigantic quantity of transiently isolated pages: your syscall can
> do the same, so should account for itself in the same way.

I had a V8 posted without this into accounting. Let me make the changes
to account for the NR_ISOLATED too.
> 
> I'm not claiming that mm/vmscan.c's too_many_isolated(), and the way it
> gets used by shrink_inactive_list(), is perfect: not at all.  But please
> follow existing convention.
> 
> Sorry, that's all for now.
