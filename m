Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B835FE893
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 08:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiJNGCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 02:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiJNGCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 02:02:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB3D1AAE6C;
        Thu, 13 Oct 2022 23:01:52 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29E4ORqf029732;
        Fri, 14 Oct 2022 06:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=4ZHhleTCCN3ryYzfqp2bjJMajF+vlFqk+nwgibKKV8o=;
 b=c3o77/kgXKYUAL5fkqm8HsbXEoqRpVeI0Bb09rGfz9k2pgNS7G2JYx0hwclCybw8xdJs
 iNi1+igL2oygiYcCk038U5nhQGXIfTxR1/nF7a9SZBVI69x7wKdMclR0OWq1Nb5/yV0N
 AKsPDLQXDHSjrt+3OJT2DV4dAjajaeubl8t6j7/zW0Fkz0VqeqnGc2nw1ff4uktrwp7J
 DK+nle8vvRvxb+1Ple/b3v0XH2MSXjRZ5Q4BKY6cTFcBVTg+4D1tzHIiF8JvDrwmmkbJ
 uJXmXFVsv5vrBEzVdop/PeOfmMRRV4KVGP93pIRtLF5cnb+XICN6KqdUb9GV30Z6Got9 QQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k66xjvc0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 06:01:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29E61YBH027941
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 06:01:34 GMT
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 13 Oct 2022 23:01:29 -0700
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Alex Elder <elder@ieee.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, <vkoul@kernel.org>,
        "Souradeep Chowdhury" <quic_schowdhu@quicinc.com>
Subject: [PATCH V17 2/7] soc: qcom: dcc: Add driver support for Data Capture and Compare unit(DCC)
Date:   Fri, 14 Oct 2022 11:30:28 +0530
Message-ID: <5fee939d0a238344c7db11cf322adcb6baa35724.1665549527.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1665549527.git.quic_schowdhu@quicinc.com>
References: <cover.1665549527.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cE6c2gUZtz-cfHF4vuuelvSFSbIgUXXw
X-Proofpoint-ORIG-GUID: cE6c2gUZtz-cfHF4vuuelvSFSbIgUXXw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_02,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140034
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DCC is a DMA Engine designed to capture and store data
during system crash or software triggers. The DCC operates
based on user inputs via the debugfs interface. The user gives
addresses as inputs and these addresses are stored in the
dcc sram. In case of a system crash or a manual software
trigger by the user through the debugfs interface,
the dcc captures and stores the values at these addresses.
This patch contains the driver which has all the methods
pertaining to the debugfs interface, auxiliary functions to
support all the four fundamental operations of dcc namely
read, write, read/modify/write and loop. The probe method
here instantiates all the resources necessary for dcc to
operate mainly the dedicated dcc sram where it stores the
values. The DCC driver can be used for debugging purposes
without going for a reboot since it can perform software
triggers as well based on user inputs.

Also added the documentation for debugfs entries and explained
the functionalities of each debugfs file that has been created
for dcc.

The following is the justification of using debugfs interface
over the other alternatives like sysfs/ioctls

i) As can be seen from the debugfs attribute descriptions,
some of the debugfs attribute files here contains multiple
arguments which needs to be accepted from the user. This goes
against the design style of sysfs.

ii) The user input patterns have been made simple and convenient
in this case with the use of debugfs interface as user doesn't
need to shuffle between different files to execute one instruction
as was the case on using other alternatives.

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
---
 Documentation/ABI/testing/debugfs-driver-dcc |   98 ++
 drivers/soc/qcom/Kconfig                     |    8 +
 drivers/soc/qcom/Makefile                    |    1 +
 drivers/soc/qcom/dcc.c                       | 1355 ++++++++++++++++++++++++++
 4 files changed, 1462 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-driver-dcc
 create mode 100644 drivers/soc/qcom/dcc.c

diff --git a/Documentation/ABI/testing/debugfs-driver-dcc b/Documentation/ABI/testing/debugfs-driver-dcc
new file mode 100644
index 0000000..387f67e
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-driver-dcc
@@ -0,0 +1,98 @@
+What:           /sys/kernel/debug/dcc/.../ready
+Date:           September 2022
+Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
+Description:
+		This file is used to check the status of the dcc
+		hardware if it's ready to take the inputs. A 'Y'
+		here indicates dcc is in a ready condition.
+		Example:
+		cat /sys/kernel/debug/dcc/.../ready
+
+What:           /sys/kernel/debug/dcc/.../trigger
+Date:           September 2022
+Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
+Description:
+		This is the debugfs interface for manual software
+		triggers. The user can simply enter a 1 against
+		the debugfs file and enable a manual trigger.
+		Example:
+		echo  1 > /sys/kernel/debug/dcc/.../trigger
+
+What:           /sys/kernel/debug/dcc/.../config_reset
+Date:           September 2022
+Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
+Description:
+		This file is used to reset the configuration of
+		a dcc driver to the default configuration. This
+		means that all the previous addresses stored in
+		the driver gets removed and user needs to enter
+		the address values from the start.
+		Example:
+		echo  1 > /sys/kernel/debug/dcc/../config_reset
+
+What:           /sys/kernel/debug/dcc/.../[list-number]/config
+Date:           September 2022
+Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
+Description:
+		This stores the addresses of the registers which
+		should be read in case of a hardware crash or
+		manual software triggers. The addresses entered here
+		are considered under all the 4 types of dcc
+		instructions Read type, Write type, Read Modify Write
+		type and Loop type. The lists need to be configured
+		sequentially and not in a overlapping manner. As an
+		example user can jump to list x only after list y is
+		configured and enabled. The format for entering all
+		types of instructions are explained in examples as
+		follows.
+		Example:
+	         i)Read Type Instruction
+		   echo R <1> <2> <3> >/sys/kernel/debug/dcc/../[list-number]/config
+		   1->Address to be considered for reading the value.
+		   2->The word count of the addresses, read n words
+		      starting from address <1>. Each word is of 32 bits.
+		      If not entered 1 is considered.
+		   3->Can be 'apb' or 'ahb' which indicates if it is apb or ahb
+		      bus respectively. If not entered ahb is considered.
+		ii)Write Type Instruction
+		   echo W <1> <2> <3> > /sys/kernel/debug/dcc/../[list-number]/config
+		   1->Address to be considered for writing the value.
+		   2->The value that needs to be written at the location.
+		   3->Can be a 'apb' or 'ahb' which indicates if it is apb or ahb
+		      but respectively.
+	       iii)Read Modify Write type instruction
+		   echo RW <1> <2> <3> > /sys/kernel/debug/dcc/../[list-number]/config
+		   1->The address which needs to be considered for read then write.
+		   2->The value that needs to be written on the address.
+		   3->The mask of the value to be written.
+		iv)Loop Type Instruction
+		   echo L <1> <2> <3> > /sys/kernel/debug/dcc/../[list-number]/config
+		   1->The loop count, the number of times the value of the addresses will be
+		      captured.
+		   2->The address count, total number of addresses to be entered in this
+		      instruction.
+		   3->The series of addresses to be entered separated by a space like <addr1>
+		      <addr2>... and so on.
+
+What:           /sys/kernel/debug/dcc/.../[list-number]/enable
+Date:           September 2022
+Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
+Description:
+		This debugfs interface is used for enabling the
+		the dcc hardware. Enable file is kept under the
+		directory list number for which the user wants
+		to enable it. For example if the user wants to
+		enable list 1, then he should go for
+		echo 1 > /sys/kernel/debug/dcc/.../1/enable.
+		On enabling the dcc, all the addresses entered
+		by the user for the corresponding list is written
+		into dcc sram which is read by the dcc hardware
+		on manual or crash induced triggers. Lists should
+		be enabled sequentially.For example after configuring
+		addresses for list 1 and enabling it, a user can
+		proceed to enable list 2 or vice versa.
+		Example:
+		echo  0 > /sys/kernel/debug/dcc/.../[list-number]/enable
+		(disable dcc for the corresponding list number)
+		echo  1 > /sys/kernel/debug/dcc/.../[list-number]/enable
+		(enable dcc for the corresponding list number)
diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 024e420..d5730bf 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -69,6 +69,14 @@ config QCOM_LLCC
 	  SDM845. This provides interfaces to clients that use the LLCC.
 	  Say yes here to enable LLCC slice driver.

