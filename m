Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B24374D16E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbjGJJ2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjGJJ1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:27:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06200E7;
        Mon, 10 Jul 2023 02:27:54 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36A9HpX7025086;
        Mon, 10 Jul 2023 09:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=YULcbSwpjyO+H3kbi8t3N4kNzpO2/EmaTYtOYPKcrnM=;
 b=ehS7MECawqOKBwGTtS/VHM3JnUd4/HxAplPNgKcMtQRo7+Urj0TeBoViguP4zU050Fa6
 FlIoziJBmmcYg5kL99o0zMRXsztwlyUn2wWL2YXHABYFwCtkJ0R0yDvm131W3VQgR0yp
 HBR9FATjPipHnZP7njCOEsSckG4612HqkSMhELepKtl40OpMC156GYvjHkDRMuRoP/rD
 40ZJESwiD2g49pWDTRYTSNBf6HlmhaLVoqXWPv2Y8YJD3DfXyl1PjkUP8ZiI9k58U7Vv
 ZmY1v1vKQ/5H+8nqo0vHBTe+zJCqGvZTfYnQ3AQWuJoL38w6kZIGAPUntuTgMI00MQ91 Sg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rrf7r072g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 09:27:49 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36A5tqbY003254;
        Mon, 10 Jul 2023 09:27:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rpye5954c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 09:27:46 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36A9RhIT47579494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 09:27:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51BE020043;
        Mon, 10 Jul 2023 09:27:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34FCA2004D;
        Mon, 10 Jul 2023 09:27:41 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.43.85.154])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 10 Jul 2023 09:27:40 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, disgoel@linux.ibm.com,
        kjain@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/10] powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show processor config information
Date:   Mon, 10 Jul 2023 14:57:10 +0530
Message-Id: <20230710092717.55317-4-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230710092717.55317-1-kjain@linux.ibm.com>
References: <20230710092717.55317-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -9KIlTaBgGtGjotk3R-J5BlX4Dx1jJOz
X-Proofpoint-ORIG-GUID: -9KIlTaBgGtGjotk3R-J5BlX4Dx1jJOz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_07,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307100082
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hcall H_GET_PERF_COUNTER_INFO with counter request value as
PROCESSOR_CONFIG(0X90), can be used to get the system
processor configuration information. To expose the system
processor config information, patch adds sysfs file called
"processor_config" to the "/sys/devices/hv_gpci/interface/"
of hv_gpci pmu driver.

Add enum and sysinfo_counter_request array to get required
counter request value in hv-gpci.c file.
Also add a new function called "sysinfo_device_attr_create",
which will create and return required device attribute to the
add_sysinfo_interface_files function.

The processor_config sysfs file is only available for power10
and above platforms. Add a new macro called
INTERFACE_PROCESSOR_CONFIG_ATTR, which points to the index of
NULL placefolder, for processor_config attribute in the interface_attrs
array. Also add macro INTERFACE_NULL_ATTR which points to index of NULL
attribute in interface_attrs array.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 arch/powerpc/perf/hv-gpci.c | 168 ++++++++++++++++++++++++++++++++----
 1 file changed, 153 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/perf/hv-gpci.c b/arch/powerpc/perf/hv-gpci.c
index 225f148f75fd..c74076d3c7a7 100644
--- a/arch/powerpc/perf/hv-gpci.c
+++ b/arch/powerpc/perf/hv-gpci.c
@@ -102,11 +102,21 @@ static ssize_t cpumask_show(struct device *dev,
 	return cpumap_print_to_pagebuf(true, buf, &hv_gpci_cpumask);
 }
 
-/* Counter request value to retrieve system information */
-#define PROCESSOR_BUS_TOPOLOGY 0XD0
-
 /* Interface attribute array index to store system information */
 #define INTERFACE_PROCESSOR_BUS_TOPOLOGY_ATTR	6
+#define INTERFACE_PROCESSOR_CONFIG_ATTR		7
+#define INTERFACE_NULL_ATTR			8
+
+/* Counter request value to retrieve system information */
+enum {
+	PROCESSOR_BUS_TOPOLOGY,
+	PROCESSOR_CONFIG
+};
+
+static int sysinfo_counter_request[] = {
+	[PROCESSOR_BUS_TOPOLOGY] = 0xD0,
+	[PROCESSOR_CONFIG] = 0x90,
+};
 
 static DEFINE_PER_CPU(char, hv_gpci_reqb[HGPCI_REQ_BUFFER_SIZE]) __aligned(sizeof(uint64_t));
 
