Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DEA68CD30
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 04:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjBGDPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 22:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBGDO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:14:59 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D9F3608A;
        Mon,  6 Feb 2023 19:14:55 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3172IQvg018396;
        Tue, 7 Feb 2023 03:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=XEa7zvdIaL+HF1k+wBz2+SKvXEtxFyOfUBYDCboRxMo=;
 b=hc8UaxEHlTVp/L3e8SXT4070UhsYm+A5Fe8Wg4ytaKH/+su3X+LVMKKRDgtKUfAFQXKQ
 x3e3kLSdS1l3PPGGXcvSg3GMEBmloCg799i712Woo+F/SaFyp6SAewFKTi0UZmlXXDLb
 cn5Rgjgi4mgF2WRBFsPVUVFfB/X8GXi4Oq+ALEcxr0ZTmJpI7VuHM7Dufr9YBJghlkyI
 emkI9boUguaD9kVMetz7HoNlwAIMCK7zGpgv1WCBMtmPkmdHppooQr42f1if183kMpZO
 zwO3/IzVtqJdk6ff6gxuPXciTmr7+lWgVNQ2E3LP/YNj/0DeP1l0LArNjZdCB1NseQ0Y 5Q== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nhg4rn59v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 03:14:47 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3173EkLY004622
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Feb 2023 03:14:46 GMT
Received: from [10.47.206.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 19:14:45 -0800
Message-ID: <1eef640f-7d3d-6213-fd5b-6731283b3049@quicinc.com>
Date:   Mon, 6 Feb 2023 19:14:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 04/22] rtc: pm8xxx: drop bogus locking
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
 <20230202155448.6715-5-johan+linaro@kernel.org>
From:   David Collins <quic_collinsd@quicinc.com>
In-Reply-To: <20230202155448.6715-5-johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DY_NK85ekIc8gtz1bv6vZP1flpZZv-jT
X-Proofpoint-GUID: DY_NK85ekIc8gtz1bv6vZP1flpZZv-jT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 phishscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0
 mlxlogscore=452 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302070028
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/23 07:54, Johan Hovold wrote:
> Since commit c8d523a4b053 ("drivers/rtc/rtc-pm8xxx.c: rework to support
> pm8941 rtc") which removed the shadow control register there is no need
> for a driver lock.
> 
> Specifically, the rtc ops are serialised by rtc core and the interrupt
> handler only unconditionally disables the alarm using the alarm_ctrl
> register.
> 
> Note that since only the alarm enable bit of alarm_ctrl is used after
> enabling the RTC at probe, the locking was not needed when doing open
> coded read-modify-write cycles either.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/rtc/rtc-pm8xxx.c | 67 +++++++++++++---------------------------
>  1 file changed, 21 insertions(+), 46 deletions(-)

Reviewed-by: David Collins <quic_collinsd@quicinc.com>

Take care,
David

