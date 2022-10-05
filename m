Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73265F5AEE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 22:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiJEUXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 16:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiJEUXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 16:23:46 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259DE61709;
        Wed,  5 Oct 2022 13:23:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBj1G9vwYp6IMg6jnPlNOUm/j+0K0l7Ku/Tg+WArUIBYLzbaXRNSC1nCJiffDGaZDVs6uIbO4c4m2lhSxWHJCqGvA8CzsY7Pf2rmUhOYwu515edic+cgVhK0HsRw37Vjjm+/nSyHEoQQikWrOOZSgijicSGDvVt4ZbDDb9GySyEHjUbVv5Tv9Xyjvw+YcWI9uoTEiZMqd3s2BlDXk97hgTjnkUOROxMhQbnTwccQitnZ//v3LFZ03DO6SZKN32HptpjIw3QK4Bd2RBd9COJMTq+ZS47BnQ3iZT6gpU6zK7ZmVJYggXT3LodFyUxEPBXhfHrkyU6kALgOYlC0ZF/Sgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNlXJQTiC88iA6JQ/ZrojUCcASFAUhYk7wrQHnkozYI=;
 b=JRup2RPGEGzCtHuJjKIs0u6g0Ver1ZZ4Pp2Sen/U2QMWMsJ9O076w/43LfAwv3nuN002GGCrL5Q/UdKankYnApvgQL6f8vbVb5wn0YkV6/uxPcbUKV8eAE9TF+UO9qa5odOo4cOFe9egIrlVWpXWmPd8SbkoN/Jmm16ORB3KpZPtQC63GtnPZMh1nDZHTDVutqgwgIWB9dvB+n5HX2/Il0ACLHtN/O/J6TegJzTcp3R4GuzLuRqsZ3iPnWyMXN3WD/Sj2d0NQHps3O8Vofs4E166nXMXltpR1jR2OUQkxQO/6t2N7I8Coo9MVT3I/pNgsDE/uRwk1wqS0vm6TK1L6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNlXJQTiC88iA6JQ/ZrojUCcASFAUhYk7wrQHnkozYI=;
 b=bOntdBQORBC5FmgDJoKffu5V/X+Ble36UVqChQJ8L+pvMA936Qcg8XxF4snuzqEIm8MEgag1ExWx2Y7uOtrosHYVIe5BVf7+nrMnQIReIrTLOA3GyGx22ATy/Aa9G8rLk6Y3CWugKZ01CptIjiqq5IGHTJ/51Oeh2QkCGORBdlw=
