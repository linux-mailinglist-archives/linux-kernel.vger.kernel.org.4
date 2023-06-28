Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FA4741149
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjF1Mgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:36:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131]:48294 "EHLO
        mx0b-0031df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231481AbjF1MgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:36:19 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SCT5mO017762;
        Wed, 28 Jun 2023 12:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=reR/OBRi++6hTO4s+OJ86kHXDpuVnRYQwHnvTltWSGo=;
 b=gXtjStU5Py+hhGwOiJX2l5jfJutoviW8q3ypLVL8KiD0BeqWKcmOKf/+PjhEuHhs9CP9
 M1k5mpzb/bGJ1IMMGS7c8clnhLKEabxwIwZH681FNrXvFG2cTkKs5NcoXRODdPGnlXid
 4wnICb3Rwal3JkNr/61DVS+i58mOWONlZY2FB2YJ5caH498lK+vWB3iNRX8QPw3yl2g5
 +JqLWWJknJTSnN+6FfrwO4lFpwCvh35TpNOCBfyTDAp0c7d8Y7tpaCPNkQ3Cg7ymCp0/
 6Ochk5Jyn0lqnVZ1AMZ3axQaTPaDo64iRn1MxrwFQdwm7H26ee56hjyjWsSQXWDLPGlp cg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rfrdtbq7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 12:35:43 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35SCZgl5023662
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 12:35:42 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 28 Jun 2023 05:35:35 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>,
        "Mukesh Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH v4 04/21] soc: qcom: Add Qualcomm APSS minidump (frontend) feature support
Date:   Wed, 28 Jun 2023 18:04:31 +0530
Message-ID: <1687955688-20809-5-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oTb39OZ0yM19lZfwqLm3QZKACOst7Nyu
X-Proofpoint-GUID: oTb39OZ0yM19lZfwqLm3QZKACOst7Nyu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280111
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

Minidump kernel driver implementation is divided into two parts for
simplicity, one is minidump core which can also be called minidump
frontend(As API gets exported from this driver for registration with
backend) and the other part is minidump backend i.e, where the underlying
implementation of minidump will be there. There could be different way
how the backend is implemented like Shared memory, Memory mapped IO
or Resource manager based where the guest region information is passed
to hypervisor via hypercalls.

Minidump Client-1     Client-2      Client-5    Client-n
         |               |              |             |
         |               |    ...       |   ...       |
         |               |              |             |
         |               |              |             |
         |               |              |             |
         |               |              |             |
         |               |              |             |
         |               |              |             |
         |           +---+--------------+----+        |
         +-----------+  qcom_minidump(core)  +--------+
                     |                       |
                     +------+-----+------+---+
                            |     |      |
                            |     |      |
            +---------------+     |      +--------------------+
            |                     |                           |
            |                     |                           |
            |                     |                           |
            v                     v                           v
 +-------------------+      +-------------------+     +------------------+
 |qcom_minidump_smem |      |qcom_minidump_mmio |     | qcom_minidump_rm |
 |                   |      |                   |     |                  |
 +-------------------+      +-------------------+     +------------------+
   Shared memory              Memory mapped IO           Resource manager
    (backend)                   (backend)                   (backend)

Here, we will be giving all analogy of backend with SMEM as it is the
only implemented backend at present but general idea remains the same.

The core of minidump feature is part of Qualcomm's boot firmware code.
It initializes shared memory (SMEM), which is a part of DDR and
allocates a small section of it to minidump table i.e also called
global table of content (G-ToC). Each subsystem (APSS, ADSP, ...) has
their own table of segments to be included in the minidump, all
references from a descriptor in SMEM (G-ToC). Each segment/region has
some details like name, physical address and it's size etc. and it
could be anywhere scattered in the DDR.

qcom_minidump(core or frontend) driver adds the capability to add APSS
region to be dumped as part of ram dump collection. It provides
appropriate symbol register/unregister client regions.

