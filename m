Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85AD67FAB6
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 21:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbjA1UE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 15:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbjA1UEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 15:04:35 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEDA24C95
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 12:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674936272; x=1706472272;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bI2P09TdvF4QobqvKUgNTA4moZLxkUQuXaGLfxAsGtc=;
  b=f24Qge/KblmyBQAJdwrZIikVpI38PfYMbfkIjhGBSXtFQFn5LqrmmvPF
   KYkvdhC25YkapGJrzYMaTa5SyRGn+wM7BleuHdsv/kOUFr8tc1dRyRL2V
   rHWoTuI/TmsOAAG2eKoOOmEd//VVp65nGuHwim+WRDGmzV+/O8MhdZh3V
   PugNvoTm4DmGoddcp2Y1vLgOHsCfBr4/DY1DhpRABvZK4W4diUfTLx6JL
   UZ5CYWSE0OKvOn/hz/0pB3NuDCLrNx3iubdbm6PWaEa8qmtaHvuiagw2L
   sYBHXKEwlkrWd89uZuciPqcLnZRba23s0pCDiQcdlCVIc1PM29map8PEq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="325022512"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="325022512"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 12:04:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="909038372"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="909038372"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jan 2023 12:04:30 -0800
From:   kan.liang@linux.intel.com
To:     joro@8bytes.org, will@kernel.org, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, robin.murphy@arm.com, robert.moore@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     yu-cheng.yu@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 4/7] iommu/vt-d: Add IOMMU perfmon support
Date:   Sat, 28 Jan 2023 12:04:25 -0800
Message-Id: <20230128200428.1459118-5-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230128200428.1459118-1-kan.liang@linux.intel.com>
References: <20230128200428.1459118-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Implement the IOMMU performance monitor capability, which supports the
collection of information about key events occurring during operation of
the remapping hardware, to aid performance tuning and debug.

The IOMMU perfmon support is implemented as part of the IOMMU driver and
interfaces with the Linux perf subsystem.

The IOMMU PMU has the following unique features compared with the other
PMUs.
- Support counting. Not support sampling.
- Does not support per-thread counting. The scope is system-wide.
- Support per-counter capability register. The event constraints can be
  enumerated.
- The available event and event group can also be enumerated.
- Extra Enhanced Commands are introduced to control the counters.

Add a new variable, struct iommu_pmu *pmu, to in the struct intel_iommu
to track the PMU related information.

Add iommu_pmu_register() and iommu_pmu_unregister() to register and
unregister a IOMMU PMU. The register function setup the IOMMU PMU ops
and invoke the standard perf_pmu_register() interface to register a PMU
in the perf subsystem. This patch only exposes the functions. The
following patch will enable them in the IOMMU driver.

The IOMMU PMUs can be found under /sys/bus/event_source/devices/dmar*

The available filters and event format can be found at the format folder

 $ ls /sys/bus/event_source/devices/dmar1/format/
 event  event_group  filter_ats  filter_ats_en  filter_page_table
 filter_page_table_en

The supported events can be found at the events folder

 $ ls /sys/bus/event_source/devices/dmar1/events/
 ats_blocked        fs_nonleaf_hit           int_cache_hit_posted
 iommu_mem_blocked  iotlb_hit        pasid_cache_lookup  ss_nonleaf_hit
 ctxt_cache_hit     fs_nonleaf_lookup        int_cache_lookup
 iommu_mrds         iotlb_lookup     pg_req_posted    ss_nonleaf_lookup
 ctxt_cache_lookup  int_cache_hit_nonposted  iommu_clocks
 iommu_requests     pasid_cache_hit  pw_occupancy

