Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F3462B372
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 07:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiKPGmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 01:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbiKPGlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 01:41:46 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15258192B2;
        Tue, 15 Nov 2022 22:41:45 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AG5txY7010732;
        Wed, 16 Nov 2022 06:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Odea2B46xrT9iJUqqu5UzRkYtBMs+DcMTYaWMBgLQGA=;
 b=IyfLkP9WgLMPQB/sVbxQR9+VX+PR9ZDRgub2TbD5ZCYAtbCRwLim0gp787EdCoUSulhI
 Vv57aF5j1p/fQEdKfIJSCfJdKCxjEw+dyctQ+ibtB9BzR32y6rGKxjQOvaFKjTBX9TM/
 VOMmAx/6JRw+V3KIm6THZRDCnuloTHDLJV6ySF+fQS80LfM/Uu37YkGmJYNTN2U3iHuN
 2mt/6ortT9bigH+rhxFYTcv+U+kePvTnkRviX5J7RRfXYuyeadhZ9QiAHOH89QxZjNzd
 5Id8NR6vY2JDy4V/r7DyVMRfCjLqRXWAqsa20nl58Dd1jzv9y5P5MtXsMwoGhsKed0Ix zw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kvt4a837m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 06:41:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AG6fbi2010916
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 06:41:37 GMT
Received: from [10.79.43.101] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 15 Nov
 2022 22:41:33 -0800
Message-ID: <1b462f1a-327b-4a8f-8de7-909dbad0ddf8@quicinc.com>
Date:   Wed, 16 Nov 2022 12:11:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V4 2/2] firmware: qcom: scm: Add wait-queue handling logic
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>
CC:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <agross@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <konrad.dybcio@somainline.org>,
        <robimarko@gmail.com>, <quic_rjendra@quicinc.com>
References: <20221114082644.28739-1-quic_sibis@quicinc.com>
 <20221114082644.28739-3-quic_sibis@quicinc.com>
 <20221115053336.GA29781@quicinc.com>
Content-Language: en-US
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20221115053336.GA29781@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4AxGlm4I2GEmdZAw2Z56HMQe4qjWkh_v
X-Proofpoint-GUID: 4AxGlm4I2GEmdZAw2Z56HMQe4qjWkh_v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 mlxlogscore=919 suspectscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160046
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Guru,

Thanks for taking time to review the series.

On 11/15/22 11:03, Guru Das Srinagesh wrote:
> On Nov 14 2022 13:56, Sibi Sankar wrote:
> 
> (snip)
> 
>> +static irqreturn_t qcom_scm_irq_handler(int irq, void *data)
>> +{
>> +	int ret;
>> +	struct qcom_scm *scm = data;
>> +	struct completion *wq_to_wake;
>> +	u32 wq_ctx, flags, more_pending = 0;
>> +
>> +	do {
>> +		ret = scm_get_wq_ctx(&wq_ctx, &flags, &more_pending);
>> +		if (ret) {
>> +			dev_err(scm->dev, "GET_WQ_CTX SMC call failed: %d\n", ret);
>> +			goto out;
>> +		}
>> +
>> +		wq_to_wake = qcom_scm_lookup_wq(scm, wq_ctx);
>> +		if (IS_ERR_OR_NULL(wq_to_wake)) {
>> +			dev_err(scm->dev, "No waitqueue found for wq_ctx %d: %ld\n",
>> +				wq_ctx, PTR_ERR(wq_to_wake));
>> +			goto out;
>> +		}
>> +
>> +		if (flags != QCOM_SMC_WAITQ_FLAG_WAKE_ONE &&
>> +		    flags != QCOM_SMC_WAITQ_FLAG_WAKE_ALL) {
>> +			dev_err(scm->dev, "Invalid Flags found for wq_ctx: %u\n", flags);
>> +			goto out;
>> +		}
>> +
>> +		complete(wq_to_wake);
> 
> Need to call complete() or complete_all() based on the flags.

with the current implementation we should get away with
just complete for now but I can add them back in the way
Bjorn wanted i.e. with the bool wake_all in the next
re-spin.

- Sibi

> 
>> +	} while (more_pending);
>> +
>> +out:
>> +	return IRQ_HANDLED;
>> +}