To simplify post mortem debugging, it creates and maintain an ELF
header as first region that gets updated upon registration
of a new region.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/soc/qcom/Kconfig                  |  15 +
 drivers/soc/qcom/Makefile                 |   2 +
 drivers/soc/qcom/qcom_minidump.c          | 456 ++++++++++++++++++++++++++++++
 drivers/soc/qcom/qcom_minidump_internal.h |  75 +++++
 include/soc/qcom/qcom_minidump.h          |  35 +++
 5 files changed, 583 insertions(+)
 create mode 100644 drivers/soc/qcom/qcom_minidump.c
 create mode 100644 drivers/soc/qcom/qcom_minidump_internal.h

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 982310b5a1cb..874ee8c3efe0 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -279,6 +279,21 @@ config QCOM_INLINE_CRYPTO_ENGINE
 	tristate
 	select QCOM_SCM
 
+config QCOM_MINIDUMP
+	tristate "QCOM Minidump APSS Core Infrastructure"
+	depends on ARCH_QCOM
+	help
+	  This config allow linux core infrastructure for APSS minidump for
+	  underlying backend(smem etc.) which can hook themselves to this and
+	  work as one unit. So, this config should be selected in combination
+	  with its backend.
+
+	  After this Linux clients driver can register their internal data
+	  structures and debug messages as part of the apss minidump region
+	  and when the SoC is crashed, and these selective regions will be
+	  dumped instead of the entire DDR. This saves significant amount
+	  of time and/or storage space.
+
 config QCOM_MINIDUMP_SMEM
 	tristate "QCOM Minidump SMEM (as backend) Support"
 	depends on ARCH_QCOM
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 89b775512bef..737d868757ac 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -34,3 +34,5 @@ obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
 obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
 qcom_ice-objs			+= ice.o
 obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= qcom_ice.o
