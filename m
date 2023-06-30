Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C43743C76
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 15:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbjF3NQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 09:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjF3NQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 09:16:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93F33A81
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 06:16:21 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35UCfbSE029399;
        Fri, 30 Jun 2023 13:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=M+N4HRHWpiUhv8np7V6R1Bm2qzXWQGoWUuCUhLG7SxA=;
 b=DGTRzuWFNkR4DLYFx/gdYITujClIJ/jeBA8f4Jct2lq6n42Tvu4mOL3yfguzP8uxudoR
 iNZfBjCcJO4mE3BIo8yGvpyUOUWrwrltiy5t3dzpzTHfFEXyUVnA2wSytHoCNVft+MWG
 fT26e+af+vr1Cp9ZXLs+UZvDjJLlNzyWFPl26f2LdAeFCjd3K2/ExaSXzURBgpdDJdZB
 BxFpI/T1635PTitQpX1uZdEJ30ZgcBiGR0oA7M6b+Q1Xiq3J3C5SodaOhaHwvd7QnMqp
 KUsQhNTVcs0H65CHEfXkNeiVlzGcSn4ymDHaI1tGWCDe10ouZj0UrrUZUTSCfjbdDzAq rg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rhw70rb6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 13:16:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35UDG80o017429
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 13:16:08 GMT
Received: from [10.214.66.119] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Fri, 30 Jun
 2023 06:16:05 -0700
Message-ID: <ad41ccc3-fd9a-bca3-4910-751b72c831fe@quicinc.com>
Date:   Fri, 30 Jun 2023 18:46:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V2] mm: madvise: fix uneven accounting of psi
Content-Language: en-US
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     <akpm@linux-foundation.org>, <surenb@google.com>,
        <hannes@cmpxchg.org>, <minchan@kernel.org>,
        <quic_smanapra@quicinc.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <1687861992-8722-1-git-send-email-quic_charante@quicinc.com>
 <f72dc0b0-e848-4053-879d-5eccd4d00b52@quicinc.com>
 <65ce241e-8614-b669-cd20-b315c30bd794@quicinc.com>
In-Reply-To: <65ce241e-8614-b669-cd20-b315c30bd794@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: btzqHRtxEPUsU7Mo2sMzrkYrNzaQH3b4
X-Proofpoint-GUID: btzqHRtxEPUsU7Mo2sMzrkYrNzaQH3b4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=814 spamscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 bulkscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306300112
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavan,

On 6/28/2023 4:19 PM, Charan Teja Kalla wrote:
> I think marking the folio as a workingset when it sits on the active is
> not a correct thing. For the same example you mentioned, a simple CMA
> allocation will be dropping the clean pages instead of migration. PSI
> accounting on refault of those pages don't reveal anything to the user.
> 
> Where as in the madvise() cases, this PSI tells the user about the type
> of pages that he is working on.[1]
> 
> BTW, damon_pa_pageout() seems a valid case above. let me fix it in the
> next patch.
I did look a little bit more at the damon code and IIUC it: DAMON
monitors the ranges it is asked to operate as regions and
operate(reclaim) on the region that has less number of accesses, IOW,
damon won't do pageout operation on a folio if it is really under use,
CMIW.

This is unlike the case with the madvise() operation where Workingset
helps in accounting PSI that helps user the type of folios he is
operating on.

Assume that damon is operating on wrong set of regions and Workingset
helps in giving a PSI. This got no help to user and just telling the
internals of damon. No?

Having said that, theoretically it seems correct to me to set workingset
on folios as they leave the active list, but I don't have any strong
reason to say what happens if we won't.

Moreover, this patch is mostly talks about the madvise() operated folios
not inline with the usual reclaim. May be a separate change can be
raised for damon() operated folios once we agree upon the importance of
Workingset to these folios. WDYT?

Thanks,
