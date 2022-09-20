Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1BE5BE2F3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 12:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiITKUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 06:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiITKUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:20:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA984AD7F;
        Tue, 20 Sep 2022 03:20:10 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28K7xnsW000538;
        Tue, 20 Sep 2022 10:19:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=nd5K05KlUljLOd4JOAHFBcf48g9JQumc72I+9PCMMas=;
 b=cXJLS0JuYShfNPhyeG7QcNHtJEW9TfxLvfGKO3AX/Mxognvk1+A+oXWSrNLLHnauhhIH
 lm25T2mAcGUCq14CoMl114rkvLGfmvQPBLvSDMBlkKCQ9II5jZz+tGkCPVjry0Xo8Z4s
 Dp5npGN404InTd3cZSnIZf4l4pfzk7LUveVuSJYsIMQ6YuKYP2y51rzsbpnn64+BOQzP
 xW6sR3a/UlfjJA12kYdzEZ5n2HKB9JNpyy0lBdZzrjBCRbfrN1M+O46tZdh1CoG7SCkA
 in/cHVZr6d3+yTMZo9iA7JJeW9o8venY7uDfEmbCKVkYv/LAUZ+33/T+JT5bbzIo0BCE kg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jq73213br-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 10:19:49 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28KAJnUS021616
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 10:19:49 GMT
Received: from [10.216.36.207] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 20 Sep
 2022 03:19:46 -0700
Message-ID: <afb6d82b-d1fc-4af7-8d1b-f0fdd26836b2@quicinc.com>
Date:   Tue, 20 Sep 2022 15:49:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] mtd: rawnand: qcom: Implement exec_op()
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Md Sadre Alam <quic_mdalam@quicinc.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1654273498-31998-1-git-send-email-quic_mdalam@quicinc.com>
 <20220915134328.GD4550@workstation>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <20220915134328.GD4550@workstation>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FXW-PHmY22oWeb8dIxxpc2lu5_2VUmCW
X-Proofpoint-GUID: FXW-PHmY22oWeb8dIxxpc2lu5_2VUmCW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_02,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 mlxlogscore=841 spamscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 clxscore=1011 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209200062
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,

On 9/15/2022 7:13 PM, Manivannan Sadhasivam wrote:
> On Fri, Jun 03, 2022 at 09:54:58PM +0530, Md Sadre Alam wrote:
>> Implement exec_op() so we can later get rid of the legacy interface
>> implementation.
>>
>> Co-developed-by: Sricharan R <quic_srichara@quicinc.com>
>> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> Sadre, Sri, any update on this patch?

Sorry got stuck with few other activities, we are taking this now up again.
So will post the reworked patches sometime next week.

Regards,
   Sricharan


