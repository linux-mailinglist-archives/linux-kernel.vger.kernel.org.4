Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B472B73BD78
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjFWRKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 13:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjFWRJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:09:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9072D69;
        Fri, 23 Jun 2023 10:09:05 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NDf6qV010028;
        Fri, 23 Jun 2023 17:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=czNt/8joIzOa1GCzQN/TG6UFZ73VTlS7L/4YiZu44dY=;
 b=As3Dk1lO9yf4DAtP+ZS0ENhbiwWoNGjz38uu/AaSF5Oaa720ymoc7WJ2ASzPaNko1t8n
 uVMNCRkmiGk0PyOVpmQw0AyPJr7xpJVPnWWA9HtJapgLTVVvxux1kgzQW3KUY409xqMz
 6DykOnYGt0FW3gkroAyQsK42C4y+WGcZfe76HYkUc0Cr2/j0NzYx+TyKdKbAKd/iv0a+
 jnQQ3dU9JKM8KSHEHgqG74Wyf41+Ssp6pd4ZVXEdG2DJ8uoZoGjX+W6dy3L3wlx1t4oR
 sO8eBNUWPHhGqPq+ZnbjukqYAqXKNqgMGNYZu9h3Ugplsivoo9r7WEjvlbcWljmQ6kb6 8w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rcw93j4bf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 17:08:58 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35NH8vC6008169
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 17:08:57 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 23 Jun 2023 10:08:57 -0700
Date:   Fri, 23 Jun 2023 10:08:56 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Andrew Halaney <ahalaney@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <viresh.kumar@linaro.org>,
        <rafael@kernel.org>, <konrad.dybcio@linaro.org>,
        <andersson@kernel.org>, <agross@kernel.org>
Subject: Re: [PATCH] cpufreq: qcom-cpufreq-hw: Use dev_err_probe() when
 failing to get icc paths
Message-ID: <20230623170856.GA1736857@hu-bjorande-lv.qualcomm.com>
References: <20230623155707.944272-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230623155707.944272-1-ahalaney@redhat.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ps1W09bcuLMUPMOYI_SbyqSZgazmL5fE
X-Proofpoint-ORIG-GUID: ps1W09bcuLMUPMOYI_SbyqSZgazmL5fE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_09,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 adultscore=0 clxscore=1011 impostorscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230153
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 10:57:07AM -0500, Andrew Halaney wrote:
> This way, if there's an issue (in this case a -EPROBE_DEFER), you can
> get useful output:
> 
>     [root@dhcp19-243-150 ~]# cat /sys/kernel/debug/devices_deferred
>     18591000.cpufreq        qcom-cpufreq-hw: Failed to find icc paths
> 
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Regards,
Bjorn

> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index a78d7a27b4b5..f2830371d25f 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -661,7 +661,7 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
>  
>  	ret = dev_pm_opp_of_find_icc_paths(cpu_dev, NULL);
>  	if (ret)
> -		return ret;
> +		return dev_err_probe(dev, ret, "Failed to find icc paths\n");
>  
>  	for (num_domains = 0; num_domains < MAX_FREQ_DOMAINS; num_domains++)
>  		if (!platform_get_resource(pdev, IORESOURCE_MEM, num_domains))
> -- 
> 2.40.1
> 
