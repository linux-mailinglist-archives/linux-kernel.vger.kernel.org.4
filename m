Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3914974CB0C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 06:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjGJEKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 00:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjGJEKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 00:10:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796A4E7;
        Sun,  9 Jul 2023 21:10:35 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36A2kfmX014794;
        Mon, 10 Jul 2023 04:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zIC99KX0aU62FO2J7U8Nqo5+YB880or40glFeAx1Ya0=;
 b=L4vBaZDapPuj9wEYX8SQ+uZCI1d/wSfsJYquZMUL7kof/C6PBNLY+G3kw9EyaemQWi95
 uPT++gz5BLXzvuRESlzCmNqALLzG0VYRQcwqs5SFlytUTL85ySa1A29knAPJkplkj/8i
 xOjzAaY7jIoJ+1KCKOoSjAbSVuTtR/WqIbrMsEYsvck10PPSEGZN2Nak8soxExQKFZLP
 kO2VIYQxCH3or+zohTBdEIyf/UKcLKW8+Y3n2i+6W3xmn/ZrFRHhKd67ptQeE5CPawAz
 +WJHGmSIC/q6haZa6S6ycaeV21UNRZE+F2omBSFRYGD7PnTRkci17M5xwtpMhuPM6k2Q Lg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rq01djepm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 04:10:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36A4ALHc016346
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 04:10:21 GMT
Received: from [10.216.9.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sun, 9 Jul
 2023 21:10:17 -0700
Message-ID: <e94f187e-e444-d18d-eba9-b9a699abdb95@quicinc.com>
Date:   Mon, 10 Jul 2023 09:40:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] clk: qcom: gdsc: Add support for set_hwmode_dev
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Kevin Hilman" <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "avel Machek" <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>
CC:     <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20230628105652.1670316-1-abel.vesa@linaro.org>
 <20230628105652.1670316-3-abel.vesa@linaro.org>
 <42b1167d-da60-f6c3-67b6-3f6857327396@linaro.org>
Content-Language: en-US
From:   Taniya Das <quic_tdas@quicinc.com>
In-Reply-To: <42b1167d-da60-f6c3-67b6-3f6857327396@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pZkrRaBr4lBulSbj6PttlyP8nkQ7G-x1
X-Proofpoint-GUID: pZkrRaBr4lBulSbj6PttlyP8nkQ7G-x1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_03,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 priorityscore=1501 clxscore=1011 adultscore=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307100037
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

Thanks for the patch.

On 6/28/2023 10:48 PM, Konrad Dybcio wrote:
> On 28.06.2023 12:56, Abel Vesa wrote:
>> Implement the GDSC specific genpd set_hwmode_dev callback in order to
>> switch the HW control on or off. For any GDSC that supports HW control
>> set this callback in order to allow its consumers to control it.
>>
>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>> ---
> This still does nothing to prevent the HW_CTRL state being changed in
> init, enable and disable functions.
> 
> Konrad
>>   drivers/clk/qcom/gdsc.c | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
>> index 5358e28122ab..9a04bf2e4379 100644
>> --- a/drivers/clk/qcom/gdsc.c
>> +++ b/drivers/clk/qcom/gdsc.c
>> @@ -314,6 +314,26 @@ static int gdsc_enable(struct generic_pm_domain *domain)
>>   	return 0;
>>   }
>>   
>> +static int gdsc_set_hwmode_dev(struct generic_pm_domain *domain,
>> +			       struct device *dev, bool enable)
>> +{
>> +	int ret = gdsc_hwctrl(domain_to_gdsc(domain), enable);
>> +
>> +	if (ret)
>> +		goto out;
>> +
>> +	/*
>> +	 * Wait for the GDSC to go through a power down and
>> +	 * up cycle.  In case there is a status polling going on
>> +	 * before the power cycle is completed it might read an
>> +	 * wrong status value.
>> +	 */
>> +	udelay(1);
>> +
>> +out:
>> +	return ret;
>> +}
>> +
>>   static int gdsc_disable(struct generic_pm_domain *domain)
>>   {
>>   	struct gdsc *sc = domain_to_gdsc(domain);
>> @@ -451,6 +471,8 @@ static int gdsc_init(struct gdsc *sc)
>>   		sc->pd.power_off = gdsc_disable;
>>   	if (!sc->pd.power_on)
>>   		sc->pd.power_on = gdsc_enable;
>> +	if (sc->flags & HW_CTRL)
>> +		sc->pd.set_hwmode_dev = gdsc_set_hwmode_dev;
>>   
We do not want to move to SW mode without consumers wanting to move to 
this mode.

We want a new flag for the consumers wanting to move to this mode. The 
mode in which the GDSC would be enabled would be in SW mode only.
+	if (sc->flags & HW_CTRL_TRIGGER) {
+		sc->pd.set_hwmode_dev = gdsc_set_mode;
+	}
+

>>   	ret = pm_genpd_init(&sc->pd, NULL, !on);
>>   	if (ret)

-- 
Thanks & Regards,
Taniya Das.
