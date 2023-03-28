Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B94D6CBEC4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjC1MMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjC1MMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:12:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52B086AF;
        Tue, 28 Mar 2023 05:12:16 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32S9tKWv019390;
        Tue, 28 Mar 2023 12:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mPCFJFazSRpUdf6YkTdnDAcGqA+5R0LFtVC9YF7xc+w=;
 b=VNaZTKqkBHSEg2bIvlfyZUOfmo0PfOkglhpOk7+YcitDlZXM0dH3aM0o3lOQjeBvPswR
 Avx66HSTjPaHcigBRXWIzx1TlW1kG3Xdcu/VDM076zMPIyT2l3Dy2KQHorD5M4b7Fm3Y
 GQF3nVkcUZrIpCCPzq+FtHNhKcZEigUAzRgnRMw0YV0NiO2EwJ9kArWFJSuEXUHthCez
 +pIMGV/invJTFmCZ6rQoTspePXcwtgzq9zypzsMm5Zv/HnO2z2zPDaPLtOfhuS497CR4
 3cSPIPE3FFsSwHtkmMWE+pOe++h6GRjUfexsO4nuDQG/OWAzloWt2CTippvApbSQ9Z35 PA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pkk7b9qu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 12:12:05 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32SCC4np001210
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 12:12:04 GMT
Received: from [10.239.155.237] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Mar
 2023 05:12:02 -0700
Message-ID: <e0c4b49d-b813-90de-f0f4-7cec0f5d04c4@quicinc.com>
Date:   Tue, 28 Mar 2023 20:11:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] pinctrl: qcom: Add support to log pin status before
 suspend for TLMM
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@somainline.org>, <linus.walleij@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_satyap@quicinc.com>,
        <quic_tsoni@quicinc.com>
References: <1680004791-4216-1-git-send-email-quic_minghao@quicinc.com>
Content-Language: en-US
From:   Minghao Zhang <quic_minghao@quicinc.com>
In-Reply-To: <1680004791-4216-1-git-send-email-quic_minghao@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yCAoKL8CCMbNyteo2cPMe9c6DsdpqEtz
X-Proofpoint-GUID: yCAoKL8CCMbNyteo2cPMe9c6DsdpqEtz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1011 malwarescore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303280098
X-Spam-Status: No, score=1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add linus.walleij@linaro.org

