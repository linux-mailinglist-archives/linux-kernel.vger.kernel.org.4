Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE925EE68B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 22:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbiI1UTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 16:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbiI1UTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 16:19:39 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632E6C5C;
        Wed, 28 Sep 2022 13:19:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnXgoUOD+UUGIGy8k74bzDu9Jc2nI2Pp1RD6OaWb5Mfn+FreipD3mNbfOdp3zTJW+AMlq3oLaHzccJR/QXTzjsz70DMp0XoUr4A4UP1e3cRu91pmJIs4JV3ELElOEKenlRZ75PlZv/8aYieG3ZcjS2YosmsLqCPnK8XcaFrCAdCqF18yXeoAOtmD2yjcAZUkVZ7C9DoOfuhnVsK1Mk5ch2uWwTi1nazEheUEBn3DI7DG6TEGuI0O+cyppzY2GM3835meR5BfJHaLUiwGPf1SYIaD4L5YkMpKtUPgskAcROnskMuqp2DdanQhOKuEMVo8das1HXQhEEXGXbugYnVqwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qMvkXeIQEu2oMfOZKka7rlJLyj/2ZoYe7AwdMndOXE=;
 b=bLVqAABlCxcSl0MiH6SdVmSVr2qxup+VOgJl4x3wBAkbDo2/6GTJg0JoKxgn/Cssn2neRUTUgp/mbHboJpgqByLSTd+5Uoz7Z2GjUeXPBBoPDYpYbLwL6IEUewnUInWM+39hl6CXUc97XnWK3mLWIBUSjUQZdJXEKXQbtblOVnYL1ksrEx6caWvXUVkm+cx3F+ZqSut+197ZzGuUC6JKsb0q7IDXbIFaBIM7EgBobwk9xPmdL39BtUMG6IZSeAlysv6CY8MaGNzyCyo1o1vy6seVFhWm2MGbrpyhTYt73gTLXAqjQCB9oMQvzpHpqlW7sFcX+k6jNiC0MkJ7Px/Szw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qMvkXeIQEu2oMfOZKka7rlJLyj/2ZoYe7AwdMndOXE=;
 b=mJ/lJhjOJO++KmNyVG1e9N13X3PuO5Q77CJNnoilDVwPzluu14cMtS/xzk19s9qgPMdahOpS+YOVCKxo1rZJYh3c6yZCrVndoRSUZxFA8FyDdu/lvORrUhcJxxVjTZAQcEk1HHqATQ/op3AOCVwQtTY7GEmZB4l/BmgN2dG7Z7AApQwXXWpRed6fUM6u99+5Wu3utVTvghx3kE3Zia/Uvo6YWIvZQKsJ3AMpapf2fGRPdRk2yIAdWxLsvQE28KnMzj2ErqyBpe4MgjBzA8g5ygbEFMLDhY+qZfpU2ZegnmqzON3xeH7y1oaFyg89B4a0R+2h6xR50VSLxDdJtKfD8g==
