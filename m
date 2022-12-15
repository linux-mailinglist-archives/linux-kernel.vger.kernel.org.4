Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611AC64E232
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 21:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiLOUM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 15:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiLOUMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 15:12:53 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FE630F71;
        Thu, 15 Dec 2022 12:12:51 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFJJGUJ008515;
        Thu, 15 Dec 2022 20:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=H0acbQg628jCJ14xWyI9iBRkRK9Ra8NqbTczgtjgjTI=;
 b=P+OtBFi3J6/osYXdi2IuYiVGlCHkLflXd9k/RrWUYY4ZBv+PNMfIhCgKJPPDnyhl7OU0
 biPiv8hO+qd77M3n9+o3UXBBLAgW1UEXBrh4/8ksnpbGwM1sE47jD+sSTEelQPWw3hV7
 u4ms8A40IWUeQTuuw1w1ANkEu+LpXrSUGAA9zq2OAHxnaJgnMObhmJ1OGpPefePH8urd
 IglmQeMZR+0IZXoQ57ETsxEEo9AVoHTSFRM3myTtVa+KiTXgwmrxiMi3CpRbnk1MbVpT
 KX/hHO5SFCX5li/szgpbjt+WMCR25OVPIKbfOlyR2VDTPvTyFrL06umC+2s1hd9osC8L ag== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mg8e68cub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 20:12:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BFKCgQ2022112
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 20:12:42 GMT
Received: from [10.110.66.74] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 15 Dec
 2022 12:12:41 -0800
Message-ID: <7f7b644d-54f1-85cd-1b35-86ba9421c39d@quicinc.com>
Date:   Thu, 15 Dec 2022 12:12:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] drm/msm/dp: do not complete dp_aux_cmd_fifo_tx() if
 irq is not for aux transfer
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <airlied@gmail.com>, <andersson@kernel.org>,
        <daniel@ffwll.ch>, <dianders@chromium.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <vkoul@kernel.org>
CC:     <quic_abhinavk@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1671129159-31105-1-git-send-email-quic_khsieh@quicinc.com>
 <ca15a54b-8040-5e4f-a78e-12b7f8a554e1@linaro.org>
 <CAE-0n53bREwEMV4aP=ySPuPP8mMbDr=Unbjw_bW0MNN7hTsWRw@mail.gmail.com>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <CAE-0n53bREwEMV4aP=ySPuPP8mMbDr=Unbjw_bW0MNN7hTsWRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SEWFHKJ4I1kUqK-qpNNjchgGayIMoCXQ
X-Proofpoint-ORIG-GUID: SEWFHKJ4I1kUqK-qpNNjchgGayIMoCXQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_11,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=773 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 clxscore=1015 phishscore=0 mlxscore=0 adultscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2212150168
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/15/2022 12:10 PM, Stephen Boyd wrote:
> Quoting Dmitry Baryshkov (2022-12-15 10:46:42)
>> On 15/12/2022 20:32, Kuogee Hsieh wrote:
>>>        if (!aux->cmd_busy)
>>>                return;
>>>
>>>        if (aux->native)
>>> -             dp_aux_native_handler(aux, isr);
>>> +             ret = dp_aux_native_handler(aux, isr);
>>>        else
>>> -             dp_aux_i2c_handler(aux, isr);
>>> +             ret = dp_aux_i2c_handler(aux, isr);
>>>
>>> -     complete(&aux->comp);
>>> +     if (ret == IRQ_HANDLED)
>>> +             complete(&aux->comp);
>> Can you just move the complete() into the individual handling functions?
>> Then you won't have to return the error code from dp_aux_*_handler() at
>> all. You can check `isr' in that function and call complete if there was
>> any error.
> I'd prefer we apply my patch and pass the irqreturn_t variable to the
> caller of this function so spurious irqs are shutdown. Should I send it
> as a proper patch?
yes, please
