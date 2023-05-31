Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB367179CC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbjEaISR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbjEaISP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:18:15 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7199AC5;
        Wed, 31 May 2023 01:18:14 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34V7wmtP006080;
        Wed, 31 May 2023 08:18:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6JEDdpWGaa96MaxLt8QOExixvypXt613u9oIE/SkivY=;
 b=c/0fNew+LrAJk1BecmZeVTWhkVKgUwMw5/vFijr++bhDVIw0+y7Cw/v8KqzX4Q9KemLf
 2rA0lCkUpnP1Nk65Ygn1eDbMTa+7VIIJ7MDpkqwRzPphwaS6YmXM/6M8Z1HyfzrZdgGv
 eZgP8rTkQ2QP5wg5aMfYHywt4JxNeRB6HIuRyuqSHBJb3RgvgTLAsTNFcg8GplLiokgV
 97+10HLYKT+IxTOV1XH2Vtl+JSHXJvNl18tOn5d+3d/Q3Y6aBBNv0tASEWCHsLcscKxF
 mqNMk3XyK3Vf0kwfDIxkdZHGfPlFBeY/EHfpdiSGbmIInr1aBMVtxMXjzdDgOBuLK34/ wA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qx0sbr7m6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 08:18:08 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34V8I7Gm023368
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 08:18:07 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 31 May
 2023 01:18:05 -0700
Message-ID: <7c1a43ee-d0ca-3deb-24e5-0423a188b459@quicinc.com>
Date:   Wed, 31 May 2023 13:48:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] soc: qcom: pmic: Fix resource leaks in
 device_for_each_child_node() loops
Content-Language: en-US
To:     Lu Hongfei <luhongfei@vivo.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     <opensource.kernel@vivo.com>
References: <20230531075513.55182-1-luhongfei@vivo.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230531075513.55182-1-luhongfei@vivo.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SSmb0oj2YmbeNstoKhBJB-VfWjnPH3GS
X-Proofpoint-ORIG-GUID: SSmb0oj2YmbeNstoKhBJB-VfWjnPH3GS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_04,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310071
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/31/2023 1:25 PM, Lu Hongfei wrote:
> The device_for_each_child_node loop in pmic_glink_altmode_probe should have
> fwnode_handle_put() before return which could avoid resource leaks.
> This patch could fix this bug.
> 
> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>

Use  Fixes: tag

Otherwise LGTM.

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-- Mukesh

> ---
>   drivers/soc/qcom/pmic_glink_altmode.c | 27 ++++++++++++++++++---------
>   1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
> index df48fbea4b68..a7fc6570fa1e
> --- a/drivers/soc/qcom/pmic_glink_altmode.c
> +++ b/drivers/soc/qcom/pmic_glink_altmode.c
> @@ -395,7 +395,7 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
>   		ret = fwnode_property_read_u32(fwnode, "reg", &port);
>   		if (ret < 0) {
>   			dev_err(dev, "missing reg property of %pOFn\n", fwnode);
> -			return ret;
> +			goto err_node_put;
>   		}
>   
>   		if (port >= ARRAY_SIZE(altmode->ports)) {
> @@ -405,7 +405,8 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
>   
>   		if (altmode->ports[port].altmode) {
>   			dev_err(dev, "multiple connector definition for port %u\n", port);
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			goto err_node_put;
>   		}
>   
>   		alt_port = &altmode->ports[port];
> @@ -420,33 +421,37 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
>   
>   		ret = devm_drm_bridge_add(dev, &alt_port->bridge);
>   		if (ret)
> -			return ret;
> +			goto err_node_put;
>   
>   		alt_port->dp_alt.svid = USB_TYPEC_DP_SID;
>   		alt_port->dp_alt.mode = USB_TYPEC_DP_MODE;
>   		alt_port->dp_alt.active = 1;
>   
>   		alt_port->typec_mux = fwnode_typec_mux_get(fwnode);
> -		if (IS_ERR(alt_port->typec_mux))
> -			return dev_err_probe(dev, PTR_ERR(alt_port->typec_mux),
> +		if (IS_ERR(alt_port->typec_mux)) {
> +			ret = dev_err_probe(dev, PTR_ERR(alt_port->typec_mux),
>   					     "failed to acquire mode-switch for port: %d\n",
>   					     port);
> +			goto err_node_put;
> +		}
>   
>   		ret = devm_add_action_or_reset(dev, pmic_glink_altmode_put_mux,
>   					       alt_port->typec_mux);
>   		if (ret)
> -			return ret;
> +			goto err_node_put;
>   
>   		alt_port->typec_switch = fwnode_typec_switch_get(fwnode);
> -		if (IS_ERR(alt_port->typec_switch))
> -			return dev_err_probe(dev, PTR_ERR(alt_port->typec_switch),
> +		if (IS_ERR(alt_port->typec_switch)) {
> +			ret = dev_err_probe(dev, PTR_ERR(alt_port->typec_switch),
>   					     "failed to acquire orientation-switch for port: %d\n",
>   					     port);
> +			goto err_node_put;
> +		}
>   
>   		ret = devm_add_action_or_reset(dev, pmic_glink_altmode_put_switch,
>   					       alt_port->typec_switch);
>   		if (ret)
> -			return ret;
> +			goto err_node_put;
>   	}
>   
>   	altmode->client = devm_pmic_glink_register_client(dev,
> @@ -455,6 +460,10 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
>   							  pmic_glink_altmode_pdr_notify,
>   							  altmode);
>   	return PTR_ERR_OR_ZERO(altmode->client);
> +
> +err_node_put:
> +	fwnode_handle_put(fwnode);
> +	return ret;
>   }
>   
>   static const struct auxiliary_device_id pmic_glink_altmode_id_table[] = {
