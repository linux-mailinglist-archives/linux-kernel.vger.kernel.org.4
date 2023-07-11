Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CF474EDDF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjGKMQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjGKMQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:16:51 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F72DFB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:16:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEIFoZFsT0ba1pNrZNLX8vrPbdxsaEH5VZBzy3HEHs5jU+TMFFkoEGh4mqGljJ2UBo20M2BTUH1BSVfNrhsdoBZi7XnuMGrkt0rJ0mms1+7dze3jJaXO5eUPWGLarWoB0dkXqoDna7MkGIFFA1Spa9RIl1afRmIaJq/XUbs0ShGwa5+s9X1K2AGolRcVQ9+gr4wj8MbRPsrIyAj6l3C48EDxkYXAb9ob5ZUiX6oP79Mtf8w2Cs2ubW3Eylo8fPOJZ0t15+1dek9SvznGKNz/Ly5lD41M2wl9Gvg/A70BbEYI02StrDKkcEe5AnAfZZuaKn4aQ0Pmj5+1Gh89nHqmfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBhdwGYiEe8FOHedIOY/vwlVXrzUTnajme5T6wqDtNE=;
 b=MTCzQGk8CzWGpVLqiROHL8kYe76gU2+zxFCHXg9T34bwS9upYBc3bKkL4eRXEi4eHN7IS8EPk2s41wGSjJvhH41syz0Nkvm6lZEkAK/sG1/441uzJJegSmITnhC8Jsi62AUEuzWIr55Sul501NaXlKGD3r4YdoCH3l6zIwpHEbvefqrGgtZ6wypDVIbDLdVMUygESvwaKMJrPvTwu4wouM7evPuYn5jQXItIGye/xyJ/rFqOlzuCFK4pETk7bYzYnRrnpwolVPTg0wlv92faIiVaDo8HaOFWelu/gMcWAfzzXAg6ybrA2y/V7KnKwERyDyA5uzFpfXksyJfD1Dr+pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBhdwGYiEe8FOHedIOY/vwlVXrzUTnajme5T6wqDtNE=;
 b=YL4e8bCRcURjA7W8KF6D1pyUH6YsmjtKLql+ypNmpQtHeMtuaLc7JxJuP/PdhnVKbKbLiVWBzN3g4K046kuEEEi5iMbHD+YeAbqPFku6RZo1bN+FM8WkvVJMO8cDUu+7z+Rp2XJe73GkrIYRIEqehLLURalIdLvJFhe0y+qoLXE=
