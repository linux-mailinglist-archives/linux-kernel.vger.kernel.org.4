Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDAD65156F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 23:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbiLSWOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 17:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiLSWOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 17:14:03 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E6E26E4;
        Mon, 19 Dec 2022 14:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1671488042; x=1703024042;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X6hdjQQyIkjXHt5DyB/GoInK8CD48WIU0VMOsq21iVw=;
  b=Y/19LDwO9fxgjaNZh2qJUOGo7I1wYEuWKG59qNxmJpAjZkymIoh6A9Me
   z1hg0AL6oooVtUSsV5lpU8qH3TKEv+O8HkE2iRm9kvHTsCDMjUd8UWkxc
   Mec9VEFDCEkwSv7TdrPTkWJxvzy59BX1M9F4B6UwdC6mU0xwRWFshqKV7
   s=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 19 Dec 2022 14:14:01 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 14:14:01 -0800
Received: from [10.110.23.17] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 19 Dec
 2022 14:14:00 -0800
Message-ID: <6465d73c-b971-9098-bd6a-7f778914808c@quicinc.com>
Date:   Mon, 19 Dec 2022 16:13:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v5 2/2] clk: qcom: Add QDU1000 and QRU1000 GCC support
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221216230722.21404-1-quic_molvera@quicinc.com>
 <20221216230722.21404-3-quic_molvera@quicinc.com>
 <8dc05650-428c-2995-a365-d397c92e7a6a@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <8dc05650-428c-2995-a365-d397c92e7a6a@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/19/2022 10:25 AM, Dmitry Baryshkov wrote:
> On 17/12/2022 01:07, Melody Olvera wrote:
>> From: Taniya Das <quic_tdas@quicinc.com>
>>
>> Add Global Clock Controller (GCC) support for QDU1000 and QRU1000 SoCs.
>>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>   drivers/clk/qcom/Kconfig       |    8 +
>>   drivers/clk/qcom/Makefile      |    1 +
>>   drivers/clk/qcom/gcc-qdu1000.c | 2653 ++++++++++++++++++++++++++++++++
>>   3 files changed, 2662 insertions(+)
>>   create mode 100644 drivers/clk/qcom/gcc-qdu1000.c
>>
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index 70d43f0a8919..d2e9ff7536f5 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -569,6 +569,14 @@ config QCS_Q6SSTOP_404
>>         Say Y if you want to use the Q6SSTOP branch clocks of the WCSS clock
>>         controller to reset the Q6SSTOP subsystem.
>>   +config QDU_GCC_1000
>> +    tristate "QDU1000/QRU1000 Global Clock Controller"
>> +    select QCOM_GDSC
>> +    help
>> +      Support for the global clock controller on QDU1000 and
>> +      QRU1000 devices. Say Y if you want to use peripheral
>> +      devices such as UART, SPI, I2C, USB, SD, PCIe, etc.
>> +
>>   config SDM_GCC_845
>>       tristate "SDM845/SDM670 Global Clock Controller"
>>       select QCOM_GDSC
>> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
>> index f18c446a97ea..c1615c76d3df 100644
>> --- a/drivers/clk/qcom/Makefile
>> +++ b/drivers/clk/qcom/Makefile
>> @@ -62,6 +62,7 @@ obj-$(CONFIG_QCM_DISPCC_2290) += dispcc-qcm2290.o
>>   obj-$(CONFIG_QCS_GCC_404) += gcc-qcs404.o
>>   obj-$(CONFIG_QCS_Q6SSTOP_404) += q6sstop-qcs404.o
>>   obj-$(CONFIG_QCS_TURING_404) += turingcc-qcs404.o
>> +obj-$(CONFIG_QDU_GCC_1000) += gcc-qdu1000.o
>>   obj-$(CONFIG_SC_CAMCC_7180) += camcc-sc7180.o
>>   obj-$(CONFIG_SC_CAMCC_7280) += camcc-sc7280.o
>>   obj-$(CONFIG_SC_DISPCC_7180) += dispcc-sc7180.o
>> diff --git a/drivers/clk/qcom/gcc-qdu1000.c b/drivers/clk/qcom/gcc-qdu1000.c
>> new file mode 100644
>> index 000000000000..144073562f8d
>> --- /dev/null
>> +++ b/drivers/clk/qcom/gcc-qdu1000.c
>> @@ -0,0 +1,2653 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/regmap.h>
>> +
>> +#include <dt-bindings/clock/qcom,qdu1000-gcc.h>
>> +
>> +#include "clk-alpha-pll.h"
>> +#include "clk-branch.h"
>> +#include "clk-rcg.h"
>> +#include "clk-regmap.h"
>> +#include "clk-regmap-divider.h"
>> +#include "clk-regmap-mux.h"
>> +#include "clk-regmap-phy-mux.h"
>> +#include "reset.h"
>> +
>> +enum {
>> +    P_BI_TCXO,
>> +    P_GCC_GPLL0_OUT_EVEN,
>> +    P_GCC_GPLL0_OUT_MAIN,
>> +    P_GCC_GPLL1_OUT_MAIN,
>> +    P_GCC_GPLL2_OUT_MAIN,
>> +    P_GCC_GPLL3_OUT_MAIN,
>> +    P_GCC_GPLL4_OUT_MAIN,
>> +    P_GCC_GPLL5_OUT_MAIN,
>> +    P_GCC_GPLL6_OUT_MAIN,
>> +    P_GCC_GPLL7_OUT_MAIN,
>> +    P_GCC_GPLL8_OUT_MAIN,
>> +    P_PCIE_0_PHY_AUX_CLK,
>> +    P_PCIE_0_PIPE_CLK,
>> +    P_SLEEP_CLK,
>> +    P_USB3_PHY_WRAPPER_GCC_USB30_PIPE_CLK,
>> +};
>> +
>> +enum {
>> +    TCXO_IDX,
>> +    SLEEP_CLK_IDX,
>> +    PCIE_0_PIPE_CLK_IDX,
>> +    PCIE_0_PHY_AUX_CLK_IDX,
>> +    USB3_PHY_WRAPPER_PIPE_CLK_IDX,
>> +};
>
> Please prefix these names with DT_, so that it's clear that they are indices in the device tree.

Will add prefixes here.

Thanks,
Melody

>
> With that fixed:
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>

