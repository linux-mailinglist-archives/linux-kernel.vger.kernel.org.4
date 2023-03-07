Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42C46AD689
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 05:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCGErh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 23:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjCGEre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 23:47:34 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7227337F3E;
        Mon,  6 Mar 2023 20:47:11 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3272TPTg011713;
        Tue, 7 Mar 2023 04:46:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DKvqvzb5WzxlmzYw8eEdTTMow8wfzTGqnqd88w9RdPQ=;
 b=AWPH2CqvNANYZlAmFyh/l7tPJ4CU1yTBqCuOvoA9V+4CXMCG4GXrIsDgDoZ/ukukGXku
 TZ8dkIn+PxnsMpTK2cIBdxuECevnYgwPE7I7V7eu2HAFFIg4VN+VG7vgagvFWM9YT3hg
 uGZ6HS6QVECq3OSYUublYgOpWTSB+jguxYmBfCiiRpgfNRzWwqNA6gkfllJiRrtM4RPj
 mYYI4EDex4i70YlXUKoPiFgpizTLxuF3WSHLACWhYIYmvfS5wS+ZN2wRZiA/VwaAUhdY
 g/MllHEX9uc6kyJNBM1aw041GVeXy3OPrE8xuNb/ARjlaD5O69Olf7nMGPd3d370SXGa 1A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p5rqjrr8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 04:46:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3274k1Mj020082
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Mar 2023 04:46:01 GMT
Received: from [10.50.8.76] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 6 Mar 2023
 20:45:55 -0800
Message-ID: <3d0315fa-14ca-dc34-81ae-467d9ed5133d@quicinc.com>
Date:   Tue, 7 Mar 2023 10:15:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] media: venus: dec: Fix capture formats enumeration order
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        Jordan Crouse <jorcrous@amazon.com>
CC:     <linux-kernel@vger.kernel.org>, Albert Esteve <aesteve@redhat.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Sergio Lopez <slp@redhat.com>,
        Enric Balletbo i Serra <eballetb@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-media@vger.kernel.org>
References: <20230210081835.2054482-1-javierm@redhat.com>
 <20230303220918.qr5ydbin3nye3qtz@amazon.com>
 <87h6uydwel.fsf@minerva.mail-host-address-is-not-set>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <87h6uydwel.fsf@minerva.mail-host-address-is-not-set>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0bLYU3qYMLhLGdt-CXXjJfU1If5MXsqK
X-Proofpoint-GUID: 0bLYU3qYMLhLGdt-CXXjJfU1If5MXsqK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_14,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 adultscore=0
 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070042
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/6/2023 3:38 PM, Javier Martinez Canillas wrote:
> Jordan Crouse <jorcrous@amazon.com> writes:
>
> Hello Jordan,
>
>> On Fri, Feb 10, 2023 at 09:18:35AM +0100, Javier Martinez Canillas wrote:
>>> Commit 9593126dae3e ("media: venus: Add a handling of QC08C compressed
>>> format") and commit cef92b14e653 ("media: venus: Add a handling of QC10C
>>> compressed format") added support for the QC08C and QC10C compressed
>>> formats respectively.
>>>
>>> But these also caused a regression, because the new formats where added
>>> at the beginning of the vdec_formats[] array and the vdec_inst_init()
>>> function sets the default format output and capture using fixed indexes
>>> of that array:
>>>
>>> static void vdec_inst_init(struct venus_inst *inst)
>>> {
>>> ...
>>> 	inst->fmt_out = &vdec_formats[8];
>>> 	inst->fmt_cap = &vdec_formats[0];
>>> ...
>>> }
>>>
>>> Since now V4L2_PIX_FMT_NV12 is not the first entry in the array anymore,
>>> the default capture format is not set to that as it was done before.
>>>
>>> Both commits changed the first index to keep inst->fmt_out default format
>>> set to V4L2_PIX_FMT_H264, but did not update the latter to keep .fmt_out
>>> default format set to V4L2_PIX_FMT_NV12.
>>>
>>> Rather than updating the index to the current V4L2_PIX_FMT_NV12 position,
>>> let's reorder the entries so that this format is the first entry again.
>>>
>>> This would also make VIDIOC_ENUM_FMT report the V4L2_PIX_FMT_NV12 format
>>> with an index 0 as it did before the QC08C and QC10C formats were added.
>>>
>>> Fixes: 9593126dae3e ("media: venus: Add a handling of QC08C compressed format")
>>> Fixes: cef92b14e653 ("media: venus: Add a handling of QC10C compressed format")
>>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> I just came across this issue independently and can confirm this patch fixes
>> the GStreamer V4L2 decoder on QRB5165.
>>
>> Tested-by: Jordan Crouse <jorcrous@amazon.com>
>>
> Thanks for testing it!
>
> Stanimir, can we please get this for v6.3 as well?

Hi Javier, Jordan

Could you please explain what regression/issue you see with patch?

venus hardware supports QC08C which provides better performance hence 
driver is publishing it as preferred color format.

if client doesn't support this or want to use any other format, they can 
set the desired format with s_fmt.

Thanks,

Dikshita

