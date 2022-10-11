Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6305FBCD3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 23:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiJKVZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 17:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiJKVZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 17:25:13 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D275FDCE;
        Tue, 11 Oct 2022 14:25:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcYgq7I+DqtcuO52J9XFocFOmgFpGaa9nhaUO5JqhW3tfIsYDcyE3cH4XnUilA+ko74Fsyuh97+EFxpR40sRkq209F0gaihr/1rzeyE1qEWJ+hXfXX7ZN80W2Nxh+hYCAOmLwFybZNcwFW8CBHsIG2cm+cyK8qitC65gpHYBFZXC1fDtM9oAf79WMx7xJpAGo8uzKFnbRqxUlH8lg9QUPssxK5QlOrVBYYeWaOrKIwMOcWP0rEQK6m8mxgwg/n6SLiZT0CyPD5UcnNW40lsU0s1rRK6zR+1/frQiQOR7fNp6qJo7KbnsoRKRLdKy7BJ9YbJtgyz/wnrR76nIHXoPaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XV8l2OwOJdabB3SGPgW3bMqJM5AOnct9ze+Iuw11jo=;
 b=dFkse4T6P/LA8HfQunba/ig7Aq713qqo0SfUHuA6gkXyY7M70+7a9I/H9OpRASEkxSJ+EAWVtUBNopwk2VTTr40y61s/CJH0jxkQPlBKtLaKKoTFoM8CqW0YLoBH/bNGSx0+5MZfCAwki/VSTuIM9hKnST+sqIRH5FUP2OICGF43OVW+6lF7GmspRg2LAdIMV8SM6wcYRwc1L2Sfss9lI4LZaCpnRJn/00aq0lGeFGGKYR8zvmmmj5/rj9GeE5uvy8WbsB5k+cJYk36caj3oso7fb32qzPj9sSH1/xBn5q2K4mmVdV4QzcoHuFLCKwWpo8z9dFcHyGnPvwtOB/LZsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XV8l2OwOJdabB3SGPgW3bMqJM5AOnct9ze+Iuw11jo=;
 b=4UbHVwOgjuhnbKbcfKKT6UD3TsWUou737kLosWNo4No7c8lY5+is8rDtIkz2japrix5TJiST1h23yVK08YRJHLl/zvhJiww/KUIooOZ9bMHlzzblRuOG62Toqoq3o9B12RdLNviwWRVL0N0QJ2N6vjLf7LetVeevAnk4jIzIyXM=
