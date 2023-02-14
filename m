Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DD36970F1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 23:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjBNWzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 17:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjBNWzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 17:55:07 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7E628D00;
        Tue, 14 Feb 2023 14:55:06 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EBp3Eb028640;
        Tue, 14 Feb 2023 22:55:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tVHN6bgf4vChzIjAucmUwO+gk4DPxGZU9YrmdL8j+uo=;
 b=dUsHgJS6yYudXqvXZIDGs2vDP7e+Ca6rJyOm66qBHzoRWT4I6EjEAEOogvLcymKYGnnK
 zM2R4VWR6oLjBWwg5ktHREZp0hw9JVsV9R6sJz4WOdKiO5sgKUHt2d/YJygzfF6YDvZM
 Ui5y1ranBnTKlJLT5895uiKKvq78p3trMOPPPMpvx8Eex+qlI6UkAAhWk0MZoaeQaoZg
 BOIWt8oTqa9vuOzaCt+bQ9oo6j7zr7+TO5Gqlpphts0+TE1LI+ntwl/uiBVaMzwCu/ZX
 DmzY9LzspHcE0WxU0oyGJ26tv67krSqP1YJLrY0OQtFQw2COVTJROeqUy3bH4BMqzOMM Sw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nr6ps24yw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 22:55:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31EMt3a9028685
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 22:55:03 GMT
Received: from [192.168.142.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 14:55:02 -0800
Subject: Re: [PATCH] rpmsg: glink: Avoid infinite loop on intent for missing
 channel
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Arun Kumar Neelakantam <quic_aneelaka@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_clew@quicinc.com>
References: <20230109223801.1706213-1-quic_bjorande@quicinc.com>
From:   Chris Lew <quic_clew@quicinc.com>
Message-ID: <393b7d5f-b565-6287-bbab-3bf51cc981f0@quicinc.com>
Date:   Tue, 14 Feb 2023 14:55:02 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20230109223801.1706213-1-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3ABI7CFFgl9gy91aIREmwrVejXXFyvgQ
X-Proofpoint-GUID: 3ABI7CFFgl9gy91aIREmwrVejXXFyvgQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_15,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140196
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/2023 2:38 PM, Bjorn Andersson wrote:
> In the event that an intent advertisement arrives on an unknown channel
> the fifo is not advanced, resulting in the same message being handled
> over and over.
> 
> Fixes: dacbb35e930f ("rpmsg: glink: Receive and store the remote intent buffers")
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>   drivers/rpmsg/qcom_glink_native.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index f36740cb6866..7b1320b1579e 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -946,12 +946,12 @@ static void qcom_glink_handle_intent(struct qcom_glink *glink,
>   	spin_unlock_irqrestore(&glink->idr_lock, flags);
>   	if (!channel) {
>   		dev_err(glink->dev, "intents for non-existing channel\n");
> -		return;
> +		goto advance_rx;
>   	}
>   
>   	msg = kmalloc(msglen, GFP_ATOMIC);
>   	if (!msg)
> -		return;
> +		goto advance_rx;


Should we be dropping the packet for this case? If we try again later 
more memory might be available to handle the command.

>   
>   	qcom_glink_rx_peak(glink, msg, 0, msglen);
>   
> @@ -973,6 +973,7 @@ static void qcom_glink_handle_intent(struct qcom_glink *glink,
>   	}
>   
>   	kfree(msg);
> +advance_rx:
>   	qcom_glink_rx_advance(glink, ALIGN(msglen, 8));
>   }
>   
> 
