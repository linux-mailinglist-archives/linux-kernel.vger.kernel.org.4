Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BD46A1559
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 04:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjBXD1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 22:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBXD1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 22:27:48 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944FA4FA97;
        Thu, 23 Feb 2023 19:27:47 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NBTq55005266;
        Fri, 24 Feb 2023 03:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=1+JOOQn1SJtiyYuvhrHQ01Gr+kmjamTm0SxGh62fztM=;
 b=UWPCxdvUdSHuomfc5UEBfvS4K9MprEd4ufEWCEXBqagufgZHbaxDwm9Pr3db88NbKjbz
 GTzRNyE+kN8lQqrkPvtC13TkyqGtD+CPgCNx+t/qbKyuHQiTcEhmk7ek9T19wFZ2CXzm
 cvTYnsso1VUcLnsLBoWUU6iVT/UDjNCEo9t0gJ1/MUBHuswaVSZk/1zF1OSN4gBfMZus
 +uTwfBphho+LVkaT3cpqEEBpLfRKEDTMfcdqSTgSARJl1DaWd9lJNWiMpmLzOOVcHT2L
 2TqvTMDi30aoQXH544HP/sx0di1RARMJvKzsUI1UH9NccwbRJ/4lwVJaLJqaq/RzGgIv bw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nwybm3hg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 03:27:42 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31O3Rfe5019543
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 03:27:41 GMT
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 23 Feb
 2023 19:27:40 -0800
Date:   Thu, 23 Feb 2023 19:27:39 -0800
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Huang Yiwei <quic_hyiwei@quicinc.com>
CC:     <mani@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_satyap@quicinc.com>, <quic_aiquny@quicinc.com>
Subject: Re: [PATCH] mailbox: qcom-ipcc: Support multiple channels for a
 given client
Message-ID: <20230224032739.GA15837@quicinc.com>
References: <20230223061318.1793-1-quic_hyiwei@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230223061318.1793-1-quic_hyiwei@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -EZIlfKClqeovBw_sfFsEvZBys1_S3MJ
X-Proofpoint-GUID: -EZIlfKClqeovBw_sfFsEvZBys1_S3MJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_15,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=723
 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240025
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 23 2023 14:13, Huang Yiwei wrote:
> Recently a new use case where two signals for the same protocol and
> client is needed, that means there will be more than one channel
> for a mbox node. Current driver only supports one channel, so need
> to remove the limitation and let the driver find every channel
> correctly.
> 
> Signed-off-by: Huang Yiwei <quic_hyiwei@quicinc.com>
> ---
>  drivers/mailbox/qcom-ipcc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mailbox/qcom-ipcc.c b/drivers/mailbox/qcom-ipcc.c
> index 7e27acf6c0cc..367658af089e 100644
> --- a/drivers/mailbox/qcom-ipcc.c
> +++ b/drivers/mailbox/qcom-ipcc.c
> @@ -226,11 +226,9 @@ static int qcom_ipcc_setup_mbox(struct qcom_ipcc *ipcc,
>  		for (j = 0; j < i; j++) {
>  			ret = of_parse_phandle_with_args(client_dn, "mboxes",
>  						"#mbox-cells", j, &curr_ph);
> -			of_node_put(curr_ph.np);
> -			if (!ret && curr_ph.np == controller_dn) {
> +			if (!ret && curr_ph.np == controller_dn)
>  				ipcc->num_chans++;
> -				break;
> -			}
> +			of_node_put(curr_ph.np);

of_node_put can stay where it is - the main change is the removal of the break,
is it not?

Guru Das.