Received: from MW2PR16CA0021.namprd16.prod.outlook.com (2603:10b6:907::34) by
 SA1PR12MB6680.namprd12.prod.outlook.com (2603:10b6:806:253::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Tue, 11 Oct
 2022 21:25:09 +0000
Received: from CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::ab) by MW2PR16CA0021.outlook.office365.com
 (2603:10b6:907::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Tue, 11 Oct 2022 21:25:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT114.mail.protection.outlook.com (10.13.174.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 11 Oct 2022 21:25:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 16:25:08 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 16:25:07 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 11 Oct 2022 16:25:07 -0500
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@amd.com>
CC:     <linux-remoteproc@vger.kernel.org>,
        Tanmay Shah <tanmay.shah@amd.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v10 0/6]  Add Xilinx RPU subsystem support
Date:   Tue, 11 Oct 2022 14:24:55 -0700
Message-ID: <20221011212501.2661003-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT114:EE_|SA1PR12MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bbe7645-9765-40dc-afea-08daabcf12f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tHp1VulkegaPHmS9W6A91P6A7yJ4LtdoIoa+5+apKrzDxE58F8vWrtkVwH0xXvWOqKVdlTSrNiAzwUn2EOBLaqOLMZ5bR/gYr2kpLgJxcPW68lh6vjro57st8AeQJNqV6wwsu4CVR5j5qFD0fhb/7LT8v2WOeA4eNI7cezpLnybpHJJTjdNW2WY6/lEwXzxiitwbDPxrR9Isv76S8VypMcuMGHX4ugtPXgz2GVl+rd9ktVSLoGqCVdNau/4NS/2QL/j5/IcMXGU8eWhLsqCywGF3cu4IXcd3CMt1tP693faWvPPk9omhrEc+WEelQdBEcCM5bdeitljWEW4mu1oAGAQC+Txh16clydZ4W6dY6PoW6oZYVXSINlVOe7WFxIFRyUAjQSlrciYF2/A6+vKnzjBVEFlD/7aRjP+a51QkwFN6gvAZ0RBOcLRQP18OWorO0ykCDFvWPkdL/pbhZMy2j7B2KTtFHdOOBoeknmEM7fKYWmlNMLd337tQcpQuGs+DKnOShvzWJGyAWw1PUinhCok9eiO/uQEkcPH1JRUFeT769kuw10yaBSqll/ilYK/rQZz7BH6ZgOwh4Mx9Xdd33yCUxP2DTKQdaX6et4YGwGL8mlKLbANYs3DCUUvFl5NxGoYUHHhcmxwui37i6/bZZ1liXaVGnOCkg3yU1QXYfyvlWLI30KWF+s5frSE4atO63cGgtTqBRjY6rmxPTnng24CZvR45a+9CSS8PyYhPxy86RAQFBgyu+/7eq3615wkfzCfaxsSHAXjFfvwo76nivrR5X888NIBGzFuMdh4IbcIoPfmjx4K8ypJDsTz3bRgo
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(81166007)(40480700001)(356005)(82310400005)(86362001)(36756003)(47076005)(83380400001)(82740400003)(426003)(4326008)(8676002)(36860700001)(110136005)(40460700003)(5660300002)(478600001)(54906003)(6636002)(316002)(70586007)(6666004)(41300700001)(2906002)(44832011)(8936002)(70206006)(26005)(1076003)(186003)(2616005)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 21:25:08.9299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bbe7645-9765-40dc-afea-08daabcf12f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6680
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds bindings document for RPU subsystem found on Xilinx
ZynqMP platforms. It also adds device nodes and driver to enable RPU
subsystem in split mode and lockstep mode.

Xilinx ZynqMP platform contains Remote Processing Unit(RPU). RPU subsystem
contains two arm cortex r5f cores. RPU subsystem can be configured in
split mode, lockstep mode and single-cpu mode.

RPU subsystem also contains 4 Tightly Coupled Memory(TCM) banks.
In lockstep mode, all 4 banks are combined and total of 256KB memory is
made available to r5 core0. In split mode, both cores can access two
TCM banks i.e. 128 KB.

RPU can also fetch data and execute instructions from DDR memory along with
TCM memory.
---

Changes in v10:
  - bindings: rename example node to remoteproc
  - dts: Rename node name to remoteproc
  - switch to AMD email ID 
  - fix Kconfig unmet dependecy error reported by kernel test robot
  - fix r5_rproc object mem leak in function zynqmp_r5_add_rproc_core
  - add explanation of hardcoded TCM nodes
  - remove redundant ToDo comment
  - remove redundant check of tcm_bank_count and rmem_count
  - remove explicit free reserved_mem in zynqmp_r5_get_mem_region_node
  - fix leaked reference of child_dev during zynqmp_r5_cluster_init
    Also fix possible crash in exit path release_r5_cores 
  - do not remove mem-region and tcm carveouts explicitly in case of failure.
    It will be deleted as part of rproc_del. This also simplifies logic to
    use rproc_add_carveout
  - fix documentation all over the driver

Changes in v9:
  - bindings: remove power-domains property description
  - bindings: fix nitpicks in description of properties
  - dts: remove unused labels
  - replace devm_rproc_alloc with rproc_alloc
  - %s/until/while/r
  - %s/i > -1/i >=0/r
  - fix type of tcm_mode from int to enum rpu_tcm_comb
  - release &child_pdev->dev references
  - remove zynqmp_r5_core_exit()
  - undefined memory-region property isn't failure
  - remove tcm bank count check from ops
  - fix tcm bank turn-off sequence
  - fix parse_fw function documentation
  - do not use rproc_mem_entry_init on vdev0buffers
  - check tcm banks shouldn't be 0
  - declare variabls in reverse xmas tree order
  - remove extra line

Changes in v8:
  - add 'items:' for sram property

Changes in v7:
  - Add minItems in sram property

Changes in v6:
  - Add maxItems to sram and memory-region property

Changes in v5:
  - Add constraints of the possible values of xlnx,cluster-mode property
  - fix description of power-domains property for r5 core
  - Remove reg, address-cells and size-cells properties as it is not required
  - Fix description of mboxes property
  - Add description of each memory-region and remove old .txt binding link
    reference in the description
  - Remove optional reg property from r5fss node
  - Move r5fss node out of axi node

Changes in v4:
  - Add memory-region, mboxes and mbox-names properties in dt-bindings example
  - Add reserved memory region node and use it in Xilinx dt RPU subsystem node
  - Remove redundant header files
  - use dev_err_probe() to report errors during probe
  - Fix missing check on error code returned by zynqmp_r5_add_rproc_core()
  - Fix memory leaks all over the driver when resource allocation fails for any core
  - make cluster mode check only at one place
  - remove redundant initialization of variable
  - remove redundant use of of_node_put() 
  - Fix Comment format problem
  - Assign offset of zynqmp_tcm_banks instead of duplicating it
  - Add tcm and memory regions rproc carveouts during prepare instead of parse_fw
  - Remove rproc_mem_entry object from r5_core
  - Use put_device() and rproc_del() APIs to fix memory leaks
  - Replace pr_* with dev_*. This was missed in v3, fix now.
  - Use "GPL" instead of "GPL v2" in MODULE_LICENSE macro. This was reported by checkpatch script.

Changes in v3:
  - Fix checkpatch script indentation warning
  - Remove unused variable from xilinx remoteproc driver
  - use C style comments, i.e /*...*/
  - Remove redundant debug information which can be derived using /proc/device-tree
  - Fix multiline comment format
  - s/"final fot TCM"/"final for TCM"
  - Function devm_kzalloc() does not return an code on error, just NULL.
    Remove redundant error check for this function throughout the driver.
  - Fix RPU mode configuration and add documentation accordingly
  - Get rid of the indentations to match function documentation style with rest of the driver
  - Fix memory leak by only using r5_rproc->priv and not replace it with new instance
  - Use 'i' for the outer loop and 'j' for the inner one as per convention
  - Remove redundant error and NULL checks throughout the driver
  - Use devm_kcalloc() when more than one element is required
  - Add memory-regions carveouts during driver probe instead of parse_fw call
    This removes redundant copy of reserved_mem object in r5_core structure.
  - Fix memory leak by using of_node_put()
  - Fix indentation of tcm_mem_map function args
  - Remove redundant init of variables
  - Initialize tcm bank size variable for lockstep mode
  - Replace u32 with phys_addr_t for variable stroing memory bank address
  - Add documentation of TCM behavior in lockstep mode
  - Use dev_get_drvdata instead of platform driver API
  - Remove info level messages
  - Fix checkpatch.pl warnings
  - Add documentation for the Xilinx r5f platform to understand driver design

Changes in v2:
  - Remove proprietary copyright footer from cover letter


Ben Levinsky (3):
  firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU
    configuration.
  firmware: xilinx: Add shutdown/wakeup APIs
  firmware: xilinx: Add RPU configuration APIs

Tanmay Shah (3):
  dt-bindings: remoteproc: Add Xilinx RPU subsystem bindings
  arm64: dts: xilinx: zynqmp: Add RPU subsystem device node
  drivers: remoteproc: Add Xilinx r5 remoteproc driver

 .../bindings/remoteproc/xlnx,r5f-rproc.yaml   |  135 +++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   32 +
 drivers/firmware/xilinx/zynqmp.c              |   97 ++
 drivers/remoteproc/Kconfig                    |   13 +
 drivers/remoteproc/Makefile                   |    1 +
 drivers/remoteproc/xlnx_r5_remoteproc.c       | 1070 +++++++++++++++++
 include/dt-bindings/power/xlnx-zynqmp-power.h |    6 +
 include/linux/firmware/xlnx-zynqmp.h          |   60 +
 8 files changed, 1414 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
 create mode 100644 drivers/remoteproc/xlnx_r5_remoteproc.c


base-commit: abac55caaeaaabd31763a7c8a79c4cc096b415ae
-- 
2.25.1

