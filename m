Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E1C5F0579
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 09:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiI3HFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 03:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiI3HFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 03:05:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8F5CE9A5;
        Fri, 30 Sep 2022 00:05:46 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28U5UC1w001479;
        Fri, 30 Sep 2022 07:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8VkyR6rGiejmPszu/9Oexm/r0Fmn4AtfWnECnM5nd+0=;
 b=JkbBdqwEEsLFtaEg3IA2PzCB/eDaI9B57msP/QxSCKNPq1Pr1iHeYjmrtdT2UOcepOu6
 0kkxwlgrOIU11oqjMWKlubBTaMXN0R2D/OqOZU7PCUoosmNMRBI9UQG5JxJwieBbSMtQ
 v559g8wW+tLmT4SoegSl+hPu16pM3R9zNRUbwmibAznButN2EzYN31RbjJgdwzqzGPUD
 Pmf41dDgGIIpQFh+Ejy1yMyXZLlrAqvHOVvDWbNkddGE4/hf3HcwMIXOBpQlUZ7vrkst
 2DLqDgKiF4nDWkwjcpnAIotgBUK+mK/b+Mwxuojd/XPKOC9d9Rtp5sxvIoovSB0wU5K3 WA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jw4pc4j6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 07:05:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28U75ax9031609
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 07:05:36 GMT
Received: from [10.110.86.174] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 30 Sep
 2022 00:05:31 -0700
Message-ID: <802e633e-9212-caf4-27a8-468c2b23e951@quicinc.com>
Date:   Fri, 30 Sep 2022 12:35:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V14 2/7] soc: qcom: dcc: Add driver support for Data
 Capture and Compare unit(DCC)
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, <vkoul@kernel.org>
References: <cover.1664383851.git.quic_schowdhu@quicinc.com>
 <c286f5e35348253809146ef45840339509e36ff8.1664383851.git.quic_schowdhu@quicinc.com>
 <fd40ba79-4fc0-9bfe-e145-aabbd631fa9e@kernel.org>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <fd40ba79-4fc0-9bfe-e145-aabbd631fa9e@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qBesExO1LnOfy6-8SX0AFncdo7Uoas5p