+config QCOM_DCC
+	tristate "Qualcomm Technologies, Inc. Data Capture and Compare(DCC) engine driver"
+	depends on ARCH_QCOM || COMPILE_TEST
+	help
+	  This option enables driver for Data Capture and Compare engine. DCC
+	  driver provides interface to configure DCC block and read back
+	  captured data from DCC's internal SRAM.
+
 config QCOM_KRYO_L2_ACCESSORS
 	bool
 	depends on ARCH_QCOM && ARM64 || COMPILE_TEST
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index d66604a..b1fe812 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_QCOM_AOSS_QMP) +=	qcom_aoss.o
 obj-$(CONFIG_QCOM_GENI_SE) +=	qcom-geni-se.o
 obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
 obj-$(CONFIG_QCOM_CPR)		+= cpr.o
+obj-$(CONFIG_QCOM_DCC) += dcc.o
 obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
 obj-$(CONFIG_QCOM_MDT_LOADER)	+= mdt_loader.o
 obj-$(CONFIG_QCOM_OCMEM)	+= ocmem.o
diff --git a/drivers/soc/qcom/dcc.c b/drivers/soc/qcom/dcc.c
new file mode 100644
index 0000000..efad225
--- /dev/null
+++ b/drivers/soc/qcom/dcc.c
@@ -0,0 +1,1355 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2015-2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/fs.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#define STATUS_READY_TIMEOUT		5000  /*microseconds*/
+
+#define DCC_SRAM_NODE "dcc_sram"
+
+/* DCC registers */
+#define DCC_HW_INFO			0x04
+#define DCC_LL_NUM_INFO			0x10
+#define DCC_STATUS(vers)		((vers) == 1 ? 0x0c : 0x1c)
+#define DCC_LL_LOCK			0x00
+#define DCC_LL_CFG			0x04
+#define DCC_LL_BASE			0x08
+#define DCC_FD_BASE			0x0c
+#define DCC_LL_TIMEOUT			0x10
+#define DCC_LL_INT_ENABLE		0x18
+#define DCC_LL_INT_STATUS		0x1c
+#define DCC_LL_SW_TRIGGER		0x2c
+#define DCC_LL_BUS_ACCESS_STATUS	0x30
+
+#define DCC_MAP_LEVEL1			0x18
+#define DCC_MAP_LEVEL2			0x34
+#define DCC_MAP_LEVEL3			0x4C
+
+#define DCC_MAP_OFFSET1			0x10
+#define DCC_MAP_OFFSET2			0x18
+#define DCC_MAP_OFFSET3			0x1C
+#define DCC_MAP_OFFSET4			0x8
+
+/*Default value used if a bit 6 in the HW_INFO register is set.*/
+#define DCC_FIX_LOOP_OFFSET		16
+
+/*Mask to find version info from HW_Info register*/
+#define DCC_VER_INFO_MASK		BIT(9)
+
+#define DCC_READ			0
+#define DCC_WRITE			1
+#define DCC_LOOP			2
+#define DCC_READ_WRITE			3
+
+#define MAX_DCC_OFFSET			GENMASK(9, 2)
+#define MAX_DCC_LEN			GENMASK(6, 0)
+#define MAX_LOOP_CNT			GENMASK(7, 0)
+#define MAX_LOOP_ADDR			10
+
+#define DCC_ADDR_DESCRIPTOR		0x00
+#define DCC_ADDR_LIMIT			27
+#define DCC_ADDR_OFF_RANGE		8
+#define DCC_ADDR_RANGE_MASK		GENMASK(31, 4)
+#define DCC_LOOP_DESCRIPTOR		BIT(30)
+#define DCC_RD_MOD_WR_DESCRIPTOR	BIT(31)
+#define DCC_LINK_DESCRIPTOR		GENMASK(31, 30)
+#define DCC_STATUS_MASK		GENMASK(1, 0)
+#define DCC_LOCK_MASK                  BIT(0)
+#define DCC_LOOP_OFFSET_MASK		BIT(6)
+#define DCC_TRIGGER_MASK		BIT(9)
+
+#define DCC_WRITE_MASK			BIT(15)
+#define DCC_WRITE_OFF_MASK		GENMASK(7, 0)
+#define DCC_WRITE_LEN_MASK		GENMASK(14, 8)
+
+#define DCC_READ_IND			0x00
+#define DCC_WRITE_IND			(BIT(28))
+
+#define DCC_AHB_IND			0x00
+#define DCC_APB_IND			BIT(29)
+
+#define DCC_MAX_LINK_LIST		8
+#define DCC_INVALID_LINK_LIST		GENMASK(7, 0)
+
+#define DCC_VER_MASK1			GENMASK(6, 0)
+#define DCC_VER_MASK2			GENMASK(5, 0)
+
+#define DCC_SRAM_WORD_LENGTH		4
+
+#define DCC_RD_MOD_WR_ADDR              0xC105E
+
+/*DCC debugfs directory*/
+static struct dentry	*dcc_dbg;
+
+enum dcc_descriptor_type {
+	DCC_READ_TYPE,
+	DCC_LOOP_TYPE,
+	DCC_READ_WRITE_TYPE,
+	DCC_WRITE_TYPE
+};
+
+struct dcc_config_entry {
+	u32				base;
+	u32				offset;
+	u32				len;
+	u32				loop_cnt;
+	u32				write_val;
+	u32				mask;
+	bool				apb_bus;
+	enum dcc_descriptor_type	desc_type;
+	struct list_head		list;
+};
+
+/**
+ * struct dcc_drvdata - configuration information related to a dcc device
+ * @base:		Base Address of the dcc device
+ * @dev:		The device attached to the driver data
+ * @mutex:		Lock to protect access and manipulation of dcc_drvdata
+ * @ram_base:		Base address for the SRAM dedicated for the dcc device
+ * @ram_size:		Total size of the SRAM dedicated for the dcc device
+ * @ram_offset:	Offset to the SRAM dedicated for dcc device
+ * @mem_map_ver:	Memory map version of DCC hardware
+ * @ram_cfg:		Used for address limit calculation for dcc
+ * @ram_start:		Starting address of DCC SRAM
+ * @sram_dev:		Miscellaneous device equivalent of dcc SRAM
+ * @cfg_head:		Points to the head of the linked list of addresses
+ * @dbg_dir:		The dcc debugfs directory under which all the debugfs files are placed
+ * @nr_link_list:	Total number of linkedlists supported by the DCC configuration
+ * @loopoff:		Loop offset bits range for the addresses
+ * @enable_bitmap:	Bitmap to capture the enabled status of each linked list of addresses
+ */
+struct dcc_drvdata {
+	void __iomem		*base;
+	void                    *ram_base;
+	struct device		*dev;
+	struct mutex		mutex;
+	size_t			ram_size;
+	size_t			ram_offset;
+	int			mem_map_ver;
+	phys_addr_t		ram_cfg;
+	phys_addr_t		ram_start;
+	struct miscdevice	sram_dev;
+	struct list_head	*cfg_head;
+	struct dentry		*dbg_dir;
+	size_t			nr_link_list;
+	u8			loopoff;
+	unsigned long		*enable_bitmap;
+};
+
+struct dcc_cfg_attr {
+	u32	addr;
+	u32	prev_addr;
+	u32	prev_off;
+	u32	link;
+	u32	sram_offset;
+};
+
+struct dcc_cfg_loop_attr {
+	u32	loop;
+	u32	loop_cnt;
+	u32	loop_len;
+	u32	loop_off;
+	bool    loop_start;
+};
+
+static size_t dcc_offset_conv(struct dcc_drvdata *drvdata, size_t off)
+{
+	/* If the memory map version is 1, adjust the offset based on
+	 * the dcc version mask. If the memory map version is 2
+	 * adjust the offset if the dcc version mask is greater than
+	 * map level 2.For other conditions, just return the offset.
+	 */
+	if (drvdata->mem_map_ver == 1) {
+		if (FIELD_GET(DCC_VER_MASK1, off) >= DCC_MAP_LEVEL3)
+			return off - DCC_MAP_OFFSET3;
+		if (FIELD_GET(DCC_VER_MASK1, off) >= DCC_MAP_LEVEL2)
+			return off - DCC_MAP_OFFSET2;
+		else if (FIELD_GET(DCC_VER_MASK1, off) >= DCC_MAP_LEVEL1)
+			return off - DCC_MAP_OFFSET1;
+	} else if (drvdata->mem_map_ver == 2) {
+		if (FIELD_GET(DCC_VER_MASK1, off) >= DCC_MAP_LEVEL2)
+			return off - DCC_MAP_OFFSET4;
+	}
+
+	return off;
+}
+
+static inline u32 dcc_ll_offset(int version)
+{
+	return version == 1 ? 0x1c : (version == 2 ? 0x2c : 0x34);
+}
+
+static inline u32 dcc_readl(struct dcc_drvdata *drvdata, u32 off)
+{
+	return readl(drvdata->base + dcc_offset_conv(drvdata, off));
+}
+
+static inline void dcc_ll_writel(struct dcc_drvdata *drvdata,
+				 u32 ll, u32 val, u32 off)
+{
+	u32 offset = dcc_ll_offset(drvdata->mem_map_ver) + off;
+
+	writel(val, drvdata->base + ll * 0x80 + offset);
+}
+
+static inline u32 dcc_ll_readl(struct dcc_drvdata *drvdata, u32 ll, u32 off)
+{
+	u32 offset = dcc_ll_offset(drvdata->mem_map_ver) + off;
+
+	return readl(drvdata->base + ll * 0x80 + offset);
+}
+
+static void dcc_sram_write_auto(struct dcc_drvdata *drvdata,
+				u32 val, u32 *off)
+{
+	memset(drvdata->ram_base + *off, val, DCC_SRAM_WORD_LENGTH);
+
+	*off += 4;
+}
+
+static int dcc_read_and_clear(struct dcc_drvdata *drvdata)
+{
+	int i;
+	u32 status;
+	u32 ll_cfg;
+	u32 tmp_ll_cfg;
+
+	for (i = 0; i < drvdata->nr_link_list; i++) {
+		if (!test_bit(i, drvdata->enable_bitmap))
+			continue;
+
+		status = dcc_ll_readl(drvdata, i, DCC_LL_BUS_ACCESS_STATUS);
+		if (!status)
+			continue;
+
+		dev_err(drvdata->dev, "Read access error for list %d err: 0x%x\n",
+			i, status);
+		ll_cfg = dcc_ll_readl(drvdata, i, DCC_LL_CFG);
+		tmp_ll_cfg = ll_cfg & ~DCC_TRIGGER_MASK;
+		dcc_ll_writel(drvdata, tmp_ll_cfg, i, DCC_LL_CFG);
+		dcc_ll_writel(drvdata, DCC_STATUS_MASK, i, DCC_LL_BUS_ACCESS_STATUS);
+		dcc_ll_writel(drvdata, ll_cfg, i, DCC_LL_CFG);
+		return -ENODATA;
+	}
+
+	return 0;
+}
+
+static int dcc_sw_trigger(struct dcc_drvdata *drvdata)
+{
+	void __iomem *addr;
+	int ret;
+	int i;
+	u32 ll_cfg;
+	u32 tmp_ll_cfg;
+	u32 val;
+
+	mutex_lock(&drvdata->mutex);
+
+	for (i = 0; i < drvdata->nr_link_list; i++) {
+		if (!test_bit(i, drvdata->enable_bitmap))
+			continue;
+		ll_cfg = dcc_ll_readl(drvdata, i, DCC_LL_CFG);
+		tmp_ll_cfg = ll_cfg & ~DCC_TRIGGER_MASK;
+		dcc_ll_writel(drvdata, tmp_ll_cfg, i, DCC_LL_CFG);
+		dcc_ll_writel(drvdata, 1, i, DCC_LL_SW_TRIGGER);
+		dcc_ll_writel(drvdata, ll_cfg, i, DCC_LL_CFG);
+	}
+
+	addr = drvdata->base + DCC_STATUS(drvdata->mem_map_ver);
+	if (readl_poll_timeout(addr, val, (FIELD_GET(DCC_STATUS_MASK, val) == 0),
+			       1, STATUS_READY_TIMEOUT)) {
+		dev_err(drvdata->dev, "DCC is busy after receiving sw trigger\n");
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	ret = dcc_read_and_clear(drvdata);
+
+out_unlock:
+	mutex_unlock(&drvdata->mutex);
+	return ret;
+}
+
+static void _dcc_ll_cfg_reset_link(struct dcc_cfg_attr *cfg)
+{
+	cfg->addr = 0x00;
+	cfg->link = 0;
+	cfg->prev_off = 0;
+	cfg->prev_addr = cfg->addr;
+}
+
+static void _dcc_emit_read_write(struct dcc_drvdata *drvdata,
+				 struct dcc_config_entry *entry,
+				 struct dcc_cfg_attr *cfg)
+{
+	if (cfg->link) {
+		/*
+		 * write new offset = 1 to continue
+		 * processing the list
+		 */
+
+		dcc_sram_write_auto(drvdata, cfg->link, &cfg->sram_offset);
+
+		/* Reset link and prev_off */
+		_dcc_ll_cfg_reset_link(cfg);
+	}
+
+	cfg->addr = DCC_RD_MOD_WR_DESCRIPTOR;
+	dcc_sram_write_auto(drvdata, cfg->addr, &cfg->sram_offset);
+
+	dcc_sram_write_auto(drvdata, entry->mask, &cfg->sram_offset);
+
+	dcc_sram_write_auto(drvdata, entry->write_val, &cfg->sram_offset);
+
+	cfg->addr = 0;
+}
+
+static void _dcc_emit_loop(struct dcc_drvdata *drvdata, struct dcc_config_entry *entry,
+			   struct dcc_cfg_attr *cfg,
+			   struct dcc_cfg_loop_attr *cfg_loop,
+			   u32 *total_len)
+{
+	/* Check if we need to write link of prev entry */
+	if (cfg->link)
+		dcc_sram_write_auto(drvdata, cfg->link, &cfg->sram_offset);
+
+	if (cfg_loop->loop_start) {
+		cfg_loop->loop = (cfg->sram_offset - cfg_loop->loop_off) / 4;
+		cfg_loop->loop |= (cfg_loop->loop_cnt << drvdata->loopoff) &
+				   GENMASK(DCC_ADDR_LIMIT, drvdata->loopoff);
+		cfg_loop->loop |= DCC_LOOP_DESCRIPTOR;
+		*total_len += (*total_len - cfg_loop->loop_len) * cfg_loop->loop_cnt;
+
+		dcc_sram_write_auto(drvdata, cfg_loop->loop, &cfg->sram_offset);
+
+		cfg_loop->loop_start = false;
+		cfg_loop->loop_len = 0;
+		cfg_loop->loop_off = 0;
+	} else {
+		cfg_loop->loop_start = true;
+		cfg_loop->loop_cnt = entry->loop_cnt - 1;
+		cfg_loop->loop_len = *total_len;
+		cfg_loop->loop_off = cfg->sram_offset;
+	}
+
+	/* Reset link and prev_off */
+	_dcc_ll_cfg_reset_link(cfg);
+}
+
+static void _dcc_emit_write(struct dcc_drvdata *drvdata,
+			    struct dcc_config_entry *entry,
+			    struct dcc_cfg_attr *cfg,
+			    u32 *total_len)
+{
+	u32 off;
+
+	if (cfg->link) {
+		/*
+		 * write new offset = 1 to continue
+		 * processing the list
+		 */
+		dcc_sram_write_auto(drvdata, cfg->link, &cfg->sram_offset);
+
+		/* Reset link and prev_off */
+		cfg->addr = 0x00;
+		cfg->prev_off = 0;
+		cfg->prev_addr = cfg->addr;
+	}
+
+	off = entry->offset / 4;
+	/* write new offset-length pair to correct position */
+	cfg->link |= ((off & DCC_WRITE_OFF_MASK) | DCC_WRITE_MASK |
+		      FIELD_PREP(DCC_WRITE_LEN_MASK, entry->len));
+	cfg->link |= DCC_LINK_DESCRIPTOR;
+
+	/* Address type */
+	cfg->addr = (entry->base >> 4) & GENMASK(DCC_ADDR_LIMIT, 0);
+	if (entry->apb_bus)
+		cfg->addr |= DCC_ADDR_DESCRIPTOR | DCC_WRITE_IND | DCC_APB_IND;
+	else
+		cfg->addr |= DCC_ADDR_DESCRIPTOR | DCC_WRITE_IND | DCC_AHB_IND;
+	dcc_sram_write_auto(drvdata, cfg->addr, &cfg->sram_offset);
+
+	dcc_sram_write_auto(drvdata, cfg->link, &cfg->sram_offset);
+
+	dcc_sram_write_auto(drvdata, entry->write_val, &cfg->sram_offset);
+
+	cfg->addr = 0x00;
+	cfg->link = 0;
+}
+
+static int _dcc_emit_read(struct dcc_drvdata *drvdata,
+			  struct dcc_config_entry *entry,
+			  struct dcc_cfg_attr *cfg,
+			  u32 *pos, u32 *total_len)
+{
+	u32 off;
+	u32 temp_off;
+
+	cfg->addr = (entry->base >> 4) & GENMASK(27, 0);
+
+	if (entry->apb_bus)
+		cfg->addr |= DCC_ADDR_DESCRIPTOR | DCC_READ_IND | DCC_APB_IND;
+	else
+		cfg->addr |= DCC_ADDR_DESCRIPTOR | DCC_READ_IND | DCC_AHB_IND;
+
+	off = entry->offset / 4;
+
+	*total_len += entry->len * 4;
+
+	if (!cfg->prev_addr || cfg->prev_addr != cfg->addr || cfg->prev_off > off) {
+		/* Check if we need to write prev link entry */
+		if (cfg->link)
+			dcc_sram_write_auto(drvdata, cfg->link, &cfg->sram_offset);
+		dev_dbg(drvdata->dev, "DCC: sram address 0x%x\n", cfg->sram_offset);
+
+		/* Write address */
+		dcc_sram_write_auto(drvdata, cfg->addr, &cfg->sram_offset);
+
+		/* Reset link and prev_off */
+		cfg->link = 0;
+		cfg->prev_off = 0;
+	}
+
+	if ((off - cfg->prev_off) > 0xFF || entry->len > MAX_DCC_LEN) {
+		dev_err(drvdata->dev, "DCC: Programming error Base: 0x%x, offset 0x%x\n",
+			entry->base, entry->offset);
+		return -EINVAL;
+	}
+
+	if (cfg->link) {
+		/*
+		 * link already has one offset-length so new
+		 * offset-length needs to be placed at
+		 * bits [29:15]
+		 */
+		*pos = 15;
+
+		/* Clear bits [31:16] */
+		cfg->link &= GENMASK(14, 0);
+	} else {
+		/*
+		 * link is empty, so new offset-length needs
+		 * to be placed at bits [15:0]
+		 */
+		*pos = 0;
+		cfg->link = 1 << 15;
+	}
+
+	/* write new offset-length pair to correct position */
+	temp_off = (off - cfg->prev_off) & GENMASK(7, 0);
+	cfg->link |= temp_off | ((entry->len << 8) & GENMASK(14, 8)) << *pos;
+
+	cfg->link |= DCC_LINK_DESCRIPTOR;
+
+	if (*pos) {
+		dcc_sram_write_auto(drvdata, cfg->link, &cfg->sram_offset);
+		cfg->link = 0;
+	}
+
+	cfg->prev_off  = off + entry->len - 1;
+	cfg->prev_addr = cfg->addr;
+	return 0;
+}
+
+static int __dcc_emit_config(struct dcc_drvdata *drvdata, int curr_list)
+{
+	int ret;
+	u32 total_len, pos;
+	struct dcc_config_entry *entry;
+	struct dcc_cfg_attr cfg;
+	struct dcc_cfg_loop_attr cfg_loop;
+
+	memset(&cfg, 0, sizeof(cfg));
+	memset(&cfg_loop, 0, sizeof(cfg_loop));
+	cfg.sram_offset = drvdata->ram_cfg * 4;
+	total_len = 0;
+
+	list_for_each_entry(entry, &drvdata->cfg_head[curr_list], list) {
+		switch (entry->desc_type) {
+		case DCC_READ_WRITE_TYPE:
+			_dcc_emit_read_write(drvdata, entry, &cfg);
+			break;
+
+		case DCC_LOOP_TYPE:
+			_dcc_emit_loop(drvdata, entry, &cfg, &cfg_loop, &total_len);
+			break;
+
+		case DCC_WRITE_TYPE:
+			_dcc_emit_write(drvdata, entry, &cfg, &total_len);
+			break;
+
+		case DCC_READ_TYPE:
+			ret = _dcc_emit_read(drvdata, entry, &cfg, &pos, &total_len);
+			if (ret)
+				goto overstep;
+			break;
+		}
+	}
+
+	if (cfg.link)
+		dcc_sram_write_auto(drvdata, cfg.link, &cfg.sram_offset);
+
+	if (cfg_loop.loop_start) {
+		dev_err(drvdata->dev, "DCC: Programming error: Loop unterminated\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	/* Handling special case of list ending with a rd_mod_wr */
+	if (cfg.addr == DCC_RD_MOD_WR_DESCRIPTOR) {
+		cfg.addr = (DCC_RD_MOD_WR_ADDR) & GENMASK(27, 0);
+		cfg.addr |= DCC_ADDR_DESCRIPTOR;
+		dcc_sram_write_auto(drvdata, cfg.addr, &cfg.sram_offset);
+	}
+
+	/* Setting zero to indicate end of the list */
+	cfg.link = DCC_LINK_DESCRIPTOR;
+	dcc_sram_write_auto(drvdata, cfg.link, &cfg.sram_offset);
+
+	/*Check if sram offset exceeds the ram size*/
+	if (cfg.sram_offset > drvdata->ram_size)
+		goto overstep;
+
+	/* Update ram_cfg and check if the data will overstep */
+	drvdata->ram_cfg = (cfg.sram_offset + total_len) / 4;
+
+	if (cfg.sram_offset + total_len > drvdata->ram_size) {
+		cfg.sram_offset += total_len;
+		goto overstep;
+	}
+
+	drvdata->ram_start = cfg.sram_offset / 4;
+	return 0;
+overstep:
+	ret = -EINVAL;
+	memset(drvdata->ram_base, 0, drvdata->ram_size);
+
+err:
+	return ret;
+}
+
+static int dcc_valid_list(struct dcc_drvdata *drvdata, int curr_list)
+{
+	u32 lock_reg;
+
+	if (list_empty(&drvdata->cfg_head[curr_list]))
+		return -EINVAL;
+
+	if (test_bit(curr_list, drvdata->enable_bitmap)) {
+		dev_err(drvdata->dev, "List %d is already enabled\n", curr_list);
+		return -EINVAL;
+	}
+
+	lock_reg = dcc_ll_readl(drvdata, curr_list, DCC_LL_LOCK);
+	if (lock_reg & DCC_LOCK_MASK) {
+		dev_err(drvdata->dev, "List %d is already locked\n", curr_list);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static bool is_dcc_enabled(struct dcc_drvdata *drvdata)
+{
+	int list;
+
+	for (list = 0; list < drvdata->nr_link_list; list++)
+		if (test_bit(list, drvdata->enable_bitmap))
+			return true;
+
+	return false;
+}
+
+static int dcc_enable(struct dcc_drvdata *drvdata, int curr_list)
+{
+	int ret;
+	u32 ram_cfg_base;
+
+	mutex_lock(&drvdata->mutex);
+
+	ret = dcc_valid_list(drvdata, curr_list);
+	if (ret)
+		goto out_unlock;
+
+	/* Fill dcc sram with the poison value.
+	 * This helps in understanding bus
+	 * hang from registers returning a zero
+	 */
+	if (!is_dcc_enabled(drvdata))
+		memset(drvdata->ram_base, 0xde, drvdata->ram_size);
+
+	/* 1. Take ownership of the list */
+	dcc_ll_writel(drvdata, DCC_LOCK_MASK, curr_list, DCC_LL_LOCK);
+
+	/* 2. Program linked-list in the SRAM */
+	ram_cfg_base = drvdata->ram_cfg;
+	ret = __dcc_emit_config(drvdata, curr_list);
+	if (ret) {
+		dcc_ll_writel(drvdata, 0, curr_list, DCC_LL_LOCK);
+		goto out_unlock;
+	}
+
+	/* 3. Program DCC_RAM_CFG reg */
+	dcc_ll_writel(drvdata, ram_cfg_base +
+			drvdata->ram_offset / 4, curr_list, DCC_LL_BASE);
+	dcc_ll_writel(drvdata, drvdata->ram_start +
+			drvdata->ram_offset / 4, curr_list, DCC_FD_BASE);
+	dcc_ll_writel(drvdata, 0xFFF, curr_list, DCC_LL_TIMEOUT);
+
+	/* 4. Clears interrupt status register */
+	dcc_ll_writel(drvdata, 0, curr_list, DCC_LL_INT_ENABLE);
+	dcc_ll_writel(drvdata, (BIT(0) | BIT(1) | BIT(2)),
+		      curr_list, DCC_LL_INT_STATUS);
+
+	set_bit(curr_list, drvdata->enable_bitmap);
+
+	/* 5. Configure trigger */
+	dcc_ll_writel(drvdata, DCC_TRIGGER_MASK,
+		      curr_list, DCC_LL_CFG);
+
+out_unlock:
+	mutex_unlock(&drvdata->mutex);
+	return ret;
+}
+
+static void dcc_disable(struct dcc_drvdata *drvdata, int curr_list)
+{
+	mutex_lock(&drvdata->mutex);
+
+	if (!test_bit(curr_list, drvdata->enable_bitmap))
+		goto out_unlock;
+	dcc_ll_writel(drvdata, 0, curr_list, DCC_LL_CFG);
+	dcc_ll_writel(drvdata, 0, curr_list, DCC_LL_BASE);
+	dcc_ll_writel(drvdata, 0, curr_list, DCC_FD_BASE);
+	dcc_ll_writel(drvdata, 0, curr_list, DCC_LL_LOCK);
+	clear_bit(curr_list, drvdata->enable_bitmap);
+out_unlock:
+	mutex_unlock(&drvdata->mutex);
+}
+
+static u32 dcc_filp_curr_list(const struct file *filp)
+{
+	struct dentry *dentry = file_dentry(filp);
+	int curr_list, ret;
+
+	ret = kstrtoint(dentry->d_parent->d_name.name, 0, &curr_list);
+	if (ret)
+		return ret;
+
+	return curr_list;
+}
+
+static ssize_t enable_read(struct file *filp, char __user *userbuf,
+			   size_t count, loff_t *ppos)
+{
+	char *buf;
+	struct dcc_drvdata *drvdata = filp->private_data;
+
+	mutex_lock(&drvdata->mutex);
+
+	if (is_dcc_enabled(drvdata))
+		buf = "Y\n";
+	else
+		buf = "N\n";
+
+	mutex_unlock(&drvdata->mutex);
+
+	return simple_read_from_buffer(userbuf, count, ppos, buf, strlen(buf) + 1);
+}
+
+static ssize_t enable_write(struct file *filp, const char __user *userbuf,
+			    size_t count, loff_t *ppos)
+{
+	int ret = 0, curr_list;
+	bool val;
+	struct dcc_drvdata *drvdata = filp->private_data;
+
+	curr_list = dcc_filp_curr_list(filp);
+	if (curr_list < 0)
+		return curr_list;
+
+	ret = kstrtobool_from_user(userbuf, count, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val) {
+		ret = dcc_enable(drvdata, curr_list);
+		if (ret)
+			return ret;
+	} else {
+		dcc_disable(drvdata, curr_list);
+	}
+
+	return count;
+}
+
+static const struct file_operations enable_fops = {
+	.read = enable_read,
+	.write = enable_write,
+	.open = simple_open,
+	.llseek = generic_file_llseek,
+};
+
+static ssize_t trigger_write(struct file *filp,
+			     const char __user *user_buf, size_t count,
+			     loff_t *ppos)
+{
+	int ret;
+	unsigned int val;
+	struct dcc_drvdata *drvdata = filp->private_data;
+
+	ret = kstrtouint_from_user(user_buf, count, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val != 1)
+		return -EINVAL;
+
+	ret = dcc_sw_trigger(drvdata);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static const struct file_operations trigger_fops = {
+	.write = trigger_write,
+	.open = simple_open,
+	.llseek = generic_file_llseek,
+};
+
+static int dcc_config_add(struct dcc_drvdata *drvdata, unsigned int addr,
+			  unsigned int len, int apb_bus, int curr_list)
+{
+	int ret = 0;
+	struct dcc_config_entry *entry, *pentry;
+	unsigned int base, offset;
+
+	mutex_lock(&drvdata->mutex);
+
+	if (!len || len > drvdata->ram_size / DCC_ADDR_OFF_RANGE) {
+		dev_err(drvdata->dev, "DCC: Invalid length\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	base = addr & DCC_ADDR_RANGE_MASK;
+
+	if (!list_empty(&drvdata->cfg_head[curr_list])) {
+		pentry = list_last_entry(&drvdata->cfg_head[curr_list],
+					 struct dcc_config_entry, list);
+
+		if (pentry->desc_type == DCC_READ_TYPE &&
+		    addr >= (pentry->base + pentry->offset) &&
+		    addr <= (pentry->base + pentry->offset + MAX_DCC_OFFSET)) {
+			/* Re-use base address from last entry */
+			base = pentry->base;
+
+			if ((pentry->len * 4 + pentry->base + pentry->offset)
+					== addr) {
+				len += pentry->len;
+
+				if (len > MAX_DCC_LEN)
+					pentry->len = MAX_DCC_LEN;
+				else
+					pentry->len = len;
+
+				addr = pentry->base + pentry->offset +
+					pentry->len * 4;
+				len -= pentry->len;
+			}
+		}
+	}
+
+	offset = addr - base;
+
+	while (len) {
+		entry = devm_kzalloc(drvdata->dev, sizeof(*entry), GFP_KERNEL);
+		if (!entry) {
+			ret = -ENOMEM;
+			goto out_unlock;
+		}
+
+		entry->base = base;
+		entry->offset = offset;
+		entry->len = min_t(u32, len, MAX_DCC_LEN);
+		entry->desc_type = DCC_READ_TYPE;
+		entry->apb_bus = apb_bus;
+		INIT_LIST_HEAD(&entry->list);
+		list_add_tail(&entry->list,
+			      &drvdata->cfg_head[curr_list]);
+
+		len -= entry->len;
+		offset += MAX_DCC_LEN * 4;
+	}
+
+out_unlock:
+	mutex_unlock(&drvdata->mutex);
+	return ret;
+}
+
+static ssize_t dcc_config_add_read(struct dcc_drvdata *drvdata, char *buf, int curr_list)
+{
+	int len, nval, bus;
+	unsigned int base;
+	char apb_bus[4];
+
+	nval = sscanf(buf, "%x %i %s", &base, &len, apb_bus);
+	if (nval <= 0 || nval > 3)
+		return -EINVAL;
+
+	if (nval == 1) {
+		len = 1;
+		bus = 0;
+	} else if (nval == 2) {
+		bus = 0;
+	} else if (!strcmp("apb", apb_bus)) {
+		bus = 1;
+	} else if (!strcmp("ahb", apb_bus)) {
+		bus = 0;
+	} else {
+		return -EINVAL;
+	}
+
+	return dcc_config_add(drvdata, base, len, bus, curr_list);
+}
+
+static void dcc_config_reset(struct dcc_drvdata *drvdata)
+{
+	struct dcc_config_entry *entry, *temp;
+	int curr_list;
+
+	mutex_lock(&drvdata->mutex);
+
+	for (curr_list = 0; curr_list < drvdata->nr_link_list; curr_list++) {
+		list_for_each_entry_safe(entry, temp,
+					 &drvdata->cfg_head[curr_list], list) {
+			list_del(&entry->list);
+		}
+	}
+	drvdata->ram_start = 0;
+	drvdata->ram_cfg = 0;
+	mutex_unlock(&drvdata->mutex);
+}
+
+static ssize_t config_reset_write(struct file *filp,
+				  const char __user *user_buf, size_t count,
+				  loff_t *ppos)
+{
+	unsigned int val, ret;
+	struct dcc_drvdata *drvdata = filp->private_data;
+
+	ret = kstrtouint_from_user(user_buf, count, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val)
+		dcc_config_reset(drvdata);
+
+	return count;
+}
+
+static const struct file_operations config_reset_fops = {
+	.write = config_reset_write,
+	.open = simple_open,
+	.llseek = generic_file_llseek,
+};
+
+static ssize_t ready_read(struct file *filp, char __user *userbuf,
+			  size_t count, loff_t *ppos)
+{
+	int ret = 0;
+	char *buf;
+	struct dcc_drvdata *drvdata = filp->private_data;
+
+	mutex_lock(&drvdata->mutex);
+
+	if (!is_dcc_enabled(drvdata)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	if (!FIELD_GET(BIT(1), readl(drvdata->base + DCC_STATUS(drvdata->mem_map_ver))))
+		buf = "Y\n";
+	else
+		buf = "N\n";
+out_unlock:
+	mutex_unlock(&drvdata->mutex);
+
+	if (ret < 0)
+		return -EINVAL;
+	else
+		return simple_read_from_buffer(userbuf, count, ppos, buf, strlen(buf) + 1);
+}
+
+static const struct file_operations ready_fops = {
+	.read = ready_read,
+	.open = simple_open,
+	.llseek = generic_file_llseek,
+};
+
+static int dcc_add_loop(struct dcc_drvdata *drvdata, unsigned long loop_cnt, int curr_list)
+{
+	struct dcc_config_entry *entry;
+
+	entry = devm_kzalloc(drvdata->dev, sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->loop_cnt = min_t(u32, loop_cnt, MAX_LOOP_CNT);
+	entry->desc_type = DCC_LOOP_TYPE;
+	INIT_LIST_HEAD(&entry->list);
+	list_add_tail(&entry->list, &drvdata->cfg_head[curr_list]);
+
+	return 0;
+}
+
+static ssize_t dcc_config_add_loop(struct dcc_drvdata *drvdata, char *buf, int curr_list)
+{
+	int ret, cnt = 2, i = 0;
+	char *token, *input;
+	char delim[2] = " ";
+	unsigned int val[MAX_LOOP_ADDR];
+
+	input = buf;
+
+	token = strsep(&input, delim);
+	while (token) {
+		ret = kstrtoint(token, 0, &val[i++]);
+		if (ret)
+			return ret;
+
+		token = strsep(&input, delim);
+	}
+
+	ret = dcc_add_loop(drvdata, val[0], curr_list);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < val[1]; i++)
+		dcc_config_add(drvdata, val[cnt++], 1, 0, curr_list);
+
+	return dcc_add_loop(drvdata, 1, curr_list);
+}
+
+static int dcc_rd_mod_wr_add(struct dcc_drvdata *drvdata, unsigned int mask,
+			     unsigned int val, int curr_list)
+{
+	int ret = 0;
+	struct dcc_config_entry *entry;
+
+	mutex_lock(&drvdata->mutex);
+
+	if (list_empty(&drvdata->cfg_head[curr_list])) {
+		dev_err(drvdata->dev, "DCC: No read address programmed\n");
+		ret = -EPERM;
+		goto out_unlock;
+	}
+
+	entry = devm_kzalloc(drvdata->dev, sizeof(*entry), GFP_KERNEL);
+	if (!entry) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+
+	entry->desc_type = DCC_READ_WRITE_TYPE;
+	entry->mask = mask;
+	entry->write_val = val;
+	INIT_LIST_HEAD(&entry->list);
+	list_add_tail(&entry->list, &drvdata->cfg_head[curr_list]);
+out_unlock:
+	mutex_unlock(&drvdata->mutex);
+	return ret;
+}
+
+static ssize_t dcc_config_add_read_write(struct dcc_drvdata *drvdata, char *buf, int curr_list)
+{
+	int ret;
+	int nval;
+	unsigned int addr, mask, val;
+
+	nval = sscanf(buf, "%x %x %x", &addr, &mask, &val);
+
+	if (nval <= 1 || nval > 3)
+		return -EINVAL;
+
+	ret = dcc_config_add(drvdata, addr, 1, 0, curr_list);
+	if (ret)
+		return ret;
+
+	return dcc_rd_mod_wr_add(drvdata, mask, val, curr_list);
+}
+
+static int dcc_add_write(struct dcc_drvdata *drvdata, unsigned int addr,
+			 unsigned int write_val, int apb_bus, int curr_list)
+{
+	struct dcc_config_entry *entry;
+
+	entry = devm_kzalloc(drvdata->dev, sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->desc_type = DCC_WRITE_TYPE;
+	entry->base = addr & GENMASK(31, 4);
+	entry->offset = addr - entry->base;
+	entry->write_val = write_val;
+	entry->len = 1;
+	entry->apb_bus = apb_bus;
+	INIT_LIST_HEAD(&entry->list);
+	list_add_tail(&entry->list, &drvdata->cfg_head[curr_list]);
+
+	return 0;
+}
+
+static ssize_t dcc_config_add_write(struct dcc_drvdata *drvdata, char *buf, int curr_list)
+{
+	int bus;
+	int nval;
+	unsigned int addr, write_val;
+	char apb_bus[4];
+
+	nval = sscanf(buf, "%x %x %s", &addr, &write_val, apb_bus);
+
+	if (nval <= 1 || nval > 3)
+		return -EINVAL;
+
+	if (nval == 3) {
+		if (!strcmp("apb", apb_bus))
+			bus = 1;
+		else if (!strcmp("apb", apb_bus))
+			bus = 0;
+		else
+			return -EINVAL;
+	}
+
+	return dcc_add_write(drvdata, addr, write_val, bus, curr_list);
+}
+
+static int config_show(struct seq_file *m, void *data)
+{
+	struct dcc_drvdata *drvdata = m->private;
+	struct dcc_config_entry *entry;
+	int index = 0, curr_list;
+
+	curr_list = dcc_filp_curr_list(m->file);
+	if (curr_list < 0)
+		return curr_list;
+
+	mutex_lock(&drvdata->mutex);
+
+	list_for_each_entry(entry,
+			    &drvdata->cfg_head[curr_list], list) {
+		index++;
+		switch (entry->desc_type) {
+		case DCC_READ_WRITE_TYPE:
+			seq_printf(m, "RW mask: 0x%x, val: 0x%x\n index: 0x%x\n",
+				   entry->mask, entry->write_val, index);
+			break;
+		case DCC_LOOP_TYPE:
+			seq_printf(m, "L index: 0x%x Loop: %d\n", index, entry->loop_cnt);
+			break;
+		case DCC_WRITE_TYPE:
+			seq_printf(m, "W Base:0x%x, Offset: 0x%x, val: 0x%x, APB: %d\n, Index: 0x%x\n",
+				   entry->base, entry->offset, entry->write_val, entry->apb_bus,
+				   index);
+			break;
+		case DCC_READ_TYPE:
+			seq_printf(m, "R Base:0x%x, Offset: 0x%x, len: 0x%x, APB: %d\n, Index: 0x%x\n",
+				   entry->base, entry->offset, entry->len, entry->apb_bus, index);
+		}
+	}
+	mutex_unlock(&drvdata->mutex);
+	return 0;
+}
+
+static int config_open(struct inode *inode, struct file *file)
+{
+	struct dcc_drvdata *drvdata = inode->i_private;
+
+	return single_open(file, config_show, drvdata);
+}
+
+static ssize_t config_write(struct file *filp,
+			    const char __user *user_buf, size_t count,
+			    loff_t *ppos)
+{
+	int ret, curr_list;
+	char *token, buf[50];
+	char *delim = " ";
+	struct dcc_drvdata *drvdata = filp->private_data;
+
+	ret = copy_from_user(buf, user_buf, count);
+	if (ret)
+		return -EFAULT;
+	if (count > sizeof(buf) || count == 0)
+		return -EINVAL;
+
+	curr_list = dcc_filp_curr_list(filp);
+	if (curr_list < 0)
+		return curr_list;
+
+	if (buf[count - 1] == '\n')
+		buf[count - 1] = '\0';
+	else
+		return -EINVAL;
+
+	token = strsep((char **)&buf, delim);
+
+	if (!strcmp("R", token)) {
+		ret = dcc_config_add_read(drvdata, buf, curr_list);
+	} else if (!strcmp("W", token)) {
+		ret = dcc_config_add_write(drvdata, buf, curr_list);
+	} else if (!strcmp("RW", token)) {
+		ret = dcc_config_add_read_write(drvdata, buf, curr_list);
+	} else if (!strcmp("L", token)) {
+		ret = dcc_config_add_loop(drvdata, buf, curr_list);
+	} else {
+		dev_err(drvdata->dev, "%s is not a correct input\n", token);
+		return -EINVAL;
+	}
+
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static const struct file_operations config_fops = {
+	.open = config_open,
+	.read = seq_read,
+	.write = config_write,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static void dcc_delete_debug_dir(struct dcc_drvdata *dcc)
+{
+	 debugfs_remove_recursive(dcc->dbg_dir);
+};
+
+static int dcc_create_debug_dir(struct dcc_drvdata *dcc)
+{
+	int i;
+	char list_num[10];
+	struct dentry *list;
+	struct device *dev = dcc->dev;
+
+	dcc_dbg = debugfs_create_dir(KBUILD_MODNAME, NULL);
+	if (!dcc_dbg) {
+		pr_err("can't create debugfs dir\n");
+		return -1;
+	}
+
+	dcc->dbg_dir = debugfs_create_dir(dev_name(dev), dcc_dbg);
+	if (!dcc->dbg_dir)
+		return -1;
+	for (i = 0; i <= dcc->nr_link_list; i++) {
+		sprintf(list_num, "%d", i);
+		list = debugfs_create_dir(list_num, dcc->dbg_dir);
+		debugfs_create_file("enable", 0600, list, dcc, &enable_fops);
+		debugfs_create_file("config", 0600, list, dcc, &config_fops);
+	}
+
+	debugfs_create_file("trigger", 0200, dcc->dbg_dir, dcc, &trigger_fops);
+	debugfs_create_file("ready", 0400, dcc->dbg_dir, dcc, &ready_fops);
+	debugfs_create_file("config_reset", 0200, dcc->dbg_dir,
+			    dcc, &config_reset_fops);
+
+	return 0;
+}
+
+static ssize_t dcc_sram_read(struct file *file, char __user *data,
+			     size_t len, loff_t *ppos)
+{
+	unsigned char *buf;
+	struct dcc_drvdata *drvdata = container_of(file->private_data,
+		struct dcc_drvdata,
+		sram_dev);
+
+	/* EOF check */
+	if (*ppos >= drvdata->ram_size)
+		return 0;
+
+	if ((*ppos + len) > drvdata->ram_size)
+		len = (drvdata->ram_size - *ppos);
+
+	buf = kzalloc(len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	memcpy(buf, drvdata->ram_base + *ppos, len);
+
+	if (copy_to_user(data, buf, len)) {
+		kfree(buf);
+		return -EFAULT;
+	}
+
+	*ppos += len;
+
+	kfree(buf);
+
+	return len;
+}
+
+static const struct file_operations dcc_sram_fops = {
+	.owner		= THIS_MODULE,
+	.read		= dcc_sram_read,
+	.llseek		= no_llseek,
+};
+
+static int dcc_sram_dev_init(struct dcc_drvdata *drvdata)
+{
+	drvdata->sram_dev.minor = MISC_DYNAMIC_MINOR;
+	drvdata->sram_dev.name = DCC_SRAM_NODE;
+	drvdata->sram_dev.fops = &dcc_sram_fops;
+
+	return misc_register(&drvdata->sram_dev);
+}
+
+static void dcc_sram_dev_exit(struct dcc_drvdata *drvdata)
+{
+	misc_deregister(&drvdata->sram_dev);
+}
+
+static int dcc_probe(struct platform_device *pdev)
+{
+	u32 val;
+	int ret = 0, i;
+	struct device *dev = &pdev->dev;
+	struct dcc_drvdata *dcc;
+	struct resource *res;
+
+	dcc = devm_kzalloc(dev, sizeof(*dcc), GFP_KERNEL);
+	if (!dcc)
+		return -ENOMEM;
+
+	dcc->dev = &pdev->dev;
+	platform_set_drvdata(pdev, dcc);
+
+	dcc->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(dcc->base))
+		return PTR_ERR(dcc->base);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res)
+		return -ENODEV;
+
+	dcc->ram_base = memremap(res->start, resource_size(res), MEMREMAP_WB);
+	if (!dcc->ram_base)
+		return -ENODEV;
+
+	dcc->ram_size = resource_size(res);
+
+	dcc->ram_offset = (size_t)of_device_get_match_data(&pdev->dev);
+
+	val = dcc_readl(dcc, DCC_HW_INFO);
+
+	if (FIELD_GET(DCC_VER_INFO_MASK, val)) {
+		dcc->mem_map_ver = 3;
+		dcc->nr_link_list = dcc_readl(dcc, DCC_LL_NUM_INFO);
+		if (dcc->nr_link_list == 0)
+			return	-EINVAL;
+	} else if ((val & DCC_VER_MASK2) == DCC_VER_MASK2) {
+		dcc->mem_map_ver = 2;
+		dcc->nr_link_list = dcc_readl(dcc, DCC_LL_NUM_INFO);
+		if (dcc->nr_link_list == 0)
+			return	-EINVAL;
+	} else {
+		dcc->mem_map_ver = 1;
+		dcc->nr_link_list = DCC_MAX_LINK_LIST;
+	}
+
+	/* Either set the fixed loop offset or calculate it
+	 * from ram_size. Max consecutive addresses the
+	 * dcc can loop is equivalent to the ram size
+	 */
+	if (val & DCC_LOOP_OFFSET_MASK)
+		dcc->loopoff = DCC_FIX_LOOP_OFFSET;
+	else
+		dcc->loopoff = get_bitmask_order((dcc->ram_size +
+				dcc->ram_offset) / 4 - 1);
+
+	mutex_init(&dcc->mutex);
+
+	dcc->enable_bitmap = devm_kcalloc(dev, BITS_TO_LONGS(dcc->nr_link_list),
+					  sizeof(*dcc->enable_bitmap), GFP_KERNEL);
+	if (!dcc->enable_bitmap)
+		return -ENOMEM;
+
+	dcc->cfg_head = devm_kcalloc(dev, dcc->nr_link_list,
+				     sizeof(*dcc->cfg_head), GFP_KERNEL);
+	if (!dcc->cfg_head)
+		return -ENOMEM;
+
+	for (i = 0; i < dcc->nr_link_list; i++)
+		INIT_LIST_HEAD(&dcc->cfg_head[i]);
+
+	ret = dcc_sram_dev_init(dcc);
+	if (ret) {
+		dev_err(dcc->dev, "DCC: sram node not registered.\n");
+		return ret;
+	}
+
+	ret = dcc_create_debug_dir(dcc);
+	if (ret) {
+		dev_err(dcc->dev, "DCC: debugfs files not created.\n");
+		dcc_sram_dev_exit(dcc);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int dcc_remove(struct platform_device *pdev)
+{
+	struct dcc_drvdata *drvdata = platform_get_drvdata(pdev);
+
+	dcc_delete_debug_dir(drvdata);
+	dcc_sram_dev_exit(drvdata);
+	dcc_config_reset(drvdata);
+	memunmap(drvdata->ram_base);
+
+	return 0;
+}
+
+static const struct of_device_id dcc_match_table[] = {
+	{ .compatible = "qcom,sm8150-dcc", .data = (void *)0x5000 },
+	{ .compatible = "qcom,sc7280-dcc", .data = (void *)0x12000 },
+	{ .compatible = "qcom,sc7180-dcc", .data = (void *)0x6000 },
+	{ .compatible = "qcom,sdm845-dcc", .data = (void *)0x6000 },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, dcc_match_table);
+
+static struct platform_driver dcc_driver = {
+	.probe = dcc_probe,
+	.remove	= dcc_remove,
+	.driver	= {
+		.name = "qcom-dcc",
+		.of_match_table	= dcc_match_table,
+	},
+};
+
+module_platform_driver(dcc_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Qualcomm Technologies Inc. DCC driver");
+
--
2.7.4