On 3/28/2023 19:59, Minghao Zhang wrote:
> This change supports to print pin status before device suspend
> to debug for TLMM. And expose 2 APIs to enable/disable this
> functionality.
> 
> Signed-off-by: Minghao Zhang <quic_minghao@quicinc.com>
> ---
>   drivers/pinctrl/qcom/pinctrl-msm.c | 133 +++++++++++++++++++++++++++++--------
>   drivers/pinctrl/qcom/pinctrl-msm.h |   1 +
>   2 files changed, 105 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index daeb79a..872c49f 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -83,6 +83,21 @@ struct msm_pinctrl {
>   	u32 phys_base[MAX_NR_TILES];
>   };
>   
> +static bool pinctrl_msm_log_mask;
> +
> +static const char * const pulls_keeper[] = {
> +	"no pull",
> +	"pull down",
> +	"keeper",
> +	"pull up"
> +};
> +
> +static const char * const pulls_no_keeper[] = {
> +	"no pull",
> +	"pull down",
> +	"pull up",
> +};
> +
>   #define MSM_ACCESSOR(name) \
>   static u32 msm_readl_##name(struct msm_pinctrl *pctrl, \
>   			    const struct msm_pingroup *g) \
> @@ -628,6 +643,29 @@ static void msm_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
>   	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>   }
>   
> +static void msm_gpio_pin_status_get(struct msm_pinctrl *pctrl, const struct msm_pingroup *g,
> +				    unsigned int offset, int *is_out, unsigned int *func,
> +				    int *drive, int *pull, int *egpio_enable, int *val)
> +{
> +	u32 ctl_reg, io_reg;
> +
> +	ctl_reg = msm_readl_ctl(pctrl, g);
> +	io_reg = msm_readl_io(pctrl, g);
> +
> +	*is_out = !!(ctl_reg & BIT(g->oe_bit));
> +	*func = (ctl_reg >> g->mux_bit) & 7;
> +	*drive = (ctl_reg >> g->drv_bit) & 7;
> +	*pull = (ctl_reg >> g->pull_bit) & 3;
> +	*egpio_enable = 0;
> +	if (pctrl->soc->egpio_func && ctl_reg & BIT(g->egpio_present))
> +		*egpio_enable = !(ctl_reg & BIT(g->egpio_enable));
> +
> +	if (*is_out)
> +		*val = !!(io_reg & BIT(g->out_bit));
> +	else
> +		*val = !!(io_reg & BIT(g->in_bit));
> +}
> +
>   #ifdef CONFIG_DEBUG_FS
>   
>   static void msm_gpio_dbg_show_one(struct seq_file *s,
> @@ -644,40 +682,13 @@ static void msm_gpio_dbg_show_one(struct seq_file *s,
>   	int pull;
>   	int val;
>   	int egpio_enable;
> -	u32 ctl_reg, io_reg;
> -
> -	static const char * const pulls_keeper[] = {
> -		"no pull",
> -		"pull down",
> -		"keeper",
> -		"pull up"
> -	};
> -
> -	static const char * const pulls_no_keeper[] = {
> -		"no pull",
> -		"pull down",
> -		"pull up",
> -	};
>   
>   	if (!gpiochip_line_is_valid(chip, offset))
>   		return;
>   
>   	g = &pctrl->soc->groups[offset];
> -	ctl_reg = msm_readl_ctl(pctrl, g);
> -	io_reg = msm_readl_io(pctrl, g);
> -
> -	is_out = !!(ctl_reg & BIT(g->oe_bit));
> -	func = (ctl_reg >> g->mux_bit) & 7;
> -	drive = (ctl_reg >> g->drv_bit) & 7;
> -	pull = (ctl_reg >> g->pull_bit) & 3;
> -	egpio_enable = 0;
> -	if (pctrl->soc->egpio_func && ctl_reg & BIT(g->egpio_present))
> -		egpio_enable = !(ctl_reg & BIT(g->egpio_enable));
> -
> -	if (is_out)
> -		val = !!(io_reg & BIT(g->out_bit));
> -	else
> -		val = !!(io_reg & BIT(g->in_bit));
> +	msm_gpio_pin_status_get(pctrl, g, offset, &is_out, &func,
> +					&drive, &pull, &egpio_enable, &val);
>   
>   	if (egpio_enable) {
>   		seq_printf(s, " %-8s: egpio\n", g->name);
> @@ -707,6 +718,39 @@ static void msm_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
>   #define msm_gpio_dbg_show NULL
>   #endif
>   
> +static void msm_gpio_log_pin_status(struct gpio_chip *chip, unsigned int offset)
> +{
> +	const struct msm_pingroup *g;
> +	struct msm_pinctrl *pctrl = gpiochip_get_data(chip);
> +	unsigned int func;
> +	int is_out;
> +	int drive;
> +	int pull;
> +	int val;
> +	int egpio_enable;
> +
> +	if (!gpiochip_line_is_valid(chip, offset))
> +		return;
> +
> +	g = &pctrl->soc->groups[offset];
> +	msm_gpio_pin_status_get(pctrl, g, offset, &is_out, &func,
> +					&drive, &pull, &egpio_enable, &val);
> +
> +	printk_deferred("%s: %s, %s, func%d, %dmA, %s\n",
> +			g->name, is_out ? "out" : "in",
> +			val ? "high" : "low", func,
> +			msm_regval_to_drive(drive),
> +			pctrl->soc->pull_no_keeper ? pulls_no_keeper[pull] : pulls_keeper[pull]);
> +}
> +
> +static void msm_gpios_status(struct gpio_chip *chip)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < chip->ngpio; i++)
> +		msm_gpio_log_pin_status(chip, i);
> +}
> +
>   static int msm_gpio_init_valid_mask(struct gpio_chip *gc,
>   				    unsigned long *valid_mask,
>   				    unsigned int ngpios)
> @@ -1450,6 +1494,35 @@ SIMPLE_DEV_PM_OPS(msm_pinctrl_dev_pm_ops, msm_pinctrl_suspend,
>   
>   EXPORT_SYMBOL(msm_pinctrl_dev_pm_ops);
>   
> +void debug_pintctrl_msm_enable(void)
> +{
> +	pinctrl_msm_log_mask = true;
> +}
> +EXPORT_SYMBOL(debug_pintctrl_msm_enable);
> +
> +void debug_pintctrl_msm_disable(void)
> +{
> +	pinctrl_msm_log_mask = false;
> +}
> +EXPORT_SYMBOL(debug_pintctrl_msm_disable);
> +
> +static __maybe_unused int noirq_msm_pinctrl_suspend(struct device *dev)
> +{
> +	struct msm_pinctrl *pctrl = dev_get_drvdata(dev);
> +
> +	if (pinctrl_msm_log_mask) {
> +		printk_deferred("%s\n", pctrl->chip.label);
> +		msm_gpios_status(&pctrl->chip);
> +	}
> +
> +	return 0;
> +}
> +
> +const struct dev_pm_ops noirq_msm_pinctrl_dev_pm_ops = {
> +	.suspend_noirq = noirq_msm_pinctrl_suspend,
> +};
> +EXPORT_SYMBOL(noirq_msm_pinctrl_dev_pm_ops);
> +
>   int msm_pinctrl_probe(struct platform_device *pdev,
>   		      const struct msm_pinctrl_soc_data *soc_data)
>   {
> @@ -1512,6 +1585,8 @@ int msm_pinctrl_probe(struct platform_device *pdev,
>   	if (ret)
>   		return ret;
>   
> +	pinctrl_msm_log_mask = false;
> +
>   	platform_set_drvdata(pdev, pctrl);
>   
>   	dev_dbg(&pdev->dev, "Probed Qualcomm pinctrl driver\n");
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
> index 985eced..8ccbb6d 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.h
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.h
> @@ -155,6 +155,7 @@ struct msm_pinctrl_soc_data {
>   };
>   
>   extern const struct dev_pm_ops msm_pinctrl_dev_pm_ops;
> +extern const struct dev_pm_ops noirq_msm_pinctrl_dev_pm_ops;
>   
>   int msm_pinctrl_probe(struct platform_device *pdev,
>   		      const struct msm_pinctrl_soc_data *soc_data);
