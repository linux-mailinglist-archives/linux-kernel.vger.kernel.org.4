Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31F370B4AA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjEVFt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjEVFtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:49:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF355CF;
        Sun, 21 May 2023 22:49:51 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M3cgOG019028;
        Mon, 22 May 2023 05:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Y3xCd5zolOuIrBVxCyYPWzX15i/8hOYxP4izH5myV78=;
 b=d6ZjClp/18mXjhlG7DMA1qopXZQM4tLWhGhW0v1pRmS1ngV2J4Zwr9Nts2DI9Q2yRKPi
 xs9H3BBtqYuJJx1E8/IoocxFWKcjPHerIU6HEV3hJp+PH0t2UlIMsEEQqwgYeUcGBx7H
 BEWFPmaFIdwC3N9bH8T/TROOvyCVvVFlUgRI6IzIz6BvC88Hg+hqepjIvP/PB1MWMX88
 5kj8wt/0HAOXwkAVtEWl2o3nZtlst8wnHzAGfqc9/pUbCiQl5dQ2j403rJdLDLs2axbf
 +FdHnA+Y8Y3BamLvfpxqfsRhwUqAWdhHM2fy1ayN/v5nTXNx34ZdRzRZh7TiR9aLTbEE /A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qpnt62sv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 05:49:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34M5nT5x030191
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 05:49:29 GMT
Received: from [10.218.35.239] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sun, 21 May
 2023 22:49:23 -0700
Message-ID: <bf3b5f0a-0a04-2410-9106-1e2957a2ce05@quicinc.com>
Date:   Mon, 22 May 2023 11:19:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] usb: gadget: u_serial: Add null pointer check in
 gserial_suspend
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Kewu Chen <Kewu.Chen@mediatek.com>, stable <stable@kernel.org>
References: <20230522022101.32163-1-chunfeng.yun@mediatek.com>
From:   Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <20230522022101.32163-1-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: icNJ-c33o_JZAe3vLJW784uCJvlYWUaO
X-Proofpoint-GUID: icNJ-c33o_JZAe3vLJW784uCJvlYWUaO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_03,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 priorityscore=1501 clxscore=1011 mlxlogscore=948 adultscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220047
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22-05-23 07:51 am, Chunfeng Yun wrote:
> When gserial_disconnect has already cleared gser->ioport, and the
> suspend triggers afterwards, gserial_suspend gets called, which will
> lead to accessing of gser->ioport and thus causing null pointer
> dereference. Add a null pointer check to prevent it as the bellow
> patch does:
> 5ec63fdbca60 ("usb: gadget: u_serial: Add null pointer check in gserial_resume")
> 
> Fixes: aba3a8d01d62 ("usb: gadget: u_serial: add suspend resume callbacks")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>   drivers/usb/gadget/function/u_serial.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
> index a0ca47fbff0f..40ba220cf6d2 100644
> --- a/drivers/usb/gadget/function/u_serial.c
> +++ b/drivers/usb/gadget/function/u_serial.c
> @@ -1420,10 +1420,18 @@ EXPORT_SYMBOL_GPL(gserial_disconnect);
>   
>   void gserial_suspend(struct gserial *gser)
>   {
> -	struct gs_port	*port = gser->ioport;
> +	struct gs_port	*port;
>   	unsigned long	flags;
>   
> -	spin_lock_irqsave(&port->port_lock, flags);
> +	spin_lock_irqsave(&serial_port_lock, flags);
> +	port = gser->ioport;
> +	if (!port) {
> +		spin_unlock_irqrestore(&serial_port_lock, flags);
> +		return;
> +	}
> +
> +	spin_lock(&port->port_lock);
> +	spin_unlock(&serial_port_lock);
>   	port->suspended = true;
>   	spin_unlock_irqrestore(&port->port_lock, flags);
>   }
Hi Chunfeng,

This looks same as the following patch.
https://lore.kernel.org/linux-usb/1683278317-11774-1-git-send-email-quic_prashk@quicinc.com/ 


Regards
