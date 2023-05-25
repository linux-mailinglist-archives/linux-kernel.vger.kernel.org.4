Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE1F710752
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239780AbjEYI2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235794AbjEYI2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:28:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325101A6;
        Thu, 25 May 2023 01:28:04 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34P6ixq8022429;
        Thu, 25 May 2023 08:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vy9UPl4NiNVH0AX5bBHsduqug1f+gXah2Heu93Csg7g=;
 b=Nriszx96ERuP/Wh8ZxRgE9KMzFjMlBUuvHVqXYUxMrlwoEQ+ot4Funm+wFwNF2QXaEPV
 +paGMvSmrUCnlCGU+GhhB/88mFoPA0p37gcqtjPOeQ6VId7RKNY3PTwUnic89fVcjzSY
 E0/+sO+araEfThuVU4H6r/tTOWivo60hoelMVz3lZ9sOQjKlQuvapjWLtoh+sIMvq2G+
 D9kYuBSj751Y9BEVijRari6pGzfXptsZioDIqDypNQYOeXyfv0CIux5AYV8o3GDMgT5R
 pd3JwF2pRItZR44+rFfTA8MAXsizFhWngmnjzJ5MLPhuhllJ3+ZCkYG8L+rKV1RmF/S4 /g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qsywfrhe7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 08:27:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34P8RspJ018244
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 08:27:54 GMT
Received: from [10.217.219.52] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 25 May
 2023 01:27:52 -0700
Message-ID: <05ff6015-aecf-8fb4-ee29-ea7b37060a13@quicinc.com>
Date:   Thu, 25 May 2023 13:57:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] usb: common: usb-conn-gpio: Set last role to unknown
 before initial detection
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1684936207-23529-1-git-send-email-quic_prashk@quicinc.com>
 <64825178-2310-8c8a-2ed9-4ae14a46915e@collabora.com>
From:   Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <64825178-2310-8c8a-2ed9-4ae14a46915e@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hgcF2X_tk-HtLij60r3vRdzHCDARtF_o
X-Proofpoint-ORIG-GUID: hgcF2X_tk-HtLij60r3vRdzHCDARtF_o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_03,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=658 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250069
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25-05-23 01:37 pm, AngeloGioacchino Del Regno wrote:
> Il 24/05/23 15:50, Prashanth K ha scritto:
>> Currently if we bootup a device without cable connected, then
>> usb-conn-gpio won't call set_role() since last_role is same as
>> current role. This happens because during probe last_role gets
>> initialized to zero.
>>
>> To avoid this, added a new constant in enum usb_role, last_role
>> is set to USB_ROLE_UNKNOWN before performing initial detection.
>>
>> Fixes: 4602f3bff266 ("usb: common: add USB GPIO based connection 
>> detection driver")
>> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
> 
> There's an issue with drivers/usb/cdns3/core.c as pointed out by the
> test robot; the solution is to handle `default` in the switch, I'd say
> that it would be safe to handle it as
> 
>      default:
>          break;
> 
> after solving that:
> 
> Reviewed-by: AngeloGioacchino Del Regno 
> <angelogioacchino.delregno@collabora.com>

Yea sure, thanks for the suggestion Agnelo

Regards,
Prashanth K
