Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911A66530F5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 13:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiLUMlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 07:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiLUMlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 07:41:40 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F382183A;
        Wed, 21 Dec 2022 04:41:38 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BLANEiD006391;
        Wed, 21 Dec 2022 12:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Z1l9hv+JIgKd5vw0WPp4KaaC0SQriFcrK0OJuME9IBY=;
 b=ipFph++31+Fg3aMSEzCxPx9v4O/bMgl5sbSvVMPOuO+ihrPhPDcR8cJJnJRY0qSY3yhp
 vmmYf4rPB6gV67fAe8Wtufh8NOp1roWXzY/iq+WIeozmMjPQm63jKqINDklgP7Z3RI6s
 Ua+GiLt3+sGo5wRl3nSVP9HLYNz+BEMcYIjVyxtt3LfrlzFpMYQLReHXl2HugKfjKqtC
 U3ySCdTiPafXUnkjTagfQ/q8XAcVqMlMewzn8i8f9yFlpb5mVVbwhV1Kcayzjhu47adv
 S8G5W7yGcLBn3p9uc+uEhbJN9ORtA982PU90MPR4EqQIgJEDCbfKal/dR2ivJw+DveaO lg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mkkxcsprp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 12:40:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BLCehAo027565
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 12:40:43 GMT
Received: from [10.50.11.246] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 21 Dec
 2022 04:40:38 -0800
Message-ID: <82939ba1-90ad-4b3a-5e68-7669dc13fc2e@quicinc.com>
Date:   Wed, 21 Dec 2022 18:10:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V19 2/7] soc: qcom: dcc: Add driver support for Data
 Capture and Compare unit(DCC)
Content-Language: en-US
To:     Alex Elder <elder@ieee.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, <vkoul@kernel.org>
References: <cover.1668595616.git.quic_schowdhu@quicinc.com>
 <9e60a42774864f3fc1a2ecbcfc94df0fff249662.1668595616.git.quic_schowdhu@quicinc.com>
 <88a10509-055d-caec-88ba-dca3a4fab82c@ieee.org>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <88a10509-055d-caec-88ba-dca3a4fab82c@ieee.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: J4Yeqt5qD-eWivwksMUMcmGuSGjJRpLE
X-Proofpoint-ORIG-GUID: J4Yeqt5qD-eWivwksMUMcmGuSGjJRpLE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_06,2022-12-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 clxscore=1011 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212210104
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/16/2022 7:36 AM, Alex Elder wrote:
> On 11/16/22 5:13 AM, Souradeep Chowdhury wrote:
>> The DCC is a DMA Engine designed to capture and store data
>> during system crash or software triggers. The DCC operates
>> based on user inputs via the debugfs interface. The user gives
>> addresses as inputs and these addresses are stored in the
>> dcc sram. In case of a system crash or a manual software
>> trigger by the user through the debugfs interface,
>> the dcc captures and stores the values at these addresses.
>> This patch contains the driver which has all the methods
>> pertaining to the debugfs interface, auxiliary functions to
>> support all the four fundamental operations of dcc namely
>> read, write, read/modify/write and loop. The probe method
>> here instantiates all the resources necessary for dcc to
>> operate mainly the dedicated dcc sram where it stores the
>> values. The DCC driver can be used for debugging purposes
>> without going for a reboot since it can perform software
>> triggers as well based on user inputs.
>>
>> Also added the documentation for debugfs entries and explained
>> the functionalities of each debugfs file that has been created
>> for dcc.
>>
>> The following is the justification of using debugfs interface
>> over the other alternatives like sysfs/ioctls
>>
>> i) As can be seen from the debugfs attribute descriptions,
>> some of the debugfs attribute files here contains multiple
>> arguments which needs to be accepted from the user. This goes
>> against the design style of sysfs.
>>
>> ii) The user input patterns have been made simple and convenient
>> in this case with the use of debugfs interface as user doesn't
>> need to shuffle between different files to execute one instruction
>> as was the case on using other alternatives.
> 
> I have more comments here, but nothing is a bug.  I think
> you can pretty easily address everything I mention here
> in a quick re-spin of your series.
> 
> If you choose to ignore any of my suggestions, so be it.
> But please follow up with a message explaining your
> reasoning.  You've been at this a long time and I want to
> see your code get accepted.
> 
> At one point during my first review I suggested making a
> more substantive change to the way you displayed the list
> configurations.  The idea was to use the same syntax for
> both input and output.  I still think that's worthwhile
> but I won't insist you do it.  You use a debugfs interface
> here, so technically you can change it in the future.
> 
> I'm going to assume you'll make most of the corrections
> I suggest, and on that assumption:
> 
> Reviewed-by: Alex Elder <elder@linaro.org>

Thanks for the review. Will be sending out the next version
implementing the comments along with the review tag.

