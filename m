Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD3D6A0352
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 08:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbjBWHeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 02:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbjBWHeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 02:34:03 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0E02D173;
        Wed, 22 Feb 2023 23:33:52 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31N49MxA004582;
        Thu, 23 Feb 2023 07:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=tCiLjuNpHdI1kGU6O309ycvOn4BKCBcI8K5P1CNfrWc=;
 b=RcRzdzd32p9izvTXL4EvfDN9HUKrGsMzIKTwgmgqeZgyv55YCCRMeknhELKYybtNUZg2
 GnnsjYBKosr7al37M9n3085edCb5SojHGN8OhmIzoRpnVDbTrX/74PMFWkdB+bDag/cJ
 UiLzE32cVvwTRFKnc1Cq1U/Fw1KoQUV8mpYxCXqt0CL8bH4l62ZKvdzelDCLYshGUJV5
 hMNB8Wt4qFpNH8s1JX+l0ipOO2wIwU5tvgGP8F1gn3xGGWSQY2TWuu9dRt1oVpJ4xIb1
 ipSnO8NdsYxakqW9FChuV/XLKXK7pACRJoNwJmt4i/QvDu8YTqnRMf/GkIK3AsXVfyCx Ow== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nwywd0j4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 07:33:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31N7XlAW025272
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 07:33:47 GMT
Received: from hu-jackp-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 22 Feb 2023 23:33:47 -0800
Date:   Wed, 22 Feb 2023 23:33:29 -0800
From:   Jack Pham <quic_jackp@quicinc.com>
To:     Prashanth K <quic_prashk@quicinc.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        =?iso-8859-1?Q?J=F3_=C1gila?= Bitsch <jgilab@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] usb: gadget: composite: Draw 100mA current if not
 configured
Message-ID: <20230223073329.GA3727894@hu-jackp-lv.qualcomm.com>
References: <1677129510-10283-1-git-send-email-quic_prashk@quicinc.com>
 <1677129510-10283-3-git-send-email-quic_prashk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1677129510-10283-3-git-send-email-quic_prashk@quicinc.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zSw8PFtmXfHTmh-Xu3ehXPJJpBxJQJCh
X-Proofpoint-ORIG-GUID: zSw8PFtmXfHTmh-Xu3ehXPJJpBxJQJCh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_04,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 clxscore=1011 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=749
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302230064
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashanth,

On Thu, Feb 23, 2023 at 10:48:30AM +0530, Prashanth K wrote:
> Currently we don't change the current value if device isn't in
> configured state. But the battery charging specification says,
> the device can draw upto 100mA of current if its in unconfigured

Here you say spec says "up to" (BTW you have a typo) 100mA...

> state. Hence add a Vbus_draw work in composite_resume to draw
> 100mA if the device isn't configured.

But here and in the patch you are calling the function to draw exactly
100mA.  Consider the possibility that a gadget could be configured to
draw less current than that or not anything at all, we should make sure
to honor that as an absolute maximum.

> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
> ---
>  drivers/usb/gadget/composite.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
> index fa7dd6c..147d278 100644
> --- a/drivers/usb/gadget/composite.c
> +++ b/drivers/usb/gadget/composite.c
> @@ -2531,6 +2531,8 @@ void composite_resume(struct usb_gadget *gadget)
>  			usb_gadget_clear_selfpowered(gadget);
>  
>  		usb_gadget_vbus_draw(gadget, maxpower);
> +	} else {
> +		usb_gadget_vbus_draw(gadget, 100);

Similar to the configured case, maybe you can perform a min()
calculation against either or both the config->MaxPower or
CONFIG_USB_GADGET_VBUS_DRAW.

Thanks,
Jack
