Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C292A6FE63B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 23:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbjEJVZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 17:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236208AbjEJVZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 17:25:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0BC2D57;
        Wed, 10 May 2023 14:25:10 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34ALFguE017613;
        Wed, 10 May 2023 21:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3G7ROuSmnEIVSHXc7PdXlYcVyFso/euyqEayPBlEkUg=;
 b=Z1SAjSlpx1+rAY9ZySREmJ/H2ZHaEv5k/K8OQiYveg4mpAG+SvoiAe9bATCKLdicgL87
 Vlp3D8Jvt5pAYGER+D7B/JWCMsdwA0N9VF0mudDNuRPLzvHiTFtgo0V2UynQ9TKZMsQG
 UZ+fBkfVQheDKVE5OXmMQmUASWaVw4USFdRgreCAhiy/Pw+t5HkPjKAOQa3NWxe9ffzq
 JRpAXchKihYJavOlnCVZaEoPJbNuGpaMq28B9O5byh4oasj8/oFF5sldU8jcvJAm+xAs
 TV6vh9YoDrfOF9Cz1pn3o2SGnVUDDDpwx7guxoDyGgMxsHWKfTvfAm1/JZCr4r0ZoXnr UA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qgett0hh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 21:24:52 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34ALOpLG019535
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 21:24:51 GMT
Received: from [192.168.143.77] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 10 May
 2023 14:24:51 -0700
Message-ID: <991cac52-22bc-0150-4332-76ac044c5bcb@quicinc.com>
Date:   Wed, 10 May 2023 14:24:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH v1] ufs: poll HCS.UCRDY before issuing a UIC command
Content-Language: en-US
To:     Kiwoong Kim <kwmad.kim@samsung.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alim.akhtar@samsung.com>,
        <avri.altman@wdc.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <beanhuo@micron.com>,
        <adrian.hunter@intel.com>, <sc.suh@samsung.com>,
        <hy50.seo@samsung.com>, <sh425.lee@samsung.com>,
        <kwangwon.min@samsung.com>
References: <CGME20230509083312epcas2p375f77d18a9026f7d263750baf9c9a5bb@epcas2p3.samsung.com>
 <1683620674-160173-1-git-send-email-kwmad.kim@samsung.com>
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
In-Reply-To: <1683620674-160173-1-git-send-email-kwmad.kim@samsung.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XPkKfCMl94N57ZMohYB-qrxneAlY1hgC
X-Proofpoint-GUID: XPkKfCMl94N57ZMohYB-qrxneAlY1hgC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305100175
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/2023 1:24 AM, Kiwoong Kim wrote:
> With auto hibern8 enabled, UIC could be working
> for a while to process a hibern8 operation and HCI
> reports UIC not ready for a short term through HCS.UCRDY.
> And UFS driver can't recognize the operation.
> UFSHCI spec specifies UCRDY like this:
> whether the host controller is ready to process UIC COMMAND
> 
> The 'ready' could be seen as many different meanings. If the meaning
> includes not processing any request from HCI, processing a hibern8
> operation can be 'not ready'. In this situation, the driver needs to
> wait until the operations is completed.
> 
> Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
> ---
>   drivers/ufs/core/ufshcd.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 96ce6af..fc79539 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -2368,7 +2368,18 @@ static inline int ufshcd_hba_capabilities(struct ufs_hba *hba)
>    */
>   static inline bool ufshcd_ready_for_uic_cmd(struct ufs_hba *hba)
>   {
> -	return ufshcd_readl(hba, REG_CONTROLLER_STATUS) & UIC_COMMAND_READY;
> +	ktime_t timeout = ktime_add_ms(ktime_get(), UIC_CMD_TIMEOUT);
> +	u32 val = 0;
> +
> +	do {
> +		val = ufshcd_readl(hba, REG_CONTROLLER_STATUS) &
> +			UIC_COMMAND_READY;
> +		if (val)
> +			break;
> +		usleep_range(500, 1000);
Hi Kiwoong,
It looks like you are sleeping while holding the 
spin_lock_irqsave(hba->host->host_lock, flags)
in ufshcd_send_uic_cmd()?


> +	} while (ktime_before(ktime_get(), timeout));
> +
> +	return val ? true : false;
>   }
>   
>   /**

