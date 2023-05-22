Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C425D70C1AC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjEVPAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbjEVPAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:00:06 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4071B9;
        Mon, 22 May 2023 08:00:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxQd1nJIxoY+DUuXgOfdMaOODt7woBY8ExUOWgfcuHixUY//iYVmmvQgCbIHUsWGMEesk3dDg6Jda4r2eyTTqWXAnXcutowljOg5qwzaWRhCmZsDRJzNAfawQnmSQHZUu/TIeeo2dQUUyGypnHNB6tGw7/levWyjp26uy1EE0NfqJhbW5W6Jmi7feEfXc6HWjuUomCa/D9cIlrewL9uMgIcAVvefl8zR6DLsYNlsF/P8mcWMUJxl9HE6BO/ac+HQkmdVYwG7AOS9Mr6SpFy/1Cd5briONEfpDqvJ4mPqUaI/KN5pUaMhNvtkq/KiR0ar6HCBXqLECtHWNTqgHgSLRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XDivpO4Z/k8ZgRlSLNpT9uzWI17+c8TXwKsXgnDy/w=;
 b=KAXha0y5RaTt2/rl5kUm4+Z7wjuLvPhO+m9YHFwPh7bJ957Uf0RshXxV6jJWr2vYDvbhohZlueNN3erRYgUY8gR32rQL2tM7RnbJniYel2gjtvbT5qahFmqjftnVuLgsfVJXYdqFPyHPX+lgdKSEEh+uIITOx8d4ONBZUlgaAXuqzKAWPZil9MlrQM2bMDtoQa9tTYBGgT/OIO3FWPwjyeAXc+ZOIhwbusdtB+KctyjucezIVxJywATvkZ6YRJ3uXjHJ/qZY6iPHcp6MafOSWXq/8pcdi9oaehf5k935sbCxFu44s43B5ACbscRNuOTt/gDbW7wOjT6A/aqrqz5KHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XDivpO4Z/k8ZgRlSLNpT9uzWI17+c8TXwKsXgnDy/w=;
 b=UnUuhBItQhn/7yRYST9HZhtbrWitoir4m8X1r532xid1KlL7jCSyQy4I8xVS0mDMxSMwmLgyLL5t/97NCxMXSe53wRD248Kbwd3CSss1ur+y2vL6/pi7dCudYcwZSByYCt8TKltaoQzW+eXg0jrcaX17R6gv6jjQE7N2sJGawEM=