X-Proofpoint-GUID: qBesExO1LnOfy6-8SX0AFncdo7Uoas5p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_03,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 phishscore=0 spamscore=0
 mlxscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209300042
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/28/2022 11:05 PM, Krzysztof Kozlowski wrote:
> On 28/09/2022 19:11, Souradeep Chowdhury wrote:
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
>>
>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> ---
>>   Documentation/ABI/testing/debugfs-driver-dcc |   98 ++
>>   drivers/soc/qcom/Kconfig                     |    8 +
>>   drivers/soc/qcom/Makefile                    |    1 +
>>   drivers/soc/qcom/dcc.c                       | 1352 ++++++++++++++++++++++++++
>>   4 files changed, 1459 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/debugfs-driver-dcc
>>   create mode 100644 drivers/soc/qcom/dcc.c
>>
>> diff --git a/Documentation/ABI/testing/debugfs-driver-dcc b/Documentation/ABI/testing/debugfs-driver-dcc
>> new file mode 100644
>> index 0000000..387f67e
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/debugfs-driver-dcc
>> @@ -0,0 +1,98 @@
>> +What:           /sys/kernel/debug/dcc/.../ready
>> +Date:           September 2022
>> +Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> +Description:
>> +		This file is used to check the status of the dcc
>> +		hardware if it's ready to take the inputs. A 'Y'
>> +		here indicates dcc is in a ready condition.
>> +		Example:
>> +		cat /sys/kernel/debug/dcc/.../ready
>> +
>> +What:           /sys/kernel/debug/dcc/.../trigger
>> +Date:           September 2022
>> +Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> +Description:
>> +		This is the debugfs interface for manual software
>> +		triggers. The user can simply enter a 1 against
>> +		the debugfs file and enable a manual trigger.
>> +		Example:
>> +		echo  1 > /sys/kernel/debug/dcc/.../trigger
>> +
>> +What:           /sys/kernel/debug/dcc/.../config_reset
>> +Date:           September 2022
>> +Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> +Description:
>> +		This file is used to reset the configuration of
>> +		a dcc driver to the default configuration. This
>> +		means that all the previous addresses stored in
>> +		the driver gets removed and user needs to enter
>> +		the address values from the start.
>> +		Example:
>> +		echo  1 > /sys/kernel/debug/dcc/../config_reset
>> +
>> +What:           /sys/kernel/debug/dcc/.../[list-number]/config
>> +Date:           September 2022
>> +Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> +Description:
>> +		This stores the addresses of the registers which
>> +		should be read in case of a hardware crash or
>> +		manual software triggers. The addresses entered here
>> +		are considered under all the 4 types of dcc
>> +		instructions Read type, Write type, Read Modify Write
>> +		type and Loop type. The lists need to be configured
>> +		sequentially and not in a overlapping manner. As an
>> +		example user can jump to list x only after list y is
>> +		configured and enabled. The format for entering all
>> +		types of instructions are explained in examples as
>> +		follows.
>> +		Example:
>> +	         i)Read Type Instruction
>> +		   echo R <1> <2> <3> >/sys/kernel/debug/dcc/../[list-number]/config
>> +		   1->Address to be considered for reading the value.
>> +		   2->The word count of the addresses, read n words
>> +		      starting from address <1>. Each word is of 32 bits.
>> +		      If not entered 1 is considered.
>> +		   3->Can be 'apb' or 'ahb' which indicates if it is apb or ahb
>> +		      bus respectively. If not entered ahb is considered.
>> +		ii)Write Type Instruction
>> +		   echo W <1> <2> <3> > /sys/kernel/debug/dcc/../[list-number]/config
>> +		   1->Address to be considered for writing the value.
>> +		   2->The value that needs to be written at the location.
>> +		   3->Can be a 'apb' or 'ahb' which indicates if it is apb or ahb
>> +		      but respectively.
>> +	       iii)Read Modify Write type instruction
>> +		   echo RW <1> <2> <3> > /sys/kernel/debug/dcc/../[list-number]/config
>> +		   1->The address which needs to be considered for read then write.
>> +		   2->The value that needs to be written on the address.
>> +		   3->The mask of the value to be written.
>> +		iv)Loop Type Instruction
>> +		   echo L <1> <2> <3> > /sys/kernel/debug/dcc/../[list-number]/config
>> +		   1->The loop count, the number of times the value of the addresses will be
>> +		      captured.
>> +		   2->The address count, total number of addresses to be entered in this
>> +		      instruction.
>> +		   3->The series of addresses to be entered separated by a space like <addr1>
>> +		      <addr2>... and so on.
>> +
>> +What:           /sys/kernel/debug/dcc/.../[list-number]/enable
>> +Date:           September 2022
>> +Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> +Description:
>> +		This debugfs interface is used for enabling the
>> +		the dcc hardware. Enable file is kept under the
>> +		directory list number for which the user wants
>> +		to enable it. For example if the user wants to
>> +		enable list 1, then he should go for
>> +		echo 1 > /sys/kernel/debug/dcc/.../1/enable.
>> +		On enabling the dcc, all the addresses entered
>> +		by the user for the corresponding list is written
>> +		into dcc sram which is read by the dcc hardware
>> +		on manual or crash induced triggers. Lists should
>> +		be enabled sequentially.For example after configuring
>> +		addresses for list 1 and enabling it, a user can
>> +		proceed to enable list 2 or vice versa.
>> +		Example:
>> +		echo  0 > /sys/kernel/debug/dcc/.../[list-number]/enable
>> +		(disable dcc for the corresponding list number)
>> +		echo  1 > /sys/kernel/debug/dcc/.../[list-number]/enable
>> +		(enable dcc for the corresponding list number)
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index 024e420..d5730bf 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -69,6 +69,14 @@ config QCOM_LLCC
>>   	  SDM845. This provides interfaces to clients that use the LLCC.
>>   	  Say yes here to enable LLCC slice driver.
>>
>> +config QCOM_DCC
>> +	tristate "Qualcomm Technologies, Inc. Data Capture and Compare(DCC) engine driver"
>> +	depends on ARCH_QCOM || COMPILE_TEST
>> +	help
>> +	  This option enables driver for Data Capture and Compare engine. DCC
>> +	  driver provides interface to configure DCC block and read back
>> +	  captured data from DCC's internal SRAM.
>> +
>>   config QCOM_KRYO_L2_ACCESSORS
>>   	bool
>>   	depends on ARCH_QCOM && ARM64 || COMPILE_TEST
>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>> index d66604a..b1fe812 100644
>> --- a/drivers/soc/qcom/Makefile
>> +++ b/drivers/soc/qcom/Makefile
>> @@ -4,6 +4,7 @@ obj-$(CONFIG_QCOM_AOSS_QMP) +=	qcom_aoss.o
>>   obj-$(CONFIG_QCOM_GENI_SE) +=	qcom-geni-se.o
>>   obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
>>   obj-$(CONFIG_QCOM_CPR)		+= cpr.o
>> +obj-$(CONFIG_QCOM_DCC) += dcc.o
>>   obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
>>   obj-$(CONFIG_QCOM_MDT_LOADER)	+= mdt_loader.o
>>   obj-$(CONFIG_QCOM_OCMEM)	+= ocmem.o
>> diff --git a/drivers/soc/qcom/dcc.c b/drivers/soc/qcom/dcc.c
>> new file mode 100644
>> index 0000000..e16c074
>> --- /dev/null
>> +++ b/drivers/soc/qcom/dcc.c
>> @@ -0,0 +1,1352 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2015-2021, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
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
>> +#define STATUS_READY_TIMEOUT		5000  /*microseconds*/
>> +
>> +#define DCC_SRAM_NODE "dcc_sram"
>> +
>> +/* DCC registers */
>> +#define DCC_HW_INFO			0x04
>> +#define DCC_LL_NUM_INFO			0x10
>> +#define DCC_STATUS(vers)		((vers) == 1 ? 0x0c : 0x1c)
>> +#define DCC_LL_LOCK			0x00
>> +#define DCC_LL_CFG			0x04
>> +#define DCC_LL_BASE			0x08
>> +#define DCC_FD_BASE			0x0c
>> +#define DCC_LL_TIMEOUT			0x10
>> +#define DCC_LL_INT_ENABLE		0x18
>> +#define DCC_LL_INT_STATUS		0x1c
>> +#define DCC_LL_SW_TRIGGER		0x2c
>> +#define DCC_LL_BUS_ACCESS_STATUS	0x30
>> +
>> +#define DCC_MAP_LEVEL1			0x18
>> +#define DCC_MAP_LEVEL2			0x34
>> +#define DCC_MAP_LEVEL3			0x4C
>> +
>> +#define DCC_MAP_OFFSET1			0x10
>> +#define DCC_MAP_OFFSET2			0x18
>> +#define DCC_MAP_OFFSET3			0x1C
>> +#define DCC_MAP_OFFSET4			0x8
>> +
>> +/*Default value used if a bit 6 in the HW_INFO register is set.*/
>> +#define DCC_FIX_LOOP_OFFSET		16
>> +
>> +/*Mask to find version info from HW_Info register*/
>> +#define DCC_VER_INFO_MASK		BIT(9)
>> +
>> +#define DCC_READ			0
>> +#define DCC_WRITE			1
>> +#define DCC_LOOP			2
>> +#define DCC_READ_WRITE			3
>> +
>> +#define MAX_DCC_OFFSET			GENMASK(9, 2)
>> +#define MAX_DCC_LEN			GENMASK(6, 0)
>> +#define MAX_LOOP_CNT			GENMASK(7, 0)
>> +#define MAX_LOOP_ADDR			10
>> +
>> +#define DCC_ADDR_DESCRIPTOR		0x00
>> +#define DCC_ADDR_LIMIT			27
>> +#define DCC_ADDR_OFF_RANGE		8
>> +#define DCC_ADDR_RANGE_MASK		GENMASK(31, 4)
>> +#define DCC_LOOP_DESCRIPTOR		BIT(30)
>> +#define DCC_RD_MOD_WR_DESCRIPTOR	BIT(31)
>> +#define DCC_LINK_DESCRIPTOR		GENMASK(31, 30)
>> +#define DCC_STATUS_MASK			GENMASK(1, 0)
>> +#define DCC_LOCK_MASK                   BIT(0)
>> +#define DCC_LOOP_OFFSET_MASK		BIT(6)
>> +#define DCC_TRIGGER_MASK		BIT(9)
>> +
>> +#define DCC_WRITE_MASK			BIT(15)
>> +#define DCC_WRITE_OFF_MASK		GENMASK(7, 0)
>> +#define DCC_WRITE_LEN_MASK		GENMASK(14, 8)
>> +
>> +#define DCC_READ_IND			0x00
>> +#define DCC_WRITE_IND			(BIT(28))
>> +
>> +#define DCC_AHB_IND			0x00
>> +#define DCC_APB_IND			BIT(29)
>> +
>> +#define DCC_MAX_LINK_LIST		8
>> +#define DCC_INVALID_LINK_LIST		GENMASK(7, 0)
>> +
>> +#define DCC_VER_MASK1			GENMASK(6, 0)
>> +#define DCC_VER_MASK2			GENMASK(5, 0)
>> +
>> +#define DCC_SRAM_WORD_LENGTH		4
>> +
>> +#define DCC_RD_MOD_WR_ADDR              0xC105E
>> +
>> +/*DCC debugfs directory*/
>> +static struct dentry	*dcc_dbg;
>> +
>> +enum dcc_descriptor_type {
>> +	DCC_READ_TYPE,
>> +	DCC_LOOP_TYPE,
>> +	DCC_READ_WRITE_TYPE,
>> +	DCC_WRITE_TYPE
>> +};
>> +
>> +struct dcc_config_entry {
>> +	u32				base;
>> +	u32				offset;
>> +	u32				len;
>> +	u32				loop_cnt;
>> +	u32				write_val;
>> +	u32				mask;
>> +	bool				apb_bus;
>> +	enum dcc_descriptor_type	desc_type;
>> +	struct list_head		list;
>> +};
>> +
>> +/**
>> + * struct dcc_drvdata - configuration information related to a dcc device
>> + * @base:		Base Address of the dcc device
>> + * @dev:		The device attached to the driver data
>> + * @mutex:		Lock to protect access and manipulation of dcc_drvdata
>> + * @ram_base:		Base address for the SRAM dedicated for the dcc device
>> + * @ram_size:		Total size of the SRAM dedicated for the dcc device
>> + * @ram_offset:	Offset to the SRAM dedicated for dcc device
>> + * @mem_map_ver:	Memory map version of DCC hardware
>> + * @ram_cfg:		Used for address limit calculation for dcc
>> + * @ram_start:		Starting address of DCC SRAM
>> + * @sram_dev:		Miscellaneous device equivalent of dcc SRAM
>> + * @cfg_head:		Points to the head of the linked list of addresses
> So where is the list item? Is it dcc_config_entry?
Yes that's right.
>
>> + * @dbg_dir:		The dcc debugfs directory under which all the debugfs files are placed
>> + * @nr_link_list:	Total number of linkedlists supported by the DCC configuration
>> + * @loopoff:		Loop offset bits range for the addresses
>> + * @enable;		This contains an array of linkedlist enable flags
> Typo: ;
>
> Compile it with W=1 and fix all the warnings.
>
> The description of this field still looks wrong. It does not have array
> of linked lists. Linked list is list_head, this is a bool.
Ack
>
> Best regards,
> Krzysztof
>
