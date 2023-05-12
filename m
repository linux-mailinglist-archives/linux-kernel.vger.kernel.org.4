Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBA9700723
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240622AbjELLrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjELLrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:47:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B14F10A1B;
        Fri, 12 May 2023 04:47:11 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CB4r7A005520;
        Fri, 12 May 2023 11:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Jt51dYl/wNg7MsBYQTQvFM6GGZ9cO3DdrttGps86SvM=;
 b=gT7R3mqeShwqwWcLDracfU0/fCygVSUAyqtns8bciK25hNLj1wEIMN6MtTqJeXOkShfw
 AQ+xcMWhgtIkM4juKBy2y+UjlB3dhbYN6BOsEre2l3dCox3w0JkfMxsphzfKqYimUBtK
 w5dwkJnRxoQjSaejpOj30eiemLJhSLicrFRredSstVvg9slhQgtaEAqFnl208BenZPua
 I9SyO39nMWMpoW6WYtbuaC92hRftDhOw6ZcB8HOPsAxgAC1fU4g4wm5Pg4YOUdc9ZS2Q
 zLImyUeWGYjhirbsGoQkuOC2jsURtiq+sKtm4k9ZQjeeRvmkDVUMlZmp2PWwfePhhFnS NA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qhayt17hk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 11:46:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34CBkjh6019594
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 11:46:45 GMT
Received: from [10.50.57.156] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 12 May
 2023 04:46:41 -0700
Message-ID: <de9e8440-9c6b-2763-de79-5af9aeb8287c@quicinc.com>
Date:   Fri, 12 May 2023 17:16:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH V6 2/3] soc: qcom: boot_stat: Add Driver Support for Boot
 Stats
To:     Bjorn Andersson <andersson@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1683628357.git.quic_schowdhu@quicinc.com>
 <35863b47c04c2edd7ae49c57d23682aba6111d4f.1683628357.git.quic_schowdhu@quicinc.com>
 <20230511170744.cyex75e5d6md5rtm@ripper>