@@ -187,7 +197,8 @@ static ssize_t processor_bus_topology_show(struct device *dev, struct device_att
 	 * starting_index value implies the starting hardware
 	 * chip id.
 	 */
-	ret = systeminfo_gpci_request(PROCESSOR_BUS_TOPOLOGY, 0, 0, buf, &n, arg);
+	ret = systeminfo_gpci_request(sysinfo_counter_request[PROCESSOR_BUS_TOPOLOGY],
+			0, 0, buf, &n, arg);
 
 	if (!ret)
 		return n;
@@ -220,8 +231,76 @@ static ssize_t processor_bus_topology_show(struct device *dev, struct device_att
 
 		memset(arg, 0, HGPCI_REQ_BUFFER_SIZE);
 
-		ret = systeminfo_gpci_request(PROCESSOR_BUS_TOPOLOGY, starting_index,
-				0, buf, &n, arg);
+		ret = systeminfo_gpci_request(sysinfo_counter_request[PROCESSOR_BUS_TOPOLOGY],
+				starting_index, 0, buf, &n, arg);
+
+		if (!ret)
+			return n;
+
+		if (ret != H_PARAMETER)
+			goto out;
+	}
+
+	return n;
+
+out:
+	put_cpu_var(hv_gpci_reqb);
+	return ret;
+}
+
+static ssize_t processor_config_show(struct device *dev, struct device_attribute *attr,
+					char *buf)
+{
+	struct hv_gpci_request_buffer *arg;
+	unsigned long ret;
+	size_t n = 0;
+
+	arg = (void *)get_cpu_var(hv_gpci_reqb);
+	memset(arg, 0, HGPCI_REQ_BUFFER_SIZE);
+
+	/*
+	 * Pass the counter request value 0x90 corresponds to request
+	 * type 'Processor_config', to retrieve
+	 * the system processor information.
+	 * starting_index value implies the starting hardware
+	 * processor index.
+	 */
+	ret = systeminfo_gpci_request(sysinfo_counter_request[PROCESSOR_CONFIG],
+			0, 0, buf, &n, arg);
+
+	if (!ret)
+		return n;
+
+	if (ret != H_PARAMETER)
+		goto out;
+
+	/*
+	 * ret value as 'H_PARAMETER' corresponds to 'GEN_BUF_TOO_SMALL', which
+	 * implies that buffer can't accommodate all information, and a partial buffer
+	 * returned. To handle that, we need to take subsequent requests
+	 * with next starting index to retrieve additional (missing) data.
+	 * Below loop do subsequent hcalls with next starting index and add it
+	 * to buffer util we get all the information.
+	 */
+	while (ret == H_PARAMETER) {
+		int returned_values = be16_to_cpu(arg->params.returned_values);
+		int elementsize = be16_to_cpu(arg->params.cv_element_size);
+		int last_element = (returned_values - 1) * elementsize;
+
+		/*
+		 * Since the starting index is part of counter_value
+		 * buffer elements, use the starting index value in the last
+		 * element and add 1 to subsequent hcalls.
+		 */
+		u32 starting_index = arg->bytes[last_element + 3] +
+				(arg->bytes[last_element + 2] << 8) +
+				(arg->bytes[last_element + 1] << 16) +
+				(arg->bytes[last_element] << 24) + 1;
+
+		memset(arg, 0, HGPCI_REQ_BUFFER_SIZE);
+
+		ret = systeminfo_gpci_request(sysinfo_counter_request[PROCESSOR_CONFIG],
+				starting_index, 0, buf, &n, arg);
 
 		if (!ret)
 			return n;
@@ -258,6 +337,11 @@ static struct attribute *interface_attrs[] = {
 	 * attribute, set in init function if applicable.
 	 */
 	NULL,
+	/*
+	 * This NULL is a placeholder for the processor_config
+	 * attribute, set in init function if applicable.
+	 */
+	NULL,
 	NULL,
 };
 
@@ -463,17 +547,24 @@ static int hv_gpci_cpu_hotplug_init(void)
 			  ppc_hv_gpci_cpu_offline);
 }
 
