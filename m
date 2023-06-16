Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2950D733B4F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 23:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236740AbjFPVHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 17:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjFPVHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 17:07:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B664D8;
        Fri, 16 Jun 2023 14:06:58 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35GKTG1s004082;
        Fri, 16 Jun 2023 21:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=za7Wba2fM/qIMMUatKDGea50zMmcCuEOpPbahiJJj7U=;
 b=HOKyVUOV1UfUXzD2/zA3/8BidtYYDu8GRfKRBgqdSPyqnac28z10ZgmccdGsyPPtnhuR
 mfVvrTiwkviVO19JqrqyjbCjZezQlPl/9h82qg9MhgdONdZ5hJCEiNb1nqa/khcVBAcU
 z/TW3IsBmE7s44fx3db7dlPC6DQS6p1ClDavAaXAjEz/vtuPRLzEvAnGAbhhpmbYQpm9
 DEigdG+HgJMuJ2OFp7IC8+QRaVAH+0dFtZfl587qaX0UADqKn8qrAfQmEf6VP2SbCjj6
 1EDMa8dC++rEuyba2MIvT7jeiliTAmzW8r94Do+b3VzQBmAsx8aid9kdM6pz5R+OyJ05 pg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r8mt0sgyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 21:06:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35GL6n09006248
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 21:06:49 GMT
Received: from [10.110.47.14] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 16 Jun
 2023 14:06:48 -0700
Message-ID: <3791f18c-89f1-f066-38c4-d8d13a3ab611@quicinc.com>
Date:   Fri, 16 Jun 2023 14:06:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] drm/msm/dpu: Add DPU_INTF_DATABUS_WIDEN feature flag
 for DPU >= 5.0
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20230525-add-widebus-support-v1-0-c7069f2efca1@quicinc.com>
 <20230525-add-widebus-support-v1-1-c7069f2efca1@quicinc.com>
 <wpjxrnhbcanbc5iatxnff25yrrdfrtmgb24sgwyo457dz2oyjz@e2docpcb6337>
 <f4fb042c-1458-6077-3c49-8cc02638b27c@linaro.org>
 <ycgei43x4kfmjk7g7gbeglehtiiinfbqmrjbdzcy56frxbtd2z@yk2f5kgrkbrt>
 <i5trozzoexkm7taojob4c53sajm2w6tnasj2yfzjy3a77oqvw7@wadk7g7op2kp>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <i5trozzoexkm7taojob4c53sajm2w6tnasj2yfzjy3a77oqvw7@wadk7g7op2kp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aGrCF_1cbB0Bk6TJHXfvFuyKpruSru8c
X-Proofpoint-GUID: aGrCF_1cbB0Bk6TJHXfvFuyKpruSru8c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_14,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 clxscore=1015 mlxlogscore=423 malwarescore=0 spamscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160191
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/2023 3:49 PM, Marijn Suijten wrote:
> On 2023-06-14 14:23:38, Marijn Suijten wrote:
> <snip>
>> Tested this on SM8350 which actually has DSI 2.5, and it is also
>> corrupted with this series so something else on this series might be
>> broken.
> 
> Never mind, this was a bad conflict-resolve.  Jessica's original
> BURST_MODE patch was RMW'ing MDP_CTRL2, but the upstreamed patch was
> only writing, and the way I conflict-resolved that caused the write of
> BURST_MODE to overwrite the RMW DATABUS_WIDEN.
> 
> If both are moved to dsi_ctrl_config(), we could do a read, add both
> flags in conditionally, and write.
> 

So just to confirm, there is no issue on your 8350 setup with widebus 
enabled right?

> - Marijn
