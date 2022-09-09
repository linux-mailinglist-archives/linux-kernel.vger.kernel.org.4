Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA78E5B31FF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiIIIlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiIIIlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:41:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D8E1177BC;
        Fri,  9 Sep 2022 01:41:48 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2898YZiM032516;
        Fri, 9 Sep 2022 08:41:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7f4hf7+hMQph/clwgyAM77ojAQotmL6rbfg/BHdxJuY=;
 b=VehycXc7StbJruC2yJzFTrHvRUCOEciGzP1rsnCoQzVvVQJClQpyd0BrqDcQKE5pgT0d
 FwgfiTvhd8YrrjJUlJinfq6w5aIh7PGrFcvyteFXtM1wg17elfw9p15l2ueBDXqzohNf
 76Dgl1YPslY0egAge1WQHHaj+tiqcEsLlndXr+z7tHTyTBAt+lH60N3H7nE5uk43qtMQ
 a67c9UIwXS8GdNM2ZHoBf3RRrGgIrX0MlDC8inEvZm3cclnyodMVu3qlAWuW7q+GvCNR
 QYazZNDdK6zAFsAQrnDadLerOlGnZVvL9nV+hinSd5ZZRetEPLZcGFOz/zfN8CpP4zKL lw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jfeuuv5m0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 08:41:47 +0000
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2898fl8N003568
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Sep 2022 08:41:47 GMT
Received: from [10.239.133.73] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 9 Sep 2022
 01:41:45 -0700
Message-ID: <de6028e6-1f0d-0b3c-979e-897271f2c51e@quicinc.com>
Date:   Fri, 9 Sep 2022 16:41:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] remoteproc: core: do pm relax when not first crash
To:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_clew@quicinc.com>
References: <1662710731-57212-1-git-send-email-quic_aiquny@quicinc.com>
From:   "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
In-Reply-To: <1662710731-57212-1-git-send-email-quic_aiquny@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MM0sXj4eJpY03fRCCPbB-g9rDItp5JDd
X-Proofpoint-GUID: MM0sXj4eJpY03fRCCPbB-g9rDItp5JDd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_04,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209090029
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/2022 4:05 PM, Maria Yu wrote:
> Even if it is not first crash, need to relax the pm
> wakelock otherwise the device will stay awake.
> 
> Change-Id: I26bfeb44871aab0b57837a77a6243b2086f94473
Removed Change-Id in the later new patchset.
Pls ignore this.
> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
> ---
>   drivers/remoteproc/remoteproc_core.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index e5279ed9a8d7..30078043e939 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1956,6 +1956,7 @@ static void rproc_crash_handler_work(struct work_struct *work)
>   	if (rproc->state == RPROC_CRASHED || rproc->state == RPROC_OFFLINE) {
>   		/* handle only the first crash detected */
>   		mutex_unlock(&rproc->lock);
> +		pm_relax(rproc->dev.parent);
>   		return;
>   	}
>   
> 


-- 
Thx and BRs,
Aiqun(Maria) Yu
