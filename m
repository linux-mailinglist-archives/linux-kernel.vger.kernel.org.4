Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EF8742315
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 11:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjF2JRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 05:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjF2JRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 05:17:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28B12134;
        Thu, 29 Jun 2023 02:17:05 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T8mXOb031688;
        Thu, 29 Jun 2023 09:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ejgo9Ha3IFB/uURLTL7ikLrQKDml9uYD+lWUNGD1J8Y=;
 b=Q5HZqz2n2kb+NTEAkAMXSIizloKVYik7ju104y8OZn96yjHMUHE2r8UejPxDjrhEh+ps
 cWd+wSjFgdc14K+PKEi3qq1azBZ4u8pIdlYimOLDmiz94hYg8zELLvYJKoMvoj5qSUlm
 xiUF5h+AVna9EN8O6xmE+kS2MqM4CdpARbaD3NQkgbC4GLfavjf/FtljharaTs7g7lti
 W5er+AR707Ti/P+vUgWcLn+r0mbJLrLF6PCLPJLahm3sSTqxYU6TXLloEYqyRTq0dHdq
 vQaCRNeFWUgrW34kv5/90nBcHlAXjnLhsXVO/11Eb0P2sw0E9ZHOoCkdGvjaL0iDILnZ Pg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgnxr9w8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 09:16:37 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35T9GZf5010847
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 09:16:35 GMT
Received: from [10.216.42.4] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 29 Jun
 2023 02:16:28 -0700
Message-ID: <e0fef1b0-3fa1-08c1-3c0e-aca30c9da266@quicinc.com>
Date:   Thu, 29 Jun 2023 14:46:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 10/21] soc: qcom: Add qcom's pstore minidump driver
 support
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
CC:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <keescook@chromium.org>,
        <tony.luck@intel.com>, <gpiccoli@igalia.com>,
        <mathieu.poirier@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <linus.walleij@linaro.org>,
        <andy.shevchenko@gmail.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <1687955688-20809-11-git-send-email-quic_mojha@quicinc.com>
 <CAL_Jsq+O70mnreuS1m54RKM+uZu_z1L87RT8sKBYEw5uvowGJg@mail.gmail.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <CAL_Jsq+O70mnreuS1m54RKM+uZu_z1L87RT8sKBYEw5uvowGJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Ao0JE0wQQz6nMX3r1Yj7CGXQWb2hQpyl
X-Proofpoint-GUID: Ao0JE0wQQz6nMX3r1Yj7CGXQWb2hQpyl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_01,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 impostorscore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290082
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/2023 4:27 AM, Rob Herring wrote:
> On Wed, Jun 28, 2023 at 6:37 AM Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>>
>> This driver was inspired from the fact pstore ram region should be
>> fixed and boot firmware need to have awarness about this region,
>> so that it will be persistent across boot. But, there are many
>> QCOM SoC which does not support warm boot from hardware but they
>> have minidump support from the software, and for them, there is
>> no need of this pstore ram region to be fixed, but at the same
>> time have interest in the pstore frontends data. So, this driver
>> get the dynamic reserved region from the ram and register the
>> ramoops platform device.
>>
>>   +---------+     +---------+   +--------+     +---------+
>>   | console |     | pmsg    |   | ftrace |     | dmesg   |
>>   +---------+     +---------+   +--------+     +---------+
>>         |             |             |              |
>>         |             |             |              |
>>         +------------------------------------------+
>>                            |
>>                           \ /
>>                    +----------------+
>>              (1)   |pstore frontends|
>>                    +----------------+
>>                            |
>>                           \ /
>>                   +------------------- +
>>              (2)  | pstore backend(ram)|
>>                   +--------------------+
>>                            |
>>                           \ /
>>                   +--------------------+
>>              (3)  |qcom_pstore_minidump|
>>                   +--------------------+
>>                            |
>>                           \ /
>>                     +---------------+
>>              (4)    | qcom_minidump |
>>                     +---------------+
>>
>> This driver will route all the pstore front data to the stored
>> in qcom pstore reserved region and the reason of showing an
>> arrow from (3) to (4) as qcom_pstore_minidump driver will register
>> all the available frontends region with qcom minidump driver
>> in upcoming patch.
>>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> ---
>>   drivers/soc/qcom/Kconfig                | 12 +++++
>>   drivers/soc/qcom/Makefile               |  1 +
>>   drivers/soc/qcom/qcom_pstore_minidump.c | 85 +++++++++++++++++++++++++++++++++
> 
> drivers/soc/ is the dumping ground for things with no other place. As
> this is a pstore driver, it belongs with pstore.

The inspiration of this driver was taken from 
drivers/platform/chrome/chromeos_pstore.c, do you think that is misplaced ?