> 
>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> ---
>>   Documentation/ABI/testing/debugfs-driver-dcc |   98 ++
>>   drivers/soc/qcom/Kconfig                     |    8 +
>>   drivers/soc/qcom/Makefile                    |    1 +
>>   drivers/soc/qcom/dcc.c                       | 1322 
>> ++++++++++++++++++++++++++
>>   4 files changed, 1429 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/debugfs-driver-dcc
>>   create mode 100644 drivers/soc/qcom/dcc.c
>>
>> diff --git a/Documentation/ABI/testing/debugfs-driver-dcc 
>> b/Documentation/ABI/testing/debugfs-driver-dcc
>> new file mode 100644
>> index 0000000..0d508d9
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/debugfs-driver-dcc
>> @@ -0,0 +1,98 @@
>> +What:           /sys/kernel/debug/dcc/.../ready
>> +Date:           November 2022
>> +Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> +Description:
>> +        This file is used to check the status of the dcc
>> +        hardware if it's ready to take the inputs. A 'Y'
>> +        here indicates dcc is in a ready condition.
>> +        Example:
>> +        cat /sys/kernel/debug/dcc/.../ready
>> +
>> +What:           /sys/kernel/debug/dcc/.../trigger
>> +Date:           November 2022
>> +Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> +Description:
>> +        This is the debugfs interface for manual software
>> +        triggers. The user can simply enter a 1 against
>> +        the debugfs file and enable a manual trigger.
>> +        Example:
>> +        echo  1 > /sys/kernel/debug/dcc/.../trigger
>> +
>> +What:           /sys/kernel/debug/dcc/.../config_reset
>> +Date:           November 2022
>> +Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> +Description:
>> +        This file is used to reset the configuration of
>> +        a dcc driver to the default configuration. This
>> +        means that all the previous addresses stored in
>> +        the driver gets removed and user needs to enter
>> +        the address values from the start.
>> +        Example:
>> +        echo  1 > /sys/kernel/debug/dcc/../config_reset
>> +
>> +What:           /sys/kernel/debug/dcc/.../[list-number]/config
>> +Date:        November 2022
>> +Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> +Description:
>> +        This stores the addresses of the registers which
>> +        should be read in case of a hardware crash or
>> +        manual software triggers. The addresses entered here
>> +        are considered under all the 4 types of dcc
>> +        instructions Read type, Write type, Read Modify Write
>> +        type and Loop type. The lists need to be configured
>> +        sequentially and not in a overlapping manner. As an
>> +        example user can jump to list x only after list y is
>> +        configured and enabled. The format for entering all
>> +        types of instructions are explained in examples as
>> +        follows.
>> +        Example:
>> +             i)Read Type Instruction
>> +           echo R <1> <2> <3> 
>> >/sys/kernel/debug/dcc/../[list-number]/config
>> +           1->Address to be considered for reading the value.
>> +           2->The word count of the addresses, read n words
>> +              starting from address <1>. Each word is of 32 bits.
>> +              If not entered 1 is considered.
>> +           3->Can be 'apb' or 'ahb' which indicates if it is apb or ahb
>> +              bus respectively. If not entered ahb is considered.
>> +        ii)Write Type Instruction
>> +           echo W <1> <2> <3> > 
>> /sys/kernel/debug/dcc/../[list-number]/config
>> +           1->Address to be considered for writing the value.
>> +           2->The value that needs to be written at the location.
>> +           3->Can be a 'apb' or 'ahb' which indicates if it is apb or 
>> ahb
>> +              but respectively.
>> +           iii)Read Modify Write type instruction
>> +           echo RW <1> <2> <3> > 
>> /sys/kernel/debug/dcc/../[list-number]/config
>> +           1->The address which needs to be considered for read then 
>> write.
>> +           2->The value that needs to be written on the address.
>> +           3->The mask of the value to be written.
>> +        iv)Loop Type Instruction
>> +           echo L <1> <2> <3> > 
>> /sys/kernel/debug/dcc/../[list-number]/config
>> +           1->The loop count, the number of times the value of the 
>> addresses will be
>> +              captured.
>> +           2->The address count, total number of addresses to be 
>> entered in this
>> +              instruction.
>> +           3->The series of addresses to be entered separated by a 
>> space like <addr1>
>> +              <addr2>... and so on.
>> +
>> +What:           /sys/kernel/debug/dcc/.../[list-number]/enable
>> +Date:           November 2022
>> +Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> +Description:
>> +        This debugfs interface is used for enabling the
>> +        the dcc hardware. Enable file is kept under the
>> +        directory list number for which the user wants
>> +        to enable it. For example if the user wants to
>> +        enable list 1, then he should go for
>> +        echo 1 > /sys/kernel/debug/dcc/.../1/enable.
>> +        On enabling the dcc, all the addresses entered
>> +        by the user for the corresponding list is written
>> +        into dcc sram which is read by the dcc hardware
>> +        on manual or crash induced triggers. Lists should
>> +        be enabled sequentially.For example after configuring
>> +        addresses for list 1 and enabling it, a user can
>> +        proceed to enable list 2 or vice versa.
>> +        Example:
>> +        echo  0 > /sys/kernel/debug/dcc/.../[list-number]/enable
>> +        (disable dcc for the corresponding list number)
>> +        echo  1 > /sys/kernel/debug/dcc/.../[list-number]/enable
>> +        (enable dcc for the corresponding list number)
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index 024e420..d5730bf 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -69,6 +69,14 @@ config QCOM_LLCC
>>         SDM845. This provides interfaces to clients that use the LLCC.
>>         Say yes here to enable LLCC slice driver.
>>
>> +config QCOM_DCC
>> +    tristate "Qualcomm Technologies, Inc. Data Capture and 
>> Compare(DCC) engine driver"
>> +    depends on ARCH_QCOM || COMPILE_TEST
>> +    help
>> +      This option enables driver for Data Capture and Compare engine. 
>> DCC
>> +      driver provides interface to configure DCC block and read back
>> +      captured data from DCC's internal SRAM.
>> +
>>   config QCOM_KRYO_L2_ACCESSORS
>>       bool
>>       depends on ARCH_QCOM && ARM64 || COMPILE_TEST
>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>> index d66604a..b1fe812 100644
>> --- a/drivers/soc/qcom/Makefile
>> +++ b/drivers/soc/qcom/Makefile
>> @@ -4,6 +4,7 @@ obj-$(CONFIG_QCOM_AOSS_QMP) +=    qcom_aoss.o
>>   obj-$(CONFIG_QCOM_GENI_SE) +=    qcom-geni-se.o
>>   obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
>>   obj-$(CONFIG_QCOM_CPR)        += cpr.o
>> +obj-$(CONFIG_QCOM_DCC) += dcc.o
>>   obj-$(CONFIG_QCOM_GSBI)    +=    qcom_gsbi.o
>>   obj-$(CONFIG_QCOM_MDT_LOADER)    += mdt_loader.o
>>   obj-$(CONFIG_QCOM_OCMEM)    += ocmem.o
>> diff --git a/drivers/soc/qcom/dcc.c b/drivers/soc/qcom/dcc.c
>> new file mode 100644
>> index 0000000..41f69fb
>> --- /dev/null
>> +++ b/drivers/soc/qcom/dcc.c
>> @@ -0,0 +1,1322 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2015-2021, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/bitops.h>
>> +#include <linux/debugfs.h>
>> +#include <linux/delay.h>
>> +#include <linux/fs.h>
>> +#include <linux/io.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/miscdevice.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/uaccess.h>
>> +
>> +#define STATUS_READY_TIMEOUT        5000  /* microseconds */
>> +
>> +#define DCC_SRAM_NODE "dcc_sram"
>> +
>> +/* DCC registers */
>> +#define DCC_HW_INFO            0x04
>> +#define DCC_LL_NUM_INFO            0x10
>> +#define DCC_STATUS(vers)        ((vers) == 1 ? 0x0c : 0x1c)
>> +#define DCC_LL_LOCK            0x00
>> +#define DCC_LL_CFG            0x04
>> +#define DCC_LL_BASE            0x08
>> +#define DCC_FD_BASE            0x0c
>> +#define DCC_LL_TIMEOUT            0x10
>> +#define DCC_LL_INT_ENABLE        0x18
>> +#define DCC_LL_INT_STATUS        0x1c
>> +#define DCC_LL_SW_TRIGGER        0x2c
>> +#define DCC_LL_BUS_ACCESS_STATUS    0x30
>> +
>> +#define DCC_MAP_LEVEL1            0x18
>> +#define DCC_MAP_LEVEL2            0x34
>> +#define DCC_MAP_LEVEL3            0x4C
> 
> The three DCC_MAP_LEVEL symbols defined above are no longer
> used, so get rid of them.

