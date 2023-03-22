Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1916C4BC8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjCVNbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjCVNbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:31:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDF55CC1D;
        Wed, 22 Mar 2023 06:31:20 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32M9rcGZ010136;
        Wed, 22 Mar 2023 13:31:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=udldFP7zD78HssHyV5rEQZFosSOO7y05k9prC9OjQEg=;
 b=bzVlVxGDTBl5K2Cqe0EVHbaLP2zehWYMyuY/QO3MWA9MVbhRcQoagHdfMDMDK1+vII+l
 WiC4yfb6FKi/b1vv9KwgIZmF+SRisEdpbnPkM6NWymOOt/x5jSW4ys/Nu3FjeNCzLneN
 4uHzEyDjTL4JSExymEWJ/8U/Fngn/yZ7dQSUZq3yBzTRmBUoSvI2IRjNR52u+6C9OlzF
 fK3q/yCNOA2onJ+lPgj3jPFKC1suqEKJX8Gyobly+6WcpyOp17hQ70Oole+LDZeDJ6X4
 XvvkmzPWFsfnUDy5+RbcuzYfLyufFIT00fvg/F48ehJWKmyTDVUk+qVU3ucwKqtUB4Oj iQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pfdm4k2nk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 13:31:00 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32MDUxKu022259
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 13:30:59 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 22 Mar 2023 06:30:54 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <corbet@lwn.net>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, "Mukesh Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH v2 4/6] soc: qcom: Add Qualcomm minidump kernel driver
Date:   Wed, 22 Mar 2023 19:00:15 +0530
Message-ID: <1679491817-2498-5-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1679491817-2498-1-git-send-email-quic_mojha@quicinc.com>
References: <1679491817-2498-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AcjsXLGN80nypteDecqpoPGxqsCKuBrN
X-Proofpoint-GUID: AcjsXLGN80nypteDecqpoPGxqsCKuBrN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_11,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303220098
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minidump is a best effort mechanism to collect useful and predefined
data for first level of debugging on end user devices running on
Qualcomm SoCs. It is built on the premise that System on Chip (SoC)
or subsystem part of SoC crashes, due to a range of hardware and
software bugs. Hence, the ability to collect accurate data is only
a best-effort. The data collected could be invalid or corrupted,
data collection itself could fail, and so on.

Qualcomm devices in engineering mode provides a mechanism for
generating full system ramdumps for post mortem debugging. But in some
cases it's however not feasible to capture the entire content of RAM.
The minidump mechanism provides the means for selecting region should
be included in the ramdump. The solution supports extracting the
ramdump/minidump produced either over USB or stored to an attached
storage device.

The core of minidump feature is part of Qualcomm's boot firmware code.
It initializes shared memory(SMEM), which is a part of DDR and
allocates a small section of it to minidump table i.e also called
global table of content (G-ToC). Each subsystem (APSS, ADSP, ...) has
their own table of segments to be included in the minidump, all
references from a descriptor in SMEM (G-ToC). Each segment/region has
some details like name, physical address and it's size etc. and it
could be anywhere scattered in the DDR.

Minidump kernel driver adds the capability to add linux region to be
dumped as part of ram dump collection. It provides appropriate symbol
to check its enablement and register client regions.

To simplify post mortem debugging, it creates and maintain an ELF
header as first region that gets updated upon registration
of a new region.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/soc/qcom/Kconfig         |  14 +
 drivers/soc/qcom/Makefile        |   1 +
 drivers/soc/qcom/qcom_minidump.c | 537 +++++++++++++++++++++++++++++++++++++++
 include/soc/qcom/minidump.h      |  40 +++
 include/soc/qcom/qcom_minidump.h |  24 +-
 5 files changed, 615 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/qcom/qcom_minidump.c
 create mode 100644 include/soc/qcom/minidump.h

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index a8f2830..bb0bc32 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -275,4 +275,18 @@ config QCOM_ICC_BWMON
 	  the fixed bandwidth votes from cpufreq (CPU nodes) thus achieve high
 	  memory throughput even with lower CPU frequencies.
 
