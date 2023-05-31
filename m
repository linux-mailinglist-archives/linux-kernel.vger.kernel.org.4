Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE2F718541
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbjEaOri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236451AbjEaOrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:47:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05D5107;
        Wed, 31 May 2023 07:47:32 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VDwDbK001363;
        Wed, 31 May 2023 14:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GupFFUipno/RdhRM6hgOLwBA79D1V8GXFuS0Nmuzq2k=;
 b=R9Fqb5qwz1DORBtXnWmRj9ogV0+CJG85BmDLzDm4xTAlFDvSKUbzc+Z10KZ8K8yUoHJQ
 iDOe8okRWktmaEHG63ZhCUIJfcx8GTAgHUgIK2tXmKl6mGj79StXBgyrq5CDcLF3OuwP
 2QOMcXHbqejiOF7iw3MBkMbPRg383EhI9vrIKmhDQB3geV6lu6Wy4yTecVkdOLbjE+bT
 Sk9th+yvR9p0bTNAqfAj+kB6w7XdGPTDFpabkt2xjxmeE4MVveD5gRmT+5jI5CYuOHLV
 AwgTUAAmcvoMQLzzvrhHB1gRBl/bWL3Y5xAB3C9Rb7eg/U891bd8JIfO/VOySnLfCp/d Uw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qwryesxr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 14:47:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34VElRIA024397
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 14:47:27 GMT
Received: from [10.217.219.52] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 31 May
 2023 07:47:26 -0700
Message-ID: <665be8f7-0892-3446-72ca-4c45457c9153@quicinc.com>
Date:   Wed, 31 May 2023 20:17:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7] usb: common: usb-conn-gpio: Set last role to unknown
 before initial detection
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1685544074-17337-1-git-send-email-quic_prashk@quicinc.com>
From:   Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <1685544074-17337-1-git-send-email-quic_prashk@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 47lg3rVRswuxgb32oWpKhIMpe0ukouQ2
X-Proofpoint-ORIG-GUID: 47lg3rVRswuxgb32oWpKhIMpe0ukouQ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_10,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 mlxlogscore=924 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310126
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31-05-23 08:11 pm, Prashanth K wrote:
>   
> diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
> index 5aabdd7..6d880c4 100644
> --- a/drivers/usb/musb/jz4740.c
> +++ b/drivers/usb/musb/jz4740.c
> @@ -95,6 +95,8 @@ static int jz4740_musb_role_switch_set(struct usb_role_switch *sw,
>   	case USB_ROLE_HOST:
>   		atomic_notifier_call_chain(&phy->notifier, USB_EVENT_ID, phy);
>   		break;
> +	default:
> +		break;
>   	}
>   
>   	return 0;
> diff --git a/drivers/usb/roles/intel-xhci-usb-role-switch.c b/drivers/usb/roles/intel-xhci-usb-role-switch.c
> index 5c96e92..4d6a3dd 100644
> --- a/drivers/usb/roles/intel-xhci-usb-role-switch.c
> +++ b/drivers/usb/roles/intel-xhci-usb-role-switch.c
> @@ -97,6 +97,8 @@ static int intel_xhci_usb_set_role(struct usb_role_switch *sw,
>   		val |= SW_VBUS_VALID;
>   		drd_config = DRD_CONFIG_STATIC_DEVICE;
>   		break;
> +	default:
> +		break;
>   	}
>   	val |= SW_IDPIN_EN;
>   	if (data->enable_sw_switch) {
> diff --git a/include/linux/usb/role.h b/include/linux/usb/role.h
> index b5deafd..65e790a 100644
> --- a/include/linux/usb/role.h
> +++ b/include/linux/usb/role.h
> @@ -11,6 +11,7 @@ enum usb_role {
>   	USB_ROLE_NONE,
>   	USB_ROLE_HOST,
>   	USB_ROLE_DEVICE,
> +	USB_ROLE_UNKNOWN,
>   };
>   
>   typedef int (*usb_role_switch_set_t)(struct usb_role_switch *sw,

Hi Greg, I have fixed the drivers that doesn't have default case while 
using usb_role enum. Added the same on intel-xhci-usb-role-switch.c & 
musb/jz4740.c files. I was able to compile successfully. Please check 
once if this fixed the build issue.

Thanks in advance,
Prashanth K