Received: from DM6PR03CA0043.namprd03.prod.outlook.com (2603:10b6:5:100::20)
 by CY5PR12MB6226.namprd12.prod.outlook.com (2603:10b6:930:22::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Wed, 5 Oct
 2022 20:23:41 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::78) by DM6PR03CA0043.outlook.office365.com
 (2603:10b6:5:100::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Wed, 5 Oct 2022 20:23:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 20:23:41 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 5 Oct
 2022 15:23:40 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mathias.nyman@intel.com>, <mika.westerberg@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
CC:     <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>
Subject: [PATCH 1/4] USB: ACPI: Look for `usb4-host-interface` property
Date:   Wed, 5 Oct 2022 15:23:49 -0500
Message-ID: <20221005202353.1269-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221005202353.1269-1-mario.limonciello@amd.com>
References: <20221005202353.1269-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT009:EE_|CY5PR12MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: f2339cb3-6227-4f5e-2d45-08daa70f7eb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IUTKnnBjEE4zDm4bb76aWxbSUpuIPKBqWmL/ixk+uVGiDk83JdGE/jHzZb9ksJKBoZgxXTxhzbQDCbfuxdYl07BBibCITBjFODVHtxJu8nMxMstMTYBkhxyvXDtMUcVIpgVGuDf6Jl83dH6YoUvEh2Qxggznng3v5Qu8j/5iaw5KNhDdbHI1Vc1OxNq7Y2q9vlH1bF4MZj2sCg2gafyNAK3hpOdZDsyAzigPZACQGK/uP94K7DNz66gA1UMo0TY1JWhnYwuSOQxIK6eP15kJPV+mTSIWO2XG15AMwgZJeIoAqBN5AXGONizvJMzbkAQlzeiJyoLzO9Z5Sxb1VuyHlEc8BXi0yMZqAiePY5fvNfsJUUn5yCX7ijx6+rE/kqxImNn6TK9dYbb7yWLY8qsKsfyABK4pVq92Rawi9LhSKMoTRb3B+IrPyp+aVscZOWoeoIx+4Atmyk57InyDewmnfrEDF56FmRqfaHKfPCVRuzSqxeLe3RZTaqBKX73ZeVUxtNKLKLRLqocJPt9RSSeGlwf7DJ7gMIGD9236XlUA2v7nRa9kxjjCeytV3455H22kTpYFDdZr7lvXJpZnrWleIAgUduTHr8RebpsFSvuh+qXT5Rp4lSNdqYMzKGSvsZG30Ic/jQduvfCinIn7cD5M7XXbwu9ijU1Tqwa7n42cTsAd9W8uzCTGIDSF9aEn3IZF2Ulh/ife4yboG7iZpC7Epth2WzRpGAv6nRyc9xGiBMlIlw0ExG9iZih7T8D04uif91rf2Miq1b5p9ptyEH4oN6x/uxgs7HuUmCiHRlsye/fFtnnAsOS2bpafuKNVWqFt1XDFruINgv7H5hubFOWNifq7yc/AcMHFLKTqg32gGMmH9wPV2O9O6sUwQgmQWxoL
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199015)(46966006)(36840700001)(40470700004)(36756003)(70206006)(8676002)(70586007)(4326008)(41300700001)(44832011)(1076003)(186003)(66574015)(2616005)(16526019)(2906002)(336012)(8936002)(40460700003)(47076005)(426003)(83380400001)(36860700001)(7696005)(40480700001)(26005)(86362001)(5660300002)(82310400005)(356005)(54906003)(110136005)(82740400003)(316002)(966005)(81166007)(478600001)(81973001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 20:23:41.7534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2339cb3-6227-4f5e-2d45-08daa70f7eb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6226
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For optimal power consumption of USB4 routers the XHCI PCIe endpoint
used for tunneling must be in D3.  Historically this is accomplished
by a long list of PCIe IDs that correspond to these endpoints.

The linux thunderbolt CM currently uses the `usb4-host-interface` ACPI
property to create a device link between the USB4 host router PCIe
endpoint and the XHCI PCIe endpoint.  The device link will move
the devices in out of D3 together.

To avoid having to maintain this never ending list of PCIe IDs, use
the existence of `usb4-host-interface` property on a USB port as a
proxy to allow runtime PM for these controllers.  The device links
will continue to be created when the CM initializes the USB4
host router and also discovers this property.

Link: https://learn.microsoft.com/en-us/windows-hardware/design/component-guidelines/usb4-acpi-requirements#port-mapping-_dsd-for-usb-3x-and-pcie
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
RFC v1->PATCH v1
 * Move this detection from Thunderbolt CM into USB core
---
 drivers/usb/core/usb-acpi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index 6d93428432f13..f91ab4fd84cf8 100644
--- a/drivers/usb/core/usb-acpi.c
+++ b/drivers/usb/core/usb-acpi.c
@@ -177,6 +177,15 @@ usb_acpi_find_companion_for_port(struct usb_port *port_dev)
 		port_dev->connect_type = usb_acpi_get_connect_type(handle, pld);
 		ACPI_FREE(pld);
 	}
+	if (!acpi_dev_get_property(adev, "usb4-host-interface",
+				   ACPI_TYPE_ANY, NULL)) {
+		struct device *dev = &port_dev->dev;
+
+		while (dev && !dev_is_pci(dev))
+			dev = dev->parent;
+		if (dev)
+			pm_runtime_allow(dev);
+	}
 
 	return adev;
 }
-- 
2.34.1

