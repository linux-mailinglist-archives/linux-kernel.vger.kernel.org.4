Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA97629187
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 06:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbiKOFdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 00:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbiKOFds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 00:33:48 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CAB10BA;
        Mon, 14 Nov 2022 21:33:47 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AF57wxa020298;
        Tue, 15 Nov 2022 05:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=b/59L43usoKzRtQpoB91HVlS8TPRiKRWN8UcCjU7Kh4=;
 b=BDe+SZiw37948l5v4bHK+KbID4n5+8a+lakAPQnYlc19gPovR8k+1f46OIXxUlB+0Pn8
 R7lFtq546H8rkf4K3+jhEhuzJ5lXAWzmSrFR3F9ubtWWxdFAtbupuVXgM612yFgV4saZ
 H/RLssJciCZofJNu2v5IRuMIFV2eCFmVYDo/uiKz0lxh+85zzzppfDz7KrTC3HGtkOB0
 qpg5m219hprMj3elhppPH/qd+V9uBdKiwtKiJT7HgkXIZfM2w5pXC8AZak9rIr1TrF6/
 YShShwxwQCM8aRWG4hHHB8JnudC6itCka43R/xH9UDooepaT3uaqJclZbAD7ilk1qflh UQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kut9rs8hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 05:33:39 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AF5XcdQ017171
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 05:33:38 GMT
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 14 Nov
 2022 21:33:37 -0800
Date:   Mon, 14 Nov 2022 21:33:36 -0800
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Sibi Sankar <quic_sibis@quicinc.com>
CC:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <agross@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <konrad.dybcio@somainline.org>,
        <robimarko@gmail.com>, <quic_rjendra@quicinc.com>
Subject: Re: [PATCH V4 2/2] firmware: qcom: scm: Add wait-queue handling logic
Message-ID: <20221115053336.GA29781@quicinc.com>
References: <20221114082644.28739-1-quic_sibis@quicinc.com>
 <20221114082644.28739-3-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221114082644.28739-3-quic_sibis@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: G8MqgC9_5CTL3Nhyj7b6hQjsEiz8sfyd
X-Proofpoint-GUID: G8MqgC9_5CTL3Nhyj7b6hQjsEiz8sfyd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_15,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=768 clxscore=1011 phishscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211150040
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 14 2022 13:56, Sibi Sankar wrote:

(snip)

> +static irqreturn_t qcom_scm_irq_handler(int irq, void *data)
> +{
> +	int ret;
> +	struct qcom_scm *scm = data;
> +	struct completion *wq_to_wake;
> +	u32 wq_ctx, flags, more_pending = 0;
> +
> +	do {
> +		ret = scm_get_wq_ctx(&wq_ctx, &flags, &more_pending);
> +		if (ret) {
> +			dev_err(scm->dev, "GET_WQ_CTX SMC call failed: %d\n", ret);
> +			goto out;
> +		}
> +
> +		wq_to_wake = qcom_scm_lookup_wq(scm, wq_ctx);
> +		if (IS_ERR_OR_NULL(wq_to_wake)) {
> +			dev_err(scm->dev, "No waitqueue found for wq_ctx %d: %ld\n",
> +				wq_ctx, PTR_ERR(wq_to_wake));
> +			goto out;
> +		}
> +
> +		if (flags != QCOM_SMC_WAITQ_FLAG_WAKE_ONE &&
> +		    flags != QCOM_SMC_WAITQ_FLAG_WAKE_ALL) {
> +			dev_err(scm->dev, "Invalid Flags found for wq_ctx: %u\n", flags);
> +			goto out;
> +		}
> +
> +		complete(wq_to_wake);

Need to call complete() or complete_all() based on the flags.

> +	} while (more_pending);
> +
> +out:
> +	return IRQ_HANDLED;
> +}