Received: from DS7PR03CA0318.namprd03.prod.outlook.com (2603:10b6:8:2b::32) by
 SJ2PR12MB8980.namprd12.prod.outlook.com (2603:10b6:a03:542::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 14:59:57 +0000
Received: from DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::e1) by DS7PR03CA0318.outlook.office365.com
 (2603:10b6:8:2b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Mon, 22 May 2023 14:59:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT069.mail.protection.outlook.com (10.13.173.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.28 via Frontend Transport; Mon, 22 May 2023 14:59:57 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 22 May
 2023 09:59:56 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Andrew Davis <afd@ti.com>,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Harini Katakam" <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Parth Gajjar <parth.gajjar@amd.com>,
        "Piyush Mehta" <piyush.mehta@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Robert Hancock" <robert.hancock@calian.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 0/6] arm64: zynqmp: Misc zynqmp changes
Date:   Mon, 22 May 2023 16:59:47 +0200
Message-ID: <cover.1684767562.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2207; i=michal.simek@amd.com; h=from:subject:message-id; bh=D1e3i1LJtDukMc8gk5rL8Xfy25m3R0C9pfK51qUQstA=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpTs5thYQ55e0ZmbQmTmM/VIz8z3OZm7fKv++QU8xY13B Zz33zjcEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACZyR49hnvk23eONrAt2Ln63 XXXh78qUR6bT5jHM4dgrIyMSddJMKeQq2zr7Fo7nAkU3AQ==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT069:EE_|SJ2PR12MB8980:EE_
X-MS-Office365-Filtering-Correlation-Id: f7ba4e78-3bf5-402c-7b7b-08db5ad53589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: awzXnwGO4lFPWKuiDuVGbt/rJHwVjEUvKSQfp/x++/Cr5Lzdg0FvuODxNF3AeMipGy1TR/O+VW5bLXbLBzP33qF7BARwhfblaPPgeSH2WI61hABk1QKHy9zJj640Sqo2kV6OxUEkETpkk60FU5xSoOF+S8P1x2JrioZJ158qELdiiskS2GqFSqUE2EdUVyYp633Mba3In316lcLGa3qaiNnhJsojnpWEyWl6lQrV9YpU0/kZfmp/VQiUVZSBGm0OOOfDbDtSkUEfcvZai1GyljY8TQyK5UUb2tPn9EOJN24c2sCdlhZGb8+BQBjqYvP5YOFg5r3pMqOV72DFtwFJpHPGFLUyGbdClB0kfMuPazem6RJLo6QPI0TqmtxmUFFXatx/3+ddVIbxQ7JrawOYMVsNfH8iHiHphNscd131KAuuJ7Gv+4vtaY/z972jyjXs8DI+WKboqCgRUwqMG6BzaEQGfw9kyKZo5fr2vrwNAAp/kJkilw4Xc1LIlc9BmjfdrbyxKiGZRf3EAIhPY7UZKeiaAPD9edaBOL2X20l1XD6Arf/nQdNDrFrHc1rNoxwGKjI9iWAopnz6rJENMWUgMmCxPfsvdZkxi5VWG9rFm8d3Y/yKaIZp2FB1ype8yAXhh/Dq11R6VcCQzvW9XW4csf3lUJcWT6YAR+FCT1+ovcUtGZFYEJBAqH2OQ2Unm1JsTTkkYvalunSELximemcDh1Bpj3da/g3Li3Hi8xvS/STLXGTleW3heU+kEbBAGJ4wwbX/GGVhJgTk/60VXakArbh4vt2pk7pt4JYtPUPFIb/UTdeUMFGp2g6qclSlwPVM
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(336012)(426003)(2616005)(47076005)(83380400001)(186003)(2906002)(16526019)(36860700001)(4326008)(70586007)(70206006)(41300700001)(316002)(6666004)(110136005)(54906003)(478600001)(7416002)(5660300002)(44832011)(26005)(966005)(8676002)(8936002)(82310400005)(82740400003)(81166007)(86362001)(356005)(36756003)(40480700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 14:59:57.4697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ba4e78-3bf5-402c-7b7b-08db5ad53589
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8980
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the series is syncing the latest dt changes based on board status and the
latest DT schema.
The patches are based on
https://lore.kernel.org/all/20230321070619.29440-1-parth.gajjar@amd.com/

I have applied patches which were reviewed already to have smaller series.
Patches can be found https://github.com/Xilinx/linux-xlnx/tree/zynqmp/dt
Or they are in Linux-next already.

v1 is at
https://lore.kernel.org/r/7d034b9e-e4e6-5d72-8b37-78e25918aa59@amd.com.

Thanks,
Michal

Changes in v2:
- fix typo in commit message
- Update commit message to skip spi-nor part - reported by Laurent
- Update commit message to remove Linux part - reported by Laurent
- Update commit message to remove OS content - reported by Laurent

Amit Kumar Mahapatra (1):
  arm64: zynqmp: Set qspi tx-buswidth to 4

Ashok Reddy Soma (1):
  arm64: zynqmp: Fix usb node drive strength and slew rate

Michal Simek (2):
  arm64: zynqmp: Describe TI phy as ethernet-phy-id
  arm64: zynqmp: Used fixed-partitions for QSPI in k26

Radhey Shyam Pandey (2):
  arm64: zynqmp: Add L2 cache nodes
  arm64: zynqmp: Add pmu interrupt-affinity

 .../boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso |   8 +-
 .../boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso |   8 +-
 .../boot/dts/xilinx/zynqmp-sm-k26-revA.dts    | 171 +++++++++---------
 .../boot/dts/xilinx/zynqmp-zc1232-revA.dts    |   2 +-
 .../boot/dts/xilinx/zynqmp-zc1254-revA.dts    |   2 +-
 .../dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    |  10 +-
 .../dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    |   8 +-
 .../dts/xilinx/zynqmp-zc1751-xm018-dc4.dts    |   2 +-
 .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    |  13 +-
 .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    |  30 ++-
 .../boot/dts/xilinx/zynqmp-zcu102-revB.dts    |  25 ++-
 .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    |  30 ++-
 .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    |  30 ++-
 .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    |  29 ++-
 .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    |  29 ++-
 .../boot/dts/xilinx/zynqmp-zcu1275-revA.dts   |   2 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |  13 ++
 17 files changed, 256 insertions(+), 156 deletions(-)

-- 
2.36.1

