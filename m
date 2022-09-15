Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EFC5B9D37
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiIOOeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiIOOeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:34:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B87F8A1D2;
        Thu, 15 Sep 2022 07:34:07 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FETS4k023581;
        Thu, 15 Sep 2022 14:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RYPfsoQxc06tcZQunrZJdvK12bl48t2xonjXL0dWddA=;
 b=jAj97wuU6LLfMwPGukrYpX2ecSRup0exDAWVLxSS1xANT7oUtkrD90mxoxxIrL3TUFkl
 gBOj3aqKanwP72zHaNgAJWSf+rQHlgFyRH75gPq/col6OsMlhnpLrOp+LhLYOyccTJS+
 sdk5pWlBvlbIRgxxwfOOT2SIO/SkGM7p4OFUDFg11Q7iohFwG9qKPISEtEC5xKs9oujl
 kfa+7dDUtKpyS+2qm3IjoxrHZBafodssxq9FIAPSowo6atZ8nUO96EFZiZ/JGFVwj/PC
 fv8PSbGCynT/XRSzGLoqBQSqS9jQirHHI2Nu28zahhgyeTF/fAuguiS8gQHc4QdsRmdW ig== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jm2r88g6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 14:34:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28FEY2Wo032605
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 14:34:02 GMT
Received: from [10.110.52.115] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 15 Sep
 2022 07:34:01 -0700
Message-ID: <643bcf80-111e-d8b3-8965-2a27b9c6d642@quicinc.com>
Date:   Thu, 15 Sep 2022 07:34:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V4 2/2] rpmsg: ctrl: Add lock to rpmsg_ctrldev_remove
Content-Language: en-US
To:     Deepak Kumar Singh <quic_deesin@quicinc.com>,
        <bjorn.andersson@linaro.org>, <arnaud.pouliquen@foss.st.com>,
        <swboyd@chromium.org>, <quic_clew@quicinc.com>,
        <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>
References: <1663235055-3081-1-git-send-email-quic_deesin@quicinc.com>
 <1663235055-3081-3-git-send-email-quic_deesin@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <1663235055-3081-3-git-send-email-quic_deesin@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1BiQdjyP1E_ao1gkSu2_Aa8CdsOv3D9x
X-Proofpoint-GUID: 1BiQdjyP1E_ao1gkSu2_Aa8CdsOv3D9x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_08,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209150084
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/2022 2:44 AM, Deepak Kumar Singh wrote:
> Call to rpmsg_ctrldev_ioctl() and rpmsg_ctrldev_remove() must be synchronized.
> In present code rpmsg_ctrldev_remove() is not protected with lock, therefore
> new char device creation can succeed through rpmsg_ctrldev_ioctl() call. At the
> same time call to rpmsg_ctrldev_remove() funtion for ctrl device removal will

nit: s/funtion/function/

> free associated rpdev device. As char device creation already succeeded, user
> space is free to issue open() call which maps to rpmsg_create_ept() in kernel.
> rpmsg_create_ept() function tries to reference rpdev which has already been
> freed through rpmsg_ctrldev_remove(). Issue is predominantly seen in aggressive
> reboot tests where rpmsg_ctrldev_ioctl() and rpmsg_ctrldev_remove() can race with
> each other.
> 
> Adding lock in rpmsg_ctrldev_remove() avoids any new char device creation
> throught rpmsg_ctrldev_ioctl() while remove call is already in progress.

nit: s/throught/through/
> 
> Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
> ---
>   drivers/rpmsg/rpmsg_ctrl.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/rpmsg/rpmsg_ctrl.c b/drivers/rpmsg/rpmsg_ctrl.c
> index 107da70..4332538 100644
> --- a/drivers/rpmsg/rpmsg_ctrl.c
> +++ b/drivers/rpmsg/rpmsg_ctrl.c
> @@ -194,10 +194,12 @@ static void rpmsg_ctrldev_remove(struct rpmsg_device *rpdev)
>   	struct rpmsg_ctrldev *ctrldev = dev_get_drvdata(&rpdev->dev);
>   	int ret;
>   
> +	mutex_lock(&ctrldev->ctrl_lock);
>   	/* Destroy all endpoints */
>   	ret = device_for_each_child(&ctrldev->dev, NULL, rpmsg_chrdev_eptdev_destroy);
>   	if (ret)
>   		dev_warn(&rpdev->dev, "failed to nuke endpoints: %d\n", ret);
> +	mutex_unlock(&ctrldev->ctrl_lock);
>   
>   	cdev_device_del(&ctrldev->cdev, &ctrldev->dev);
>   	put_device(&ctrldev->dev);

