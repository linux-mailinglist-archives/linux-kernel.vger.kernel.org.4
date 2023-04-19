Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A596E7398
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 09:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjDSHBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 03:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjDSHBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:01:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623F9191;
        Wed, 19 Apr 2023 00:01:20 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33J6JpDk007974;
        Wed, 19 Apr 2023 07:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KyzlXhyFGaaeR55GRtCttFAUB+UfMwYPL77LV2G/rC4=;
 b=BXBSDQL3sXuAIdfAX7iaCZB24dODZzWCjX43QKhcOLR3DPlZY8x4qTYG5FHAtkDyd7wv
 0tEi+sUkNDcJpsEZGh0X9gE2dxdovap7NL0JDlDtCViz5kptBPDEh4QFQKan0ymowWFk
 jha3mfhpVgdPekJkJKI7PuzojBah5rIQHnYSiTTUP1cUXabuYU61/IaiMLWp2pQiQdIN
 5TUl3Q6gLKLGTo/UScfxejMysN5Mpd0zYcJqcHZR7MySP04W+kMODdk+fhwKHyjE8SQn
 XMCLspJR1BpX751HIb0IleEGj+DFQ8k6nEdQWHNBaUoK87ETw2fn+sn3PDxMyuSbtgmD Og== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q25kwrm5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 07:00:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33J70okY018058
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 07:00:50 GMT
Received: from [10.50.49.141] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 19 Apr
 2023 00:00:45 -0700
Message-ID: <f1456dd7-5dcf-d91a-459c-65efca4a3444@quicinc.com>
Date:   Wed, 19 Apr 2023 12:30:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V22 2/3] misc: dcc: Add driver support for Data Capture
 and Compare unit(DCC)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>,
        Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        "Rajendra Nayak" <quic_rjendra@quicinc.com>
References: <cover.1681829664.git.quic_schowdhu@quicinc.com>
 <e4f41fa61d9dd66f68bbd7650c6fbf96810c3569.1681829664.git.quic_schowdhu@quicinc.com>
 <2023041833-alienate-trash-f4da@gregkh>
Content-Language: en-US
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <2023041833-alienate-trash-f4da@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2M9xIiiVGE63EV5UL28bIqVaC937xsDY
X-Proofpoint-GUID: 2M9xIiiVGE63EV5UL28bIqVaC937xsDY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-19_02,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304190064
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/18/2023 9:15 PM, Greg Kroah-Hartman wrote:
> On Tue, Apr 18, 2023 at 08:52:36PM +0530, Souradeep Chowdhury wrote:
>> The DCC is a DMA Engine designed to capture and store data during system
>> crash or software triggers. The DCC operates based on user inputs via
>> the debugfs interface. The user gives addresses as inputs and these
>> addresses are stored in the dcc sram. In case of a system crash or a
>> manual software trigger by the user through the debugfs interface, the
>> dcc captures and stores the values at these addresses. This patch
>> contains the driver which has all the methods pertaining to the debugfs
>> interface, auxiliary functions to support all the four fundamental
>> operations of dcc namely read, write, read/modify/write and loop. The
>> probe method here instantiates all the resources necessary for dcc to
>> operate mainly the dedicated dcc sram where it stores the values. The
>> DCC driver can be used for debugging purposes without going for a reboot
>> since it can perform software triggers as well based on user inputs.
>>
>> Also add the documentation for debugfs entries which explains the
>> functionalities of each debugfs file that has been created for dcc.
> 
> I see no documentation entries in this commit :(

My apologies, this patch was given from qcom-next tree which already has 
the documentation merged. Will include it from the next versions.

> 
>> The following is the justification of using debugfs interface over the
>> other alternatives like sysfs/ioctls
>>
>> i) As can be seen from the debugfs attribute descriptions, some of the
>> debugfs attribute files here contains multiple arguments which needs to
>> be accepted from the user. This goes against the design style of sysfs.
>>
>> ii) The user input patterns have been made simple and convenient in this
>> case with the use of debugfs interface as user doesn't need to shuffle
>> between different files to execute one instruction as was the case on
>> using other alternatives.
> 
> Why do you have debugfs and also a misc device?  How are they related?
> Why both?  Why not just one?  What userspace tools are going to use
> either of these interfaces and where are they published to show how this
> all was tested?