Ack

> 
>> +#define DCC_MAP_OFFSET1            0x10
>> +#define DCC_MAP_OFFSET2            0x18
>> +#define DCC_MAP_OFFSET3            0x1C
>> +#define DCC_MAP_OFFSET4            0x8
> 
> The four DCC_MAP_OFFSET symbols defined here are also no
> longer used,m so get rid of them.

Ack

> 
>> +
>> +/* Default value used if a bit 6 in the HW_INFO register is set. */
>> +#define DCC_FIX_LOOP_OFFSET        16
>> +
>> +/* Mask to find version info from HW_Info register */
>> +#define DCC_VER_INFO_MASK        BIT(9)
>> +
>> +#define DCC_READ            0
>> +#define DCC_WRITE            1
>> +#define DCC_LOOP            2
>> +#define DCC_READ_WRITE            3
> 
> The four symbols above are no longer used, so get rid
> of them.  I believe you use the dcc_descriptor_type
> values now instead.

Ack

> 
> 
>> +
>> +#define MAX_DCC_OFFSET            GENMASK(9, 2)
>> +#define MAX_DCC_LEN            GENMASK(6, 0)
>> +#define MAX_LOOP_CNT            GENMASK(7, 0)
>> +#define MAX_LOOP_ADDR            10
>> +
>> +#define DCC_ADDR_DESCRIPTOR        0x00
>> +#define DCC_ADDR_LIMIT            27
>> +#define DCC_WORD_SIZE            sizeof(u32)
>> +#define DCC_ADDR_RANGE_MASK        GENMASK(31, 4)
>> +#define DCC_LOOP_DESCRIPTOR        BIT(30)
>> +#define DCC_RD_MOD_WR_DESCRIPTOR    BIT(31)
>> +#define DCC_LINK_DESCRIPTOR        GENMASK(31, 30)
>> +#define DCC_STATUS_MASK        GENMASK(1, 0)
> 
> The line above needs another tab before the GENMASK()

Ack

