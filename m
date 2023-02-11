Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90DD692EB5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 07:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjBKGdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 01:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjBKGdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 01:33:24 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9877D3C4;
        Fri, 10 Feb 2023 22:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676097196; x=1707633196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sicLrsvVZy9P6KGOhyjaeddCBIYX6vdAjje0xZ1P+Wk=;
  b=iyVkoavUh3JRuSA/DVruzc0lpawwC3GD6j+zD3Z6W/Tg/oQpUddIiAwz
   wNH8mWwmXEY+bmfT4zWMFnt+Rwsm0PbumHqPpGCGGUQq+fayA962E+jD7
   z7MELGFzP6W/Rdxz4UtruE7fPSCwK5y2bsokTQ/JBymM9EFIYXMh0I578
   K1jGw5w9poHwev3GJkGbhL6pkJsomNecP7rKEGbL8uTQSBzHpJ6pevKMi
   znE39hpQEWcUbk+JALGwRjNKFlRS6088T9qJ9LojFe4PWVcaPN5QsWNqU
   1AJKg2PgTzLu7M9qZwGYLl931yVHvjezD8k5w5fO/VUGhKhkz4RLt7/uz
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="310223216"
X-IronPort-AV: E=Sophos;i="5.97,289,1669104000"; 
   d="scan'208";a="310223216"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 22:33:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="997171775"
X-IronPort-AV: E=Sophos;i="5.97,289,1669104000"; 
   d="scan'208";a="997171775"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga005.fm.intel.com with ESMTP; 10 Feb 2023 22:33:03 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 08/12] platform/x86: ISST: Add SST-CP support via TPMI
Date:   Fri, 10 Feb 2023 22:32:53 -0800
Message-Id: <20230211063257.311746-9-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230211063257.311746-1-srinivas.pandruvada@linux.intel.com>
References: <20230211063257.311746-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Speed Select Technology Core Power (SST-CP) is an interface that
allows users to define per core priority. This defines a mechanism to
distribute power among cores when there is a power constrained
scenario. This defines a class of service (CLOS) configuration.

Three new IOCTLs are added:
ISST_IF_CORE_POWER_STATE : Enable/Disable SST-CP
ISST_IF_CLOS_PARAM : Configure CLOS parameters
ISST_IF_CLOS_ASSOC : Associate CPUs to a CLOS

To associate CPUs to CLOS, either Linux CPU numbering or PUNIT numbering
scheme can be used, using parameter punit_cpu_map (1: for PUNIT numbering
0 for Linux CPU number).

There is no change to IOCTL to get PUNIT CPU number for a CPU.

Introduce get_instance() function, which is used by majority of IOCTLs
processing to convert a socket and power domain to
tpmi_per_power_domain_info * instance. This instance has all the MMIO
offsets stored to read a particular field.

Once an instance is identified, read or write from correct MMIO
offset for a given field as defined in the specification.

