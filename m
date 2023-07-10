Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C7E74CE00
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjGJHKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjGJHKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:10:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAEFEB;
        Mon, 10 Jul 2023 00:10:40 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36A4UIXN021222;
        Mon, 10 Jul 2023 07:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dCm0/Vy6asPs4IBh53btJ9D//kXAfuuaZbmgUQVFn1k=;
 b=hvWkPTtOMLETSPrOu5SPSG6/V/0Na2DWUT0ijRh3k2a2/2K1e57IzsLsBkkV81LSvV4d
 VaTbVHVEpnXXFZf0vzKNA01/Y79Ujv9P2eR2utBu6Cv/0GUkSWxI/026+sVh90BRRczE
 84FCwUuIDD9YuJhfWoI+ITqwhftpjWJ8IxHSMGbn/rWAPviFHnHkrPv86wN0D/XhiTeC
 fZnBfIf4h/IRfNDSpHo72jiebiCY32DQRJ6rIBxIPJ9B3UOLJDLZET4mA6P1Fw4RR8E3
 hLr89RYg6Sc0zOOfez6gUcPJH+jVAlzQYAeCRZi61OINoRKHGy7LEXgUYAU0GKE3AuQD CQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rq13f2pnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 07:10:36 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36A7AZoX007887
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 07:10:35 GMT
Received: from [10.50.37.218] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 10 Jul
 2023 00:10:31 -0700
Message-ID: <931fe2af-85a8-ad0d-8869-2907db9fff25@quicinc.com>
Date:   Mon, 10 Jul 2023 12:40:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH][next] media: venus: Use struct_size_t() helper in
 pkt_session_unset_buffers()
Content-Language: en-US
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <ZKBfoqSl61jfpO2r@work>
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <ZKBfoqSl61jfpO2r@work>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4CAE994kF6N4fs_aYf5ll27cOi-b8Num
X-Proofpoint-ORIG-GUID: 4CAE994kF6N4fs_aYf5ll27cOi-b8Num
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_05,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 malwarescore=0 mlxscore=0 spamscore=0
 mlxlogscore=918 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307100065
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/1/2023 10:47 PM, Gustavo A. R. Silva wrote:
> Prefer struct_size_t() over struct_size() when no pointer instance
> of the structure type is present.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Vikash Garodia <quic_vgarodia@quicinc.com>

> ---
>  drivers/media/platform/qcom/venus/hfi_cmds.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
> index 7f0802a5518c..3418d2dd9371 100644
> --- a/drivers/media/platform/qcom/venus/hfi_cmds.c
> +++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
> @@ -251,8 +251,8 @@ int pkt_session_unset_buffers(struct hfi_session_release_buffer_pkt *pkt,
>  
>  		pkt->extradata_size = 0;
>  		pkt->shdr.hdr.size =
> -			struct_size((struct hfi_session_set_buffers_pkt *)0,
> -				    buffer_info, bd->num_buffers);
> +			struct_size_t(struct hfi_session_set_buffers_pkt,
> +				      buffer_info, bd->num_buffers);
>  	}
>  
>  	pkt->response_req = bd->response_required;