> 
>>   3 files changed, 98 insertions(+)
>>   create mode 100644 drivers/soc/qcom/qcom_pstore_minidump.c
>>
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index 1834213fd652..fbf08e30feda 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -306,4 +306,16 @@ config QCOM_MINIDUMP_SMEM
>>
>>            This config should be enabled if the low level minidump is implemented
>>            as part of SMEM.
>> +
>> +config QCOM_PSTORE_MINIDUMP
>> +       tristate "Pstore support for QCOM Minidump"
>> +       depends on ARCH_QCOM
>> +       depends on PSTORE_RAM
>> +       depends on QCOM_MINIDUMP
>> +       help
>> +         Enablement of this driver ensures that ramoops region can be anywhere
>> +         reserved in ram instead of being fixed address which needs boot firmware
>> +         awareness. So, this driver creates plaform device and registers available
>> +         frontend region with the Qualcomm's minidump driver.
>> +
>>   endmenu
>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>> index 737d868757ac..1ab59c1b364d 100644
>> --- a/drivers/soc/qcom/Makefile
>> +++ b/drivers/soc/qcom/Makefile
>> @@ -36,3 +36,4 @@ qcom_ice-objs                 += ice.o
>>   obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)        += qcom_ice.o
>>   obj-$(CONFIG_QCOM_MINIDUMP) += qcom_minidump.o
>>   obj-$(CONFIG_QCOM_MINIDUMP_SMEM) += qcom_minidump_smem.o
>> +obj-$(CONFIG_QCOM_PSTORE_MINIDUMP) += qcom_pstore_minidump.o
>> diff --git a/drivers/soc/qcom/qcom_pstore_minidump.c b/drivers/soc/qcom/qcom_pstore_minidump.c
>> new file mode 100644
>> index 000000000000..b07cd10340df
>> --- /dev/null
>> +++ b/drivers/soc/qcom/qcom_pstore_minidump.c
>> @@ -0,0 +1,85 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
>> +/*
>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
> 
> You probably don't need this include. Use the actual includes you need
> and don't rely on implicit includes (because I'm trying to remove
> those).

Ok, will try to check..

- Mukesh

> 
>> +#include <linux/of_reserved_mem.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pstore_ram.h>
>> +
>> +struct qcom_ramoops_dd {
>> +       struct ramoops_platform_data qcom_ramoops_pdata;
>> +       struct platform_device *ramoops_pdev;
>> +};
>> +
>> +static int qcom_ramoops_probe(struct platform_device *pdev)
>> +{
>> +       struct device_node *of_node = pdev->dev.of_node;
>> +       struct qcom_ramoops_dd *qcom_rdd;
>> +       struct ramoops_platform_data *pdata;
>> +       struct reserved_mem *rmem;
>> +       struct device_node *node;
>> +       long ret;
>> +
>> +       node = of_parse_phandle(of_node, "memory-region", 0);
>> +       if (!node)
>> +               return -ENODEV;
>> +
>> +       rmem = of_reserved_mem_lookup(node);
>> +       of_node_put(node);
>> +       if (!rmem) {
>> +               dev_err(&pdev->dev, "failed to locate DT /reserved-memory resource\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       qcom_rdd = devm_kzalloc(&pdev->dev, sizeof(*qcom_rdd), GFP_KERNEL);
>> +       if (!qcom_rdd)
>> +               return -ENOMEM;
>> +
>> +       pdata = &qcom_rdd->qcom_ramoops_pdata;
>> +       pdata->mem_size = rmem->size;
>> +       pdata->mem_address = rmem->base;
>> +       ramoops_parse_dt(pdev, pdata);
>> +
>> +       qcom_rdd->ramoops_pdev = platform_device_register_data(NULL, "ramoops", -1,
>> +                                                              pdata, sizeof(*pdata));
>> +       if (IS_ERR(qcom_rdd->ramoops_pdev)) {
>> +               ret = PTR_ERR(qcom_rdd->ramoops_pdev);
>> +               dev_err(&pdev->dev, "could not create platform device: %ld\n", ret);
>> +               qcom_rdd->ramoops_pdev = NULL;
>> +       }
>> +       platform_set_drvdata(pdev, qcom_rdd);
>> +
>> +       return ret;
>> +}
>> +
>> +static void qcom_ramoops_remove(struct platform_device *pdev)
>> +{
>> +       struct qcom_ramoops_dd *qcom_rdd = platform_get_drvdata(pdev);
>> +
>> +       platform_device_unregister(qcom_rdd->ramoops_pdev);
>> +       qcom_rdd->ramoops_pdev = NULL;
>> +}
>> +
>> +static const struct of_device_id qcom_ramoops_of_match[] = {
>> +       { .compatible = "qcom,ramoops"},
>> +       {}
>> +};
>> +MODULE_DEVICE_TABLE(of, qcom_ramoops_of_match);
>> +
>> +static struct platform_driver qcom_ramoops_drv = {
>> +       .driver         = {
>> +               .name   = "qcom,ramoops",
>> +               .of_match_table = qcom_ramoops_of_match,
>> +       },
>> +       .probe = qcom_ramoops_probe,
>> +       .remove_new = qcom_ramoops_remove,
>> +};
>> +
>> +module_platform_driver(qcom_ramoops_drv);
>> +
>> +MODULE_DESCRIPTION("Qualcomm ramoops minidump driver");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.7.4
>>
