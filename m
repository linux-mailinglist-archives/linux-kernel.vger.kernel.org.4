Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A94E68CD5A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 04:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjBGDRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 22:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjBGDRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:17:22 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44882196AE;
        Mon,  6 Feb 2023 19:17:05 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3172B2pg018033;
        Tue, 7 Feb 2023 03:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6m1DTHjCgh4CBi/CzMiuI3kgpFXQGgs0euEGDQ2qvz4=;
 b=WtK4IohfpcJut2eHViEEiTKbDyDGEsEN9hFjB8mczOVHslXtaBYDaMC7ie8ZAR4WtF9b
 UtSZoEoQBSODs6S+w/FFiqcJOQ4yDRd8kPqThNHB89MAQaBnJjOotdVgEXmB7vUw0YzN
 13mgdFY7f1XF7Asyiei6Zp9UQm05Ara8NoG9rAI60Tmr6Z9+N92wvMKJlT0VYLySPXoG
 2nFjBTkh32iKNqguuissmrWdfePaZKH3MfQLXdsvlW5/aitJoXB9zmNirrONDMoVkQsJ
 nylj5gC+kRNeNfl1uoFxJ2jF5Ogxz4YNhR0hBxBsM4xuenXjaGaGCgkUPk89O9gmo6JF Fg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nhghv54y3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 03:16:56 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3173Gt1P008946
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Feb 2023 03:16:56 GMT
Received: from [10.47.206.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 19:16:55 -0800
Message-ID: <f7e6203d-5773-3c40-db3c-547334efb218@quicinc.com>
Date:   Mon, 6 Feb 2023 19:16:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 17/22] rtc: pm8xxx: add support for nvmem offset
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
 <20230202155448.6715-18-johan+linaro@kernel.org>
From:   David Collins <quic_collinsd@quicinc.com>
In-Reply-To: <20230202155448.6715-18-johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XYL9xfT4Nse4u_GKpie6Pc_ug9HJyLAP
X-Proofpoint-ORIG-GUID: XYL9xfT4Nse4u_GKpie6Pc_ug9HJyLAP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
> On many Qualcomm platforms the PMIC RTC control and time registers are
> read-only so that the RTC time can not be updated. Instead an offset

s/can not/cannot/

> needs be stored in some machine-specific non-volatile memory, which the
> driver can take into account.
> 
> Add support for storing a 32-bit offset from the Epoch in an nvmem cell
> so that the RTC time can be set on such platforms.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/rtc/rtc-pm8xxx.c | 141 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 129 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
> index eff2782beeed..372494e82f40 100644
> --- a/drivers/rtc/rtc-pm8xxx.c
> +++ b/drivers/rtc/rtc-pm8xxx.c
> @@ -1,8 +1,13 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/* Copyright (c) 2010-2011, Code Aurora Forum. All rights reserved.
> +/*
> + * pm8xxx RTC driver
> + *
> + * Copyright (c) 2010-2011, Code Aurora Forum. All rights reserved.
> + * Copyright (c) 2023, Linaro Limited
>   */
>  #include <linux/of.h>
>  #include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
>  #include <linux/init.h>
>  #include <linux/rtc.h>
>  #include <linux/platform_device.h>
> @@ -49,6 +54,8 @@ struct pm8xxx_rtc_regs {
>   * @alarm_irq:		alarm irq number
>   * @regs:		register description
>   * @dev:		device structure
> + * @nvmem_cell:		nvmem cell for offset
> + * @offset:		offset from epoch in seconds
>   */
>  struct pm8xxx_rtc {
>  	struct rtc_device *rtc;
> @@ -57,8 +64,60 @@ struct pm8xxx_rtc {
>  	int alarm_irq;
>  	const struct pm8xxx_rtc_regs *regs;
>  	struct device *dev;
> +	struct nvmem_cell *nvmem_cell;
> +	u32 offset;
>  };
>  
> +static int pm8xxx_rtc_read_nvmem_offset(struct pm8xxx_rtc *rtc_dd)
> +{
> +	size_t len;
> +	void *buf;
> +	int rc;
> +
> +	buf = nvmem_cell_read(rtc_dd->nvmem_cell, &len);
> +	if (IS_ERR(buf)) {
> +		rc = PTR_ERR(buf);
> +		dev_dbg(rtc_dd->dev, "failed to read nvmem offset: %d\n", rc);

Why is dev_dbg() used instead of dev_err() for newly added error
messages?  Also, why do these conditions warrant error logging when some
of the previous patches in this series removed older error logging?

Thanks,
David