The command below illustrates filter usage with a simple example.

 $ perf stat -e dmar1/iommu_requests,filter_ats_en=0x1,filter_ats=0x1/
   -a sleep 1

 Performance counter stats for 'system wide':

   368,947      dmar1/iommu_requests,filter_ats_en=0x1,filter_ats=0x1/

 1.002592074 seconds time elapsed

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 .../sysfs-bus-event_source-devices-iommu      |  29 +
 drivers/iommu/intel/iommu.h                   |  15 +
 drivers/iommu/intel/perfmon.c                 | 526 ++++++++++++++++++
 drivers/iommu/intel/perfmon.h                 |  24 +
 4 files changed, 594 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-iommu

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-iommu b/Documentation/ABI/testing/sysfs-bus-event_source-devices-iommu
new file mode 100644
index 000000000000..988210a0e8ce
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-iommu
@@ -0,0 +1,29 @@
+What:		/sys/bus/event_source/devices/dmar*/format
+Date:		Jan 2023
+KernelVersion:  6.3
+Contact:	Kan Liang <kan.liang@linux.intel.com>
+Description:	Read-only.  Attribute group to describe the magic bits
+		that go into perf_event_attr.config,
+		perf_event_attr.config1 or perf_event_attr.config2 for
+		the IOMMU pmu.  (See also
+		ABI/testing/sysfs-bus-event_source-devices-format).
+
+		Each attribute in this group defines a bit range in
+		perf_event_attr.config, perf_event_attr.config1,
+		or perf_event_attr.config2. All supported attributes
+		are listed below (See the VT-d Spec 4.0 for possible
+		attribute values)::
+
+		    event		= "config:0-27"   - event ID
+		    event_group		= "config:28-31"  - event group ID
+
+		    filter_requester_en	= "config1:0"     - Enable Requester ID filter
+		    filter_domain_en	= "config1:1"     - Enable Domain ID filter
+		    filter_pasid_en	= "config1:2"     - Enable PASID filter
+		    filter_ats_en	= "config1:3"     - Enable Address Type filter
+		    filter_page_table_en= "config1:4"     - Enable Page Table Level filter
+		    filter_requester_id	= "config1:16-31" - Requester ID filter
+		    filter_domain	= "config1:32-47" - Domain ID filter
+		    filter_pasid	= "config2:0-21"  - PASID filter
+		    filter_ats		= "config2:24-28" - Address Type filter
+		    filter_page_table	= "config2:32-36" - Page Table Level filter
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index f918e83bf91c..d56b3c386366 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -22,6 +22,7 @@
 #include <linux/ioasid.h>
 #include <linux/bitfield.h>
 #include <linux/xarray.h>
+#include <linux/perf_event.h>
 
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
@@ -606,6 +607,16 @@ struct dmar_domain {
 					   iommu core */
 };
 