> 
>> +#define DCC_LOCK_MASK            BIT(0)
>> +#define DCC_LOOP_OFFSET_MASK        BIT(6)
>> +#define DCC_TRIGGER_MASK        BIT(9)
>> +
>> +#define DCC_WRITE_MASK            BIT(15)
>> +#define DCC_WRITE_OFF_MASK        GENMASK(7, 0)
>> +#define DCC_WRITE_LEN_MASK        GENMASK(14, 8)
>> +
>> +#define DCC_READ_IND            0x00
>> +#define DCC_WRITE_IND            (BIT(28))
>> +
>> +#define DCC_AHB_IND            0x00
>> +#define DCC_APB_IND            BIT(29)
>> +
>> +#define DCC_MAX_LINK_LIST        8
>> +#define DCC_INVALID_LINK_LIST        GENMASK(7, 0)
> 
> DCC_INVALID_LINK_LIST is not used, so get rid of it.

Ack

> 
>> +
>> +#define DCC_VER_MASK1            GENMASK(6, 0)
> 
> Note that DCC_VER_MASK1, which might be well-defined for the
> hardware, is never used (or required) in this driver.  So you
> could just get rid of it.

Ack

> 
>> +#define DCC_VER_MASK2            GENMASK(5, 0)
>> +
>> +#define DCC_SRAM_WORD_LENGTH        4
> 
> DCC_SRAM_WORD_LENGTH is not used, so get rid of it.  (You
> use DCC_WORD_SIZE now.)

Ack

