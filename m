Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1846E68CD3C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 04:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjBGDPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 22:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjBGDPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:15:37 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D687314499;
        Mon,  6 Feb 2023 19:15:26 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3171wv0Q021202;
        Tue, 7 Feb 2023 03:15:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KrvOc6elVm0A496D2vDI+LpC2f0xux8IGkIfFml1Mkg=;
 b=Ng3SmIazFxRgoyJrdhV6VRME31Yu/lVDE2LeFAk9KGpRH9MY6ms5p/+nzp/9yjF6/B7p
 TTsjSlB/gKU/7XFe9ByL+jhAoyaTPOAY9WAm7X4qujkFCz8acE/CpGCUJzV7aXZXF6w3
 8D87iRmy9YffLlLoTTD00I7IrOi8RzhwGZI+zxR3Eg/KmwAKVZGJFSQZ5/ep1K1VbaDW
 aYerMlUy3Jlys3VlK3v3CnWhxA1P48Ffq1nux6CUQLG5dGIuQ+1q9IaMbbNpUcdgfJyQ
 zreBlLR/2QYttKDMTJyqs8oOejqgTlHeGY65UoQLVe9rcpw1WbaRhUVSzl7d5E57LwUC WA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nkdey85g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 03:15:14 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3173FDgs005773
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Feb 2023 03:15:13 GMT
Received: from [10.47.206.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 19:15:12 -0800
Message-ID: <4c64f23d-a743-acb7-58eb-a6f02d369b34@quicinc.com>
Date:   Mon, 6 Feb 2023 19:15:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 07/22] rtc: pm8xxx: use unaligned le32 helpers
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bjorn Andersson <andersson@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230202155448.6715-1-johan+linaro@kernel.org>
 <20230202155448.6715-8-johan+linaro@kernel.org>
From:   David Collins <quic_collinsd@quicinc.com>
In-Reply-To: <20230202155448.6715-8-johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EHviRA3_M76anQUiKYRkWV1Qarw5x0Z3
X-Proofpoint-GUID: EHviRA3_M76anQUiKYRkWV1Qarw5x0Z3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxlogscore=904 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302070027
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/23 07:54, Johan Hovold wrote:
> Use the unaligned le32 helpers instead of open coding when accessing the
> time and alarm registers.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/rtc/rtc-pm8xxx.c | 26 ++++++++------------------
>  1 file changed, 8 insertions(+), 18 deletions(-)

Reviewed-by: David Collins <quic_collinsd@quicinc.com>

Take care,
David