Received: from DM6PR17CA0003.namprd17.prod.outlook.com (2603:10b6:5:1b3::16)
 by MN2PR12MB4582.namprd12.prod.outlook.com (2603:10b6:208:26b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 20:19:29 +0000
Received: from DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::e7) by DM6PR17CA0003.outlook.office365.com
 (2603:10b6:5:1b3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 20:19:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT103.mail.protection.outlook.com (10.13.172.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 20:19:29 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 28 Sep
 2022 13:19:19 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 28 Sep
 2022 13:19:19 -0700
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 28 Sep 2022 13:19:18 -0700
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     <suzuki.poulose@arm.com>, <robin.murphy@arm.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <sudeep.holla@arm.com>, <thanu.rangarajan@arm.com>,
        <Michael.Williams@arm.com>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
        <mathieu.poirier@linaro.org>, <mike.leach@linaro.org>,
        <leo.yan@linaro.org>, Besar Wicaksono <bwicaksono@nvidia.com>
Subject: [PATCH v5 2/2] perf: arm_cspmu: Add support for NVIDIA SCF and MCF attribute
Date:   Wed, 28 Sep 2022 15:18:30 -0500
Message-ID: <20220928201830.45637-3-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220928201830.45637-1-bwicaksono@nvidia.com>
References: <20220928201830.45637-1-bwicaksono@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT103:EE_|MN2PR12MB4582:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ae7a45-3f4b-4db7-1a6e-08daa18ebf68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LvqJPIRwgGvHBB3a2dg3HFpLU7y0xpFjf/KWF3gNKjDBilAWwXw+OzPxcf7D9UEqg3FOBHt3ub1/5STc9g3Mo317QIkTyEmM5r1a27kBZ23IQ8WSHAdohUMfSSyRyXlsNIu4eC8EXFQczBEz0qbVDuZjefjQaH4RBFpCdKZFa/JpkzlIX0LiD7RaAETyn+8EpRuLoimzujRdsx+1KuMq8moN2PrmljWRHnv46y0Y6gKl6aFaG8dW4a1dBvYokQCglN11zWPKrB2wqwPdyouwO+k/9yW6ntRh+KWxTYAjZO34FL9fluArOfXQhddCUm4bsofkK0NRPAbKfts950OmntTYw25ddHIPtiHyZ3kvsOGVOpXOeUBsp6GR13nsOcJ8LVaM/WT8ZTyA05baSmA8r+7RD2ZerdeRBJnTc854FXY8oPlo3pV3skMnlffce+z5Ocm5cvGD1yJx7Mbl3VQ2JZZ+qtuty1TAJTlIPt17AwpZmZ08uxPWIbbGj1yZbYPXJ0c/aFxdtUkRo8vFvukqtM7AayrWmy7dUc4ioXLVI8UgjBOLbvNcHM4IcSNZxNOszj0gtEnXxkjCwa7kcUFIhu/sZhn7kuF9tuRA2XDtXkiNkyOPqhvaMMPSJVLa3+2XnhQixqKq1kqTAhzLaJTUCr5tfq3ycUISIRohSEPlhAy/ZBFPX/BUdWKlnteSsnsJhTns3X6B1D7gP9zeMouyIjsmXrLIQ4K0dprIQ/H1Q6/X8FwQquauZDtlcFU/FyL5f0wLE1+51ioufsK36MQBzA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199015)(36840700001)(40470700004)(46966006)(4326008)(36756003)(54906003)(8676002)(86362001)(2616005)(356005)(7416002)(36860700001)(186003)(47076005)(5660300002)(82740400003)(110136005)(83380400001)(426003)(7636003)(336012)(6666004)(26005)(41300700001)(70206006)(30864003)(478600001)(7696005)(1076003)(8936002)(316002)(107886003)(2906002)(40460700003)(70586007)(40480700001)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 20:19:29.3639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ae7a45-3f4b-4db7-1a6e-08daa18ebf68
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4582
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for NVIDIA System Cache Fabric (SCF) and Memory Control
Fabric (MCF) PMU attributes for CoreSight PMU implementation in
NVIDIA devices.

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 Documentation/admin-guide/perf/index.rst      |   1 +
 Documentation/admin-guide/perf/nvidia-pmu.rst | 299 +++++++++++++
 drivers/perf/arm_cspmu/Makefile               |   3 +-
 drivers/perf/arm_cspmu/arm_cspmu.c            |   9 +
 drivers/perf/arm_cspmu/nvidia_cspmu.c         | 398 ++++++++++++++++++
 drivers/perf/arm_cspmu/nvidia_cspmu.h         |  17 +
 6 files changed, 726 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/admin-guide/perf/nvidia-pmu.rst
 create mode 100644 drivers/perf/arm_cspmu/nvidia_cspmu.c
 create mode 100644 drivers/perf/arm_cspmu/nvidia_cspmu.h

diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
index 69b23f087c05..cf05fed1f67f 100644
--- a/Documentation/admin-guide/perf/index.rst
+++ b/Documentation/admin-guide/perf/index.rst
@@ -17,3 +17,4 @@ Performance monitor support
    xgene-pmu
    arm_dsu_pmu
    thunderx2-pmu
+   nvidia-pmu
diff --git a/Documentation/admin-guide/perf/nvidia-pmu.rst b/Documentation/admin-guide/perf/nvidia-pmu.rst
new file mode 100644
index 000000000000..e7f454d3411d
--- /dev/null
+++ b/Documentation/admin-guide/perf/nvidia-pmu.rst
@@ -0,0 +1,299 @@
+=========================================================
+NVIDIA Tegra SoC Uncore Performance Monitoring Unit (PMU)
+=========================================================
+
+The NVIDIA Tegra SoC includes various system PMUs to measure key performance
+metrics like memory bandwidth, latency, and utilization:
+
+* Scalable Coherency Fabric (SCF)
+* NVLink-C2C0
+* NVLink-C2C1
+* CNVLink
+* PCIE
+
+PMU Driver
+----------
+
+The PMUs in this document are based on ARM CoreSight PMU Architecture as
+described in document: ARM IHI 0091. Since this is a standard architecture, the
+PMUs are managed by a common driver "arm-cs-arch-pmu". This driver describes
+the available events and configuration of each PMU in sysfs. Please see the
+sections below to get the sysfs path of each PMU. Like other uncore PMU drivers,
+the driver provides "cpumask" sysfs attribute to show the CPU id used to handle
+the PMU event. There is also "associated_cpus" sysfs attribute, which contains a
+list of CPUs associated with the PMU instance.
+
+.. _SCF_PMU_Section:
+
+SCF PMU
+-------
+
+The SCF PMU monitors system level cache events, CPU traffic, and
+strongly-ordered (SO) PCIE write traffic to local/remote memory. Please see
+:ref:`NVIDIA_Uncore_PMU_Traffic_Coverage_Section` for more info about the PMU
+traffic coverage.
+
+The events and configuration options of this PMU device are described in sysfs,
+see /sys/bus/event_sources/devices/nvidia_scf_pmu_<socket-id>.
+
+Example usage:
+
+* Count event id 0x0 in socket 0::
+
+   perf stat -a -e nvidia_scf_pmu_0/event=0x0/
+
+* Count event id 0x0 in socket 1::
+
+   perf stat -a -e nvidia_scf_pmu_1/event=0x0/
+
+NVLink-C2C0 PMU
+--------------------
+
+The NVLink-C2C0 PMU monitors incoming traffic from a GPU/CPU connected with
+NVLink-C2C (Chip-2-Chip) interconnect. The type of traffic captured by this PMU 
+varies dependent on the chip configuration:
+
+* NVIDIA Grace Hopper Superchip: Hopper GPU is connected with Grace SoC.
+
+  In this config, the PMU captures GPU ATS translated or EGM traffic from the GPU. 
+
+* NVIDIA Grace CPU Superchip: two Grace CPU SoCs are connected.
+
+  In this config, the PMU captures read and relaxed ordered (RO) writes from
+  PCIE device of the remote SoC.
+
+Please see :ref:`NVIDIA_Uncore_PMU_Traffic_Coverage_Section` for more info about
+the PMU traffic coverage.
+
+The events and configuration options of this PMU device are described in sysfs,
+see /sys/bus/event_sources/devices/nvidia_nvlink_c2c0_pmu_<socket-id>.
+
+Example usage:
+
+* Count event id 0x0 from the GPU/CPU connected with socket 0::
+
+   perf stat -a -e nvidia_nvlink_c2c0_pmu_0/event=0x0/
+
+* Count event id 0x0 from the GPU/CPU connected with socket 1::
+
+   perf stat -a -e nvidia_nvlink_c2c0_pmu_1/event=0x0/
+
+* Count event id 0x0 from the GPU/CPU connected with socket 2::
+
+   perf stat -a -e nvidia_nvlink_c2c0_pmu_2/event=0x0/
+
+* Count event id 0x0 from the GPU/CPU connected with socket 3::
+
+   perf stat -a -e nvidia_nvlink_c2c0_pmu_3/event=0x0/
+
+NVLink-C2C1 PMU
+-------------------
+
+The NVLink-C2C1 PMU monitors incoming traffic from a GPU connected with
+NVLink-C2C (Chip-2-Chip) interconnect. This PMU captures untranslated GPU
+traffic, in contrast with NvLink-C2C0 PMU that captures ATS translated traffic.
+Please see :ref:`NVIDIA_Uncore_PMU_Traffic_Coverage_Section` for more info about
+the PMU traffic coverage.
+
+The events and configuration options of this PMU device are described in sysfs,
+see /sys/bus/event_sources/devices/nvidia_nvlink_c2c1_pmu_<socket-id>.
+
+Example usage:
+
+* Count event id 0x0 from the GPU connected with socket 0::
+
+   perf stat -a -e nvidia_nvlink_c2c1_pmu_0/event=0x0/
+
+* Count event id 0x0 from the GPU connected with socket 1::
+
+   perf stat -a -e nvidia_nvlink_c2c1_pmu_1/event=0x0/
+
+* Count event id 0x0 from the GPU connected with socket 2::
+
+   perf stat -a -e nvidia_nvlink_c2c1_pmu_2/event=0x0/
+
+* Count event id 0x0 from the GPU connected with socket 3::
+
+   perf stat -a -e nvidia_nvlink_c2c1_pmu_3/event=0x0/
+
+CNVLink PMU
+---------------
+
+The CNVLink PMU monitors traffic from GPU and PCIE device on remote sockets
+to local memory. For PCIE traffic, this PMU captures read and relaxed ordered
+(RO) write traffic. Please see :ref:`NVIDIA_Uncore_PMU_Traffic_Coverage_Section`
+for more info about the PMU traffic coverage.
+
+The events and configuration options of this PMU device are described in sysfs,
+see /sys/bus/event_sources/devices/nvidia_cnvlink_pmu_<socket-id>.
+
+Each SoC socket can be connected to one or more sockets via CNVLink. The user can
+use "rem_socket" bitmap parameter to select the remote socket(s) to monitor.
+Each bit represents the socket number, e.g. "rem_socket=0xE" corresponds to
+socket 1 to 3.
+/sys/bus/event_sources/devices/nvidia_cnvlink_pmu_<socket-id>/format/rem_socket
+shows the valid bits that can be set in the "rem_socket" parameter.
+
+The PMU can not distinguish the remote traffic initiator, therefore it does not
+provide filter to select the traffic source to monitor. It reports combined
+traffic from remote GPU and PCIE devices.
+
+Example usage:
+
+* Count event id 0x0 for the traffic from remote socket 1, 2, and 3 to socket 0::
+
+   perf stat -a -e nvidia_cnvlink_pmu_0/event=0x0,rem_socket=0xE/
+
+* Count event id 0x0 for the traffic from remote socket 0, 2, and 3 to socket 1::
+
+   perf stat -a -e nvidia_cnvlink_pmu_1/event=0x0,rem_socket=0xD/
+
+* Count event id 0x0 for the traffic from remote socket 0, 1, and 3 to socket 2::
+
+   perf stat -a -e nvidia_cnvlink_pmu_2/event=0x0,rem_socket=0xB/
+
+* Count event id 0x0 for the traffic from remote socket 0, 1, and 2 to socket 3::
+
+   perf stat -a -e nvidia_cnvlink_pmu_3/event=0x0,rem_socket=0x7/
+
+
+PCIE PMU
+------------
+
+The PCIE PMU monitors all read/write traffic from PCIE root ports to
+local/remote memory. Please see :ref:`NVIDIA_Uncore_PMU_Traffic_Coverage_Section`
+for more info about the PMU traffic coverage.
+
+The events and configuration options of this PMU device are described in sysfs,
+see /sys/bus/event_sources/devices/nvidia_pcie_pmu_<socket-id>.
+
+Each SoC socket can support multiple root ports. The user can use
+"root_port" bitmap parameter to select the port(s) to monitor, i.e.
+"root_port=0xF" corresponds to root port 0 to 3.
+/sys/bus/event_sources/devices/nvidia_pcie_pmu_<socket-id>/format/root_port
+shows the valid bits that can be set in the "root_port" parameter.
+
+Example usage:
+
+* Count event id 0x0 from root port 0 and 1 of socket 0::
+
+   perf stat -a -e nvidia_pcie_pmu_0/event=0x0,root_port=0x3/
+
+* Count event id 0x0 from root port 0 and 1 of socket 1::
+
+   perf stat -a -e nvidia_pcie_pmu_1/event=0x0,root_port=0x3/
+
+.. _NVIDIA_Uncore_PMU_Traffic_Coverage_Section:
+
+Traffic Coverage
+----------------
+
+The PMU traffic coverage may vary dependent on the chip configuration:
+
+* **NVIDIA Grace Hopper Superchip**: Hopper GPU is connected with Grace SoC.
+
+  Example configuration with two Grace SoCs::
+
+   *********************************          *********************************
+   * SOCKET-A                      *          * SOCKET-B                      *
+   *                               *          *                               *
+   *                     ::::::::  *          *  ::::::::                     *
+   *                     : PCIE :  *          *  : PCIE :                     *
+   *                     ::::::::  *          *  ::::::::                     *
+   *                         |     *          *      |                        *
+   *                         |     *          *      |                        *
+   *  :::::::            ::::::::: *          *  :::::::::            ::::::: *
+   *  :     :            :       : *          *  :       :            :     : *
+   *  : GPU :<--NVLink-->: Grace :<---CNVLink--->: Grace :<--NVLink-->: GPU : *
+   *  :     :    C2C     :  SoC  : *          *  :  SoC  :    C2C     :     : *
+   *  :::::::            ::::::::: *          *  :::::::::            ::::::: *
+   *     |                   |     *          *      |                   |    *
+   *     |                   |     *          *      |                   |    *
+   *  &&&&&&&&           &&&&&&&&  *          *   &&&&&&&&           &&&&&&&& *
+   *  & GMEM &           & CMEM &  *          *   & CMEM &           & GMEM & *
+   *  &&&&&&&&           &&&&&&&&  *          *   &&&&&&&&           &&&&&&&& *
+   *                               *          *                               *
+   *********************************          *********************************
+
+   GMEM = GPU Memory (e.g. HBM)
+   CMEM = CPU Memory (e.g. LPDDR5X)
+
+  | 
+  | Following table contains traffic coverage of Grace SoC PMU in socket-A:
+
+  ::
+ 
+   +--------------+-------+-----------+-----------+-----+----------+----------+
+   |              |                        Source                             |
+   +              +-------+-----------+-----------+-----+----------+----------+
+   | Destination  |       |GPU ATS    |GPU Not-ATS|     | Socket-B | Socket-B |
+   |              |PCI R/W|Translated,|Translated | CPU | CPU/PCIE1| GPU/PCIE2| 
+   |              |       |EGM        |           |     |          |          |
+   +==============+=======+===========+===========+=====+==========+==========+
+   | Local        | PCIE  |NVLink-C2C0|NVLink-C2C1| SCF | SCF PMU  | CNVLink  |
+   | SYSRAM/CMEM  | PMU   |PMU        |PMU        | PMU |          | PMU      |
+   +--------------+-------+-----------+-----------+-----+----------+----------+
+   | Local GMEM   | PCIE  |    N/A    |NVLink-C2C1| SCF | SCF PMU  | CNVLink  |
+   |              | PMU   |           |PMU        | PMU |          | PMU      |
+   +--------------+-------+-----------+-----------+-----+----------+----------+
+   | Remote       | PCIE  |NVLink-C2C0|NVLink-C2C1| SCF |          |          |
+   | SYSRAM/CMEM  | PMU   |PMU        |PMU        | PMU |   N/A    |   N/A    |
+   | over CNVLink |       |           |           |     |          |          |
+   +--------------+-------+-----------+-----------+-----+----------+----------+
+   | Remote GMEM  | PCIE  |NVLink-C2C0|NVLink-C2C1| SCF |          |          |
+   | over CNVLink | PMU   |PMU        |PMU        | PMU |   N/A    |   N/A    |
+   +--------------+-------+-----------+-----------+-----+----------+----------+
+   
+   PCIE1 traffic represents strongly ordered (SO) writes.
+   PCIE2 traffic represents reads and relaxed ordered (RO) writes. 
+
+* **NVIDIA Grace CPU Superchip**: two Grace CPU SoCs are connected.
+
+  Example configuration with two Grace SoCs::
+
+   *******************             *******************
+   * SOCKET-A        *             * SOCKET-B        *
+   *                 *             *                 *
+   *    ::::::::     *             *    ::::::::     *
+   *    : PCIE :     *             *    : PCIE :     *
+   *    ::::::::     *             *    ::::::::     *
+   *        |        *             *        |        *
+   *        |        *             *        |        *
+   *    :::::::::    *             *    :::::::::    *
+   *    :       :    *             *    :       :    *
+   *    : Grace :<--------NVLink------->: Grace :    *
+   *    :  SoC  :    *     C2C     *    :  SoC  :    *
+   *    :::::::::    *             *    :::::::::    *
+   *        |        *             *        |        *
+   *        |        *             *        |        *
+   *     &&&&&&&&    *             *     &&&&&&&&    *
+   *     & CMEM &    *             *     & CMEM &    *
+   *     &&&&&&&&    *             *     &&&&&&&&    *
+   *                 *             *                 *
+   *******************             *******************
+
+   GMEM = GPU Memory (e.g. HBM)
+   CMEM = CPU Memory (e.g. LPDDR5X)
+
+  | 
+  | Following table contains traffic coverage of Grace SoC PMU in socket-A:
+
+  ::
+
+   +-----------------+-----------+---------+----------+-------------+
+   |                 |                      Source                  |
+   +                 +-----------+---------+----------+-------------+
+   | Destination     |           |         | Socket-B | Socket-B    |
+   |                 |  PCI R/W  |   CPU   | CPU/PCIE1| PCIE2       | 
+   |                 |           |         |          |             |
+   +=================+===========+=========+==========+=============+
+   | Local           |  PCIE PMU | SCF PMU | SCF PMU  | NVLink-C2C0 |
+   | SYSRAM/CMEM     |           |         |          | PMU         |
+   +-----------------+-----------+---------+----------+-------------+
+   | Remote          |           |         |          |             |
+   | SYSRAM/CMEM     |  PCIE PMU | SCF PMU |   N/A    |     N/A     |
+   | over NVLink-C2C |           |         |          |             |
+   +-----------------+-----------+---------+----------+-------------+
+   
+   PCIE1 traffic represents strongly ordered (SO) writes.
+   PCIE2 traffic represents reads and relaxed ordered (RO) writes. 
diff --git a/drivers/perf/arm_cspmu/Makefile b/drivers/perf/arm_cspmu/Makefile
index cdc3455f74d8..1b586064bd77 100644
--- a/drivers/perf/arm_cspmu/Makefile
+++ b/drivers/perf/arm_cspmu/Makefile
@@ -3,4 +3,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += \
-	arm_cspmu.o
+	arm_cspmu.o \
+	nvidia_cspmu.o
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 0fa5f29bf1c6..5342205322ae 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -31,6 +31,7 @@
 #include <acpi/processor.h>
 
 #include "arm_cspmu.h"
+#include "nvidia_cspmu.h"
 
 #define PMUNAME "arm_cspmu"
 #define DRVNAME "arm-cs-arch-pmu"
@@ -116,6 +117,9 @@
  */
 #define HILOHI_MAX_POLL	1000
 
+/* JEDEC-assigned JEP106 identification code */
+#define ARM_CSPMU_IMPL_ID_NVIDIA		0x36B
+
 static unsigned long arm_cspmu_cpuhp_state;
 
 /*
@@ -372,6 +376,11 @@ struct impl_match {
 };
 
 static const struct impl_match impl_match[] = {
+	{
+	  .pmiidr = ARM_CSPMU_IMPL_ID_NVIDIA,
+	  .mask = ARM_CSPMU_PMIIDR_IMPLEMENTER,
+	  .impl_init_ops = nv_cspmu_init_ops
+	},
 	{}
 };
 
diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.c b/drivers/perf/arm_cspmu/nvidia_cspmu.c
new file mode 100644
index 000000000000..7b7afc3d81e8
--- /dev/null
+++ b/drivers/perf/arm_cspmu/nvidia_cspmu.c
@@ -0,0 +1,398 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
+ *
+ */
+
+/* Support for NVIDIA specific attributes. */
+
+#include <linux/topology.h>
+
+#include "nvidia_cspmu.h"
+
+#define NV_PCIE_PORT_COUNT           10ULL
+#define NV_PCIE_FILTER_ID_MASK       GENMASK_ULL(NV_PCIE_PORT_COUNT - 1, 0)
+
+#define NV_NVL_C2C_PORT_COUNT        2ULL
+#define NV_NVL_C2C_FILTER_ID_MASK    GENMASK_ULL(NV_NVL_C2C_PORT_COUNT - 1, 0)
+
+#define NV_CNVL_PORT_COUNT           4ULL
+#define NV_CNVL_FILTER_ID_MASK       GENMASK_ULL(NV_CNVL_PORT_COUNT - 1, 0)
+
+#define NV_GENERIC_FILTER_ID_MASK    GENMASK_ULL(31, 0)
+
+#define NV_PRODID_MASK               GENMASK(31, 0)
+
+#define NV_FORMAT_NAME_GENERIC	0
+
+#define to_nv_cspmu_ctx(cspmu)	((struct nv_cspmu_ctx *)(cspmu->impl.ctx))
+
+#define NV_CSPMU_EVENT_ATTR_4_INNER(_pref, _num, _suff, _config)	\
+	ARM_CSPMU_EVENT_ATTR(_pref##_num##_suff, _config)
+
+#define NV_CSPMU_EVENT_ATTR_4(_pref, _suff, _config)			\
+	NV_CSPMU_EVENT_ATTR_4_INNER(_pref, _0_, _suff, _config),	\
+	NV_CSPMU_EVENT_ATTR_4_INNER(_pref, _1_, _suff, _config + 1),	\
+	NV_CSPMU_EVENT_ATTR_4_INNER(_pref, _2_, _suff, _config + 2),	\
+	NV_CSPMU_EVENT_ATTR_4_INNER(_pref, _3_, _suff, _config + 3)
+
+struct nv_cspmu_ctx {
+	const char *name;
+	u32 filter_mask;
+	u32 filter_default_val;
+	struct attribute **event_attr;
+	struct attribute **format_attr;
+};
+
+static struct attribute *scf_pmu_event_attrs[] = {
+	ARM_CSPMU_EVENT_ATTR(bus_cycles,			0x1d),
+
+	ARM_CSPMU_EVENT_ATTR(scf_cache_allocate,		0xF0),
+	ARM_CSPMU_EVENT_ATTR(scf_cache_refill,			0xF1),
+	ARM_CSPMU_EVENT_ATTR(scf_cache,				0xF2),
+	ARM_CSPMU_EVENT_ATTR(scf_cache_wb,			0xF3),
+
+	NV_CSPMU_EVENT_ATTR_4(socket, rd_data,			0x101),
+	NV_CSPMU_EVENT_ATTR_4(socket, dl_rsp,			0x105),
+	NV_CSPMU_EVENT_ATTR_4(socket, wb_data,			0x109),
+	NV_CSPMU_EVENT_ATTR_4(socket, ev_rsp,			0x10d),
+	NV_CSPMU_EVENT_ATTR_4(socket, prb_data,			0x111),
+
+	NV_CSPMU_EVENT_ATTR_4(socket, rd_outstanding,		0x115),
+	NV_CSPMU_EVENT_ATTR_4(socket, dl_outstanding,		0x119),
+	NV_CSPMU_EVENT_ATTR_4(socket, wb_outstanding,		0x11d),
+	NV_CSPMU_EVENT_ATTR_4(socket, wr_outstanding,		0x121),
+	NV_CSPMU_EVENT_ATTR_4(socket, ev_outstanding,		0x125),
+	NV_CSPMU_EVENT_ATTR_4(socket, prb_outstanding,		0x129),
+
+	NV_CSPMU_EVENT_ATTR_4(socket, rd_access,		0x12d),
+	NV_CSPMU_EVENT_ATTR_4(socket, dl_access,		0x131),
+	NV_CSPMU_EVENT_ATTR_4(socket, wb_access,		0x135),
+	NV_CSPMU_EVENT_ATTR_4(socket, wr_access,		0x139),
+	NV_CSPMU_EVENT_ATTR_4(socket, ev_access,		0x13d),
+	NV_CSPMU_EVENT_ATTR_4(socket, prb_access,		0x141),
+
+	NV_CSPMU_EVENT_ATTR_4(ocu, gmem_rd_data,		0x145),
+	NV_CSPMU_EVENT_ATTR_4(ocu, gmem_rd_access,		0x149),
+	NV_CSPMU_EVENT_ATTR_4(ocu, gmem_wb_access,		0x14d),
+	NV_CSPMU_EVENT_ATTR_4(ocu, gmem_rd_outstanding,		0x151),
+	NV_CSPMU_EVENT_ATTR_4(ocu, gmem_wr_outstanding,		0x155),
+
+	NV_CSPMU_EVENT_ATTR_4(ocu, rem_rd_data,			0x159),
+	NV_CSPMU_EVENT_ATTR_4(ocu, rem_rd_access,		0x15d),
+	NV_CSPMU_EVENT_ATTR_4(ocu, rem_wb_access,		0x161),
+	NV_CSPMU_EVENT_ATTR_4(ocu, rem_rd_outstanding,		0x165),
+	NV_CSPMU_EVENT_ATTR_4(ocu, rem_wr_outstanding,		0x169),
+
+	ARM_CSPMU_EVENT_ATTR(gmem_rd_data,			0x16d),
+	ARM_CSPMU_EVENT_ATTR(gmem_rd_access,			0x16e),
+	ARM_CSPMU_EVENT_ATTR(gmem_rd_outstanding,		0x16f),
+	ARM_CSPMU_EVENT_ATTR(gmem_dl_rsp,			0x170),
+	ARM_CSPMU_EVENT_ATTR(gmem_dl_access,			0x171),
+	ARM_CSPMU_EVENT_ATTR(gmem_dl_outstanding,		0x172),
+	ARM_CSPMU_EVENT_ATTR(gmem_wb_data,			0x173),
+	ARM_CSPMU_EVENT_ATTR(gmem_wb_access,			0x174),
+	ARM_CSPMU_EVENT_ATTR(gmem_wb_outstanding,		0x175),
+	ARM_CSPMU_EVENT_ATTR(gmem_ev_rsp,			0x176),
+	ARM_CSPMU_EVENT_ATTR(gmem_ev_access,			0x177),
+	ARM_CSPMU_EVENT_ATTR(gmem_ev_outstanding,		0x178),
+	ARM_CSPMU_EVENT_ATTR(gmem_wr_data,			0x179),
+	ARM_CSPMU_EVENT_ATTR(gmem_wr_outstanding,		0x17a),
+	ARM_CSPMU_EVENT_ATTR(gmem_wr_access,			0x17b),
+
+	NV_CSPMU_EVENT_ATTR_4(socket, wr_data,			0x17c),
+
+	NV_CSPMU_EVENT_ATTR_4(ocu, gmem_wr_data,		0x180),
+	NV_CSPMU_EVENT_ATTR_4(ocu, gmem_wb_data,		0x184),
+	NV_CSPMU_EVENT_ATTR_4(ocu, gmem_wr_access,		0x188),
+	NV_CSPMU_EVENT_ATTR_4(ocu, gmem_wb_outstanding,		0x18c),
+
+	NV_CSPMU_EVENT_ATTR_4(ocu, rem_wr_data,			0x190),
+	NV_CSPMU_EVENT_ATTR_4(ocu, rem_wb_data,			0x194),
+	NV_CSPMU_EVENT_ATTR_4(ocu, rem_wr_access,		0x198),
+	NV_CSPMU_EVENT_ATTR_4(ocu, rem_wb_outstanding,		0x19c),
+
+	ARM_CSPMU_EVENT_ATTR(gmem_wr_total_bytes,		0x1a0),
+	ARM_CSPMU_EVENT_ATTR(remote_socket_wr_total_bytes,	0x1a1),
+	ARM_CSPMU_EVENT_ATTR(remote_socket_rd_data,		0x1a2),
+	ARM_CSPMU_EVENT_ATTR(remote_socket_rd_outstanding,	0x1a3),
+	ARM_CSPMU_EVENT_ATTR(remote_socket_rd_access,		0x1a4),
+
+	ARM_CSPMU_EVENT_ATTR(cmem_rd_data,			0x1a5),
+	ARM_CSPMU_EVENT_ATTR(cmem_rd_access,			0x1a6),
+	ARM_CSPMU_EVENT_ATTR(cmem_rd_outstanding,		0x1a7),
+	ARM_CSPMU_EVENT_ATTR(cmem_dl_rsp,			0x1a8),
+	ARM_CSPMU_EVENT_ATTR(cmem_dl_access,			0x1a9),
+	ARM_CSPMU_EVENT_ATTR(cmem_dl_outstanding,		0x1aa),
+	ARM_CSPMU_EVENT_ATTR(cmem_wb_data,			0x1ab),
+	ARM_CSPMU_EVENT_ATTR(cmem_wb_access,			0x1ac),
+	ARM_CSPMU_EVENT_ATTR(cmem_wb_outstanding,		0x1ad),
+	ARM_CSPMU_EVENT_ATTR(cmem_ev_rsp,			0x1ae),
+	ARM_CSPMU_EVENT_ATTR(cmem_ev_access,			0x1af),
+	ARM_CSPMU_EVENT_ATTR(cmem_ev_outstanding,		0x1b0),
+	ARM_CSPMU_EVENT_ATTR(cmem_wr_data,			0x1b1),
+	ARM_CSPMU_EVENT_ATTR(cmem_wr_outstanding,		0x1b2),
+
+	NV_CSPMU_EVENT_ATTR_4(ocu, cmem_rd_data,		0x1b3),
+	NV_CSPMU_EVENT_ATTR_4(ocu, cmem_rd_access,		0x1b7),
+	NV_CSPMU_EVENT_ATTR_4(ocu, cmem_wb_access,		0x1bb),
+	NV_CSPMU_EVENT_ATTR_4(ocu, cmem_rd_outstanding,		0x1bf),
+	NV_CSPMU_EVENT_ATTR_4(ocu, cmem_wr_outstanding,		0x1c3),
+
+	ARM_CSPMU_EVENT_ATTR(ocu_prb_access,			0x1c7),
+	ARM_CSPMU_EVENT_ATTR(ocu_prb_data,			0x1c8),
+	ARM_CSPMU_EVENT_ATTR(ocu_prb_outstanding,		0x1c9),
+
+	ARM_CSPMU_EVENT_ATTR(cmem_wr_access,			0x1ca),
+
+	NV_CSPMU_EVENT_ATTR_4(ocu, cmem_wr_access,		0x1cb),
+	NV_CSPMU_EVENT_ATTR_4(ocu, cmem_wb_data,		0x1cf),
+	NV_CSPMU_EVENT_ATTR_4(ocu, cmem_wr_data,		0x1d3),
+	NV_CSPMU_EVENT_ATTR_4(ocu, cmem_wb_outstanding,		0x1d7),
+
+	ARM_CSPMU_EVENT_ATTR(cmem_wr_total_bytes,		0x1db),
+
+	ARM_CSPMU_EVENT_ATTR(cycles, ARM_CSPMU_EVT_CYCLES_DEFAULT),
+	NULL,
+};
+
+static struct attribute *mcf_pmu_event_attrs[] = {
+	ARM_CSPMU_EVENT_ATTR(rd_bytes_loc,			0x0),
+	ARM_CSPMU_EVENT_ATTR(rd_bytes_rem,			0x1),
+	ARM_CSPMU_EVENT_ATTR(wr_bytes_loc,			0x2),
+	ARM_CSPMU_EVENT_ATTR(wr_bytes_rem,			0x3),
+	ARM_CSPMU_EVENT_ATTR(total_bytes_loc,			0x4),
+	ARM_CSPMU_EVENT_ATTR(total_bytes_rem,			0x5),
+	ARM_CSPMU_EVENT_ATTR(rd_req_loc,			0x6),
+	ARM_CSPMU_EVENT_ATTR(rd_req_rem,			0x7),
+	ARM_CSPMU_EVENT_ATTR(wr_req_loc,			0x8),
+	ARM_CSPMU_EVENT_ATTR(wr_req_rem,			0x9),
+	ARM_CSPMU_EVENT_ATTR(total_req_loc,			0xa),
+	ARM_CSPMU_EVENT_ATTR(total_req_rem,			0xb),
+	ARM_CSPMU_EVENT_ATTR(rd_cum_outs_loc,			0xc),
+	ARM_CSPMU_EVENT_ATTR(rd_cum_outs_rem,			0xd),
+	ARM_CSPMU_EVENT_ATTR(cycles, ARM_CSPMU_EVT_CYCLES_DEFAULT),
+	NULL,
+};
+
+static struct attribute *generic_pmu_event_attrs[] = {
+	ARM_CSPMU_EVENT_ATTR(cycles, ARM_CSPMU_EVT_CYCLES_DEFAULT),
+	NULL,
+};
+
+static struct attribute *scf_pmu_format_attrs[] = {
+	ARM_CSPMU_FORMAT_EVENT_ATTR,
+	NULL,
+};
+
+static struct attribute *pcie_pmu_format_attrs[] = {
+	ARM_CSPMU_FORMAT_EVENT_ATTR,
+	ARM_CSPMU_FORMAT_ATTR(root_port, "config1:0-9"),
+	NULL,
+};
+
+static struct attribute *nvlink_c2c_pmu_format_attrs[] = {
+	ARM_CSPMU_FORMAT_EVENT_ATTR,
+	NULL,
+};
+
+static struct attribute *cnvlink_pmu_format_attrs[] = {
+	ARM_CSPMU_FORMAT_EVENT_ATTR,
+	ARM_CSPMU_FORMAT_ATTR(rem_socket, "config1:0-3"),
+	NULL,
+};
+
+static struct attribute *generic_pmu_format_attrs[] = {
+	ARM_CSPMU_FORMAT_EVENT_ATTR,
+	ARM_CSPMU_FORMAT_FILTER_ATTR,
+	NULL,
+};
+
+static struct attribute **
+nv_cspmu_get_event_attrs(const struct arm_cspmu *cspmu)
+{
+	const struct nv_cspmu_ctx *ctx = to_nv_cspmu_ctx(cspmu);
+
+	return ctx->event_attr;
+}
+
+static struct attribute **
+nv_cspmu_get_format_attrs(const struct arm_cspmu *cspmu)
+{
+	const struct nv_cspmu_ctx *ctx = to_nv_cspmu_ctx(cspmu);
+
+	return ctx->format_attr;
+}
+
+static const char *
+nv_cspmu_get_name(const struct arm_cspmu *cspmu)
+{
+	const struct nv_cspmu_ctx *ctx = to_nv_cspmu_ctx(cspmu);
+
+	return ctx->name;
+}
+
+static u32 nv_cspmu_event_filter(const struct perf_event *event)
+{
+	const struct nv_cspmu_ctx *ctx =
+		to_nv_cspmu_ctx(to_arm_cspmu(event->pmu));
+
+	if (ctx->filter_mask == 0)
+		return ctx->filter_default_val;
+
+	return event->attr.config1 & ctx->filter_mask;
+}
+
+enum nv_cspmu_name_fmt {
+	NAME_FMT_GENERIC,
+	NAME_FMT_SOCKET
+};
+
+struct nv_cspmu_match {
+	u32 prodid;
+	u32 prodid_mask;
+	u64 filter_mask;
+	u32 filter_default_val;
+	const char *name_pattern;
+	enum nv_cspmu_name_fmt name_fmt;
+	struct attribute **event_attr;
+	struct attribute **format_attr;
+};
+
+static const struct nv_cspmu_match nv_cspmu_match[] = {
+	{
+	  .prodid = 0x103,
+	  .prodid_mask = NV_PRODID_MASK,
+	  .filter_mask = NV_PCIE_FILTER_ID_MASK,
+	  .filter_default_val = NV_PCIE_FILTER_ID_MASK,
+	  .name_pattern = "nvidia_pcie_pmu_%u",
+	  .name_fmt = NAME_FMT_SOCKET,
+	  .event_attr = mcf_pmu_event_attrs,
+	  .format_attr = pcie_pmu_format_attrs
+	},
+	{
+	  .prodid = 0x104,
+	  .prodid_mask = NV_PRODID_MASK,
+	  .filter_mask = 0x0,
+	  .filter_default_val = NV_NVL_C2C_FILTER_ID_MASK,
+	  .name_pattern = "nvidia_nvlink_c2c1_pmu_%u",
+	  .name_fmt = NAME_FMT_SOCKET,
+	  .event_attr = mcf_pmu_event_attrs,
+	  .format_attr = nvlink_c2c_pmu_format_attrs
+	},
+	{
+	  .prodid = 0x105,
+	  .prodid_mask = NV_PRODID_MASK,
+	  .filter_mask = 0x0,
+	  .filter_default_val = NV_NVL_C2C_FILTER_ID_MASK,
+	  .name_pattern = "nvidia_nvlink_c2c0_pmu_%u",
+	  .name_fmt = NAME_FMT_SOCKET,
+	  .event_attr = mcf_pmu_event_attrs,
+	  .format_attr = nvlink_c2c_pmu_format_attrs
+	},
+	{
+	  .prodid = 0x106,
+	  .prodid_mask = NV_PRODID_MASK,
+	  .filter_mask = NV_CNVL_FILTER_ID_MASK,
+	  .filter_default_val = NV_CNVL_FILTER_ID_MASK,
+	  .name_pattern = "nvidia_cnvlink_pmu_%u",
+	  .name_fmt = NAME_FMT_SOCKET,
+	  .event_attr = mcf_pmu_event_attrs,
+	  .format_attr = cnvlink_pmu_format_attrs
+	},
+	{
+	  .prodid = 0x2CF,
+	  .prodid_mask = NV_PRODID_MASK,
+	  .filter_mask = 0x0,
+	  .filter_default_val = 0x0,
+	  .name_pattern = "nvidia_scf_pmu_%u",
+	  .name_fmt = NAME_FMT_SOCKET,
+	  .event_attr = scf_pmu_event_attrs,
+	  .format_attr = scf_pmu_format_attrs
+	},
+	{
+	  .prodid = 0,
+	  .prodid_mask = 0,
+	  .filter_mask = NV_GENERIC_FILTER_ID_MASK,
+	  .filter_default_val = NV_GENERIC_FILTER_ID_MASK,
+	  .name_pattern = "nvidia_uncore_pmu_%u",
+	  .name_fmt = NAME_FMT_GENERIC,
+	  .event_attr = generic_pmu_event_attrs,
+	  .format_attr = generic_pmu_format_attrs
+	},
+};
+
+static char *nv_cspmu_format_name(const struct arm_cspmu *cspmu,
+				  const struct nv_cspmu_match *match)
+{
+	char *name;
+	struct device *dev = cspmu->dev;
+
+	static atomic_t pmu_generic_idx = {0};
+
+	switch (match->name_fmt) {
+	case NAME_FMT_SOCKET: {
+		const int cpu = cpumask_first(&cspmu->associated_cpus);
+		const int socket = cpu_to_node(cpu);
+
+		name = devm_kasprintf(dev, GFP_KERNEL, match->name_pattern,
+				       socket);
+		break;
+	}
+	case NAME_FMT_GENERIC:
+		name = devm_kasprintf(dev, GFP_KERNEL, match->name_pattern,
+				       atomic_fetch_inc(&pmu_generic_idx));
+		break;
+	default:
+		name = NULL;
+		break;
+	}
+
+	return name;
+}
+
+int nv_cspmu_init_ops(struct arm_cspmu *cspmu)
+{
+	u32 prodid;
+	struct nv_cspmu_ctx *ctx;
+	struct device *dev = cspmu->dev;
+	struct arm_cspmu_impl_ops *impl_ops = &cspmu->impl.ops;
+	const struct nv_cspmu_match *match = nv_cspmu_match;
+
+	ctx = devm_kzalloc(dev, sizeof(struct nv_cspmu_ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	prodid = FIELD_GET(ARM_CSPMU_PMIIDR_PRODUCTID, cspmu->impl.pmiidr);
+
+	/* Find matching PMU. */
+	for (; match->prodid; match++) {
+		const u32 prodid_mask = match->prodid_mask;
+
+		if ((match->prodid & prodid_mask) == (prodid & prodid_mask))
+			break;
+	}
+
+	ctx->name		= nv_cspmu_format_name(cspmu, match);
+	ctx->filter_mask	= match->filter_mask;
+	ctx->filter_default_val = match->filter_default_val;
+	ctx->event_attr		= match->event_attr;
+	ctx->format_attr	= match->format_attr;
+
+	cspmu->impl.ctx = ctx;
+
+	/* NVIDIA specific callbacks. */
+	impl_ops->event_filter			= nv_cspmu_event_filter;
+	impl_ops->get_event_attrs		= nv_cspmu_get_event_attrs;
+	impl_ops->get_format_attrs		= nv_cspmu_get_format_attrs;
+	impl_ops->get_name			= nv_cspmu_get_name;
+
+	/* Set others to NULL to use default callback. */
+	impl_ops->event_type			= NULL;
+	impl_ops->event_attr_is_visible		= NULL;
+	impl_ops->get_identifier		= NULL;
+	impl_ops->is_cycle_counter_event	= NULL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nv_cspmu_init_ops);
diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.h b/drivers/perf/arm_cspmu/nvidia_cspmu.h
new file mode 100644
index 000000000000..eefba85644f6
--- /dev/null
+++ b/drivers/perf/arm_cspmu/nvidia_cspmu.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
+ *
+ */
+
+/* Support for NVIDIA specific attributes. */
+
+#ifndef __NVIDIA_CSPMU_H__
+#define __NVIDIA_CSPMU_H__
+
+#include "arm_cspmu.h"
+
+/* Allocate NVIDIA descriptor. */
+int nv_cspmu_init_ops(struct arm_cspmu *cspmu);
+
+#endif /* __NVIDIA_CSPMU_H__ */
-- 
2.17.1