> 
>> +
>> +#define DCC_RD_MOD_WR_ADDR             0xC105E
>> +
>> +enum dcc_descriptor_type {
>> +    DCC_READ_TYPE,
>> +    DCC_LOOP_TYPE,
>> +    DCC_READ_WRITE_TYPE,
>> +    DCC_WRITE_TYPE
>> +};
>> +
>> +struct dcc_config_entry {
>> +    u32                base;
>> +    u32                offset;
>> +    u32                len;
>> +    u32                loop_cnt;
>> +    u32                write_val;
>> +    u32                mask;
>> +    bool                apb_bus;
>> +    enum dcc_descriptor_type    desc_type;
>> +    struct list_head        list;
>> +};
>> +
>> +/**
>> + * struct dcc_drvdata - configuration information related to a dcc 
>> device
>> + * @base:        Base Address of the dcc device
>> + * @dev:        The device attached to the driver data
>> + * @mutex:        Lock to protect access and manipulation of dcc_drvdata
>> + * @ram_base:        Base address for the SRAM dedicated for the dcc 
>> device
>> + * @ram_size:        Total size of the SRAM dedicated for the dcc device
>> + * @ram_offset:    Offset to the SRAM dedicated for dcc device
> 
> Insert a tab before "Offset" above.

Ack

> 
>> + * @mem_map_ver:    Memory map version of DCC hardware
>> + * @ram_cfg:        Used for address limit calculation for dcc
>> + * @ram_start:        Starting address of DCC SRAM
>> + * @sram_dev:        Miscellaneous device equivalent of dcc SRAM
>> + * @cfg_head:        Points to the head of the linked list of addresses
>> + * @dbg_dir:        The dcc debugfs directory under which all the 
>> debugfs files are placed
>> + * @nr_link_list:    Total number of linkedlists supported by the DCC 
>> configuration
>> + * @loopoff:        Loop offset bits range for the addresses
>> + * @enable_bitmap:    Bitmap to capture the enabled status of each 
>> linked list of addresses
>> + */
>> +struct dcc_drvdata {
>> +    void __iomem        *base;
>> +    void __iomem            *ram_base;
>> +    struct device        *dev;
>> +    struct mutex        mutex;
>> +    size_t            ram_size;
>> +    size_t            ram_offset;
>> +    int            mem_map_ver;
>> +    unsigned int        ram_cfg;
>> +    unsigned int        ram_start;
>> +    struct miscdevice    sram_dev;
>> +    struct list_head    *cfg_head;
>> +    struct dentry        *dbg_dir;
>> +    size_t            nr_link_list;
>> +    u8            loopoff;
>> +    unsigned long        *enable_bitmap;
>> +};
>> +
>> +struct dcc_cfg_attr {
>> +    u32    addr;
>> +    u32    prev_addr;
>> +    u32    prev_off;
>> +    u32    link;
>> +    u32    sram_offset;
>> +};
>> +
>> +struct dcc_cfg_loop_attr {
>> +    u32    loop_cnt;
>> +    u32    loop_len;
>> +    u32    loop_off;
>> +    bool    loop_start;
>> +};
>> +
>> +static inline u32 dcc_list_offset(int version)
>> +{
>> +    return version == 1 ? 0x1c : (version == 2 ? 0x2c : 0x34);
> 
> No need for the parentheses in the line above.

Ack

> 
>> +}
>> +
>> +static inline void dcc_list_writel(struct dcc_drvdata *drvdata,
>> +                   u32 ll, u32 val, u32 off)
>> +{
>> +    u32 offset = dcc_list_offset(drvdata->mem_map_ver) + off;
>> +
>> +    writel(val, drvdata->base + ll * 0x80 + offset);
>> +}
>> +
>> +static inline u32 dcc_list_readl(struct dcc_drvdata *drvdata, u32 ll, 
>> u32 off)
>> +{
>> +    u32 offset = dcc_list_offset(drvdata->mem_map_ver) + off;
>> +
>> +    return readl(drvdata->base + ll * 0x80 + offset);
>> +}
>> +
>> +static void dcc_sram_write_auto(struct dcc_drvdata *drvdata,
>> +                u32 val, u32 *off)
>> +{
>> +    /* If the overflow condition is met increment the offset
>> +     * and return to indicate that overflow has occurred
>> +     */
>> +    if (unlikely(*off > (drvdata->ram_size - 4))) {
> 
> Parentheses around the subtraction above are not required.

Ack

> 
>> +        *off += 4;
>> +        return;
>> +    }
>> +
>> +    writel(val, drvdata->ram_base + *off);
>> +
>> +    *off += 4;
>> +}
>>
> 
> . . .
> 
>> +static const struct file_operations trigger_fops = {
>> +    .write = trigger_write,
>> +    .open = simple_open,
>> +    .llseek = generic_file_llseek,
>> +};
>> +
>> +static int dcc_config_add(struct dcc_drvdata *drvdata, unsigned int 
>> addr,
>> +              unsigned int len, bool apb_bus, int curr_list)
>> +{
>> +    int ret = 0;
>> +    struct dcc_config_entry *entry, *pentry;
>> +    unsigned int base, offset;
>> +
>> +    mutex_lock(&drvdata->mutex);
>> +
>> +    if (!len || len > drvdata->ram_size / DCC_WORD_SIZE) {
>> +        dev_err(drvdata->dev, "DCC: Invalid length\n");
>> +        ret = -EINVAL;
>> +        goto out_unlock;
>> +    }
>> +
>> +    base = addr & DCC_ADDR_RANGE_MASK;
> 
> Last time I reviewed this, I said this about the above line
> (and the range check above it):
> 
>      Maybe:
>      base = round_down(addr, DCC_WORD_SIZE);
> 
>      Then you don't even need DCC_ADDR_RANGE_MASK.
> 
>      And then:
>      len += base - addr;
>      And if necessary:
>      len = round_up(addr, DCC_WORD_SIZE);
>      And finally:
>      if (len > drvdata->ram_size / DCC_WORD_SIZE)
>          return -EINVAL;
> 
> To which you responded:
> 
>      Ack.
> 
> 
> My suggestion improved the one line you had in these ways:
> - Eliminated this, the only use of DCC_ADDR_RANGE_MASK
>    by rounding down to the nearest DCC_WORD_SIZE multiple
>    instead.  (The effect should be the same.)
> - If the base address *did* get rounded down, it extended
>    the length to ensure the original bytes are included
> - Then ensured the length is rounded up to a multiple of
>    the word size
> ...all before doing the range check.
> 
> In other words, I suggest this instead (note I corrected
> an error in what I suggested):
> 
>      base = round_down(addr, DCC_WORD_SIZE);
>      len = round_up(len + addr - base, DCC_WORD_SIZE);
>      if (!len || len > drvdata->ram_size / DCC_WORD_SIZE)
>          return -EINVAL;
> 
> If you don't agree this helps, I guess I'll accept that.

Ack. Sticking to the original offset calculation as this
might introduce some differences that the existing
implementation.

For example base = round_down(addr, DCC_WORD_SIZE) is not similar
to base = addr & DCC_ADDR_RANGE_MASK where DCC_ADDR_RANGE_MASK is
GENMASK(31, 4). We are maintaining a 16 byte aligned address as 
mentioned before, rounding down to the word size changes that which
is not as per the sram programming specifications.


> 
>> +
>> +    if (!list_empty(&drvdata->cfg_head[curr_list])) {
>> +        pentry = list_last_entry(&drvdata->cfg_head[curr_list],
>> +                     struct dcc_config_entry, list);
>> +
>> +        if (pentry->desc_type == DCC_READ_TYPE &&
>> +            addr >= (pentry->base + pentry->offset) &&
>> +            addr <= (pentry->base + pentry->offset + MAX_DCC_OFFSET)) {
>> +            /* Re-use base address from last entry */
>> +            base = pentry->base;
>> +
>> +            if ((pentry->len * 4 + pentry->base + pentry->offset)
>> +                    == addr) {
>> +                len += pentry->len;
>> +
>> +                if (len > MAX_DCC_LEN)
>> +                    pentry->len = MAX_DCC_LEN;
>> +                else
>> +                    pentry->len = len;
>> +
>> +                addr = pentry->base + pentry->offset +
>> +                    pentry->len * 4;
>> +                len -= pentry->len;
>> +            }
>> +        }
>> +    }
>> +
>> +    offset = addr - base;
>> +
>> +    while (len) {
>> +        entry = kzalloc(sizeof(*entry), GFP_KERNEL);
>> +        if (!entry) {
>> +            ret = -ENOMEM;
>> +            goto out_unlock;
>> +        }
>> +
>> +        entry->base = base;
>> +        entry->offset = offset;
>> +        entry->len = min_t(u32, len, MAX_DCC_LEN);
>> +        entry->desc_type = DCC_READ_TYPE;
>> +        entry->apb_bus = apb_bus;
>> +        INIT_LIST_HEAD(&entry->list);
>> +        list_add_tail(&entry->list,
>> +                  &drvdata->cfg_head[curr_list]);
>> +
>> +        len -= entry->len;
>> +        offset += MAX_DCC_LEN * 4;
>> +    }
>> +
>> +out_unlock:
>> +    mutex_unlock(&drvdata->mutex);
>> +    return ret;
>> +}
> 
> . . .
> 
>> +static ssize_t dcc_config_add_loop(struct dcc_drvdata *drvdata, char 
>> *buf, int curr_list)
> 
> The above line is pretty long.  You could but the function name on a
> new line and it would look better.