Received: from MW4PR04CA0037.namprd04.prod.outlook.com (2603:10b6:303:6a::12)
 by CYYPR12MB8704.namprd12.prod.outlook.com (2603:10b6:930:c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.29; Tue, 11 Jul
 2023 12:13:39 +0000
Received: from CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::14) by MW4PR04CA0037.outlook.office365.com
 (2603:10b6:303:6a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Tue, 11 Jul 2023 12:13:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT097.mail.protection.outlook.com (10.13.175.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.19 via Frontend Transport; Tue, 11 Jul 2023 12:13:37 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 11 Jul
 2023 07:13:36 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 11 Jul
 2023 05:13:36 -0700
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Tue, 11 Jul 2023 07:13:28 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
CC:     <Nipun.Gupta@amd.com>, <nikhil.agarwal@amd.com>,
        <puneet.gupta@amd.com>, <git@amd.com>, <michal.simek@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        "Pieter Jansen van Vuuren" <pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH 3/4] cdx: create sysfs resource files
Date:   Tue, 11 Jul 2023 17:40:26 +0530
Message-ID: <20230711121027.936487-4-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230711121027.936487-1-abhijit.gangurde@amd.com>
References: <20230711121027.936487-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT097:EE_|CYYPR12MB8704:EE_
X-MS-Office365-Filtering-Correlation-Id: 71054de0-04e5-40d4-9069-08db82084184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jHM1B1TwaXls6mAbyhiFlCcJroW/uZ4IcKB/+b3tfaXH8M77Uy7wmYyYMbvj/W6hMQuo2pD7MfxjiEOiwC0m9JBzHH3Ou77V5CUoKYqSQIgRR331IIiHl1uClLrtqEz02CDwjh1P4NCPCEqP4s/c+xnLaFWwI2T8BSHZ1I7UDcygjwvbOs7Zyiwf4KVsyCaY3YayVqpcX4+iY88bY5Vdn63WYMumymRnVGWvz54K3gdkOUUXqyk+aJov0qscusX7bw/xGRtow6IYXCfNJQSYS3Ye0iw04WRqmiA9Ms6qRP2nngruPj1D5nLxNZ8Bwu/B0ldPKFlOYV69y+1dcAZ/t3VojrkOmChVUH7MBlMdQS4ln9Pc9/5IR7cotSg4i+L37NYMJRjg+AvTMBjsVBP4TL6al1MyfImJdIkArJMHyWzE1ROdv+mA8ZOZz9kWYEANpKO5QKVu8XBMmVoj12Smv6SGq/KMUNmONJ2612gRhb+qONVIVZdryv/uD9LEnuCKX/yXfl2+wMPm2IpG9eSqMuDI1bRY2bgVDU9LHJ7CO20jlOxXc/Hiw1r3K88cEfvxPpbQpAl104VOsU37S6CPx7sLv6CaZN+bA6QFsiJ3p1kIa0SHuubOXZGJKkNns19VvvpGeK146HzX9UbQGPRhfiPVS7cB2OMKShWfax2MwkQrgl3ndUiyd2UMAjLPA+yXkzA7yN5+UjnwTdbZJV6n1nsDyJ66HsUrnM7zSgngScTbQQCfFTc5VQsL6WoiX7JyEVif9QZlW1qoEogEXKPdtw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(26005)(186003)(1076003)(2616005)(336012)(83380400001)(426003)(41300700001)(47076005)(4326008)(478600001)(36860700001)(2906002)(316002)(5660300002)(8676002)(44832011)(8936002)(54906003)(70586007)(70206006)(110136005)(40480700001)(36756003)(356005)(81166007)(82740400003)(86362001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 12:13:37.2050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71054de0-04e5-40d4-9069-08db82084184
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8704
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resource files provides the basic MMIO regions info to the
user-space. Also, resources<x> devices can be used to mmap the
MMIO regions in the user-space.

Co-developed-by: Puneet Gupta <puneet.gupta@amd.com>
Signed-off-by: Puneet Gupta <puneet.gupta@amd.com>
Co-developed-by: Nipun Gupta <nipun.gupta@amd.com>
Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
---
 Documentation/ABI/testing/sysfs-bus-cdx |  15 +++
 drivers/cdx/cdx.c                       | 139 +++++++++++++++++++++++-
 include/linux/cdx/cdx_bus.h             |  10 ++
 3 files changed, 163 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cdx b/Documentation/ABI/testing/sysfs-bus-cdx
index d9e00058471d..6ca47b6442ce 100644
--- a/Documentation/ABI/testing/sysfs-bus-cdx
+++ b/Documentation/ABI/testing/sysfs-bus-cdx
@@ -76,3 +76,18 @@ Description:
 		For example::
 
 		  # echo 1 > /sys/bus/cdx/devices/.../remove
+
+What:		/sys/bus/cdx/devices/.../resource
+Date:		July 2023
+Contact:	puneet.gupta@amd.com
+Description:
+		The resource file contains host addresses of CDX device
+		resources. Each line of the resource file describes a region
+		with start, end, and flag fields.
+
+What:		/sys/bus/cdx/devices/.../resource<N>
+Date:		July 2023
+Contact:	puneet.gupta@amd.com
+Description:
+		The resource binary file contains the content of the memory
+		regions. These files can be m'maped from userspace.
diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 4d20047b55bb..9d568df8e566 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -73,6 +73,8 @@
 /* CDX controllers registered with the CDX bus */
 static DEFINE_XARRAY_ALLOC(cdx_controllers);
 
+static void cdx_destroy_res_attr(struct cdx_device *cdx_dev, int num);
+
 /**
  * cdx_dev_reset - Reset a CDX device
  * @dev: CDX device
@@ -126,6 +128,8 @@ static int cdx_unregister_device(struct device *dev,
 {
 	struct cdx_device *cdx_dev = to_cdx_device(dev);
 
+	cdx_destroy_res_attr(cdx_dev, MAX_CDX_DEV_RESOURCES);
+
 	kfree(cdx_dev->driver_override);
 	cdx_dev->driver_override = NULL;
 	/*
@@ -375,12 +379,32 @@ static ssize_t driver_override_show(struct device *dev,
 }
 static DEVICE_ATTR_RW(driver_override);
 
+static ssize_t resource_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct cdx_device *cdx_dev = to_cdx_device(dev);
+	size_t len = 0;
+	int i;
+
+	for (i = 0; i < MAX_CDX_DEV_RESOURCES; i++) {
+		struct resource *res =  &cdx_dev->res[i];
+
+		len += sysfs_emit_at(buf, len, "0x%016llx 0x%016llx 0x%016llx\n",
+				    (unsigned long long)res->start,
+				    (unsigned long long)res->end,
+				    (unsigned long long)res->flags);
+	}
+
+	return len;
+}
+static DEVICE_ATTR_RO(resource);
+
 static struct attribute *cdx_dev_attrs[] = {
 	&dev_attr_remove.attr,
 	&dev_attr_reset.attr,
 	&dev_attr_vendor.attr,
 	&dev_attr_device.attr,
 	&dev_attr_driver_override.attr,
+	&dev_attr_resource.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(cdx_dev);
@@ -514,12 +538,106 @@ static void cdx_device_release(struct device *dev)
 	kfree(cdx_dev);
 }
 
+static const struct vm_operations_struct cdx_phys_vm_ops = {
+#ifdef CONFIG_HAVE_IOREMAP_PROT
+	.access = generic_access_phys,
+#endif
+};
+
+/**
+ * cdx_mmap_resource - map a CDX resource into user memory space
+ * @fp: File pointer. Not used in this function, but required where
+ *      this API is registered as a callback.
+ * @kobj: kobject for mapping
+ * @attr: struct bin_attribute for the file being mapped
+ * @vma: struct vm_area_struct passed into the mmap
+ *
+ * Use the regular CDX mapping routines to map a CDX resource into userspace.
+ *
+ * Return: true on success, false otherwise.
+ */
+static int cdx_mmap_resource(struct file *fp, struct kobject *kobj,
+			     struct bin_attribute *attr,
+			     struct vm_area_struct *vma)
+{
+	struct cdx_device *cdx_dev = to_cdx_device(kobj_to_dev(kobj));
+	int num = (unsigned long)attr->private;
+	struct resource *res;
+	unsigned long size;
+
+	res = &cdx_dev->res[num];
+	if (iomem_is_exclusive(res->start))
+		return -EINVAL;
+
+	/* Make sure the caller is mapping a valid resource for this device */
+	size = ((cdx_resource_len(cdx_dev, num) - 1) >> PAGE_SHIFT) + 1;
+	if (vma->vm_pgoff + vma_pages(vma) > size)
+		return -EINVAL;
+
+	/*
+	 * Map memory region and vm->vm_pgoff is expected to be an
+	 * offset within that region.
+	 */
+	vma->vm_page_prot = pgprot_device(vma->vm_page_prot);
+	vma->vm_pgoff += (cdx_resource_start(cdx_dev, num) >> PAGE_SHIFT);
+	vma->vm_ops = &cdx_phys_vm_ops;
+	return io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+				  vma->vm_end - vma->vm_start,
+				  vma->vm_page_prot);
+}
+
+static void cdx_destroy_res_attr(struct cdx_device *cdx_dev, int num)
+{
+	int i;
+
+	/* removing the bin attributes */
+	for (i = 0; i < num; i++) {
+		struct bin_attribute *res_attr;
+
+		res_attr = cdx_dev->res_attr[i];
+		if (res_attr) {
+			sysfs_remove_bin_file(&cdx_dev->dev.kobj, res_attr);
+			kfree(res_attr);
+		}
+	}
+}
+
+#define CDX_RES_ATTR_NAME_LEN	10
+static int cdx_create_res_attr(struct cdx_device *cdx_dev, int num)
+{
+	struct bin_attribute *res_attr;
+	char *res_attr_name;
+	int ret;
+
+	res_attr = kzalloc(sizeof(*res_attr) + CDX_RES_ATTR_NAME_LEN, GFP_ATOMIC);
+	if (!res_attr)
+		return -ENOMEM;
+
+	res_attr_name = (char *)(res_attr + 1);
+
+	sysfs_bin_attr_init(res_attr);
+
+	cdx_dev->res_attr[num] = res_attr;
+	sprintf(res_attr_name, "resource%d", num);
+
+	res_attr->mmap = cdx_mmap_resource;
+	res_attr->attr.name = res_attr_name;
+	res_attr->attr.mode = 0600;
+	res_attr->size = cdx_resource_len(cdx_dev, num);
+	res_attr->private = (void *)(unsigned long)num;
+	ret = sysfs_create_bin_file(&cdx_dev->dev.kobj, res_attr);
+	if (ret)
+		kfree(res_attr);
+
+	return ret;
+}
+
 int cdx_device_add(struct cdx_dev_params *dev_params)
 {
 	struct cdx_controller *cdx = dev_params->cdx;
 	struct device *parent = cdx->dev;
 	struct cdx_device *cdx_dev;
-	int ret;
+	int ret, i;
 
 	cdx_dev = kzalloc(sizeof(*cdx_dev), GFP_KERNEL);
 	if (!cdx_dev)
@@ -558,7 +676,26 @@ int cdx_device_add(struct cdx_dev_params *dev_params)
 		goto fail;
 	}
 
+	/* Create resource<N> attributes */
+	for (i = 0; i < MAX_CDX_DEV_RESOURCES; i++) {
+		if (cdx_resource_flags(cdx_dev, i) & IORESOURCE_MEM) {
+			/* skip empty resources */
+			if (!cdx_resource_len(cdx_dev, i))
+				continue;
+
+			ret = cdx_create_res_attr(cdx_dev, i);
+			if (ret != 0) {
+				dev_err(&cdx_dev->dev,
+					"cdx device resource<%d> file creation failed: %d", i, ret);
+				goto fail1;
+			}
+		}
+	}
+
 	return 0;
+fail1:
+	cdx_destroy_res_attr(cdx_dev, i);
+	device_del(&cdx_dev->dev);
 fail:
 	/*
 	 * Do not free cdx_dev here as it would be freed in
diff --git a/include/linux/cdx/cdx_bus.h b/include/linux/cdx/cdx_bus.h
index 5da0634ae4ee..e93f1cd8ae33 100644
--- a/include/linux/cdx/cdx_bus.h
+++ b/include/linux/cdx/cdx_bus.h
@@ -104,6 +104,7 @@ struct cdx_device {
 	u8 bus_num;
 	u8 dev_num;
 	struct resource res[MAX_CDX_DEV_RESOURCES];
+	struct bin_attribute *res_attr[MAX_CDX_DEV_RESOURCES];
 	u8 res_count;
 	u64 dma_mask;
 	u16 flags;
@@ -114,6 +115,15 @@ struct cdx_device {
 #define to_cdx_device(_dev) \
 	container_of(_dev, struct cdx_device, dev)
 
+#define cdx_resource_start(dev, num)	((dev)->res[(num)].start)
+#define cdx_resource_end(dev, num)	((dev)->res[(num)].end)
+#define cdx_resource_flags(dev, num)	((dev)->res[(num)].flags)
+#define cdx_resource_len(dev, num) \
+	((cdx_resource_start((dev), (num)) == 0 &&	\
+	  cdx_resource_end((dev), (num)) ==		\
+	  cdx_resource_start((dev), (num))) ? 0 :	\
+	 (cdx_resource_end((dev), (num)) -		\
+	  cdx_resource_start((dev), (num)) + 1))
 /**
  * struct cdx_driver - CDX device driver
  * @driver: Generic device driver
-- 
2.25.1