DCC has two fundamental steps of usage:-

1.Configuring the register addresses on the dcc_sram which is done by 
user through the debugfs interface. For example:-

echo R 0x10c004 > /sys/kernel/debug/dcc/../3/config

Here we are configuring the register addresses for list 3, the 'R'
indicates a read operation, so this register value will be read
in case of a software trigger or kernel panic/watchdog bite and
dumped into the dcc_sram.

2.The dcc_sram content is exposed to the user in the form of a misc 
device. The user can parse the content of this dcc_sram to get the
register values. There is an opensource parser available for dcc at
the following location:-

https://git.codelinaro.org/clo/le/platform/vendor/qcom-opensource/tools/-/tree/opensource-tools.lnx.1.0.r176-rel/dcc_parser

> 
>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> Reviewed-by: Alex Elder <elder@linaro.org>
>> ---
>>   drivers/misc/Kconfig  |    8 +
>>   drivers/misc/Makefile |    1 +
>>   drivers/misc/dcc.c    | 1300 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 1309 insertions(+)
>>   create mode 100644 drivers/misc/dcc.c
>>
>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>> index 433aa41..e2bc652 100644
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
>> @@ -276,6 +276,14 @@ config QCOM_COINCELL
>>   	  to maintain PMIC register and RTC state in the absence of
>>   	  external power.
>>   
>> +config QCOM_DCC
>> +	tristate "Qualcomm Technologies, Inc. Data Capture and Compare(DCC) engine driver"
>> +	depends on ARCH_QCOM || COMPILE_TEST
>> +	help
>> +	  This option enables driver for Data Capture and Compare engine. DCC
>> +	  driver provides interface to configure DCC block and read back
>> +	  captured data from DCC's internal SRAM.
> 
> 
> What is the module name?

It's qcom-dcc, will update the name here.

> 
>> +
>>   config QCOM_FASTRPC
>>   	tristate "Qualcomm FastRPC"
>>   	depends on ARCH_QCOM || COMPILE_TEST
>> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
>> index 56de439..6fa8efa 100644
>> --- a/drivers/misc/Makefile
>> +++ b/drivers/misc/Makefile
>> @@ -16,6 +16,7 @@ obj-$(CONFIG_TIFM_CORE)       	+= tifm_core.o
>>   obj-$(CONFIG_TIFM_7XX1)       	+= tifm_7xx1.o
>>   obj-$(CONFIG_PHANTOM)		+= phantom.o
>>   obj-$(CONFIG_QCOM_COINCELL)	+= qcom-coincell.o
>> +obj-$(CONFIG_QCOM_DCC)		+= dcc.o
> 
> Why such a generic name?  Shouldn't it be qcom-dcc?

Ack

> 
> 
> 
>>   obj-$(CONFIG_QCOM_FASTRPC)	+= fastrpc.o
>>   obj-$(CONFIG_SENSORS_BH1770)	+= bh1770glc.o
>>   obj-$(CONFIG_SENSORS_APDS990X)	+= apds990x.o
>> diff --git a/drivers/misc/dcc.c b/drivers/misc/dcc.c
>> new file mode 100644
>> index 0000000..7231ed9
>> --- /dev/null
>> +++ b/drivers/misc/dcc.c
>> @@ -0,0 +1,1300 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2015-2021, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> 
> No work happened on this code in 2022?  All 22 of these entries were
> only in 2021 and 2023?

Ack

> 
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
>> +#define STATUS_READY_TIMEOUT		5000  /* microseconds */
>> +
>> +/* DCC registers */
>> +#define DCC_HW_INFO			0x04
>> +#define DCC_LL_NUM_INFO			0x10
>> +#define DCC_STATUS(vers)		((vers) == 1 ? 0x0c : 0x1c)
> 
> Why isn't this just an inline function?

Ack. Will make this inline

