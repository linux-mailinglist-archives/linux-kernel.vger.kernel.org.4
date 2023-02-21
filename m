Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF8F69E3FB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 16:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbjBUPxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 10:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbjBUPxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 10:53:45 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF87CC1B;
        Tue, 21 Feb 2023 07:53:44 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LCbPqM026160;
        Tue, 21 Feb 2023 15:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=F0bEi225clmFHMBmgr9awg4R3d+FiQcGc8Ky4+gvTQU=;
 b=fvz029rlj1GTfaBm4yrXzpD223hax3AqKbLVkqWWCTQXLyYVLJ2mfI5lg0Z22vj5RjzR
 fQZfmo0re+/gE+CTdBd3XLCpDDPpgaqhSqyD+VFwqOGz/uM6zWDtKIbk4izCiOtY/Cz3
 t3DVLQ6llQFnV5t7Ae0e9giwA/7buBbI3tg7FmaqCi9y9Z6brwxcIjklG1W0LriOyVrc
 nxiW4qLF4a4EpEnPYTu6g/FBfQhZG2iwv2auKtzlGrjYke0tjtpDgMSHtr7AS745MrOM
 K4i8Tn747ZY3Ns0dTKCySGcFFazACZ8sAB0th7MN5crF2EdcUtt1HvKFIyUy4g2xKNrN mw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nvp4v1gbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 15:52:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31LFqxBG013565
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 15:52:59 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 21 Feb
 2023 07:52:58 -0800
Message-ID: <0e630740-6913-0fb0-3ba1-1afc0aa61669@quicinc.com>
Date:   Tue, 21 Feb 2023 08:52:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V1] bus: mhi: host: Avoid ringing EV DB if there is no
 elements to process
Content-Language: en-US
To:     Vivek Pernamitta <quic_vpernami@quicinc.com>, <mhi@lists.linux.dev>
CC:     <quic_qianyu@quicinc.com>, <manivannan.sadhasivam@linaro.org>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        Alex Elder <elder@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        Paul Davey <paul.davey@alliedtelesis.co.nz>,
        "open list:MHI BUS" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1676974528-963-1-git-send-email-quic_vpernami@quicinc.com>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <1676974528-963-1-git-send-email-quic_vpernami@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: s3Jg8BuM1oIxND0GsZpNsMoMM5FF0yb7
X-Proofpoint-GUID: s3Jg8BuM1oIxND0GsZpNsMoMM5FF0yb7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_08,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=771
 clxscore=1011 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210131
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/2023 3:15 AM, Vivek Pernamitta wrote:
> Avoid ringing Event DB if there is no elements to process.
> As mhi_poll function can be called by mhi client drivers
> which will call process_event, which will ring DB even if
> there no ring elements to process.
> 
> Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
> ---
>   drivers/bus/mhi/host/main.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> index df0fbfe..8bf8394 100644
> --- a/drivers/bus/mhi/host/main.c
> +++ b/drivers/bus/mhi/host/main.c
> @@ -1031,7 +1031,9 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
>   		count++;
>   	}
>   	read_lock_bh(&mhi_cntrl->pm_lock);
> -	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl)))
> +
> +	/* Ring EV DB only if there is any pending element to process */
> +	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl)) && count)
>   		mhi_ring_er_db(mhi_event);
>   	read_unlock_bh(&mhi_cntrl->pm_lock);
>   

Seems like this optimization also applies to mhi_process_ctrl_ev_ring(). 
  Why not update that as well?
