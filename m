Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B54628D94
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237024AbiKNXkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiKNXkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:40:49 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D2010041;
        Mon, 14 Nov 2022 15:40:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQL7HivcnLGQJYwYrBwCu0L68++TvWx7eDKfk4sXHrDAcSfbG5i3ymLtBxHi3d+ksYJsDjD+Y55e9OoOfOS4mVe9ZRVkT/7dg+PuFgAmDguKbkz+h91luhxBcbFtIve67LkNGtQGYUbyQSm9prx1nHMJW3rxkoW0ErG17pj5b/4xVsgp29PUHrbIqZKXsn5FINPRjOWwUNXurLXm/zkI0FYs7TZCE+cHvCi0XNgaz5DyAJldmehV0woRedidDxFpWK0zZRII79EVqy9e8XtrU2mQzxGNsdrDK0Uy9eVWtyZ2ooc0LsGG7AmAK+L+M0UT3+1w5iP0hBTVQXjfCAh4UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1iTKEMkB1E+3tWeCkczN86Ml4cdBXUOPXKWI9iqcTc=;
 b=i8xOzbx3vr6wUfps1sAPadkyh5yI8jO0Yw/Yx1xJt4fj+vxL3/nNkpJLh8GDlQAUtmvgL5hsQo/BgnCk47MDjDSlap2p+ybmkKBvCfvCYcE/siZir4YHZs0fxOocAMIcjAMGNFsVFEpTKn+zhkQuZZ2G3p7m8Vf5AVmjIFyaO0T6uddapPs2bTTY4CerRyXjQ+Fg+0K2IOxDrNPcTM1Zibvw0n5MmbZjkf4CSpJ4/ANNz1wbzkrivuABrMoY/S8SKOYbdk2kHwcPD133D4LxhuYDKSDXlOsJ//dkARcOVPpSVGThcyLcQf3k7fqwY018hTtsrhd4D9+gJh2qvF+F/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1iTKEMkB1E+3tWeCkczN86Ml4cdBXUOPXKWI9iqcTc=;
 b=ZEDbufpuz8LcnW4YlhjN32/4bSbbyBIUZLa3ynpOew7pwonmptcNN/cPW68bwpRkHLqAYb+DS36RDrqNEXswIEfvO9Juo4lUJy0fRJCd0/Y4eGQ2VdvWVMor09hsuf6prx8tKMSuyrbhO2Ea6QD15RqD78UPNeIYN7mvJijhbS0=
Received: from DM6PR06CA0052.namprd06.prod.outlook.com (2603:10b6:5:54::29) by
 BN9PR12MB5081.namprd12.prod.outlook.com (2603:10b6:408:132::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 23:40:43 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::26) by DM6PR06CA0052.outlook.office365.com
 (2603:10b6:5:54::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Mon, 14 Nov 2022 23:40:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Mon, 14 Nov 2022 23:40:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 14 Nov
 2022 17:40:42 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 14 Nov
 2022 17:40:42 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 14 Nov 2022 17:40:41 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <michal.simek@amd.com>
CC:     <bill.mills@linaro.org>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v11 0/6] Add Xilinx RPU subsystem support
Date:   Mon, 14 Nov 2022 15:39:34 -0800
Message-ID: <20221114233940.2096237-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT027:EE_|BN9PR12MB5081:EE_
X-MS-Office365-Filtering-Correlation-Id: 4251e5d5-1853-41ba-8a9b-08dac699a555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rpSsc4H+MXM7gNYhMIbXlGiKskh1wKhrqum9Q1AKlKBAKdUmIxS1pj/u74B33acld8YoQSLhCU33FA7qtIPN41RFoBss3o3tM/FEcSmmMubdk6R9z6dd6jPyr2DYt8dZ+D1RsHqDkD1A2cL55f+cN5oeLhc9wJyisJtr83QJr2hyp9tt4yR7oEsS/omFF3UWdGNM4S2w/wJSvdqkOCj2VS3A0/fiX1tT3JX5hHX4lzwqVSEHlsAaOBYUSEo4H5KdyBwKKWwtlOXqYs1neT4GTzBXRoC6TW5JwA48PipsMvDnqRIBxqcutxVEkU398DRSWUh/ShQ+CUOO+HgkJFXm1+O9D7jgFV5cgDVG0Mrk0nAkaQkW03eiEOhOmevTXijrStjovBF3oAsHqkKiMqDdlV/rwuBWpqHlHdYbvihuEwsdYYdoq5aXwdbp6W+uXGAHcvqa2Ur6LCH4W0qvP8djXEjUV4/z9kfOdMHAeGELZit/qrKtMD+yt+PyWBHnuqLOVSv4nBnFl1m3qP90w9bJf96eH0pbymTEEGlcwESg1NHuqG72ksQrLb+LH+hQ3Tr2koOH332exiI90MYsIDAS70SsWNNP77G/vQzz0FFepzYDp20dEJ0fufdtTUhUeB2HQxpqKTX7c5xuXeY8o0I7ksy33vYMB8Xtjfkf8Po99sQSBCzLc9RdKBveX07KxDiN+4hZTK3twyGfaey1fYo5zUhOo9u6ymlJWEa7NdjaFo3uu7F1I7wbB3mMrynkgVeu18QLMcgfQAcvIrbaAZJ4UKv9Cn4DwU7kWtwS+rmSSrXWIccEK/skPGFcoLnN/Fsn
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199015)(36840700001)(46966006)(40470700004)(6666004)(26005)(40480700001)(6636002)(110136005)(54906003)(316002)(36756003)(478600001)(36860700001)(47076005)(82740400003)(81166007)(40460700003)(186003)(426003)(1076003)(336012)(2906002)(2616005)(86362001)(356005)(82310400005)(83380400001)(70206006)(8936002)(41300700001)(8676002)(44832011)(70586007)(4326008)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 23:40:43.1707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4251e5d5-1853-41ba-8a9b-08dac699a555
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5081
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

Changes in v11:
  - rename binding filename to match with compatible string
  - change $id: value accordingly as well
  - Rebase on latest rproc-next branch and resolve merge conflicts
  - remove redundant < 0 check for function of_get_available_child_count()
  - return 'ret' variable rather than masking the real error code when
    parsing "xlnx,cluster-mode" property fails
  - remove redundant use of devm_free()
  - call  of_reserved_mem_device_release() to release reserved memory
    in case driver probe fails or driver is removed.

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

 .../remoteproc/xlnx,zynqmp-r5fss.yaml         |  135 +++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   33 +
 drivers/firmware/xilinx/zynqmp.c              |   97 ++
 drivers/remoteproc/Kconfig                    |   13 +
 drivers/remoteproc/Makefile                   |    1 +
 drivers/remoteproc/xlnx_r5_remoteproc.c       | 1067 +++++++++++++++++
 include/dt-bindings/power/xlnx-zynqmp-power.h |    6 +
 include/linux/firmware/xlnx-zynqmp.h          |   60 +
 8 files changed, 1412 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
 create mode 100644 drivers/remoteproc/xlnx_r5_remoteproc.c


base-commit: 6eed169c7fefd9cdbbccb5ba7a98470cc0c09c63
-- 
2.25.1

