Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5DA697269
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 01:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjBOADx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 19:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjBOADu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 19:03:50 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE462F7BD;
        Tue, 14 Feb 2023 16:03:38 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EKkj88014247;
        Wed, 15 Feb 2023 00:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OnAGUAPviKr5lCGeTkyaz1RvX/ujJcJXYj+jo1bH868=;
 b=QNAw5hSyuiOk3GxQrS1WrWgNXOwnoItVTyg2VMKaVDJ99CwF9xtcpe5X349NWOrh56kW
 +UGF0M6E0PkjhXwkvxAGqhzPCmj4v0p8xIVyYk97WfT+n+LdshbmW4AiCeV0lcS+ljiK
 ASeojqnu3wfDWupEJ2eeGYgk+ODpA0AN2NcxQHqRBO37NDegXZj+1MpoPLVzX4H3uHv7
 iChB/0SCy+iqzw628KvOGrW7FpoE/uTajxbA5Alh3xr+XlPNkwjWNvZENbjjyVtm30yd
 f9pQow7StMaSqp7i4f+3T9bcLcTlpLoQSk7sbq7AC+d4qUfhSashQhweGmBWSBn1LOvu Hg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqtv0bre0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 00:03:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31F036aF005383
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 00:03:06 GMT
Received: from [192.168.142.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 16:03:05 -0800
Subject: Re: [PATCH v2] rpmsg: glink: Avoid infinite loop on intent for
 missing channel
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230214234231.2069751-1-quic_bjorande@quicinc.com>
From:   Chris Lew <quic_clew@quicinc.com>
Message-ID: <071912cd-4a61-285b-a65a-4aed7ea72bf6@quicinc.com>
Date:   Tue, 14 Feb 2023 16:03:04 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20230214234231.2069751-1-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: q42vAGAtP6pKQ6-E-v_yQQT96m_ni0N1
X-Proofpoint-ORIG-GUID: q42vAGAtP6pKQ6-E-v_yQQT96m_ni0N1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_15,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140206
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/2023 3:42 PM, Bjorn Andersson wrote:
> In the event that an intent advertisement arrives on an unknown channel
> the fifo is not advanced, resulting in the same message being handled
> over and over.
> 
> Fixes: dacbb35e930f ("rpmsg: glink: Receive and store the remote intent buffers")
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Reviewed-by: Chris Lew <quic_clew@quicinc.com>

> ---
> 
> Changes since v1:
> - Don't drop packet if the following memory allocation fails.
> 
>   drivers/rpmsg/qcom_glink_native.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index 89c3381f06c3..b6c60bf86009 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -966,6 +966,7 @@ static void qcom_glink_handle_intent(struct qcom_glink *glink,
>   	spin_unlock_irqrestore(&glink->idr_lock, flags);
>   	if (!channel) {
>   		dev_err(glink->dev, "intents for non-existing channel\n");
> +		qcom_glink_rx_advance(glink, ALIGN(msglen, 8));
>   		return;
>   	}
>   
> 
