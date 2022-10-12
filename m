Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375635FCB21
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 20:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiJLSzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 14:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiJLSy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:54:28 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48323FF201;
        Wed, 12 Oct 2022 11:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1665600862; x=1697136862;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=He66nZ0SvfJpXphGYaH54qTUAxIcYXyRMnszZBlbJo8=;
  b=on8hhA7tLXiAQBbfCWjCIt3eNB2Wp6+7iAzKZWRefOsxQMcJcw0pfyHZ
   BiXXGzm54z+78L4rTbPwTX95+cgWvsaW/1qmIfVhavOnpw7MM8ktlcDOH
   kZFpsSX05u4fBosagynUDt5PZa4luGVg0isusYyOWBmu2MPJc1SPtOjLD
   4=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 12 Oct 2022 11:54:21 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 11:54:21 -0700
Received: from [10.134.66.255] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 12 Oct
 2022 11:54:21 -0700
Message-ID: <2f9237cf-1ce2-47ed-4aea-b7b3a890da16@quicinc.com>
Date:   Wed, 12 Oct 2022 11:54:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] pinctrl: qcom: Add QDU1000/QRU1000 pinctrl driver
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221001030546.28220-1-quic_molvera@quicinc.com>
 <20221001030546.28220-3-quic_molvera@quicinc.com>
 <20221006015047.4ten7sjsth7sw6s7@baldur>
Content-Language: en-US
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <20221006015047.4ten7sjsth7sw6s7@baldur>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/5/2022 6:50 PM, Bjorn Andersson wrote:
> On Fri, Sep 30, 2022 at 08:05:46PM -0700, Melody Olvera wrote:
> [..]
>> diff --git a/drivers/pinctrl/qcom/pinctrl-qdru1000.c b/drivers/pinctrl/qcom/pinctrl-qdru1000.c
>> new file mode 100644
>> index 000000000000..8b931ff80bb4
>> --- /dev/null
>> +++ b/drivers/pinctrl/qcom/pinctrl-qdru1000.c
>> @@ -0,0 +1,59 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pinctrl/pinctrl.h>
>> +
>> +#include "pinctrl-msm.h"
>> +#include "pinctrl-qdru1000.h"
>> +
>> +static const struct msm_pinctrl_soc_data qdru1000_tlmm = {
>> +	.pins = qdru1000_pins,
>> +	.npins = ARRAY_SIZE(qdru1000_pins),
>> +	.functions = qdru1000_functions,
>> +	.nfunctions = ARRAY_SIZE(qdru1000_functions),
>> +	.groups = qdru1000_groups,
>> +	.ngroups = ARRAY_SIZE(qdru1000_groups),
>> +	.ngpios = 151,
>> +};
>> +
>> +static int qdru1000_tlmm_probe(struct platform_device *pdev)
>> +{
>> +	return msm_pinctrl_probe(pdev, &qdru1000_tlmm);
>> +}
>> +
>> +static const struct of_device_id qdru1000_tlmm_of_match[] = {
>> +	{ .compatible = "qcom,qdu1000-tlmm", },
>> +	{ .compatible = "qcom,qru1000-tlmm", },
>> +	{ },
>> +};
>> +
>> +static struct platform_driver qdru1000_tlmm_driver = {
>> +	.driver = {
>> +		.name = "qdru1000-tlmm",
>> +		.of_match_table = qdru1000_tlmm_of_match,
>> +	},
>> +	.probe = qdru1000_tlmm_probe,
>> +	.remove = msm_pinctrl_remove,
>> +};
>> +
>> +static int __init qdru1000_tlmm_init(void)
>> +{
>> +	return platform_driver_register(&qdru1000_tlmm_driver);
>> +}
>> +arch_initcall(qdru1000_tlmm_init);
>> +
>> +static void __exit qdru1000_tlmm_exit(void)
>> +{
>> +	platform_driver_unregister(&qdru1000_tlmm_driver);
>> +}
>> +module_exit(qdru1000_tlmm_exit);
>> +
>> +MODULE_DESCRIPTION("QTI QDRU1000 TLMM driver");
>> +MODULE_LICENSE("GPL v2");
> "GPL" only please.
Ack.
>
>> +MODULE_DEVICE_TABLE(of, qdru1000_tlmm_of_match);
> Please add this next to qdru1000_tlmm_of_match.
Ack.
>
>> diff --git a/drivers/pinctrl/qcom/pinctrl-qdru1000.h b/drivers/pinctrl/qcom/pinctrl-qdru1000.h
> I'm not able to see why this is in a header file and the commit message
> doesn't give a clue. Please align with the customary form, or motivate
> your choice.
Will use customary form instead of header file.
>
> [..]
>> +
>> +enum qdru1000_functions {
>> +	msm_mux_gpio,
>> +	msm_mux_CMO_PRI,
>> +	msm_mux_SI5518_INT,
>> +	msm_mux_atest_char_start,
>> +	msm_mux_atest_char_status0,
>> +	msm_mux_atest_char_status1,
>> +	msm_mux_atest_char_status2,
>> +	msm_mux_atest_char_status3,
> For anything that denotes different pins in one function, please drop
> the suffix and make this a list of functions.
Got it.
>
> [..]
>> +	msm_mux_qspi_data_0,
>> +	msm_mux_qspi_data_1,
>> +	msm_mux_qspi_data_2,
>> +	msm_mux_qspi_data_3,
>> +	msm_mux_qup0_se0_l0,
> E.g. msm_mux_qup0_se0 is enough, giving each pin its own function means
> that we need to define each pin separate in DT.
Going to switch to qupN format per another thread.
> Regards,
> Bjorn
Thanks,
Melody