Content-Language: en-US
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <20230511170744.cyex75e5d6md5rtm@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kImsigrcMcPFrOWb4PVzDrrhlX30RJsX
X-Proofpoint-GUID: kImsigrcMcPFrOWb4PVzDrrhlX30RJsX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 phishscore=0 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120098
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/11/2023 10:37 PM, Bjorn Andersson wrote:
> On Tue, May 09, 2023 at 03:52:22AM -0700, Souradeep Chowdhury wrote:
>> All of Qualcomm's proprietary Android boot-loaders capture boot time
>> stats, like the time when the bootloader started execution and at what
>> point the bootloader handed over control to the kernel etc. in the IMEM
>> region. This information is captured in a specific format by this driver
>> by mapping a structure to the IMEM memory region and then accessing the
>> members of the structure to show the information within debugfs file.
>> This information is useful in verifying if the existing boot KPIs have
>> regressed or not. The information is shown in milliseconds, a sample
>> log from sm8450(waipio) device is as follows:-
>>
>> /sys/kernel/debug/qcom_boot_stats # cat abl_time
>> 17898 ms
>> /sys/kernel/debug/qcom_boot_stats # cat pre_abl_time
>> 2879 ms
>>
>> The Module Power Manager(MPM) sleep counter starts ticking at the PBL
>> stage and the timestamp generated by the sleep counter is logged by
>> the Qualcomm proprietary bootloader(ABL) at two points-> First when it
>> starts execution which is logged here as "pre_abl_time" and the second
>> when it is about to load the kernel logged as "abl_time". Documentation
>> details are also added in Documentation/ABI/testing/debugfs-driver-bootstat
>>
> 
> I would have preferred some way to implement this without spending
> countless kB of RAM to occasionally read out two u32 values...
> 
> But pulling them out of /dev/mem is the only suggestion that comes to
> mind... Perhaps dropping the MODULE_DEVICE_TABLE() to rely on an
> explicit modprobe/insmod in the few cases where it's needed?
> 
> @Arnd, do you have any suggestion about how to handle this kind of debug
> drivers?
> 
>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> ---
>>   .../ABI/testing/debugfs-driver-bootstat       |  17 +++
>>   drivers/soc/qcom/Kconfig                      |  10 ++
>>   drivers/soc/qcom/Makefile                     |   1 +
>>   drivers/soc/qcom/boot_stats.c                 | 100 ++++++++++++++++++
>>   4 files changed, 128 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/debugfs-driver-bootstat
>>   create mode 100644 drivers/soc/qcom/boot_stats.c
>>
>> diff --git a/Documentation/ABI/testing/debugfs-driver-bootstat b/Documentation/ABI/testing/debugfs-driver-bootstat
>> new file mode 100644
>> index 000000000000..7127d15d9f15
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/debugfs-driver-bootstat
>> @@ -0,0 +1,17 @@
>> +What:		/sys/kernel/debug/qcom_boot_stats/pre_abl_time
>> +Date:           May 2023
>> +Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> +Description:
>> +		This file is used to read the KPI value pre abl time.
>> +		It shows the time in milliseconds from the starting
>> +		point of PBL to the point when the control shifted
>> +		to ABL(Qualcomm proprietary bootloader).
>> +
>> +What:           /sys/kernel/debug/qcom_boot_stats/abl_time
>> +Date:           May 2023
>> +Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> +Description:
>> +		This file is used to read the KPI value abl time.
>> +		It show the duration in milliseconds from the
>> +		time control switched to ABL to the point when
>> +		the linux kernel started getting loaded.
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index a491718f8064..04141236dcdd 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -16,6 +16,16 @@ config QCOM_AOSS_QMP
>>   	  subsystems as well as controlling the debug clocks exposed by the Always On
>>   	  Subsystem (AOSS) using Qualcomm Messaging Protocol (QMP).
>>   
>> +config QCOM_BOOTSTAT
>> +	tristate "Qualcomm Technologies, Boot Stat driver"
>> +	depends on ARCH_QCOM || COMPILE_TEST
>> +	depends on DEBUG_FS
>> +	help
>> +	  This option enables driver support for boot stats. Boot stat driver logs
>> +	  the kernel bootloader information by accessing the imem region. These
>> +	  information are exposed in the form of debugfs files. This is used to
>> +	  determine if there is any regression in boot timings.
>> +
>>   config QCOM_COMMAND_DB
>>   	tristate "Qualcomm Command DB"
>>   	depends on ARCH_QCOM || COMPILE_TEST
>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>> index 0f43a88b4894..ae7bda96a539 100644
>> --- a/drivers/soc/qcom/Makefile
>> +++ b/drivers/soc/qcom/Makefile
>> @@ -1,6 +1,7 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   CFLAGS_rpmh-rsc.o := -I$(src)
>>   obj-$(CONFIG_QCOM_AOSS_QMP) +=	qcom_aoss.o
>> +obj-$(CONFIG_QCOM_BOOTSTAT) += boot_stats.o
>>   obj-$(CONFIG_QCOM_GENI_SE) +=	qcom-geni-se.o
>>   obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
>>   obj-$(CONFIG_QCOM_CPR)		+= cpr.o
>> diff --git a/drivers/soc/qcom/boot_stats.c b/drivers/soc/qcom/boot_stats.c
>> new file mode 100644
>> index 000000000000..ca67b6b5d8eb
>> --- /dev/null
>> +++ b/drivers/soc/qcom/boot_stats.c
>> @@ -0,0 +1,100 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2013-2019, 2021 The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <linux/debugfs.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/platform_device.h>
>> +
>> +#define TO_MS(timestamp) ((timestamp * 1000) / 32768)
>> +
>> +/**
>> + *  struct boot_stats - timestamp information related to boot stats
>> + *  @abl_start: Time for the starting point of the abl
>> + *  @abl_end: Time when the kernel starts loading from abl
>> + */
>> +struct boot_stats {
>> +	u32 abl_start;
>> +	u32 abl_end;
>> +} __packed;
>> +
>> +struct bs_data {
>> +	struct boot_stats __iomem *b_stats;
>> +	struct dentry *dbg_dir;
>> +};
>> +
>> +static void populate_boot_stats(char *abl_str, char *pre_abl_str, struct bs_data *drvdata)
>> +{
>> +	 u32 abl_time, pre_abl_time;
>> +
>> +	 abl_time = TO_MS(drvdata->b_stats->abl_end) - TO_MS(drvdata->b_stats->abl_start);
>> +	 sprintf(abl_str, "%u ms", abl_time);
>> +
>> +	 pre_abl_time =  TO_MS(drvdata->b_stats->abl_start);
>> +	 sprintf(pre_abl_str, "%u ms", pre_abl_time);
>> +}
>> +
>> +static int boot_stats_probe(struct platform_device *pdev)
>> +{
>> +	char abl_str[20], pre_abl_str[20], *abl, *pre_abl;
>> +	struct device *bootstat_dev = &pdev->dev;
>> +	struct bs_data *drvdata;
>> +
>> +	drvdata = devm_kzalloc(bootstat_dev, sizeof(*drvdata), GFP_KERNEL);
>> +	if (!drvdata)
>> +		return dev_err_probe(bootstat_dev, -ENOMEM, "failed to allocate memory");
>> +	platform_set_drvdata(pdev, drvdata);
>> +
>> +	drvdata->b_stats = devm_of_iomap(bootstat_dev, bootstat_dev->of_node, 0, NULL);
> 
> You don't use this region past probe, so no need to keep it mapped, or
> hang onto the pointer.
> 
> This means that you don't need struct bs_data, you can just stuff the
> dentry pointer directly in the drvdata.

Ack

> 
>> +	if (IS_ERR(drvdata->b_stats))
>> +		return dev_err_probe(bootstat_dev, PTR_ERR(drvdata->b_stats),
>> +				     "failed to map imem region");
>> +
>> +	drvdata->dbg_dir = debugfs_create_dir("qcom_boot_stats", NULL);
>> +	if (IS_ERR(drvdata->dbg_dir))
> 
> Please omit error handling in the debugfs api.

Ack

> 
>> +		return dev_err_probe(bootstat_dev, PTR_ERR(drvdata->dbg_dir),
>> +				     "failed to create debugfs directory");
>> +
>> +	populate_boot_stats(abl_str, pre_abl_str, drvdata);
>> +	abl = abl_str;
>> +	pre_abl = pre_abl_str;
>> +
>> +	debugfs_create_str("pre_abl_time", 0400, drvdata->dbg_dir, (char **)&pre_abl);
> 
> abl lives on the stack, pre_abl is a pointer to the stack, &pre_abl is a
> pointer to this pointer and if I read the code correctly, in
> __debugfs_create_file this value is stored in inode->i_private.
> 
> So I think this will only work if your stack isn't resused...

Ack

> 
> Regards,
> Bjorn
> 
>> +	debugfs_create_str("abl_time", 0400, drvdata->dbg_dir, (char **)&abl);
>> +
>> +	return 0;
>> +}
>> +
>> +void boot_stats_remove(struct platform_device *pdev)
>> +{
>> +	struct bs_data *drvdata = platform_get_drvdata(pdev);
>> +
>> +	debugfs_remove_recursive(drvdata->dbg_dir);
>> +}
>> +
>> +static const struct of_device_id boot_stats_dt_match[] = {
>> +	{ .compatible = "qcom,imem-bootstats" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, boot_stats_dt_match);
>> +
>> +static struct platform_driver boot_stat_driver = {
>> +	.probe  = boot_stats_probe,
>> +	.remove_new = boot_stats_remove,
>> +	.driver = {
>> +		.name = "qcom-boot-stats",
>> +		.of_match_table = boot_stats_dt_match,
>> +	},
>> +};
>> +module_platform_driver(boot_stat_driver);
>> +
>> +MODULE_DESCRIPTION("Qualcomm Technologies Inc. Boot Stat driver");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.17.1
>>