+config QCOM_MINIDUMP
+	tristate "QCOM Minidump Support"
+	depends on ARCH_QCOM || COMPILE_TEST
+	select QCOM_SMEM
+	help
+	  Enablement of core minidump feature is controlled from boot firmware
+	  side, and this config allow linux to query and manages APPS minidump
+	  table.
+
+	  Client drivers can register their internal data structures and debug
+	  messages as part of the minidump region and when the SoC is crashed,
+	  these selective regions will be dumped instead of the entire DDR.
+	  This saves significant amount of time and/or storage space.
+
 endmenu
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 6e88da8..dc7f0ab 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -32,3 +32,4 @@ obj-$(CONFIG_QCOM_RPMHPD) += rpmhpd.o
 obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
 obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
 obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
+obj-$(CONFIG_QCOM_MINIDUMP) += qcom_minidump.o
diff --git a/drivers/soc/qcom/qcom_minidump.c b/drivers/soc/qcom/qcom_minidump.c
new file mode 100644
index 0000000..44770ed
--- /dev/null
+++ b/drivers/soc/qcom/qcom_minidump.c
@@ -0,0 +1,537 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#define pr_fmt(fmt) "Minidump: " fmt
+
+#include <linux/init.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/elf.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/printk.h>
+#include <linux/soc/qcom/smem.h>
+#include <soc/qcom/qcom_minidump.h>
+#include <soc/qcom/minidump.h>
+
+/**
+ * DOC: Overview
+ *
+ *   +-----------------------------------------------+
+ *   |   DDR                       +-------------+   |
+ *   |                             |      SS0-ToC|   |
+ *   | +----------------+     +----------------+ |   |
+ *   | |Shared memory   |     |         SS1-ToC| |   |
+ *   | |(SMEM)          |     |                | |   |
+ *   | |                | +-->|--------+       | |   |
+ *   | |G-ToC           | |   | SS-ToC  \      | |   |
+ *   | |+-------------+ | |   | +-----------+  | |   |
+ *   | ||-------------| | |   | |-----------|  | |   |
+ *   | || SS0-ToC     | | | +-|<|SS1 region1|  | |   |
+ *   | ||-------------| | | | | |-----------|  | |   |
+ *   | || SS1-ToC     |-|>+ | | |SS1 region2|  | |   |
+ *   | ||-------------| |   | | |-----------|  | |   |
+ *   | || SS2-ToC     | |   | | |  ...      |  | |   |
+ *   | ||-------------| |   | | |-----------|  | |   |
+ *   | ||  ...        | |   |-|<|SS1 regionN|  | |   |
+ *   | ||-------------| |   | | |-----------|  | |   |
+ *   | || SSn-ToC     | |   | | +-----------+  | |   |
+ *   | |+-------------+ |   | |                | |   |
+ *   | |                |   | |----------------| |   |
+ *   | |                |   +>|  regionN       | |   |
+ *   | |                |   | |----------------| |   |
+ *   | +----------------+   | |                | |   |
+ *   |                      | |----------------| |   |
+ *   |                      +>|  region1       | |   |
+ *   |                        |----------------| |   |
+ *   |                        |                | |   |
+ *   |                        |----------------|-+   |
+ *   |                        |  region5       |     |
+ *   |                        |----------------|     |
+ *   |                        |                |     |
+ *   |  Region information    +----------------+     |
+ *   | +---------------+                             |
+ *   | |region name    |                             |
+ *   | |---------------|                             |
+ *   | |region address |                             |
+ *   | |---------------|                             |
+ *   | |region size    |                             |
+ *   | +---------------+                             |
+ *   +-----------------------------------------------+
+ *       G-ToC: Global table of content
+ *       SS-ToC: Subsystem table of content
+ *       SS0-SSn: Subsystem numbered from 0 to n
+ *
+ * The core of minidump feature is part of Qualcomm's boot firmware code.
+ * It initializes shared memory(SMEM), which is a part of DDR and
+ * allocates a small section of it to minidump table i.e also called
+ * global table of content (G-ToC).
+ *
+ * Each subsystem (APSS, ADSP, ...) has their own table of segments to be
+ * included in the minidump, all references from a descriptor in SMEM
+ * (G-ToC). Each segment/region has some details like name, physical
+ * address and it's size etc. and it could be anywhere scattered
+ * in the DDR.
+ *
+ * Qualcomm SoCs supports extracting the ramdump/minidump produced
+ * either over USB or stored to an attached storage device.
+ */
+
+/**
+ * struct minidump_elfhdr - Minidump table elf header
+ * @ehdr: Elf main header
+ * @shdr: Section header
+ * @phdr: Program header
+ * @elf_offset: Section offset in elf
+ * @strtable_idx: String table current index position
+ */
+struct minidump_elfhdr {
+	struct elfhdr		*ehdr;
+	struct elf_shdr		*shdr;
+	struct elf_phdr		*phdr;
+	size_t			elf_offset;
+	size_t			strtable_idx;
+};
+
+/**
+ * struct minidump - Minidump driver private data
+ * @md_gbl_toc	: Global TOC pointer
+ * @md_ss_toc	: High level OS TOC pointer
+ * @md_regions	: High level OS region base pointer
+ * @elf		: Minidump elf header
+ * @init_done	: Minidump is initialized or not
+ * @ready	: If minidump is ready for the clients.
+ */
+struct minidump {
+	struct minidump_global_toc	*md_gbl_toc;
+	struct minidump_subsystem	*md_ss_toc;
+	struct minidump_region		*md_regions;
+	struct minidump_elfhdr		elf;
+	bool				init_done;
+	bool				ready;
+};
+
+/*
+ * In some of the Old Qualcomm devices, boot firmware statically allocates 300
+ * as total number of supported region (including all co-processors) in
+ * minidump table out of which linux was using 200. In future, this limitation
+ * from boot firmware might get removed by allocating the region dynamically.
+ * So, keep it compatible with older devices, we can the current limit for Linux
+ * to 200.
+ */
+#define MAX_NUM_ENTRIES	  200
+#define MAX_STRTBL_SIZE	  (MAX_NUM_ENTRIES * MAX_REGION_NAME_LENGTH)
+
+static struct minidump minidump;
+static DEFINE_MUTEX(minidump_lock);
+
+static struct elf_shdr *elf_shdr_entry_addr(struct elfhdr *ehdr, int idx)
+{
+	struct elf_shdr *eshdr = (struct elf_shdr *)((size_t)ehdr + ehdr->e_shoff);
+
+	return &eshdr[idx];
+}
+
+static struct elf_phdr *elf_phdr_entry_addr(struct elfhdr *ehdr, int idx)
+{
+	struct elf_phdr *ephdr = (struct elf_phdr *)((size_t)ehdr + ehdr->e_phoff);
+
+	return &ephdr[idx];
+}
+
+static char *elf_str_table_start(struct elfhdr *ehdr)
+{
+	struct elf_shdr *eshdr;
+
+	if (ehdr->e_shstrndx == SHN_UNDEF)
+		return NULL;
+
+	eshdr = elf_shdr_entry_addr(ehdr, ehdr->e_shstrndx);
+	return (char *)ehdr + eshdr->sh_offset;
+}
+
+static unsigned int append_str_to_strtable(const char *name)
+{
+	char *strtab = elf_str_table_start(minidump.elf.ehdr);
+	unsigned int old_idx = minidump.elf.strtable_idx;
+	unsigned int ret;
+
+	if (!strtab || !name)
+		return 0;
+
+	ret = old_idx;
+	old_idx += strscpy((strtab + old_idx), name, MAX_REGION_NAME_LENGTH);
+	minidump.elf.strtable_idx = old_idx + 1;
+	return ret;
+}
+
+static int get_minidump_region_index(const struct qcom_minidump_region *region)
+{
+	struct minidump_region *mdr;
+	unsigned int i;
+	unsigned int count;
+
+	count = le32_to_cpu(minidump.md_ss_toc->region_count);
+	for (i = 0; i < count; i++) {
+		mdr = &minidump.md_regions[i];
+		if (!strcmp(mdr->name, region->name))
+			return i;
+	}
+	return -ENOENT;
+}
+
+/* Update ELF header */
+static void minidump_update_elf_header(const struct qcom_minidump_region *region)
+{
+	struct elfhdr *ehdr = minidump.elf.ehdr;
+	struct elf_shdr *shdr;
+	struct elf_phdr *phdr;
+
+	shdr = elf_shdr_entry_addr(ehdr, ehdr->e_shnum++);
+	phdr = elf_phdr_entry_addr(ehdr, ehdr->e_phnum++);
+
+	shdr->sh_type = SHT_PROGBITS;
+	shdr->sh_name = append_str_to_strtable(region->name);
+	shdr->sh_addr = (elf_addr_t)region->virt_addr;
+	shdr->sh_size = region->size;
+	shdr->sh_flags = SHF_WRITE;
+	shdr->sh_offset = minidump.elf.elf_offset;
+	shdr->sh_entsize = 0;
+
+	phdr->p_type = PT_LOAD;
+	phdr->p_offset = minidump.elf.elf_offset;
+	phdr->p_vaddr = (elf_addr_t)region->virt_addr;
+	phdr->p_paddr = region->phys_addr;
+	phdr->p_filesz = phdr->p_memsz = region->size;
+	phdr->p_flags = PF_R | PF_W;
+	minidump.elf.elf_offset += shdr->sh_size;
+}
+
+/* Add region in subsystem ToC */
+static void minidump_ss_add_region(const struct qcom_minidump_region *region)
+{
+	struct minidump_region *mdr;
+	unsigned int region_cnt = le32_to_cpu(minidump.md_ss_toc->region_count);
+
+	mdr = &minidump.md_regions[region_cnt];
+	strscpy(mdr->name, region->name, sizeof(mdr->name));
+	mdr->address = cpu_to_le64(region->phys_addr);
+	mdr->size = cpu_to_le64(region->size);
+	mdr->valid = cpu_to_le32(MINIDUMP_REGION_VALID);
+	region_cnt++;
+	minidump.md_ss_toc->region_count = cpu_to_le32(region_cnt);
+}
+
+static bool qcom_minidump_valid_region(const struct qcom_minidump_region *region)
+{
+	return region &&
+		strnlen(region->name, MAX_NAME_LENGTH) < MAX_NAME_LENGTH &&
+		region->virt_addr &&
+		region->size &&
+		IS_ALIGNED(region->size, 4);
+}
+
+static int minidump_add_elf_header(void)
+{
+	struct qcom_minidump_region elfregion;
+	struct elfhdr *ehdr;
+	struct elf_shdr *shdr;
+	struct elf_phdr *phdr;
+	unsigned int  elfh_size;
+	unsigned int strtbl_off;
+	unsigned int phdr_off;
+	char *banner;
+	unsigned int banner_len;
+
+	banner_len = strlen(linux_banner);
+	/*
+	 * Header buffer contains:
+	 * ELF header, (MAX_NUM_ENTRIES + 4) of Section and Program ELF headers,
+	 * where, 4 additional entries, one for empty header, one for string table
+	 * one for minidump table and one for linux banner.
+	 *
+	 * Linux banner is stored in minidump to aid post mortem tools to determine
+	 * the kernel version.
+	 */
+	elfh_size = sizeof(*ehdr);
+	elfh_size += MAX_STRTBL_SIZE;
+	elfh_size += banner_len + 1;
+	elfh_size += ((sizeof(*shdr) + sizeof(*phdr)) * (MAX_NUM_ENTRIES + 4));
+	elfh_size = ALIGN(elfh_size, 4);
+
+	minidump.elf.ehdr = kzalloc(elfh_size, GFP_KERNEL);
+	if (!minidump.elf.ehdr)
+		return -ENOMEM;
+
+	/* Register ELF header as first region */
+	strscpy(elfregion.name, "KELF_HEADER", sizeof(elfregion.name));
+	elfregion.virt_addr = minidump.elf.ehdr;
+	elfregion.phys_addr = virt_to_phys(minidump.elf.ehdr);
+	elfregion.size = elfh_size;
+	minidump_ss_add_region(&elfregion);
+
+	ehdr = minidump.elf.ehdr;
+	/* Assign Section/Program headers offset */
+	minidump.elf.shdr = shdr = (struct elf_shdr *)(ehdr + 1);
+	minidump.elf.phdr = phdr = (struct elf_phdr *)(shdr + MAX_NUM_ENTRIES);
+	phdr_off = sizeof(*ehdr) + (sizeof(*shdr) * MAX_NUM_ENTRIES);
+
+	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
+	ehdr->e_ident[EI_CLASS] = ELF_CLASS;
+	ehdr->e_ident[EI_DATA] = ELF_DATA;
+	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
+	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
+	ehdr->e_type = ET_CORE;
+	ehdr->e_machine  = ELF_ARCH;
+	ehdr->e_version = EV_CURRENT;
+	ehdr->e_ehsize = sizeof(*ehdr);
+	ehdr->e_phoff = phdr_off;
+	ehdr->e_phentsize = sizeof(*phdr);
+	ehdr->e_shoff = sizeof(*ehdr);
+	ehdr->e_shentsize = sizeof(*shdr);
+	ehdr->e_shstrndx = 1;
+
+	minidump.elf.elf_offset = elfh_size;
+
+	/*
+	 * The zeroth index of the section header is reserved and is rarely used.
+	 * Set the section header as null (SHN_UNDEF) and move to the next one.
+	 * 2nd Section is String table.
+	 */
+	minidump.elf.strtable_idx = 1;
+	strtbl_off = sizeof(*ehdr) + ((sizeof(*phdr) + sizeof(*shdr)) * MAX_NUM_ENTRIES);
+	shdr++;
+	shdr->sh_type = SHT_STRTAB;
+	shdr->sh_offset = (elf_addr_t)strtbl_off;
+	shdr->sh_size = MAX_STRTBL_SIZE;
+	shdr->sh_entsize = 0;
+	shdr->sh_flags = 0;
+	shdr->sh_name = append_str_to_strtable("STR_TBL");
+	shdr++;
+
+	/* 3rd Section is for Minidump_table VA, used by parsers */
+	shdr->sh_type = SHT_PROGBITS;
+	shdr->sh_entsize = 0;
+	shdr->sh_flags = 0;
+	shdr->sh_addr = (elf_addr_t)&minidump;
+	shdr->sh_name = append_str_to_strtable("minidump_table");
+	shdr++;
+
+	/* 4th Section is Linux banner */
+	banner = (char *)ehdr + strtbl_off + MAX_STRTBL_SIZE;
+	memcpy(banner, linux_banner, banner_len);
+
+	shdr->sh_type = SHT_PROGBITS;
+	shdr->sh_offset = (elf_addr_t)(strtbl_off + MAX_STRTBL_SIZE);
+	shdr->sh_size = banner_len + 1;
+	shdr->sh_addr = (elf_addr_t)linux_banner;
+	shdr->sh_entsize = 0;
+	shdr->sh_flags = SHF_WRITE;
+	shdr->sh_name = append_str_to_strtable("linux_banner");
+
+	phdr->p_type = PT_LOAD;
+	phdr->p_offset = (elf_addr_t)(strtbl_off + MAX_STRTBL_SIZE);
+	phdr->p_vaddr = (elf_addr_t)linux_banner;
+	phdr->p_paddr = virt_to_phys(linux_banner);
+	phdr->p_filesz = phdr->p_memsz = banner_len + 1;
+	phdr->p_flags = PF_R | PF_W;
+
+	/* Update the program header/section header count added above */
+	ehdr->e_phnum = 1;
+	ehdr->e_shnum = 4;
+
+	return 0;
+}
+
+static int qcom_minidump_init(void)
+{
+	struct minidump_subsystem *mdsstoc;
+
+	mdsstoc = qcom_minidump_subsystem_desc(MINIDUMP_APSS_DESC);
+	if (IS_ERR(mdsstoc))
+		return -EINVAL;
+
+	minidump.md_regions = kcalloc(MAX_NUM_ENTRIES,
+			      sizeof(struct minidump_region), GFP_KERNEL);
+	if (!minidump.md_regions)
+		return -ENOMEM;
+
+	minidump.md_ss_toc = mdsstoc;
+	/* Share memory table update */
+	mdsstoc->regions_baseptr = cpu_to_le64(virt_to_phys(minidump.md_regions));
+	/* Tell bootloader not to encrypt the regions of this subsystem */
+	mdsstoc->encryption_status = cpu_to_le32(MINIDUMP_SS_ENCR_DONE);
+	mdsstoc->encryption_required = cpu_to_le32(MINIDUMP_SS_ENCR_NOTREQ);
+
+	mdsstoc->enabled = cpu_to_le32(MINIDUMP_SS_ENABLED);
+	mdsstoc->status = cpu_to_le32(1);
+	mdsstoc->region_count = cpu_to_le32(0);
+
+	return 0;
+}
+
+/**
+ * qcom_minidump_ready - Check, if minidump is ready for client registration or not.
+ *
+ * Return: zero on success and negative on failure.
+ *
+ * Qualcomm minidump feature is dependent on Qualcomm's shared memory and it is
+ * possible for a arm64 target to not have it's device tree entry present, for
+ * such case, qcom_minidump_ready() returns -ENODEV and client should not further
+ * try to register their region with minidump driver.
+ */
+int qcom_minidump_ready(void)
+{
+	struct device_node *np;
+	void *ptr;
+	int ret = 0;
+
+	mutex_lock(&minidump_lock);
+	if (minidump.ready)
+		goto unlock;
+
+	np = of_find_compatible_node(NULL, NULL, "qcom,smem");
+	if (!np) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+
+	of_node_put(np);
+	if (!of_device_is_available(np)) {
+		ret = -EPROBE_DEFER;
+		goto unlock;
+	}
+
+	ptr = qcom_smem_get(QCOM_SMEM_HOST_ANY, SBL_MINIDUMP_SMEM_ID, NULL);
+	if (IS_ERR(ptr)) {
+		ret = PTR_ERR(ptr);
+		goto unlock;
+	}
+
+	minidump.md_gbl_toc = ptr;
+	minidump.ready = true;
+
+unlock:
+	if (ret < 0)
+		minidump.ready = false;
+	mutex_unlock(&minidump_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_minidump_ready);
+
+/**
+ * qcom_minidump_subsystem_desc() - Get minidump subsystem descriptor.
+ * @minidump_index: minidump index for a subsystem in minidump table
+ *
+ * Return: minidump subsystem descriptor address on success and error
+ * on failure
+ */
+struct minidump_subsystem *qcom_minidump_subsystem_desc(unsigned int minidump_index)
+{
+	struct minidump_global_toc *mdgtoc;
+	size_t size;
+
+	if (minidump.md_gbl_toc)
+		return &minidump.md_gbl_toc->subsystems[minidump_index];
+
+	mdgtoc = qcom_smem_get(QCOM_SMEM_HOST_ANY, SBL_MINIDUMP_SMEM_ID, &size);
+	if (IS_ERR(mdgtoc)) {
+		pr_err("Unable to find minidump smem item\n");
+		return ERR_CAST(mdgtoc);
+	}
+
+	if (size < sizeof(*mdgtoc) || !mdgtoc->status) {
+		pr_err("Minidump table is not initialized\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	return &mdgtoc->subsystems[minidump_index];
+}
+EXPORT_SYMBOL_GPL(qcom_minidump_subsystem_desc);
+
+/**
+ * qcom_minidump_region_register() - Register a region in Minidump table.
+ * @region: minidump region.
+ *
+ * Client should not call this directly instead first call qcom_minidump_ready()
+ * to check if minidump is ready to do registration if yes, then call this API.
+ *
+ * Return: On success, it returns region index in minidump table and negative
+ * error value on failure.
+ */
+int qcom_minidump_region_register(const struct qcom_minidump_region *region)
+{
+	unsigned int num_region;
+	int ret;
+
+	mutex_lock(&minidump_lock);
+	if (!minidump.ready) {
+		pr_info("minidump is not ready\n");
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	/* Initialize minidump context on first call */
+	if (!minidump.init_done) {
+		ret = qcom_minidump_init();
+		if (ret)
+			goto unlock;
+
+		/* First entry would be ELF header */
+		ret = minidump_add_elf_header();
+		if (ret) {
+			kfree(minidump.md_regions);
+			goto unlock;
+		}
+
+		minidump.init_done = true;
+	}
+
+	if (!qcom_minidump_valid_region(region)) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	ret = get_minidump_region_index(region);
+	if (ret >= 0) {
+		pr_info("%s region is already registered\n", region->name);
+		ret = -EEXIST;
+		goto unlock;
+	}
+
+	/* Check if there is a room for a new entry */
+	ret = num_region = le32_to_cpu(minidump.md_ss_toc->region_count);
+	if (num_region >= MAX_NUM_ENTRIES) {
+		pr_err("maximum region limit %u reached\n", num_region);
+		ret = -ENOSPC;
+		goto unlock;
+	}
+
+	minidump_ss_add_region(region);
+	minidump_update_elf_header(region);
+unlock:
+	mutex_unlock(&minidump_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_minidump_region_register);
+
+static void __exit qcom_minidump_exit(void)
+{
+	mutex_lock(&minidump_lock);
+	kfree(minidump.elf.ehdr);
+	kfree(minidump.md_regions);
+	mutex_unlock(&minidump_lock);
+}
+module_exit(qcom_minidump_exit);
+
+MODULE_DESCRIPTION("Qualcomm minidump driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/soc/qcom/minidump.h b/include/soc/qcom/minidump.h
new file mode 100644
index 0000000..a50843f
--- /dev/null
+++ b/include/soc/qcom/minidump.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _MINIDUMP_H_
+#define _MINIDUMP_H_
+
+#include <linux/types.h>
+
+#define MAX_NAME_LENGTH		12
+
+/**
+ * struct qcom_minidump_region - Minidump region information
+ *
+ * @name:	Entry name, Minidump will dump binary with this name.
+ * @virt_addr:  Virtual address of the entry.
+ * @phys_addr:	Physical address of the entry to dump.
+ * @size:	Number of byte to dump from @address location,
+ *		and it should be 4 byte aligned.
+ */
+struct qcom_minidump_region {
+	char		name[MAX_NAME_LENGTH];
+	void		*virt_addr;
+	phys_addr_t	phys_addr;
+	size_t		size;
+};
+
+#if IS_ENABLED(CONFIG_QCOM_MINIDUMP)
+extern int qcom_minidump_ready(void);
+extern int qcom_minidump_region_register(const struct qcom_minidump_region *entry);
+#else
+static inline int qcom_minidump_ready(void) { return 0; }
+static inline int qcom_minidump_region_register(const struct qcom_minidump_region *entry)
+{
+	/* Return quietly, if minidump is not enabled */
+	return 0;
+}
+#endif
+#endif /* _MINIDUMP_H_ */
diff --git a/include/soc/qcom/qcom_minidump.h b/include/soc/qcom/qcom_minidump.h
index 84c8605..e8630ed 100644
--- a/include/soc/qcom/qcom_minidump.h
+++ b/include/soc/qcom/qcom_minidump.h
@@ -10,11 +10,25 @@
 
 #define MAX_NUM_OF_SS           10
 #define MAX_REGION_NAME_LENGTH  16
+
+#define MINIDUMP_REVISION	1
 #define SBL_MINIDUMP_SMEM_ID	602
+
+/* Application processor minidump descriptor */
+#define MINIDUMP_APSS_DESC	0
+#define SMEM_ENTRY_SIZE		40
+
 #define MINIDUMP_REGION_VALID		('V' << 24 | 'A' << 16 | 'L' << 8 | 'I' << 0)
+#define MINIDUMP_REGION_INVALID		('I' << 24 | 'N' << 16 | 'V' << 8 | 'A' << 0)
+#define MINIDUMP_REGION_INIT		('I' << 24 | 'N' << 16 | 'I' << 8 | 'T' << 0)
+#define MINIDUMP_REGION_NOINIT		0
+
+#define MINIDUMP_SS_ENCR_REQ		(0 << 24 | 'Y' << 16 | 'E' << 8 | 'S' << 0)
+#define MINIDUMP_SS_ENCR_NOTREQ		(0 << 24 | 0 << 16 | 'N' << 8 | 'R' << 0)
+#define MINIDUMP_SS_ENCR_NONE		('N' << 24 | 'O' << 16 | 'N' << 8 | 'E' << 0)
 #define MINIDUMP_SS_ENCR_DONE		('D' << 24 | 'O' << 16 | 'N' << 8 | 'E' << 0)
+#define MINIDUMP_SS_ENCR_START		('S' << 24 | 'T' << 16 | 'R' << 8 | 'T' << 0)
 #define MINIDUMP_SS_ENABLED		('E' << 24 | 'N' << 16 | 'B' << 8 | 'L' << 0)
-
 /**
  * struct minidump_region - Minidump region
  * @name		: Name of the region to be dumped
@@ -63,4 +77,12 @@ struct minidump_global_toc {
 	struct minidump_subsystem	subsystems[MAX_NUM_OF_SS];
 };
 
+#if IS_ENABLED(CONFIG_QCOM_MINIDUMP)
+extern struct minidump_subsystem *qcom_minidump_subsystem_desc(unsigned int minidump_index);
+#else
+static inline struct minidump_subsystem *qcom_minidump_subsystem_desc(unsigned int minidump_index)
+{
+	return NULL;
+}
+#endif
 #endif  /* _QCOM_MINIDUMP_H_ */
-- 
2.7.4

