Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D678873E22A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 16:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjFZObp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 10:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFZObn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:31:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2E510C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:31:42 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35QCVxPv024164;
        Mon, 26 Jun 2023 14:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EPBgG7RePFl33JUP0Sp09a5Cq4hKOg3JaOTgQmLXP44=;
 b=EsJFqPI9kARvLQYfcvNC+tLFTwQ4Hh4j+wN9CNebuWO8vOhjqAzpNXPxcsX3mur029sC
 6/fc83T0PB94NJodGUaMnAmNh6pBmxyDrvLJh+/maARGuGcL0h4oKOVxLzQI4hhGIr53
 U4IMoG9zIi4o55/Ccb771dAOeht1ETZftNXhNtO1g56oUOV2AW0of4JN9X+tVXEL0OFT
 3sh1kQsi//Vl6Kf3rAUjSfkbWPxfoYwg7zY9SdX+HdRqnP0tID4W8szr5SYiz+CzVt+r
 fM+HTxW/qq5972srbuNAuayvNw9MrHxplz0RbLI1c7nfv/1NpNrhaiMI52n/vDJUr34N KA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rfart88hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 14:31:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35QEVTFK015488
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 14:31:29 GMT
Received: from [10.214.66.119] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 26 Jun
 2023 07:31:26 -0700
Message-ID: <70743150-dc85-1a1a-87ec-e3dd9f72c5d0@quicinc.com>
Date:   Mon, 26 Jun 2023 20:01:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] mm: madvise: fix uneven accounting of psi
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>, <akpm@linux-foundation.org>,
        <minchan@kernel.org>, <quic_pkondeti@quicinc.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <1685531374-6091-1-git-send-email-quic_charante@quicinc.com>
 <20230531221955.GD102494@cmpxchg.org>
 <230e45e8-8cd8-3668-bbfa-a95212b4cb99@quicinc.com>
 <20230605180013.GD221380@cmpxchg.org>
 <f3f15b6a-8618-f755-f21c-4193c502e65c@quicinc.com>
 <CAJuCfpFB33GLbwvYspg966b6AGMopS3ca68hjL94kgpM7et7CQ@mail.gmail.com>
 <4543c4e5-43f1-bae2-245e-951437e4bd07@quicinc.com>
 <CAJuCfpE42OJZur-1u2hvvXmPkRdV1uOfK-Aqm2POmvrDpRwg0Q@mail.gmail.com>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <CAJuCfpE42OJZur-1u2hvvXmPkRdV1uOfK-Aqm2POmvrDpRwg0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rYb3HqzQqoMwNIR0IvxMYEqb-zvBTMxD
X-Proofpoint-ORIG-GUID: rYb3HqzQqoMwNIR0IvxMYEqb-zvBTMxD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_11,2023-06-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=472 clxscore=1015
 bulkscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260130
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suren,

On 6/10/2023 4:43 AM, Suren Baghdasaryan wrote:
>>> I can see use for that from userspace to detect incorrect madvise()
>>> and adjust its aggressiveness. I think the API might get a bit complex
>>> because of the need to associate refaults with specific madvise()/VMAs
>>> to understand which hint was incorrect and adjust the behavior.
>>> Instead what is the opinion about giving an MADV_PAGEOUT_INACTIVE
>> interface which does operate on a page only If it is on the inactive
>> list and !PageWorkingset ?
> IOW you want a less aggressive mechanism which can be used by the
> userspace to tell the kernel "I think these pages won't be used but
> I'm not 100% sure, so drop them only if they are inactive"?
>  I don't know how much that will help when the madvise() ends up being
> wrong but maybe you can quickly experiment and tell us if the
> difference is substantial?

We did some extensive testing on Android and this ask is not helping us
much. I am really not sure if there is some other usecase that can
benefit from this. So, for now I just stick to your suggestion of making
the pages on the Active list as the Workingset at the time of pageout.
>

Thanks.