> 
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
>> +/* Default value used if a bit 6 in the HW_INFO register is set. */
>> +#define DCC_FIX_LOOP_OFFSET		16
>> +
>> +/* Mask to find version info from HW_Info register */
>> +#define DCC_VER_INFO_MASK		BIT(9)
>> +
>> +#define MAX_DCC_OFFSET			GENMASK(9, 2)
>> +#define MAX_DCC_LEN			GENMASK(6, 0)
>> +#define MAX_LOOP_CNT			GENMASK(7, 0)
>> +#define MAX_LOOP_ADDR			10
>> +
>> +#define DCC_ADDR_DESCRIPTOR		0x00
>> +#define DCC_ADDR_LIMIT			27
>> +#define DCC_WORD_SIZE			sizeof(u32)
>> +#define DCC_ADDR_RANGE_MASK		GENMASK(31, 4)
>> +#define DCC_LOOP_DESCRIPTOR		BIT(30)
>> +#define DCC_RD_MOD_WR_DESCRIPTOR	BIT(31)
>> +#define DCC_LINK_DESCRIPTOR		GENMASK(31, 30)
>> +#define DCC_STATUS_MASK			GENMASK(1, 0)
>> +#define DCC_LOCK_MASK			BIT(0)
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
>> +
>> +#define DCC_VER_MASK2			GENMASK(5, 0)
>> +
>> +#define DCC_SRAM_WORD_LENGTH		4
>> +
>> +#define DCC_RD_MOD_WR_ADDR              0xC105E
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
> 
> No documentation for this structure?

Ack. Will add documentation to this structure as well.

> 
>> +
>> +/**
>> + * struct dcc_drvdata - configuration information related to a dcc device
>> + * @base:		Base Address of the dcc device
>> + * @dev:		The device attached to the driver data
>> + * @mutex:		Lock to protect access and manipulation of dcc_drvdata
>> + * @ram_base:		Base address for the SRAM dedicated for the dcc device
>> + * @ram_size:		Total size of the SRAM dedicated for the dcc device
>> + * @ram_offset:		Offset to the SRAM dedicated for dcc device
>> + * @mem_map_ver:	Memory map version of DCC hardware
>> + * @ram_cfg:		Used for address limit calculation for dcc
>> + * @ram_start:		Starting address of DCC SRAM
>> + * @sram_dev:		Miscellaneous device equivalent of dcc SRAM
>> + * @cfg_head:		Points to the head of the linked list of addresses
>> + * @dbg_dir:		The dcc debugfs directory under which all the debugfs files are placed
>> + * @nr_link_list:	Total number of linkedlists supported by the DCC configuration
>> + * @loop_shift:		Loop offset bits range for the addresses
>> + * @enable_bitmap:	Bitmap to capture the enabled status of each linked list of addresses
>> + */
>> +struct dcc_drvdata {
>> +	void __iomem		*base;
>> +	void __iomem            *ram_base;
>> +	struct device		*dev;
> 
> Why do you need this back-pointer here?

This is getting used at multiple places to log
dev_err and also for resource allocation using
devm_kzalloc.

> 
>> +	struct mutex		mutex;
>> +	size_t			ram_size;
>> +	size_t			ram_offset;
>> +	int			mem_map_ver;
>> +	unsigned int		ram_cfg;
>> +	unsigned int		ram_start;
>> +	struct miscdevice	sram_dev;
> 
> Wait, this is the struct device, right?  Or not?

miscdevice here represents the dcc_sram, an io-memory
dedicated to dcc for configuring/storing register values.
Whereas struct device represents the dcc_device which can
be used to write control signals on the bus to handle dcc
hardware operation sequence(like config_reset,sw_trigger etc.)

> 
>> +	struct list_head	*cfg_head;
>> +	struct dentry		*dbg_dir;
> 
> Why is this needed and not just looked up when necessary?

This needs to be passed while creating sub-directories and also
while removing. Rather than looking up everytime,saving and
re-using this in here.

> 
>> +	size_t			nr_link_list;
>> +	u8			loop_shift;
>> +	unsigned long		*enable_bitmap;
> 
> So this is a list of bitmaps?  Why "unsigned long"?  Why not u64?

Ack

> 
>> +};
>> +
>> +struct dcc_cfg_attr {
>> +	u32	addr;
>> +	u32	prev_addr;
>> +	u32	prev_off;
>> +	u32	link;
>> +	u32	sram_offset;
>> +};
>> +
>> +struct dcc_cfg_loop_attr {
>> +	u32	loop_cnt;
>> +	u32	loop_len;
>> +	u32	loop_off;
>> +	bool    loop_start;
>> +};
>> +
>> +static inline u32 dcc_list_offset(int version)
>> +{
>> +	return version == 1 ? 0x1c : version == 2 ? 0x2c : 0x34;
>> +}
> 
> Ah, you do have an inline function for the above mentioned macro.
> Please drop the macro.
> 
> And write this inline function out to be readable, single-level ?:
> comments are impossible to read, let alone double-level ones.
> 
> Write code for people first, compilers second.  You gain nothing by
> making this terse except to confuse people.

