Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC4967AAB8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 08:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbjAYHLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 02:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjAYHLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 02:11:06 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CA05260;
        Tue, 24 Jan 2023 23:11:01 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30P5wYg8018646;
        Wed, 25 Jan 2023 07:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RBqV54Nrv3kEwv1XiZhZaXvmfcZ+NG4YbScD4yT8hfY=;
 b=TPn1qqnRFxfPfz1TlM7g2K1qT46MS3mCAp3/jZ/KsgncT4lju4RmYqPvzlTzx2Qvi1s1
 zbKWCZmwf628mgWa2ZjsCBebAb8EgqOY/dE3DFHUkdRIgIImQaik0yNDsziqKbSXbG/+
 TBUI+YMfJPyMrstLuaT3nks09MhRyVaUt5UGgt2SY/S/nrfElDXSJXbHDkTU3xwFF28/
 AwLPgaaVaw4lu0ZcO/LYo4K1uVFTkp3oJC2BahvjTy8dQZGErVCMOxB99u+daTH2HRja
 BIBpv77aDGT6CYUUVawODdwCLsHb7ZerXJ1Jgr8xJv5Rw+ZEyad75TOl9GieCMY9f4Bd Ig== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3napvhgqv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 07:10:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30P7AuLI010384
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 07:10:56 GMT
Received: from [10.110.119.13] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 24 Jan
 2023 23:10:56 -0800
Message-ID: <6289c682-d5e0-8871-36a2-f9a02d98829d@quicinc.com>
Date:   Tue, 24 Jan 2023 23:10:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 3/6] rpmsg: glink: rpm: Wrap driver context
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230109224001.1706516-1-quic_bjorande@quicinc.com>
 <20230109224001.1706516-4-quic_bjorande@quicinc.com>
From:   Chris Lew <quic_clew@quicinc.com>
In-Reply-To: <20230109224001.1706516-4-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -HQpqmMNeT3IMh7e-5SX6wsEx7u13S08
X-Proofpoint-ORIG-GUID: -HQpqmMNeT3IMh7e-5SX6wsEx7u13S08
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_03,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 adultscore=0 impostorscore=0 mlxscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250065
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/2023 2:39 PM, Bjorn Andersson wrote:
> As with the SMEM driver update, wrap the RPM context in a struct to
> facilitate the upcoming changes of moving IRQ and mailbox registration
> to the driver.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---

Reviewed-by: Chris Lew <quic_clew@quicinc.com>

>   drivers/rpmsg/qcom_glink_rpm.c | 44 ++++++++++++++++++++--------------
>   1 file changed, 26 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/rpmsg/qcom_glink_rpm.c b/drivers/rpmsg/qcom_glink_rpm.c
> index f64f45d1a735..6443843df6ca 100644
> --- a/drivers/rpmsg/qcom_glink_rpm.c
> +++ b/drivers/rpmsg/qcom_glink_rpm.c
> @@ -53,6 +53,13 @@ struct glink_rpm_pipe {
>   	void __iomem *fifo;
>   };
>   
> +struct glink_rpm {
> +	struct qcom_glink *glink;
> +
> +	struct glink_rpm_pipe rx_pipe;
> +	struct glink_rpm_pipe tx_pipe;
> +};
> +
>   static size_t glink_rpm_rx_avail(struct qcom_glink_pipe *glink_pipe)
>   {
>   	struct glink_rpm_pipe *pipe = to_rpm_pipe(glink_pipe);
> @@ -257,8 +264,7 @@ static int glink_rpm_parse_toc(struct device *dev,
>   static int glink_rpm_probe(struct platform_device *pdev)
>   {
>   	struct qcom_glink *glink;
> -	struct glink_rpm_pipe *rx_pipe;
> -	struct glink_rpm_pipe *tx_pipe;
> +	struct glink_rpm *rpm;
>   	struct device_node *np;
>   	void __iomem *msg_ram;
>   	size_t msg_ram_size;
> @@ -266,9 +272,8 @@ static int glink_rpm_probe(struct platform_device *pdev)
>   	struct resource r;
>   	int ret;
>   
> -	rx_pipe = devm_kzalloc(&pdev->dev, sizeof(*rx_pipe), GFP_KERNEL);
> -	tx_pipe = devm_kzalloc(&pdev->dev, sizeof(*tx_pipe), GFP_KERNEL);
> -	if (!rx_pipe || !tx_pipe)
> +	rpm = devm_kzalloc(&pdev->dev, sizeof(*rpm), GFP_KERNEL);
> +	if (!rpm)
>   		return -ENOMEM;
>   
>   	np = of_parse_phandle(dev->of_node, "qcom,rpm-msg-ram", 0);
> @@ -283,36 +288,39 @@ static int glink_rpm_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	ret = glink_rpm_parse_toc(dev, msg_ram, msg_ram_size,
> -				  rx_pipe, tx_pipe);
> +				  &rpm->rx_pipe, &rpm->tx_pipe);
>   	if (ret)
>   		return ret;
>   
>   	/* Pipe specific accessors */
> -	rx_pipe->native.avail = glink_rpm_rx_avail;
> -	rx_pipe->native.peak = glink_rpm_rx_peak;
> -	rx_pipe->native.advance = glink_rpm_rx_advance;
> -	tx_pipe->native.avail = glink_rpm_tx_avail;
> -	tx_pipe->native.write = glink_rpm_tx_write;
> +	rpm->rx_pipe.native.avail = glink_rpm_rx_avail;
> +	rpm->rx_pipe.native.peak = glink_rpm_rx_peak;
> +	rpm->rx_pipe.native.advance = glink_rpm_rx_advance;
> +	rpm->tx_pipe.native.avail = glink_rpm_tx_avail;
> +	rpm->tx_pipe.native.write = glink_rpm_tx_write;
>   
> -	writel(0, tx_pipe->head);
> -	writel(0, rx_pipe->tail);
> +	writel(0, rpm->tx_pipe.head);
> +	writel(0, rpm->rx_pipe.tail);
>   
> -	glink = qcom_glink_native_probe(&pdev->dev,
> +	glink = qcom_glink_native_probe(dev,
>   					0,
> -					&rx_pipe->native,
> -					&tx_pipe->native,
> +					&rpm->rx_pipe.native,
> +					&rpm->tx_pipe.native,
>   					true);
>   	if (IS_ERR(glink))
>   		return PTR_ERR(glink);
>   
> -	platform_set_drvdata(pdev, glink);
> +	rpm->glink = glink;
> +
> +	platform_set_drvdata(pdev, rpm);
>   
>   	return 0;
>   }
>   
>   static int glink_rpm_remove(struct platform_device *pdev)
>   {
> -	struct qcom_glink *glink = platform_get_drvdata(pdev);
> +	struct glink_rpm *rpm = platform_get_drvdata(pdev);
> +	struct qcom_glink *glink = rpm->glink;
>   
>   	qcom_glink_native_remove(glink);
>   
