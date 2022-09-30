Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843BC5F02DE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 04:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiI3Cfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 22:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiI3CfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 22:35:21 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6833E140B1;
        Thu, 29 Sep 2022 19:35:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJSIXd7nFHtsV4ilYwlf446PAaVm813KWVU/trFinxQ/Zvo93zq94ISJ8OqhafpcPxnjXV+gShYOcR5G5n6C0tKBuWhrR+yXCIcEEdgtuqCYejxctjGpU9o883VGMPToobcHHUKh+3OXZu6GAIlq3Sqw8AphxqQ/G0eDiU9pX/NOl82hLhddalaU1bU+8I9bX1BCA5nFTY5gq54TPJIbBRhL6htGGQ14nqzM4176LJi25GV+IV7IaClZFDVoBkeDa+5s0hdcD7FBFCbmluszwtvnsat6TJY5apKG01rAkHVcfRklQfz99Neo3j2CB/AGbOjBLH8o8zinxvS68v4OQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/j9rgOwBoe0f42HW2CLwedfHMYDYyowwYjRanVRaUzI=;
 b=Jjkp1pguO/Wdn2Gkdo7ETWTzAK7fAvnY9yHZEISfb4b2RujXLoK1g7FsIHjcA87Dd7ohROgkpbkhKFL/ZttO5fW2EugWxflOvzpZGOOFgohA0Ei0ICOKovyiSVND6csZJVqXRfOL+YHffHXWJA8OFNK8ORVCQZJLuKlabMu2pcyDq0MwkFd38n0TDK4TXMHqf2vB4tC4101ha2Hgtb2rQTP1apqw/o95BAlW/ThR6MesxCOxRKkC5lHILAOeeo1i8iiv+gVsiYo6r2wL12bpudx9SeevGZgvwufLMulJXUSyhrAtdtOb2SqJd7Z7GZ17hupXK0QJSeeWtrJH9/sbtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/j9rgOwBoe0f42HW2CLwedfHMYDYyowwYjRanVRaUzI=;
 b=Tv1X0vlKqzVnwlR36qVZsCgGts8OqmTm6DnaIfRzw2qzGLlDPci2/8kL6eaXm/ukFs2iAylNS/kp2Rm/QH+G9th62q8TICsQARx8nQ338zbJnyCPJPa4RtGkqmBMNQqQUPY/zoq/HQjnACtc8NaYHyKuGYsPJ7fNeylwo4l52lfS++iLLDS64D3QBCFiiTajvL7wcUwj8uDHMpdUbISVLmKt3ImhuhyKrU47j60r8oAJOpxBHn2jS5yuW4gwDRtKv3ElPlmGJ4S7u/335h+s9e1rx4B4DhInDkCV+qPbTDVOSafBGcUIOZPzpNkqkJ6AIp+UY4M9W8v4xzibL531pg==
Received: from MW4PR04CA0358.namprd04.prod.outlook.com (2603:10b6:303:8a::33)
 by MW4PR12MB6729.namprd12.prod.outlook.com (2603:10b6:303:1ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Fri, 30 Sep
 2022 02:35:17 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::63) by MW4PR04CA0358.outlook.office365.com
 (2603:10b6:303:8a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Fri, 30 Sep 2022 02:35:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Fri, 30 Sep 2022 02:35:17 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 29 Sep
 2022 19:35:08 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 29 Sep
 2022 19:35:07 -0700
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 29 Sep 2022 19:35:06 -0700
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
Subject: [PATCH v6 2/2] perf: arm_cspmu: Add support for NVIDIA SCF and MCF attribute
Date:   Thu, 29 Sep 2022 21:34:43 -0500
Message-ID: <20220930023443.9463-3-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220930023443.9463-1-bwicaksono@nvidia.com>
References: <20220930023443.9463-1-bwicaksono@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT065:EE_|MW4PR12MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c5b6f48-f483-4745-273f-08daa28c695e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CglqwAhT3jXhqytt5jr/wGlhQnaQ3nlGFv4MySj30mQyK4UphsMsI8BO2DXD5eiN4vZX2Xf0BKioybYrIiZ9+X8SbBjJYQTfU+4Bot9yOmr0300WNXSHIzMffginlUWqCJjcHMatf6z36aalfkz/gdOXxd4A0qszcokHCO+30pg1uSmc+DlgHGxmJOAC74jY7FTKkPTQArwU8OiGa1UzL3CRLxpZfhXH04JiaDsnrYEflRScir+0t/jOfvIplNXve26t7dk3ZgS5+PNN5BnUxa4WV7eLXrJf0tCDE6JmQ6y1X/j6ARqH6A7K28PuUjqy/QZ12Qo1oF/aaFCGza1DS+0cltIRPoSuBWZY0r+07+Xk7mZx8t4u8SLhqWv3AHBSW/8BGovaSuhI7mxXyiZSmQFL1EhatVCOTKG6n5iXwfJgGIwk8AaVBPXxv06ea7h7MaaofMQxMaEXP5T2r6z8pX3UodlEjMq13eWy5R7FUFtuR7JPczq4bMRyyVqzxeFVndtBvxkTF0HtZ5g6Jwql/X3V3+kPcuP9i/P0JTFR7Iy1m9+GRMXOsbjEKGDeUuzVTK8ssjgpHUcO/Zs/Dzgkyjts59EjiUY/et+81bY9rtKwfiNs2y5GYb5e0Dkp+ca6awD5R7wupxMdod6AGdMa5TmVVleyFREYbvEA1zDYfLj1V77g616xW4f6t8bxAVcmyjrNNw1gcRlQT23QKHieqtfc6hGnAbC583i9RUpNsL8nUeeIJCdvEdpL6P7zqgCJOBxU7Y0VOwzMFrqqmIELKw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199015)(36840700001)(46966006)(40470700004)(70586007)(8936002)(30864003)(70206006)(8676002)(4326008)(7416002)(2906002)(41300700001)(40480700001)(5660300002)(36860700001)(36756003)(82310400005)(40460700003)(83380400001)(356005)(7636003)(316002)(7696005)(47076005)(6666004)(107886003)(86362001)(186003)(54906003)(110136005)(1076003)(478600001)(26005)(426003)(2616005)(82740400003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 02:35:17.1527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5b6f48-f483-4745-273f-08daa28c695e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6729
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
index 8ec3b55b5539..8ce614d5b907 100644
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
@@ -382,6 +386,11 @@ struct impl_match {
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