Ack. This inline function is different from the previous macro.

Will keep both as inline functions.

> 
>> +
>> +static inline void dcc_list_writel(struct dcc_drvdata *drvdata,
>> +				   u32 ll, u32 val, u32 off)
>> +{
>> +	u32 offset = dcc_list_offset(drvdata->mem_map_ver) + off;
>> +
>> +	writel(val, drvdata->base + ll * 0x80 + offset);
> 
> What is this magic 0x80 for?

This is the list offset needed for address calculation as per the 
dcc-hardware specification. Will declare a macro for this.

> 
>> +}
>> +
>> +static inline u32 dcc_list_readl(struct dcc_drvdata *drvdata, u32 ll, u32 off)
>> +{
>> +	u32 offset = dcc_list_offset(drvdata->mem_map_ver) + off;
>> +
>> +	return readl(drvdata->base + ll * 0x80 + offset);
> 
> Again, where did 0x80 come from?

Same as above.

> 
>> +}
>> +
>> +static void dcc_sram_write_auto(struct dcc_drvdata *drvdata,
>> +				u32 val, u32 *off)
>> +{
>> +	/* If the overflow condition is met increment the offset
>> +	 * and return to indicate that overflow has occurred
>> +	 */
>> +	if (unlikely(*off > drvdata->ram_size - 4)) {
>> +		*off += 4;
>> +		return;
> 
> You didn't indicate anything here, all you did was succeed at the call,
> the caller has no way of ever knowing this failed.
> 
> Why not return an error?

As per previous discussions it was decided to perform the write 
speculatively. So that while writing to the dcc_sram if we exceed
the memory size, dcc will skip the write and keep incrementing
the offset. In the method "dcc_emit_config" we have the check to
finally detect if we have exceeded the sram offset

if (cfg.sram_offset + total_len > drvdata->ram_size) {
	cfg.sram_offset += total_len;
	goto overstep;
}

> 
>> +	}
>> +
>> +	writel(val, drvdata->ram_base + *off);
>> +
>> +	*off += 4;
> 
> See, same modification as your "error" above.
> 
> How was this tested?

This increment is needed to update the offset for the next memory
position in dcc_sram.

> 
>> +static int dcc_emit_config(struct dcc_drvdata *drvdata, unsigned int curr_list)
>> +{
>> +	int ret;
>> +	u32 total_len, pos;
>> +	struct dcc_config_entry *entry;
>> +	struct dcc_cfg_attr cfg;
>> +	struct dcc_cfg_loop_attr cfg_loop;
>> +
>> +	memset(&cfg, 0, sizeof(cfg));
>> +	memset(&cfg_loop, 0, sizeof(cfg_loop));
> 
> Why are these large structures on the stack?

cfg_loop is needed for offset calculation in case of dcc loop 
instructions based on the way it needs to be configured in dcc_sram
for dcc hardware to interpret it. entry, cfg is a generic structure used
across all dcc instructions. All these structures are needed for the
memory checks after we are done with configuring all the dcc instructions.

> 
> And if on the stack, why not have the compiler initialize them to 0 for
> you automatically?

Ack

> 
> I stopped reviewing here...
> 
> greg k-h