-static void add_sysinfo_interface_files(void)
+static struct device_attribute *sysinfo_device_attr_create(int
+		sysinfo_interface_group_index, u32 req)
 {
 	struct device_attribute *attr = NULL;
 	unsigned long ret;
 	struct hv_gpci_request_buffer *arg;
 
-	/* Check for counter request type PROCESSOR_BUS_TOPOLOGY support */
+	if (sysinfo_interface_group_index < INTERFACE_PROCESSOR_BUS_TOPOLOGY_ATTR ||
+			sysinfo_interface_group_index >= INTERFACE_NULL_ATTR) {
+		pr_info("Wrong interface group index for system information\n");
+		return NULL;
+	}
+
+	/* Check for given counter request value support */
 	arg = (void *)get_cpu_var(hv_gpci_reqb);
 	memset(arg, 0, HGPCI_REQ_BUFFER_SIZE);
 
-	arg->params.counter_request = cpu_to_be32(PROCESSOR_BUS_TOPOLOGY);
+	arg->params.counter_request = cpu_to_be32(req);
 
 	ret = plpar_hcall_norets(H_GET_PERF_COUNTER_INFO,
 			virt_to_phys(arg), HGPCI_REQ_BUFFER_SIZE);
@@ -481,24 +572,71 @@ static void add_sysinfo_interface_files(void)
 	put_cpu_var(hv_gpci_reqb);
 
 	/*
-	 * Add processor_bus_topology attribute in the interface_attrs
+	 * Add given counter request value attribute in the interface_attrs
 	 * attribute array, only for valid return types.
 	 */
 	if (!ret || ret == H_AUTHORITY || ret == H_PARAMETER) {
 		attr = kzalloc(sizeof(*attr), GFP_KERNEL);
 
 		if (!attr) {
-			pr_info("Memory allocation failed for sysinfo interface files\n");
-			return;
+			pr_info("Mem allocation failed, for sysinfo interface file");
+			return NULL;
 		}
 
 		sysfs_attr_init(&attr->attr);
-		attr->attr.name = "processor_bug_topology";
 		attr->attr.mode = 0444;
-		attr->show = processor_bus_topology_show;
-		interface_attrs[INTERFACE_PROCESSOR_BUS_TOPOLOGY_ATTR] = &attr->attr;
+
+		switch (sysinfo_interface_group_index) {
+		case INTERFACE_PROCESSOR_BUS_TOPOLOGY_ATTR:
+			attr->attr.name = "processor_bug_topology";
+			attr->show = processor_bus_topology_show;
+		break;
+		case INTERFACE_PROCESSOR_CONFIG_ATTR:
+			attr->attr.name = "processor_config";
+			attr->show = processor_config_show;
+		break;
+		}
 	} else
 		pr_devel("hcall failed, with error: 0x%lx\n", ret);
+
+	return attr;
+}
+
+static void add_sysinfo_interface_files(void)
+{
+	int sysfs_count;
+	struct device_attribute *attr[INTERFACE_NULL_ATTR - INTERFACE_PROCESSOR_BUS_TOPOLOGY_ATTR];
+	int i;
+
+	sysfs_count = INTERFACE_NULL_ATTR - INTERFACE_PROCESSOR_BUS_TOPOLOGY_ATTR;
+
+	/* Get device attribute for a given counter request value */
+	for (i = 0; i < sysfs_count; i++) {
+		attr[i] = sysinfo_device_attr_create(i + INTERFACE_PROCESSOR_BUS_TOPOLOGY_ATTR,
+				sysinfo_counter_request[i]);
+
+		if (!attr[i])
+			goto out;
+	}
+
+	/* Add sysinfo interface attributes in the interface_attrs attribute array */
+	for (i = 0; i < sysfs_count; i++)
+		interface_attrs[i + INTERFACE_PROCESSOR_BUS_TOPOLOGY_ATTR] = &attr[i]->attr;
+
+	return;
+
+out:
+	/*
+	 * The sysinfo interface attributes will be added, only if hcall passed for
+	 * all the counter request values. Free the device attribute array incase
+	 * of any hcall failure.
+	 */
+	if (i > 0) {
+		while (i >= 0) {
+			kfree(attr[i]);
+			i--;
+		}
+	}
 }
 
 static int hv_gpci_init(void)
-- 
2.31.1

