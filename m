Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B71968CD40
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 04:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjBGDPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 22:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjBGDPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:15:37 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4375414490;
        Mon,  6 Feb 2023 19:15:29 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3171wrT6021183;
        Tue, 7 Feb 2023 03:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DYdFQ1BRn/zSjfjTIoIcss+VZAzEi4LZGv1zM/L38CQ=;
 b=KDXAVLSkiS5JSH8zialh59ik8pa3qm+6DRii/vtpINuVqR1O6VBSyPOXS7mY/ilRRgyy
 hkmi+39le+41u2CWzQ/ltwfJfFsXM6EQrjAQhla6KU3DXKNMEGzUIDyy69iP6ONPZT/r
 BF8Ngvp+3LSTq5K3HnKRkJTVLLVmdZHA6PiPOkammiSq9h+8ozLHIceUJwzcjd50lG6b
 jO7lg473kD0hzvZiDmkUWO/DaXn4Gn2PYJHGu75wV1NnscFvVUD3wbm814WupK8HDorC
 XuGkZx6c/o45QV9y/qw0sqnJyc4LMiOD0ecvO4eCF9ovGGEzC4cRDE4HtinbVBdjsINx mw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nkdey85ge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 03:15:22 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3173FLhn011771
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Feb 2023 03:15:21 GMT
Received: from [10.47.206.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 19:15:20 -0800
Message-ID: <6594e8bb-1176-c133-32b9-9883b0900f0f@quicinc.com>
Date:   Mon, 6 Feb 2023 19:15:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 08/22] rtc: pm8xxx: clean up time and alarm debugging
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
 <20230202155448.6715-9-johan+linaro@kernel.org>
From:   David Collins <quic_collinsd@quicinc.com>
In-Reply-To: <20230202155448.6715-9-johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PgquhzJTBBZfWTsUQALZ9AKViOg-Y-Nc
X-Proofpoint-GUID: PgquhzJTBBZfWTsUQALZ9AKViOg-Y-Nc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxlogscore=906 lowpriorityscore=0 priorityscore=1501 phishscore=0
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
> Clean up the time and alarm callback debugging by using a consistent and
> succinct human-readable (i.e. non-raw) format.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/rtc/rtc-pm8xxx.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Reviewed-by: David Collins <quic_collinsd@quicinc.com>

Take care,
David

