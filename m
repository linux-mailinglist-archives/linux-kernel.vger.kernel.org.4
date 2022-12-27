Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE85E656896
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 09:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiL0I4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 03:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiL0I4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 03:56:23 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB9D64CC;
        Tue, 27 Dec 2022 00:56:21 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BR5sFMq012005;
        Tue, 27 Dec 2022 08:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vOJfLNIhfso9l2s3VZeawR3CLuvnu+SogGq4Uicjcag=;
 b=U964bRlJFv92pzZRLFdOMMSExnSFf35wnhzzqmH8NuG0tIkto7weM8CDKCk1d/JzJWHl
 tqMHvEfAdXLCeBCeSRMwTqlym8ZIn4cEDB+wQicAvqcVnR9UMmCj1VNJqrdsu/ca0MAr
 waOu5MgTkjlMXaPlxW8DaosFOFdfT+bruvI/jcxJfvw23mOOM0CMbzoNxTzq1K0KWlnh
 9MQY5FdlILxm+mXHkvQI4HAOuUVlkIcaXHS7PCopbIsmmoqguKfenST1ptuG05Nncsdl
 j8l9U9Y6phcBJxFjR2lamQP+CgqvL3ysCxP/zIfgsPch7nY0DSMbb3twTHJXU62hD6+A oQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mnt6s45dx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Dec 2022 08:56:18 +0000
Received: from nasanex01c.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BR8uIwi001095
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Dec 2022 08:56:18 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 27 Dec
 2022 00:56:15 -0800
Message-ID: <ead97313-c147-ae8b-dda6-c872475a9dd5@quicinc.com>
Date:   Tue, 27 Dec 2022 14:26:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] remoteproc: qcom: pas: Fix subdevice add order
Content-Language: en-US
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mathieu.poirier@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1671024983-22634-1-git-send-email-quic_mojha@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <1671024983-22634-1-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9_NDah0Y1Q47XFfSeo2XgP2KeocUJtWN
X-Proofpoint-ORIG-GUID: 9_NDah0Y1Q47XFfSeo2XgP2KeocUJtWN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-27_05,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212270073
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Friendly reminder for review.

-Mukesh

On 12/14/2022 7:06 PM, Mukesh Ojha wrote:
> Currently, the notification like QCOM_SSR_BEFORE_SHUTDOWN is not exactly
> sent before starting shutdown activity on remote subsystem but it is
> getting sent after sysmon shutdown request to remote.
> 
> On getting QCOM_SSR_BEFORE_SHUTDOWN, some client want remote subsystem
> to be alive to communicate but as sysmon shutdown request is getting
> sent to remote before QCOM_SSR_BEFORE_SHUTDOWN notification sent to
> kernel client due to which remote is not in a condition to communicate
> with kernel clients.
> 
> Fixing the subdevice ordering will fix this as ssr subdevice will be
> first one to get triggered in shutdown/stop path.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>   drivers/remoteproc/qcom_q6v5_pas.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 6afd094..5e34d59 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -538,7 +538,6 @@ static int adsp_probe(struct platform_device *pdev)
>   
>   	qcom_add_glink_subdev(rproc, &adsp->glink_subdev, desc->ssr_name);
>   	qcom_add_smd_subdev(rproc, &adsp->smd_subdev);
> -	qcom_add_ssr_subdev(rproc, &adsp->ssr_subdev, desc->ssr_name);
>   	adsp->sysmon = qcom_add_sysmon_subdev(rproc,
>   					      desc->sysmon_name,
>   					      desc->ssctl_id);
> @@ -547,6 +546,7 @@ static int adsp_probe(struct platform_device *pdev)
>   		goto detach_proxy_pds;
>   	}
>   
> +	qcom_add_ssr_subdev(rproc, &adsp->ssr_subdev, desc->ssr_name);
>   	ret = rproc_add(rproc);
>   	if (ret)
>   		goto detach_proxy_pds;
