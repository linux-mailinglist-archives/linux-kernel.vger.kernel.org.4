Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E2B6E2DCF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 02:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjDOAKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 20:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDOAKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 20:10:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD4B30F1;
        Fri, 14 Apr 2023 17:10:40 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33F01UY3016291;
        Sat, 15 Apr 2023 00:10:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LUJ2/lAfWFV0553iBaBy/s0Q3nMiR2TR4qQH20SjvaE=;
 b=a9Royk2NmeiLjMtwLn36yyepLw1Zh60uDH1atMzTyAcpQ1dXmT+JKCg75+uay6JFxgZE
 6tc/R1vg0hEu3LQPU0hV+7MQHk6STanqzC9IvrcLYJH5hR1f7WyXvmf4ZAXL5UhMRlh1
 5RYL+yFa6jpe/ve4Xc8MulQ0dLBY5Nc7HpdoG4VZCydVz7NAoZlCrUXk8Cgvg/XdsVqY
 P4ciKQw1R0p/p8J1gyntrIL5Tq0ho+w0bRF9Z0CCRUXI1PMwQYbpXz5pRQAv5a5ZYlIP
 f2Up5tFH8SlHgfUQy4I7R9zxNNC5I840nc4WiYh+NBbRK/dYz7pu+OpVzrE8LtqgqDvQ CA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pyck1gexa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Apr 2023 00:10:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33F0ATMq027243
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Apr 2023 00:10:29 GMT
Received: from [10.110.73.215] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 14 Apr
 2023 17:10:27 -0700
Message-ID: <76d217d2-ee49-2074-d54a-7ba21ff4fb2d@quicinc.com>
Date:   Fri, 14 Apr 2023 17:10:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2] drm/msm/dpu: always program dsc active bits
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>
CC:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1681401401-15099-1-git-send-email-quic_khsieh@quicinc.com>
 <tgfbdk6q3uool365jqddibnbgq66clsmsm6tldxpm5toqghxpq@m2ic3oonv2s5>
 <aac210da-dec1-aab8-3f48-c33d9e7687d6@quicinc.com>
 <3oaangxh7gmie3cdd6rmujm7dd3hagsrnwiq3bascdtamvfn3a@bn6ou5hbsgxv>
 <c09725ff-771c-35d1-adc9-4bb1b7c1c334@quicinc.com>
 <CAA8EJppKXSGcOcYEc6UKz9Eh8JizSpdDNe+cdvfmFbuBJ9zPKw@mail.gmail.com>
 <eb8ea024-1152-418c-a048-f86253867c9e@quicinc.com>
 <m43254ainsnznnehtziigr3akpy7lnwkel424e2emr2tycpbek@yqam6dij63d5>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <m43254ainsnznnehtziigr3akpy7lnwkel424e2emr2tycpbek@yqam6dij63d5>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZrV_lk8tW8jJssG75kSzHIUE4WsBt4OC
X-Proofpoint-GUID: ZrV_lk8tW8jJssG75kSzHIUE4WsBt4OC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_16,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304150000
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/2023 3:52 PM, Marijn Suijten wrote:
> On 2023-04-14 14:03:23, Abhinav Kumar wrote:
> [..]
>>>> Yes, ofcourse git send-email was used to send the patch, not any other
>>>> mail client.
>>>>
>>>> Yes i am also aware that send-email converts rb to CC.
>>>>
>>>> But if you keep working on the local branch, then you would have to
>>>> manually add the r-bs. If you use am of the prev version and develop on
>>>> that, it will automatically add the r-bs.
> 
> I don't think git-am is smart enough to fetch additional replies from
> lore and apply the reviewed-by (and other trailers).  This workflow
> relies on downloading the mbox from a service that extracts and
> accumulates the trailers such as patchwork, see for example:
> 
> 	https://patchwork.freedesktop.org/api/1.0/series/116340/revisions/1/mbox/
> 
> Note that it also picked up one sentence starting with Fixes:
> 
> 	Fixes: tag below seems extraneous.
> 

Yes, I usually use git-pw ap.

So perhaps, I should have been more specific to say that.

Some form of am is what i wanted to emphasize but just wrote git am by 
mistake.

> On the other hand b4 (shaz)am is itself capable of downloading the whole
> mail thread and appending all trailers, just like patchwork is doing
> above, in one automated `b4 shazam <lore link>` command.
> 
> And to solve the problem of trailers arriving in your inbox after
> working on the next revision in a local branch - or without ever even
> redownloading the series from lore/patchwork¸ b4 has a command to
> download and apply them to commits in your local branch:
> 
> 	b4 trailers -uF <lore link>
> 
> Try it out, b4 is amazing :)
> 

Yes, i recently started using it to send "applied" emails as suggested 
by Dmitry , for patch related work was still using git-pw.

Perhaps, I will switch completely to it.

> [..]
>> 2) I synced with kuogee. his git version seems to be quite old which is
>> not adding the folks from r-b to cc. So there was nothing wrong with
>> invocation, just versioning.
> 
> You are right.  The X-Mailer header of Kuogee's patch indicates git
> 2.7.4, while cc'ing of additional -by trailers (such as r-b's) was only
> introduced in 2.20.0:
> 
> https://github.com/git/git/commit/ef0cc1df90f6b6c2987ab2db8e0ccf2cfc421edf
> 
> Fwiw 2.7.4 is from March 2016.
> 
> - Marijn
