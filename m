Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6F37254CB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238213AbjFGGxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjFGGxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:53:00 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A71B1723;
        Tue,  6 Jun 2023 23:52:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQco7Mv5DhOXcbcUH7zBneYsbFB7DPCij7pKfUxmmgVxmHNEeCWYYgVNBzjK3z5AXMq/dA305a4ppW79NAf7WTsE4RyONMczWhkIdV6zDbY/Au7gIM4UqurwdidLO24I423D6cwyMFDoMTdWZGiXYG7zuTp25lb8VF3QNuYRR8NChIfRN4IQ+GGQqoJKWoarpftlXGaOzzuhXBnFMQ9i5QwJLNrzfHbqi+jREQ8xeqpfXBIbB8kz/gvsdVUUwn7Ewb8qMK8v/Q6CMqmK+wb//f1LVvxdx6qBF7rSsoeNcGuzkF2Xy2LD7mEJ8xZAvdx0Q+/+Dx8C/hQKp5ZsEs2HYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RveyQlVBhpqCawzoQeElPlMfAWwDjb+YP2EW3luhzg=;
 b=mDaQQyaJvj/2tuxp5Yy9EpIBHLRiZdY7al1R2dxGq4CiZ2HP0vAIBMSAo37daLv7Gtne82WsoyYt+rhABB6zWL9M04+apd15MBF5ITHKXRcCzyiKWgUWrAYMDCfRJjd4wu743cUUHv4ZTaPcEqXJ2pSFOYFmDZE8SAPtrjNIppxWS7fAVCs2VPkzyj4xsyivuIRQv+xBZHb5yZRksV0JpHKbZFQiOWb9Unr+d6XbZDPYJq+eYL0O12h7GKZWB2MpkikSV/GGD2lniR/ixPA5+MdTux+ycXd1c6K/bxGtfVx+9j85yXhTmJ556IzAENwcHxBvIjC3yn82JlhIC+5Awg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RveyQlVBhpqCawzoQeElPlMfAWwDjb+YP2EW3luhzg=;
 b=etr+VjxbJ10BjmtBNeyldYygbmPm/uZjnyN4OVSrobVmsZaQSZ7vIgYDYU1ygLwhSePHuvZ/MN3sKVhtgnzoTsNg3PbTtZPWvMhTa+hFIR6Hn7cS6P5Yw4WU6sa0LybPW8LngIFKxN/lsRhz1wYYyCCNTqGax4ddYdgBuVZtWhs=
Received: from BN9P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::7)
 by DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 06:52:56 +0000
Received: from BN8NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::cd) by BN9P220CA0002.outlook.office365.com
 (2603:10b6:408:13e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 06:52:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT104.mail.protection.outlook.com (10.13.177.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Wed, 7 Jun 2023 06:52:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 01:52:55 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 01:52:55 -0500
Received: from xhdnavam40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 7 Jun 2023 01:52:51 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <michal.simek@xilinx.com>,
        <nava.manne@xilinx.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <siva.durga.prasad.paladugu@amd.com>, <git@amd.com>,
        Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH 0/2] dt-bindings: reset: convert the xlnx,zynqmp-reset.txt to yaml 
Date:   Wed, 7 Jun 2023 12:21:19 +0530
Message-ID: <20230607065121.2265076-1-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT104:EE_|DM6PR12MB4219:EE_
X-MS-Office365-Filtering-Correlation-Id: ed66535c-f40f-4804-58f3-08db6723d2bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 630j+y+iw+PIZJU1OEcY1vt2tItxnC3iZ8fJ2aLDYa5N4KrNlbAFaH1tP9PhtVAeCmHR+GGQ7AH/2gxyJhxI+mRb6B4u1bRaacw83BbTIFJYSnAmXHe8f+B1BDr9m9P7nPRObRCnoy9KjY0MIXXyCej1xMv4qAQ6Gpvymkxn279/FHX2S2qlUfyPWQWff84r3FCL6czUgoZHYDg54FI8idvjV/EfFBvTGUry5vpfepF52912SVL1w3YHp99nga1pbKTc0hyGx4adkKQ/v8J9tXhRMiIXvZbGAeCRxSABdYWXCuf5MKaDBnibZP4Qn98d39u9fEg7oyghbLgJmCsnBjb/iOPZOWZqZqsowPbgekHvCCcsl/kEGmhPYrKV+7xWHUeTO3yvXoHkI3gp1nj4o8TVW+CG1NMcwzPDChZpProCH8EPjrsgxfd6WKkwaGLeVo+juE+abTGyh2pZpashlMWIzwuQ4qoPB9BOU1sXxZeKvZS+LoOVE8IjAFkoCriNrPAUvrbh4pa6WoA+PFqDRY5NboVy6z1WAEDRrgXh1hOcgPXDEHGsBA2fQQU/EZHXkOg3EsMTMSzzUozCaiAMD/RPC8g42xx78PARqb4+AcJsLn5nxz6Esoye+Yew/cgTZMG0yvMATQJtEjt9VamCBBiY18fDKennDhzIKNEHvdZO8xn90/Z3fVVebpncX2sg3pyXaZyOvE9SkkUsnbLkHZK84U11fTNwSLIyD25jF6Pn9mwrZmN0zZLN69+3LT3p/9o9lUDI+yE1UhXuWeG9oZ1SUy6p/G20lLG5IYt/wfw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(8676002)(4326008)(70586007)(8936002)(70206006)(316002)(5660300002)(41300700001)(54906003)(110136005)(40480700001)(44832011)(2906002)(478600001)(40460700003)(356005)(81166007)(26005)(4743002)(86362001)(1076003)(186003)(36756003)(82740400003)(36860700001)(2616005)(82310400005)(47076005)(336012)(83380400001)(426003)(6666004)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 06:52:55.9729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed66535c-f40f-4804-58f3-08db6723d2bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
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

This series of patch convert txt file (xlnx,zynqmp-reset.txt) to yaml
(xlnx,zynqmp-reset.yaml) DT schema format and adding reset-controller
property to the firmware dt-binding.

---
Note:
The 1/2 patch introduced a warning related to the dt binding check,
which was subsequently fixed in the 2/2 patch. This warning is a
conversion warning due to a dependency on firmware dt binding.

Warning:
  DTC_CHK Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.example.dtb
/scratch/piyushm/torvalds/linux/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.example.dtb: zynqmp-firmware: 'reset-controller' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /scratch/piyushm/torvalds/linux/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml

Please suggest to me, if it's fine to make a single patch instead
of the separate patch 1/2 and 2/2.
---
Piyush Mehta (2):
  dt-bindings: reset: convert the xlnx,zynqmp-reset.txt to yaml
  dt-bindings: firmware: add reset-controller property

 .../firmware/xilinx/xlnx,zynqmp-firmware.yaml | 11 +++
 .../bindings/reset/xlnx,zynqmp-reset.txt      | 55 ---------------
 .../bindings/reset/xlnx,zynqmp-reset.yaml     | 67 +++++++++++++++++++
 3 files changed, 78 insertions(+), 55 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml

-- 
2.25.1

