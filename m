Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5846769968A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjBPOBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBPOBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:01:33 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B6326AF;
        Thu, 16 Feb 2023 06:01:32 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31GArWdL013797;
        Thu, 16 Feb 2023 14:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3IATf/n2gVdgnP0wM+657JvVHnwtpkGHrGuCmG1Wmsk=;
 b=fESsklKUlmz2EDYTlklM3uKlMD7yrP+myH/sAkYamDRT/9kXDs8jsdcdp4htbbCtsmN8
 VOaKP+9j/93iEiajwCCpLz+yEEfgtIaUicypteD4PxXycDNrlKfDsabeODy+UJUOV9sH
 6g30MNh9FvVauyIFkohTlqoznhAN/0jMuCmhYCFRdg2KJ8qNZxWbLJQuQJHz2nZlBrlC
 oM+SUs5NSyX/gB8xNozEDGVHT722Nid/+bbHf60q3QbHgmK+wEbxgQ4CqDuGRP76JtiR
 Hf8hj91LZq7oqaPwHHSqwWj0uC7lOUX1QqiJaafCNLU+IktE4T2YdHRzZAe5TOKt3u6s OQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nsja90h31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 14:01:07 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31GE1680017414
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 14:01:06 GMT
Received: from [10.216.54.159] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 16 Feb
 2023 06:00:56 -0800
Message-ID: <51bd93be-f8d3-a33c-18ad-ba4a331f2bcf@quicinc.com>
Date:   Thu, 16 Feb 2023 19:30:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V5 5/5] firmware: scm: Modify only the DLOAD bit in TCSR
 register for download mode
Content-Language: en-US
To:     Poovendhan Selvaraj <quic_poovendh@quicinc.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <robimarko@gmail.com>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_devipriy@quicinc.com>
References: <20230216120012.28357-1-quic_poovendh@quicinc.com>
 <20230216120012.28357-6-quic_poovendh@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230216120012.28357-6-quic_poovendh@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kUFx6QUrIQ5HGL-ouXwHrXrP8Rf7V14s
X-Proofpoint-ORIG-GUID: kUFx6QUrIQ5HGL-ouXwHrXrP8Rf7V14s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_10,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302160121
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/16/2023 5:30 PM, Poovendhan Selvaraj wrote:
> CrashDump collection is based on the DLOAD bit of TCSR register.
> To retain other bits, we read the register and modify only the DLOAD bit as
> the other bits have their own significance.
> 
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Co-developed-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> ---
>   Changes in V5:
> 	- checking the return value in qcom_scm_set_download_mode function as
> 	  suggested by Srinivas Kandagatla
> 
>   Changes in V4:
> 	- retain the orginal value of tcsr register when download mode
> 	  is not set
> 
>   drivers/firmware/qcom_scm.c | 21 ++++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 468d4d5ab550..d88c5f14bd54 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -407,7 +407,7 @@ int qcom_scm_set_remote_state(u32 state, u32 id)
>   }
>   EXPORT_SYMBOL(qcom_scm_set_remote_state);
>   
> -static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
> +static int __qcom_scm_set_dload_mode(struct device *dev, u32 val, bool enable)
>   {
>   	struct qcom_scm_desc desc = {
>   		.svc = QCOM_SCM_SVC_BOOT,
> @@ -417,7 +417,8 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>   		.owner = ARM_SMCCC_OWNER_SIP,
>   	};
>   
> -	desc.args[1] = enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0;
> +	desc.args[1] = enable ? val | QCOM_SCM_BOOT_SET_DLOAD_MODE :
> +				val & ~(QCOM_SCM_BOOT_SET_DLOAD_MODE);
>   
>   	return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
>   }
> @@ -426,15 +427,25 @@ static void qcom_scm_set_download_mode(bool enable)
>   {
>   	bool avail;
>   	int ret = 0;
> +	u32 dload_addr_val;
>   
>   	avail = __qcom_scm_is_call_available(__scm->dev,
>   					     QCOM_SCM_SVC_BOOT,
>   					     QCOM_SCM_BOOT_SET_DLOAD_MODE);
> +	ret = qcom_scm_io_readl(__scm->dload_mode_addr, &dload_addr_val);
> +
> +	if (ret) {
> +		dev_err(__scm->dev,
> +			"failed to read dload mode address value: %d\n", ret);
> +		return;
> +	}
> +
>   	if (avail) {
> -		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
> +		ret = __qcom_scm_set_dload_mode(__scm->dev, dload_addr_val, enable);

Did you test this on a target where it comes under this if statement? 
does it really need to know dload_mode_addr for this target ?

-Mukesh
>   	} else if (__scm->dload_mode_addr) {
> -		ret = qcom_scm_io_writel(__scm->dload_mode_addr,
> -				enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
> +		ret = qcom_scm_io_writel(__scm->dload_mode_addr, enable ?
> +				dload_addr_val | QCOM_SCM_BOOT_SET_DLOAD_MODE :
> +				dload_addr_val & ~(QCOM_SCM_BOOT_SET_DLOAD_MODE));
>   	} else {
>   		dev_err(__scm->dev,
>   			"No available mechanism for setting download mode\n");
