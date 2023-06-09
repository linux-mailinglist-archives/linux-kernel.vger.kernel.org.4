Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951A2729A32
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240680AbjFIMmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjFIMmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:42:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B794A1BC6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 05:42:45 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359CLjNd026710;
        Fri, 9 Jun 2023 12:42:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=v50cHrWsFzrYEcC7Kfm2tB78lTfcNiCEuWOx1AzPGm0=;
 b=Ym3r6pdxyV/Bl8YvoFRG8/m1KKvm7oiVZ3GJRcI7JheBMQ4Zjm+rZTBW39FearAaHwG5
 +HrgHIXXTVAagHaSGQaESUDsuDSSLLzaeeDbJNkNGXL7jfIjHnS4DDwRkMeaOl5gFELF
 aqowr+5Q4yoH1/U4gy4OxQt6mAPOqykIsF3jUByqAfwBErrwcVwMNAdyLOiaouyX9EVD
 E9C2QnAav5ztsKlJrLfV1SMU25yZh7yDssLXwa13y2Y+jYk59PWDhZxCE7xBhJK3Ef4o
 8BfGiSZFpqf91NwKaWgFBvjOO+u2ux73me9f8F3n40T7jTfdesKXR5q7J0ySx/cTYkZu 9A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r43d4838b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 12:42:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 359CgZbx013601
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Jun 2023 12:42:35 GMT
Received: from [10.216.18.70] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 9 Jun 2023
 05:42:32 -0700
Message-ID: <4543c4e5-43f1-bae2-245e-951437e4bd07@quicinc.com>
Date:   Fri, 9 Jun 2023 18:12:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] mm: madvise: fix uneven accounting of psi
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
Content-Language: en-US
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <CAJuCfpFB33GLbwvYspg966b6AGMopS3ca68hjL94kgpM7et7CQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NltAhbyisJKtWTR2bHzr2qo1jui5_z7Z
X-Proofpoint-GUID: NltAhbyisJKtWTR2bHzr2qo1jui5_z7Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_08,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=986 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306090107
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Suren & Johannes,

On 6/7/2023 1:18 AM, Suren Baghdasaryan wrote:
> Hi Folks. Sorry for being late to the party.
> Yeah, userspace does not have a crystal ball to predict future user
> behavior, so there will always be pathological cases when usual
> assumptions and resulting madvise() would make things worse.
> 
> I think this discussion can be split into several questions/issues:
> 1. Inconsistency in how madvise(MADV_PAGEOUT) would affect PSI
> calculation when the page is refaulted, based on the path it took
> before being evicted by madvise(). In your initial description case
> (a) is inconsistent with (b) and (c) and it's probably worth fixing.
> IMHO (a) should be made consistent with others, not the other way
> around. My reasoning is that page was expelled from the active list,
> so it was part of the active workingset.
> 
That means we should be setting Workingset on the page while it is on
the active list and when it is being pageout through madvising. Right? I
see, this makes it consistent.

On the same note, discussing with Suren offline, Should the refaulted
madvise pages start always at the inactive list? If they are really
active, they get promoted anyway..

> 2. Whether refaults caused by incorrect madvise(MADV_PAGEOUT) should
> be counted as workingset refault and affect PSI.
> This one I think is trickier. IMHO it should be counted as workingset
> refault simply because it was refaulted and it was part of the
> workingset. Whether it should affect PSI, which is supposed to be an
> indicator of "pressure" is, I think, debatable. With madvise() in the
> mix, refault might happen without any real memory pressure... So, the
> answer is not obvious to me.
> 
> 3. Should refaults caused by incorrect madvise(MADV_PAGEOUT) be
> distinguished from the ones which were evicted by kernel reclaim
> mechanisms.
> I can see use for that from userspace to detect incorrect madvise()
> and adjust its aggressiveness. I think the API might get a bit complex
> because of the need to associate refaults with specific madvise()/VMAs
> to understand which hint was incorrect and adjust the behavior.
> Instead what is the opinion about giving an MADV_PAGEOUT_INACTIVE
interface which does operate on a page only If it is on the inactive
list and !PageWorkingset ?

> Hope my feedback is useful and if we can improve Android's userspace
> behavior, I'm happy to help make that happen.
Thanks...