+obj-$(CONFIG_QCOM_MINIDUMP) += qcom_minidump.o
+obj-$(CONFIG_QCOM_MINIDUMP_SMEM) += qcom_minidump_smem.o
diff --git a/drivers/soc/qcom/qcom_minidump.c b/drivers/soc/qcom/qcom_minidump.c
new file mode 100644
index 000000000000..7744e57843ab
--- /dev/null
+++ b/drivers/soc/qcom/qcom_minidump.c
@@ -0,0 +1,456 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/device.h>
+#include <linux/export.h>
+#include <linux/kallsyms.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/string.h>
+
+#include "qcom_minidump_internal.h"
+
+/*
+ * In some of the Old Qualcomm devices, boot firmware statically allocates 300
+ * as total number of supported region (including all co-processors) in
+ * minidump table out of which linux was using 201. In future, this limitation
+ * from boot firmware might get removed by allocating the region dynamically.
+ * So, keep it compatible with older devices, we can keep the current limit for
+ * Linux to 201.
+ */
+#define MAX_NUM_ENTRIES	  201
+#define MAX_STRTBL_SIZE	  (MAX_NUM_ENTRIES * MAX_REGION_NAME_LENGTH)
+
+/*
+ * md_lock protects "md" during calls to qcom_minidump_backend_register(),
+ * qcom_minidump_backend_unregister().
+ */
+static DEFINE_MUTEX(md_lock);
+
+/* Only one front end will be attached to one back-end */
+static struct minidump *md;
+static char *md_backend;
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
+static char *elf_lookup_string(struct elfhdr *ehdr, int offset)
+{
+	char *strtab = elf_str_table_start(ehdr);
+
+	if (!strtab || (md->elf.strtable_idx < offset))
+		return NULL;
+
+	return strtab + offset;
+}
+
+static unsigned int append_str_to_strtable(struct minidump *md, const char *name)
+{
+	char *strtab = elf_str_table_start(md->elf.ehdr);
+	unsigned int old_idx = md->elf.strtable_idx;
+	unsigned int ret;
+
+	if (!strtab || !name)
+		return 0;
+
+	ret = old_idx;
+	old_idx += strscpy((strtab + old_idx), name, MAX_REGION_NAME_LENGTH);
+	md->elf.strtable_idx = old_idx + 1;
+
+	return ret;
+}
+
+static int qcom_minidump_clear_header(const struct qcom_minidump_region *region)
+{
+	struct elfhdr *ehdr = md->elf.ehdr;
+	struct elf_shdr *shdr;
+	struct elf_shdr *tmp_shdr;
+	struct elf_phdr *phdr;
+	struct elf_phdr *tmp_phdr;
+	unsigned int phidx;
+	unsigned int shidx;
+	unsigned int len;
+	unsigned int i;
+	char *shname;
+
+	for (i = 0; i < ehdr->e_phnum; i++) {
+		phdr = elf_phdr_entry_addr(ehdr, i);
+		if (phdr->p_paddr == region->phys_addr &&
+		    phdr->p_memsz == region->size)
+			break;
+	}
+
+	if (i == ehdr->e_phnum) {
+		dev_err(md->dev, "Cannot find program header entry in elf\n");
+		return -EINVAL;
+	}
+
+	phidx = i;
+	for (i = 0; i < ehdr->e_shnum; i++) {
+		shdr = elf_shdr_entry_addr(ehdr, i);
+		shname = elf_lookup_string(ehdr, shdr->sh_name);
+		if (shname && !strcmp(shname, region->name) &&
+		    shdr->sh_addr == (elf_addr_t)region->virt_addr &&
+		    shdr->sh_size == region->size)
+			break;
+	}
+
+	if (i == ehdr->e_shnum) {
+		dev_err(md->dev, "Cannot find section header entry in elf\n");
+		return -EINVAL;
+	}
+
+	shidx = i;
+	if (shdr->sh_offset != phdr->p_offset) {
+		dev_err(md->dev, "Invalid entry details for region: %s\n", region->name);
+		return -EINVAL;
+	}
+
+	/* Clear name in string table */
+	len = strlen(shname) + 1;
+	memmove(shname, shname + len, md->elf.strtable_idx - shdr->sh_name - len);
+	md->elf.strtable_idx -= len;
+
+	/* Clear program header */
+	tmp_phdr = elf_phdr_entry_addr(ehdr, phidx);
+	for (i = phidx; i < ehdr->e_phnum - 1; i++) {
+		tmp_phdr = elf_phdr_entry_addr(ehdr, i + 1);
+		phdr = elf_phdr_entry_addr(ehdr, i);
+		memcpy(phdr, tmp_phdr, sizeof(struct elf_phdr));
+		phdr->p_offset = phdr->p_offset - region->size;
+	}
+	memset(tmp_phdr, 0, sizeof(struct elf_phdr));
+	ehdr->e_phnum--;
+
+	/* Clear section header */
+	tmp_shdr = elf_shdr_entry_addr(ehdr, shidx);
+	for (i = shidx; i < ehdr->e_shnum - 1; i++) {
+		tmp_shdr = elf_shdr_entry_addr(ehdr, i + 1);
+		shdr = elf_shdr_entry_addr(ehdr, i);
+		memcpy(shdr, tmp_shdr, sizeof(struct elf_shdr));
+		shdr->sh_offset -= region->size;
+		shdr->sh_name -= len;
+	}
+
+	memset(tmp_shdr, 0, sizeof(struct elf_shdr));
+	ehdr->e_shnum--;
+	md->elf.elf_offset -= region->size;
+
+	return 0;
+}
+
+static void qcom_md_update_elf_header(const struct qcom_minidump_region *region)
+{
+	struct elfhdr *ehdr = md->elf.ehdr;
+	struct elf_shdr *shdr;
+	struct elf_phdr *phdr;
+
+	shdr = elf_shdr_entry_addr(ehdr, ehdr->e_shnum++);
+	phdr = elf_phdr_entry_addr(ehdr, ehdr->e_phnum++);
+
+	shdr->sh_type = SHT_PROGBITS;
+	shdr->sh_name = append_str_to_strtable(md, region->name);
+	shdr->sh_addr = (elf_addr_t)region->virt_addr;
+	shdr->sh_size = region->size;
+	shdr->sh_flags = SHF_WRITE;
+	shdr->sh_offset = md->elf.elf_offset;
+	shdr->sh_entsize = 0;
+
+	phdr->p_type = PT_LOAD;
+	phdr->p_offset = md->elf.elf_offset;
+	phdr->p_vaddr = (elf_addr_t)region->virt_addr;
+	phdr->p_paddr = region->phys_addr;
+	phdr->p_filesz = phdr->p_memsz = region->size;
+	phdr->p_flags = PF_R | PF_W;
+	md->elf.elf_offset += shdr->sh_size;
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
+/**
+ * qcom_minidump_region_register() - Register region in APSS Minidump table.
+ * @region: minidump region.
+ *
+ * Return: On success, it returns 0 and negative error value on failure.
+ */
+int qcom_minidump_region_register(const struct qcom_minidump_region *region)
+{
+	int ret;
+
+	if (!qcom_minidump_valid_region(region))
+		return -EINVAL;
+
+	mutex_lock(&md_lock);
+	if (!md) {
+		mutex_unlock(&md_lock);
+		pr_err("No backend registered yet, try again..");
+		return -EPROBE_DEFER;
+	}
+
+	ret = md->ops->md_region_register(md, region);
+	if (ret)
+		goto unlock;
+
+	qcom_md_update_elf_header(region);
+unlock:
+	mutex_unlock(&md_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_minidump_region_register);
+
+/**
+ * qcom_minidump_region_unregister() - Unregister region from APSS Minidump table.
+ * @region: minidump region.
+ *
+ * Return: On success, it returns 0 and negative error value on failure.
+ */
+int qcom_minidump_region_unregister(const struct qcom_minidump_region *region)
+{
+	int ret;
+
+	if (!qcom_minidump_valid_region(region))
+		return -EINVAL;
+
+	mutex_lock(&md_lock);
+	if (!md) {
+		mutex_unlock(&md_lock);
+		pr_err("No backend registered yet, try again..");
+		return -EPROBE_DEFER;
+	}
+
+	ret = md->ops->md_region_unregister(md, region);
+	if (ret)
+		goto unlock;
+
+	ret = qcom_minidump_clear_header(region);
+unlock:
+	mutex_unlock(&md_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_minidump_region_unregister);
+
+static int qcom_minidump_add_elf_header(struct minidump *md_data)
+{
+	struct qcom_minidump_region elfregion;
+	struct elfhdr *ehdr;
+	struct elf_shdr *shdr;
+	struct elf_phdr *phdr;
+	unsigned int  elfh_size;
+	unsigned int strtbl_off;
+	unsigned int phdr_off;
+	char *linux_banner;
+	unsigned int banner_len;
+	char *banner;
+
+	linux_banner = (char *)kallsyms_lookup_name("linux_banner");
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
+	md_data->elf.ehdr = devm_kzalloc(md_data->dev, elfh_size, GFP_KERNEL);
+	if (!md_data->elf.ehdr)
+		return -ENOMEM;
+
+	ehdr = md_data->elf.ehdr;
+	/* Assign Section/Program headers offset */
+	md_data->elf.shdr = shdr = (struct elf_shdr *)(ehdr + 1);
+	md_data->elf.phdr = phdr = (struct elf_phdr *)(shdr + MAX_NUM_ENTRIES);
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
+	md_data->elf.elf_offset = elfh_size;
+	/*
+	 * The zeroth index of the section header is reserved and is rarely used.
+	 * Set the section header as null (SHN_UNDEF) and move to the next one.
+	 * 2nd Section is String table.
+	 */
+	md_data->elf.strtable_idx = 1;
+	strtbl_off = sizeof(*ehdr) + ((sizeof(*phdr) + sizeof(*shdr)) * MAX_NUM_ENTRIES);
+	shdr++;
+	shdr->sh_type = SHT_STRTAB;
+	shdr->sh_offset = (elf_addr_t)strtbl_off;
+	shdr->sh_size = MAX_STRTBL_SIZE;
+	shdr->sh_entsize = 0;
+	shdr->sh_flags = 0;
+	shdr->sh_name = append_str_to_strtable(md_data, "STR_TBL");
+	shdr++;
+
+	/* 3rd Section is Linux banner */
+	banner = (char *)ehdr + strtbl_off + MAX_STRTBL_SIZE;
+	memcpy(banner, linux_banner, banner_len);
+
+	shdr->sh_type = SHT_PROGBITS;
+	shdr->sh_offset = (elf_addr_t)(strtbl_off + MAX_STRTBL_SIZE);
+	shdr->sh_size = banner_len + 1;
+	shdr->sh_addr = (elf_addr_t)linux_banner;
+	shdr->sh_entsize = 0;
+	shdr->sh_flags = SHF_WRITE;
+	shdr->sh_name = append_str_to_strtable(md_data, "linux_banner");
+
+	phdr->p_type = PT_LOAD;
+	phdr->p_offset = (elf_addr_t)(strtbl_off + MAX_STRTBL_SIZE);
+	phdr->p_vaddr = (elf_addr_t)linux_banner;
+	phdr->p_paddr = virt_to_phys(linux_banner);
+	phdr->p_filesz = phdr->p_memsz = banner_len + 1;
+	phdr->p_flags = PF_R | PF_W;
+
+	/*
+	 * Above are some prdefined sections/program header used
+	 * for debug, update their count here.
+	 */
+	ehdr->e_phnum = 1;
+	ehdr->e_shnum = 3;
+
+	/* Register ELF header as first region */
+	strscpy(elfregion.name, "KELF_HEADER", sizeof(elfregion.name));
+	elfregion.virt_addr = md_data->elf.ehdr;
+	elfregion.phys_addr = virt_to_phys(md_data->elf.ehdr);
+	elfregion.size = elfh_size;
+
+	return md_data->ops->md_region_register(md_data, &elfregion);
+}
+
+/**
+ * qcom_minidump_backend_register() - Register backend minidump device.
+ * @md_data: minidump backend driver data
+ *
+ * Return: On success, it returns 0 and negative error value on failure.
+ */
+int qcom_minidump_backend_register(struct minidump *md_data)
+{
+	int ret;
+
+	if (!md_data->name || !md_data->dev ||
+	    !md_data->ops ||
+	    !md_data->ops->md_table_init ||
+	    !md_data->ops->md_region_register ||
+	    !md_data->ops->md_region_unregister ||
+	    !md_data->ops->md_table_exit) {
+		pr_warn("backend '%s' must fill/implement necessary fields\n", md->name);
+		return -EINVAL;
+	}
+
+	if (md_backend && strcmp(md_backend, md_data->name)) {
+		pr_warn("backend '%s' already in use: ignoring '%s'\n",
+			 md_backend, md_data->name);
+		return -EBUSY;
+	}
+
+	mutex_lock(&md_lock);
+	if (md) {
+		dev_warn(md->dev, "backend '%s' already loaded: ignoring '%s'\n",
+			 md->name, md_data->name);
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	if (!md_data->max_region_limit || md_data->max_region_limit > MAX_NUM_ENTRIES)
+		md_data->max_region_limit = MAX_NUM_ENTRIES;
+
+	ret = md_data->ops->md_table_init(md_data);
+	if (ret) {
+		dev_err(md_data->dev, "minidump backend initialization failed: %d\n", ret);
+		goto unlock;
+	}
+
+	/* First entry would be ELF header */
+	ret = qcom_minidump_add_elf_header(md_data);
+	if (ret) {
+		dev_err(md_data->dev, "Failed to add elf header: %d\n", ret);
+		md_data->ops->md_table_exit(md_data);
+		goto unlock;
+	}
+
+	md = md_data;
+	md_backend = kstrdup(md->name, GFP_KERNEL);
+	dev_info(md->dev, "Registered minidump backend : %s\n", md->name);
+
+unlock:
+	mutex_unlock(&md_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_minidump_backend_register);
+
+/**
+ * qcom_minidump_backend_unregister() - Unregister backend minidump device.
+ * @md_data: minidump backend driver data
+ */
+void qcom_minidump_backend_unregister(struct minidump *md_data)
+{
+	mutex_lock(&md_lock);
+	/* Only one backend can be registered at a time. */
+	if (WARN_ON(md_data != md))
+		goto unlock;
+
+	dev_info(md_data->dev, "Unregistered %s as minidump backend\n", md_data->name);
+	md_data->ops->md_table_exit(md_data);
+	kfree(md_backend);
+	md_backend = NULL;
+	md = NULL;
+unlock:
+	mutex_unlock(&md_lock);
+}
+EXPORT_SYMBOL_GPL(qcom_minidump_backend_unregister);
+
+MODULE_DESCRIPTION("Qualcomm minidump core");
+MODULE_LICENSE("GPL");
diff --git a/drivers/soc/qcom/qcom_minidump_internal.h b/drivers/soc/qcom/qcom_minidump_internal.h
new file mode 100644
index 000000000000..9031b1b0a046
--- /dev/null
+++ b/drivers/soc/qcom/qcom_minidump_internal.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _QCOM_MINIDUMP_INTERNAL_H_
+#define _QCOM_MINIDUMP_INTERNAL_H_
+
+#include <linux/elf.h>
+#include <soc/qcom/qcom_minidump.h>
+
+#define MAX_REGION_NAME_LENGTH  16
+
+struct minidump;
+/**
+ * struct minidump_ops - APSS Minidump operation structure, each underlying
+ *			 backend need to add their hooks to it.
+ *
+ * @md_table_init:	  Get the hold of APSS minidump table for the backend
+ *			  and initialize it with details.
+ * @md_table_exit:	  Clean up the stuff populated while md_table_init()
+ * @md_region_register:	  Callback to register the region at the backend.
+ * @md_region_unregister: Callback to unregister the region at the backend.
+ */
+struct minidump_ops {
+	int (*md_table_init)(struct minidump *md);
+	int (*md_table_exit)(struct minidump *md);
+	int (*md_region_register)(struct minidump *md,
+				 const struct qcom_minidump_region *region);
+	int (*md_region_unregister)(struct minidump *md,
+				 const struct qcom_minidump_region *region);
+};
+
+/**
+ * struct minidump_elfhdr - Minidump table elf header
+ * @ehdr: elf main header
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
+ * struct minidump - Qualcomm minidump core information
+ * @name	  : Minidump backend name
+ * @ops		  : set of callback need to be implemented
+ * @elf		  : Minidump elf header
+ * @dev		  : Minidump backend device
+ * @max_num_limit : Maximum number of region limit
+ * @apss_data	  : Backend driver's private data pointer
+ */
+struct minidump {
+	const char			*name;
+	struct minidump_ops		*ops;
+	struct minidump_elfhdr		elf;
+	struct device			*dev;
+	unsigned int			max_region_limit;
+	void				*apss_data;
+};
+
+#if IS_ENABLED(CONFIG_QCOM_MINIDUMP)
+int qcom_minidump_backend_register(struct minidump *md);
+void qcom_minidump_backend_unregister(struct minidump *md);
+#else
+int qcom_minidump_backend_register(struct minidump *md) { return 0; }
+void qcom_minidump_backend_unregister(struct minidump *md) {}
+#endif /* CONFIG_QCOM_MINIDUMP */
+#endif /* _QCOM_MINIDUMP_INTERNAL_H_ */
diff --git a/include/soc/qcom/qcom_minidump.h b/include/soc/qcom/qcom_minidump.h
index d7747c27fd45..d0bebc3daac5 100644
--- a/include/soc/qcom/qcom_minidump.h
+++ b/include/soc/qcom/qcom_minidump.h
@@ -1,11 +1,46 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
+ * This file contains data structure which should be used by the
+ * APSS minidump clients.
+ *
  * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef _QCOM_MINIDUMP_H_
 #define _QCOM_MINIDUMP_H_
 
+#define MAX_NAME_LENGTH		12
+/**
+ * struct qcom_minidump_region - APSS Minidump region information
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
+int qcom_minidump_region_register(const struct qcom_minidump_region *region);
+int qcom_minidump_region_unregister(const struct qcom_minidump_region *region);
+#else
+static inline int qcom_minidump_region_register(const struct qcom_minidump_region *region)
+{
+	/* Return quietly, if minidump is not enabled */
+	return 0;
+}
+static inline int qcom_minidump_region_unregister(const struct qcom_minidump_region *region)
+{
+	return 0;
+}
+#endif /* CONFIG_QCOM_MINIDUMP */
+
 #if IS_ENABLED(CONFIG_QCOM_MINIDUMP_SMEM)
 void *qcom_ss_md_mapped_base(unsigned int minidump_id, int *seg_cnt);
 int qcom_ss_valid_segment_info(void *ptr, int i, char **name,
-- 
2.7.4