For details on SST CP operations using intel-speed-selet utility,
refer to:
Documentation/admin-guide/pm/intel-speed-select.rst
under the kernel documentation

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel/speed_select_if/isst_tpmi_core.c    | 264 ++++++++++++++++++
 include/uapi/linux/isst_if.h                  |  79 ++++++
 2 files changed, 343 insertions(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 3453708c2dd0..bcdf51517c88 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -31,6 +31,18 @@
 /* Supported SST hardware version by this driver */
 #define ISST_HEADER_VERSION		1
 
+/*
+ * Used to indicate if value read from MMIO needs to get multiplied
+ * to get to a standard unit or not.
+ */
+#define SST_MUL_FACTOR_NONE    1
+
+/* Define 100 as a scaling factor frequency ratio to frequency conversion */
+#define SST_MUL_FACTOR_FREQ    100
+
+/* All SST regs are 64 bit size */
+#define SST_REG_SIZE   8
+
 /**
  * struct sst_header -	SST main header
  * @interface_version:	Version number for this interface
@@ -359,6 +371,249 @@ static int sst_main(struct auxiliary_device *auxdev, struct tpmi_per_power_domai
 	return 0;
 }
 
+/*
+ * Map a package and power_domain id to SST information structure unique for a power_domain.
+ * The caller should call under isst_tpmi_dev_lock.
+ */
+static struct tpmi_per_power_domain_info *get_instance(int pkg_id, int power_domain_id)
+{
+	struct tpmi_per_power_domain_info *power_domain_info;
+	struct tpmi_sst_struct *sst_inst;
+
+	if (pkg_id < 0 || pkg_id > isst_common.max_index ||
+	    pkg_id >= topology_max_packages())
+		return NULL;
+
+	sst_inst = isst_common.sst_inst[pkg_id];
+	if (!sst_inst)
+		return NULL;
+
+	if (power_domain_id < 0 || power_domain_id >= sst_inst->number_of_power_domains)
+		return NULL;
+
+	power_domain_info = &sst_inst->power_domain_info[power_domain_id];
+
+	if (power_domain_info && !power_domain_info->sst_base)
+		return NULL;
+
+	return power_domain_info;
+}
+
+static bool disable_dynamic_sst_features(void)
+{
+	u64 value;
+
+	rdmsrl(MSR_PM_ENABLE, value);
+	return !(value & 0x1);
+}
+
+#define _read_cp_info(name_str, name, offset, start, width, mult_factor)\
+{\
+	u64 val, mask;\
+	\
+	val = readq(power_domain_info->sst_base + power_domain_info->sst_header.cp_offset +\
+			(offset));\
+	mask = GENMASK_ULL((start + width - 1), start);\
+	val &= mask; \
+	val >>= start;\
+	name = (val * mult_factor);\
+}
+
+#define _write_cp_info(name_str, name, offset, start, width, div_factor)\
+{\
+	u64 val, mask;\
+	\
+	val = readq(power_domain_info->sst_base +\
+		    power_domain_info->sst_header.cp_offset + (offset));\
+	mask = GENMASK_ULL((start + width - 1), start);\
+	val &= ~mask;\
+	val |= (name / div_factor) << start;\
+	writeq(val, power_domain_info->sst_base + power_domain_info->sst_header.cp_offset +\
+		(offset));\
+}
+
+#define	SST_CP_CONTROL_OFFSET	8
+#define	SST_CP_STATUS_OFFSET	16
+
+#define SST_CP_ENABLE_START		0
+#define SST_CP_ENABLE_WIDTH		1
+
+#define SST_CP_PRIORITY_TYPE_START	1
+#define SST_CP_PRIORITY_TYPE_WIDTH	1
+
+static long isst_if_core_power_state(void __user *argp)
+{
+	struct tpmi_per_power_domain_info *power_domain_info;
+	struct isst_core_power core_power;
+
+	if (disable_dynamic_sst_features())
+		return -EFAULT;
+
+	if (copy_from_user(&core_power, argp, sizeof(core_power)))
+		return -EFAULT;
+
+	power_domain_info = get_instance(core_power.socket_id, core_power.power_domain_id);
+	if (!power_domain_info)
+		return -EINVAL;
+
+	if (core_power.get_set) {
+		_write_cp_info("cp_enable", core_power.enable, SST_CP_CONTROL_OFFSET,
+			       SST_CP_ENABLE_START, SST_CP_ENABLE_WIDTH, SST_MUL_FACTOR_NONE)
+		_write_cp_info("cp_prio_type", core_power.priority_type, SST_CP_CONTROL_OFFSET,
+			       SST_CP_PRIORITY_TYPE_START, SST_CP_PRIORITY_TYPE_WIDTH,
+			       SST_MUL_FACTOR_NONE)
+	} else {
+		/* get */
+		_read_cp_info("cp_enable", core_power.enable, SST_CP_STATUS_OFFSET,
+			      SST_CP_ENABLE_START, SST_CP_ENABLE_WIDTH, SST_MUL_FACTOR_NONE)
+		_read_cp_info("cp_prio_type", core_power.priority_type, SST_CP_STATUS_OFFSET,
+			      SST_CP_PRIORITY_TYPE_START, SST_CP_PRIORITY_TYPE_WIDTH,
+			      SST_MUL_FACTOR_NONE)
+		core_power.supported = !!(power_domain_info->sst_header.cap_mask & BIT(0));
+		if (copy_to_user(argp, &core_power, sizeof(core_power)))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+#define SST_CLOS_CONFIG_0_OFFSET	24
+
+#define SST_CLOS_CONFIG_PRIO_START	4
+#define SST_CLOS_CONFIG_PRIO_WIDTH	4
+
+#define SST_CLOS_CONFIG_MIN_START	8
+#define SST_CLOS_CONFIG_MIN_WIDTH	8
+
+#define SST_CLOS_CONFIG_MAX_START	16
+#define SST_CLOS_CONFIG_MAX_WIDTH	8
+
+static long isst_if_clos_param(void __user *argp)
+{
+	struct tpmi_per_power_domain_info *power_domain_info;
+	struct isst_clos_param clos_param;
+
+	if (copy_from_user(&clos_param, argp, sizeof(clos_param)))
+		return -EFAULT;
+
+	power_domain_info = get_instance(clos_param.socket_id, clos_param.power_domain_id);
+	if (!power_domain_info)
+		return -EINVAL;
+
+	if (clos_param.get_set) {
+		_write_cp_info("clos.min_freq", clos_param.min_freq_mhz,
+			       (SST_CLOS_CONFIG_0_OFFSET + clos_param.clos * SST_REG_SIZE),
+			       SST_CLOS_CONFIG_MIN_START, SST_CLOS_CONFIG_MIN_WIDTH,
+			       SST_MUL_FACTOR_FREQ);
+		_write_cp_info("clos.max_freq", clos_param.max_freq_mhz,
+			       (SST_CLOS_CONFIG_0_OFFSET + clos_param.clos * SST_REG_SIZE),
+			       SST_CLOS_CONFIG_MAX_START, SST_CLOS_CONFIG_MAX_WIDTH,
+			       SST_MUL_FACTOR_FREQ);
+		_write_cp_info("clos.prio", clos_param.prop_prio,
+			       (SST_CLOS_CONFIG_0_OFFSET + clos_param.clos * SST_REG_SIZE),
+			       SST_CLOS_CONFIG_PRIO_START, SST_CLOS_CONFIG_PRIO_WIDTH,
+			       SST_MUL_FACTOR_NONE);
+	} else {
+		/* get */
+		_read_cp_info("clos.min_freq", clos_param.min_freq_mhz,
+				(SST_CLOS_CONFIG_0_OFFSET + clos_param.clos * SST_REG_SIZE),
+				SST_CLOS_CONFIG_MIN_START, SST_CLOS_CONFIG_MIN_WIDTH,
+				SST_MUL_FACTOR_FREQ)
+		_read_cp_info("clos.max_freq", clos_param.max_freq_mhz,
+				(SST_CLOS_CONFIG_0_OFFSET + clos_param.clos * SST_REG_SIZE),
+				SST_CLOS_CONFIG_MAX_START, SST_CLOS_CONFIG_MAX_WIDTH,
+				SST_MUL_FACTOR_FREQ)
+		_read_cp_info("clos.prio", clos_param.prop_prio,
+				(SST_CLOS_CONFIG_0_OFFSET + clos_param.clos * SST_REG_SIZE),
+				SST_CLOS_CONFIG_PRIO_START, SST_CLOS_CONFIG_PRIO_WIDTH,
+				SST_MUL_FACTOR_NONE)
+
+		if (copy_to_user(argp, &clos_param, sizeof(clos_param)))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+#define SST_CLOS_ASSOC_0_OFFSET		56
+#define SST_CLOS_ASSOC_CPUS_PER_REG	16
+#define SST_CLOS_ASSOC_BITS_PER_CPU	4
+
+static long isst_if_clos_assoc(void __user *argp)
+{
+	struct isst_if_clos_assoc_cmds assoc_cmds;
+	unsigned char __user *ptr;
+	int i;
+
+	/* Each multi command has u16 command count as the first field */
+	if (copy_from_user(&assoc_cmds, argp, sizeof(assoc_cmds)))
+		return -EFAULT;
+
+	if (!assoc_cmds.cmd_count || assoc_cmds.cmd_count > ISST_IF_CMD_LIMIT)
+		return -EINVAL;
+
+	ptr = argp + offsetof(struct isst_if_clos_assoc_cmds, assoc_info);
+	for (i = 0; i < assoc_cmds.cmd_count; ++i) {
+		struct tpmi_per_power_domain_info *power_domain_info;
+		struct isst_if_clos_assoc clos_assoc;
+		int punit_id, punit_cpu_no, pkg_id;
+		struct tpmi_sst_struct *sst_inst;
+		int offset, shift, cpu;
+		u64 val, mask, clos;
+
+		if (copy_from_user(&clos_assoc, ptr, sizeof(clos_assoc)))
+			return -EFAULT;
+
+		if (clos_assoc.socket_id > topology_max_packages())
+			return -EINVAL;
+
+		cpu = clos_assoc.logical_cpu;
+		clos = clos_assoc.clos;
+
+		if (assoc_cmds.punit_cpu_map)
+			punit_cpu_no = cpu;
+		else
+			return -EOPNOTSUPP;
+
+		if (punit_cpu_no < 0)
+			return -EINVAL;
+
+		punit_id = clos_assoc.power_domain_id;
+		pkg_id = clos_assoc.socket_id;
+
+		sst_inst = isst_common.sst_inst[pkg_id];
+
+		if (clos_assoc.power_domain_id > sst_inst->number_of_power_domains)
+			return -EINVAL;
+
+		power_domain_info = &sst_inst->power_domain_info[punit_id];
+
+		offset = SST_CLOS_ASSOC_0_OFFSET +
+				(punit_cpu_no / SST_CLOS_ASSOC_CPUS_PER_REG) * SST_REG_SIZE;
+		shift = punit_cpu_no % SST_CLOS_ASSOC_CPUS_PER_REG;
+		shift *= SST_CLOS_ASSOC_BITS_PER_CPU;
+
+		val = readq(power_domain_info->sst_base +
+				power_domain_info->sst_header.cp_offset + offset);
+		if (assoc_cmds.get_set) {
+			mask = GENMASK_ULL((shift + SST_CLOS_ASSOC_BITS_PER_CPU - 1), shift);
+			val &= ~mask;
+			val |= (clos << shift);
+			writeq(val, power_domain_info->sst_base +
+					power_domain_info->sst_header.cp_offset + offset);
+		} else {
+			val >>= shift;
+			clos_assoc.clos = val & GENMASK(SST_CLOS_ASSOC_BITS_PER_CPU - 1, 0);
+			if (copy_to_user(ptr, &clos_assoc, sizeof(clos_assoc)))
+				return -EFAULT;
+		}
+
+		ptr += sizeof(clos_assoc);
+	}
+
+	return 0;
+}
+
 static int isst_if_get_tpmi_instance_count(void __user *argp)
 {
 	struct isst_tpmi_instance_count tpmi_inst;
@@ -400,6 +655,15 @@ static long isst_if_def_ioctl(struct file *file, unsigned int cmd,
 	case ISST_IF_COUNT_TPMI_INSTANCES:
 		ret = isst_if_get_tpmi_instance_count(argp);
 		break;
+	case ISST_IF_CORE_POWER_STATE:
+		ret = isst_if_core_power_state(argp);
+		break;
+	case ISST_IF_CLOS_PARAM:
+		ret = isst_if_clos_param(argp);
+		break;
+	case ISST_IF_CLOS_ASSOC:
+		ret = isst_if_clos_assoc(argp);
+		break;
 	default:
 		break;
 	}
diff --git a/include/uapi/linux/isst_if.h b/include/uapi/linux/isst_if.h
index bf32d959f6e8..32687d8023ef 100644
--- a/include/uapi/linux/isst_if.h
+++ b/include/uapi/linux/isst_if.h
@@ -163,6 +163,82 @@ struct isst_if_msr_cmds {
 	struct isst_if_msr_cmd msr_cmd[1];
 };
 
+/**
+ * struct isst_core_power - Structure to get/set core_power feature
+ * @get_set:	0: Get, 1: Set
+ * @socket_id:	Socket/package id
+ * @power_domain: Power Domain id
+ * @enable:	Feature enable status
+ * @priority_type: Priority type for the feature (ordered/proportional)
+ *
+ * Structure to get/set core_power feature state using IOCTL
+ * ISST_IF_CORE_POWER_STATE.
+ */
+struct isst_core_power {
+	__u8 get_set;
+	__u8 socket_id;
+	__u8 power_domain_id;
+	__u8 enable;
+	__u8 supported;
+	__u8 priority_type;
+};
+
+/**
+ * struct isst_clos_param - Structure to get/set clos praram
+ * @get_set:	0: Get, 1: Set
+ * @socket_id:	Socket/package id
+ * @power_domain:	Power Domain id
+ * clos:	Clos ID for the parameters
+ * min_freq_mhz: Minimum frequency in MHz
+ * max_freq_mhz: Maximum frequency in MHz
+ * prop_prio:	Proportional priority from 0-15
+ *
+ * Structure to get/set per clos property using IOCTL
+ * ISST_IF_CLOS_PARAM.
+ */
+struct isst_clos_param {
+	__u8 get_set;
+	__u8 socket_id;
+	__u8 power_domain_id;
+	__u8 clos;
+	__u16 min_freq_mhz;
+	__u16 max_freq_mhz;
+	__u8 prop_prio;
+};
+
+/**
+ * struct isst_if_clos_assoc - Structure to assign clos to a CPU
+ * @socket_id:	Socket/package id
+ * @power_domain:	Power Domain id
+ * @logical_cpu: CPU number
+ * @clos:	Clos ID to assign to the logical CPU
+ *
+ * Structure to get/set core_power feature.
+ */
+struct isst_if_clos_assoc {
+	__u8 socket_id;
+	__u8 power_domain_id;
+	__u16 logical_cpu;
+	__u16 clos;
+};
+
+/**
+ * struct isst_if_clos_assoc_cmds - Structure to assign clos to CPUs
+ * @cmd_count:	Number of cmds (cpus) in this request
+ * @get_set:	Request is for get or set
+ * @punit_cpu_map: Set to 1 if the CPU number is punit numbering not
+ *		   Linux CPU number
+ *
+ * Structure used to get/set associate CPUs to clos using IOCTL
+ * ISST_IF_CLOS_ASSOC.
+ */
+struct isst_if_clos_assoc_cmds {
+	__u16 cmd_count;
+	__u16 get_set;
+	__u16 punit_cpu_map;
+	struct isst_if_clos_assoc assoc_info[1];
+};
+
 /**
  * struct isst_tpmi_instance_count - Get number of TPMI instances per socket
  * @socket_id:	Socket/package id
@@ -186,5 +262,8 @@ struct isst_tpmi_instance_count {
 #define ISST_IF_MSR_COMMAND	_IOWR(ISST_IF_MAGIC, 4, struct isst_if_msr_cmds *)
 
 #define ISST_IF_COUNT_TPMI_INSTANCES	_IOR(ISST_IF_MAGIC, 5, struct isst_tpmi_instance_count *)
+#define ISST_IF_CORE_POWER_STATE _IOWR(ISST_IF_MAGIC, 6, struct isst_core_power *)
+#define ISST_IF_CLOS_PARAM	_IOWR(ISST_IF_MAGIC, 7, struct isst_clos_param *)
+#define ISST_IF_CLOS_ASSOC	_IOWR(ISST_IF_MAGIC, 8, struct isst_if_clos_assoc_cmds *)
 
 #endif
-- 
2.39.1

