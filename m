Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A1174CB11
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 06:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjGJEMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 00:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjGJEMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 00:12:20 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D23CA8;
        Sun,  9 Jul 2023 21:12:19 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36A3EBUT017060;
        Mon, 10 Jul 2023 04:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BZhSCLmmrXGESQUH3y/gMEKSL1Ao4appmRSt28A9Wqg=;
 b=k3twBsfoWzx53jV8dQiExIgAE/dE+5Q/s98/PcpWQ2Ar5R/8lROugT3X53eTVvRN3/q5
 ZiCG0kSMK2lGD3naz56zmXhtlvjtDqA1Z0eeDPfQiMyjvkAyY7iJ5bwvPLkSDOvBOs0i
 RSom4vkJtuPR2PqDOfaej501fhxhfSjrOSvh/YeSGK5eccLERPn3wcR/spmkGTO6Mvwp
 cCspDHcLnIl9NbSspRxtPYa7GWPtY7NuByGVb6pezqJvnOaeBNBFElFoQvOFsEh4qmO0
 qM6XE8B1N7iVwkPlsgyAfWKy4vh5xT2eqow4HNkgLzGFOO362K5/4W6FZcUGI+8shKuw CQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rpy4rtg2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 04:12:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36A4C3WD006298
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 04:12:03 GMT
Received: from [10.216.9.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sun, 9 Jul
 2023 21:11:58 -0700
Message-ID: <74dcd80b-547c-af5a-5a02-2e8d75ecca50@quicinc.com>
Date:   Mon, 10 Jul 2023 09:41:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] clk: qcom: gdsc: Add support for set_hwmode_dev
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        avel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>
CC:     <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20230628105652.1670316-1-abel.vesa@linaro.org>
 <20230628105652.1670316-3-abel.vesa@linaro.org>
From:   Taniya Das <quic_tdas@quicinc.com>
In-Reply-To: <20230628105652.1670316-3-abel.vesa@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 629z4ciUuGPuYNmbJqrKDuQhuw1Fg87z
X-Proofpoint-GUID: 629z4ciUuGPuYNmbJqrKDuQhuw1Fg87z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_03,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307100037
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/28/2023 4:26 PM, Abel Vesa wrote:
> Implement the GDSC specific genpd set_hwmode_dev callback in order to
> switch the HW control on or off. For any GDSC that supports HW control
> set this callback in order to allow its consumers to control it.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>   drivers/clk/qcom/gdsc.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index 5358e28122ab..9a04bf2e4379 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -314,6 +314,26 @@ static int gdsc_enable(struct generic_pm_domain *domain)
>   	return 0;
>   }
>   
> +static int gdsc_set_hwmode_dev(struct generic_pm_domain *domain,
> +			       struct device *dev, bool enable)
> +{
> +	int ret = gdsc_hwctrl(domain_to_gdsc(domain), enable);
> +
> +	if (ret)
> +		goto out;
> +
> +	/*
> +	 * Wait for the GDSC to go through a power down and
> +	 * up cycle.  In case there is a status polling going on
> +	 * before the power cycle is completed it might read an
> +	 * wrong status value.
> +	 */
> +	udelay(1);
> +
> +out:
> +	return ret;
> +}
> +
>   static int gdsc_disable(struct generic_pm_domain *domain)
>   {
>   	struct gdsc *sc = domain_to_gdsc(domain);
> @@ -451,6 +471,8 @@ static int gdsc_init(struct gdsc *sc)
>   		sc->pd.power_off = gdsc_disable;
>   	if (!sc->pd.power_on)
>   		sc->pd.power_on = gdsc_enable;
> +	if (sc->flags & HW_CTRL)
> +		sc->pd.set_hwmode_dev = gdsc_set_hwmode_dev;
>   

Forgot to add the get_mode.

+	if (sc->flags & HW_CTRL_TRIGGER) {
+		sc->pd.set_hwmode_dev = gdsc_set_mode;
+		sc->pd.get_hwmode_dev = gdsc_get_mode;
+	}
+
>   	ret = pm_genpd_init(&sc->pd, NULL, !on);
>   	if (ret)

-- 
Thanks & Regards,
Taniya Das.