+/*
+ * In theory, the VT-d 4.0 spec can support up to 2 ^ 16 counters.
+ * But in practice, there are only 14 counters for the existing
+ * platform. Setting the max number of counters to 64 should be good
+ * enough for a long time. Also, supporting more than 64 counters
+ * requires more extras, e.g., extra freeze and overflow registers,
+ * which is not necessary for now.
+ */
+#define IOMMU_PMU_IDX_MAX		64
+
 struct iommu_pmu {
 	struct intel_iommu	*iommu;
 	u32			num_cntr;	/* Number of counters */
@@ -620,6 +631,10 @@ struct iommu_pmu {
 
 	u64			*evcap;		/* Indicates all supported events */
 	u32			**cntr_evcap;	/* Supported events of each counter. */
+
+	struct pmu		pmu;
+	DECLARE_BITMAP(used_mask, IOMMU_PMU_IDX_MAX);
+	struct perf_event	*event_list[IOMMU_PMU_IDX_MAX];
 };
 
 struct intel_iommu {
diff --git a/drivers/iommu/intel/perfmon.c b/drivers/iommu/intel/perfmon.c
index db5791a54455..df9b78736462 100644
--- a/drivers/iommu/intel/perfmon.c
+++ b/drivers/iommu/intel/perfmon.c
@@ -10,6 +10,504 @@
 #include "iommu.h"
 #include "perfmon.h"
 
+PMU_FORMAT_ATTR(event,		"config:0-27");		/* ES: Events Select */
+PMU_FORMAT_ATTR(event_group,	"config:28-31");	/* EGI: Event Group Index */
+
+static struct attribute *iommu_pmu_format_attrs[] = {
+	&format_attr_event_group.attr,
+	&format_attr_event.attr,
+	NULL
+};
+
+static struct attribute_group iommu_pmu_format_attr_group = {
+	.name = "format",
+	.attrs = iommu_pmu_format_attrs,
+};
+
+/* The available events are added in attr_update later */
+static struct attribute *attrs_empty[] = {
+	NULL
+};
+
+static struct attribute_group iommu_pmu_events_attr_group = {
+	.name = "events",
+	.attrs = attrs_empty,
+};
+
+static const struct attribute_group *iommu_pmu_attr_groups[] = {
+	&iommu_pmu_format_attr_group,
+	&iommu_pmu_events_attr_group,
+	NULL
+};
+
+static inline struct iommu_pmu *dev_to_iommu_pmu(struct device *dev)
+{
+	/*
+	 * The perf_event creates its own dev for each PMU.
+	 * See pmu_dev_alloc()
+	 */
+	return container_of(dev_get_drvdata(dev), struct iommu_pmu, pmu);
+}
+
+#define IOMMU_PMU_ATTR(_name, _format, _filter)				\
+	PMU_FORMAT_ATTR(_name, _format);				\
+									\
+static struct attribute *_name##_attr[] = {				\
+	&format_attr_##_name.attr,					\
+	NULL								\
+};									\
+									\
+static umode_t								\
+_name##_is_visible(struct kobject *kobj, struct attribute *attr, int i)	\
+{									\
+	struct device *dev = kobj_to_dev(kobj);				\
+	struct iommu_pmu *iommu_pmu = dev_to_iommu_pmu(dev);		\
+									\
+	if (!iommu_pmu)							\
+		return 0;						\
+	return (iommu_pmu->filter & _filter) ? attr->mode : 0;		\
+}									\
+									\
+static struct attribute_group _name = {					\
+	.name		= "format",					\
+	.attrs		= _name##_attr,					\
+	.is_visible	= _name##_is_visible,				\
+};
+
+IOMMU_PMU_ATTR(filter_requester_id_en,	"config1:0",		IOMMU_PMU_FILTER_REQUESTER_ID);
+IOMMU_PMU_ATTR(filter_domain_en,	"config1:1",		IOMMU_PMU_FILTER_DOMAIN);
+IOMMU_PMU_ATTR(filter_pasid_en,		"config1:2",		IOMMU_PMU_FILTER_PASID);
+IOMMU_PMU_ATTR(filter_ats_en,		"config1:3",		IOMMU_PMU_FILTER_ATS);
+IOMMU_PMU_ATTR(filter_page_table_en,	"config1:4",		IOMMU_PMU_FILTER_PAGE_TABLE);
+IOMMU_PMU_ATTR(filter_requester_id,	"config1:16-31",	IOMMU_PMU_FILTER_REQUESTER_ID);
+IOMMU_PMU_ATTR(filter_domain,		"config1:32-47",	IOMMU_PMU_FILTER_DOMAIN);
+IOMMU_PMU_ATTR(filter_pasid,		"config2:0-21",		IOMMU_PMU_FILTER_PASID);
+IOMMU_PMU_ATTR(filter_ats,		"config2:24-28",	IOMMU_PMU_FILTER_ATS);
+IOMMU_PMU_ATTR(filter_page_table,	"config2:32-36",	IOMMU_PMU_FILTER_PAGE_TABLE);
+
+#define iommu_pmu_en_requester_id(e)		((e) & 0x1)
+#define iommu_pmu_en_domain(e)			(((e) >> 1) & 0x1)
+#define iommu_pmu_en_pasid(e)			(((e) >> 2) & 0x1)
+#define iommu_pmu_en_ats(e)			(((e) >> 3) & 0x1)
+#define iommu_pmu_en_page_table(e)		(((e) >> 4) & 0x1)
+#define iommu_pmu_get_requester_id(filter)	(((filter) >> 16) & 0xffff)
+#define iommu_pmu_get_domain(filter)		(((filter) >> 32) & 0xffff)
+#define iommu_pmu_get_pasid(filter)		((filter) & 0x3fffff)
+#define iommu_pmu_get_ats(filter)		(((filter) >> 24) & 0x1f)
+#define iommu_pmu_get_page_table(filter)	(((filter) >> 32) & 0x1f)
+
+#define iommu_pmu_set_filter(_name, _config, _filter, _idx, _econfig)		\
+{										\
+	if ((iommu_pmu->filter & _filter) && iommu_pmu_en_##_name(_econfig)) {	\
+		dmar_writel(iommu_pmu->cfg_reg + _idx * IOMMU_PMU_CFG_OFFSET +	\
+			    IOMMU_PMU_CFG_SIZE +				\
+			    (ffs(_filter) - 1) * IOMMU_PMU_CFG_FILTERS_OFFSET,	\
+			    iommu_pmu_get_##_name(_config) | IOMMU_PMU_FILTER_EN);\
+	}									\
+}
+
+#define iommu_pmu_clear_filter(_filter, _idx)					\
+{										\
+	if (iommu_pmu->filter & _filter) {					\
+		dmar_writel(iommu_pmu->cfg_reg + _idx * IOMMU_PMU_CFG_OFFSET +	\
+			    IOMMU_PMU_CFG_SIZE +				\
+			    (ffs(_filter) - 1) * IOMMU_PMU_CFG_FILTERS_OFFSET,	\
+			    0);							\
+	}									\
+}
+
+/*
+ * Define the event attr related functions
+ * Input: _name: event attr name
+ *        _string: string of the event in sysfs
+ *        _g_idx: event group encoding
+ *        _event: event encoding
+ */
+#define IOMMU_PMU_EVENT_ATTR(_name, _string, _g_idx, _event)			\
+	PMU_EVENT_ATTR_STRING(_name, event_attr_##_name, _string)		\
+										\
+static struct attribute *_name##_attr[] = {					\
+	&event_attr_##_name.attr.attr,						\
+	NULL									\
+};										\
+										\
+static umode_t									\
+_name##_is_visible(struct kobject *kobj, struct attribute *attr, int i)		\
+{										\
+	struct device *dev = kobj_to_dev(kobj);					\
+	struct iommu_pmu *iommu_pmu = dev_to_iommu_pmu(dev);			\
+										\
+	if (!iommu_pmu)								\
+		return 0;							\
+	return (iommu_pmu->evcap[_g_idx] & _event) ? attr->mode : 0;		\
+}										\
+										\
+static struct attribute_group _name = {						\
+	.name		= "events",						\
+	.attrs		= _name##_attr,						\
+	.is_visible	= _name##_is_visible,					\
+};
+
+IOMMU_PMU_EVENT_ATTR(iommu_clocks,		"event_group=0x0,event=0x001", 0x0, 0x001)
+IOMMU_PMU_EVENT_ATTR(iommu_requests,		"event_group=0x0,event=0x002", 0x0, 0x002)
+IOMMU_PMU_EVENT_ATTR(pw_occupancy,		"event_group=0x0,event=0x004", 0x0, 0x004)
+IOMMU_PMU_EVENT_ATTR(ats_blocked,		"event_group=0x0,event=0x008", 0x0, 0x008)
+IOMMU_PMU_EVENT_ATTR(iommu_mrds,		"event_group=0x1,event=0x001", 0x1, 0x001)
+IOMMU_PMU_EVENT_ATTR(iommu_mem_blocked,		"event_group=0x1,event=0x020", 0x1, 0x020)
+IOMMU_PMU_EVENT_ATTR(pg_req_posted,		"event_group=0x1,event=0x040", 0x1, 0x040)
+IOMMU_PMU_EVENT_ATTR(ctxt_cache_lookup,		"event_group=0x2,event=0x001", 0x2, 0x001)
+IOMMU_PMU_EVENT_ATTR(ctxt_cache_hit,		"event_group=0x2,event=0x002", 0x2, 0x002)
+IOMMU_PMU_EVENT_ATTR(pasid_cache_lookup,	"event_group=0x2,event=0x004", 0x2, 0x004)
+IOMMU_PMU_EVENT_ATTR(pasid_cache_hit,		"event_group=0x2,event=0x008", 0x2, 0x008)
+IOMMU_PMU_EVENT_ATTR(ss_nonleaf_lookup,		"event_group=0x2,event=0x010", 0x2, 0x010)
+IOMMU_PMU_EVENT_ATTR(ss_nonleaf_hit,		"event_group=0x2,event=0x020", 0x2, 0x020)
+IOMMU_PMU_EVENT_ATTR(fs_nonleaf_lookup,		"event_group=0x2,event=0x040", 0x2, 0x040)
+IOMMU_PMU_EVENT_ATTR(fs_nonleaf_hit,		"event_group=0x2,event=0x080", 0x2, 0x080)
+IOMMU_PMU_EVENT_ATTR(hpt_nonleaf_lookup,	"event_group=0x2,event=0x100", 0x2, 0x100)
+IOMMU_PMU_EVENT_ATTR(hpt_nonleaf_hit,		"event_group=0x2,event=0x200", 0x2, 0x200)
+IOMMU_PMU_EVENT_ATTR(iotlb_lookup,		"event_group=0x3,event=0x001", 0x3, 0x001)
+IOMMU_PMU_EVENT_ATTR(iotlb_hit,			"event_group=0x3,event=0x002", 0x3, 0x002)
+IOMMU_PMU_EVENT_ATTR(hpt_leaf_lookup,		"event_group=0x3,event=0x004", 0x3, 0x004)
+IOMMU_PMU_EVENT_ATTR(hpt_leaf_hit,		"event_group=0x3,event=0x008", 0x3, 0x008)
+IOMMU_PMU_EVENT_ATTR(int_cache_lookup,		"event_group=0x4,event=0x001", 0x4, 0x001)
+IOMMU_PMU_EVENT_ATTR(int_cache_hit_nonposted,	"event_group=0x4,event=0x002", 0x4, 0x002)
+IOMMU_PMU_EVENT_ATTR(int_cache_hit_posted,	"event_group=0x4,event=0x004", 0x4, 0x004)
+
+static const struct attribute_group *iommu_pmu_attr_update[] = {
+	&filter_requester_id_en,
+	&filter_domain_en,
+	&filter_pasid_en,
+	&filter_ats_en,
+	&filter_page_table_en,
+	&filter_requester_id,
+	&filter_domain,
+	&filter_pasid,
+	&filter_ats,
+	&filter_page_table,
+	&iommu_clocks,
+	&iommu_requests,
+	&pw_occupancy,
+	&ats_blocked,
+	&iommu_mrds,
+	&iommu_mem_blocked,
+	&pg_req_posted,
+	&ctxt_cache_lookup,
+	&ctxt_cache_hit,
+	&pasid_cache_lookup,
+	&pasid_cache_hit,
+	&ss_nonleaf_lookup,
+	&ss_nonleaf_hit,
+	&fs_nonleaf_lookup,
+	&fs_nonleaf_hit,
+	&hpt_nonleaf_lookup,
+	&hpt_nonleaf_hit,
+	&iotlb_lookup,
+	&iotlb_hit,
+	&hpt_leaf_lookup,
+	&hpt_leaf_hit,
+	&int_cache_lookup,
+	&int_cache_hit_nonposted,
+	&int_cache_hit_posted,
+	NULL
+};
+
+static inline void __iomem *
+iommu_event_base(struct iommu_pmu *iommu_pmu, int idx)
+{
+	return iommu_pmu->cntr_reg + idx * iommu_pmu->cntr_stride;
+}
+
+static inline void __iomem *
+iommu_config_base(struct iommu_pmu *iommu_pmu, int idx)
+{
+	return iommu_pmu->cfg_reg + idx * IOMMU_PMU_CFG_OFFSET;
+}
+
+static inline struct iommu_pmu *iommu_event_to_pmu(struct perf_event *event)
+{
+	return container_of(event->pmu, struct iommu_pmu, pmu);
+}
+
+static inline u64 iommu_event_config(struct perf_event *event)
+{
+	u64 config = event->attr.config;
+
+	return (iommu_event_select(config) << IOMMU_EVENT_CFG_ES_SHIFT) |
+	       (iommu_event_group(config) << IOMMU_EVENT_CFG_EGI_SHIFT) |
+	       IOMMU_EVENT_CFG_INT;
+}
+
+static inline bool is_iommu_pmu_event(struct iommu_pmu *iommu_pmu,
+				      struct perf_event *event)
+{
+	return event->pmu == &iommu_pmu->pmu;
+}
+
+static int iommu_pmu_validate_event(struct perf_event *event)
+{
+	struct iommu_pmu *iommu_pmu = iommu_event_to_pmu(event);
+	u32 event_group = iommu_event_group(event->attr.config);
+
+	if (event_group >= iommu_pmu->num_eg)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int iommu_pmu_validate_group(struct perf_event *event)
+{
+	struct iommu_pmu *iommu_pmu = iommu_event_to_pmu(event);
+	struct perf_event *sibling;
+	int nr = 0;
+
+	/*
+	 * All events in a group must be scheduled simultaneously.
+	 * Check whether there is enough counters for all the events.
+	 */
+	for_each_sibling_event(sibling, event->group_leader) {
+		if (!is_iommu_pmu_event(iommu_pmu, sibling) ||
+		    sibling->state <= PERF_EVENT_STATE_OFF)
+			continue;
+
+		if (++nr > iommu_pmu->num_cntr)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int iommu_pmu_event_init(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	/* sampling not supported */
+	if (event->attr.sample_period)
+		return -EINVAL;
+
+	if (event->cpu < 0)
+		return -EINVAL;
+
+	if (iommu_pmu_validate_event(event))
+		return -EINVAL;
+
+	hwc->config = iommu_event_config(event);
+
+	return iommu_pmu_validate_group(event);
+}
+
+static void iommu_pmu_event_update(struct perf_event *event)
+{
+	struct iommu_pmu *iommu_pmu = iommu_event_to_pmu(event);
+	struct hw_perf_event *hwc = &event->hw;
+	u64 prev_count, new_count, delta;
+	int shift = 64 - iommu_pmu->cntr_width;
+
+again:
+	prev_count = local64_read(&hwc->prev_count);
+	new_count = dmar_readq(iommu_event_base(iommu_pmu, hwc->idx));
+	if (local64_xchg(&hwc->prev_count, new_count) != prev_count)
+		goto again;
+
+	/*
+	 * The counter width is enumerated. Always shift the counter
+	 * before using it.
+	 */
+	delta = (new_count << shift) - (prev_count << shift);
+	delta >>= shift;
+
+	local64_add(delta, &event->count);
+}
+
+static void iommu_pmu_start(struct perf_event *event, int flags)
+{
+	struct iommu_pmu *iommu_pmu = iommu_event_to_pmu(event);
+	struct intel_iommu *iommu = iommu_pmu->iommu;
+	struct hw_perf_event *hwc = &event->hw;
+	u64 count;
+
+	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
+		return;
+
+	if (WARN_ON_ONCE(hwc->idx < 0 || hwc->idx >= IOMMU_PMU_IDX_MAX))
+		return;
+
+	if (flags & PERF_EF_RELOAD)
+		WARN_ON_ONCE(!(event->hw.state & PERF_HES_UPTODATE));
+
+	hwc->state = 0;
+
+	/* Always reprogram the period */
+	count = dmar_readq(iommu_event_base(iommu_pmu, hwc->idx));
+	local64_set((&hwc->prev_count), count);
+
+	/*
+	 * The error of ecmd will be ignored.
+	 * - The existing perf_event subsystem doesn't handle the error.
+	 *   Only IOMMU PMU returns runtime HW error. We don't want to
+	 *   change the existing generic interfaces for the specific case.
+	 * - It's a corner case caused by HW, which is very unlikely to
+	 *   happen. There is nothing SW can do.
+	 * - The worst case is that the user will get <not count> with
+	 *   perf command, which can give the user some hints.
+	 */
+	ecmd_submit_sync(iommu, DMA_ECMD_ENABLE, hwc->idx, 0);
+
+	perf_event_update_userpage(event);
+}
+
+static void iommu_pmu_stop(struct perf_event *event, int flags)
+{
+	struct iommu_pmu *iommu_pmu = iommu_event_to_pmu(event);
+	struct intel_iommu *iommu = iommu_pmu->iommu;
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (!(hwc->state & PERF_HES_STOPPED)) {
+		ecmd_submit_sync(iommu, DMA_ECMD_DISABLE, hwc->idx, 0);
+
+		iommu_pmu_event_update(event);
+
+		hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
+	}
+}
+
+static inline int
+iommu_pmu_validate_per_cntr_event(struct iommu_pmu *iommu_pmu,
+				  int idx, struct perf_event *event)
+{
+	u32 event_group = iommu_event_group(event->attr.config);
+	u32 select = iommu_event_select(event->attr.config);
+
+	if (!(iommu_pmu->cntr_evcap[idx][event_group] & select))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int iommu_pmu_assign_event(struct iommu_pmu *iommu_pmu,
+				  struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	int idx;
+
+	/*
+	 * The counters which support limited events are usually at the end.
+	 * Schedule them first to accommodate more events.
+	 */
+	for (idx = iommu_pmu->num_cntr - 1; idx >= 0; idx--) {
+		if (test_and_set_bit(idx, iommu_pmu->used_mask))
+			continue;
+		/* Check per-counter event capabilities */
+		if (!iommu_pmu_validate_per_cntr_event(iommu_pmu, idx, event))
+			break;
+		clear_bit(idx, iommu_pmu->used_mask);
+	}
+	if (idx < 0)
+		return -EINVAL;
+
+	iommu_pmu->event_list[idx] = event;
+	hwc->idx = idx;
+
+	/* config events */
+	dmar_writeq(iommu_config_base(iommu_pmu, idx), hwc->config);
+
+	iommu_pmu_set_filter(requester_id, event->attr.config1,
+			     IOMMU_PMU_FILTER_REQUESTER_ID, idx,
+			     event->attr.config1);
+	iommu_pmu_set_filter(domain, event->attr.config1,
+			     IOMMU_PMU_FILTER_DOMAIN, idx,
+			     event->attr.config1);
+	iommu_pmu_set_filter(pasid, event->attr.config1,
+			     IOMMU_PMU_FILTER_PASID, idx,
+			     event->attr.config1);
+	iommu_pmu_set_filter(ats, event->attr.config2,
+			     IOMMU_PMU_FILTER_ATS, idx,
+			     event->attr.config1);
+	iommu_pmu_set_filter(page_table, event->attr.config2,
+			     IOMMU_PMU_FILTER_PAGE_TABLE, idx,
+			     event->attr.config1);
+
+	return 0;
+}
+
+static int iommu_pmu_add(struct perf_event *event, int flags)
+{
+	struct iommu_pmu *iommu_pmu = iommu_event_to_pmu(event);
+	struct hw_perf_event *hwc = &event->hw;
+	int ret;
+
+	ret = iommu_pmu_assign_event(iommu_pmu, event);
+	if (ret < 0)
+		return ret;
+
+	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
+
+	if (flags & PERF_EF_START)
+		iommu_pmu_start(event, 0);
+
+	return 0;
+}
+
+static void iommu_pmu_del(struct perf_event *event, int flags)
+{
+	struct iommu_pmu *iommu_pmu = iommu_event_to_pmu(event);
+	int idx = event->hw.idx;
+
+	iommu_pmu_stop(event, PERF_EF_UPDATE);
+
+	iommu_pmu_clear_filter(IOMMU_PMU_FILTER_REQUESTER_ID, idx);
+	iommu_pmu_clear_filter(IOMMU_PMU_FILTER_DOMAIN, idx);
+	iommu_pmu_clear_filter(IOMMU_PMU_FILTER_PASID, idx);
+	iommu_pmu_clear_filter(IOMMU_PMU_FILTER_ATS, idx);
+	iommu_pmu_clear_filter(IOMMU_PMU_FILTER_PAGE_TABLE, idx);
+
+	iommu_pmu->event_list[idx] = NULL;
+	event->hw.idx = -1;
+	clear_bit(idx, iommu_pmu->used_mask);
+
+	perf_event_update_userpage(event);
+}
+
+static void iommu_pmu_enable(struct pmu *pmu)
+{
+	struct iommu_pmu *iommu_pmu = container_of(pmu, struct iommu_pmu, pmu);
+	struct intel_iommu *iommu = iommu_pmu->iommu;
+
+	ecmd_submit_sync(iommu, DMA_ECMD_UNFREEZE, 0, 0);
+}
+
+static void iommu_pmu_disable(struct pmu *pmu)
+{
+	struct iommu_pmu *iommu_pmu = container_of(pmu, struct iommu_pmu, pmu);
+	struct intel_iommu *iommu = iommu_pmu->iommu;
+
+	ecmd_submit_sync(iommu, DMA_ECMD_FREEZE, 0, 0);
+}
+
+static int __iommu_pmu_register(struct intel_iommu *iommu)
+{
+	struct iommu_pmu *iommu_pmu = iommu->pmu;
+
+	iommu_pmu->pmu.name		= iommu->name;
+	iommu_pmu->pmu.task_ctx_nr	= perf_invalid_context;
+	iommu_pmu->pmu.event_init	= iommu_pmu_event_init;
+	iommu_pmu->pmu.pmu_enable	= iommu_pmu_enable;
+	iommu_pmu->pmu.pmu_disable	= iommu_pmu_disable;
+	iommu_pmu->pmu.add		= iommu_pmu_add;
+	iommu_pmu->pmu.del		= iommu_pmu_del;
+	iommu_pmu->pmu.start		= iommu_pmu_start;
+	iommu_pmu->pmu.stop		= iommu_pmu_stop;
+	iommu_pmu->pmu.read		= iommu_pmu_event_update;
+	iommu_pmu->pmu.attr_groups	= iommu_pmu_attr_groups;
+	iommu_pmu->pmu.attr_update	= iommu_pmu_attr_update;
+	iommu_pmu->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
+	iommu_pmu->pmu.module		= THIS_MODULE;
+
+	return perf_pmu_register(&iommu_pmu->pmu, iommu_pmu->pmu.name, -1);
+}
+
 static inline void __iomem *
 get_perf_reg_address(struct intel_iommu *iommu, u32 offset)
 {
@@ -45,11 +543,21 @@ int alloc_iommu_pmu(struct intel_iommu *iommu)
 	if (!pcap_interrupt(perfcap))
 		return -ENODEV;
 
+	/* Check required Enhanced Command Capability */
+	if (!ecmd_has_pmu_essential(iommu))
+		return -ENODEV;
+
 	iommu_pmu = kzalloc(sizeof(*iommu_pmu), GFP_KERNEL);
 	if (!iommu_pmu)
 		return -ENOMEM;
 
 	iommu_pmu->num_cntr = pcap_num_cntr(perfcap);
+	if (iommu_pmu->num_cntr > IOMMU_PMU_IDX_MAX) {
+		pr_warn_once("The number of IOMMU counters %d > max(%d), clipping!",
+			     iommu_pmu->num_cntr, IOMMU_PMU_IDX_MAX);
+		iommu_pmu->num_cntr = IOMMU_PMU_IDX_MAX;
+	}
+
 	iommu_pmu->cntr_width = pcap_cntr_width(perfcap);
 	iommu_pmu->filter = pcap_filters_mask(perfcap);
 	iommu_pmu->cntr_stride = pcap_cntr_stride(perfcap);
@@ -170,3 +678,21 @@ void free_iommu_pmu(struct intel_iommu *iommu)
 	kfree(iommu_pmu);
 	iommu->pmu = NULL;
 }
+
+void iommu_pmu_register(struct intel_iommu *iommu)
+{
+	if (!iommu->pmu)
+		return;
+
+	if (__iommu_pmu_register(iommu)) {
+		pr_err("Failed to register PMU for iommu (seq_id = %d)\n",
+		       iommu->seq_id);
+		free_iommu_pmu(iommu);
+	}
+}
+
+void iommu_pmu_unregister(struct intel_iommu *iommu)
+{
+	if (iommu->pmu)
+		perf_pmu_unregister(&iommu->pmu->pmu);
+}
diff --git a/drivers/iommu/intel/perfmon.h b/drivers/iommu/intel/perfmon.h
index 4b0d9c1fea6f..58606af9a2b9 100644
--- a/drivers/iommu/intel/perfmon.h
+++ b/drivers/iommu/intel/perfmon.h
@@ -7,6 +7,14 @@
 #define IOMMU_PMU_NUM_OFF_REGS			4
 #define IOMMU_PMU_OFF_REGS_STEP			4
 
+#define IOMMU_PMU_FILTER_REQUESTER_ID		0x01
+#define IOMMU_PMU_FILTER_DOMAIN			0x02
+#define IOMMU_PMU_FILTER_PASID			0x04
+#define IOMMU_PMU_FILTER_ATS			0x08
+#define IOMMU_PMU_FILTER_PAGE_TABLE		0x10
+
+#define IOMMU_PMU_FILTER_EN			BIT(31)
+
 #define IOMMU_PMU_CFG_OFFSET			0x100
 #define IOMMU_PMU_CFG_CNTRCAP_OFFSET		0x80
 #define IOMMU_PMU_CFG_CNTREVCAP_OFFSET		0x84
@@ -20,12 +28,18 @@
 #define iommu_cntrcap_ios(p)			(((p) >> 16) & 0x1)
 #define iommu_cntrcap_egcnt(p)			(((p) >> 28) & 0xf)
 
+#define IOMMU_EVENT_CFG_EGI_SHIFT		8
+#define IOMMU_EVENT_CFG_ES_SHIFT		32
+#define IOMMU_EVENT_CFG_INT			BIT_ULL(1)
+
 #define iommu_event_select(p)			((p) & 0xfffffff)
 #define iommu_event_group(p)			(((p) >> 28) & 0xf)
 
 #ifdef CONFIG_INTEL_IOMMU_PERF_EVENTS
 int alloc_iommu_pmu(struct intel_iommu *iommu);
 void free_iommu_pmu(struct intel_iommu *iommu);
+void iommu_pmu_register(struct intel_iommu *iommu);
+void iommu_pmu_unregister(struct intel_iommu *iommu);
 #else
 static inline int
 alloc_iommu_pmu(struct intel_iommu *iommu)
@@ -37,4 +51,14 @@ static inline void
 free_iommu_pmu(struct intel_iommu *iommu)
 {
 }
+
+static inline void
+iommu_pmu_register(struct intel_iommu *iommu)
+{
+}
+
+static inline void
+iommu_pmu_unregister(struct intel_iommu *iommu)
+{
+}
 #endif /* CONFIG_INTEL_IOMMU_PERF_EVENTS */
-- 
2.35.1