Ack

> 
>> +{
>> +    int ret, i = 0;
>> +    char *token, *input;
>> +    char delim[2] = " ";
>> +    unsigned int val[MAX_LOOP_ADDR];
>> +
>> +    input = buf;
>> +
>> +    token = strsep(&input, delim);
>> +    while (token) {
>> +        if (i < MAX_LOOP_ADDR) {
>> +            ret = kstrtoint(token, 0, &val[i++]);
>> +            if (ret)
>> +                return ret;
>> +        } else {
>> +            dev_err(drvdata->dev, "Max limit of loop address exceeded");
>> +            return -EINVAL;
>> +        }
> 
> I suggest:
> 
>      while ((token = strsep(&input, delim)) && i < MAX_LOOP_ADDR) {
>          ret = kstrtoint(token, &val[i++];
>          if (ret)
>              return ret;
>      }
> 
>      if (token) {
>          dev_err(drvdata->dev, "Max limit %u of loop address exceeded",
>                  MAX_LOOP_ADDR);
>          return -EINVAL;
>      }
> 
> But what you have is OK.

Ack

> 
>> +
>> +        token = strsep(&input, delim);
>> +    }
>> +
>> +    if (val[1] < 1 || val[1] > 8)
>> +        return -EINVAL;
>> +
>> +    ret = dcc_add_loop(drvdata, val[0], curr_list);
>> +    if (ret)
>> +        return ret;
>> +
>> +    for (i = 0; i < val[1]; i++)
>> +        dcc_config_add(drvdata, val[i + 2], 1, false, curr_list);
>> +
>> +    return dcc_add_loop(drvdata, 1, curr_list);
>> +}
>> +
> 
> . . .
> 
>> +static ssize_t config_write(struct file *filp,
>> +                const char __user *user_buf, size_t count,
>> +                loff_t *ppos)
>> +{
>> +    int ret, curr_list;
>> +    char *token, buf[50];
>> +    char *bufp = buf;
>> +    char *delim = " ";
>> +    struct dcc_drvdata *drvdata = filp->private_data;
>> +
>> +    if (count > sizeof(buf) || count == 0)
>> +        return -EINVAL;
>> +
>> +    ret = copy_from_user(buf, user_buf, count);
>> +    if (ret)
>> +        return -EFAULT;
>> +
>> +    curr_list = dcc_filp_curr_list(filp);
>> +    if (curr_list < 0)
>> +        return curr_list;
>> +
>> +    if (buf[count - 1] == '\n')
>> +        buf[count - 1] = '\0';
>> +    else
>> +        return -EINVAL;
> 
> I still don't understand why a newline is required on
> your input, but that's OK.

The '\0' needs to be set at the end of the bufp passed to
srtsep. Even though strsep doesn't need that to do it's work,
it is required for further string operations as the token
is passed to the functions.

> 
>> +
>> +    token = strsep(&bufp, delim);
>> +
>> +    if (!strcmp("R", token)) {
>> +        ret = dcc_config_add_read(drvdata, bufp, curr_list);
>> +    } else if (!strcmp("W", token)) {
>> +        ret = dcc_config_add_write(drvdata, bufp, curr_list);
>> +    } else if (!strcmp("RW", token)) {
>> +        ret = dcc_config_add_read_write(drvdata, bufp, curr_list);
>> +    } else if (!strcmp("L", token)) {
>> +        ret = dcc_config_add_loop(drvdata, bufp, curr_list);
>> +    } else {
>> +        dev_err(drvdata->dev, "%s is not a correct input\n", token);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (ret)
>> +        return ret;
>> +
>> +    return count;
>> +}
>> +
>> +static const struct file_operations config_fops = {
>> +    .open = config_open,
>> +    .read = seq_read,
>> +    .write = config_write,
>> +    .llseek = seq_lseek,
>> +    .release = single_release,
>> +};
>> +
>> +static void dcc_delete_debug_dir(struct dcc_drvdata *dcc)
> 
> Here and in the next function, please use "drvdata" as the name
> of the symbol rather than "dcc", as is used everywhere else.
> 
> ... OR ...
> 
> Change the name of "struct dcc_drvdata" to be just "struct dcc",
> and rename *all* variables of that type to be "dcc".
> 
> I like the second suggestion, but at this point I guess the
> first is easiest.

Ack. Will go with the first.

> 
>> +{
>> +     debugfs_remove_recursive(dcc->dbg_dir);
>> +};
>> +
>> +static void dcc_create_debug_dir(struct dcc_drvdata *dcc)
>> +{
>> +    int i;
>> +    char list_num[10];
>> +    struct dentry *list;
>> +    struct device *dev = dcc->dev;
>> +
>> +    dcc->dbg_dir = debugfs_create_dir(dev_name(dev), NULL);
>> +    if (IS_ERR(dcc->dbg_dir)) {
>> +        pr_err("can't create debugfs dir\n");
>> +        return;
>> +    }
>> +
>> +    for (i = 0; i <= dcc->nr_link_list; i++) {
>> +        sprintf(list_num, "%d", i);
>> +        list = debugfs_create_dir(list_num, dcc->dbg_dir);
>> +        debugfs_create_file("enable", 0600, list, dcc, &enable_fops);
>> +        debugfs_create_file("config", 0600, list, dcc, &config_fops);
>> +    }
>> +
>> +    debugfs_create_file("trigger", 0200, dcc->dbg_dir, dcc, 
>> &trigger_fops);
>> +    debugfs_create_file("ready", 0400, dcc->dbg_dir, dcc, &ready_fops);
>> +    debugfs_create_file("config_reset", 0200, dcc->dbg_dir,
>> +                dcc, &config_reset_fops);
> 
> As I mentioned last time, any of the debugfs_create_file() calls
> could fail.  And I *think* the failure of any one of them is
> enough to make the driver functionality unusable.
> 
> So I think you should check for errors, and if any occur, just
> give up completely and return an error to the caller (dcc_probe()),
> and fail entirely.

As mentioned by Bjorn, there are cases where the DCC driver might be 
loaded just to configure addresses during boot-time statically, in such 
cases we wouldn't want the driver to fail even if there are issues while
creating debugfs interface. Patch series to do the same will be 
introduced subsequently. Currently dropped the error handling here as 
per Bjorn's suggestion on version 17 of the patch.

> 
>> +}
>> +
>> +static ssize_t dcc_sram_read(struct file *file, char __user *data,
>> +                 size_t len, loff_t *ppos)
>> +{
>> +    unsigned char *buf;
>> +    struct dcc_drvdata *drvdata = container_of(file->private_data,
>> +        struct dcc_drvdata,
>> +        sram_dev);
> 
> The indentation above is bad.  But I think this would look better
> anyway:
> 
>      struct dcc_drvdata *drvdata;
> 
>      drvdata = container_of(file->private_data, struct dcc_drvdata,
>                             sram_dev);
> 

Ack

>> +    /* EOF check */
>> +    if (*ppos >= drvdata->ram_size)
>> +        return 0;
>> +
>> +    if ((*ppos + len) > drvdata->ram_size)
>> +        len = (drvdata->ram_size - *ppos);
>> +
>> +    buf = kzalloc(len, GFP_KERNEL);
>> +    if (!buf)
>> +        return -ENOMEM;
>> +
>> +    memcpy_fromio(buf, drvdata->ram_base + *ppos, len);
>> +
>> +    if (copy_to_user(data, buf, len)) {
>> +        kfree(buf);
>> +        return -EFAULT;
>> +    }
>> +
>> +    *ppos += len;
>> +
>> +    kfree(buf);
>> +
>> +    return len;
>> +}
>> +
>> +static const struct file_operations dcc_sram_fops = {
>> +    .owner        = THIS_MODULE,
>> +    .read        = dcc_sram_read,
>> +    .llseek        = no_llseek,
>> +};
>> +
>> +static int dcc_sram_dev_init(struct dcc_drvdata *drvdata)
>> +{
>> +    drvdata->sram_dev.minor = MISC_DYNAMIC_MINOR;
>> +    drvdata->sram_dev.name = DCC_SRAM_NODE;
>> +    drvdata->sram_dev.fops = &dcc_sram_fops;
>> +
>> +    return misc_register(&drvdata->sram_dev);
>> +}
>> +
>> +static void dcc_sram_dev_exit(struct dcc_drvdata *drvdata)
>> +{
>> +    misc_deregister(&drvdata->sram_dev);
>> +}
>> +
>> +static int dcc_probe(struct platform_device *pdev)
>> +{
>> +    u32 val;
>> +    int ret = 0, i;
>> +    struct device *dev = &pdev->dev;
>> +    struct dcc_drvdata *dcc;
> 
> Please name the "dcc" variable "drvdata" as used everywhere else.

Ack

> 
>> +    struct resource *res;
>> +
>> +    dcc = devm_kzalloc(dev, sizeof(*dcc), GFP_KERNEL);
>> +    if (!dcc)
>> +        return -ENOMEM;
>> +
>> +    dcc->dev = &pdev->dev;
>> +    platform_set_drvdata(pdev, dcc);
>> +
>> +    dcc->base = devm_platform_ioremap_resource(pdev, 0);
>> +    if (IS_ERR(dcc->base))
>> +        return PTR_ERR(dcc->base);
>> +
>> +    dcc->ram_base = devm_platform_get_and_ioremap_resource(pdev, 1, 
>> &res);
>> +    if (IS_ERR(dcc->ram_base))
>> +        return PTR_ERR(dcc->ram_base);
>> +
>> +    dcc->ram_size = resource_size(res);
>> +
>> +    dcc->ram_offset = (size_t)of_device_get_match_data(&pdev->dev);
>> +
>> +    val = readl(dcc->base + DCC_HW_INFO);
>> +
>> +    if (FIELD_GET(DCC_VER_INFO_MASK, val)) {
>> +        dcc->mem_map_ver = 3;
>> +        dcc->nr_link_list = readl(dcc->base + DCC_LL_NUM_INFO);
>> +        if (dcc->nr_link_list == 0)
> 
> This is more typical kernel coding style:
> 
>          if (!dcc->nr_link_list)
> 
> Same comment on the condition in the next block.

Ack

> 
>> +            return    -EINVAL;
>> +    } else if ((val & DCC_VER_MASK2) == DCC_VER_MASK2) {
> 
> I don't know what's actually possible here.  But DCC_VER_MASK2
> is actually fewer bits (5) than DCC_VERSION_MASK_1 (6).  That
> means DCC_VER_MASK2 could fit inside DCC_VER_MASK1.  Is it
> guaranteed that the 6-bit DCC_VER_MASK1 will never have value
> 0x1f?
> 
> Anyway, I presume this is just fine...

Yes. This is as per the hardware specifications for setting the

memory map version.

> 
> 
>> +        dcc->mem_map_ver = 2;
>> +        dcc->nr_link_list = readl(dcc->base + DCC_LL_NUM_INFO);
>> +        if (dcc->nr_link_list == 0)
>> +            return    -EINVAL;
>> +    } else {
>> +        dcc->mem_map_ver = 1;
>> +        dcc->nr_link_list = DCC_MAX_LINK_LIST;
>> +    }
>> +
>> +    /* Either set the fixed loop offset or calculate
>> +     * it from the total number of words in dcc_sram.
>> +     * Max consecutive addresses dcc can loop is
>> +     * equivalent to the words in dcc_sram.
>> +     */
>> +    if (val & DCC_LOOP_OFFSET_MASK)
>> +        dcc->loopoff = DCC_FIX_LOOP_OFFSET;
>> +    else
>> +        dcc->loopoff = get_bitmask_order((dcc->ram_size +
>> +                dcc->ram_offset) / 4 - 1);
> 
> Every time I see this, I say something.  Even with your added
> comments, it's just not clear why you are getting the *order*
> of the end offset of the SRAM used for DCC, rather than just
> something directly related linearly to that offset.
> 
> Looking at the code elsewhere now, I see the "loopoff" field
> is actually used in dcc_emit_loop() as a *shift* amount.  The
> loop count is encoded in a 32-bit value with its low-order bit
> positioned at loopoff.  And *that* explains the use of get_bitmask_order().
> 
> * So I guess I personally would find a different name more
>    understandable (like, loop_shift?).
> 
> Based on my assumed "offset, not shift" I also thought that
> dcc->ram_offset shouldn't be included in the calculation.
> But I suppose the encoded loop count offset is a offset into
> a larger memory space (not just the SRAM range).  (Maybe
> that doesn't make sense, but I think I get it now.)
> 
> * As I suggested before, please use DCC_SRAM_WORD_LENGTH
>    instead of 4 here.
> 
> * Also I think "offset + size" is slightly better than
>    "size + offset" but it's really a minor thing.

Ack

> 
>> +    mutex_init(&dcc->mutex);
>> +
>> +    dcc->enable_bitmap = devm_kcalloc(dev, 
>> BITS_TO_LONGS(dcc->nr_link_list),
>> +                      sizeof(*dcc->enable_bitmap), GFP_KERNEL);
>> +    if (!dcc->enable_bitmap)
>> +        return -ENOMEM;
>> +
>> +    dcc->cfg_head = devm_kcalloc(dev, dcc->nr_link_list,
>> +                     sizeof(*dcc->cfg_head), GFP_KERNEL);
>> +    if (!dcc->cfg_head)
>> +        return -ENOMEM;
>> +
>> +    for (i = 0; i < dcc->nr_link_list; i++)
>> +        INIT_LIST_HEAD(&dcc->cfg_head[i]);
>> +
>> +    ret = dcc_sram_dev_init(dcc);
>> +    if (ret) {
>> +        dev_err(dcc->dev, "DCC: sram node not registered.\n");
>> +        return ret;
>> +    }
>> +
>> +    dcc_create_debug_dir(dcc);
>> +
>> +    return 0;
>> +}
>> +
>> +static int dcc_remove(struct platform_device *pdev)
>> +{
>> +    struct dcc_drvdata *drvdata = platform_get_drvdata(pdev);
>> +
>> +    dcc_delete_debug_dir(drvdata);
>> +    dcc_sram_dev_exit(drvdata);
>> +    dcc_config_reset(drvdata);
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct of_device_id dcc_match_table[] = {
>> +    { .compatible = "qcom,sc7180-dcc", .data = (void *)0x6000 },
>> +    { .compatible = "qcom,sc7280-dcc", .data = (void *)0x12000 },
>> +    { .compatible = "qcom,sdm845-dcc", .data = (void *)0x6000 },
>> +    { .compatible = "qcom,sm8150-dcc", .data = (void *)0x5000 },
>> +    { }
>> +};
>> +MODULE_DEVICE_TABLE(of, dcc_match_table);
>> +
>> +static struct platform_driver dcc_driver = {
>> +    .probe = dcc_probe,
>> +    .remove    = dcc_remove,
>> +    .driver    = {
>> +        .name = "qcom-dcc",
>> +        .of_match_table    = dcc_match_table,
>> +    },
>> +};
>> +
>> +module_platform_driver(dcc_driver);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("Qualcomm Technologies Inc. DCC driver");
>> +
> 
> There should be blank line at end of file (that might just get
> cleaned up automatically when the patch is applied).

Ack

> 
>> -- 
>> 2.7.4
>>
>>
>>
> 
